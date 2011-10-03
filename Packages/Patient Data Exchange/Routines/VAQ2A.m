VAQ2A ;ALB/CMM,JRP - PDX PATCH 15 FIELD VERIFIER ;01-FEB-95
 ;;1.5;PATIENT DATA EXCHANGE;**15**;NOV 17, 1993
 ;
FIX1 ;Verify triggered field/cross reference in VAQ - RELEASE GROUP file
 ;Kill "C" cross reference
 K ^VAT(394.82,"C")
 ;Declare variables
 N LOOP,LOC,COUNT,DIE,DA,DR,DIC,X,Y
 W !,?3,"Performing update of triggered values in VAQ - RELEASE GROUP file "
 ;Loop through all entries in 394.82 to re-stuff Remote Domain.
 ;Will update any entries that had external format and make it
 ;the pointer value.
 W "."
 S (LOOP,COUNT)=0,DIE="^VAT(394.82,"
 F  S LOOP=+$O(^VAT(394.82,LOOP)) Q:('LOOP)  D
 .S LOC=$P(^VAT(394.82,LOOP,0),"^",2)
 .S DA=LOOP,DR=".02///"_LOC
 .D ^DIE
 .S COUNT=COUNT+1
 .I '(COUNT#10) W "."
 Q
FIX2 ;Verify triggered field/cross reference in VAQ - OUTGOING GROUP file
 ;Declare variables
 N ENT,LOOP,COUNT,LOC,DIE,DA,DR,DIC,X,Y
 W !,?3,"Performing update of triggered values in VAQ - OUTGOING GROUP file "
 ;Loop through all entries in 394.83 to re-stuff Remote Domain.
 ;Will update any entries that had external format and make
 ;it the pointer value.
 S (ENT,COUNT)=0
 W "."
 F  S ENT=+$O(^VAT(394.83,ENT)) Q:('ENT)  D
 .;Kill "A-OUTGRP" cross reference
 .K ^VAT(394.83,ENT,"FAC","A-OUTGRP")
 .S LOOP=0
 .F  S LOOP=+$O(^VAT(394.83,ENT,"FAC",LOOP)) Q:('LOOP)  D
 ..S LOC=$P(^VAT(394.83,ENT,"FAC",LOOP,0),"^",2)
 ..S DA(1)=ENT,DA=LOOP,DR=".02///"_LOC,DIE="^VAT(394.83,"_ENT_",""FAC"","
 ..D ^DIE
 ..S COUNT=COUNT+1
 ..I '(COUNT#10) W "."
 Q
