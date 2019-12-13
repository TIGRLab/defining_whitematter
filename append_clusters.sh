#!/bin/bash

module load whitematteranalysis/2018-07-19

SUBJECTS='s1 s2 s3 s4 s5 s6'

for SUB in $SUBJECTS; do

    BASE_DIR=/projects/mjoseph/challenges/defining_whitematter
    CLUSTER_DIR=${BASE_DIR}/data/output/${SUB}/WMA/tracking-deterministic_pp/FiberClustering/InitialClusters/tracking-deterministic_pp_reg
    OUTPUT_DIR=${BASE_DIR}/data/testing/${SUB}/deterministic/ACPC

    mkdir -p $OUTPUT_DIR

    #########################################################
    # ANTERIOR/POSTERIOR COMMISURES
    #########################################################

    wm_append_clusters.py \
      $CLUSTER_DIR \
      $OUTPUT_DIR \
      -appendedTractName ACPC_initial \
      -clusterList 41 57 69 92 164 323 489 654 659

done


