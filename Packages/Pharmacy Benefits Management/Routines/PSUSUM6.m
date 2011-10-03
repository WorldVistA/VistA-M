PSUSUM6 ;BIR/DAM - Patient Demographics Summary for IV/UD/RX ; 20 DEC 2001
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
EN ;EN CALLED FROM PSUOP0
 ;
 K ^XTMP("PSU_"_PSUJOB,"PSUSUMA")   ;DAM  Trying to make auto run
 I $D(^XTMP("PSU_"_PSUJOB,"PSUFLAG2"))!$D(^XTMP("PSU_"_PSUJOB,"PSUFLAG3")) D
 .K ^XTMP("PSU_"_PSUJOB,"PSUSUMA")
 ;
 N PSURX,PSUIV,PSUUD
 S PSURX=$G(^XTMP("PSU_"_PSUJOB,"PSUNONE","RX"))
 S PSUIV=$G(^XTMP("PSU_"_PSUJOB,"PSUNONE","IV"))
 S PSUUD=$G(^XTMP("PSU_"_PSUJOB,"PSUNONE","UD"))
 I $G(PSURX)&$G(PSUIV)&$G(PSUUD) D  Q
 .D NODATA D
 ..I $D(^XTMP("PSU_"_PSUJOB,"PSUFLAG1"))!$D(^XTMP("PSU_"_PSUJOB,"PSUFLAG2")) K ^XTMP("PSU_"_PSUJOB,"PSUNONE")
 D EN1
 Q
 ;
EN1 ;Gather summary data for UD/IV/RX report
 D PULL^PSUCP
 D DATE
 S I=7
 D UNIQUE
 D TOP
 D OPDIV
 D DIVTOT
 D TUDIV
 D IPDIV
 D IPDIV1
 D TAB3
 D TAB4
 D PDSUM^PSUDEM5       ;Mail message
 K ^XTMP("PSU_"_PSUJOB,"PSUTMP")
 K ^XTMP("PSU_"_PSUJOB,"PSUTOTAL")
 K ^XTMP("PSU_"_PSUJOB,"PSURXUNIQUE")
 K ^XTMP("PSU_"_PSUJOB,"PSURXTOTAL")
 K ^XTMP("PSU_"_PSUJOB,"PSURXCTA")
 K ^XTMP("PSU_"_PSUJOB,"PSURXSSN")
 K ^XTMP("PSU_"_PSUJOB,"PSUCOMBO")
 K ^XTMP("PSU_"_PSUJOB,"PSUIVSSN")
 K ^XTMP("PSU_"_PSUJOB,"PSUUDSSN")
 K ^XTMP("PSU_"_PSUJOB,"PSUIVDIV")
 K ^XTMP("PSU_"_PSUJOB,"PSUIVOUT")
 K ^XTMP("PSU_"_PSUJOB,"PSUUDDIV")
 Q
 ;
DATE ;EN  Convert date range of extract to external format
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
 D COMSUM
 Q
 ;
COMSUM ;Summary report header to be run for combination Rx/IV/UD report
 ;
 ;Report header
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",1)="PHARMACY UNIQUE PATIENTS REPORT                          "_PSUD
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",2),"-",80)=""                ;Separator bar
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",3)="                 "_PSUS_"  through  "_PSUE
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",4),"=",80)=""
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",5)="                                                          UNIQUE"
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",6),"-",70)=""
 Q
 ;
UNIQUE ;Find total unique pharmacy patients across all divisions
 ;
 S PSURXN=0,PSUIVN=0,PSUUDN1=0
 ;
 M ^XTMP("PSU_"_PSUJOB,"PSUTMP")=^XTMP("PSU_"_PSUJOB,"PSURXSSN")
 M ^XTMP("PSU_"_PSUJOB,"PSUTMP")=^XTMP("PSU_"_PSUJOB,"PSUIVSSN")
 M ^XTMP("PSU_"_PSUJOB,"PSUTMP")=^XTMP("PSU_"_PSUJOB,"PSUUDSSN")
 ;
 ;
 S N=1
 S PSUTTL=0
 F  S PSUTTL=$O(^XTMP("PSU_"_PSUJOB,"PSUTMP",PSUTTL)) Q:PSUTTL=""  D
 .S ^XTMP("PSU_"_PSUJOB,"PSUTOTAL")=N S N=N+1
 D TAB2
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",I),"-",70)="" S I=I+1
 Q
 ;
TAB2 ;Tab spacing for line 7.  Set line into global
 ;
 N PSUTB3,PSUTB4,PSUTB5
 ;
 S PSUTB3=" "
 S PSUTB4="TOTAL Pharmacy patients across all divisions:"
 S PSUTB5=(64-$L(PSUTB4))-$L($P($G(^XTMP("PSU_"_PSUJOB,"PSUTOTAL")),U,1))
 F S3=1:1:(PSUTB5-1) S PSUTB(S3)=" " D
 .S PSUTB3=PSUTB3_PSUTB(S3)
 I '$G(^XTMP("PSU_"_PSUJOB,"PSUTOTAL")) D
 .S ^XTMP("PSU_"_PSUJOB,"PSUTOTAL")=0
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)=PSUTB4_PSUTB3_$P($G(^XTMP("PSU_"_PSUJOB,"PSUTOTAL")),U,1)
 S I=I+1
 Q
 ;
TOP ;EN  Find Total Outpatients
 N PSUTB1,PSUTB2
 ;
 N PSUTOP,PSULBL
 S PSUTOP=$G(^XTMP("PSU_"_PSUJOB,"PSURXUNIQUE"))
 I '$G(PSUTOP) S PSUTOP=0,PSUTOPF=1
 S PSULBL="   Total OUTPATIENT:"
 D TAB
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)=PSULBL_PSUTB1_PSUTOP S I=I+1
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",I),"-",70)="" S I=I+1
 Q
 ;
TAB ;Calculate tab spacing
 ;
 S PSUTB1=" "
 S PSUTB2=(64-$L(PSUTOP))-$L(PSULBL)
 F S2=1:1:(PSUTB2-1) S PSUTB(S2)=" " D
 .S PSUTB1=PSUTB1_PSUTB(S2)
 Q
 ;
OPDIV ;EN   Find outpatients per division
 ;
 Q:$G(PSUTOPF)
 N PSUTB1,PSUTB2
 ;
 N PSUTTL
 S PSULBL=0
 I $D(^XTMP("PSU_"_PSUJOB,"PSURXCTA")) D
 .F  S PSULBL=$O(^XTMP("PSU_"_PSUJOB,"PSURXCTA",PSULBL)) Q:PSULBL=""  D
 ..Q:PSULBL=0
 ..S PSUTTL=$P($G(^XTMP("PSU_"_PSUJOB,"PSURXCTA",PSULBL)),U,1)
 ..D TAB1
 ..S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="     "_PSULBL_" Division:"_PSUTB1_PSUTTL
 ..S I=I+1
 I '$D(^XTMP("PSU_"_PSUJOB,"PSURXCTA")) D
 .S PSUTTL=0
 .D TAB1
 .S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="     "_PSULBL_" Division:"_PSUTB1_PSUTTL
 .S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="                                                          ----------" S I=I+1
 Q
 ;
TAB1 ;EN   Calculate division tab spacing
 ;
 S PSUTB1=" "
 S PSUTB2=(59-$L(PSUTTL))-$L(PSULBL)-10
 F S2=1:1:(PSUTB2-1) S PSUTB(S2)=" " D
 .S PSUTB1=PSUTB1_PSUTB(S2)
 Q
 ;
DIVTOT ;EN  Calculate tab spacing for 'Outpatient total of all divisions'
 ;line and set line into message global
 ;
 N PSUTB3,PSUTB4,PSUTB5
 ;
 I '$G(^XTMP("PSU_"_PSUJOB,"PSURXTOTAL")) D
 .S ^XTMP("PSU_"_PSUJOB,"PSURXTOTAL")=0
 S PSUTB3=" "
 S PSUTB4="     Outpatient Total of all Divisions:"
 S PSUTB5=(64-$L(PSUTB4))-$L($P($G(^XTMP("PSU_"_PSUJOB,"PSURXTOTAL")),U,1))
 F S3=1:1:(PSUTB5-1) S PSUTB3(S3)=" " D
 .S PSUTB3=PSUTB3_PSUTB(S3)
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)=PSUTB4_PSUTB3_$P($G(^XTMP("PSU_"_PSUJOB,"PSURXTOTAL")),U,1) S I=I+1
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",I),"-",70)="" S I=I+1
 Q
 ;
TUDIV ;Calculate tab spacing for 'Total INPATIENT' line and
 ;set line into message global
 ;
 N PSUTB3,PSUTB4,PSUTB5
 ;
 ;Create global with total number of unique UD + IV inpatients
 ;using patient SSN to ID unique patient
 M ^XTMP("PSU_"_PSUJOB,"PSUUDIVT")=^XTMP("PSU_"_PSUJOB,"PSUDIV1")
 M ^XTMP("PSU_"_PSUJOB,"PSUUDIVT")=^XTMP("PSU_"_PSUJOB,"PSUDIVUD")
 ;
 ;Loop through division global and create global with unique SSN
 S G=1
 S PSUD2=0
 F  S PSUD2=$O(^XTMP("PSU_"_PSUJOB,"PSUUDIVT",PSUD2)) Q:PSUD2=""  D
 .S PSUD8=0
 .F  S PSUD8=$O(^XTMP("PSU_"_PSUJOB,"PSUUDIVT",PSUD2,PSUD8)) Q:PSUD8=""  D
 ..S ^XTMP("PSU_"_PSUJOB,"PSUUDIVT1",PSUD8)=""   ;Unique SSN's
 ;
 ;Find number of unique SSN's. This is number of unique patients
 S PSUD9=0
 F  S PSUD9=$O(^XTMP("PSU_"_PSUJOB,"PSUUDIVT1",PSUD9)) Q:PSUD9=""  D
 .S ^XTMP("PSU_"_PSUJOB,"PSUUDIVTOT")=G,G=G+1
 ;
 ;Calculate tab spacing
 S PSUTB3=" "
 S PSUTB4="   Total INPATIENT:"
 S PSUTB5=(64-$L(PSUTB4))-$L($P($G(^XTMP("PSU_"_PSUJOB,"PSUUDIVTOT")),U,1))
 F S3=1:1:(PSUTB5-1) S PSUTB(S3)=" " D
 .S PSUTB3=PSUTB3_PSUTB(S3)             ;Tab position
 ;
 ;Set line into message global
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)=PSUTB4_PSUTB3_$P($G(^XTMP("PSU_"_PSUJOB,"PSUUDIVTOT")),U,1) S I=I+1
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",I),"-",70)="" S I=I+1
 Q
 ;
IPDIV ;EN   Find inpatients  by division (includes UD patients and IV
 ;patients with ward location NOT set to 0.5
 ;
 ;If no Unit Dose data exists, do the following to get IV data:
 I $D(^XTMP("PSU_"_PSUJOB,"PSUNONE","UD")) D  Q
 .M ^XTMP("PSU_"_PSUJOB,"PSUINPT")=^XTMP("PSU_"_PSUJOB,"PSUDIV1")
 ;
 ;If no IV data exists, do the following to get UD data:
 I $D(^XTMP("PSU_"_PSUJOB,"PSUNONE","IV")) D  Q
 .M ^XTMP("PSU_"_PSUJOB,"PSUINPT")=^XTMP("PSU_"_PSUJOB,"PSUDIVUD")
 ;
 ;Construct a storage global containing unique inpatients
 ;per division when there is both UD and IV data
 S PSUDV1=0
 F  S PSUDV1=$O(^XTMP("PSU_"_PSUJOB,"PSUDIV1",PSUDV1)) Q:PSUDV1=""  D
 .S PSUDVUD=0
 .F  S PSUDVUD=$O(^XTMP("PSU_"_PSUJOB,"PSUDIVUD",PSUDVUD)) Q:PSUDVUD=""  D
 ..I PSUDVUD=PSUDV1 D
 ...S PSUPT=0
 ...F  S PSUPT=$O(^XTMP("PSU_"_PSUJOB,"PSUDIV1",PSUDV1,PSUPT)) Q:PSUPT=""  D
 ....S ^XTMP("PSU_"_PSUJOB,"PSUINPT",PSUDV1,PSUPT)=""
 ....S PSUPT1=0
 ....F  S PSUPT1=$O(^XTMP("PSU_"_PSUJOB,"PSUDIVUD",PSUDVUD,PSUPT1)) Q:PSUPT1=""  D
 .....S ^XTMP("PSU_"_PSUJOB,"PSUINPT",PSUDVUD,PSUPT1)=""
 ..I PSUDVUD'=PSUDV1 D
 ...M ^XTMP("PSU_"_PSUJOB,"PSUINPT")=^XTMP("PSU_"_PSUJOB,"PSUDIVUD")
 Q
 ;
IPDIV1 ;Calculate inpatient totals
 ;
 S PSUSIT=0,PSUSIT1=0,T=1
 ;
 F  S PSUSIT=$O(^XTMP("PSU_"_PSUJOB,"PSUINPT",PSUSIT)) Q:PSUSIT=""  D
 .F  S PSUSIT1=$O(^XTMP("PSU_"_PSUJOB,"PSUINPT",PSUSIT,PSUSIT1)) Q:PSUSIT1=""  D
 ..I $D(^XTMP("PSU_"_PSUJOB,"PSUCOMBO",PSUSIT)) D
 ...S C=C+1
 ...S ^XTMP("PSU_"_PSUJOB,"PSUCOMBO",PSUSIT)=C
 ..I '$D(^XTMP("PSU_"_PSUJOB,"PSUCOMBO",PSUSIT)) D
 ...S C=1
 ...S ^XTMP("PSU_"_PSUJOB,"PSUCOMBO",PSUSIT)=C
 Q
 ;
TAB3 ;Place inpatient division totals into summary message
 ;
 N PSUTB1,PSUTB2
 ;
 N PSUTTL
 S PSULBL=0
 F  S PSULBL=$O(^XTMP("PSU_"_PSUJOB,"PSUCOMBO",PSULBL)) Q:PSULBL=""  D
 .S PSUTTL=$P($G(^XTMP("PSU_"_PSUJOB,"PSUCOMBO",PSULBL)),U,1)
 .I '$G(PSUTTL) S PSUTTL=0
 .D TAB1
 .S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="     "_PSULBL_" Division:"_PSUTB1_PSUTTL
 .S I=I+1
 Q
 ;
TAB4 ;Calculate inpatient totals of all divisions and place in summary
 ;message
 ;
 S N=0,PSUMKER=0
 F  S PSUMKER=$O(^XTMP("PSU_"_PSUJOB,"PSUCOMBO",PSUMKER)) Q:PSUMKER=""  D
 .S N=$P(^XTMP("PSU_"_PSUJOB,"PSUCOMBO",PSUMKER),U)+N
 S ^XTMP("PSU_"_PSUJOB,"PSUTOTAL")=N                 ;Sum of all inpatients
 ;
 D TAB1^PSUSUM3
 Q
 ;
NODATA ;Summary report line to be sent if there is no data
 ;
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",1)="PHARMACY UNIQUE PATIENTS REPORT"
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",2)=" "
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",3)="No data to report"
 D PDSUM^PSUDEM5
 Q
