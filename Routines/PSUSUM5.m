PSUSUM5 ;BIR/DAM - Patient Demographics Summary for IV/UD ; 20 DEC 2001
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
EN ;EN CALLED FROM PSUUD0
 ;
 I $D(^XTMP("PSU_"_PSUJOB,"PSUFLAG2"))!$D(^XTMP("PSU_"_PSUJOB,"PSUFLAG3")) K ^XTMP("PSU_"_PSUJOB,"PSUSUMA")
 I $D(^XTMP("PSU_"_PSUJOB,"PSUNONE","IV"))&$D(^XTMP("PSU_"_PSUJOB,"PSUNONE","UD")) D  Q    ;Summary report if there is no data
 .D NODATA
 .I $D(^XTMP("PSU_"_PSUJOB,"PSUFLAG1"))!$D(^XTMP("PSU_"_PSUJOB,"PSUFLAG2")) K ^XTMP("PSU_"_PSUJOB,"PSUNONE")
 ;
 D DATE
 S I=7         ;Line Counter
 D UNIQUE
 D DIV
 D TOTAL
 D TAB1^PSUSUM4
 D PDSUM^PSUDEM5      ;Mail message
 K ^XTMP("PSU_"_PSUJOB,"PSUIVOUT")
 K ^XTMP("PSU_"_PSUJOB,"PSUUDIN")
 I $D(^XTMP("PSU_"_PSUJOB,"PSUFLAG2")) K ^XTMP("PSU_"_PSUJOB,"PSUSUMA")
 K ^XTMP("PSU_"_PSUJOB,"PSUFIN")
 K ^XTMP("PSU_"_PSUJOB,"PSUIVSSN")
 K ^XTMP("PSU_"_PSUJOB,"PSUIVDIV")
 K ^XTMP("PSU_"_PSUJOB,"PSUNEW")
 K ^XTMP("PSU_"_PSUJOB,"PSUTOTAL")
 K ^XTMP("PSU_"_PSUJOB,"PSUFLAG2")
 K ^XTMP("PSU_"_PSUJOB,"PSUFLAG3")
 K ^XTMP("PSU_"_PSUJOB,"PSUUDDIV")
 ;
 K ^XTMP("PSU_"_PSUJOB,"PSURXCTA")
 Q
 ;
DATE ;Convert date range of extract to external format
 ;
 D PULL^PSUCP
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
 D IVUDSUM
 Q
 ;
IVUDSUM ;Summary report header
 ;
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",1)="PHARMACY INPATIENT (UD & IV) UNIQUE PATIENTS REPORT          "_PSUD
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",2),"-",80)=""                ;Separator bar
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",3)="                 "_PSUS_"  through  "_PSUE
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",4),"=",80)=""
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",5)="                                                           UNIQUE"
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",6),"-",70)=""
 Q
 ;
UNIQUE ;Find Total unique patient number across all divisions
 ;
 N PSUSIT
 S PSUSIT=PSUSNDR
 ;
 N PSUIPSUM,PSUOPSUM
 I '$D(^XTMP("PSU_"_PSUJOB,"PSUIVIN")) S $P(^XTMP("PSU_"_PSUJOB,"PSUIVIN"),U,1)=0
 I '$D(^XTMP("PSU_"_PSUJOB,"PSUUDIN")) S $P(^XTMP("PSU_"_PSUJOB,"PSUUDIN"),U,1)=0
 I '$D(^XTMP("PSU_"_PSUJOB,"PSUIVOUT")) S $P(^XTMP("PSU_"_PSUJOB,"PSUIVOUT"),U,1)=0
 ;
 ;Create IP unique global.  Screen out duplicates
 M ^XTMP("PSU_"_PSUJOB,"PSUIPSUM")=^XTMP("PSU_"_PSUJOB,"PSUUDIN")
 M ^XTMP("PSU_"_PSUJOB,"PSUIPSUM")=^XTMP("PSU_"_PSUJOB,"PSUIN")
 ;
 S N=1
 S PSUSUM=0
 F  S PSUSUM=$O(^XTMP("PSU_"_PSUJOB,"PSUIPSUM",PSUSUM))  Q:PSUSUM=""  D
 .S PSUIPSUM=N S N=N+1
 ;
 S PSUOPSUM=$P($G(^XTMP("PSU_"_PSUJOB,"PSUIVOUT")),U,1)
 D TAB
 Q
 ;
TAB ;Calculate tab spacing
 ;
 N PSUTB2,PSUTB3,PSUTB4,PSUTB5
 ;
 S PSUTB1=" "
 S PSUTB2="Total Inpatients across all divisions:"
 S PSUTB3=(64-$L(PSUIPSUM))-$L(PSUTB2)
 F S2=1:1:(PSUTB3-1) S PSUTB(S2)=" " D
 .S PSUTB1=PSUTB1_PSUTB(S2)
 ;
 S PSUTB6=" "
 S PSUTB4="Total Outpatients across all divisions:"
 S PSUTB5=(64-$L(PSUOPSUM))-$L(PSUTB4)
 F S3=1:1:(PSUTB5-1) S PSUTB(S3)=" " D
 .S PSUTB6=PSUTB6_PSUTB(S3)
 D TOT
 Q
 ;
TOT ;Set total number of unique in-patients and out-patients into
 ;summary message
 ;
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)=PSUTB2_PSUTB1_(PSUIPSUM) S I=I+1
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)=PSUTB4_PSUTB6_(PSUOPSUM) S I=I+1
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUMA",I),"-",70)="" S I=I+1
 Q
 ;
DIV ;Set all divisions from both IV and UD extracts into one global
 ;
 M ^XTMP("PSU_"_PSUJOB,"PSUFIN")=^XTMP("PSU_"_PSUJOB,"PSUDIV1")    ;IP division name/SSN
 M ^XTMP("PSU_"_PSUJOB,"PSUFIN")=^XTMP("PSU_"_PSUJOB,"PSUDIVUD")   ;UD division name/SSN
 Q
 S E=1        ;Counter for new global
 S PSUZ=0
 F  S PSUZ=$O(^XTMP("PSU_"_PSUJOB,"PSUIVINDIV",PSUZ)) Q:PSUZ=""  D
 .S ^XTMP("PSU_"_PSUJOB,"PSUNEW",PSUZ,E)=$P($G(^XTMP("PSU_"_PSUJOB,"PSUIVINDIV",PSUZ)),U,1)   ;IV
 .S E=E+1
 ;
 S PSUZ1=0
 F  S PSUZ1=$O(^XTMP("PSU_"_PSUJOB,"PSUUDDIV",PSUZ1)) Q:PSUZ1=""  D
 .S ^XTMP("PSU_"_PSUJOB,"PSUNEW",PSUZ1,E)=$P($G(^XTMP("PSU_"_PSUJOB,"PSUUDDIV",PSUZ1)),U,1)
 .S E=E+1
 Q
 ;
 ;
TOTAL ;Calculate sum of all divisions and set individual division lines
 ;into summary message
 ;
 S T=1
 S PSUDNAM=0
 F  S PSUDNAM=$O(^XTMP("PSU_"_PSUJOB,"PSUFIN",PSUDNAM)) Q:PSUDNAM=""  D
 .S PSUNUM1=0
 .F  S PSUNUM1=$O(^XTMP("PSU_"_PSUJOB,"PSUFIN",PSUDNAM,PSUNUM1)) Q:PSUNUM1=""  D
 ..S ^XTMP("PSU_"_PSUJOB,"PSUTOTAL")=T S T=T+1     ;Set total count
 ..I $D(^XTMP("PSU_"_PSUJOB,"PSUTOT",PSUDNAM)) D
 ...S C=C+1
 ...S ^XTMP("PSU_"_PSUJOB,"PSUTOT",PSUDNAM)=C
 ..I '$D(^XTMP("PSU_"_PSUJOB,"PSUTOT",PSUDNAM)) D
 ...S C=1
 ...S ^XTMP("PSU_"_PSUJOB,"PSUTOT",PSUDNAM)=C
 ;
 S PSUDNAM1=0
 N PSUSNUM
 F  S PSUDNAM1=$O(^XTMP("PSU_"_PSUJOB,"PSUTOT",PSUDNAM1)) Q:PSUDNAM1=""  D
 .S PSUNUM=$P($G(^XTMP("PSU_"_PSUJOB,"PSUTOT",PSUDNAM1)),U,1)
 .D TAB1
 .S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",I)="     "_PSUDNAM1_" Division:"_PSUTB6_PSUNUM
 .S I=I+1
 ;
 Q
 ;
TAB1 ;Calculate tab spacing
 ;
 S PSUTB6=" "
 S PSUTB7=(59-$L(PSUNUM))-$L(PSUDNAM1)-10
 F S2=1:1:(PSUTB7-1) S PSUTB(S2)=" " D
 .S PSUTB6=PSUTB6_PSUTB(S2)                  ;Tab position
 Q
 ;
NODATA ;Summary report line to be sent if there is no data
 ;
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",1)="PHARMACY INPATIENT (UD & IV) UNIQUE PATIENTS REPORT"
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",2)=" "
 S ^XTMP("PSU_"_PSUJOB,"PSUSUMA",3)="No data to report"
 D PDSUM^PSUDEM5
 Q
