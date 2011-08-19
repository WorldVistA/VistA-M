PSUUD7 ;BIR/DAM - UD AMIS Summary Message II;23 MAR 2004
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;Reference to file #40.8 supported by DBIA 2438
 ;
EN ;Entry point for MailMan message
 ;Called from PSUUD0
 ;
 K AMIS,DOSE,DOSTOT,SPEC,DIVTOT,GTOT    ;Kill arrays to hold data
 ;
 D MSG
 F PSULN=PSULN:1:(PSULN+3) S AMIS(PSULN)=""     ;Blank lines
 M ^XTMP("PSU_"_PSUJOB,"UDAMIS")=AMIS
 D MAIL
 ;
 Q
 ;
MSG ;Set up lines in message
 ;
 S Y=PSUSDT\1 X ^DD("DD") S PSUDTS=Y ;    start date
 S Y=PSUEDT\1 X ^DD("DD") S PSUDTE=Y ;    end date
 ;
 S X=PSUSNDR,DIC=40.8,DIC(0)="X",D="C" D IX^DIC
 S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
 S AMIS(1)="UD AMIS Summary for "_PSUDTS_" through "_PSUDTE_" for "_PSUDIVNM
 ;
 S AMIS(2)=""       ;Blank line
 ;
 S AMIS(3)="                                      NET"
 ;
 S AMIS(4)="                    DOSES   DOSES     DOSES     TOTAL     AVG COST"
 ;
 S AMIS(5)="DIVISION            DISP    RET       DISP      COST      PER DOSE"
 ;
 S $P(AMIS(6),"-",78)=""      ;Separator bar
 ;
 S PSULN=7
 ;
 D DOSE
 ;
 S $P(AMIS(PSULN),"-",78)="" S PSULN=PSULN+1      ;Separator bar
 ;
 D DOST
 ;
 F PSULN=PSULN:1:(PSULN+2) S AMIS(PSULN)=""       ;Blank lines
 S PULN=PSULN+1
 ;
 S AMIS(PSULN)="Division                Specialty             Total Patient Days of Care"
 ;
 S PSULN=PSULN+1
 ;
 S $P(AMIS(PSULN),"-",78)="" S PSULN=PSULN+1      ;Separator bar
 ;
 D DIV      ;Calculate division data
 D GTOT     ;Calculate grand totals
 Q
 ;
DOSE ;Set doses into array and set data into message
 ;
 M DOSE=^XTMP(PSUUDSUB,"DOSES")
 ;
 S PSUDIV=0
 F  S PSUDIV=$O(DOSE(PSUDIV)) Q:PSUDIV=""  D
 .S X=PSUDIV,DIC=40.8,DIC(0)="X",D="C" D IX^DIC
 .S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
 .S PSULINE=""
 .S $E(PSULINE,1,17)=PSUDIVNM
 .S $E(PSULINE,18,24)=$J($P(DOSE(PSUDIV),U,1),7)
 .S $E(PSULINE,25,32)=$J($P(DOSE(PSUDIV),U,2),8)
 .S $E(PSULINE,33,42)=$J($P(DOSE(PSUDIV),U,3),10)
 .S $E(PSULINE,44,45)="$"
 .S $E(PSULINE,46,53)=$J($P(DOSE(PSUDIV),U,4),8)
 .S $E(PSULINE,57,58)="$"
 .S $E(PSULINE,59,64)=$J($P(DOSE(PSUDIV),U,5),6)
 .S AMIS(PSULN)=PSULINE S PSULN=PSULN+1
 Q
 ;
DOST ;Set dose totals into array and set into message
 ;
 M DOSTOT=^XTMP(PSUUDSUB,"DOSTOT")
 I '$G(DOSTOT) S DOSTOT="0^0^0^0^0"
 ;
 S PSULINE=""
 S $E(PSULINE,1,17)="Total"
 S $E(PSULINE,18,24)=$J($P(DOSTOT,U,1),7)
 S $E(PSULINE,25,32)=$J($P(DOSTOT,U,2),8)
 S $E(PSULINE,33,42)=$J($P(DOSTOT,U,3),10)
 S $E(PSULINE,44,45)="$"
 S $E(PSULINE,46,53)=$J($P(DOSTOT,U,4),8)
 S $E(PSULINE,57,58)="$"
 S $E(PSULINE,59,64)=$J($P(DOSTOT,U,5),6)
 S AMIS(PSULN)=PSULINE S PSULN=PSULN+1
 Q
 ;
DIV ;Set division data into array and create message
 ;
 M SPEC=^XTMP(PSUUDSUB,"SPEC")
 ;
 ;
 S PSUDV=0
 F  S PSUDV=$O(SPEC(PSUDV)) Q:PSUDV=""  D
 .S X=PSUDV,DIC=40.8,DIC(0)="X",D="C" D IX^DIC
 .S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
 .S PSUSPC=0
 .N C
 .F  S PSUSPC=$O(SPEC(PSUDV,PSUSPC)) Q:PSUSPC=""  D
 ..S PSULINE=""
 ..I '$D(C) S $E(PSULINE,1,17)=PSUDIVNM S C=""
 ..S $E(PSULINE,25,49)=$P(SPEC(PSUDV,PSUSPC),U,1)
 ..S $E(PSULINE,50,59)=$J($P(SPEC(PSUDV,PSUSPC),U,2),10)
 ..S AMIS(PSULN)=PSULINE S PSULN=PSULN+1
 .D DIVTOT
 Q
 ;
DIVTOT ;Create message lines for division totals
 ;
 S $P(AMIS(PSULN),"-",78)="" S PSULN=PSULN+1      ;Separator bar 
 ;
 S PSULINE=""
 S $E(PSULINE,1,40)=PSUDIVNM_" Total"
 S $E(PSULINE,50,59)=$J(^XTMP(PSUUDSUB,"DIVTOT",PSUDV),10)
 S AMIS(PSULN)=PSULINE
 ;
 S PSULN=PSULN+1
 ;
 F PSULN=PSULN:1:(PSULN+2) S AMIS(PSULN)=""     ;Blank lines
 S PSULN=PSULN+1
 Q
 ;
GTOT ;Calculate grand total patient days of care for all divisions
 ;
 S $P(AMIS(PSULN),"-",78)="" S PSULN=PSULN+1      ;Separator bar
 ;
 S PSULINE=""
 S $E(PSULINE,1,40)="Grand Total"
 S $E(PSULINE,50,59)=$J($G(^XTMP(PSUUDSUB,"GTOT")),10)
 S AMIS(PSULN)=PSULINE S PSULN=PSULN+1
 ;
 ;
 Q
 ;
MAIL ;Send mailman message
 ;
 ;Do not send report if option selection includes 1,2,3,4,6
 I $D(^XTMP("PSU_"_PSUJOB,"CBAMIS")) D  Q
 .M ^XTMP("PSU_"_PSUJOB,"UDCOMBO")=AMIS
 .S ^XTMP("PSU_"_PSUJOB,"UDCOMBO",1)="INPATIENT:"
 ;
 S X=PSUSNDR,DIC=40.8,DIC(0)="X",D="C" D IX^DIC
 S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
 ;
 S XMSUB="V. 4.0 PBMUD "_PSUMON_" "_PSUSNDR_" "_PSUDIVNM
 S XMTEXT="AMIS("
 S XMDUZ=DUZ
 M XMY=PSUXMY
 S XMCHAN=1
 I PSUMASF!PSUDUZ!PSUPBMG D ^XMD
 ;
 Q
