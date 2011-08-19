PSUUD6 ;BIR/DAM - UD AMIS Summary Message I;23 MAR 2004
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;Reference to file #42.6 supported by DBIA 4597
 ;Reference to file #42.7 supported by DBIA 4598
 ;Reference to file #40.8 supported by DBIA 2438
 ;
EN ;Entry point to construct globals for AMIS summary message
 ;Called from PSUUD3
 ;
 K UDAM      ;array to hold tabulated data
 K SPEC      ;array to hold specialty data
 ;
 S PSUDV=0
 F  S PSUDV=$O(^XTMP(PSUUDSUB,"DIS",PSUDV)) Q:PSUDV=""  D
 .D DISP
 .D RET
 .D TCOST
 .D NET
 .D AVG
 .D TRUNC
 .D SPEC
 .D DIVT
 .D GRAND
 ;
 D TOTAL
 ;
 Q
 ;
DISP ;Add doses dispensed of all drugs for each division
 ;
 N DSP,A
 S DSP=^XTMP(PSUUDSUB,"DISP",PSUDV)
 S $P(UDAM(PSUDV),U,1)=DSP
 ;
 I $P(UDAM(PSUDV),U,1)["." D
 .S A=$F($P(UDAM(PSUDV),U,1),".")  ;Find 1st position after decimal
 .S $P(UDAM(PSUDV),U,1)=$E($P(UDAM(PSUDV),U,1),1,(A-2))  ;Truncate
 ;
 Q
 ;
RET ;Add doses returned of all drugs for each division
 ;
 N RET,A
 S RET=^XTMP(PSUUDSUB,"RET",PSUDV)
 S $P(UDAM(PSUDV),U,2)=RET
 ;
 I $P(UDAM(PSUDV),U,2)["." D
 .S A=$F($P(UDAM(PSUDV),U,2),".")  ;Find 1st position after decimal
 .S $P(UDAM(PSUDV),U,2)=$E($P(UDAM(PSUDV),U,2),1,(A-2))  ;Truncate
 Q
 ;
NET ;Calculate Net doses dispensed of all drugs
 ;
 S $P(UDAM(PSUDV),U,3)=$P(UDAM(PSUDV),U,1)-$P(UDAM(PSUDV),U,2)
 ;
 Q
 ;
TCOST ;Find total cost per drug
 ;
 N CST,DP,RT,NT
 ;
 S CST=^XTMP(PSUUDSUB,"CST",PSUDV)    ;Price per dispensed unit
 ;
 S $P(UDAM(PSUDV),U,4)=CST
 ;
 Q
 ;
AVG ;Calculate average cost per dose
 ;
 N TCST,NET
 ;
 S NET=$P(UDAM(PSUDV),U,3)         ;Net doses dispensed
 ;
 I $G(NET)'>0 S NET=1
 ;
 S TCST=$P(UDAM(PSUDV),U,4)        ;Total cost
 ;
 S $P(UDAM(PSUDV),U,5)=$P($G(UDAM(PSUDV)),U,5)+(TCST/NET)
 ;
 Q
 ;
TRUNC ;Truncate pieces with dollar values to 2 decimal places
 ;
 F I=4:1:5 D
 .N A,B,C
 .;
 .I $P(UDAM(PSUDV),U,I)'["." D  Q
 ..S $P(UDAM(PSUDV),U,I)=$P(UDAM(PSUDV),U,4)_".00"
 .;
 .S A=$F($P(UDAM(PSUDV),U,I),".")  ;Find 1st position after decimal
 .;
 .S B=$E($P(UDAM(PSUDV),U,I),1,(A-1))  ;Extract dollars and decimal
 .;
 .S C=$E($P(UDAM(PSUDV),U,I),A,(A+1))  ;Extract cents after decimal
 .;
 .I $L(C)'=2 S C=$E(C,1)_0
 .;
 .S $P(UDAM(PSUDV),U,I)=B_C
 ;
 M ^XTMP(PSUUDSUB,"DOSES",PSUDV)=UDAM(PSUDV)
 Q
 ;
TOTAL ;Add dose totals of all divisions
 ;
 N DTOT,RTOT,NETOT,TCST,ACST
 ;
 S PSUD=0
 F  S PSUD=$O(UDAM(PSUD)) Q:PSUD=""  D
 .S DTOT=$G(DTOT)+$P(UDAM(PSUD),U,1)       ;Total of doses dispensed
 .S RTOT=$G(RTOT)+$P(UDAM(PSUD),U,2)       ;Total of returned doses
 .S NETOT=$G(NETOT)+$P(UDAM(PSUD),U,3)     ;Total of net doses disp
 .S TCST=$G(TCST)+$P(UDAM(PSUD),U,4)       ;Total of total cost
 .;S ACST=$G(ACST)+$P(UDAM(PSUD),U,5)       ;Total of average cost
 .I $G(NETOT) S ACST=$G(TCST)/$G(NETOT) D
 ..I ACST'["." S ACST=ACST_".00" Q
 ..N A,B,C
 ..S A=$F(ACST,".")  ;Find 1st position after decimal
 ..S B=$E(ACST,1,(A-1))   ;Extract dollars and decimal
 ..S C=$E(ACST,A,(A+1))   ;Extract cents after decimal
 ..I $L(C)'=2 S C=$E(C,1)_0
 ..S ACST=B_C
 ;
 S ^XTMP(PSUUDSUB,"DOSTOT")=DTOT_U_RTOT_U_NETOT_U_TCST_U_ACST
 ;
 Q
 ;
SPEC ;Find out if a monthly extract is being run
 ;
 N PSUMT,PSUMTH
 I $D(PSUMON) D
 .S PSUMT=PSUMON_"00"
 .I $D(^DGAM(334,"B",PSUMT)) D SPEC1
 .;
 .S PSUMTH=PSUMT
 .I $D(^DGAM(345,"B",PSUMTH)) D SPEC2
 ;
 Q
 ;
SPEC1 ;Find division names from File (#42.6) records within
 ;the month of the extract
 ;
 N PSUDNM
 ;
 M SPEC(334,PSUMT)=^DGAM(334,PSUMT)    ;set node into array
 ;
 S PSUD1=0
 F  S PSUD1=$O(SPEC(334,PSUMT,"SE",PSUD1)) Q:PSUD1=""  D
 .S PSUD2=0
 .F  S PSUD2=$O(SPEC(334,PSUMT,"SE",PSUD1,"D",PSUD2)) Q:PSUD2=""  D
 ..;find division and match to DIVNM
 ..S X=PSUD2
 ..S PSUNM=$$VAL^PSUTL(40.8,X,.01)
 ..S X=PSUDV,DIC=40.8,DIC(0)="X",D="C" D IX^DIC
 ..S X=+Y S PSUDNM=$$VAL^PSUTL(40.8,X,.01)
 ..I PSUNM=PSUDNM D REC1
 Q
 ;
REC1 ;Create a record of specialties and days of patient care for File #42.6
 ;for each division within the month of the extract
 ;
 N SPC,DAYA,DAYB,SPCE
 ;
 S SPC=$P(SPEC(334,PSUMT,"SE",PSUD1,0),U,1)   ;Specialty code
 ;
 S DAYA=$P(SPEC(334,PSUMT,"SE",PSUD1,"D",PSUD2,0),U,12) ;Days of care
 ;
 S DAYB=$P(SPEC(334,PSUMT,"SE",PSUD1,"D",PSUD2,0),U,24) ;Days of care >45
 ;
 ;
 ;Find external form of specialty
 S:SPC=334 SPCE="PSYCHIATRY"
 S:SPC=335 SPCE="INTERMEDIATE"
 S:SPC=336 SPCE="MEDICINE"
 S:SPC=337 SPCE="NEUROLOGY"
 S:SPC=338 SPCE="REHAB MEDICINE"
 S:SPC=339 SPCE="BLIND REHAB"
 S:SPC=340 SPCE="SPINAL CORD INJURY"
 S:SPC=341 SPCE="SURGERY"
 ;
 S ^XTMP(PSUUDSUB,"SPEC",PSUDV,SPC)=SPCE_U_(DAYA+DAYB)   ;Record created
 ;
 Q
 ;
SPEC2 ;Find division names from File (#42.7) records within
 ;the month of the extract
 ;
 N PSUDNAM
 M SPEC(345,PSUMTH)=^DGAM(345,PSUMTH)    ;set node into array
 ;
 S PSUD1=0
 F  S PSUD1=$O(SPEC(345,PSUMTH,"SE",PSUD1)) Q:PSUD1=""  D
 .S PSUD2=0
 .F  S PSUD2=$O(SPEC(345,PSUMTH,"SE",PSUD1,"D",PSUD2)) Q:PSUD2=""  D
 ..;find division and match to DIVNM
 ..S X=PSUD2
 ..S PSUNM=$$VAL^PSUTL(40.8,X,.01)
 ..S X=PSUDV,DIC=40.8,DIC(0)="X",D="C" D IX^DIC
 ..S X=+Y S PSUDNAM=$$VAL^PSUTL(40.8,X,.01)
 ..I PSUNM=PSUDNAM D REC2
 ;
 Q
 ;
REC2 ;Create a record of specialties and days of patient care for File #42.7
 ;for each division within the month of the extract
 ;
 N SPC,DAY,SPCE
 ;
 S SPC=$P($G(SPEC(345,PSUMTH,"SE",PSUD1,0)),U,1)   ;Specialty code
 ;
 S DAY=$P($G(SPEC(345,PSUMTH,"SE",PSUD1,"D",PSUD2,0)),U,16) ;Days of care
 ;
 ;Find external form of specialty
 S:SPC=345 SPCE="VA NURSING HOME"
 ;
 I $D(SPCE) D
 .S ^XTMP(PSUUDSUB,"SPEC",PSUDV,SPC)=SPCE_U_DAY      ;Record created
 Q
 ;
DIVT ;Calculate division totals
 ;
 N TOT
 S PSUSP=0
 F  S PSUSP=$O(^XTMP(PSUUDSUB,"SPEC",PSUDV,PSUSP)) Q:PSUSP=""  D
 .S TOT=$G(TOT)+$P(^XTMP(PSUUDSUB,"SPEC",PSUDV,PSUSP),U,2)
 .S ^XTMP(PSUUDSUB,"DIVTOT",PSUDV)=TOT
 Q
 ;
GRAND ;Calculate grand total of all divisions
 ;
 ;
 S ^XTMP(PSUUDSUB,"GTOT")=$G(^XTMP(PSUUDSUB,"GTOT"))+$G(^XTMP(PSUUDSUB,"DIVTOT",PSUDV))
 ;
 Q
