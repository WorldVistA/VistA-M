PSUSUM2 ;BIR/DAM - Patient Demographics Summary for OP Extract ; 20 DEC 2001
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;DBIA'S
 ;  Reference to File #59 supported by DBIA 1876
 ;
EN ;EN  CALLED FROM PSUOP0
 ;Q:$D(^XTMP("PSU_"_PSUJOB,"PSUMFLAG"))   ;Do not run if auto extract
 ;
 D PULL^PSUCP
 F I=1:1:$L(PSUOPTS,",") S PSUMOD($P(PSUOPTS,",",I))=""
 ;
 I $D(^XTMP("PSU_"_PSUJOB,"PSUNONE","RX")) D  Q    ;Summary report if there is no data
 .I '$D(PSUMOD(1))&'$D(PSUMOD(2)) D
 ..D NODATA
 ..I $D(^XTMP("PSU_"_PSUJOB,"PSUFLAG1"))!$D(^XTMP("PSU_"_PSUJOB,"PSUFLAG2")) K ^XTMP("PSU_"_PSUJOB,"PSUNONE")
 ;
 D DATE
 D DIVNUM
 D TOTAL
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="                                                            ---------" S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="" S I=I+1
 D TAB1
 I $D(PSUMOD(1))!$D(PSUMOD(2)) D
 .M ^XTMP("PSU_"_PSUJOB,"PSURXCTA")=^XTMP("PSU_"_PSUJOB,"PSUCT")
 .M ^XTMP("PSU_"_PSUJOB,"PSURXTOTAL")=^XTMP("PSU_"_PSUJOB,"PSUTOTAL")
 .S ^XTMP("PSU_"_PSUJOB,"PSURXUNIQUE")=M-1
 .M ^XTMP("PSU_"_PSUJOB,"PSURXSSN")=^XTMP("PSU_"_PSUJOB,"PSUSSN")
 ;
 I '$D(PSUMOD(1))&'$D(PSUMOD(2)) D
 .D PDSUM^PSUDEM5      ;Mail message
 K ^XTMP("PSU_"_PSUJOB,"PSUTOTAL")
 K ^XTMP("PSU_"_PSUJOB,"PSUSSN")
 K ^XTMP("PSU_"_PSUJOB,"PSUCT")
 K ^XTMP("PSU_"_PSUJOB,"PSUDIV")
 K ^XTMP("PSU_"_PSUJOB,"PSURX")
 I $D(^XTMP("PSU_"_PSUJOB,"PSUFLAG1")) K ^XTMP("PSU_"_PSUJOB,"PSUSUMA")
 K ^XTMP("PSU_"_PSUJOB,"PSUFLAG1")
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
 D RXSUM
 Q
 ;
RXSUM ;Summary report to be run if Rx (Outpatient) extract is  run
 ;
 D UNIQUE
 ;Report header
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",1)="PHARMACY OUTPATIENT UNIQUE PATIENTS REPORT                     "_PSUD
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",2),"-",80)=""                ;Separator bar
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",3)="                 "_PSUS_"  through  "_PSUE
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",4),"=",80)=""
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",5)="                                                             UNIQUE"
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",6),"-",70)=""
 D TAB2
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",8),"-",70)=""
 S I=9
 ;
 Q
 ;
TAB2 ;Tab spacing for line 7.  Set line into global
 ;
 N PSUTB3,PSUTB4,PSUTB5
 ;
 S PSUTB3=" "
 S PSUTB4="TOTAL Pharmacy patients across all divisions:"
 S PSUTB5=(67-$L(PSUTB4))-$L($P(^XTMP("PSU_"_PSUJOB,"PSUUNIQUE"),U,1))
 F S3=1:1:(PSUTB5-1) S PSUTB(S3)=" " D
 .S PSUTB3=PSUTB3_PSUTB(S3)
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",7)=PSUTB4_PSUTB3_$P(^XTMP("PSU_"_PSUJOB,"PSUUNIQUE"),U,1)
 Q
 ;
UNIQUE ;Find UNIQUE patients across all divisions
 ;
 N PSUSIT,PSUTOTAL,PSUSOC1,PSUNIQUE,PSURX2,PSURX5
 M ^XTMP("PSU_"_PSUJOB,"PSURX")=^XTMP(PSUOPSUB)
 ;
 S M=0
 S N=1
 S PSUSIT=0
 S PSURX1=0
 F  S PSUSIT=$O(^XTMP("PSU_"_PSUJOB,"PSURX","RECORDS",PSUSIT)) Q:'PSUSIT  D
 .F  S PSURX1=$O(^XTMP("PSU_"_PSUJOB,"PSURX","RECORDS",PSUSIT,PSURX1)) Q:'PSURX1  D
 ..I $P($G(^XTMP("PSU_"_PSUJOB,"PSURX","RECORDS",PSUSIT,PSURX1)),U,7)?9.10E D
 ...;S PSUTOTAL=N
 ...S PSUSOC1=$P($G(^XTMP("PSU_"_PSUJOB,"PSURX","RECORDS",PSUSIT,PSURX1)),U,7)
 ...I $G(PSUSOC1) S ^XTMP("PSU_"_PSUJOB,"PSUSSN",PSUSOC1)=""
 ...S N=N+1
 D ELIM
 Q
 ;
ELIM ;Eliminate duplicate patient entries to get number of unique pts
 ;
 S PSUADM=0
 F  S PSUADM=$O(^XTMP("PSU_"_PSUJOB,"PSUSSN",PSUADM)) Q:'PSUADM  D
 .S $P(^XTMP("PSU_"_PSUJOB,"PSUUNIQUE"),U,1)=M
 .S M=M+1
 Q
 ;
DIVNUM ;Set number of patients per division into summary message
 ;
 ;Find patient SSN's in the following global and place with the division
 ;number
 N PSUPTID,PSUPL
 S PSUDNUM=0
 S C=1
 F  S PSUDNUM=$O(^XTMP("PSU_"_PSUJOB,"PSUDIVPT",PSUDNUM)) Q:PSUDNUM=""  D
 .S PSUPL=0
 .F  S PSUPL=$O(^XTMP("PSU_"_PSUJOB,"PSUDIVPT",PSUDNUM,PSUPL)) Q:PSUPL=""  D
 ..S PSUPTID=$P(^XTMP("PSU_"_PSUJOB,"PSUDIVPT",PSUDNUM,PSUPL),U,7)
 ..Q:PSUPTID=""
 ..S ^XTMP("PSU_"_PSUJOB,"PSUCT0",PSUDNUM,PSUPTID)=""
 ;
 ;Get patient count for each division
 S PSUDNUM1=0
 F  S PSUDNUM1=$O(^XTMP("PSU_"_PSUJOB,"PSUCT0",PSUDNUM1)) Q:PSUDNUM1=""  D
 .S PSUID=0
 .F  S PSUID=$O(^XTMP("PSU_"_PSUJOB,"PSUCT0",PSUDNUM1,PSUID)) Q:PSUID=""  D
 ..I $D(^XTMP("PSU_"_PSUJOB,"PSUCT1",PSUDNUM1)) D
 ...S C=C+1
 ...S ^XTMP("PSU_"_PSUJOB,"PSUCT1",PSUDNUM1)=C
 ..I '$D(^XTMP("PSU_"_PSUJOB,"PSUCT1",PSUDNUM1)) D
 ...S C=1 S ^XTMP("PSU_"_PSUJOB,"PSUCT1",PSUDNUM1)=C
 ;
 ;Get division name
 S PSUDIV=0
 N PSUNBR
 F  S PSUDIV=$O(^XTMP("PSU_"_PSUJOB,"PSUCT1",PSUDIV)) Q:PSUDIV=""  D
 .S PSUNBR=$P(^XTMP("PSU_"_PSUJOB,"PSUCT1",PSUDIV),U,1)
 .S X=PSUDIV,DIC=59,DIC(0)="XM" D ^DIC ;**1
 .S X=+Y,PSUDIVNM=$$VAL^PSUTL(59,X,.01)
 .I PSUDIVNM'="" S ^XTMP("PSU_"_PSUJOB,"PSUCT",PSUDIVNM)=PSUNBR
 .I PSUDIVNM="" S ^XTMP("PSU_"_PSUJOB,"PSUCT",PSUDIV)=PSUNBR
 ;
 N PSUTB1,PSUTB2
 ;
 N PSUCT2
 S PSUDIVA1=0
 F  S PSUDIVA1=$O(^XTMP("PSU_"_PSUJOB,"PSUCT",PSUDIVA1)) Q:PSUDIVA1=""  D
 .S PSUCT2=$P(^XTMP("PSU_"_PSUJOB,"PSUCT",PSUDIVA1),U,1)
 .D TAB
 .S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="     "_PSUDIVA1_" Division:"_PSUTB1_PSUCT2
 .S I=I+1
 Q
 ;
TAB ;Calculate tab spacing
 ;
 S PSUTB1=" "
 S PSUTB2=(62-$L(PSUCT2))-$L(PSUDIVA1)-10
 F S2=1:1:(PSUTB2-1) S PSUTB(S2)=" " D
 .S PSUTB1=PSUTB1_PSUTB(S2)                ;Tab position
 Q
 ;
TOTAL ;Calculate Outpatient Total of all Divisions
 ;
 S PSUOPTOT=0
 S PSUTOCT1=0
 F  S PSUOPTOT=$O(^XTMP("PSU_"_PSUJOB,"PSUCT",PSUOPTOT)) Q:PSUOPTOT=""  D
 .S PSUTOCT=$P(^XTMP("PSU_"_PSUJOB,"PSUCT",PSUOPTOT),U,1)
 .S PSUTOCT1=PSUTOCT1+PSUTOCT
 S $P(^XTMP("PSU_"_PSUJOB,"PSUTOTAL"),U,1)=PSUTOCT1
 Q
 ;
TAB1 ;Calculate tab spacing for 'Outpatient Total of all Divisions' line.
 ;and set the last lines of message  into the summary global.
 ;
 N PSUTB3,PSUTB4,PSUTB5
 ;
 S PSUTB3=" "
 S PSUTB4="     Outpatient Total of all Divisions:"
 S PSUTB5=(67-$L(PSUTB4))-$L($P(^XTMP("PSU_"_PSUJOB,"PSUTOTAL"),U,1))
 F S3=1:1:(PSUTB5-1) S PSUTB(S3)=" " D
 .S PSUTB3=PSUTB3_PSUTB(S3)                ;Tab position
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)=PSUTB4_PSUTB3_$P($G(^XTMP("PSU_"_PSUJOB,"PSUTOTAL")),U,1) S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="" S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="**PLEASE NOTE: Final TOTAL may not match sum of all SUBTOTALS. A patient may" S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="have been provided pharmacy services at more than one outpatient and/or" S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="inpatient division."
 Q
 ;
NODATA ;Summary report line to be sent if there is no data
 ;
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",1)="PHARMACY OUTPATIENT UNIQUE PATIENTS REPORT"
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",2)=" "
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",3)="No data to report"
 D PDSUM^PSUDEM5
 Q
