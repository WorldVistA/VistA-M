PSUSUM7 ;BIR/DAM - Pt. Demographics Summary for IV/RX or UD/RX ; 20 DEC 2001
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
EN ;EN CALLED FROM PSUOP0
 ;Q:$D(^XTMP("PSU_"_PSUJOB,"PSU_"_PSUJOB,"PSUMFLAG"))   ;Do not run if auto extract
 ;
 D PULL^PSUCP
 F I=1:1:$L(PSUOPTS,",") S PSUMOD($P(PSUOPTS,",",I))=""
 ;
 K ^XTMP("PSU_"_PSUJOB,"PSUSUMA")
 I $G(^XTMP("PSU_"_PSUJOB,"PSUFLAG2"))!$G(^XTMP("PSU_"_PSUJOB,"PSUFLAG3")) K ^XTMP("PSU_"_PSUJOB,"PSUSUMA")
 I $D(^XTMP("PSU_"_PSUJOB,"PSUNONE","RX")) D  Q
 .I $D(^XTMP("PSU_"_PSUJOB,"PSUNONE","IV"))!$D(^XTMP("PSU_"_PSUJOB,"PSUNONE","UD")) D
 ..D NODATA
 ..I $G(^XTMP("PSU_"_PSUJOB,"PSUFLAG1"))!$G(^XTMP("PSU_"_PSUJOB,"PSUFLAG2")) K ^XTMP("PSU_"_PSUJOB,"PSUNONE")
 ;
 D EN1
 Q
 ;
EN1 ;Gather summary data
 D DATE^PSUSUM6
 S I=7
 I $D(PSUMOD(1)) D UNIQUE1
 I '$D(PSUMOD(1)) D UNIQUE
 D TOP^PSUSUM6
 D OPDIV^PSUSUM6
 D DIVTOT^PSUSUM6
 D TUDIV
 I $D(PSUMOD(1)) D
 .D IPDIV2
 I $D(PSUMOD(2)) D
 .D IPDIV^PSUSUM6
 .D IPDIV1
 .D TAB4
 D PDSUM^PSUDEM5
 K ^XTMP("PSU_"_PSUJOB,"PSUTMP"),^XTMP("PSU_"_PSUJOB,"PSUTOTAL"),^XTMP("PSU_"_PSUJOB,"PSURXUNIQUE")
 K ^XTMP("PSU_"_PSUJOB,"PSURXTOTAL")
 K ^XTMP("PSU_"_PSUJOB,"PSURXCTA"),^XTMP("PSU_"_PSUJOB,"PSUIVINDIV")
 K ^XTMP("PSU_"_PSUJOB,"PSURXSSN"),^XTMP("PSU_"_PSUJOB,"PSUIVDIV"),^XTMP("PSU_"_PSUJOB,"PSUFLAG2")
 K ^XTMP("PSU_"_PSUJOB,"PSUFLAG3")
 K ^XTMP("PSU_"_PSUJOB,"PSUIVOUT"),^XTMP("PSU_"_PSUJOB,"PSUIVSSN"),^XTMP("PSU_"_PSUJOB,"PSUUDDIV")
 Q
 ;
UNIQUE ;Find total unique pharmacy patients across all divisions when
 ;UD and RX extracts are run together
 ;
 S PSURXN=0,PSUUDN1=0,PSUUDN2=0
 ;
 S N=1
 F  S PSURXN=$O(^XTMP("PSU_"_PSUJOB,"PSURXSSN",PSURXN)) Q:PSURXN=""  D
 .S ^XTMP("PSU_"_PSUJOB,"PSUTMP",PSURXN)=N S N=N+1
 .F  S PSUUDN1=$O(^XTMP("PSU_"_PSUJOB,"PSUUDSSN",PSUUDN1)) Q:PSUUDN1=""  D
 ..I '$D(^XTMP("PSU_"_PSUJOB,"PSUTMP",PSUUDN1)) S ^XTMP("PSU_"_PSUJOB,"PSUTMP",PSUUDN1)=N S N=N+1
 ;
 S ^XTMP("PSU_"_PSUJOB,"PSUTOTAL")=N-1
 D TAB2
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",I),"-",70)="" S I=I+1
 Q
 ;
TAB2 ;Tab spacing for line 7.  Set line into global
 ;
 S PSUTB3=" "
 S PSUTB4="TOTAL Pharmacy patients across all divisions:"
 S PSUTB5=(64-$L(PSUTB4))-$L($P($G(^XTMP("PSU_"_PSUJOB,"PSUTOTAL")),U,1))
 F S3=1:1:(PSUTB5-1) S PSUTB(S3)=" " D
 .S PSUTB3=PSUTB3_PSUTB(S3)
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)=PSUTB4_PSUTB3_$P($G(^XTMP("PSU_"_PSUJOB,"PSUTOTAL")),U,1)
 S I=I+1
 Q
 ;
UNIQUE1 ;Find total unique pharmacy patients across all divisions when
 ;IV and RX extracts are run together
 ;
 S PSURXN=0,PSUIVN=0
 ;
 S N=1
 ;
 F  S PSURXN=$O(^XTMP("PSU_"_PSUJOB,"PSURXSSN",PSURXN)) Q:PSURXN=""  D
 .S ^XTMP("PSU_"_PSUJOB,"PSUTMP",PSURXN)=N S N=N+1
 .F  S PSUIVN=$O(^XTMP("PSU_"_PSUJOB,"PSUIVSSN",PSUIVN)) Q:PSUIVN=""  D
 ..I '$D(^XTMP("PSU_"_PSUJOB,"PSUTMP",PSUIVN)) S ^XTMP("PSU_"_PSUJOB,"PSUTMP",PSUIVN)=N S N=N+1
 ;
 S ^XTMP("PSU_"_PSUJOB,"PSUTOTAL")=N-1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="TOTAL Pharmacy patients across all divisions:               "_$P($G(^XTMP("PSU_"_PSUJOB,"PSUTOTAL")),U,1) S I=I+1
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",I),"-",70)="" S I=I+1
 Q
 ;
TUDIV ;Calculate total inpatient count and tab spacing for 'Total
 ;INPATIENT (UD or IV)' line and set into message global
 ;
 N PSUTB3,PSUTB4,PSUTB5,PSUDT
 ;
 I '$D(PSUMOD(1)) D
 .S PSUDT=$P($G(^XTMP("PSU_"_PSUJOB,"PSUUDSSN")),U) D
 ..S ^XTMP("PSU_"_PSUJOB,"PSUUDIVTOT")=PSUDT                 ;Total UD inpatient count
 ;
 I '$D(PSUMOD(2)) D
 .S ^XTMP("PSU_"_PSUJOB,"PSUUDIVTOT")=$P($G(^XTMP("PSU_"_PSUJOB,"PSUIVIN")),U,1)-1   ;Total IV inpatient count
 ;
 I '$G(^XTMP("PSU_"_PSUJOB,"PSUUDIVTOT")) S ^XTMP("PSU_"_PSUJOB,"PSUUDIVTOT")=0
 S PSUTB3=" "
 S PSUTB4="   Total INPATIENT (UD or IV):"
 S PSUTB5=(64-$L(PSUTB4))-$L($P($G(^XTMP("PSU_"_PSUJOB,"PSUUDIVTOT")),U,1))
 F S3=1:1:(PSUTB5-1) S PSUTB(S3)=" " D
 .S PSUTB3=PSUTB3_PSUTB(S3)                ;Tab position
 ;
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)=PSUTB4_PSUTB3_$P($G(^XTMP("PSU_"_PSUJOB,"PSUUDIVTOT")),U,1) S I=I+1
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",I),"-",70)="" S I=I+1
 Q
 ;
IPDIV1 ;Find UD inpatient division totals
 ;
 S PSULBL=0
 N PSUTTL
 ;
 I $D(PSUMOD(2)) D           ;UD inpatients
 .F  S PSULBL=$O(^XTMP("PSU_"_PSUJOB,"PSUUDDIV",PSULBL)) Q:PSULBL=""  D
 ..S PSUTTL=$P($G(^XTMP("PSU_"_PSUJOB,"PSUUDDIV",PSULBL)),U,1)
 ..D TAB1^PSUSUM6
 ..D IPMSG
 Q
 ;
IPMSG ;Set UD inpatient division totals into message global
 ;
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="     "_PSULBL_" Division:"_PSUTB1_PSUTTL
 S I=I+1
 Q
 ;
IPDIV2 ;Calculate inpatient totals for IV divisions
 ;
 ;
 ;Construct a storage global containing unique IV inpatients
 ;per division 
 S PSUDV=0
 F  S PSUDV=$O(^XTMP("PSU_"_PSUJOB,"PSUDIV1",PSUDV)) Q:PSUDV=""  D
 .S PSUPT=0
 .F  S PSUPT=$O(^XTMP("PSU_"_PSUJOB,"PSUDIV1",PSUDV,PSUPT)) Q:PSUPT=""  D
 ..S PSUPT1=0
 ..F  S PSUPT1=$O(^XTMP("PSU_"_PSUJOB,"PSUIN1",PSUPT1)) Q:PSUPT1=""  D
 ...I PSUPT1=PSUPT S ^XTMP("PSU_"_PSUJOB,"PSUDIV",PSUDV,PSUPT1)=""
 D IPDIV3
 Q
 ;
IPDIV3 ;Find unique inpatient count for each division
 S PSUCT1=0,PSUCT2=0,T=1
 ;
 F  S PSUCT1=$O(^XTMP("PSU_"_PSUJOB,"PSUDIV",PSUCT1)) Q:PSUCT1=""  D
 .F  S PSUCT2=$O(^XTMP("PSU_"_PSUJOB,"PSUDIV",PSUCT1,PSUCT2)) Q:PSUCT2=""  D
 ..S ^XTMP("PSU_"_PSUJOB,"PSUTOTAL1")=T S T=T+1    ;Total count
 ..I $D(^XTMP("PSU_"_PSUJOB,"PSUCT",PSUCT1)) D
 ...S C=C+1
 ...S ^XTMP("PSU_"_PSUJOB,"PSUCT",PSUCT1)=C
 ..I '$D(^XTMP("PSU_"_PSUJOB,"PSUCT",PSUCT1)) D
 ...S C=1
 ...S ^XTMP("PSU_"_PSUJOB,"PSUCT",PSUCT1)=C
 D DIVNUM
 D MSG
 Q
 ;
DIVNUM ;Set number of inpatients per division into summary message
 ;
 N PSUTB1,PSUTB2
 S N=1
 ;
 N PSUCT2
 S PSUDIVA1=0
 F  S PSUDIVA1=$O(^XTMP("PSU_"_PSUJOB,"PSUCT",PSUDIVA1)) Q:PSUDIVA1=""  D
 .S PSUCT2=$P($G(^XTMP("PSU_"_PSUJOB,"PSUCT",PSUDIVA1)),U,1)
 .D TAB5
 .S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="     "_PSUDIVA1_" Division:"_PSUTB1_PSUCT2
 .S I=I+1
 Q
 ;
TAB5 ;Calculate tab spacing
 ;
 S PSUTB1=" "
 S PSUTB2=(59-$L(PSUCT2))-$L(PSUDIVA1)-10
 F S2=1:1:(PSUTB2-1) S PSUTB(S2)=" " D
 .S PSUTB1=PSUTB1_PSUTB(S2)                ;Tab position
 Q
 ;
TAB4 ;Calculate UD totals of all divisions and place in summary
 ;message
 ;
 S N=0,PSUMKER=0,R=1
 ;
 I $D(PSUMOD(2)) D
 .F  S PSUMKER=$O(^XTMP("PSU_"_PSUJOB,"PSUUDDIV",PSUMKER)) Q:PSUMKER=""  D
 ..S N=$P(^XTMP("PSU_"_PSUJOB,"PSUUDDIV",PSUMKER),U)+N
 ..S ^XTMP("PSU_"_PSUJOB,"PSUTOTAL1")=N                   ;Sum of all UD inpatients
 ;
 D MSG
 Q
 ;
MSG ;Final lines of message
 ;
 I '$D(^XTMP("PSU_"_PSUJOB,"PSUTOTAL1")) S ^XTMP("PSU_"_PSUJOB,"PSUTOTAL1")=0
 ;
 N PSUTB3,PSUTB4,PSUTB5
 ;
 S PSUTB3=" "
 S PSUTB4="     Inpatient Total of all Divisions:"
 S PSUTB5=(64-$L(PSUTB4))-$L($P($G(^XTMP("PSU_"_PSUJOB,"PSUTOTAL1")),U,1))
 F S3=1:1:(PSUTB5-1) S PSUTB(S3)=" " D
 .S PSUTB3=PSUTB3_PSUTB(S3)                ;Tab position
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="                                                          ----------" S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)=PSUTB4_PSUTB3_$P($G(^XTMP("PSU_"_PSUJOB,"PSUTOTAL1")),U,1) S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="" S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="**PLEASE NOTE: Final TOTAL may not match sum of all SUBTOTALS.  A patient may" S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="have been provided pharmacy services at more than one outpatient and/or" S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="inpatient division."
 Q
 ;
NODATA ;Summary report line to be sent if there is no data
 ;
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",1)="PHARMACY UNIQUE PATIENTS REPORT"
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",2)=" "
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",3)="No data to report"
 D PDSUM^PSUDEM5
 Q
