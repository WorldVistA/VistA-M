ONCP2P8 ;Hines OIFO/GWB - 1998 Prostate Cancer Study ;05/30/00
 ;;2.11;ONCOLOGY;**18,24,26**;Mar 07, 1995
 ;Print
 K IOP,%ZIS S %ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP KILL
 I $D(IO("Q")) S ONCOLST="ONCONUM^ONCOPA^PATNAM^SPACES^TOPNAM^SSN^TOPTAB^TOPCOD^DASHES^SITTAB^SITEGP" D TASK G KILL
 U IO D PRT D ^%ZISC K %ZIS,IOP G KILL
PRT S PG=0,EX="",LIN=$S(IOST?1"C".E:IOSL-2,1:IOSL-4),IE=ONCONUM
 D NOW^%DTC S ONDATE=%,Y=ONDATE X ^DD("DD") S ONDATE=$P(Y,":",1,2)
 K DIQ S DIC="^ONCO(160,",DR="9;15",DA=ONCOPA,DIQ="ONC" D EN^DIQ1
 S DR=".04;.05;.06;.12;1;3;9;18;19;20;23;24;26;29;32;33;37.1;37.2;37.3;38;50;51;51.2;53;53.2;54;54.2;58.1;58.2;58.3;59;70;71;74;81;82;85;86;87;88;89;138:142;145;146;307;441;623:699;699.1"
 S DIC="^ONCO(165.5,",DA=ONCONUM,DIQ="ONC" D EN^DIQ1
 S HIST=$P($G(^ONCO(165.5,ONCONUM,2)),U,3)
 K LINE S $P(LINE,"-",40)="-"
I S TABLE="TABLE I - GENERAL INFORMATION"
 D HEAD^ONCP2P0
 W !," 1. INSTITUTION ID NUMBER............: H6",$$IIN^ONCFUNC D P Q:EX=U
 W !!?4,TABLE,!?4,"-----------------------------"
 S D0=ONCOPA D DOB1^ONCOES S Y=X D DATEOT^ONCOPCE S DOB=Y
 W !," 2. ACCESSION NUMBER.................: ",ONC(165.5,IE,.05) D P Q:EX=U
 W !," 3. SEQUENCE NUMBER..................: ",ONC(165.5,IE,.06) D P Q:EX=U
 W !," 4. POSTAL CODE AT DIAGNOSIS.........: ",ONC(165.5,IE,9) D P Q:EX=U
 W !," 5. DATE OF BIRTH....................: ",DOB D P Q:EX=U
 W !," 6. RACE.............................: ",ONC(165.5,IE,.12) D P Q:EX=U
 W !," 7. SPANISH ORIGIN...................: ",ONC(160,ONCOPA,9) D P Q:EX=U
 W !," 8. PRIMARY PAYER AT DIAGNOSIS.......: ",ONC(165.5,IE,18) D P Q:EX=U
 W !," 9. FAMILY HISTORY OF PROSTATE CANCER: ",ONC(165.5,IE,657)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCP2P0 G II
 D P Q:EX=U
II S TABLE="TABLE II - INITIAL DIAGNOSIS"
 I IOST'?1"C".E W ! I ($Y'<(LIN-4)) D HEAD^ONCP2P0
 W !?4,TABLE,!?4,"----------------------------" D P Q:EX=U
 W !,"10. CLASS OF CASE....................: ",ONC(165.5,IE,.04) D P Q:EX=U
 W !!,"11. SYMPTOMS PRESENT AT INITIAL DIAGNOSIS:" D P Q:EX=U
 W !,"     HEMATURIA.......................: ",ONC(165.5,IE,658) D P Q:EX=U
 W !,"     LOWER BACK PAIN.................: ",ONC(165.5,IE,659) D P Q:EX=U
 W !,"     TROUBLE URINATING...............: ",ONC(165.5,IE,660) D P Q:EX=U
 K LINE S $P(LINE,"-",40)="-"
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCP2P0 W !?4,TABLE_" (continued)",!?4,LINE G IMD
 E  W ! D P Q:EX=U
IMD W !,"12. INITIAL METHODS OF DIAGNOSIS:" D P Q:EX=U
 W !,"     CLINICAL DX W BONE LESION.......: ",ONC(165.5,IE,661) D P Q:EX=U
 W !,"     CLINICAL DX BY RECTAL EXAM......: ",ONC(165.5,IE,662) D P Q:EX=U
 W !,"     CYTOLOGY........................: ",ONC(165.5,IE,663) D P Q:EX=U
 W !,"     DIGITAL TRANSRECTAL BIOPSY......: ",ONC(165.5,IE,664) D P Q:EX=U
 W !,"     INCIDENTAL FINDING IN TURP FOR                                                  BENIGN DISEASE..................: ",ONC(165.5,IE,665) D P Q:EX=U
 W !,"     NEEDLE BIOPSY, NOS..............: ",ONC(165.5,IE,666) D P Q:EX=U
 W !,"     PERINEAL BIOPSY.................: ",ONC(165.5,IE,667) D P Q:EX=U
 W !,"     PSA.............................: ",ONC(165.5,IE,668) D P Q:EX=U
 W !,"     TRUS GUIDED BIOPSY..............: ",ONC(165.5,IE,669) D P Q:EX=U
 W !,"     TURP, NOS.......................: ",ONC(165.5,IE,670) D P Q:EX=U
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCP2P0 W !?4,TABLE_" (continued)",!?4,LINE G DE
 W ! D P Q:EX=U
DE W !,"13. DIAGNOSTIC EVALUATION:" D P Q:EX=U
 W !,"     BONE MARROW ASPIRATION..........: ",ONC(165.5,IE,671) D P Q:EX=U
 W !,"     BONE SCAN.......................: ",ONC(165.5,IE,672) D P Q:EX=U
 W !,"     BONE X-RAY......................: ",ONC(165.5,IE,673) D P Q:EX=U
 W !,"     CHEST X-RAY.....................: ",ONC(165.5,IE,674) D P Q:EX=U
 W !,"     CT SCAN OF ABDOMEN..............: ",ONC(165.5,IE,675) D P Q:EX=U
 W !,"     CT SCAN OF PELVIS...............: ",ONC(165.5,IE,676) D P Q:EX=U
 W !,"     IVP.............................: ",ONC(165.5,IE,677) D P Q:EX=U
 W !,"     MRI.............................: ",ONC(165.5,IE,678) D P Q:EX=U
 W !,"     PELVIC LYMPH NODE DISSECTION....: ",ONC(165.5,IE,679) D P Q:EX=U
 W !,"     PCR.............................: ",ONC(165.5,IE,680) D P Q:EX=U
 W !,"     PAP.............................: ",ONC(165.5,IE,681) D P Q:EX=U
 W !,"     PSA.............................: ",ONC(165.5,IE,682) D P Q:EX=U
 W !,"     ULTRASOUND OF ABDOMEN...........: ",ONC(165.5,IE,683)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCP2P0 W !?4,TABLE_" (continued)",!?4,LINE G PSA
 E  W ! D P Q:EX=U
PSA W !,"14. RESULTS OF MOST RECENT PRE-"
 W !,"    TREATMENT PSA TEST...............: ",ONC(165.5,IE,684) D P Q:EX=U
 W !,"15. DATE OF INITIAL DIAGNOSIS........: ",ONC(165.5,IE,3) D P Q:EX=U
 W !,"16. PRIMARY SITE (ICD-O-2)...........: ",TOPCOD," ",ONC(165.5,IE,20)
 W !,"17. HISTOLOGY (ICD-O-2)..............: ",$E(HIST,1,4) D P Q:EX=U
 W !,"18. BEHAVIOR CODE (ICD-O-2)..........: ",$E(HIST,5) D P Q:EX=U
 W !,"19. GRADE............................: ",ONC(165.5,IE,24) D P Q:EX=U
 W !,"20. BIOPSY PROCEDURE.................: ",ONC(165.5,IE,141)
 W !,"21. GUIDANCE OF BIOPSY TO PRIMARY....: ",ONC(165.5,IE,142)
 W !,"22. BIOPSY APPROACH FOR PRIMARY......: ",ONC(165.5,IE,145)
 W !,"23. BIOPSY OF OTHER THAN PRIMARY.....: ",ONC(165.5,IE,146)
 W !,"24. DIAGNOSTIC CONFIRMATION..........: ",ONC(165.5,IE,26)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCP2P0 W !?4,TABLE_" (continued)",!?4,LINE G GS
 E  W ! D P Q:EX=U
GS W !,"25. GLEASON'S SCORE FOR BIOPSY, LOCAL RESECTION, OR SIMPLE PROSTATECTOMY:" D P Q:EX=U
 W !,"     PREDOMINANT (PRIMARY) PATTERN...: ",ONC(165.5,IE,623.1) D P Q:EX=U
 W !,"     LESSER (SECONDARY) PATTERN......: ",ONC(165.5,IE,623.2) D P Q:EX=U
 W !,"     GLEASON SCORE...................: ",ONC(165.5,IE,623) D P Q:EX=U
 W ! D P Q:EX=U
 W !,"26. GLEASON'S SCORE FOR RADICAL PROSTATECTOMY:" D P Q:EX=U
 W !,"     PREDOMINANT (PRIMARY) PATTERN...: ",ONC(165.5,IE,623.4) D P Q:EX=U
 W !,"     LESSER (SECONDARY) PATTERN......: ",ONC(165.5,IE,623.5) D P Q:EX=U
 W !,"     GLEASON SCORE...................: ",ONC(165.5,IE,623.3) D P Q:EX=U
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCP2P0 G III
 D P Q:EX=U
III D ^ONCP2P8A
KILL ;Kill Variables and Exit
 K CDS,CDSOT,CS,CSDAT,CSIEN,CSPNT,DLC,DOB,DOIT,FIL,LIN,LOS,NCDS,HIST
 K NCDSIEN,NCDSOT,ONC,ONDATE,PG,SURG,SURG1,SURG2,SURGDT,TABLE
 K %,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,OSP,IIN
 Q
P ;Print
 I ($Y'<(LIN-1)) D  Q:EX=U  W !?4,TABLE_" (continued)",!?4,LINE
 .I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .D HEAD^ONCP2P0 Q
 Q
TASK ;Queue a task
 K IO("Q"),ZTUCI,ZTDTH,ZTIO,ZTSAVE
 S ZTRTN="PRT^ONCP2P8",ZTREQ="@",ZTSAVE("ZTREQ")=""
 S ZTDESC="Print Colorectal Cancer PCE"
 F V2=1:1 S V1=$P(ONCOLST,"^",V2) Q:V1=""  S ZTSAVE(V1)=""
 D ^%ZTLOAD D ^%ZISC U IO W !,"Request Queued",!
 K V1,V2,ONCOLST,ZTSK Q
HDR ;Header
 W @IOF S PG=PG+1 N BLANKS S $P(BLANKS," ",SITTAB-$L(PATNAM)-4)=" "
 W !," ",PATNAM,BLANKS,SITEGP,!,?1,SSN,?TOPTAB-3,TOPNAM," ",TOPCOD
 W $S($L(PG)=2:" ",1:"  "),PG,!,DASHES
 W !," 1998 Patient Care Evaluation Study of Prostate Cancer"
 W ?62,ONDATE,!,DASHES
 Q
