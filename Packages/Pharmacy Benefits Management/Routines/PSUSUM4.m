PSUSUM4 ;BIR/DAM - Patient Demographics Summary for IV Extract ; 20 DEC 2001
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;DBIA's
 ; Reference to file #55 supported by DBIA 3502
 ; Reference to file #42 supported by DBIA 2440
 ;
EN ;EN CALLED FROM PSUIV0
 ;Q:$D(^XTMP("PSU_"_PSUJOB,"PSUMFLAG"))   ;Do not run if auto extract
 ;
 D PULL^PSUCP
 F I=1:1:$L(PSUOPTS,",") S PSUMOD($P(PSUOPTS,",",I))=""
 ;
 I $D(^XTMP("PSU_"_PSUJOB,"PSUFLAG2"))!$D(^XTMP("PSU_"_PSUJOB,"PSUFLAG3")) K ^XTMP("PSU_"_PSUJOB,"PSUSUMA")
 I $D(^XTMP("PSU_"_PSUJOB,"PSUNONE","IV")) D  Q    ;Summary report if there is no data
 .I '$D(PSUMOD(2))&$D(PSUMOD(1)) D
 ..I '$D(PSUMOD(4)) D
 ...D NODATA
 ...I $D(^XTMP("PSU_"_PSUJOB,"PSUFLAG1"))!$D(^XTMP("PSU_"_PSUJOB,"PSUFLAG2")) K ^XTMP("PSU_"_PSUJOB,"PSUNONE")
 D EN1
 Q
 ;
EN1 ;Entry point to collect data
 ;
 D DATE
 M ^XTMP("PSU_"_PSUJOB,"PSUIV")=^XTMP(PSUIVSUB)
 S I=7             ;Line counter for message
 D UNIQUE
 N PSUTB2,PSUTB3,PSUTB4,PSUTB5
 D TAB
 D TOTUN
 S I=10            ;Reset line counter for message
 D PATNUM
 D TAB1
 ;
 I $D(PSUMOD(2))&$D(PSUMOD(1)) D
 .I $D(PSUMOD(4)) D
 ..M ^XTMP("PSU_"_PSUJOB,"PSUIVINDIV")=^XTMP("PSU_"_PSUJOB,"PSUCT")
 ..M ^XTMP("PSU_"_PSUJOB,"PSUIVIN")=^XTMP("PSU_"_PSUJOB,"PSUINP")
 ..M ^XTMP("PSU_"_PSUJOB,"PSUIVOUT")=^XTMP("PSU_"_PSUJOB,"PSUOUTP")
 ..M ^XTMP("PSU_"_PSUJOB,"PSUIVSSN")=^XTMP("PSU_"_PSUJOB,"PSUIV","PAT")
 ..M ^XTMP("PSU_"_PSUJOB,"PSUDIV1")=^XTMP("PSU_"_PSUJOB,"PSUDIV")
 ;
 I '$D(PSUMOD(2))&$D(PSUMOD(1)) D
 .I $D(PSUMOD(4)) D
 ..M ^XTMP("PSU_"_PSUJOB,"PSUIVINDIV")=^XTMP("PSU_"_PSUJOB,"PSUCT")
 ..M ^XTMP("PSU_"_PSUJOB,"PSUIVIN")=^XTMP("PSU_"_PSUJOB,"PSUINP")
 ..M ^XTMP("PSU_"_PSUJOB,"PSUIVOUT")=^XTMP("PSU_"_PSUJOB,"PSUOUTP")
 ..M ^XTMP("PSU_"_PSUJOB,"PSUIVSSN")=^XTMP("PSU_"_PSUJOB,"PSUIV","PAT")
 ..M ^XTMP("PSU_"_PSUJOB,"PSUIN1")=^XTMP("PSU_"_PSUJOB,"PSUIN")
 ..M ^XTMP("PSU_"_PSUJOB,"PSUDIV1")=^XTMP("PSU_"_PSUJOB,"PSUDIV")
 ;
 I $D(PSUMOD(2))&$D(PSUMOD(1)) D
 .I '$D(PSUMOD(4)) D
 ..M ^XTMP("PSU_"_PSUJOB,"PSUIVINDIV")=^XTMP("PSU_"_PSUJOB,"PSUCT")
 ..M ^XTMP("PSU_"_PSUJOB,"PSUIVIN")=^XTMP("PSU_"_PSUJOB,"PSUINP")
 ..M ^XTMP("PSU_"_PSUJOB,"PSUIVOUT")=^XTMP("PSU_"_PSUJOB,"PSUOUTP")
 ..M ^XTMP("PSU_"_PSUJOB,"PSUDIV1")=^XTMP("PSU_"_PSUJOB,"PSUDIV")
 ;
 I '$D(PSUMOD(2))&'$D(PSUMOD(4)) D
 .I '$G(^XTMP("PSU_"_PSUJOB,"PSUFLAG1")) D
 ..D PDSUM^PSUDEM5     ;Mail message
 ..K ^XTMP("PSU_"_PSUJOB,"PSUIVOUT")
 ..K ^XTMP("PSU_"_PSUJOB,"PSUIVINDIV")
 K ^XTMP("PSU_"_PSUJOB,"PSUIV")
 ;K ^XTMP("PSU_"_PSUJOB,"PSUIVSSN")
 K ^XTMP("PSU_"_PSUJOB,"PSUINP")
 ;K ^XTMP("PSU_"_PSUJOB,"PSUIN")
 ;K ^XTMP("PSU_"_PSUJOB,"PSUOUT")
 I $D(^XTMP("PSU_"_PSUJOB,"PSUFLAG1")) K ^XTMP("PSU_"_PSUJOB,"PSUSUMA")
 I $D(^XTMP("PSU_"_PSUJOB,"PSUMFLAG"))
 K ^XTMP("PSU_"_PSUJOB,"PSUFLAG1")
 K ^XTMP("PSU_"_PSUJOB,"PSUOUTP")
 K ^XTMP("PSU_"_PSUJOB,"PSUINP")
 ;K ^XTMP("PSU_"_PSUJOB,"PSUDIV")
 K ^XTMP("PSU_"_PSUJOB,"PSUCT")
 ;K ^XTMP("PSU_"_PSUJOB,"PSUTOTAL")
 K ^XTMP("PSU_"_PSUJOB,"PSURXCTA")
 Q
 ;
DATE ;Convert date range of extract to external format
 ;
 S %H=$E($H,1,5)    ;today's date
 D YX^%DTC
 N PSUD S PSUD=Y
 ;
 S Y=PSUSDT
 D DD^%DT
 N PSUS S PSUS=Y
 ;
 S Y=PSUEDT
 D DD^%DT
 N PSUE S PSUE=Y
 ;
 D IVSUM
 Q
 ;
IVSUM ;Summary report header to be run if IV  extract is  run
 ;
 ;Report header
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",1)="PHARMACY INPATIENT (IV) UNIQUE PATIENTS REPORT             "_PSUD
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",2),"-",80)=""                ;Separator bar
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",3)="                 "_PSUS_"  through  "_PSUE
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",4),"=",80)=""
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",5)="                                                           UNIQUE"
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",6),"-",70)=""
 Q
 ;
UNIQUE ;Find number of unique patients across all divisions
 ;
 N PSUSIT
 S PSUSIT=PSUSNDR
 ;
 N PSUWD,PSUSN
 S PSUOPCT=1
 S PSUIPCT=1
 S PSUNUM=0,PSUSIT1=0
 F  S PSUSIT1=$O(^XTMP("PSU_"_PSUJOB,"PSUIV","RECORDS",PSUSIT1)) Q:PSUSIT1=""  D
 .F  S PSUNUM=$O(^XTMP("PSU_"_PSUJOB,"PSUIV","RECORDS",PSUSIT1,PSUNUM)) Q:PSUNUM=""  D
 ..S PSUWD=$P($G(^XTMP("PSU_"_PSUJOB,"PSUIV","RECORDS",PSUSIT1,PSUNUM)),U,7)
 ..S PSUSN=$P($G(^XTMP("PSU_"_PSUJOB,"PSUIV","RECORDS",PSUSIT1,PSUNUM)),U,8)
 ..I PSUWD'="" D
 ...I PSUWD="Y" S ^XTMP("PSU_"_PSUJOB,"PSUOUT",PSUSN)=""
 ...I PSUWD="N" S ^XTMP("PSU_"_PSUJOB,"PSUIN",PSUSN)=""
 D WARD
 Q
 ;
WARD ;Find unique number of patients that are OP and IP
 ;
 ;Find unique number of outpatients
 S PSUD1A=0
 F  S PSUD1A=$O(^XTMP("PSU_"_PSUJOB,"PSUOUT",PSUD1A)) Q:PSUD1A=""  D
 .S ^XTMP("PSU_"_PSUJOB,"PSUOUTP")=PSUOPCT S PSUOPCT=PSUOPCT+1
 ;
 ;Find unique number in inpatients
 S PSUD1B=0
 F  S PSUD1B=$O(^XTMP("PSU_"_PSUJOB,"PSUIN",PSUD1B)) Q:PSUD1B=""  D
 .S ^XTMP("PSU_"_PSUJOB,"PSUINP")=PSUIPCT S PSUIPCT=PSUIPCT+1
 Q
 ;
TAB ;Calculate tab spacing
 ;
 I '$D(^XTMP("PSU_"_PSUJOB,"PSUINP")) S ^XTMP("PSU_"_PSUJOB,"PSUINP")=0
 I '$D(^XTMP("PSU_"_PSUJOB,"PSUOUTP")) S ^XTMP("PSU_"_PSUJOB,"PSUOUTP")=0
 ;
 S PSUTB1=" "
 S PSUTB2="Total unique Inpatients across all divisions:"
 S PSUTB3=(64-$L(^XTMP("PSU_"_PSUJOB,"PSUINP")))-$L(PSUTB2)
 F S2=1:1:(PSUTB3-1) S PSUTB(S2)=" " D
 .S PSUTB1=PSUTB1_PSUTB(S2)
 ;
 S PSUTB6=" "
 S PSUTB4="Total unique Outpatients across all divisions:"
 S PSUTB5=(64-$L(^XTMP("PSU_"_PSUJOB,"PSUOUTP")))-$L(PSUTB4)
 F S3=1:1:(PSUTB5-1) S PSUTB(S3)=" " D
 .S PSUTB6=PSUTB6_PSUTB(S3)
 Q
 ;
TOTUN ;Set total number of unique in-patients and out-patients into
 ;summary message
 ; 
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)=PSUTB2_PSUTB1_^XTMP("PSU_"_PSUJOB,"PSUINP") S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)=PSUTB4_PSUTB6_^XTMP("PSU_"_PSUJOB,"PSUOUTP") S I=I+1
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",I),"-",70)=""
 Q
 ;
PATNUM ;Place division names and patient totals into summary message
 ;
 N PSUTB1,PSUTB2
 N PSUCT3
 S PSUTOTAL=0
 S PSUDIVNM=0
 F  S PSUDIVNM=$O(^XTMP("PSU_"_PSUJOB,"PSUCT",PSUDIVNM)) Q:PSUDIVNM=""  D
 .S PSUCT3=$P($G(^XTMP("PSU_"_PSUJOB,"PSUCT",PSUDIVNM)),U,1)
 .S PSUTOTAL=PSUTOTAL+PSUCT3
 .D SPACE
 .S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="     "_PSUDIVNM_" Division:"_PSUTB1_PSUCT3
 .S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUTOTAL")=PSUTOTAL   ;Total of all divisions
 Q
 ;
SPACE ;S ^XTMP("PSU_"_PSUJOB,"PSUTOTAL")=PSUTOTAL   ;Total of all divisions
 ;
 S PSUTB1=" "
 S PSUTB2=(59-$L(PSUCT3))-$L(PSUDIVNM)-10
 F S2=1:1:(PSUTB2-1) S PSUTB(S2)=" " D
 .S PSUTB1=PSUTB1_PSUTB(S2)                  ;Tab position
 Q
 ;
TAB1 ;EN  Calculate tab spacing for 'Total of all Divisions' line,
 ;and set the last lines of message into the summary global.
 ;
 N PSUTB3,PSUTB4,PSUTB5
 ;
 S PSUTB3=" "
 S PSUTB4="     Total of all Divisions:          "
 S PSUTB5=(64-$L(PSUTB4))-$L($P(^XTMP("PSU_"_PSUJOB,"PSUTOTAL"),U,1))
 F S3=1:1:(PSUTB5-1) S PSUTB(S3)=" " D
 .S PSUTB3=PSUTB3_PSUTB(S3)                ;Tab position
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="                                                         ------------" S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)=PSUTB4_PSUTB3_$P(^XTMP("PSU_"_PSUJOB,"PSUTOTAL"),U,1) S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="" S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="* This report includes Outpatients receiving IV orders." S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="" S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="**PLEASE NOTE: Final TOTAL may not match sum of all SUBTOTALS.  A patient may" S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="have been provided pharmacy services at more than one outpatient and/or" S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="inpatient division."
 Q
 ;
NODATA ;Summary report line to be sent if there is no data
 ;
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",1)="PHARMACY INPATIENT (IV) UNIQUE PATIENTS REPORT"
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",2)=" "
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",3)="No data to report"
 D PDSUM^PSUDEM5
 Q
