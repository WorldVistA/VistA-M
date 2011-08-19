PSOCPA ;BHAM ISC/LGH - PHARMACY CO-PAY CANCEL & RESET STATUS OPTIONS ;05/27/92
 ;;7.0;OUTPATIENT PHARMACY;**9,71,85,137,143,201**;DEC 1997
 ;
 ;REF/IA
 ;^IBARX/125
 ;^IBE(350.3/2216
 ; PSO=1 (REMOVE CHARGE cancel),PSO=2 (UPDATE CHARGE called from EDIT)
 ; PSO=3 (REMOVE CHARGE cancel in background processing) ... USED FOR PSOHLNE3
 ;
EN ;Entry point for Remove Co-Pay charge
 S PSOFLAG=0
 S PSO=1 ; Remove Co-Pay charge
RX ;
 G EXIT:PSO'>0
 W ! S DIC="^PSRX(",DIC(0)="AEQMZ" D ^DIC K DIC G EXIT:Y<0 S PSODA=+Y
RXED ;         Entry point from PSORXED and PSORESK1...requires PSODA,PSO,PSODAYS,PSOFLAG
 N POTBILL
 S PSORXN=$P(^PSRX(PSODA,0),"^") ;..........Rx #
 ;          Determine if Rx is COPAY 
 I +$G(PSOPFS) S PSOREF=+$G(TYPE) G REASON
 I PSO'=3 I '$D(^PSRX(PSODA,"IB")) W !,"Rx # ",PSORXN," is NOT a COPAY transaction...NO action taken." G EXIT
 I PSO'=3 S PSOIB=^PSRX(PSODA,"IB")
 I PSO=2!(PSO=1)!(PSO=3&($G(PSOREF)=0)) I $P(PSOIB,"^",2)'>0 S POTBILL=$P(PSOIB,"^",4) I POTBILL="",'$D(^PSRX(PSODA,1)) G EXIT ; No bill#, no refills
 ;I PSO=3&($G(PSOREF)=0) I $P(PSOIB,"^",2)'>0 S POTBILL=$P(PSOIB,"^",4) I POTBILL="",'$D(^PSRX(PSODA,1)) G EXIT ; No bill#, no refills
 ;          Determine last entry in ^PSRX
 I PSO=3&($D(^PSRX(PSODA,1))) G RXED2
 S PSOREF=0
 G:'$D(^PSRX(PSODA,1)) REASON
 F PSZ=0:0 S PSZ=$O(^PSRX(PSODA,1,PSZ)) Q:PSZ'>0  S PSOREF=PSZ
 S PSOIB=$G(^PSRX(PSODA,1,PSOREF,"IB"))
RXED2 I PSO=2!(PSO=1)!(PSO=3) I $P(PSOIB,"^",1)'>0 S POTBILL=$P(PSOIB,"^",2)
 G:($P(PSOIB,"^",1)'>0)&($G(POTBILL)'>0) EXIT ; No bill#
REASON ;
 N PSORD S:PSOREF>0 PSORD=$$GET1^DIQ(52.1,PSOREF_","_PSODA,"17","I") S:PSOREF=0 PSORD=$$GET1^DIQ(52,PSODA,"31","I")
 ;          Get Cancellation reason
 I PSO=1!(PSO=3) G CANCEL2:$G(PSOPFS)&('$P(+$G(^PSRX(PSODA,"IB")),"^",1)) G PFS:$G(PSOPFS) G CANCEL
 S DIC="^IBE(350.3,",DIC("S")="I $P(^(0),U,3)'=2",DIC(0)="AEQMZ",DIC("A")="Select CHARGE REMOVAL REASON : " D ^DIC S:$G(Y)<0 COPAYFLG=0 K DIC D ENDMSG:Y<0 G EXIT:Y<0 S PSORSN=+Y
 I PSO=2&($G(PSOPFS))&($G(PSORD)) D  Q:'$P(+$G(^PSRX(PSODA,"IB")),"^",1)  D PFS2 G EXIT
 . D CHRG^PSOPFSU1(PSODA,PSOREF,"CG",PSOPFS)  ;only send charge msg if released
 G UPDATE:PSO=2
 G EXIT
CANCEL ;
 ;          Set x=service^dfn^^user duz
 ;              x(n)=IB number^cancellation reason
 N PSOIBST
 ;G PFS:$G(PSOPFS)
 I PSOREF=0,$P(PSOIB,"^",2)>0 S PSOIBST=$$STATUS^IBARX($P(PSOIB,"^",2)) I PSOIBST'=1,PSOIBST'=3 G EXITA
 I $G(PSO)=1!(PSO=3) I PSOREF>0,$P(PSOIB,"^",1)>0 S PSOIBST=$$STATUS^IBARX($P(PSOIB,"^",1)) I PSOIBST'=1,PSOIBST'=3 G EXITA
PFS I PSO'=3 S DIC="^IBE(350.3,",DIC("S")="I $P(^(0),U,3)'=2",DIC(0)="AEQMZ",DIC("A")="Select CHARGE REMOVAL REASON : " D ^DIC S:$G(Y)<0 COPAYFLG=0 K DIC D ENDMSG:Y<0 G EXIT:Y<0 S PSORSN=+Y
 I PSO=3 S DIC="^IBE(350.3,",DIC(0)="QEZ",X="RX EDITED" D ^DIC K DIC G EXIT:Y<0 S PSORSN=+Y
 G CANCEL2:$G(PSOPFS)
 S X=PSOPAR7_"^"_+$P(^PSRX(PSODA,0),"^",2)_"^^"_DUZ
 S:PSOREF=0 X(PSORXN)=$S($G(POTBILL)="":+$P(PSOIB,"^",2),1:POTBILL)_"^"_PSORSN ; Original Rx
 S:PSOREF>0 X(PSORXN)=$S($G(POTBILL)="":+^PSRX(PSODA,1,PSOREF,"IB"),1:POTBILL)_"^"_PSORSN ; Refill Rx
 I $G(POTBILL)'="" D CANIBAM^IBARX G CANCEL2
 D CANCEL^IBARX
 ;          Return y=1 if success, -1^error code if error
 ;                 y(n)=IB number^total charge^AR bill number
 I +Y=-1 W !,"Error in processing...No action taken." G EXIT
 G EXIT:'$D(Y(PSORXN))
CANCEL2 I $G(PSOPFS)&($G(PSORD)) D CHRG^PSOPFSU1(PSODA,PSOREF,"CD",PSOPFS)  ;only cancel charge if released
 G EXIT:'($P(+$G(^PSRX(PSODA,"IB")),"^",1))
 I $G(PSOPFS) D PFS2 G EXIT
 D FILE
 G EXIT
FILE ;
 ;G PFS2:$G(PSOPFS)
 ;          File new Bill # in ^PSRX
 I '$G(POTBILL) S:PSOREF=0 $P(^PSRX(PSODA,"IB"),"^",2)=+Y(PSORXN) ;...Original Rx
 I $G(POTBILL) S:PSOREF=0 $P(^PSRX(PSODA,"IB"),"^",4)="" ; IF POTENTIAL BILL IS CANCELLED, REMOVE ITS NUMBER FROM ^PSRX
 I '$G(POTBILL) S:PSOREF>0 ^PSRX(PSODA,1,PSOREF,"IB")=+Y(PSORXN) ; ...Refill Rx
 I $G(POTBILL) S:PSOREF>0 $P(^PSRX(PSODA,1,PSOREF,"IB"),"^",2)="" ; ...Refill Rx (REMOVE "POTENTIAL" BILL NUMBER WHEN CANCELLED)
PFS2 ;
 I PSO=1 W !!,"Co-Pay transaction for Rx # ",PSORXN,$S(PSOREF>0:" refill # "_PSOREF,1:"")," has been cancelled." S PREA="C",PSOCOMM="Returned to stock"
 I PSO=2 W !!,"Co-Pay transaction for Rx # ",PSORXN,$S(PSOREF>0:" refill # "_PSOREF,1:"")," has been updated." S PREA="E",PSOCOMM="Days supply change. Copay amount updated"
 D ACTLOG
 Q
UPDATE ;if days supply changes during Rx edit, cancel old bill and get new bill number
 N SAVEDA
 S SAVEDA=$G(DA)
 I PSOFLAG=0 W !,"Use Pharmacy Manager Option - Edit Prescriptions - to UPDATE this Rx." G EXIT
 ;
 ;    Set x=service^dfn^action type^user duz.....x value for update
 ;  x(n)=softlink^units^IB number of parent to cancel^Cancellation reason
 ;
 ;
 S X=PSOPAR7_"^"_+$P(^PSRX(PSODA,0),"^",2)_"^"_$P(^PSRX(PSODA,"IB"),"^")_"^"_DUZ
 ;                Units for COPAY
 S PSOCPUN=$P(($P(^PSRX(PSODA,0),"^",8)+29)/30,".",1)
 G EXIT:PSOCPUN=$P((PSODAYS+29)/30,".",1) ; No change if UNITS unchanged
 ;
 ;               Build softlink for x(n)
 S X(PSORXN)="52:"_PSODA S:PSOREF>0 X(PSORXN)=X(PSORXN)_";1:"_PSOREF
 ;
 ;         Set IB number of Parent record to update
 S PSOPARNT=$S(PSOREF=0:+$P(^PSRX(PSODA,"IB"),"^",2),PSOREF>0:+^PSRX(PSODA,1,PSOREF,"IB"),1:0)
 S X(PSORXN)=X(PSORXN)_"^"_PSOCPUN_"^"_PSOPARNT_"^"_PSORSN
 I $G(POTBILL)'="" D
 . S $P(X(PSORXN),"^",3)=POTBILL
 . I $T(UPIBAM^IBARX)="" Q
 . D UPIBAM^IBARX
 I '$G(POTBILL) D UPDATE^IBARX
 ;          Return y=1 if success, -1^error code if error
 ;                 y(n)=IB number^total charge^AR bill number
 I +Y=-1 W !,"Error in processing...No action taken." G EXIT
 G EXIT:'$D(Y(PSORXN))
PFS3 ;
 D FILE
 G EXIT
 ;
RXDEL ;          Entry point when Rx is deleted thru menu option -- THIS ENTRY POINT NO LONGER USED WITH MILL BILL COPAY CHANGES
 K DIC S DIC="^IBE(350.3,",DIC(0)="M",X="RX DELETED" D ^DIC K DIC Q:+Y<0  S PSORSN=+Y
 K Y
 S PSODA=RXN,PSORXN=+RX
 S X=PSOPAR7_"^"_+$P(RX,"^",2)_"^^"_DUZ
 S X(PSORXN)=+$P(PSOIB,"^",2)_"^"_PSORSN ; Original Rx
 D CANCEL^IBARX
 W:+Y=1 !!,"Copay transaction for this Rx has been cancelled."
 S PREA="C" D ACTLOG
 G EXIT
EXITA ;
 I PSO=1 W !!,"Co-Pay transaction for Rx # ",PSORXN,$S(PSOREF>0:" refill # "_PSOREF,1:"")," has previously been cancelled."
EXIT I $D(SAVEDA) S DA=SAVEDA ;
 I PSO'=3 K PSO,PSOCPUN,PSODA,PSOFLAG,PSOIB,PSOPARNT,PSOREF,PSORSN,PSORXN,PSZ,X,Y Q
 I PSO=3 K PSOCPUN,PSOPARNT,PSORXN,X,Y
 Q
ENDMSG ;
 I PSO'=3 W !!,"Unable to UPDATE COPAY TRANSACTON without REMOVAL REASON entry."
 Q
ACTLOG ;ENTER MESSAGE INTO RX COPAY ACTIVITY LOG
 Q:+$G(PSOPFS)&('$D(^PSRX(PSODA,"IB")))  ;don't set copay activity log when no copay when send Rx to external bill sys
 N X,Y
 S:'$D(PREA) PREA="R" D NOW^%DTC S PSI=0
ACTL S PSI=+$O(^PSRX(PSODA,"COPAY",PSI)) G:$O(^PSRX(PSODA,"COPAY",PSI)) ACTL
 K DIC,PSORSNZ I $G(PSORSN)'="" S DIC="^IBE(350.3,",DIC(0)="M",X="`"_PSORSN D ^DIC K DIC I $G(Y) S PSORSNZ=$P($G(Y),"^",2)
 S PSORSNZ=$G(PSORSNZ)_$S($G(PSORSNZ)="":"",1:" ")_$G(PSOCOMM)
 S ^PSRX(PSODA,"COPAY",+PSI+1,0)=%_"^"_PREA_"^"_DUZ_"^"_$G(PSOREF)_"^"_PSORSNZ_"^"_$G(PSOOLD)_"^"_$G(PSONW)
 S ^PSRX(PSODA,"COPAY",0)="^52.0107DA^"_(+PSI+1)_"^"_(+PSI+1)
 K PSORSNZ
 Q
 ;
