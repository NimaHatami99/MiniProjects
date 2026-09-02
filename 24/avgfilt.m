function imgout=avgfilt(I)
[x,y,z] = size(I);
I2=zeros(x,y,z);
for k = 1:z
    for i = 2:x-1
        for j = 2:y-1
            sum = 0;
            sum=int32(sum);
            for ii = i-1:i+1  
                for jj = j-1:j+1
                    tmp=I(ii,jj,k);
                    tmp=int32(tmp);
                    sum = sum + tmp;
                    sum=int32(sum);
                end
            end
            I2(i,j,k) = ceil(sum/9);
        end
    end
end
imgout=uint8(I2);
end