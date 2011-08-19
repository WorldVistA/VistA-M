ONCIPC2A ;HINES OIFO/GWB - Primary Intracranial/CNS Tumors PCE Study ;01/18/00
 ;;2.11;ONCOLOGY;**26,27**;Mar 07, 1995
 ;Tumor Identification (continued)
PTDS W !," 20. PRE-THERAPY DIAGNOSTIC STUDIES:"
 S DR="1274      ANGIOGRAPHY.................." D ^DIE G:$D(Y) JUMP
 S DR="1275      CT SCAN OF BRAIN............." D ^DIE G:$D(Y) JUMP
 S DR="1276      CT SCAN OF SPINE............." D ^DIE G:$D(Y) JUMP
 S DR="1277      EEG.........................." D ^DIE G:$D(Y) JUMP
 S DR="1278      ISOTOPE BRAIN SCAN..........." D ^DIE G:$D(Y) JUMP
 S DR="1279      PET SCAN....................." D ^DIE G:$D(Y) JUMP
 S DR="1280      SPECT SCAN..................." D ^DIE G:$D(Y) JUMP
 S DR="1281      MRI OF BRAIN................." D ^DIE G:$D(Y) JUMP
 S DR="1282      MRI OF SPINE................." D ^DIE G:$D(Y) JUMP
 S DR="1283      FUNCTIONAL MRI..............." D ^DIE G:$D(Y) JUMP
 S DR="1284      MYELOGRAPHY.................." D ^DIE G:$D(Y) JUMP
 S DR="1285      MRS.........................." D ^DIE G:$D(Y) JUMP
TLI W !!," 21. TUMOR LOCATION/INVOLVEMENT:"
 S DR="1286      FRONTAL LOBE................." D ^DIE G:$D(Y) JUMP
 S DR="1287      TEMPORAL LOBE................" D ^DIE G:$D(Y) JUMP
 S DR="1288      PARIETAL LOBE................" D ^DIE G:$D(Y) JUMP
 S DR="1289      OCCIPITAL LOBE..............." D ^DIE G:$D(Y) JUMP
 S DR="1290      OPTIC NERVES................." D ^DIE G:$D(Y) JUMP
 S DR="1291      PITUITARY GLAND.............." D ^DIE G:$D(Y) JUMP
 S DR="1292      PINEAL GLAND................." D ^DIE G:$D(Y) JUMP
 S DR="1293      CEREBELLUM..................." D ^DIE G:$D(Y) JUMP
 S DR="1294      BRAIN STEM..................." D ^DIE G:$D(Y) JUMP
 S DR="1295      SKULL BASE..................." D ^DIE G:$D(Y) JUMP
 S DR="1296      OTHER SKULL.................." D ^DIE G:$D(Y) JUMP
 S DR="1297      SPINAL CORD.................." D ^DIE G:$D(Y) JUMP
 S DR="1298      CEREBRAL SPINAL FLUID (CSF).." D ^DIE G:$D(Y) JUMP
 S DR="1299      CRANIAL MENINGES............." D ^DIE G:$D(Y) JUMP
 S DR="1300      SPINAL MENINGES.............." D ^DIE G:$D(Y) JUMP
 S DR="1301      OTHER........................" D ^DIE G:$D(Y) JUMP
SIDE W !!," 22. SIDE:"
 S DR="1302      LEFT........................." D ^DIE G:$D(Y) JUMP
 S DR="1303      RIGHT........................" D ^DIE G:$D(Y) JUMP
 S DR="1304      MIDLINE......................" D ^DIE G:$D(Y) JUMP
NT W !
 S DR="1305 23. NUMBER OF TUMORS.............." D ^DIE G:$D(Y) JUMP
DFS S DR="1306 24. DATE OF FIRST SYMPTOMS........" D ^DIE G:$D(Y) JUMP
DID S IDX=$E(DATEDX,4,5)_"/"_$E(DATEDX,6,7)_"/"_(1700+$E(DATEDX,1,3))
 W !," 25. DATE OF INITIAL DIAGNOSIS.....: ",IDX
DPD S DR="1307 26. DATE OF PATHOLOGIC DIAGNOSIS.." D ^DIE G:$D(Y) JUMP
PS W !," 27. PRIMARY SITE (ICD-O-2)........: ",$$GET1^DIQ(165.5,IE,20.1)
WHCT S DR="1308 28. WHO HISTOLOGICAL CLASSIFICATION                                                  OF TUMOR....................." D ^DIE G:$D(Y) JUMP
BC W !," 29. BEHAVIOR CODE (ICD-O-2).......: ",$E($$GET1^DIQ(165.5,IE,22,"I"),5)
GRADE S DR="24 30. GRADE........................." D ^DIE G:$D(Y) JUMP
DC W !," 31. DIAGNOSTIC CONFIRMAITON.......: ",$$GET1^DIQ(165.5,IE,26)
MM S DR="1309 32. MOLECULAR MARKERS............." D ^DIE G:$D(Y) JUMP
TS S DR="1394 33. TUMOR SIZE...................." D ^DIE G:$D(Y) JUMP
 I X=999 D  G KRPT
 .S $P(^ONCO(165.5,ONCONUM,"CNS2"),U,25)=0
 .W !," 34. TUMOR SIZE (SOURCE)...........: Size not recorded"
TSS S DR="1310 34. TUMOR SIZE (SOURCE)..........." D ^DIE G:$D(Y) JUMP
KRPT S DR="1311 35. KARNOFSKY'S RATING PRIOR TO                                                      THERAPY......................" D ^DIE G:$D(Y) JUMP
PRTC W ! K DIR S DIR(0)="E" D ^DIR S:$D(DIRUT) OUT="Y"
 G EXIT
JUMP ;Jump to prompts
 S XX="" R !!," GO TO ITEM NUMBER: ",X:DTIME
 I (X="")!(X[U) S OUT="Y" G EXIT
 I X["?" D  G JUMP
 .W !," CHOOSE FROM:" F I=1:1:CHOICES W !,?5,HTABLE(I)
 I '$D(TABLE(X)) S:X?1.2N X=X_"." S XX=X,X=$O(TABLE(X)) I ($P(X,XX,1)'="")!(X="") W *7,"??" D  G JUMP
 .W !," CHOOSE FROM:" F I=1:1:CHOICES W !,?5,HTABLE(I)
 S X=TABLE(X)
 G @X
EXIT G EXIT^ONCIPC2
