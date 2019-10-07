# Defining White Matter Challenge

## Task
- extract 14 major white matter pathways using MRI data from 6 subjects in the HCP dataset
- extract the **LEFT** pathway only

- define where each tract starts, ends, where it goes, its relation to cortical structure, shape, location relative to other structures
- dissect the streamlines that make up these pathways

## Methods
- deterministic
- probabilistic
  
## Software
Try to avoid software that requires inputing the raw data so we can use the already pre-processed files that have been provided. 

- [Unscented Kalman Filter (UKF) tractography](https://github.com/pnlbwh/ukftractography)
- [WhiteMatterAnalysis](https://github.com/SlicerDMRI/whitematteranalysis)
- [White Matter Query Language](https://github.com/demianw/tract_querier) **
- [Automated Fiber Quantification](https://github.com/yeatmanlab/AFQ)
- [TractSeg](https://github.com/MIC-DKFZ/TractSeg)
