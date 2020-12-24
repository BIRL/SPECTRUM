# SPECTRUM
Top-Down Proteomics (TDP) is an emerging proteomics protocol that involves identification, characterization, and quantitation of intact proteins using high-resolution mass spectrometry. 

TDP has an edge over other proteomics protocols in that it allows for: 
1. accurate measurement of intact protein mass, 
1. high sequence coverage, and 
1. enhanced identification of post-translational modifications (PTMs). 

However, the complexity of TDP spectra poses a significant impediment to protein search and PTM characterization. Furthermore, limited software support is currently available in the form of search algorithms and pipelines. To address this need, we propose [SPECTRUM](https://github.com/BIRL/SPECTRUM), an open-architecture and open-source toolbox for TDP data analysis. 

## Features
Its salient features include: 
1. MS2-based intact protein mass tuning, 
1. de novo peptide sequence tag analysis, 
1. propensity-driven PTM characterization, 
1. blind PTM search, (v) spectral comparison, 
1. identification of truncated proteins, 
1. multifactorial coefficient-weighted scoring, and 
1. intuitive graphical user interfaces to access the aforementioned functionalities and visualization of results. 

We have validated SPECTRUM using published datasets and benchmarked it against salient TDP tools. SPECTRUM provides significantly enhanced protein identification rates (91% to 177%) over its contemporaries. 

[SPECTRUM](https://github.com/BIRL/SPECTRUM) has been implemented in MATLAB, and is freely available along with its source code and [documentation](https://github.com/BIRL/SPECTRUM/).
