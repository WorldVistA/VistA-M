ONCCPC9 ;Hines OIFO/GWB - PCE Study of Colorectal Cancer ;05/30/00
 ;;2.11;ONCOLOGY;**11,16,24,26**;Mar 07, 1995
 ;Print
 K IOP,%ZIS S %ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP KILL
 I $D(IO("Q")) S ONCOLST="ONCONUM^ONCOPA^PATNAM^SPACES^TOPNAM^SSN^TOPTAB^TOPCOD^DASHES^SITTAB^SITEGP" D TASK G KILL
 U IO D PRT D ^%ZISC K %ZIS,IOP G KILL
PRT S PG=0,EX="",LIN=$S(IOST?1"C".E:IOSL-2,1:IOSL-6),IE=ONCONUM
 D NOW^%DTC S ONDATE=%,Y=ONDATE X ^DD("DD") S ONDATE=$P(Y,":",1,2)
 K DIQ S DIC="^ONCO(160,",DR="9;15",DA=ONCOPA,DIQ="ONC" D EN^DIQ1
 S DR=".04;.05;.06;.1;.12;1;1.1;3;9;18;20;22;24;26;29;32;33;37.1;37.2;37.3;38;19;50;51;53;53.2;58.1;58.2;58.3;59;70;71;81;82;85;86;87;88;89;302;307;308;361;377;421;430;437;441;563;700:799"
 S DIC="^ONCO(165.5,",DA=ONCONUM,DIQ="ONC" D EN^DIQ1
I S TABLE="TABLE I - GENERAL INFORMATION"
 D HDR
 W !," 1. INSTITUTION ID NUMBER............: H6",$$IIN^ONCFUNC D P Q:EX=U
 W !!?4,TABLE,!?4,"-----------------------------"
 S D0=ONCOPA D DOB1^ONCOES S Y=X D DATEOT^ONCOPCE S DOB=Y
 W !," 2. ACCESSION NUMBER.................: ",ONC(165.5,IE,.05) D P Q:EX=U
 W !," 3. SEQUENCE NUMBER..................: ",ONC(165.5,IE,.06) D P Q:EX=U
 W !," 4. POSTAL CODE AT DIAGNOSIS.........: ",ONC(165.5,IE,9) D P Q:EX=U
 W !," 5. DATE OF BIRTH....................: ",DOB D P Q:EX=U
 W !," 6. RACE.............................: ",ONC(165.5,IE,.12) D P Q:EX=U
 W !," 7. SPANISH ORIGIN...................: ",ONC(160,ONCOPA,9) D P Q:EX=U
 W !," 8. SEX..............................: ",ONC(165.5,IE,.1) D P Q:EX=U
 W !," 9. PRIMARY PAYER AT DIAGNOSIS.......: ",ONC(165.5,IE,18) D P Q:EX=U
 W !,"10. FAMILY HISTORY OF COLORECTAL CA..: ",ONC(165.5,IE,700)
 W !,"11. PERSONAL HISTORY OF COLORECTAL CA: ",ONC(165.5,IE,701)
 W !,"12. MULTI 1997 COLON/RECTUM PRIMARIES: ",ONC(165.5,IE,702)
 K LINE S $P(LINE,"-",41)="-"
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR W !?4,TABLE_" (continued)",!?4,LINE G PHNCC
 W ! D P Q:EX=U
PHNCC W !,"13. PERSONAL HISTORY OF NON-COLORECTAL CANCER:" D P Q:EX=U
 W !,"      BREAST...........: ",ONC(165.5,IE,703),?39,"PROSTATE.........: ",ONC(165.5,IE,307) D P Q:EX=U
 W !,"      CERVIX...........: ",ONC(165.5,IE,302),?39,"STOMACH..........: ",ONC(165.5,IE,707) D P Q:EX=U
 W !,"      LUNG.............: ",ONC(165.5,IE,704),?39,"THYROID..........: ",ONC(165.5,IE,708) D P Q:EX=U
 W !,"      OVARY............: ",ONC(165.5,IE,705),?39,"UTERUS...........: ",ONC(165.5,IE,709) D P Q:EX=U
 W !,"      OVARIAN CARCINOMA: ",ONC(165.5,IE,706),?39,"OTHER............: ",ONC(165.5,IE,308) D P Q:EX=U
 W ! D P Q:EX=U
 W !,"14. PREVIOUS TAH/BSO.................: ",ONC(165.5,IE,710) D P Q:EX=U
 W !!,"15. OTHER PRIOR CONDITIONS:" D P Q:EX=U
 W !,"      FAP..............: ",ONC(165.5,IE,711),?39,"PRIOR POLYPS.....: ",ONC(165.5,IE,714) D P Q:EX=U
 W !,"      HNPCC............: ",ONC(165.5,IE,712),?39,"POLYPS...........: ",ONC(165.5,IE,715) D P Q:EX=U
 W !,"      IBD..............: ",ONC(165.5,IE,713)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR G II
 D P Q:EX=U
II S TABLE="TABLE II - INITIAL DIAGNOSIS"
 I IOST'?1"C".E W ! I ($Y'<(LIN-4)) D HDR
 W !?4,TABLE,!?4,"----------------------------" D P Q:EX=U
 W !,"16. CLASS OF CASE....................: ",ONC(165.5,IE,.04) D P Q:EX=U
 W !!,"17. DURATION OF SIGNS/SYMPTOMS PRESENT AT INITIAL DIAGNOSIS (months):" D P Q:EX=U
 W !,"      ANEMIA.........................: ",ONC(165.5,IE,716) D P Q:EX=U
 W !,"      BOWEL OBSTRUCTION..............: ",ONC(165.5,IE,717) D P Q:EX=U
 W !,"      CHANGE IN BOWEL HABIT..........: ",ONC(165.5,IE,718) D P Q:EX=U
 W !,"      EMER PRESENTATION-OBSTRUCTION..: ",ONC(165.5,IE,719) D P Q:EX=U
 W !,"      JAUNDICE.......................: ",ONC(165.5,IE,720) D P Q:EX=U
 W !,"      MALAISE........................: ",ONC(165.5,IE,721) D P Q:EX=U
 W !,"      OCCULT BLOOD ONLY IN STOOL.....: ",ONC(165.5,IE,722) D P Q:EX=U
 W !,"      PAIN (ABDOMINAL)...............: ",ONC(165.5,IE,723) D P Q:EX=U
 W !,"      PAIN (PELVIC)..................: ",ONC(165.5,IE,724) D P Q:EX=U
 W !,"      RECTAL BLEEDING (MELENA).......: ",ONC(165.5,IE,725) D P Q:EX=U
 W !,"      OTHER..........................: ",ONC(165.5,IE,726)
 K LINE S $P(LINE,"-",40)="-"
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR W !?4,TABLE_" (continued)",!?4,LINE G IMD
 W ! D P Q:EX=U
IMD W !,"18. INITIAL METHODS OF DIAGNOSIS:" D P Q:EX=U
 W !,"      ENDOSCOPIC.....................: ",ONC(165.5,IE,727) D P Q:EX=U
 W !,"      RADIOGRAPHIC...................: ",ONC(165.5,IE,728) D P Q:EX=U
 W !,"      SCREENING DIGITAL RECTAL EXAM..: ",ONC(165.5,IE,729) D P Q:EX=U
 W !,"      SCREENING PHYSICAL EXAM........: ",ONC(165.5,IE,730) D P Q:EX=U
 W !,"      OTHER..........................: ",ONC(165.5,IE,731) D P Q:EX=U
 W !!,"19. REASON LEADING TO EVENTUAL DX....: ",ONC(165.5,IE,732) D P Q:EX=U
 W ! D P Q:EX=U
 W !,"20. DIAGNOSTIC EVALUATION:" D P Q:EX=U
 W !,"      BARIUM ENEMA, DOUBLE CONTRAST..: ",ONC(165.5,IE,733) D P Q:EX=U
 W !,"      BARIUM ENEMA, SINGLE CONTRAST..: ",ONC(165.5,IE,734) D P Q:EX=U
 W !,"      BARIUM ENEMA, NOS..............: ",ONC(165.5,IE,735) D P Q:EX=U
 W !,"      BIOPSY OF PRIMARY SITE.........: ",ONC(165.5,IE,736) D P Q:EX=U
 W !,"      BIOPSY OF METASTATIC SITE......: ",ONC(165.5,IE,737) D P Q:EX=U
 W !,"      CT SCAN OF CHEST...............: ",ONC(165.5,IE,421) D P Q:EX=U
 W !,"      CT SCAN OF LIVER...............: ",ONC(165.5,IE,738) D P Q:EX=U
 W !,"      CT SCAN OF PRIMARY SITE........: ",ONC(165.5,IE,739) D P Q:EX=U
 W !,"      CEA (PREOPERATIVE).............: ",ONC(165.5,IE,740) D P Q:EX=U
 W !,"      CHEST ROENTGENOGRAM............: ",ONC(165.5,IE,741) D P Q:EX=U
 W !,"      COLONOSCOPY....................: ",ONC(165.5,IE,742) D P Q:EX=U
 W !,"      DIGITAL RECTAL EXAM............: ",ONC(165.5,IE,743) D P Q:EX=U
 W !,"      FLEXIBLE SIGMOIDOSCOPY.........: ",ONC(165.5,IE,744) D P Q:EX=U
 W !,"      INTRAVENOUS PYELOGRAM..........: ",ONC(165.5,IE,745) D P Q:EX=U
 W !,"      SERUM-LIVER FUNCTION TEST......: ",ONC(165.5,IE,746) D P Q:EX=U
 W !,"      MRI............................: ",ONC(165.5,IE,747) D P Q:EX=U
 W !,"      PROCTOSCOPY (RIGID)............: ",ONC(165.5,IE,748) D P Q:EX=U
 W !,"      STOOL GUAIAC (OCCULT BLOOD)....: ",ONC(165.5,IE,749) D P Q:EX=U
 W !,"      ULTRASOUND, LIVER, ABDOMEN.....: ",ONC(165.5,IE,750) D P Q:EX=U
 W !,"      ULTRASOUND, ENDORECTAL.........: ",ONC(165.5,IE,751) D P Q:EX=U
 W !,"      OTHER..........................: ",ONC(165.5,IE,430)
 W ! D P Q:EX=U
 W !,"21. LEVEL OF TUMOR BY ENDOSCOPIC EXAM: ",ONC(165.5,IE,752) D P Q:EX=U
 W !,"22. LEVEL OF RECTAL TUMOR............: ",ONC(165.5,IE,753) D P Q:EX=U
 W !,"23. DATE OF INITIAL DIAGNOSIS........: ",ONC(165.5,IE,3) D P Q:EX=U
 W !,"24. PRIMARY SITE.....................: ",TOPCOD," ",ONC(165.5,IE,20)
 W !,"25. HISTOLOGY/26. BEHAVIOR CODE......: ",ONC(165.5,IE,22) D P Q:EX=U
 W !,"27. GRADE............................: ",ONC(165.5,IE,24) D P Q:EX=U
 W !,"28. DIAGNOSTIC CONFIRMATION..........: ",ONC(165.5,IE,26)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR G III
 D P Q:EX=U
III D ^ONCCPC9A
KILL ;
 K CDS,CDSOT,CS,CSDAT,CSIEN,CSPNT,DLC,DOB,DOIT,FIL,LIN,LOS,NCDS
 K NCDSIEN,NCDSOT,ONC,ONDATE,PG,SURG,SURG1,SURG2,SURGDT,TABLE
 K %,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,OSP,IIN
 Q
P ;Print
 I ($Y'<(LIN-1)) D  Q:EX=U  W !?4,TABLE_" (continued)",!?4,LINE
 .I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .D HDR Q
 Q
TASK ;Queue a task
 K IO("Q"),ZTUCI,ZTDTH,ZTIO,ZTSAVE
 S ZTRTN="PRT^ONCCPC9",ZTREQ="@",ZTSAVE("ZTREQ")=""
 S ZTDESC="Print Colorectal Cancer PCE"
 F V2=1:1 S V1=$P(ONCOLST,"^",V2) Q:V1=""  S ZTSAVE(V1)=""
 D ^%ZTLOAD D ^%ZISC U IO W !,"Request Queued",!
 K V1,V2,ONCOLST,ZTSK Q
HDR ;
 W @IOF S PG=PG+1 N BLANKS S $P(BLANKS," ",SITTAB-$L(PATNAM)-4)=" "
 W " ",PATNAM,BLANKS,SITEGP,!,?1,SSN,?TOPTAB-3,TOPNAM," ",TOPCOD
 W $S($L(PG)=2:" ",1:"  "),PG,!,DASHES
 W !?20," PCE Study of Colorectal Cancer"
 W ?62,ONDATE,!,DASHES
 Q
