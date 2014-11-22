function skin_values_out = findSkinColors(img_in, skin_values_in)

I = imcrop(img_in);
hsv = rgb2hsv(I);
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
        
        skin_values_in(hue,sat) = skin_values_in(hue,sat) + 1;
        
    end
end

skin_values_out = skin_values_in;

end