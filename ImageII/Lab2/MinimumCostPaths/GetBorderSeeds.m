function seeds = GetBorderSeeds( image)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

seeds=image;

%Set all pixels to 0
seeds(:)=0;

%Set pixels on the image boundary to 1
s=size(image);
seeds(1:s(1),1)=1;
seeds(1:s(1),s(2))=1;
seeds(1,1:s(2))=1;
seeds(s(1),1:s(2))=1;

end

