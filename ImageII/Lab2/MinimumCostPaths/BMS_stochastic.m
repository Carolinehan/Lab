function dt = BMS_stochastic( image , number_of_iterations)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

dt=double(image);
dt(:)=0;

for i=1:number_of_iterations
    t=256*rand();
    thresholded=image>t;
    
    %Find foreground regions isolated from the border
    fg=imfill(thresholded, 'holes');
    fg=(fg~=thresholded);
 
    %Find background regions isolated from the border
    bg=imfill(~thresholded, 'holes');
    bg=(bg~=(~thresholded));
    
    dt=dt+double(fg|bg);
    
end

dt=dt/number_of_iterations;




end

