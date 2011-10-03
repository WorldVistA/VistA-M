GECSLIST ;WISC/RFJ-old version 1.5 routine                          ;01 Nov 93
 ;;2.0;GCS;;MAR 14, 1995
 Q
WAITBAT ;  batches waiting to be transmitted
 D WAITBAT^GECSREP0 Q
RBAT ;  code sheets ready for batching
 D READYBAT^GECSREP0 Q
BATCHES ;  status of all batches
 D BATCHES^GECSREP0 Q
