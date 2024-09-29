# Image Processing in MATLAB

This repository contains various MATLAB scripts for image processing, including thresholding, histogram equalization, and edge detection using the Laplace of Gaussian (LoG) filter.

## Table of Contents
- [Thresholding](#thresholding)
- [Histogram Equalization](#histogram-equalization)
- [Laplace of Gaussian (LoG) Edge Detection](#laplace-of-gaussian-log-edge-detection)

### Thresholding

This script reads an image and applies thresholding to convert the grayscale image into a binary image.

#### Code:

```matlab
clear all, clc

I = imread('NDVI_GIMP.png');  % Read the image
Igray = rgb2gray(I);          % Convert the image to grayscale
[row, col] = size(Igray);     % Get the dimensions of the grayscale image
t = 150;                      % Define the threshold

% Apply thresholding
for i = 1:row
    for j = 1:col
        if Igray(i, j) > t
            new(i, j) = 1;
        else
            new(i, j) = 0;
        end
    end
end

figure, imshow(new);  % Display the thresholded image

### Histogram Equalization
This script performs histogram equalization on a grayscale image to enhance contrast.

clear all, clc

I = imread('tree.jpg');       % Read the image
Igray = rgb2gray(I);          % Convert the image to grayscale

% Initialize the histogram array
for i = 1:256
    hist(i) = 0;
end

[M, N] = size(Igray);  % Get the image dimensions

% Compute the histogram
for x = 1:M
    for y = 1:N
        for k = 1:256
            if Igray(x, y) == k
                hist(k) = hist(k) + 1;
            end
        end
    end
end

% Initialize the equalized histogram
for t = 1:256
    eq_hist(t) = 0;
end

% Define specific ranges
a = 10; b = 20; c = 25; d = 30;

sigma_hists = zeros(1, 256);
sigma_hists(a + 1) = hist(a + 1);
q = zeros(1, 256);

% Compute cumulative sums for the histogram
for i = a + 2:b + 1
    sigma_hists(i) = sigma_hists(i - 1) + hist(i);
end

q(a + 1) = round(((d - c) / sigma_hists(b + 1)) * sigma_hists(a + 1) + c) + 1;
eq_hist(q(a + 1)) = hist(a + 1);

% Compute equalized histogram
for p = a + 2:b + 1
    q(p) = round(((d - c) / sigma_hists(b + 1)) * sigma_hists(p) + c) + 1;
    eq_hist(q(p)) = eq_hist(q(p)) + hist(p);
end

% Apply histogram equalization
for x = 1:M
    for y = 1:N
        if (a <= Igray(x, y)) && (Igray(x, y) >= b)
            Igray_eqlevel(x, y) = q(Igray(x, y));
        else
            Igray_eqlevel(x, y) = Igray(x, y);
        end
    end
end

% Display results
subplot(2, 2, 1); imshow(uint8(Igray));                % Original image
subplot(2, 2, 3); imshow(uint8(Igray_eqlevel));        % Equalized image
subplot(2, 2, 2); stem(hist);                          % Original histogram
subplot(2, 2, 4); stem(eq_hist);                       % Equalized histogram


### Laplace of Gaussian (LoG) Edge Detection

This script performs edge detection using the Laplacian of Gaussian (LoG) filter. The LoG combines Gaussian smoothing and the Laplacian operator to detect edges based on rapid intensity changes.

clc;
clear all;
close all;

% Read and convert the image to grayscale
Image = rgb2gray(imread("girl.png"));

% User input for Gaussian parameters
sigma = input("Enter the value of σ: ");
K = input("Enter the value of K: ");
m = 3;

% Initialize the Laplacian of Gaussian (LoG) filter
LOG = zeros(3, 3);
x = 0;
y = 1;

% Create the LoG filter based on user input
for X = -m:m
    x = x + 1;
    for Y = -m:m
        R = sqrt(X^2 + Y^2);
        LOG(x, y) = K * ((R^2 - (2 * sigma^2)) / sigma^4) * exp(-(R^2) / (2 * sigma^2));
        x = x + 1;
    end
    x = 0;
    y = y + 1;
end

% Create an alternative filter for comparison
LOG1 = fspecial('log', [2*m+1, 2*m+1], sigma);

% Apply the filter to the image
filteredImage = conv2(Image, LOG);

% Initialize edge matrix E
E = zeros(size(Image));
[M, N] = size(Image);

% Perform edge detection by analyzing the zero-crossings in the filtered image
for t = 1:M
    for r = 1:N
        if filteredImage(t, r) == 0 || filteredImage(t, r) < 0.1
            
            % Handle edges of the image (corners)
            if (t == r) == 1 || (t == 1 && r == N) || (t == M && r == 1) || (t == M && r == N)
                E(t, r) = 0;
            else
                % First row (except first and last elements)
                if t == 1 && (r > 1 && r < N)
                    a1 = filteredImage(t, r-1) * filteredImage(t, r+1);
                    if a1 < 0
                        E(t, r) = 1;
                    end
                end
                % First column (except first and last elements)
                if (t > 1 && t < M) && (r == 1)
                    a2 = filteredImage(t-1, r) * filteredImage(t+1, r);
                    if a2 < 0
                        E(t, r) = 1;
                    end
                end
                % Last row (except first and last elements)
                if t == M && (r > 1 && r < N)
                    a3 = filteredImage(t, r-1) * filteredImage(t, r+1);
                    if a3 < 0
                        E(t, r) = 1;
                    end
                end
                % Last column (except first and last elements)
                if (t > 1 && t < M) && (r == N)
                    a4 = filteredImage(t-1, r) * filteredImage(t+1, r);
                    if a4 < 0
                        E(t, r) = 1;
                    end
                end
                % General case (middle of the image)
                if (t > 1 && t < M) && (r > 1 && r < N)
                    b1 = filteredImage(t-1, r) * filteredImage(t+1, r);  % up and down
                    b2 = filteredImage(t, r-1) * filteredImage(t, r+1);  % left and right
                    b3 = filteredImage(t-1, r-1) * filteredImage(t+1, r+1);  % diagonal
                    b4 = filteredImage(t-1, r+1) * filteredImage(t+1, r-1);  % diagonal
                    if b1 < 0 || b2 < 0 || b3 < 0 || b4 < 0
                        E(t, r) = 1;
                    end
                end
            end
        end
    end
end

% Display the edge-detected image
imshow(E);
