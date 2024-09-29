# Image Processing in MATLAB

This repository contains various MATLAB scripts for image processing, including thresholding, histogram equalization, and edge detection using the Laplace of Gaussian (LoG) filter.

## Table of Contents
- [Introduction](#introduction)
- [Script Code](#script-code)
  - [Thresholding](#thresholding)
  - [Histogram Equalization](#histogram-equalization)
  - [Laplace of Gaussian (LoG) Edge Detection](#laplace-of-gaussian-log-edge-detection)
- [Usage](#usage)

## Introduction
This MATLAB script provides basic image processing functionalities such as thresholding, histogram equalization for contrast enhancement, and edge detection using the Laplacian of Gaussian (LoG) filter. The script handles grayscale images and demonstrates various image manipulation techniques.

## Script Code

### Thresholding

The script applies a threshold to convert a grayscale image into a binary image. 

### Histogram Equalization

The script performs histogram equalization on a grayscale image to enhance contrast by redistributing intensity values.

### Laplace of Gaussian (LoG) Edge Detection

The script uses the Laplace of Gaussian filter to detect edges based on intensity changes.

#### Full Code:

```matlab
clear all, clc

% Thresholding Section
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

% Histogram Equalization Section
Igray_eq = Igray;                % Grayscale image for equalization

% Initialize histogram
for i = 1:256
    hist(i) = 0;
end

[M, N] = size(Igray_eq);  % Get image dimensions

% Compute the histogram
for x = 1:M
    for y = 1:N
        for k = 1:256
            if Igray_eq(x, y) == k
                hist(k) = hist(k) + 1;
            end
        end
    end
end

% Initialize equalized histogram
for t = 1:256
    eq_hist(t) = 0;
end

% Specify ranges for histogram equalization
a = 10; b = 20; c = 25; d = 30;

sigma_hists = zeros(1, 256);
sigma_hists(a + 1) = hist(a + 1);
q = zeros(1, 256);

% Compute cumulative sum for histogram equalization
for i = a + 2:b + 1
    sigma_hists(i) = sigma_hists(i - 1) + hist(i);
end

q(a + 1) = round(((d - c) / sigma_hists(b + 1)) * sigma_hists(a + 1) + c) + 1;
eq_hist(q(a + 1)) = hist(a + 1);

for p = a + 2:b + 1
    q(p) = round(((d - c) / sigma_hists(b + 1)) * sigma_hists(p) + c) + 1;
    eq_hist(q(p)) = eq_hist(q(p)) + hist(p);
end

% Apply histogram equalization
for x = 1:M
    for y = 1:N
        if (a <= Igray_eq(x, y)) && (Igray_eq(x, y) >= b)
            Igray_eqlevel(x, y) = q(Igray_eq(x, y));
        else
            Igray_eqlevel(x, y) = Igray_eq(x, y);
        end
    end
end

% Display original and equalized images with histograms
figure;
subplot(2, 2, 1); imshow(uint8(Igray_eq));                % Original image
subplot(2, 2, 3); imshow(uint8(Igray_eqlevel));           % Equalized image
subplot(2, 2, 2); stem(hist);                             % Original histogram
subplot(2, 2, 4); stem(eq_hist);                          % Equalized histogram

% Laplace of Gaussian (LoG) Edge Detection Section
Image = rgb2gray(imread("girl.png"));  % Read and convert image to grayscale

sigma = 1;  % Gaussian sigma value
K = 1;      % Laplace scaling factor
m = 3;      % Filter size (3x3)

LOG = zeros(3, 3);
x = 0;
y = 1;

% Create LoG filter
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

% Apply the LoG filter
filteredImage = conv2(Image, LOG);

% Initialize edge detection matrix E
E = zeros(size(Image));
[M, N] = size(Image);

% Detect edges based on zero-crossing
for t = 1:M
    for r = 1:N
        if filteredImage(t, r) == 0 || filteredImage(t, r) < 0.1
            
            % Handle image corners
            if (t == r) == 1 || (t == 1 && r == N) || (t == M && r == 1) || (t == M && r == N)
                E(t, r) = 0;
            else
                % Handle borders and general cases
                % (Details for zero-crossing checks omitted for brevity)
                E(t, r) = 1;
            end
        end
    end
end

% Display edge-detected image
figure, imshow(E);
