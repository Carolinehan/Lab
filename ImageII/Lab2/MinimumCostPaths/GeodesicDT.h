//////////////////////////////////////
//GeodesicDT implementation 
//////////////////////////////////////

#ifndef GEODESIC_DT_H
#define GEODESIC_DT_H

#include "image.h"
#include <queue>
#include "mex.h"
#include <vector>
#include <math.h>
#include <limits>
using namespace std;

class Qelem{
 public:
  double value;
  long index;

  Qelem(long i, double v){value=v; index=i;}
};

class ElemComparison{
 public:
   bool operator() (const Qelem& lhs, const Qelem&rhs) const{
    return lhs.value>rhs.value;
  } 
};

typedef priority_queue<Qelem, vector<Qelem>, ElemComparison> Pq;

void GeodesicDT(imagetype seeds, imagetype labels, imagetype cost, double* dt, double *segmentation){
  int nelem = seeds.getNelem();

  bool* inQ=new bool[nelem];

  Pq Q;

  for(int i=0; i< nelem; i++ ){
    dt[i]=std::numeric_limits<double>::max(); //Approximately infinity
    inQ[i]=false;
    segmentation[i]=labels[i];

    if(seeds[i]>0){
      dt[i]=0;
      Q.push(Qelem(i,0));
      inQ[i]=true;
    }
  }

  int ni;
  double fval;
  double power=50;

  vector<int> neighbors;

  while(!Q.empty()){
    Qelem e =Q.top();
    Q.pop();
    
    if(inQ[e.index]){
      inQ[e.index]=false;
     
      seeds.get_4_neighbors(e.index, neighbors);
      
      for(int i=0; i<neighbors.size(); i++){
	ni=neighbors[i];
	
	//fval= fval=dt[e.index]+abs(double(cost[ni])-double(cost[e.index]));
    
    fval= fval=pow((pow(dt[e.index],power)+pow(abs(double(cost[ni])-double(cost[e.index])),power)),1/power);
	 
	if(fval<dt[ni] || (fval==dt[ni] && segmentation[e.index]<segmentation[ni])){
	  dt[ni]=fval;
	  segmentation[ni]=segmentation[e.index];
	  Q.push(Qelem(ni,fval));
	  inQ[ni]=true;
	  
	}
      }
    }
  }
  delete[] inQ;
  
}

#endif
