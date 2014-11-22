function img_out = segmentSkinColors(img_in, skinHisto)


img_out = zeros(size(img_in));

%Normalize skinHisto
max_val = max(max(skinHisto));

for i = 1:size(skinHisto,1)
    for j = 1:size(skinHisto,2)
        
        skinHisto(i,j) = mod(skinHisto(i,j),max_val);
        
    end
end

%Iterate through image
hsv = rgb2hsv(img_in);
h = hsv(:,:,1);
s = hsv(:,:,2);

for i = 1:size(hsv, 1)
    for j = 1:size(hsv, 2)
        
        hue = floor(h(i,j) * 100);
        sat = floor(s(i,j) * 100);
        
        if(hue == 0)
            hue = 1;
        end
        
        if(sat == 0)
            sat = 1;
        end
        
        if(skinHisto(hue,sat) > 50)
            img_out(i,j,:) = img_in(i,j,:);
        else
            img_out(i,j,:) = [255 255 255];
        end
        
    end
end

img_out = img_out/255;
image(img_out);

end