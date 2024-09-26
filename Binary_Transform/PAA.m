clear all, clc

I = imread('NDVI_GIMP.png');
Igray=rgb2gray(I);
[row col]= size(Igray);
t=150;

for i=1:row
    
    for j=1:col
        
       if Igray(i,j)>t
          new(i,j)=1;
       else 
          new(i,j)=0;
            
       end
    end
end 
       
            

figure, imshow(new);
