IBYBPRE ;ALB/ARH - PATCH IB*2*27 ENVIRONMENT CHECK ; 10-FEB-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**27**; 21-MAR-94
 ;
EN ; Perform checks to be sure IB*2*27 can be installed.
 ;
 W ! S IBQ=0
 ;
 D CHKUSR I IBQ G ENQ ;   check DUZ and DUZ(0)
 ;
 I $$RERUN() G ENQ ;      skip checks if it appears init is being re-run
 ;
 D CHKAR ;          make sure patch PRCA*4*15 or PRCA*4.5*1 is installed
 D CHKIB ;                make sure IB parameters are in place
 ;
 I IBQ K DIFQ ;           stop the install if there is a problem
 ;
ENQ K IBQ
 Q
 ;
 ;
CHKUSR ; Check DUZ and DUZ(0).
 I $S('($D(DUZ)#2):1,'$D(^VA(200,+DUZ,0)):1,'$D(DUZ(0)):1,1:0) D
 .W !!?3,"The variable DUZ must be set to an active user code and the variable"
 .W !?3,"DUZ(0) must also be defined to run this initialization.",!
 .K DIFQ S IBQ=1
 Q
 ;
CHKAR ; Make sure patch PRCA*4*15 or PRCA*4.5*1 is properly installed.
 S IBCTPN="CHAMPVA THIRD PARTY",IBCTP=$O(^PRCA(430.2,"B",IBCTPN,0))
 S IBCCVN="CHAMPVA",IBCCV=$O(^PRCA(430.2,"B",IBCCVN,0))
 S IBCCSN="CHAMPVA SUBSISTENCE",IBCCS=$O(^PRCA(430.2,"B",IBCCSN,0))
 ;
 S IBCTPD=$G(^PRCA(430.2,+IBCTP,0)) I IBCTPD="" S IBQ=1 W !," >> ACCOUNTS RECEIVABLE CATEGORY (430.2) '",IBCTPN,"' not found."
 S IBCCVD=$G(^PRCA(430.2,+IBCCV,0)) I IBCCVD="" S IBQ=1 W !," >> ACCOUNTS RECEIVABLE CATEGORY (430.2) '",IBCCVN,"' not found."
 S IBCCSD=$G(^PRCA(430.2,+IBCCS,0)) I IBCCSD="" S IBQ=1 W !," >> ACCOUNTS RECEIVABLE CATEGORY (430.2) '",IBCCSN,"' not found."
 ;
 I IBQ D
 .W !!,*7,"Patch PRCA*4*15 or PRCA*4.5*1 does not appear to be installed!  Please install"
 .W !,"the appropriate patch and then re-run this initialization."
 ;
 K IBCTPN,IBCTPD,IBCCVN,IBCCVD,IBCCSN,IBCCSD
 Q
 ;
CHKIB ; Make sure IB parameters exist and haven't been modified.
 S IBRTPN="CHAMPVA REIMB. INS.",IBRTP=$O(^DGCR(399.3,"B",IBRTPN,0))
 S IBRCVN="CHAMPVA",IBRCV=$O(^DGCR(399.3,"B",IBRCVN,0))
 ;
 S IBACNN="DG CHAMPVA PER DIEM NEW",IBACN=$O(^IBE(350.1,"B",IBACNN,0))
 S IBACCN="DG CHAMPVA PER DIEM CANCEL",IBACC=$O(^IBE(350.1,"B",IBACCN,0))
 S IBACUN="DG CHAMPVA PER DIEM UPDATE",IBACU=$O(^IBE(350.1,"B",IBACUN,0))
 ;
 S IBRTPD=$G(^DGCR(399.3,+IBRTP,0)) I IBRTPD="" S IBQ=1 W !," >> RATE TYPE (399.3) '",IBRTPN,"' not found."
 S IBRCVD=$G(^DGCR(399.3,+IBRCV,0)) I IBRCVD="" S IBQ=1 W !," >> RATE TYPE (399.3) '",IBRCVN,"' not found."
 S IBACND=$G(^IBE(350.1,+IBACN,0)) I IBACND="" S IBQ=1 W !," >> ACTION TYPE (350.1) '",IBACNN,"' not found."
 S IBACCD=$G(^IBE(350.1,+IBACC,0)) I IBACCD="" S IBQ=1 W !," >> ACTION TYPE (350.1) '",IBACCN,"' not found."
 S IBACUD=$G(^IBE(350.1,+IBACU,0)) I IBACUD="" S IBQ=1 W !," >> ACTION TYPE (350.1) '",IBACUN,"' not found."
 I IBQ D  G CHKIBQ
 .W !!,"Required file entries are missing.  You should determine why you do not"
 .W !,"have these entries before continuing.  They should have been installed"
 .W !,"with the installation of IB v2.0."
 ;
 ; check that Rate Types have not been modified since release of IB v2.0
 I '$P(IBRTPD,U,3) S IBQ=1 W !!," >> RATE TYPE (399.3) '",IBRTPN,"' is not Inactive."
 I +$P(IBRTPD,U,6) D
 .W !!," >> RATE TYPE (399.3) '",IBRTPN,"' already has a pointer"
 .W !,"    to an ACCOUNTS RECEIVABLE CATEGORY (430.2)."
 .W !,"    This RATE TYPE will be re-pointed to a new CATEGORY in this installation."
 ;
 I '$P(IBRCVD,U,3) S IBQ=1 W !!," >> RATE TYPE (399.3) '",IBRCVN,"' is not Inactive."
 I +$P(IBRCVD,U,6) D
 .W !!," >> RATE TYPE (399.3) '",IBRCVN,"' already has a pointer"
 .W !,"    to an ACCOUNTS RECEIVABLE CATEGORY (430.2)."
 .W !,"    This RATE TYPE will be re-pointed to a new CATEGORY in this installation."
 ;
 I IBQ D
 .W !!,"RATE TYPE entries have changed since the release of IB 2.0.  You should"
 .W !,"determine why these entries may have changed, and then inactivate"
 .W !,"the Rate Types again, before re-running the initialization."
 ;
CHKIBQ K IBRTPN,IBRTPD,IBRCVN,IBRCVD,IBACNN,IBACND,IBACCN,IBACCD,IBACUN,IBACUD
 Q
 ;
 ;
RERUN() ; Has the installation already been run?
 N X,Y,Z S (X,Y,Z)=0
 F  S X=$O(^IBE(350.2,"B","CHAMPVA PER DIEM",X)) Q:'X  S Y=X
 I Y S Y=$G(^IBE(350.2,Y,0)) I $P(Y,"^",2)=2941001,+$P(Y,"^",4)=9.5 S Z=1
 Q Z
