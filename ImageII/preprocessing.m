laplacian=[0 1 0;1 -4 1; 0 1 0];

for file_no=[12 36 37 38]
    filename='Data/glass'+string(file_no)+".hdf5";
     h5disp(filename)
    cells=h5read(filename,'/data');
    counts= size(cells);
    count = counts(4);
    processed_cells= zeros(80,80,1,count*8);
    processed_no=1;
    for cell_no=1:count
      cell = cells(:,:,1,cell_no);
      %figure,imshow(cell);
      processed_cells(:,:,1,processed_no)=cell;
      mirror_horizontal = flip(cell ,2); 
      processed_no=processed_no+1;
      processed_cells(:,:,1,processed_no)=mirror_horizontal;
      %hor_rotate= imrotate(mirror_horizontal,90);
      %processed_no=processed_no+1;
      %processed_cells(:,:,1,processed_no)=hor_rotate;
      mirror_vertical = flip(cell ,1);
      processed_no=processed_no+1;
      processed_cells(:,:,1,processed_no)=mirror_vertical;
%       ver_rotate= imrotate(mirror_vertical,90);
%       processed_no=processed_no+1;
%       processed_cells(:,:,1,processed_no)=ver_rotate;
      mirror_hor_ver = flip(mirror_vertical,2);
      processed_no=processed_no+1;
      processed_cells(:,:,1,processed_no)=mirror_hor_ver;
%       ver_hor_rotate= imrotate(mirror_hor_ver,90);
%       processed_no=processed_no+1;
%       processed_cells(:,:,1,processed_no)=ver_hor_rotate;
    end
    new_filename='Data/glassmir'+string(file_no)+".hdf5";
    if isfile(new_filename)
       delete(new_filename); 
    end
    h5create(new_filename,'/data',size(processed_cells),'Datatype','uint8');
    h5disp(new_filename)
    h5write(new_filename,'/data',processed_cells);
end