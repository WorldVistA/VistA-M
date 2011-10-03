ONCPPC9 ;Hines OIFO/GWB - PCE Studies of Prostate Cancer ;05/30/00
 ;;2.11;ONCOLOGY;**6,16,24,26**;Mar 07, 1995
 ;Print
 K IOP,%ZIS S %ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP KILL
 I $D(IO("Q")) S ONCOLST="ONCONUM^ONCOPA^PATNAM^SPACES^TOPNAM^SSN^TOPCOD^DASHES^TOPTAB^DATEDX^SITTAB^SITEGP" D TASK G KILL
 U IO D PRT D ^%ZISC K %ZIS,IOP G KILL
PRT S PG=0,EX="",LIN=$S(IOST?1"C".E:IOSL-2,1:IOSL-6)
 D NOW^%DTC S ONDATE=%,Y=ONDATE X ^DD("DD") S ONDATE=Y
I S TABLE="TABLE I - GENERAL INFORMATION"
 D HDR W !?25,TABLE,! D P Q:EX=U
 S PRINODE0=^ONCO(165.5,ONCONUM,0)
 S ACCSEQ=$P(PRINODE0,U,5)_"/"_$P(PRINODE0,U,6)
 S COCIN=$P(PRINODE0,U,4),Y=COCIN,C=$P(^DD(165.5,.04,0),U,2) D Y^DIQ
 S COCEX=Y,IEN=ONCONUM
 S D0=ONCOPA D DOB1^ONCOES S Y=X D DATEOT^ONCOPCE S DOB=Y
 S DIC="^ONCO(160,",DR="15;22.9",DA=ONCOPA,DIQ="ONC" D EN^DIQ1
 S DIC="^ONCO(165.5,",DR="1;.12;1.1;9;18;19;22;24;37.1;37.2;37.3;38;50;51;54;58.1;58.2;58.3;58;70;71;74;81;82;85;86;87;88;89;600:656"
 S DA=ONCONUM,DIQ="ONC" D EN^DIQ1
 W !,"ACCESSION/SEQUENCE NUMBER..........: ",ACCSEQ D P Q:EX=U
 W !,"CLASS OF CASE......................: ",COCEX D P Q:EX=U
 W !,"ZIP CODE...........................: ",ONC(165.5,IEN,9) D P Q:EX=U
 W !,"BIRTHDATE..........................: ",DOB D P Q:EX=U
 W !,"RACE...............................: ",ONC(165.5,IEN,.12) D P Q:EX=U
 W !,"PRIMARY PAYER AT DIAGNOSIS.........: ",ONC(165.5,IEN,18) D P Q:EX=U
 W !,"DATE OF ADMISSION..................: ",ONC(165.5,IEN,1) D P Q:EX=U
 W !,"DATE OF DISCHARGE..................: ",ONC(165.5,IEN,1.1)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR G II
 S EOT="Y" D P Q:EX=U
II S TABLE="TABLE II - INITIAL DIAGNOSIS"
 I IOST'?1"C".E W ! D P Q:EX=U  W ! D P Q:EX=U
 W !?25,TABLE D P Q:EX=U
 W !,"METHOD OF DIAGNOSIS:",! D P Q:EX=U
 W !,"  CLINICAL DX WITH BONE LESION.....: ",ONC(165.5,IEN,600) D P Q:EX=U
 W !,"  CLINICAL DX BY RECTAL EXAM.......: ",ONC(165.5,IEN,601) D P Q:EX=U
 W !,"  CYTOLOGY.........................: ",ONC(165.5,IEN,602) D P Q:EX=U
 W !,"  INCIDENTAL FINDING IN TURP.......: ",ONC(165.5,IEN,603) D P Q:EX=U
 W !,"  NEEDLE ASPIRATION BIOPSY.........: ",ONC(165.5,IEN,604) D P Q:EX=U
 W !,"  NEEDLE BIOPSY, NOS...............: ",ONC(165.5,IEN,605) D P Q:EX=U
 W !,"  PERINEAL BIOPSY..................: ",ONC(165.5,IEN,606) D P Q:EX=U
 W !,"  TRANSRECTAL BIOPSY...............: ",ONC(165.5,IEN,607) D P Q:EX=U
 W !,"  TRUS GUIDED BIOPSY...............: ",ONC(165.5,IEN,608) D P Q:EX=U
 W !,"  TRANSURETHRAL RESECTION, NOS.....: ",ONC(165.5,IEN,609) D P Q:EX=U
 W !,"  OTHER............................: ",ONC(165.5,IEN,610) D P Q:EX=U
 S DOID=$E(DATEDX,4,5)_"/"_$E(DATEDX,6,7)_"/"_(1700+$E(DATEDX,1,3))
 W !!,"DATE OF INITIAL DIAGNOSIS..........: ",DOID
 I IOST?1"C".E K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR W !?15,TABLE_" (continued)" G DI
 D P Q:EX=U
DI W !!,"DIAGNOSTIC INFORMATION:" D P Q:EX=U
 W !,"  BONE MARROW ASPIRATION...........: ",ONC(165.5,IEN,611) D P Q:EX=U
 W !,"  BONE SCAN........................: ",ONC(165.5,IEN,612) D P Q:EX=U
 W !,"  BONE X-RAY.......................: ",ONC(165.5,IEN,613) D P Q:EX=U
 W !,"  CHEST X-RAY......................: ",ONC(165.5,IEN,614) D P Q:EX=U
 W !,"  CT SCAN OF PRIMARY SITE..........: ",ONC(165.5,IEN,615) D P Q:EX=U
 W !,"  IVP..............................: ",ONC(165.5,IEN,616) D P Q:EX=U
 W !,"  LIVER SCAN.......................: ",ONC(165.5,IEN,617) D P Q:EX=U
 W !,"  MRI..............................: ",ONC(165.5,IEN,618) D P Q:EX=U
 W !,"  PELVIC LYMPH NODE DISSECTION.....: ",ONC(165.5,IEN,619) D P Q:EX=U
 W !,"  PAP..............................: ",ONC(165.5,IEN,620) D P Q:EX=U
 W !,"  PSA..............................: ",ONC(165.5,IEN,621) D P Q:EX=U
 W !,"  OTHER............................: ",ONC(165.5,IEN,622) D P Q:EX=U
 W ! D P Q:EX=U
 W !,"HISTOLOGY (ICD-O)..................: ",ONC(165.5,IEN,22) D P Q:EX=U
 W !,"DIFFERENTIATION/GRADE..............: ",ONC(165.5,IEN,24) D P Q:EX=U
 W !,"GLEASON'S SCORE....................: ",ONC(165.5,IEN,623)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR G III
 S EOT="Y" D P Q:EX=U
III S TABLE="TABLE III - STAGE OF DISEASE"
 I IOST'?1"C".E W ! D:($Y'<(LIN-1)) HDR W ! D:($Y'<(LIN-1)) HDR
 W !?25,TABLE,! D P Q:EX=U
AJCCCS W !,"AJCC CLINICAL STAGE (cTNM):",! D P Q:EX=U
 W !,"  T-CODE........................: ",ONC(165.5,IEN,37.1) D P Q:EX=U
 W !,"  N-CODE........................: ",ONC(165.5,IEN,37.2) D P Q:EX=U
 W !,"  M-CODE........................: ",ONC(165.5,IEN,37.3) D P Q:EX=U
 W !,"  AJCC STAGE....................: ",ONC(165.5,IEN,38) D P Q:EX=U
AJCCPS W !!,"AJCC PATHOLOGIC STAGE (pTNM):",! D P Q:EX=U
 W !,"  T-CODE........................: ",ONC(165.5,IEN,85) D P Q:EX=U
 W !,"  N-CODE........................: ",ONC(165.5,IEN,86) D P Q:EX=U
 W !,"  M-CODE........................: ",ONC(165.5,IEN,87) D P Q:EX=U
 W !,"  AJCC STAGE....................: ",ONC(165.5,IEN,88)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR W !?15,TABLE_" (continued)" G SB
 D P Q:EX=U
SB W !!,"STAGED BY:",! D P Q:EX=U
 W !,"CLINICAL STAGE..................: ",ONC(165.5,IEN,19) D P Q:EX=U
 W !,"PATHOLOGIC STAGE.................: ",ONC(165.5,IEN,89)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR G IV
 S EOT="Y" D P Q:EX=U
IV D ^ONCPPC9A
 G KILL
KILL ;Kill Variables and Exit
 K %,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FILN,ONCOBL,EX,TXT,X,Y,EOT
 Q
P ;Display Data
 I ($Y'<(LIN-1)) D  Q:EX=U  W:EOT="N" !?15,TABLE_" (continued)",!
 .I IOST?1"C".E K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .D HDR Q
 S EOT="N" Q
TASK ;Queue a task
 K IO("Q"),ZTUCI,ZTDTH,ZTIO,ZTSAVE
 S ZTRTN="PRT^ONCPPC9",ZTREQ="@",ZTSAVE("ZTREQ")=""
 S ZTDESC="Print Prostate PCE Data."
 F V3=1:1 S V1=$P(ONCOLST,"^",V3) Q:V1=""  S ZTSAVE(V1)=""
 D ^%ZTLOAD D ^%ZISC U IO W !,"Request Queued",!
 K V1,V3,ONCOLST,ZTSK Q
HDR ;Header
 W @IOF S PG=PG+1 N BLANKS S $P(BLANKS," ",SITTAB-$L(PATNAM)-4)=" "
 W " ",PATNAM,BLANKS,SITEGP,!,?1,SSN,?TOPTAB-3,TOPNAM," ",TOPCOD
 W $S($L(PG)=2:" ",1:"  "),PG,!,DASHES
 W !?20,"PCE Studies of Cancer of the Prostate"
 W ?59,ONDATE,!,DASHES
 Q
