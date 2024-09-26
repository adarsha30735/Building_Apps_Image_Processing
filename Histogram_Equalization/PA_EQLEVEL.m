clear all  clc

I=imread('tree.jpg');
Igray=rgb2gray(I);
f_grey_levels= max(Igray,[],'all');

for i=1:256
    hist(i)=0;
end
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

for t=1:256
    eq_hist(t)=0;
end      
a=10;
b=20;
c=25;
d=30;

g_grey_levels=255;
sigma_hists=zeros(1,256);
sigma_hists(a+1)=hist(a+1);
q=zeros(1,256);
for i=a+2:b+1
    sigma_hists(i) = sigma_hists(i-1) + hist(i);
    

end

q(a+1)= (round(((d-c)/sigma_hists(b+1))*sigma_hists(a+1)+c))+1;
eq_hist(q(a+1)) = hist(a+1); 


for p=a+2:b+1
    q(p)= (round(((d-c)/sigma_hists(b+1))*sigma_hists(p)+c))+1;
    eq_hist(q(p))=eq_hist(q(p))+hist(p);
end




for x=1:M
    for y=1:N
        if (a<=Igray(x,y)) && (Igray(x,y)>=b)
            Igray_eqlevel(x,y)=q(Igray(x,y));
        else
            Igray_eqlevel(x,y)=Igray(x,y);
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
stem(e_hist);

