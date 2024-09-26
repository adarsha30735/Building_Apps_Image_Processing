clc
clear all
close all
Image=rgb2gray((imread("girl.png")));
sigma=input("Enter the value of σ ");
K=input("Enter the value of K ");
m=3;
LOG=zeros(3,3);



x=0;
y=1;
        
       for X=-m:m
          x=x+1; 
          
          for Y=-m:m
                  R=sqrt(X^2+Y^2);
                  LOG(x,y)= K * ((R^2-(2*sigma^2))/sigma^4)* exp(-(R^2)/(2*sigma^2));
                  x=x+1;
          end
          x=0;
          y=y+1;
       end
       %(1/pi*(sigma^4))
LOG1 = fspecial('log',[2*m+1,2*m+1],sigma);

       
% filteredImage = conv2( LOG,double(Image));  %f'(x,y)
filteredImage = conv2((Image), LOG);  %f'(x,y)


E=zeros(size(Image));
[M ,N]= size(Image);

for t=1:M
    for r=1:N
        
        if filteredImage(t,r)==0 || filteredImage(t,r)<0.1
            
            %four edges zero
           if (t==r)==1
               E(t,r)=0;
           end    
           if t==1 && r==N
                 E(t,r)=0;
           end    
           if t==M && r==1
                 E(t,r)=0;
           end    
          
           if t==M && r==N
                E(t,r)=0; 
           end
               
               %first row without 1st and last terms
             
           if t==1 && (r>1 && r<N)
               a1= filteredImage(t,r-1)*filteredImage(t,r+1);
                 if a1<0
                       E(t,r)=1;
                      
                 end
           end
                      
           %first column without 1st and last element          
           if (t>1 && t<M)  && (r==1)    
                a2= filteredImage(t-1,r)*filteredImage(t+1,r);
                 if a2<0
                       E(t,r)=1;
                 end    
           end 
            %last row without 1st and last terms
             
           if t==M && (r>1 && r<N)
               a3= filteredImage(t,r-1)*filteredImage(t,r+1);
                 if a3<0
                       E(t,r)=1;
                 end     
           end
           %last column without 1st and last element          
           if (t>1 && t<M)  && (r==N)    
                a4= filteredImage(t-1,r)*filteredImage(t+1,r);
                 if a4<0
                       E(t,r)=1;
                 end     
           end          
           if (t>1 && t<M)  && (r>1 && r<N)   
               b1=filteredImage(t-1,r)*filteredImage(t+1,r);%up bottom
               b2=filteredImage(t,r-1)*filteredImage(t,r+1);% left right
               b3=filteredImage(t-1,r-1)*filteredImage(t+1,r+1);%upper left/ bottom right
               b4=filteredImage(t-1,r+1)*filteredImage(t+1,r-1);%upper right/ bottom left
               
               if b1<0 || b2<0 ||b3<0 ||b4<0 
                 
                    E(t,r)=1;
       
                    
               end    
           end

        end

    end
end  


imshow(E)