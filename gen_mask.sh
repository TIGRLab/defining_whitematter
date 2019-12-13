#!/bin/bash

SUBJECTS='s1 s2 s3 s4 s5 s6'

for SUB in $SUBJECTS; do

    BASE_DIR=/projects/mjoseph/challenges/defining_whitematter
    MASK_DIR=${BASE_DIR}/data/AccessoryData/Structural/${SUB}/fs_labels
    OUTPUT_DIR=${BASE_DIR}/data/testing/${SUB}/masks/OR

    mkdir -p $OUTPUT_DIR

    cd $MASK_DIR

    #########################################################
    # OPTIC RADIATIONS
    #########################################################

    # include labels 1 and 2

    fslmaths \
      Left-Thalamus-Proper.nii.gz \
      -mul 1 ${OUTPUT_DIR}/Left-Thalamus-Proper_thresh.nii.gz

    fslmaths \
      ctx-lh-cuneus.nii.gz \
      -mul 2 ${OUTPUT_DIR}/ctx-lh-cuneus_thresh.nii.gz

    fslmaths \
      ctx-lh-lateraloccipital.nii.gz \
      -mul 2 ${OUTPUT_DIR}/ctx-lh-lateraloccipital_thresh.nii.gz

    fslmaths \
      ctx-lh-lingual.nii.gz \
      -mul 2 ${OUTPUT_DIR}/ctx-lh-lingual_thresh.nii.gz

    fslmaths \
      ctx-lh-pericalcarine.nii.gz \
      -mul 2 ${OUTPUT_DIR}/ctx-lh-pericalcarine_thresh.nii.gz

    # exclude label 3

    fslmaths \
      ctx-lh-parahippocampal.nii.gz \
      -mul 3 ${OUTPUT_DIR}/ctx-lh-parahippocampal_thresh.nii.gz

    fslmaths \
      Left-Hippocampus.nii.gz \
      -mul 3 ${OUTPUT_DIR}/Left-Hippocampus_thresh.nii.gz

    fslmaths \
      ${OUTPUT_DIR}/Left-Thalamus-Proper_thresh.nii.gz \
      -add ${OUTPUT_DIR}/ctx-lh-cuneus_thresh.nii.gz \
      -add ${OUTPUT_DIR}/ctx-lh-lateraloccipital_thresh.nii.gz \
      -add ${OUTPUT_DIR}/ctx-lh-lingual_thresh.nii.gz \
      -add ${OUTPUT_DIR}/ctx-lh-pericalcarine_thresh.nii.gz \
      -add ${OUTPUT_DIR}/ctx-lh-parahippocampal_thresh.nii.gz \
      -add ${OUTPUT_DIR}/Left-Hippocampus_thresh.nii.gz \
      ${OUTPUT_DIR}/OR_mask.nii.gz

done

#########################################################
# ANTERIOR/POSTERIOR COMMISSURE
#########################################################

for SUB in $SUBJECTS; do

    BASE_DIR=/projects/mjoseph/challenges/defining_whitematter
    DWI_DIR=${BASE_DIR}/data/Data_2.0/${SUB}
    MASK_DIR=${BASE_DIR}/data/AccessoryData/Structural/${SUB}/fs_labels
    OUTPUT_DIR=${BASE_DIR}/data/testing/${SUB}/masks/ACPC

    mkdir -p $OUTPUT_DIR

    # fslmaths \
    #   ${MASK_DIR}/Left-Caudate.nii.gz \
    #   -mul 1 ${OUTPUT_DIR}/Left-Caudate_thresh.nii.gz

    # fslmaths \
    #   ${MASK_DIR}/Left-Putamen.nii.gz \
    #   -mul 2 ${OUTPUT_DIR}/Left-Putamen_thresh.nii.gz

    fslmaths \
      ${MASK_DIR}/Left-Pallidum.nii.gz \
      -mul 1 ${OUTPUT_DIR}/Left-Pallidum_thresh.nii.gz

    fslmaths \
      ${MASK_DIR}/Right-Pallidum.nii.gz \
      -mul 1 ${OUTPUT_DIR}/Right-Pallidum_thresh.nii.gz

    fslmaths \
      ${OUTPUT_DIR}/Left-Pallidum_thresh.nii.gz \
      -add ${OUTPUT_DIR}/Right-Pallidum_thresh.nii.gz \
      ${OUTPUT_DIR}/ACPC_mask.nii.gz

    # fslmaths \
    #   ${OUTPUT_DIR}/Left-Caudate_thresh.nii.gz \
    #   -add ${OUTPUT_DIR}/Left-Putamen_thresh.nii.gz \
    #   -add ${OUTPUT_DIR}/Left-Pallidum_thresh.nii.gz \
    #   ${OUTPUT_DIR}/ACPC_mask.nii.gz

done

