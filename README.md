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
