function dt = BMS_Dijkstra( image, seeds, labels)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

im=double(image)/255;
dt_max=MaxDT(seeds, labels,image);
dt_min=255-MaxDT(seeds,labels, 255-image);
dt = (dt_max-dt_min)/255;


end

