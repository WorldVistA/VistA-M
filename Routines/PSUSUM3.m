PSUSUM3 ;BIR/DAM - Patient Demographics Summary for UD Extract ; 20 DEC 2001
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;DBIA's
 ; Reference to file #55 supported by DBIA 3502
 ; Reference to file #42 supported by DBIA 1848
 ; Reference to file #40.8 supported by DBIA 1576
 ;
EN ;EN CALLED FROM PSUUD0
 ;Q:$D(^XTMP("PSU_"_PSUJOB,"PSUMFLAG"))   ;Do not run if auto extract
 ;
 D PULL^PSUCP
 F I=1:1:$L(PSUOPTS,",") S PSUMOD($P(PSUOPTS,",",I))=""
 ;
 I $D(^XTMP("PSU_"_PSUJOB,"PSUNONE","UD")) D  Q    ;report if there is no data
 .I $D(PSUMOD(2))&'$D(PSUMOD(1)) D
 ..I '$D(PSUMOD(4)) D
 ...D NODATA D
 ....I $D(^XTMP("PSU_"_PSUJOB,"PSUFLAG1")) K ^XTMP("PSU_"_PSUJOB,"PSUNONE")
 ....K ^XTMP("PSU_"_PSUJOB,"PSUSUMA")
 D EN1
 Q
 ;
EN1 ;Entry point to collect data
 D DATE
 M ^XTMP("PSU_"_PSUJOB,"PSUUD")=^XTMP(PSUUDSUB)
 D RE
 D UNIQUE
 S I=9        ;Line counter for division data in summary report
 D DIVNUM
 D TOTAL
 D TAB1
 ;
 I $D(PSUMOD(1))&$D(PSUMOD(2)) D
 .I $D(PSUMOD(4)) D
 ..M ^XTMP("PSU_"_PSUJOB,"PSUUDDIV")=^XTMP("PSU_"_PSUJOB,"PSUCT")
 ..M ^XTMP("PSU_"_PSUJOB,"PSUUDSSN")=^XTMP("PSU_"_PSUJOB,"PSUIPT")
 ..M ^XTMP("PSU_"_PSUJOB,"PSUDIVUD")=^XTMP("PSU_"_PSUJOB,"PSUDIV")
 ;
 I '$D(PSUMOD(1))&$D(PSUMOD(2)) D
 .I $D(PSUMOD(4)) D
 ..M ^XTMP("PSU_"_PSUJOB,"PSUUDDIV")=^XTMP("PSU_"_PSUJOB,"PSUCT")
 ..M ^XTMP("PSU_"_PSUJOB,"PSUUDSSN")=^XTMP("PSU_"_PSUJOB,"PSUIPT")
 ;
 I $D(PSUMOD(1))&$D(PSUMOD(2)) D
 .I '$D(PSUMOD(4)) D
 ..M ^XTMP("PSU_"_PSUJOB,"PSUUDDIV")=^XTMP("PSU_"_PSUJOB,"PSUCT")
 ..M ^XTMP("PSU_"_PSUJOB,"PSUUDIN")=^XTMP("PSU_"_PSUJOB,"PSUIPT")
 ..M ^XTMP("PSU_"_PSUJOB,"PSUDIVUD")=^XTMP("PSU_"_PSUJOB,"PSUDIV")
 ;
 I '$D(PSUMOD(1))&'$D(PSUMOD(4)) D
 .D PDSUM^PSUDEM5     ;Mail message
 .K ^XTMP("PSU_"_PSUJOB,"PSUUDDIV")
 K ^XTMP("PSU_"_PSUJOB,"PSUUD")
 I $D(^XTMP("PSU_"_PSUJOB,"PSUFLAG1")) K ^XTMP("PSU_"_PSUJOB,"PSUSUMA")
 K ^XTMP("PSU_"_PSUJOB,"PSUFLAG1")
 ;K ^XTMP("PSU_"_PSUJOB,"PSUTOTAL")
 K ^XTMP("PSU_"_PSUJOB,"PSUCT")
 K ^XTMP("PSU_"_PSUJOB,"PSURXCTA")
 Q
 ;
RE ;Rearrange the ^XTMP("PSU_"_PSUJOB,"PSUUD","DETAIL" global so information in PATDIV
 ;can be accessed quickly.
 ;
 N PSUSIT
 S PSUSIT=PSUSNDR
 ;D INST^PSUDEM1 S PSUSIT=$P(^XTMP("PSU_"_PSUJOB,"PSUSITE"),U,1)
 ;
 N PSUSSNA,PSUUDA
 S PSUPN1=0,PSUSIT1=0
 F  S PSUSIT1=$O(^XTMP("PSU_"_PSUJOB,"PSUUD","DETAIL",PSUSIT1)) Q:PSUSIT1=""  D
 .F  S PSUPN1=$O(^XTMP("PSU_"_PSUJOB,"PSUUD","DETAIL",PSUSIT1,PSUPN1)) Q:PSUPN1=""  D
 ..S PSUUDA=$P($G(^XTMP("PSU_"_PSUJOB,"PSUUD","DETAIL",PSUSIT1,PSUPN1)),U,4)
 ..S PSUSSNA=$P($G(^XTMP("PSU_"_PSUJOB,"PSUUD","DETAIL",PSUSIT1,PSUPN1)),U,5) D
 ...S PSUDFN=0
 ...F  S PSUDFN=$O(^XTMP("PSU_"_PSUJOB,"PSUTDFN",PSUDFN)) Q:PSUDFN=""  D
 ....S PSUSN=0
 ....F  S PSUSN=$O(^XTMP("PSU_"_PSUJOB,"PSUTDFN",PSUDFN,PSUSN)) Q:PSUSN=""  D
 .....I PSUSN=PSUSSNA S ^XTMP("PSU_"_PSUJOB,"PSUORSN1",PSUDFN,PSUUDA)=PSUSN
 .....;S ^XTMP("PSU_"_PSUJOB,"PSUORSN",PSUUDA)=PSUSSNA
 Q
 ;
DATE ;Convert date range of extract to external format
 ;
 S %H=$E($H,1,5)    ;today's date
 D YX^%DTC
 N PSUD S PSUD=Y
 ;
 S Y=PSUSDT         ;Start date of extract
 D DD^%DT
 N PSUS S PSUS=Y
 ;
 S Y=PSUEDT         ;End date of extract
 D DD^%DT
 N PSUE S PSUE=Y
 ;
 D UDSUM
 Q
 ;
UDSUM ;Summary report header to be run if UD (Inpatient) extract is  run
 ;
 ;Report header
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",1)="PHARMACY INPATIENT (UD) UNIQUE PATIENTS REPORT               "_PSUD
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",2),"-",80)=""                ;Separator bar
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",3)="                 "_PSUS_"  through  "_PSUE
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",4),"=",80)=""
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",5)="                                                           UNIQUE"
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",6),"-",70)=""
 Q
 ;
UNIQUE ;Find number of unique patients across all divisions
 ;
 S PSUUDS=0
 N PSUUDS3
 F  S PSUUDS=$O(^XTMP("PSU_"_PSUJOB,"PSUORSN1",PSUUDS)) Q:PSUUDS=""  D
 .S PSUUDS1=0
 .S PSUUDS1=$O(^XTMP("PSU_"_PSUJOB,"PSUORSN1",PSUUDS,PSUUDS1)) Q:PSUUDS1=""  D
 ..S PSUUDS3=$P($G(^XTMP("PSU_"_PSUJOB,"PSUORSN1",PSUUDS,PSUUDS1)),U,1)
 ..S ^XTMP("PSU_"_PSUJOB,"PSUIPT",PSUUDS3)=""     ;Set up global for unique SSNs
 .;S PSUUDS1=$P(^XTMP("PSU_"_PSUJOB,"PSUORSN",PSUUDS),U)
 .;S ^XTMP("PSU_"_PSUJOB,"PSUIPT",PSUUDS1)=""     ;Set up global for unique SSNs
 ;
 S B=1
 S PSUUDS2=0
 F  S PSUUDS2=$O(^XTMP("PSU_"_PSUJOB,"PSUIPT",PSUUDS2)) Q:PSUUDS2=""  D
 .S ^XTMP("PSU_"_PSUJOB,"PSUIPT")=B,B=B+1       ;B=total count unique patients
 .D TAB2
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",8),"-",70)=""
 Q
 ;
TAB2 ;Tab spacing for line 7.  Set line into global
 ;
 N PSUTB3,PSUTB4,PSUTB5
 ;
 S PSUTB3=" "
 S PSUTB4="TOTAL patients across all divisions:"
 S PSUTB5=(64-$L(PSUTB4))-$L($P($G(^XTMP("PSU_"_PSUJOB,"PSUIPT")),U,1))
 F S3=1:1:(PSUTB5-1) S PSUTB(S3)=" " D
 .S PSUTB3=PSUTB3_PSUTB(S3)
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",7)=PSUTB4_PSUTB3_$P($G(^XTMP("PSU_"_PSUJOB,"PSUIPT")),U,1)
 Q
 ;
DIVNUM ;Set number of patients per division into summary message
 ;
 N PSUTB1,PSUTB2
 ;
 N PSUCT3
 S PSUDIVA2=0
 F  S PSUDIVA2=$O(^XTMP("PSU_"_PSUJOB,"PSUCT",PSUDIVA2)) Q:PSUDIVA2=""  D
 .S PSUCT3=$P($G(^XTMP("PSU_"_PSUJOB,"PSUCT",PSUDIVA2)),U,1)
 .D TAB
 .S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="     "_PSUDIVA2_" Division:"_PSUTB1_PSUCT3
 .S I=I+1
 Q
 ;
TAB ;Calculate tab spacing
 ;
 S PSUTB1=" "
 S PSUTB2=(59-$L(PSUCT3))-$L(PSUDIVA2)-10
 F S2=1:1:(PSUTB2-1) S PSUTB(S2)=" " D
 .S PSUTB1=PSUTB1_PSUTB(S2)                  ;Tab position
 Q
 ;
TOTAL ;EN   Calculate Inpatient total of all divisions
 ;
 N PSUIPCT
 S PSUIPTOT=0
 S PSUTOCT1=0
 F  S PSUIPTOT=$O(^XTMP("PSU_"_PSUJOB,"PSUCT",PSUIPTOT)) Q:PSUIPTOT=""  D
 .S PSUIPCT=$P($G(^XTMP("PSU_"_PSUJOB,"PSUCT",PSUIPTOT)),U,1)
 .S PSUTOCT1=PSUTOCT1+PSUIPCT
 S $P(^XTMP("PSU_"_PSUJOB,"PSUTOTAL"),U,1)=PSUTOCT1
 Q
 ;
TAB1 ;EN  Calculate tab spacing for 'Outpatient Total of all Divisions' line.
 ;and set the last lines of message into the summary global.
 ;
 N PSUTB3,PSUTB4,PSUTB5
 ;
 I '$G(^XTMP("PSU_"_PSUJOB,"PSUTOTAL")) D
 .S ^XTMP("PSU_"_PSUJOB,"PSUTOTAL")=0
 S PSUTB3=" "
 S PSUTB4="     Inpatient Total of all Divisions:"
 S PSUTB5=(64-$L(PSUTB4))-$L($P($G(^XTMP("PSU_"_PSUJOB,"PSUTOTAL")),U,1))
 F S3=1:1:(PSUTB5-1) S PSUTB(S3)=" " D
 .S PSUTB3=PSUTB3_PSUTB(S3)                ;Tab position
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="                                                           ----------" S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)=PSUTB4_PSUTB3_$P($G(^XTMP("PSU_"_PSUJOB,"PSUTOTAL")),U,1) S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="" S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="**PLEASE NOTE: Final TOTAL may not match sum of all SUBTOTALS.  A patient may" S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="have been provided pharmacy services at more than one outpatient and/or" S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="inpatient division."
 Q
 ;
NODATA ;Summary report line to be sent if there is no data
 ;
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",1)="PHARMACY INPATIENT (UD) UNIQUE PATIENTS REPORT"
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",2)=" "
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",3)="No data to report"
 D PDSUM^PSUDEM5
 Q
