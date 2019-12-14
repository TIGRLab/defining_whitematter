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
      ${OUTPUT_DIR}/OR_mask.nii.gz

done

for SUB in $SUBJECTS; do

    BASE_DIR=/projects/mjoseph/challenges/defining_whitematter
    MASK_DIR=${BASE_DIR}/data/AccessoryData/Structural/${SUB}/fs_labels
    OUTPUT_DIR=${BASE_DIR}/data/refined_tracts/${SUB}
    TMP_DIR=${BASE_DIR}/data/refined_tracts/${SUB}/tmp

    mkdir -p $OUTPUT_DIR $TMP_DIR

    #########################################################
    # ANTERIOR/POSTERIOR COMMISSURE
    #########################################################

    fslmaths \
      # prefrontal
      ${MASK_DIR}/ctx-lh-parstriangularis.nii.gz \
      -add ${MASK_DIR}/ctx-rh-parstriangularis.nii.gz \
      -add ${MASK_DIR}/ctx-lh-parsorbitalis.nii.gz \
      -add ${MASK_DIR}/ctx-rh-parsorbitalis.nii.gz \
      -add ${MASK_DIR}/ctx-lh-superiorfrontal.nii.gz \
      -add ${MASK_DIR}/ctx-rh-superiorfrontal.nii.gz \
      -add ${MASK_DIR}/ctx-lh-rostralmiddlefrontal.nii.gz \
      -add ${MASK_DIR}/ctx-rh-rostralmiddlefrontal.nii.gz \
      -add ${MASK_DIR}/ctx-lh-frontalpole.nii.gz \
      -add ${MASK_DIR}/ctx-rh-frontalpole.nii.gz \
      -add ${MASK_DIR}/ctx-lh-lateralorbitofrontal.nii.gz \
      -add ${MASK_DIR}/ctx-rh-lateralorbitofrontal.nii.gz \
      # parietal
      -add ${MASK_DIR}/ctx-lh-postcentral.nii.gz \
      -add ${MASK_DIR}/ctx-rh-postcentral.nii.gz \
      -add ${MASK_DIR}/ctx-lh-precuneus.nii.gz \
      -add ${MASK_DIR}/ctx-rh-precuneus.nii.gz \
      -add ${MASK_DIR}/ctx-lh-supramarginal.nii.gz \
      -add ${MASK_DIR}/ctx-rh-supramarginal.nii.gz \
      -add ${MASK_DIR}/ctx-rh-lateralorbitofrontal.nii.gz \
      -add ${MASK_DIR}/ctx-lh-superiorparietal.nii.gz \
      -add ${MASK_DIR}/ctx-rh-superiorparietal.nii.gz \
      -add ${MASK_DIR}/ctx-lh-inferiorparietal.nii.gz \
      -add ${MASK_DIR}/ctx-rh-inferiorparietal.nii.gz \
      # occipital
      -add ${MASK_DIR}/ctx-lh-lingual.nii.gz \
      -add ${MASK_DIR}/ctx-rh-lingual.nii.gz \
      -add ${MASK_DIR}/ctx-lh-pericalcarine.nii.gz \
      -add ${MASK_DIR}/ctx-rh-pericalcarine.nii.gz \
      -add ${MASK_DIR}/ctx-lh-cuneus.nii.gz \
      -add ${MASK_DIR}/ctx-rh-cuneus.nii.gz \
      -add ${MASK_DIR}/ctx-lh-lateraloccipital.nii.gz \
      -add ${MASK_DIR}/ctx-rh-lateraloccipital.nii.gz \
      # precentral
      -add ${MASK_DIR}/ctx-lh-precentral.nii.gz \
      -add ${MASK_DIR}/ctx-rh-precentral.nii.gz \
      ${TMP_DIR}/lobe_mask.nii.gz

done


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

