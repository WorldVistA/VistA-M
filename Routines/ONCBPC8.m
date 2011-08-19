ONCBPC8 ;Hines OIFO/GWB -PCE Study of Cancers of the Urinary Bladder ;05/30/00
 ;;2.11;ONCOLOGY;**6,16,26**;Mar 07, 1995
 ;Print
 K IOP,%ZIS S %ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP KILL
 I $D(IO("Q")) S ONCOLST="ONCONUM^ONCOPA^PATNAM^SPACES^TOPNAM^SSN^TOPTAB^TOPCOD^DASHES^SITTAB^SITEGP" D TASK G KILL
 U IO D PRT D ^%ZISC K %ZIS,IOP G KILL
PRT S PG=0,EX="",LIN=$S(IOST?1"C".E:IOSL-2,1:IOSL-6)
 D NOW^%DTC S ONDATE=%,Y=ONDATE X ^DD("DD") S ONDATE=Y
I S TABLE="TABLE I - GENERAL INFORMATION"
 D HDR W !?15,TABLE,!
 S PRINODE0=^ONCO(165.5,ONCONUM,0)
 S ACCSEQ=$P(PRINODE0,U,5)_"/"_$P(PRINODE0,U,6)
 S IEN=ONCONUM
 K DIQ S DIC="^ONCO(160,",DR="3;9;15",DA=ONCOPA,DIQ="ONC" D EN^DIQ1
 S DIC="^ONCO(165.5,"
 S DR=".04;.1;.12;3;9;18;19;20;22;24;29;32;33;34;34.1;34.2;37.1;37.2;37.3;38;50;51;51.2;53;53.2;55.2;58.1;58.2;58.3;70;71.1;71.2;71.3;81;82;85;86;87;88;89;300:387"
 S DA=ONCONUM,DIQ="ONC" D EN^DIQ1
 W !,"ACCESSION/SEQUENCE NUMBER...........: ",ACCSEQ D P Q:EX=U
 W !,"CLASS OF CASE.......................: ",ONC(165.5,IEN,.04) D P Q:EX=U
 W !,"PATIENT REFERRED FOR TREATMENT......: ",ONC(165.5,IEN,300) D P Q:EX=U
 W !,"ZIP CODE AT DIAGNOSIS...............: ",ONC(165.5,IEN,9) D P Q:EX=U
 W !,"BIRTHDATE...........................: ",ONC(160,ONCOPA,3) D P Q:EX=U
 W !,"RACE................................: ",ONC(165.5,IEN,.12) D P Q:EX=U
 W !,"SPANISH ORIGIN......................: ",ONC(160,ONCOPA,9) D P Q:EX=U
 W !,"SEX.................................: ",ONC(165.5,IEN,.1) D P Q:EX=U
 W !,"PRIMARY PAYER AT DIAGNOSIS..........: ",ONC(165.5,IEN,18) D P Q:EX=U
 W !,"LENGTH OF STAY......................: ",ONC(165.5,IEN,301)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR W !?15,TABLE_" (continued)" G PHOOC
 D P Q:EX=U
PHOOC W !!,"PATIENT HISTORY OF OTHER CANCER:",?41,"FAMILY HISTORY OF CANCER:",! D P Q:EX=U
 W !,"  CERVIX.......: ",ONC(165.5,IEN,302),?41,"  BLADDER......: ",ONC(165.5,IEN,309) D P Q:EX=U
 W !,"  COLON........: ",ONC(165.5,IEN,303),?41,"  COLON........: ",ONC(165.5,IEN,310) D P Q:EX=U
 W !,"  BLADDER......: ",ONC(165.5,IEN,304),?41,"  LUNG.........: ",ONC(165.5,IEN,311) D P Q:EX=U
 W !,"  HEAD AND NECK: ",ONC(165.5,IEN,305),?41,"  PROSTATE.....: ",ONC(165.5,IEN,312) D P Q:EX=U
 W !,"  KIDNEY.......: ",ONC(165.5,IEN,306),?41,"  OTHER........: ",ONC(165.5,IEN,313) D P Q:EX=U
 W !,"  PROSTATE.....: ",ONC(165.5,IEN,307) D P Q:EX=U
 W !,"  OTHER........: ",ONC(165.5,IEN,308) D P Q:EX=U
 W !!,"SMOKING HISTORY.....................: ",ONC(165.5,IEN,314) D P Q:EX=U
 W !,"DURATION OF SMOKING HISTORY.........: ",ONC(165.5,IEN,315) D P Q:EX=U
 W !,"DURATION OF SMOKE FREE HISTORY......: ",ONC(165.5,IEN,315)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR G II
 D P Q:EX=U
II S TABLE="TABLE II - DIAGNOSTIC INFORMATION"
 I IOST'?1"C".E W ! I ($Y'<(LIN-4)) D HDR
 W !?15,TABLE,! D P Q:EX=U
 W !,"CLINICAL DETECTION:",! D P Q:EX=U
 W !,"  GROSS HEMATURIA...................: ",ONC(165.5,IEN,317) D P Q:EX=U
 W !,"  MICROSCOPIC HEMATURIA.............: ",ONC(165.5,IEN,318) D P Q:EX=U
 W !,"  URINARY FREQUENCY.................: ",ONC(165.5,IEN,319) D P Q:EX=U
 W !,"  BLADDER IRRITIBILITY..............: ",ONC(165.5,IEN,320) D P Q:EX=U
 W !,"  DYSURIA...........................: ",ONC(165.5,IEN,321) D P Q:EX=U
 W !,"  OTHER.............................: ",ONC(165.5,IEN,322) D P Q:EX=U
 W !!,"ONSET OF SYMPTOMS...................: ",ONC(165.5,IEN,323)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR W !?15,TABLE_" (continued)" G DOS
 D P Q:EX=U
DOS W !!,"DURATION OF SYMPTOMS:",! D P Q:EX=U
 W !,"  GROSS HEMTURIA....................: ",ONC(165.5,IEN,324) D P Q:EX=U
 W !,"  DYSURIA...........................: ",ONC(165.5,IEN,325) D P Q:EX=U
 W !!,"DIAGNOSTIC PROCEDURES:" D P Q:EX=U
 W !!,"  BIMANUAL EXAMINATION OF BLADDER...: ",ONC(165.5,IEN,326) D P Q:EX=U
 W !,"  CYSTOSCOPY WITH BIOPSY............: ",ONC(165.5,IEN,327) D P Q:EX=U
 W !,"  CYSTOSCOPY WITHOUT BIOPSY.........: ",ONC(165.5,IEN,328) D P Q:EX=U
 W !,"  FLOW CYTOMETRY....................: ",ONC(165.5,IEN,329) D P Q:EX=U
 W !,"  INTRAVENOUS PYELOGRAM.............: ",ONC(165.5,IEN,330) D P Q:EX=U
 W !,"  URINE CYTOLOGY....................: ",ONC(165.5,IEN,331) D P Q:EX=U
 W !,"  URINALYSIS........................: ",ONC(165.5,IEN,332) D P Q:EX=U
 W !,"  OTHER.............................: ",ONC(165.5,IEN,333)
 I IOST?1"C".E K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR W !?15,TABLE_" (continued)" G DOID
 D P Q:EX=U
DOID W !!,"DATE OF INITIAL DIAGNOSIS...........: ",ONC(165.5,IEN,3) D P Q:EX=U
 W !,"SPECIALTY MAKING DIAGNOSIS..........: ",ONC(165.5,IEN,334) D P Q:EX=U
 W !,"PRIMARY SITE (ICD-O-2)..............: ",TOPCOD," ",ONC(165.5,IEN,20)
 W !,"HISTOLOGY (ICD-O-2).................: ",ONC(165.5,IEN,22) D P Q:EX=U
 W !,"GRADE...............................: ",ONC(165.5,IEN,24)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR G III
 D P Q:EX=U
III S TABLE="TABLE III - EXTENT OF DISEASE AND AJCC STAGE"
 I IOST'?1"C".E W ! I ($Y'<(LIN-4)) D HDR
 W !?15,TABLE,! D P Q:EX=U
 W !,"STAGING PROCEDURES:",! D P Q:EX=U
 W !,"  ABDOMINAL ULTRASOUND: ",ONC(165.5,IEN,335),?36,"CT OTHER............: ",ONC(165.5,IEN,340) D P Q:EX=U
 W !,"  BONE IMAGING........: ",ONC(165.5,IEN,336),?36,"MRI PELVIS/ABDOMEN..: ",ONC(165.5,IEN,341) D P Q:EX=U
 W !,"  CHEST X-RAY.........: ",ONC(165.5,IEN,337),?36,"MRI OTHER...........: ",ONC(165.5,IEN,342) D P Q:EX=U
 W !,"  CT CHEST/LUNG.......: ",ONC(165.5,IEN,338),?36,"OTHER...............: ",ONC(165.5,IEN,343) D P Q:EX=U
 W !,"  CT ABDOMEN/PELVIS...: ",ONC(165.5,IEN,339) D P Q:EX=U
 W !!,"PRESENCE OF HYDRONEPHROSIS..........: ",ONC(165.5,IEN,344) D P Q:EX=U
 W !,"TUMOR SIZE (mm).....................: ",ONC(165.5,IEN,29) D P Q:EX=U
 W !,"PRESENCE OF MULTIPLE TUMORS.........: ",ONC(165.5,IEN,345) D P Q:EX=U
 W !,"REGIONAL NODES EXAMINED.............: ",ONC(165.5,IEN,33) D P Q:EX=U
 W !,"REGIONAL NODES POSITIVE.............: ",ONC(165.5,IEN,32)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR W !?15,TABLE_" (continued)"
SODM W !!,"SITE(S) OF DISTANT METASTASIS:",! D P Q:EX=U
 W !,"  SITE OF DISTANT METASTASIS #1.....: ",ONC(165.5,IEN,34) D P Q:EX=U
 W !,"  SITE OF DISTANT METASTASIS #2.....: ",ONC(165.5,IEN,34.1) D P Q:EX=U
 W !,"  SITE OF DISTANT METASTASIS #3.....: ",ONC(165.5,IEN,34.2) D P Q:EX=U
 W !!,"AJCC CLINICAL STAGE (cTNM):",! D P Q:EX=U
 W !,"  T-CODE............................: ",ONC(165.5,IEN,37.1) D P Q:EX=U
 W !,"  N-CODE............................: ",ONC(165.5,IEN,37.2) D P Q:EX=U
 W !,"  M-CODE............................: ",ONC(165.5,IEN,37.3) D P Q:EX=U
 W !,"  AJCC STAGE........................: ",ONC(165.5,IEN,38)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR W !?15,TABLE_" (continued)"
 W !!,"AJCC PATHOLOGIC STAGE (pTNM):",! D P Q:EX=U
 W !,"  T-CODE............................: ",ONC(165.5,IEN,85) D P Q:EX=U
 W !,"  N-CODE............................: ",ONC(165.5,IEN,86) D P Q:EX=U
 W !,"  M-CODE............................: ",ONC(165.5,IEN,87) D P Q:EX=U
 W !,"  AJCC STAGE........................: ",ONC(165.5,IEN,88) D P Q:EX=U
 W !!,"STAGED BY:" D P Q:EX=U
 W !!,"  CLINICAL STAGE....................: ",ONC(165.5,IEN,19) D P Q:EX=U
 W !,"  PATHOLOGIC STAGE..................: ",ONC(165.5,IEN,89)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR G IV
 D P Q:EX=U
IV D ^ONCBPC8A
KILL ;Kill Variables and Exit
 K ACCSEQ,CDS,CDSOT,CS,CSDAT,CSIEN,CSPNT,DLC,DOB,DOIT,FIL,LIN,LOS,NCDS
 K NCDSIEN,NCDSOT,ONC,ONDATE,PG,SURG,SURG1,SURG2,SURGDT,TABLE
 K %,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
P ;Print
 I ($Y'<(LIN-1)) D  Q:EX=U  W !?15,TABLE_" (continued)",!
 .I IOST?1"C".E K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .D HDR Q
 Q
TASK ;Queue a task
 K IO("Q"),ZTUCI,ZTDTH,ZTIO,ZTSAVE
 S ZTRTN="PRT^ONCBPC8",ZTREQ="@",ZTSAVE("ZTREQ")=""
 S ZTDESC="Print Bladder PCE"
 F V2=1:1 S V1=$P(ONCOLST,"^",V2) Q:V1=""  S ZTSAVE(V1)=""
 D ^%ZTLOAD D ^%ZISC U IO W !,"Request Queued",!
 K V1,V2,ONCOLST,ZTSK Q
HDR ;Header
 W @IOF S PG=PG+1 N BLANKS S $P(BLANKS," ",SITTAB-$L(PATNAM)-4)=" "
 W " ",PATNAM,BLANKS,SITEGP,!,?1,SSN,?TOPTAB-3,TOPNAM," ",TOPCOD
 W $S($L(PG)=2:" ",1:"  "),PG,!,DASHES
 W !," PCE Study of Cancers of the Urinary Bladder"
 W ?59,ONDATE,!,DASHES
 Q
