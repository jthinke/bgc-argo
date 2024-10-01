# bgc-argo
R code to support analysis of tracking data and B-SOSE output. 
## Code
The code here includes functionality to import and format data, and the to plot Figures 1-4 in the manuscript. Figure 5, highlighting B-SOSE model output, was made with Matlab and you'll need to find Matt. 

Run `Data and Figure 1.Rmd` first to generate the subset of tracking data used in `Figure 2.Rmd` and `Figure 3.Rmd`. The subsets of data, *tracks3* and *tagstats3*, will be saved as *.csv* files to the `\data\tracks` directory in the project root.

## Data
The data files used in this analysis, including tracking data sets, circumpolar bathymetry, winter sea ice extent, and global coastline shapefiles exceed limits for storage on Github. The code expects the following data folder structure:
* data
  + bathymetry
  + coastline
  + ice
  + tracks
