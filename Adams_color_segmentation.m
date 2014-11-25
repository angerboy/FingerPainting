function [img_out]=my_HS_SkinSegmentation(img_in,histo)
%% function [img_out]=my_HS_SkinSegmentation(img_in,histo)
%
% Description:
%       This function does basic color image segmention in HS space.
%
% Inputs:
%       img_in = A string containing the image name. The image must be in
%                the working directory or path. The extension should be
%                included.
%       histo = The histogram formed from training data.
%
% Outputs:
%       img_out = The segmented image.
%
% Uses:
%       [img_out]=my_HS_SkinSegmentation('The_Image_name.bmp',histo)
%
% Author: Adam Eshein (aeshein@u.northwestern.edu) - 10.27.2014
img_in=imread(img_in);
img=double(img_in);

%% Convert image to HS space
hs_img=zeros(size(img,1),size(img,2),2);
for ii=1:size(img,1);
    for jj=1:size(img,2);
        hs_img(ii,jj,2)=1-(1/(sum(img(ii,jj,:))))*min(img(ii,jj,:));
        h=acos((2*img(ii,jj,1)-img(ii,jj,2)-img(ii,jj,3))/(2*sqrt(((img(ii,jj,1)-img(ii,jj,2))^2)+(img(ii,jj,1)-img(ii,jj,3))*(img(ii,jj,2)-img(ii,jj,3)))));
        if img(ii,jj,3)<=img(ii,jj,2);
            hs_img(ii,jj,1)=h;
        else hs_img(ii,jj,1)=2*pi-h;
        end
    end
end
hs_img(isnan(hs_img))=0;

hs_img(:,:,1)=round(300*hs_img(:,:,1)/(2*pi)); %normalize the hue and multiply it by 300 and round;
hs_img(:,:,2)=round(300*hs_img(:,:,2)); % multipl the saturation by 300 and round it


%% Normalize HS histogram
hist_bins_norm=histo/max(max(histo));

%% Do the segmentation
segment=zeros(size(img,1),size(img,2));
for ii=1:size(hs_img,1)
    for jj=1:size(hs_img,2)
        if hist_bins_norm(hs_img(ii,jj,1)+1,hs_img(ii,jj,2)+1)>0;
            segment(ii,jj)=1;
        end
    end
end

segment=repmat(segment,[1 1 3]);
img_out=segment.*img;
