clear
clc
clf
img = imread('photo1.jpg');
imshow(img)
title('original image')
smoothed_img=avgfilt(img);
figure()
imshow(smoothed_img)
title('smoothed image');
figure()
edge_img_mat=edgefilt(img);
imshow(edge_img_mat)
title('edge of original image');
dim=size(img);
R=reshape((img(:,:,1))',dim(1)*dim(2),1);
G=reshape((img(:,:,2))',dim(1)*dim(2),1);
B=reshape((img(:,:,3))',dim(1)*dim(2),1);
dlmwrite('R_input_vector.txt',R)
dlmwrite('G_input_vector.txt',G)
dlmwrite('B_input_vector.txt',B)
figure()
R_avg=[dlmread('R_output_vector_avgfilt.txt');0];
G_avg=[dlmread('G_output_vector_avgfilt.txt');0];
B_avg=[dlmread('B_output_vector_avgfilt.txt');0];
R_edge=[dlmread('R_output_vector_edgefilt.txt');0];
G_edge=[dlmread('G_output_vector_edgefilt.txt');0];
B_edge=[dlmread('B_output_vector_edgefilt.txt');0];
R_avg=(reshape(R_avg,603,317))';%----------------------- image size is (319,605,3)
G_avg=(reshape(G_avg,603,317))';
B_avg=(reshape(B_avg,603,317))';
R_edge=(reshape(R_edge,603,317))';
G_edge=(reshape(G_edge,603,317))';
B_edge=(reshape(B_edge,603,317))';
avg_img=zeros(317,603,3);
edge_img=zeros(317,603,3);
avg_img(:,:,1)=R_avg;
avg_img(:,:,2)=G_avg;
avg_img(:,:,3)=B_avg;
edge_img(:,:,1)=R_edge;
edge_img(:,:,2)=G_edge;
edge_img(:,:,3)=B_edge;
avg_img=uint8(avg_img);
edge_img=uint8(edge_img);
imshow(avg_img)
title('smoothed image - processed by FPGA');
figure()
imshow(edge_img)
title('edge of original image - processed by FPGA')
if isequal(edge_img(:,:,:),edge_img_mat(2:dim(1)-1,2:dim(2)-1,:))
    disp("The edge image calculated by matlab is equal to FPGA's output.");
else
    diff=sum(sum(sum(abs(double(edge_img(:,:,:))-double(edge_img_mat(2:dim(1)-1,2:dim(2)-1,:))))))/(dim(1)*dim(2));
    disp("The difference between edge image calculated by matlab and FPFA's output on average is "+diff+" (full range is 0 to 255) per each pixel.");
end
if isequal(avg_img(:,:,:),smoothed_img(2:dim(1)-1,2:dim(2)-1,:))
    disp("The smoothed image calculated by matlab is equal to FPGA's output.");
else
    diff=sum(sum(sum(abs(double(avg_img(:,:,:))-double(smoothed_img(2:dim(1)-1,2:dim(2)-1,:))))))/(dim(1)*dim(2));
    disp("The difference between smoothed image calculated by matlab and FPFA's output on average is "+diff+" (full range is 0 to 255) per each pixel.");
end