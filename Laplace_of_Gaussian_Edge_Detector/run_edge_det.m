function [] = run_edge_det()

%function to run the filter
%usage: find_edges (img,hsize,sigma)
% OR find_edges(img) == %default find_edges(img,[5,5],0.3)
img = imread('tree.jpg');

hsize = [7 7]; %only runs for odd integer step_size
sigma = 0.3;
%img = rgb2gray(img);
find_edges(img,hsize,sigma) 

end