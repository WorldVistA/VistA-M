PSOCPD ;BHAM ISC/BaB - MULTIPLE COPAY CHARGE REMOVAL ;05/27/92
 ;;7.0;OUTPATIENT PHARMACY;**71,85,201**;DEC 1997
 ;
 ;REF/IA
 ;^IBARX/125
 ; Originally released as part of the copayment enhancement patch
 ; Mill Bill Copay enhancement -- entry point ASKCAN - called from PSOCPB
CR I '$D(PSOPAR) S PSOINDPT="" D ^PSOLSET G CR ; Setup site parameters
ASK K PSPEED,PSPEEDA,PSPOUT W ! R !,"PRESCRIPTION(s): ",PSX:DTIME S:'$T PSX="^" G LASTEX:"^"[PSX
 I PSX["?"!($L(PSX)>245)!(PSX?.AP) W !?5,"Enter prescription number(s) for removal of charges. If more than one",!,"separate with commas.  Do not exceed 245 characters including commas." G ASK
 G SPEED:PSX[","
 I '$D(^PSRX("B",PSX)) W !!,PSX," is not a valid RX #!!" G ASK
 S PSODA=$O(^PSRX("B",PSX,"")) W:PSODA="" !!,PSX," is not a valid RX #!!" G ASK:PSODA=""
 I '$D(^PSRX(PSODA,"IB")) W !!,"Rx # ",$P($G(^PSRX(PSODA,0)),"^")," is NOT a COPAY transaction...NO action taken." G EXIT
 D REASON G:Y<0 LASTEX D SPEED1,LASTEX
 Q
REASON ;
 ;          Get Cancellation reason
 W ! S DIC="^IBE(350.3,",DIC("S")="I $P(^(0),U,3)'=2",DIC(0)="AEQMZ",DIC("A")="Select CHARGE REMOVAL REASON : " D ^DIC K DIC D ENDMSG:Y<0 Q:Y<0  S PSORSN=+Y
 S PREA="C-CPD"
 Q
SPEED ;
 S PSPEED=1 D REASON G:Y<0 LASTEX
 F PSOI=1:1 S X=$P(PSX,",",PSOI) Q:$P(PSX,",",PSOI,99)=""!($G(PSPOUT))  I X S DIC=52,DIC(0)="M" D ^DIC K DIC S:Y<0 PSINV(X)="" I Y>0 S PSODA=+Y D SPEED1
INVALD G:'$D(PSINV) ASK
 W !!,"The following are INVALID choices:" S PSOI="" F PSOJ=0:0 S PSOI=$O(PSINV(PSOI)) Q:PSOI'>0  W !?10,PSOI
 K PSINV
 G ASK
SPEED1 ;
 S PSOFLAG=0
 S PSO=1 ; Remove Co-Pay charge
 S PSORXN=$P(^PSRX(PSODA,0),"^") ;..........Rx #
 ;          Determine if Rx is COPAY 
 I '$D(^PSRX(PSODA,"IB")) W !,"Rx # ",PSORXN," is NOT a COPAY transaction...NO action taken." G EXIT
 S PSOIB=^PSRX(PSODA,"IB")
 G:($P(PSOIB,"^",2)'>0)&('$D(^PSRX(PSODA,1))) ERRBIL ;No bill#/no refills
 ;
 ;          Determine last entry in ^PSRX
 S PSOREF=0
 G:'$D(^PSRX(PSODA,1)) CANCEL
 F PSZ=0:0 S PSZ=$O(^PSRX(PSODA,1,PSZ)) Q:PSZ'>0  S PSOREF=PSZ
 G:$S('$D(^PSRX(PSODA,1,PSOREF,"IB")):1,(+^("IB"))'>0:1,1:0) ERRBIL ;..No bill #
 S:PSOREF>0 PSOIB=^PSRX(PSODA,1,PSOREF,"IB")
CANCEL ;
 I '$G(PSPEED) W ! K DIR S DIR(0)="Y",DIR("B")="Y",DIR("A")="Are you sure you want to remove Copay charges for Rx # "_$G(PSORXN) D ^DIR K DIR I Y'=1 W !!,"No action taken.",! G EXIT
 I $G(PSPEED),'$G(PSPEEDA) W ! K DIR S DIR(0)="Y",DIR("B")="Y",DIR("A")="Are you sure you want to remove Copay charges for these Rx's" D ^DIR K DIR S PSPEEDA=1 I Y'=1 W !!,"No action taken.",! S PSPOUT=1 G EXIT
 W ! K X
 ;          Set x=service^dfn^^user duz
 ;              x(n)=IB number^cancellation reason
 ;
 S X=PSOPAR7_"^"_+$P(^PSRX(PSODA,0),"^",2)_"^^"_DUZ
 S:PSOREF=0 X(PSORXN)=+$P(PSOIB,"^",2)_"^"_PSORSN ; Original Rx
 S:PSOREF>0 X(PSORXN)=+^PSRX(PSODA,1,PSOREF,"IB")_"^"_PSORSN ; Refill Rx
 ;
 D CANCEL^IBARX
 ;
 ;          Return y=1 if success, -1^error code if error
 ;                 y(n)=IB number^total charge^AR bill number
 ;
 I +Y=-1 W !,"......No action taken." G EXIT
 G EXIT:'$D(Y(PSORXN))
FILE ;
 ;          File new Bill # in ^PSRX
 ;
 S:PSOREF=0 $P(^PSRX(PSODA,"IB"),"^",2)=+Y(PSORXN) ;...Original Rx
 S:PSOREF>0 ^PSRX(PSODA,1,PSOREF,"IB")=+Y(PSORXN) ; ...Refill Rx
 W:PSO=1 !!,"Co-Pay transaction for Rx # ",PSORXN,$S(PSOREF>0:" refill # "_PSOREF,1:"")," has been cancelled."
 ;
 D ACTLOG^PSOCPA
 ;
 G EXIT
ERRBIL W !!,"No Entry # for Rx # "_$P($G(^PSRX(PSODA,0)),"^")_" ...No action taken."
EXIT ;
 K PREA,C,PSO,PSODA,PSOIB,PSOPARNT,PSOREF,PSORXN,PSZ,X,Y
 Q
LASTEX ;
 K PSO,PSPOUT,PSPEED,PSPEEDA,PSOCPUN,PSODA,PSOFLAG,PSOIB,PSOPARNT,PSOREF,PSORSN,PSORXN,PSZ,X,Y,PSINV,PSOI,PSX,PSOJ,PREA,C
 I $D(PSOINDPT) K PSOINDPT D FINAL^PSOLSET
 Q
ENDMSG ;
 W !!,"Unable to process without REASON entry."
 Q
 ;
ASKCAN ; if any charges currently, give option to cancel some or all
 I '$D(^PSRX(PSODA,"IB")) Q  ;ok to quit based on IB node for PFSS because always have IB node when copay is billed.
 N J,PSOREF,PSOCAN,CANTYPE
 K X,XX
 S J=0
 I $P($G(^PSRX(PSODA,"PFS")),"^",2) S X(PSODA)="",J=1,PSOCAN(J)=PSODA_"^"_X(PSODA),$P(PSOCAN(J),"^",10)="PFS" ;if PFS and it has charge id
 I $P(^PSRX(PSODA,"IB"),"^",2)>0 S X(PSORXN)=$P(^PSRX(PSODA,"IB"),"^",2),J=1,PSOCAN(J)=PSORXN_"^"_X(PSORXN) ; original fill
 I $P(^PSRX(PSODA,"IB"),"^",4)>0,'$D(X(PSORXN)) S XX(PSORXN)=$P(^PSRX(PSODA,"IB"),"^",4),J=1,PSOCAN(J)=PSORXN_"^"_XX(PSORXN)_"^CAP" ; original fill
PFS D REFILL^PSOCPB
 I '$D(X),'$D(XX) Q  ; no "IB" numbers on original or refills
 S PSOREF="" F  S PSOREF=$O(X(PSOREF)) Q:PSOREF=""  Q:PSOREF>12  S J=J+1,PSOCAN(J)=PSOREF_"^"_X(PSOREF) S:$P($G(^PSRX(PSODA,1,PSOREF,"PFS")),"^",2) $P(PSOCAN(J),"^",10)="PFS"
 S PSOREF="" F  S PSOREF=$O(XX(PSOREF)) Q:PSOREF=""  Q:PSOREF>12  S J=J+1,PSOCAN(J)=PSOREF_"^"_XX(PSOREF)_"^CAP" S:$P($G(^PSRX(PSODA,1,PSOREF,"PFS")),"^",2) $P(PSOCAN(J),"^",10)="PFS"
ASKCAN2 W !!,"Do you want to cancel any charges (Y/N)? "
 R X:DTIME S:'$T X="^" Q:X=""  G:"Yy"[$E(X) ASKALL Q:"Nn^"[$E(X)  D HELP2:"?"[$E(X) G ASKCAN2
HELP2 W !,"Answering YES will allow cancelling of all or selected charges"
 Q
HELP3 W !,"Answering YES will proceed with cancelling selected charges"
 Q
ASKALL ;PFS - check copay activity log to see if any fills were previously cancelled; mark as cancelled for display
 N PSOPFSD,PSOFIL D GETS^DIQ(52,PSODA,"107*","I","PSOPFSD") D:$D(PSOPFSD)
 .F I=1:1 Q:'$D(PSOPFSD(52.0107,I_","_PSODA_","))  D:$G(PSOPFSD(52.0107,I_","_PSODA_",",1,"I"))="C"
 ..S PSOFIL=$G(PSOPFSD(52.0107,I_","_PSODA_",",3,"I")),J=""
 ..F  S J=$O(PSOCAN(J)) Q:J=""  S:$P(PSOCAN(J),"^")=PSOFIL&($P(PSOCAN(J),"^",10)="PFS") $P(PSOCAN(J),"^",5)="CANCEL" S:$P(PSOCAN(J),"^")=PSODA&(PSOFIL=0)&($P(PSOCAN(J),"^",10)="PFS") $P(PSOCAN(J),"^",5)="CANCEL"
 K PSOFIL,PSOPFSD
 ;
 W !!,"(A)ll or (S)elect Charges? (A/S): "
 R X:DTIME S:'$T X="^" I X="" Q
 I X="^" Q
 I X'="A",X'="a",X'="S",X'="s" W !,"Enter 'A' to cancel all charges or 'S' to select from list of charges" G ASKALL
 I X="A"!(X="a") D  D BILL2^PSOCPB Q
 .W !!,"**********Charges are on file for this Rx.**********"
 .W !,"Proceeding with cancellation of ALL charges."
 .S CANTYPE=1
 S CANTYPE=0
 D SELECT
 Q
 ;
SELECT ; Choose from list of fills that have charges
 N J,I,PSORELDT,PSOBILL,FOOTNOTE
 K FOOTNOTE
 K X
 F J=1:1 Q:'$D(PSOCAN(J))  D  W:PSORELDT'="//" !,J,". ",$S(+PSOCAN(J)>11:"Original fill",1:"Refill #"_+PSOCAN(J)),?20,"(",PSORELDT,")",?35,PSOBILL
 .S PSOBILL=""
 .I $P(PSOCAN(J),"^",10)'="PFS" D
 ..I PSOCAN(J)["CAP" S PSOBILL="(Potential Charge *)",FOOTNOTE=1
 ..I $P(PSOCAN(J),"^",10)'="PFS" I $T(STATUS^IBARX)'="" I PSOCAN(J)'["CAP" S PSOBILL=$$STATUS^IBARX($P(PSOCAN(J),"^",2)) S:PSOBILL=2 $P(PSOCAN(J),"^",5)="CANCEL" S PSOBILL=$S(PSOBILL=2:"(Charge Cancelled)",1:"")
 .I $P(PSOCAN(J),"^",10)="PFS" S:$P(PSOCAN(J),"^",5)="CANCEL" PSOBILL="(Charge Cancelled)"
 .N RX2
 .S RX2=$S(+PSOCAN(J)>11:$G(^PSRX(PSODA,2)),1:$G(^PSRX(PSODA,1,+PSOCAN(J),0)))
 .I RX2="" S PSORELDT="" Q
 .I +PSOCAN(J)>11 S PSORELDT=$S($P(RX2,"^",13):$E($P(RX2,"^",13),4,5)_"/"_$E($P(RX2,"^",13),6,7)_"/"_$E($P(RX2,"^",13),2,3),$P(RX2,"^",15):"RTS",1:"") Q
 .S PSORELDT=$E($P(RX2,"^",18),4,5)_"/"_$E($P(RX2,"^",18),6,7)_"/"_$E($P(RX2,"^",18),2,3)
 I $D(FOOTNOTE) D
 . W !!,"* Potential charge indicates fill was not billed due to the annual cap."
 . W !,"If cancelled, this fill will not be considered for future copay billing."
SELECT2 ;
 K DIR
 S DIR("?")="Select a list or a range, e.g., 1,3,5 or 2-5,8"
 S DIR(0)="LO^1:"_(J-1)
 D ^DIR K DIR
 Q:(X="")!(X="^")!(Y=-1)
 F I=1:1:$L(Y,",")-1 D
 . S PSOSLCT=$P(Y,",",I)
 . I $P(PSOCAN(PSOSLCT),"^",5)="" S X($P(PSOCAN(PSOSLCT),"^",1))=$P(PSOCAN(PSOSLCT),"^",2) Q
SELECT3 W !!,"Do you wish to continue (Y/N)? "
 R X:DTIME S:'$T X="^" I X="" Q
 I "Yy"[$E(X) G SELECT4
 Q:"Nn^"[$E(X)  D HELP3:"?"[$E(X) G SELECT3
SELECT4 I $O(X(""))'="" D  D BILL2^PSOCPB ; cancel charges for selected fills only
 . S I="" F  S I=$O(PSOCAN(I)) Q:I=""  I '$D(X($P(PSOCAN(I),"^",1))) K PSOCAN(I) ; remove unselected fills from cancellation list
 Q
 ;
CHKCAN ; SEE IF SELECTION HAS ALREADY BEEN CANCELLED
 I '$D(PSOCAN(J)) D  Q
 . I J>12!(J'?0.2N) W $C(7),!!,J," is an invalid selection.  Please try again.",!
 S PSI=0
 I $P(PSOCAN(J),"^",5)="CANCEL" S PSOCOMM="Rx # "_PSORXN_" - "_$S(+PSOCAN(J)>11:"Original fill",1:"Refill #"_+PSOCAN(J))_" copay charge has already been cancelled!" D SETSUMM^PSOCPC
 K PSI
 Q
 ;
