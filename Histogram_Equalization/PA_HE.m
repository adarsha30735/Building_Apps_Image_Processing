clear all  clc

I=imread('dd.jpg');
Igray=rgb2gray(I);
f_grey_levels= max(Igray,[],'all');

for i=1:256;
    hist(i)=0;
end
[M N]=size(Igray);

for x=1:M;
    for y=1:N;
        for k= 1:256;
            if Igray(x,y)==k
                hist(k)=hist(k)+1;
            end
        end
    end
end

for t=1:256;
    eq_hist(t)=0;
end          
g_grey_levels=255;
sigma_hists=zeros(1,256);
sigma_hists(1)=hist(1);
q=zeros(1,256);


q(1)=round((g_grey_levels/(M*N))*sigma_hists(1))+1;
eq_hist(q(1))=hist(1);

for p=2:256;
    sigma_hists(p)=sigma_hists(p-1)+hist(p);
    q(p)=round((g_grey_levels/(M*N))*sigma_hists(p))+1;
    
    eq_hist(q(p))=eq_hist(q(p))+hist(p);
end

for x=1:M
    for y=1:N
        Igray_eq(x,y)= q(Igray(x,y));
    end
end

subplot(2,2,1);
imshow(uint8(Igray));
subplot(2,2,3);
imshow(uint8(Igray_eq));
subplot(2,2,2);
stem(hist);
subplot(2,2,4);
stem(eq_hist);

    

   