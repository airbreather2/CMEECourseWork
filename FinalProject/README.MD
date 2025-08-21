# Final Project Repository

## Overview
This repository contains the final scripts associated with the MSC project using XGboost and random forests to predict wheat yield

## File Structure

```
├── datajoin/                   # [Contains datajoining scripts]
│   └── [2 items]              # 
├── other scripts/             # [Contains scripts for mentioned algorithms in the paper ]
│   └── [5 items]              # Coordjitter.ipynb(Coordinate Jittering) ,missforest.R (missing random forest imputation script), Rfmodelanalysis.ipynb (Notebook for generating SHAP plots used in analysis for RF, Spacialautocorrelation.ipynb (Code used to generate spacial autocorrelation threshold) , Xgboostmodelanalysis.ipynb (Code used in analysis for XGboost)

├── README.md                  # This file
├── functions.py            # [Contains functions used in some code]
├── RFtopush.ipynb            # [Final RF global model generator]
└── XGBOOSTtopush.ipynb       # [Final XGboost global model generator]
```

## Scripts and Notebooks

### Main Analysis Notebooks
- **`RFtopush.ipynb`** - [ Generated and saves the final RF model and csv files used for SHAP analysis after in Rfmodelanalysis.ipynb). Input file required:imputed_jittered_eng_cleaned.csv  ]
- **`XGBOOSTtopush.ipynb`** - [ Generated and saves the final XGBoost model and csv files used for SHAP analysis after in Rfmodelanalysis.ipynb ]


## Python Libraries

### Core Libraries
- `os`  
- `time`  
- `numpy`  
- `pandas`  
- `matplotlib.pyplot`  
- `seaborn`  
- `tabulate`  
- `sys`  
- `joblib`  

### Geospatial Analysis
- `geopandas`  
- `shapely.geometry`  
- `haversine`  
- `folium`  

### Machine Learning
- `sklearn`  
- `xgboost`  
- `category_encoders`  
- `shap`  

### Statistical Analysis
- `scipy.stats`  
- `scipy.cluster.hierarchy`  
- `scipy.spatial.distance`  
- `gstools`  
- `skgstat`  
- `statsmodels.graphics.tsaplots`  

---

## R Packages
- `missForest`  
- `Tidyverse`  
- `readr`  
- `mice`  
- `corrplot`  
```
