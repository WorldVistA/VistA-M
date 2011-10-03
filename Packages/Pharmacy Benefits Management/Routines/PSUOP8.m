PSUOP8 ;BIR/DAM - Outpatient AMIS Summary Message;04 MAR 2004
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;Reference to file #59  supported by DBIA 2510
 ;
EN ;Entry point for MailMan message
 ;Called from PSUOP0
 ;
 Q:$D(^XTMP("PSU_"_PSUJOB,"PSUFLAG"))  ;Quit if Provider extract only
 D MSG
 D MAIL
 Q
 ;
MSG ;Create the Rx AMIS summary mailman message
 ;Called from PSUOP0
 ;
 S (PSU30,PSU60,PSU90,PSUNADJ,PSUEQ,PSUTCST,PSUNADC,PSUCFIL)=""
 S (PSUNEW,PSUREF,PSUWN,PSUWNCS,PSUML,PSUMLCS,PSUMP,PSULC)=""
 S (PSUSTF,PSUFEE,PSULOCS,PSUSTNM)=""
 ;
 S PSUST=$P($G(^XTMP("PSU_"_PSUJOB,"PSUSITE")),U,1)    ;Facility #
 S PSUSTNM=$P($G(^XTMP("PSU_"_PSUJOB,"PSUSITE")),U,2)  ;Facility name
 ;
 D TCOST      ;Calculate total cost for all Rx fills
 ;
 S Y=PSUSDT X ^DD("DD") S PSUDTS=Y
 S Y=PSUEDT X ^DD("DD") S PSUDTE=Y
 S AMIS(1)="Outpatient AMIS Summary for "_PSUDTS_" through "_PSUDTE_" for "_PSUSTNM
 ;
 S AMIS(2)=""
 ;
 S AMIS(3)="                                                         Unadj     30Day                      Cost/          Cost/"
 ;
 S AMIS(4)="                      30Day        60Day      90Day      Total     Equiv        Total        Unadj          30Day"
 ;
 S AMIS(5)="Division              Fills        Fills      Fills      Fills     Fills        Cost          Fill           Fill"
 ;
 S $P(AMIS(6),"-",132)=""      ;Separator bar
 ;
 S PSULN=7
 ;
 S PSUDVN=0
 F  S PSUDVN=$O(^TMP($J,"FILL",PSUDVN)) Q:PSUDVN=""  D
 .S X=PSUDVN,DIC=59,DIC(0)="XM" D ^DIC     ;Find division name
 .S X=+Y,PSUDIVNM=$$VAL^PSUTL(59,X,.01)
 .I '$G(PSUDIVNM) S X=PSUDVN,DIC=40.8,DIC(0)="X",D="C" D IX^DIC D
 ..S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
 .D VAR
 .D UNADCST
 .D FILL
 .D TOTAL1
 .;
 .;Construct line with spacing
 .S PSULINE=""
 .S $E(PSULINE,1,17)=PSUDIVNM
 .S $E(PSULINE,18,28)=$J(FILL30,11)
 .S $E(PSULINE,29,39)=$J(FILL60,11)
 .S $E(PSULINE,40,50)=$J(FILL90,11)
 .S $E(PSULINE,51,61)=$J(UNAD,11)
 .S $E(PSULINE,62,72)=$J(EQUIV,11)
 .S $E(PSULINE,74,75)="$"
 .S $E(PSULINE,76,88)=$J(TCOST(PSUDVN),13)
 .S $E(PSULINE,90,91)="$"
 .S $E(PSULINE,92,102)=$J(UNADC(PSUDVN),11)
 .S $E(PSULINE,104,105)="$"
 .S $E(PSULINE,106,116)=$J(CFILL(PSUDVN),11)
 .;End line
 .S AMIS(PSULN)=PSULINE S PSULN=PSULN+1
 ;
 S $P(AMIS(PSULN),"-",132)="" S PSULN=PSULN+1      ;Separator bar
 ;
 ;Construct line with spacing
 S PSULINE=""
 S $E(PSULINE,1,17)="Total"
 S $E(PSULINE,18,28)=$J(PSU30,11)
 S $E(PSULINE,29,39)=$J(PSU60,11)
 S $E(PSULINE,40,50)=$J(PSU90,11)
 S $E(PSULINE,51,61)=$J(PSUNADJ,11)
 S $E(PSULINE,62,72)=$J(PSUEQ,11)
 S $E(PSULINE,74,75)="$"
 S $E(PSULINE,76,88)=$J(PSUTCST,13)
 S $E(PSULINE,90,91)="$"
 S $E(PSULINE,92,102)=$J(PSUNADC,11)
 S $E(PSULINE,104,105)="$"
 S $E(PSULINE,106,116)=$J(PSUCFIL,11)
 ;End line construction
 ;
 S AMIS(PSULN)=PSULINE S PSULN=PSULN+1
 ;
 F PSULN=PSULN:1:(PSULN+2) S AMIS(PSULN)=""     ;Blank lines
 S PSULN=PSULN+1
 ;
 S AMIS(PSULN)="Unadjusted             New       Ref          Win           Mail               CMOP         Local           Staff         Fee" S PSULN=PSULN+1
 ;
 S AMIS(PSULN)="Division                Rx        Rx         Rx(CS)        Rx(CS)               Rx          Rx(CS)            Rx           Rx" S PSULN=PSULN+1
 ;
 S $P(AMIS(PSULN),"-",132)="" S PSULN=PSULN+1      ;Separator bar
 ;
 S PSUDVN=0
 F  S PSUDVN=$O(^TMP($J,"NEW",PSUDVN)) Q:PSUDVN=""  D
 .S X=PSUDVN,DIC=59,DIC(0)="XM" D ^DIC     ;Find division name
 .S X=+Y,PSUDIVNM=$$VAL^PSUTL(59,X,.01)
 .I '$G(PSUDIVNM) S X=PSUDVN,DIC=40.8,DIC(0)="X",D="C" D IX^DIC D
 ..S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
 .D VAR2
 .D TOTAL2
 .;Construct line with spacing
 .S PSULINE=""
 .S $E(PSULINE,1,17)=PSUDIVNM
 .S $E(PSULINE,18,27)=$J(PSUN,10)
 .S $E(PSULINE,28,37)=$J(PSUR,10)
 .S $E(PSULINE,38,47)=$J(PSUW,10)
 .S $E(PSULINE,48,57)="("_PSUWCS_")"
 .S $E(PSULINE,58,67)=$J(PSUM,10)
 .S $E(PSULINE,68,77)="("_PSUMCS_")"
 .S $E(PSULINE,78,87)=$J(PSUMOP,10)
 .S $E(PSULINE,88,97)=$J(PSULOC,10)
 .S $E(PSULINE,98,107)="("_PSULCS_")"
 .S $E(PSULINE,108,117)=$J(PSUTF,10)
 .S $E(PSULINE,118,127)=$J(PSUFE,10)
 .;End construction of line
 .S AMIS(PSULN)=PSULINE S PSULN=PSULN+1
 ;
 S $P(AMIS(PSULN),"-",132)="" S PSULN=PSULN+1      ;Separator bar
 ;
 ;Construct line with spacing
 S PSULINE=""
 S $E(PSULINE,1,15)="Total"
 S $E(PSULINE,18,27)=$J(PSUNEW,10)
 S $E(PSULINE,28,37)=$J(PSUREF,10)
 S $E(PSULINE,38,47)=$J(PSUWN,10)
 S $E(PSULINE,48,57)="("_PSUWNCS_")"
 S $E(PSULINE,58,67)=$J(PSUML,10)
 S $E(PSULINE,68,77)="("_PSUMLCS_")"
 S $E(PSULINE,78,87)=$J(PSUMP,10)
 S $E(PSULINE,88,97)=$J(PSULC,10)
 S $E(PSULINE,98,107)="("_PSULOCS_")"
 S $E(PSULINE,108,117)=$J(PSUSTF,10)
 S $E(PSULINE,118,127)=$J(PSUFEE,10)
 ;End construction of line
 S AMIS(PSULN)=PSULINE S PSULN=PSULN+1
 ;
 Q
 ;
VAR ;Set contents of ^TMP global into VARIABLES
 ;
 S (FILL30,FILL60,FILL90,UNAD,EQUIV)=""
 ;
 S FILL30=^TMP($J,"FILL",PSUDVN,30)      ;30 DAY FILLS
 ;
 S FILL60=^TMP($J,"FILL",PSUDVN,60)      ;60 DAY FILLS
 ;
 S FILL90=^TMP($J,"FILL",PSUDVN,90)      ;90 DAY FILLS
 ;
 S UNAD=^TMP($J,"UNAD",PSUDVN)           ;UNADJUSTED TOTAL FILLS
 ;
 S EQUIV=^TMP($J,"EQUIV",PSUDVN)         ;30 DAY EQUIV FILLS
 ;
 Q
 ;
TCOST ;Calculate total cost for prescription fills 
 ;
 S PSUTC="",PSUTCOST=""
 ;
 S PSUDIVN=0
 F  S PSUDIVN=$O(^TMP($J,"COST",PSUDIVN)) Q:PSUDIVN=""  D
 .S PSURXIEN=0
 .F  S PSURXIEN=$O(^TMP($J,"COST",PSUDIVN,PSURXIEN)) Q:PSURXIEN=""  D
 ..S PSUTCOST=^TMP($J,"COST",PSUDIVN,PSURXIEN)
 ..S TCOST(PSUDIVN)=$G(TCOST(PSUDIVN))+PSUTCOST
 ..I TCOST(PSUDIVN)'["." S TCOST(PSUDIVN)=TCOST(PSUDIVN)_".00" Q
 ..N A,B,C
 ..S A=$F(TCOST(PSUDIVN),".")  ;Find 1st position after decimal
 ..S B=$E(TCOST(PSUDIVN),1,(A-1))   ;Extract dollars and decimal
 ..S C=$E(TCOST(PSUDIVN),A,(A+1))   ;Extract cents after decimal
 ..I $L(C)'=2 S C=$E(C,1)_0
 ..S TCOST(PSUDIVN)=B_C
 ;
 Q
 ;
UNADCST ;Calculate Cost Per Unadjusted Fill
 ;
 N A,B,C
 S UNADC(PSUDVN)=TCOST(PSUDVN)/UNAD
 ;
 I UNADC(PSUDVN)'["." S UNADC(PSUDVN)=UNADC(PSUDVN)_".00" Q
 ;
 S A=$F(UNADC(PSUDVN),".")    ;Find position of 1st # after decimal
 ;
 S B=$E(UNADC(PSUDVN),1,(A-1)) ;Extract "dollars" up to decimal
 ;
 S C=$E(UNADC(PSUDVN),A,(A+1)) ;Extract "cents" after decimal
 ;
 S UNADC(PSUDVN)=B_C
 Q
 ;
FILL ;Calculate Cost Per 30-day Fill
 ;
 N A,B,C
 S CFILL(PSUDVN)=TCOST(PSUDVN)/EQUIV
 ;
 I CFILL(PSUDVN)'["." S CFILL(PSUDVN)=CFILL(PSUDVN)_".00" Q
 ;
 S A=$F(CFILL(PSUDVN),".")    ;Find position of 1st # after decimal
 ;
 S B=$E(CFILL(PSUDVN),1,(A-1)) ;Extract "dollars" up to decimal
 ;
 S C=$E(CFILL(PSUDVN),A,(A+1)) ;Extract "cents" after decimal
 ;
 S CFILL(PSUDVN)=B_C
 ;
 Q
 ;
VAR2 ;Set contents of ^TMP globals into variables
 ;
 S (PSUN,PSUR,PSUW,PSUWCS,PSUM,PSUMCS)=""
 S (PSUMOP,PSULOC,PSULCS,PSUTF,PSUFE)=""
 ;
 S PSUN=^TMP($J,"NEW",PSUDVN)           ;NEW FILLS
 ;
 S PSUR=^TMP($J,"REF",PSUDVN)           ;REFILLS
 ;
 S PSUW=^TMP($J,"WIN",PSUDVN)           ;WINDOW FILLS
 ;
 S PSUWCS=^TMP($J,"WINCS",PSUDVN)       ;WINDOW CS
 ;
 S PSUM=^TMP($J,"MAIL",PSUDVN)          ;MAIL FILLS
 ;
 S PSUMCS=^TMP($J,"MAILCS",PSUDVN)      ;MAIL CS
 ;
 S PSUMOP=^TMP($J,"CMOP",PSUDVN)        ;CMOP FILLS
 ;
 S PSULOC=^TMP($J,"LOC",PSUDVN)         ;LOCAL FILLS
 ;
 S PSULCS=^TMP($J,"LOCS",PSUDVN)        ;LOCAL CS
 ;
 S PSUTF=^TMP($J,"STAFF",PSUDVN)        ;STAFF FILLS
 ;
 S PSUFE=^TMP($J,"FEE",PSUDVN)          ;FEE FILLS
 ;
 Q
 ;
TOTAL1 ;Add each column to get totals for all divisions
 ;
 ;
 S PSU30=$G(PSU30)+FILL30               ;Total 30 day fills
 ;
 S PSU60=$G(PSU60)+FILL60               ;Total 60 day fills
 ;
 S PSU90=$G(PSU90)+FILL90               ;Total 90 day fills
 ;
 S PSUNADJ=$G(PSUNADJ)+UNAD             ;Total unadjusted fills
 ;
 S PSUEQ=$G(PSUEQ)+EQUIV                ;Total 30 day equiv fills
 ;
 S PSUTCST=$G(PSUTCST)+TCOST(PSUDVN)    ;Total of Total Cost
 ;
 ;S PSUNADC=$G(PSUNADC)+UNADC(PSUDVN)    ;Total of Cost/Unadj fill
 I $G(PSUNADJ) S PSUNADC=$G(PSUTCST)/PSUNADJ D
 .I PSUNADC'["." S PSUNADC=PSUNADC_".00" Q
 .N A,B,C
 .S A=$F(PSUNADC,".")  ;Find 1st position after decimal
 .S B=$E(PSUNADC,1,(A-1))   ;Extract dollars and decimal
 .S C=$E(PSUNADC,A,(A+1))   ;Extract cents after decimal
 .I $L(C)'=2 S C=$E(C,1)_0
 .S PSUNADC=B_C
 ;
 ;S PSUCFIL=$G(PSUCFIL)+CFILL(PSUDVN)    ;Total of Cost/30day fill
 I $G(PSUEQ) S PSUCFIL=$G(PSUTCST)/PSUEQ D
 .I PSUCFIL'["." S PSUCFIL=PSUCFIL_".00" Q
 .N A,B,C
 .S A=$F(PSUCFIL,".")  ;Find 1st position after decimal
 .S B=$E(PSUCFIL,1,(A-1))   ;Extract dollars and decimal
 .S C=$E(PSUCFIL,A,(A+1))   ;Extract cents after decimal
 .I $L(C)'=2 S C=$E(C,1)_0
 .S PSUCFIL=B_C
 ;
 Q
 ;
TOTAL2 ;Add each column to get totals for all divisions
 ;
 S PSUNEW=$G(PSUNEW)+^TMP($J,"NEW",PSUDVN)
 ;
 S PSUREF=$G(PSUREF)+^TMP($J,"REF",PSUDVN)
 ;
 S PSUWN=$G(PSUWN)+^TMP($J,"WIN",PSUDVN)
 ;
 S PSUWNCS=$G(PSUWNCS)+^TMP($J,"WINCS",PSUDVN)
 ;
 S PSUML=$G(PSUML)+^TMP($J,"MAIL",PSUDVN)
 ;
 S PSUMLCS=$G(PSUMLCS)+^TMP($J,"MAILCS",PSUDVN)
 ;
 S PSUMP=$G(PSUMP)+^TMP($J,"CMOP",PSUDVN)
 ;
 S PSULC=$G(PSULC)+^TMP($J,"LOC",PSUDVN)
 ;
 S PSULOCS=$G(PSULOCS)+^TMP($J,"LOCS",PSUDVN)
 ;
 S PSUSTF=$G(PSUSTF)+^TMP($J,"STAFF",PSUDVN)
 ;
 S PSUFEE=$G(PSUFEE)+^TMP($J,"FEE",PSUDVN)
 ;
 Q
 ;
MAIL ;Send AMIS summary mailman message
 ;
 ;Do not send report if option selection includes 1,2,3,4,6
 I $D(^XTMP("PSU_"_PSUJOB,"CBAMIS")) D  Q
 .M ^XTMP("PSU_"_PSUJOB,"OPCOMBO")=AMIS
 .S ^XTMP("PSU_"_PSUJOB,"OPCOMBO",1)="OUTPATIENT:"
 ;
 S XMSUB="V. 4.0 PBMOP "_PSUMON_" "_PSUST_" "_PSUSTNM
 S XMTEXT="AMIS("
 M ^XTMP("PSU_"_PSUJOB,"OPAMIS")=AMIS
 S XMCHAN=1
 M XMY=PSUXMYS2
 D ^XMD
 ;
 Q
