im=imread('cameraman.png');
seeds=imread('cameraman_seeds.png');

%We don't use any segmentation labels here, so we set them to 0
labels=seeds;
labels(:)=0; 

DT_geodesic=GeodesicDT(seeds, labels, im);
DT_fuzzy_connectedness=FuzzyConnectedness(seeds, labels, im);
