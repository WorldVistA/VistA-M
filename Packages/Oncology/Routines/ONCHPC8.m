ONCHPC8 ;Hines OIFO/GWB - 2000 Hepatocellular Cancers PCE Study ;01/12/00
 ;;2.11;ONCOLOGY;**26**;Mar 07, 1995
 ;Print 
 K IOP,%ZIS S %ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP KILL
 I $D(IO("Q")) S ONCOLST="ONCONUM^ONCOPA^PATNAM^SPACES^TOPNAM^SSN^TOPTAB^TOPCOD^DASHES^SITTAB^SITEGP" D TASK G KILL
 U IO D PRT D ^%ZISC K %ZIS,IOP G KILL
PRT S EX="",LIN=$S(IOST?1"C".E:IOSL-2,1:IOSL-4),IE=ONCONUM
 D NOW^%DTC S ONDATE=%,Y=ONDATE X ^DD("DD") S ONDATE=$P(Y,":",1,2)
 S HIST=$P($G(^ONCO(165.5,ONCONUM,2)),U,3)
 K LINE S $P(LINE,"-",40)="-"
I S TABLE="PATIENT INFORMATION"
 D HEAD^ONCHPC0
 K LINE S $P(LINE,"-",19)="-"
 W !?4,TABLE,!?4,LINE
 S D0=ONCOPA D DOB1^ONCOES S Y=X D DATEOT^ONCOPCE S DOB=Y
 W !," 1. FACILITY ID NUMBER (FIN)....: ",$$IIN^ONCFUNC
 D P Q:EX=U
 W !," 2. ACCESSION NUMBER............: ",$$GET1^DIQ(165.5,IE,.05)
 D P Q:EX=U
 W !," 3. SEQUENCE NUMBER.............: ",$$GET1^DIQ(165.5,IE,.06)
 D P Q:EX=U
 W !," 4. POSTAL CODE AT DIAGNOIS.....: ",$$GET1^DIQ(165.5,IE,9)
 D P Q:EX=U
 W !," 5. PLACE OF BIRTH..............: ",$$GET1^DIQ(160,ONCOPA,7)
 D P Q:EX=U
 W !," 6. DATE OF BIRTH...............: ",DOB
 D P Q:EX=U
 W !," 7. RACE........................: ",$$GET1^DIQ(165.5,IE,.12)
 D P Q:EX=U
 W !," 8. SPANISH ORIGIN..............: ",$$GET1^DIQ(160,ONCOPA,9)
 D P Q:EX=U
 W !," 9. SEX.........................: ",$$GET1^DIQ(160,ONCOPA,10)
 D P Q:EX=U
 W !,"10. PRIMARY PAYER AT DIAGNOSIS..: ",$$GET1^DIQ(165.5,IE,18)
 D P Q:EX=U
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCHPC0 G II
 D P Q:EX=U
II S TABLE="TUMOR IDENTIFICATION"
 I IOST'?1"C".E W ! I ($Y'<(LIN-4)) D HEAD^ONCHPC0
 K LINE S $P(LINE,"-",20)="-"
 W !?4,TABLE,!?4,LINE
 D P Q:EX=U
 W !,"11. CLASS OF CASE...............: ",$$GET1^DIQ(165.5,IE,.04)
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !,"12. HORMONES:"
 D P Q:EX=U
 W !,"     ORAL CONTRACEPTIVES........: ",$$GET1^DIQ(165.5,IE,1000)
 D P Q:EX=U
 W !,"     ESTROGEN REPLACEMENT.......: ",$$GET1^DIQ(165.5,IE,1001)
 D P Q:EX=U
 W !,"     TAMOXIFEN..................: ",$$GET1^DIQ(165.5,IE,1002)
 D P Q:EX=U
 W !,"     OTHER......................: ",$$GET1^DIQ(165.5,IE,1003)
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !,"13. CONDITIONS PRESENT AT INITIAL DIAGNOSIS:"
 D P Q:EX=U
 W !,"     ASCITES....................: ",$$GET1^DIQ(165.5,IE,1004)
 D P Q:EX=U
 W !,"     CIRRHOSIS..................: ",$$GET1^DIQ(165.5,IE,1005)
 D P Q:EX=U
 W !,"     CHILD'S CLASS A............: ",$$GET1^DIQ(165.5,IE,1006)
 D P Q:EX=U
 W !,"     CHILD'S CLASS B............: ",$$GET1^DIQ(165.5,IE,1007)
 D P Q:EX=U
 W !,"     CHILD'S CLASS C............: ",$$GET1^DIQ(165.5,IE,1008)
 D P Q:EX=U
 W !,"     HEPATITIS B................: ",$$GET1^DIQ(165.5,IE,1009)
 D P Q:EX=U
 W !,"     HEPATITIS C................: ",$$GET1^DIQ(165.5,IE,1010)
 D P Q:EX=U
 W !,"     HEMOCHROMATOSIS............: ",$$GET1^DIQ(165.5,IE,1011)
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !,"14. ALCOHOL CONSUMPTION.........: ",$$GET1^DIQ(165.5,IE,1012)
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !,"15. TUMOR MARKERS:"
 D P Q:EX=U
 W !,"     AFP (IU/ml)................: ",$$GET1^DIQ(165.5,IE,1013)
 D P Q:EX=U
 W !,"     CEA (mg/ml)................: ",$$GET1^DIQ(165.5,IE,1014)
 D P Q:EX=U
 W !,"     CA 19.9 (U/ml).............: ",$$GET1^DIQ(165.5,IE,1015)
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !,"16. TESTS RELATED TO LIVER FUNCTION:"
 D P Q:EX=U
 W !,"     PROTIME (sec)..............: ",$$GET1^DIQ(165.5,IE,1016)
 D P Q:EX=U
 W !,"     BILIRUBIN (mg/ml)..........: ",$$GET1^DIQ(165.5,IE,1017)
 D P Q:EX=U
 W !,"     ALBUMIN (g/dl).............: ",$$GET1^DIQ(165.5,IE,1018)
 D P Q:EX=U
 W !,"     LDH (U/l)..................: ",$$GET1^DIQ(165.5,IE,1019)
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !,"17. RADIOLOGICAL EVALUATION"
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !,"    CT ARTERIAL PORTOGRAPHY:"
 D P Q:EX=U
 W !,"     PERFORMED..................: ",$$GET1^DIQ(165.5,IE,1020)
 D P Q:EX=U
 W !,"     CIRRHOSIS..................: ",$$GET1^DIQ(165.5,IE,1021)
 D P Q:EX=U
 W !,"     VASCULAR INVASTION.........: ",$$GET1^DIQ(165.5,IE,1022)
 D P Q:EX=U
 W !,"     BILOBAR DISEASE............: ",$$GET1^DIQ(165.5,IE,1023)
 D P Q:EX=U
 W !,"     LYMPH NODES................: ",$$GET1^DIQ(165.5,IE,1024)
 D P Q:EX=U
 W !,"     SIZE OF DOMINANT TUMOR (MM): ",$$GET1^DIQ(165.5,IE,1025)
 D P Q:EX=U
 W !,"     NUMBER OF TUMORS...........: ",$$GET1^DIQ(165.5,IE,1026)
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !,"    SPIRAL CT:"
 D P Q:EX=U
 W !,"     PERFORMED..................: ",$$GET1^DIQ(165.5,IE,1027)
 D P Q:EX=U
 W !,"     CIRRHOSIS..................: ",$$GET1^DIQ(165.5,IE,1028)
 D P Q:EX=U
 W !,"     VASCULAR INVASTION.........: ",$$GET1^DIQ(165.5,IE,1029)
 D P Q:EX=U
 W !,"     BILOBAR DISEASE............: ",$$GET1^DIQ(165.5,IE,1030)
 D P Q:EX=U
 W !,"     LYMPH NODES................: ",$$GET1^DIQ(165.5,IE,1031)
 D P Q:EX=U
 W !,"     SIZE OF DOMINANT TUMOR (MM): ",$$GET1^DIQ(165.5,IE,1032)
 D P Q:EX=U
 W !,"     NUMBER OF TUMORS...........: ",$$GET1^DIQ(165.5,IE,1033)
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !,"    INCREMENTAL CT:"
 D P Q:EX=U
 W !,"     PERFORMED..................: ",$$GET1^DIQ(165.5,IE,1034)
 D P Q:EX=U
 W !,"     CIRRHOSIS..................: ",$$GET1^DIQ(165.5,IE,1035)
 D P Q:EX=U
 W !,"     VASCULAR INVASTION.........: ",$$GET1^DIQ(165.5,IE,1036)
 D P Q:EX=U
 W !,"     BILOBAR DISEASE............: ",$$GET1^DIQ(165.5,IE,1037)
 D P Q:EX=U
 W !,"     LYMPH NODES................: ",$$GET1^DIQ(165.5,IE,1038)
 D P Q:EX=U
 W !,"     SIZE OF DOMINANT TUMOR (MM): ",$$GET1^DIQ(165.5,IE,1039)
 D P Q:EX=U
 W !,"     NUMBER OF TUMORS...........: ",$$GET1^DIQ(165.5,IE,1040)
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !,"    ULTRASOUND:"
  D P Q:EX=U
 W !,"     PERFORMED..................: ",$$GET1^DIQ(165.5,IE,1041)
 D P Q:EX=U
 W !,"     CIRRHOSIS..................: ",$$GET1^DIQ(165.5,IE,1042)
 D P Q:EX=U
 W !,"     VASCULAR INVASTION.........: ",$$GET1^DIQ(165.5,IE,1043)
 D P Q:EX=U
 W !,"     BILOBAR DISEASE............: ",$$GET1^DIQ(165.5,IE,1044)
 D P Q:EX=U
 W !,"     LYMPH NODES................: ",$$GET1^DIQ(165.5,IE,1045)
 D P Q:EX=U
 W !,"     SIZE OF DOMINANT TUMOR (MM): ",$$GET1^DIQ(165.5,IE,1046)
 D P Q:EX=U
 W !,"     NUMBER OF TUMORS...........: ",$$GET1^DIQ(165.5,IE,1047)
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !,"    MRI:"
 D P Q:EX=U
 W !,"     PERFORMED..................: ",$$GET1^DIQ(165.5,IE,1048)
 D P Q:EX=U
 W !,"     CIRRHOSIS..................: ",$$GET1^DIQ(165.5,IE,1049)
 D P Q:EX=U
 W !,"     VASCULAR INVASTION.........: ",$$GET1^DIQ(165.5,IE,1050)
 D P Q:EX=U
 W !,"     BILOBAR DISEASE............: ",$$GET1^DIQ(165.5,IE,1051)
 D P Q:EX=U
 W !,"     LYMPH NODES................: ",$$GET1^DIQ(165.5,IE,1052)
 D P Q:EX=U
 W !,"     SIZE OF DOMINANT TUMOR (MM): ",$$GET1^DIQ(165.5,IE,1053)
 D P Q:EX=U
 W !,"     NUMBER OF TUMORS...........: ",$$GET1^DIQ(165.5,IE,1054)
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !,"18. DEFINITIVE DIAGNOSIS........: ",$$GET1^DIQ(165.5,IE,1055)
 D P Q:EX=U
 W !,"19. DATE OF INITIAL DIAGNOSIS...: ",$$GET1^DIQ(165.5,IE,3)
 D P Q:EX=U
 W !,"20. HISTOLOGY (ICD-O-2).........: ",$E(HIST,1,4)
 D P Q:EX=U
 W !,"21. GRADE.......................: ",$$GET1^DIQ(165.5,IE,24)
 D P Q:EX=U
 W !,"22. DIAGNOSTIC CONFIRMATION.....: ",$$GET1^DIQ(165.5,IE,26)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR G:'Y KILL
III D HEAD^ONCHPC0,^ONCHPC8A
KILL ;
 K CS,CSDAT,CSI,CSPNT,DESC,DESC1,DESC2,DLC,DOB,DOFCT
 K EX,HIST,IE,LIN,LINE,LOS,NOP,ONDATE,ONCOLST,TABLE
 K %,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
P ;Print
 I ($Y'<(LIN-1)) D  Q:EX=U  W !?4,TABLE_" (continued)",!?4,LINE_"------------"
 .I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .D HEAD^ONCHPC0 Q
 Q
TASK ;Queue a task
 K IO("Q"),ZTUCI,ZTDTH,ZTIO,ZTSAVE
 S ZTRTN="PRT^ONCHPC8",ZTREQ="@",ZTSAVE("ZTREQ")=""
 S ZTDESC="Print Hepatocellular Cancer PCE"
 F V2=1:1 S V1=$P(ONCOLST,"^",V2) Q:V1=""  S ZTSAVE(V1)=""
 D ^%ZTLOAD D ^%ZISC U IO W !,"Request Queued",!
 K V1,V2,ONCOLST,ZTSK Q
