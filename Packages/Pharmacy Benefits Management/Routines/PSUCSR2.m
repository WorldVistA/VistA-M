PSUCSR2 ;BIR/DAM - PBM CS AMIS SUMMARY;6 APR 2004
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;Reference to file #40.8 supported by DBIA 2438
 ;
EN ;Entry point to create AMIS summary report
 ;Called from ^PSUCSR1
 ;
 N TYP
 K CSAM
 ;
 S PSUDV=0
 F  S PSUDV=$O(^XTMP(PSUCSJB,"RECORDS",PSUDV)) Q:PSUDV=""  D
 .S PSUA=0
 .F  S PSUA=$O(^XTMP(PSUCSJB,"RECORDS",PSUDV,PSUA)) Q:PSUA=""  D
 ..S PSUB=0
 ..F  S PSUB=$O(^XTMP(PSUCSJB,"RECORDS",PSUDV,PSUA,PSUB)) Q:PSUB=""  D
 ...S TYP=^XTMP(PSUCSJB,"RECORDS",PSUDV,PSUA,PSUB,0)
 ...I TYP=2 D
 ....D DISP
 ....D TCOST
 .Q:'$D(CSAM(PSUDV))
 .D AVE
 .D TRUNC
 ;
 D TOTAL
 D MSG
 D MAIL
 ;
 Q
 ;
DISP ;Calculate orders dispensed
 ;
 S $P(CSAM(PSUDV),U,1)=$P($G(CSAM(PSUDV)),U,1)+1
 ;
 Q
 ;
TCOST ;Calculate total cost of orders dispensed
 ;
 N QTY,PRC
 ;
 S QTY=^XTMP(PSUCSJB,"RECORDS",PSUDV,PSUA,PSUB,17)
 S PRC=^XTMP(PSUCSJB,"RECORDS",PSUDV,PSUA,PSUB,16)
 ;
 S $P(CSAM(PSUDV),U,2)=$P($G(CSAM(PSUDV)),U,2)+(QTY*PRC)
 ;
 Q
 ;
AVE ;Calculate average cost per order
 ;
 N TCST,DSP
 ;
 S DSP=$P(CSAM(PSUDV),U,1)
 S TCST=$P(CSAM(PSUDV),U,2)
 ;
 S $P(CSAM(PSUDV),U,3)=$P($G(CSAM(PSUDV)),U,3)+(TCST/DSP)
 ;
 Q
 ;
TRUNC ;Truncate pieces with dollar values to 2 decimal places
 ;
 F I=2:1:3 D
 .N A,B,C
 .;
 .I $P(CSAM(PSUDV),U,I)'["." D  Q
 ..S $P(CSAM(PSUDV),U,I)=$P(CSAM(PSUDV),U,I)_".00"
 .;
 .S A=$F($P(CSAM(PSUDV),U,I),".")  ;Find first position after decimal
 .;
 .S B=$E($P(CSAM(PSUDV),U,I),1,(A-1))  ;Extract dollars and decimal
 .;
 .S C=$E($P(CSAM(PSUDV),U,I),A,(A+1))  ;Extract cents after decimal
 .;
 .I $L(C)'=2 S C=$E(C,1)_0
 .;
 .S $P(CSAM(PSUDV),U,I)=B_C
 ;
 Q
TOTAL ;Add column totals
 ;
 N TDSP,TCST,TAVE
 ;
 S PSUDIV=0
 F  S PSUDIV=$O(CSAM(PSUDIV)) Q:PSUDIV=""  D
 .S TDSP=$G(TDSP)+$P(CSAM(PSUDIV),U,1)    ;Total orders dispensed
 .S TCST=$G(TCST)+$P(CSAM(PSUDIV),U,2)    ;Total of total costs
 .I $G(TDSP) S TAVE=$G(TCST)/TDSP D
 ..I TAVE'["." S TAVE=TAVE_".00" Q
 ..N A,B,C
 ..S A=$F(TAVE,".")  ;Find 1st position after decimal
 ..S B=$E(TAVE,1,(A-1))   ;Extract dollars and decimal
 ..S C=$E(TAVE,A,(A+1))   ;Extract cents after decimal
 ..I $L(C)'=2 S C=$E(C,1)_0
 ..S TAVE=B_C
 ;
 S TOTAL("TOT")=$G(TDSP)_U_$G(TCST)_U_$G(TAVE)
 ;
 Q
 ;
MSG ;Construct lines for the MailMan message
 ;
 S Y=PSUSDT\1 X ^DD("DD") S PSUDTS=Y ;    start date
 S Y=PSUEDT\1 X ^DD("DD") S PSUDTE=Y ;    end date
 ;
 K AMISC      ;Array to hold message lines
 ;
 S AMISC(1)="Controlled AMIS Summary for "_PSUDTS_" through "_PSUDTE_" for "_PSUDIVNM
 ;
 S AMISC(2)=""                       ;Blank line
 ;
 I '$D(CSAM) D  Q
 .S AMISC(3)=" "
 .S AMISC(4)="No data to report"
 .S AMISC(5)=" "
 ;
 S ^XTMP(PSUCSJB,"MAIL",PSUMC)=PSUDIV
 ;
 S AMISC(3)="INPATIENT CONTROLLED SUBSTANCE ORDERS:"
 ;
 S AMISC(4)=""                       ;Blank line
 ;
 S AMISC(5)="                            ORDERS               TOTAL     AVE COST"
 S AMISC(6)="DIVISION                    DISPENSED            COST      PER ORDER"
 ;
 S $P(AMISC(7),"-",78)=""      ;Separator bar
 ;
 S PSULN=8
 ;
 S PSUDIV=0
 F  S PSUDIV=$O(CSAM(PSUDIV)) Q:PSUDIV=""  D
 .S X=PSUDIV,DIC=40.8,DIC(0)="X",D="C" D IX^DIC
 .S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
 .S PSULINE=""
 .S $E(PSULINE,1,17)=PSUDIVNM
 .S $E(PSULINE,18,35)=$J($P(CSAM(PSUDIV),U,1),18)
 .S $E(PSULINE,41,42)="$"
 .S $E(PSULINE,43,53)=$J($P(CSAM(PSUDIV),U,2),11)
 .S $E(PSULINE,60,61)="$"
 .S $E(PSULINE,62,67)=$J($P(CSAM(PSUDIV),U,3),6)
 .S AMISC(PSULN)=PSULINE S PSULN=PSULN+1
 ;
 S $P(AMISC(PSULN),"-",78)=""     ;Separator bar
 S PSULN=PSULN+1
 ;
 S PSULINE=""
 S $E(PSULINE,1,17)="Total"
 S $E(PSULINE,18,35)=$J($P(TOTAL("TOT"),U,1),18)
 S $E(PSULINE,41,42)="$"
 S $E(PSULINE,43,53)=$J($P(TOTAL("TOT"),U,2),11)
 S $E(PSULINE,60,61)="$"
 S $E(PSULINE,62,67)=$J($P(TOTAL("TOT"),U,3),6)
 S AMISC(PSULN)=PSULINE S PSULN=PSULN+1
 ;
 F PSULN=PSULN:1:(PSULN+2) S AMISC(PSULN)=""     ;Blank lines
 Q
 ;
MAIL ;Mail CS AMIS summary report
 ;
 ;Do not send report if option selection includes 1,2,3,4,6
 ;Instead send the combined AMIS summary report
 I $D(^XTMP("PSU_"_PSUJOB,"CBAMIS")) D  Q
 .M ^XTMP("PSU_"_PSUJOB,"CSCOMBO")=AMISC
 .S ^XTMP("PSU_"_PSUJOB,"CSCOMBO",1)=""
 .D EN^PSUAMC
 ;
 M XMY=PSUXMYS2
 ;
 S X=PSUSNDR,DIC=40.8,DIC(0)="X",D="C" D IX^DIC
 S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
 ;
 S XMSUB="V. 4.0 PBMCS "_PSUMON_" "_PSUSNDR_" "_PSUDIVNM
 S XMTEXT="AMISC("
 M ^XTMP("PSU_"_PSUJOB,"CSAMIS")=AMISC
 S XMCHAN=1
 D ^XMD
 ;
 Q
