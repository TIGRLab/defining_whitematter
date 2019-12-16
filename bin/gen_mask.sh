#!/bin/bash

module load FSL/6.0.1

SUBJECTS='s1 s2 s3 s4 s5 s6'

for SUB in $SUBJECTS; do

    BASE_DIR=/projects/mjoseph/challenges/defining_whitematter
    MASK_DIR=${BASE_DIR}/data/AccessoryData/Structural/${SUB}/fs_labels
    OUTPUT_DIR=${BASE_DIR}/data/refined_tracts/${SUB}
    TMP_DIR=${BASE_DIR}/data/refined_tracts/${SUB}/tmp

    mkdir -p $OUTPUT_DIR $TMP_DIR

    #########################################################
    # OPTIC RADIATIONS
    #########################################################

    # LEFT
    # include labels 1 and 2
    fslmaths \
      ${MASK_DIR}/Left-Thalamus-Proper.nii.gz \
      -mul 1 ${TMP_DIR}/Left-Thalamus-Proper_thresh.nii.gz

    fslmaths \
      ${MASK_DIR}/ctx-lh-cuneus.nii.gz \
      -mul 2 ${TMP_DIR}/ctx-lh-cuneus_thresh.nii.gz

    fslmaths \
      ${MASK_DIR}/ctx-lh-lateraloccipital.nii.gz \
      -mul 2 ${TMP_DIR}/ctx-lh-lateraloccipital_thresh.nii.gz

    fslmaths \
      ${MASK_DIR}/ctx-lh-lingual.nii.gz \
      -mul 2 ${TMP_DIR}/ctx-lh-lingual_thresh.nii.gz

    fslmaths \
      ${MASK_DIR}/ctx-lh-pericalcarine.nii.gz \
      -mul 2 ${TMP_DIR}/ctx-lh-pericalcarine_thresh.nii.gz

    # exclude label 3
    fslmaths \
      ${MASK_DIR}/ctx-lh-parahippocampal.nii.gz \
      -mul 3 ${TMP_DIR}/ctx-lh-parahippocampal_thresh.nii.gz

    fslmaths \
      ${MASK_DIR}/Left-Hippocampus.nii.gz \
      -mul 3 ${TMP_DIR}/Left-Hippocampus_thresh.nii.gz

    fslmaths \
      ${TMP_DIR}/Left-Thalamus-Proper_thresh.nii.gz \
      -add ${TMP_DIR}/ctx-lh-cuneus_thresh.nii.gz \
      -add ${TMP_DIR}/ctx-lh-lateraloccipital_thresh.nii.gz \
      -add ${TMP_DIR}/ctx-lh-lingual_thresh.nii.gz \
      -add ${TMP_DIR}/ctx-lh-pericalcarine_thresh.nii.gz \
      -add ${TMP_DIR}/ctx-lh-parahippocampal_thresh.nii.gz \
      -add ${TMP_DIR}/Left-Hippocampus_thresh.nii.gz \
      ${OUTPUT_DIR}/OR_left_mask.nii.gz

    #RIGHT
    # include labels 1 and 2
    fslmaths \
      ${MASK_DIR}/Right-Thalamus-Proper.nii.gz \
      -mul 1 ${TMP_DIR}/Right-Thalamus-Proper_thresh.nii.gz

    fslmaths \
      ${MASK_DIR}/ctx-rh-cuneus.nii.gz \
      -mul 2 ${TMP_DIR}/ctx-rh-cuneus_thresh.nii.gz

    fslmaths \
      ${MASK_DIR}/ctx-rh-lateraloccipital.nii.gz \
      -mul 2 ${TMP_DIR}/ctx-rh-lateraloccipital_thresh.nii.gz

    fslmaths \
      ${MASK_DIR}/ctx-rh-lingual.nii.gz \
      -mul 2 ${TMP_DIR}/ctx-rh-lingual_thresh.nii.gz

    fslmaths \
      ${MASK_DIR}/ctx-rh-pericalcarine.nii.gz \
      -mul 2 ${TMP_DIR}/ctx-rh-pericalcarine_thresh.nii.gz

    # exclude label 3

    fslmaths \
      ${MASK_DIR}/ctx-rh-parahippocampal.nii.gz \
      -mul 3 ${TMP_DIR}/ctx-rh-parahippocampal_thresh.nii.gz

    fslmaths \
      ${MASK_DIR}/Right-Hippocampus.nii.gz \
      -mul 3 ${TMP_DIR}/Right-Hippocampus_thresh.nii.gz

    fslmaths \
      ${TMP_DIR}/Right-Thalamus-Proper_thresh.nii.gz \
      -add ${TMP_DIR}/ctx-rh-cuneus_thresh.nii.gz \
      -add ${TMP_DIR}/ctx-rh-lateraloccipital_thresh.nii.gz \
      -add ${TMP_DIR}/ctx-rh-lingual_thresh.nii.gz \
      -add ${TMP_DIR}/ctx-rh-pericalcarine_thresh.nii.gz \
      -add ${TMP_DIR}/ctx-rh-parahippocampal_thresh.nii.gz \
      -add ${TMP_DIR}/Right-Hippocampus_thresh.nii.gz \
      ${OUTPUT_DIR}/OR_right_mask.nii.gz

done
