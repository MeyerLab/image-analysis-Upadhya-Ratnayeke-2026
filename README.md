# Upadhya, Ratnayeke et al. 2026, Nature Communications
Analysis and plotting code used for Upadhya, Ratnayeke et al. 2026, Nature Communications. Included are scripts for generating all figures in paper.  

Processed data (single-cell measurements) can be downloaded from Zenodo for use in plotting scripts. Plots have been pre-generated and included in folders from the executed scripts.

**Functionality**
Image analysis pipeline has primarly been used on MCF-10A cells, and has been used on U2OS and RPE-1 cells. This pipeline has the following functionaliy:

Tracking cells from time-lapse microscopy and quantification of fluorescent reporters (nuclear/cytoplasmic signals)
Quantitative image-based cytometry (QIBC) analysis of fixed-cell microscopy, with capabilities to handle multi-round imaging of the same sample.
Retrospective Time-lapse Synchronized QIBC (RT-QIBC) analysis of fixed-cell microscopy, using prior information from live-cell tracking measurements of matched cells.


Timelapse and fixed microscopy image analysis pipeline used to process imaging experiments can be found at: https://github.com/MeyerLab/image-analysis-ratnayeke-2022

Parts of the analysis pipeline are based on code from Ratnayeke et al. 2022, Molecular Cell
Ratnayeke N, Baris Y, Chung M, Yeeles JTP, Meyer T. (2023). "CDT1 inhibits CMG helicase in early S phase to separate origin licensing from DNA synthesis." *Molecular Cell*, 83(1):26-42.
https://doi.org/10.1016/j.molcel.2022.12.004

**Installation**
Add /image-analysis-Upadhya-Ratnayeke-2026/ and subdirectories to MATLAB path.

Usage
For recreating plots from Upadhya, Ratnayeke et al. 2026, scripts are included in Figure-generating/ and are subdivided by figure number, along with corresponding supplementary information. Script executed to generate specific figure panels are indicated in the file names. To execute script, update dataDir to the location of the downloaded Zenodo data files and then execute script.
