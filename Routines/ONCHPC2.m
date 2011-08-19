ONCHPC2 ;Hines OIFO/GWB - 2000 Hepatocellular Cancers PCE Study ;01/06/00
 ;;2.11;ONCOLOGY;**26**;Mar 07, 1995
 ;Tumor Indentification 
 K TABLE,HTABLE
 S TABLE("11. CLASS OF CASE")="CC"
 S TABLE("12. HORMONES")="HOR"
 S TABLE("13. CONDITIONS PRESENT AT INITIAL DIAGNOSIS")="CPID"
 S TABLE("14. ALCOHOL CONSUMPTION")="AC"
 S TABLE("15. TUMOR MARKERS")="TM"
 S TABLE("16. TESTS RELATED TO LIVER FUNCTION")="TRLF"
 S TABLE("17. RADIOLOGICAL EVALUATION")="RE"
 S TABLE("18. DEFINITIVE DIAGNOSIS")="DD"
 S TABLE("19. DATE OF INITIAL DIAGNOSIS")="DID"
 S TABLE("20. HISTOLOGY (ICD-O-2)")="HIST"
 S TABLE("21. GRADE")="GRADE"
 S TABLE("22. DIAGNOSTIC CONFIRMATION")="DC"
 S HTABLE(1)="11. CLASS OF CASE"
 S HTABLE(2)="12. HORMONES"
 S HTABLE(3)="13. CONDITIONS PRESENT AT INITIAL DIAGNOSIS"
 S HTABLE(4)="14. ALCOHOL CONSUMPTION"
 S HTABLE(5)="15. TUMOR MARKERS"
 S HTABLE(6)="16. TESTS RELATED TO LIVER FUNCTION"
 S HTABLE(7)="17. RADIOLOGICAL EVALUATION"
 S HTABLE(8)="18. DEFINITIVE DIAGNOSIS"
 S HTABLE(9)="19. DATE OF INITIAL DIAGNOSIS"
 S HTABLE(10)="20. HISTOLOGY (ICD-O-2)"
 S HTABLE(11)="21. GRADE"
 S HTABLE(12)="22. DIAGNOSTIC CONFIRMATION"
 S CHOICES=12
 S IE=ONCONUM
 S DIE="^ONCO(165.5,",DA=ONCONUM
 W @IOF D HEAD^ONCHPC0
 W !," TUMOR IDENTIFICATION"
 W !," --------------------"
CC W !," 11. CLASS OF CASE.................: ",$$GET1^DIQ(165.5,IE,.04,"E")
HOR W !!," 12. HORMONES:"
 S DR="1000      ORAL CONTRACEPTIVES.........." D ^DIE G:$D(Y) JUMP
 S DR="1001      ESTROGEN REPLACEMENT........." D ^DIE G:$D(Y) JUMP
 S DR="1002      TAMOXIFEN...................." D ^DIE G:$D(Y) JUMP
 S DR="1003      OTHER........................" D ^DIE G:$D(Y) JUMP
 W !
CPID W !," 13. CONDITIONS PRESENT AT INITIAL DIAGNOSIS:"
 S DR="1004      ASCITES......................" D ^DIE G:$D(Y) JUMP
 S DR="1005      CIRRHOSIS...................." D ^DIE G:$D(Y) JUMP
 S DR="1006      CHILD'S CLASS A.............." D ^DIE G:$D(Y) JUMP
 S DR="1007      CHILD'S CLASS B.............." D ^DIE G:$D(Y) JUMP
 S DR="1008      CHILD'S CLASS C.............." D ^DIE G:$D(Y) JUMP
 S DR="1009      HEPATITIS B.................." D ^DIE G:$D(Y) JUMP
 S DR="1010      HEPATITIS C.................." D ^DIE G:$D(Y) JUMP
 S DR="1011      HEMOCHROMATOSIS.............." D ^DIE G:$D(Y) JUMP
 W !
AC S DR="1012 14. ALCOHOL CONSUMPTION..........." D ^DIE G:$D(Y) JUMP
TM W !!," 15. TUMOR MARKERS:"
 S DR="1013      AFP (IU/ml).................." D ^DIE G:$D(Y) JUMP
 S DR="1014      CEA (mg/ml).................." D ^DIE G:$D(Y) JUMP
 S DR="1015      CA19.9 (U/ml)................" D ^DIE G:$D(Y) JUMP
TRLF W !!," 16. TESTS RELATED TO LIVER FUNCTION:"
 S DR="1016      PROTIME (sec)................" D ^DIE G:$D(Y) JUMP
 S DR="1017      BILIRUBIN (mg/ml)............" D ^DIE G:$D(Y) JUMP
 S DR="1018      ALBUMIN (g/dl)..............." D ^DIE G:$D(Y) JUMP
 S DR="1019      LDH (U/I)...................." D ^DIE G:$D(Y) JUMP
RE W !!," 17. RADIOLOGICAL EVALUATION:"
CTAP W !!,"     CT ARTERIAL PORTOGRAPHY:"
 S DR="1020      PERFORMED...................." D ^DIE G:$D(Y) JUMP
 I $G(X)=0 D CTAP0^ONCHPC2A G SCT
 I $G(X)=9 D CTAP9^ONCHPC2A G SCT
 S DR="1021      CIRRHOSIS...................." D ^DIE G:$D(Y) JUMP
 S DR="1022      VASCULAR INVASION............" D ^DIE G:$D(Y) JUMP
 S DR="1023      BILOBAR DISEASE.............." D ^DIE G:$D(Y) JUMP
 S DR="1024      LYMPH NODES.................." D ^DIE G:$D(Y) JUMP
 S DR="1025      SIZE OF DOMINANT TUMOR (mm).." D ^DIE G:$D(Y) JUMP
 S DR="1026      NUMBER OF TUMORS............." D ^DIE G:$D(Y) JUMP
SCT W !!,"     SPIRAL CT:"
 S DR="1027      PERFORMED...................." D ^DIE G:$D(Y) JUMP
 I $G(X)=0 D SCT0^ONCHPC2A G ICT
 I $G(X)=9 D SCT9^ONCHPC2A G ICT
 S DR="1028      CIRRHOSIS...................." D ^DIE G:$D(Y) JUMP
 S DR="1029      VASCULAR INVASION............" D ^DIE G:$D(Y) JUMP
 S DR="1030      BILOBAR DISEASE.............." D ^DIE G:$D(Y) JUMP
 S DR="1031      LYMPH NODES.................." D ^DIE G:$D(Y) JUMP
 S DR="1032      SIZE OF DOMINANT TUMOR (mm).." D ^DIE G:$D(Y) JUMP
 S DR="1033      NUMBER OF TUMORS............." D ^DIE G:$D(Y) JUMP
ICT W !!,"     INCREMENTAL CT:"
 S DR="1034      PERFORMED...................." D ^DIE G:$D(Y) JUMP
 I $G(X)=0 D ICT0^ONCHPC2A G ULTRA
 I $G(X)=9 D ICT9^ONCHPC2A G ULTRA
 S DR="1035      CIRRHOSIS...................." D ^DIE G:$D(Y) JUMP
 S DR="1036      VASCULAR INVASION............" D ^DIE G:$D(Y) JUMP
 S DR="1037      BILOBAR DISEASE.............." D ^DIE G:$D(Y) JUMP
 S DR="1038      LYMPH NODES.................." D ^DIE G:$D(Y) JUMP
 S DR="1039      SIZE OF DOMINANT TUMOR (mm).." D ^DIE G:$D(Y) JUMP
 S DR="1040      NUMBER OF TUMORS............." D ^DIE G:$D(Y) JUMP
ULTRA W !!,"     ULTRASOUND:"
 S DR="1041      PERFORMED...................." D ^DIE G:$D(Y) JUMP
 I $G(X)=0 D ULTRA0^ONCHPC2A G MRI
 I $G(X)=9 D ULTRA9^ONCHPC2A G MRI
 S DR="1042      CIRRHOSIS...................." D ^DIE G:$D(Y) JUMP
 S DR="1043      VASCULAR INVASION............" D ^DIE G:$D(Y) JUMP
 S DR="1044      BILOBAR DISEASE.............." D ^DIE G:$D(Y) JUMP
 S DR="1045      LYMPH NODES.................." D ^DIE G:$D(Y) JUMP
 S DR="1046      SIZE OF DOMINANT TUMOR (mm).." D ^DIE G:$D(Y) JUMP
 S DR="1047      NUMBER OF TUMORS............." D ^DIE G:$D(Y) JUMP
MRI W !!,"     MRI:"
 S DR="1048      PERFORMED...................." D ^DIE G:$D(Y) JUMP
 I $G(X)=0 D MRI0^ONCHPC2A G DD
 I $G(X)=9 D MRI9^ONCHPC2A G DD
 S DR="1049      CIRRHOSIS...................." D ^DIE G:$D(Y) JUMP
 S DR="1050      VASCULAR INVASION............" D ^DIE G:$D(Y) JUMP
 S DR="1051      BILOBAR DISEASE.............." D ^DIE G:$D(Y) JUMP
 S DR="1052      LYMPH NODES.................." D ^DIE G:$D(Y) JUMP
 S DR="1053      SIZE OF DOMINANT TUMOR (mm).." D ^DIE G:$D(Y) JUMP
 S DR="1054      NUMBER OF TUMORS............." D ^DIE G:$D(Y) JUMP
DD W !
 S DR="1055 18. DEFINITIVE DIAGNOSIS.........." D ^DIE G:$D(Y) JUMP
DID S DID=$E(DATEDX,4,5)_"/"_$E(DATEDX,6,7)_"/"_(1700+$E(DATEDX,1,3))
 W !," 19. DATE OF INITIAL DIAGNOSIS.....: ",DID
HIST W !," 20. HISTOLOGY (ICD-O-2)...........: ",$E($$GET1^DIQ(165.5,IE,22,"I"),1,4)," ",$$GET1^DIQ(165.5,IE,22)
GRADE S DR="24 21. GRADE........................." D ^DIE G:$D(Y) JUMP
DC W !," 22. DIAGNOSTIC CONFIRMATON........: ",$$GET1^DIQ(165.5,IE,26,"E")
 W ! K DIR S DIR(0)="E" D ^DIR S:$D(DIRUT) OUT="Y"
 G EXIT
RE0 ;Radiological Evaluation not performed (0)
 W !,"      CIRRHOSIS....................: NA"
 W !,"      VASCULAR INVASION............: NA"
 W !,"      BILOBAR DISEASE..............: NA"
 W !,"      LYMPH NODES..................: NA"
 W !,"      SIZE OF DOMINANT TUMOR (mm)..: Not performed"
 W !,"      NUMBER OF TUMORS.............: Not performed"
 Q
RE9 ;Radiological Evaluation unknown (9)
 W !,"      CIRRHOSIS....................: Unknown"
 W !,"      VASCULAR INVASION............: Unknown"
 W !,"      BILOBAR DISEASE..............: Unknown"
 W !,"      LYMPH NODES..................: Unknown"
 W !,"      SIZE OF DOMINANT TUMOR (mm)..: Not performed"
 W !,"      NUMBER OF TUMORS.............: Not performed"
 Q
JUMP ;Jump to prompts
 S XX="" R !!," GO TO ITEM NUMBER: ",X:DTIME
 I (X="")!(X[U) S OUT="Y" G EXIT
 I X["?" D  G JUMP
 .W !," CHOOSE FROM:" F I=1:1:CHOICES W !,?5,HTABLE(I)
 I '$D(TABLE(X)) S:X?1.2N X=X_"." S XX=X,X=$O(TABLE(X)) I ($P(X,XX,1)'="")!(X="") W *7,"??" D  G JUMP
 .W !," CHOOSE FROM:" F I=1:1:CHOICES W !,?5,HTABLE(I)
 S X=TABLE(X)
 G @X
EXIT K CHOICES,HTABLE,IE,TABLE
 K DA,DID,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,X,XX,Y
 Q
