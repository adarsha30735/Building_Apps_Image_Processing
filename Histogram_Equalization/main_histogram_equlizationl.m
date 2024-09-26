clear all , clc

I=imread('tree.jpg');
Igray=rgb2gray(I);
f_grey_levels= max(Igray,[],'all');

hist=zeros(1,256);
[M, N]=size(Igray);

for x=1:M
    for y=1:N
        for k= 1:256
            if Igray(x,y)==k
                hist(k)=hist(k)+1;
            end
        end
    end
end


a=input("Enter the value of a");
b=input("Enter the value of b");
c=input("Enter the value of c");
d=input("Enter the value of d");

g_grey_levels=255;
sigma_hists=zeros(1,256);
sigma_hists(a)=hist(a);
q=zeros(1,256);

for i=a+1:b
    sigma_hists(i) = sigma_hists(i-1) + hist(i);
    
end
eq_hist=zeros(1,256);
q(a)= (round(((d-c)/sigma_hists(b))*sigma_hists(a)+c));
eq_hist(q(a)) = hist(a); 

for p=a+1:b
    q(p)= (round(((d-c)/sigma_hists(b))*sigma_hists(p)+c));
    eq_hist(q(p))=eq_hist(q(p))+hist(p);
end



for x=1:M
    for y=1:N
        if (a<=Igray(x,y))&& (Igray(x,y)<=b)
            Igray_eqlevel(x,y)=q(Igray(x,y));
        else
            Igray_eqlevel(x,y)=Igray(x,y);
        end
    end
end
eq_hist=zeros(1,256);


for x=1:M
    for y=1:N
        for l= 1:256
            if Igray_eqlevel(x,y)==l
                eq_hist(l)=eq_hist(l)+1;
            end
        end
    end
end

subplot(2,2,1);
imshow(uint8(Igray));
subplot(2,2,3);
imshow(uint8(Igray_eqlevel));
subplot(2,2,2);
stem(hist);
subplot(2,2,4);
stem(eq_hist);
