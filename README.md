# bgc-argo
R code to support analysis of tracking data and B-SOSE output
## Code
The code here inlcudes fuctionality to import and format data, and the to plot Figures 1-3. Figure 4, highlighting B-SOSE model output, was made with Matlab and we're working to bring that in here. 

Run `Data and Figure 1.Rmd` first to generate the subset of tracking data used in `Figure 2.Rmd` and `Figure 3.Rmd`. The data, *tracks3* and *tagstats3*, will be saved as a *.csv* file to the `\data\tracks` directory in the project root.

## Data
The data files used in this analysis, including tracking data sets, circumpolar bathymetry, winter sea ice extent, and global coastline shapefiles exceed limits for storage on Github. We are working on a solution for access. The code expects the following data folder structure:
* data
  + bathymetry
  + coastline
  + ice
  + tracks
