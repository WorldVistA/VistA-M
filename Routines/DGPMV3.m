DGPMV3 ;ALB/MIR - ENTER TRANSACTION INFORMATION; 8 MAY 89 ; 5/23/06 8:32am
 ;;5.3;Registration;**34,54,62,95,692,715**;Aug 13, 1993
 K ^UTILITY("DGPM",$J)
 D NOW^%DTC S DGNOW=%,DGPMHY=DGPMY,DGPMOUT=0 G:'DGPMN DT S X=DGPMY
 S DGPM0ND=DGPMY_"^"_DGPMT_"^"_DFN_"^^^^^^^^^^^"_$S("^1^4^"[("^"_DGPMT_"^"):"",1:DGPMCA)
 ;
 I DGPMT=1 S $P(DGPM0ND,"^",25)=$S(DGPMSA:1,1:0)
 ;-- provider change
 I DGPMT=6,$D(DGPMPC) S DGPM0ND=$$PRODAT(DGPM0ND)
 D NEW G Q:Y'>0 S (DA,DGPMDA)=+Y
 S:DGPMT=1!(DGPMT=4) DGPMCA=DA,DGPMAN=^DGPM(DA,0) D VAR G DR
DT D VAR G:DGPM1X DR S (DGPMY,Y)=DGPMHY X ^DD("DD") W !,DGPMUC," DATE: ",Y,"// " R X:DTIME G Q:'$T!(X["^") I X="" G DR
 S %DT="SRXE",%DT(0)="-NOW" I X["?"!(Y<0) D HELP^%DTC G DT
 I X="@" G OKD
 D ^%DT I Y<0 D HELP^%DTC G DT
 K %DT S DGPMY=Y D CHK^DGPMV30:(X]"")&(DGPMY'=+DGPMP) I $D(DGPME) S DGPMY=DGPMHY W !,DGPME K DGPME G DT
DR ;select input template for transaction type
 S DIE="^DGPM(" I "^1^4^6^"[("^"_DGPMT_"^"),DGPMN S DIE("NO^")=""
 S DGODSPT=$S('$D(^DGPM(DGPMCA,"ODS")):0,^("ODS"):1,1:0)
 S DR=$S(DGPMT=1:"[DGPM ADMIT]",DGPMT=2:"[DGPM TRANSFER]",DGPMT=3:"[DGPM DISCHARGE]",DGPMT=4:"[DGPM CHECK-IN LODGER]",DGPMT=5:"[DGPM LODGER CHECK-OUT]",DGPMT=6:"[DGPM SPECIALTY TRANSFER]",1:"") G Q:DR="" K DQ,DG D ^DIE K DIE
 I $D(Y)#2 S DGPMOUT=1
 ;Modified in patch dg*5.3*692 to include privacy indicator node "DIR"
 K DGZ S (^UTILITY("DGPM",$J,DGPMT,DGPMDA,"A"),DGPMA)=$S($D(^DGPM(DGPMDA,0)):^(0)_$S($G(^("DIR"))'="":U_^("DIR"),1:""),1:"")
 D:DGPMT'=4 @("^DGPMV3"_DGPMT)
 I DGPMT=4,$S('$D(^DGPM(DGPMDA,"LD")):1,'$P(^("LD"),"^",1):1,1:0) S DIK="^DGPM(",DA=DGPMDA W !,"Incomplete check-in...deleted" D ^DIK K DIK S DGPMA=""
 S (^UTILITY("DGPM",$J,DGPMT,DGPMDA,"A"),DGPMA)=$G(^DGPM(DGPMDA,0))_$S($G(^("DIR"))'="":U_^("DIR"),1:"") I DGPMT=6 S Y=DGPMDA D AFTER^DGPMV36
EVENTS ;
 I DGPMT=4!(DGPMT=5) D RESET^DGPMDDLD
 I DGPMT'=4&(DGPMT'=5) D RESET^DGPMDDCN I (DGPMT'=6) D SI^DGPMV33
 D:DGPMA]"" START^DGPWB(DFN)
 D EN^DGPMVBM ;notify building management if room-bed change
 S DGOK=0 F I=0:0 S I=$O(^UTILITY("DGPM",$J,I)) Q:'I  F J=0:0 S J=$O(^UTILITY("DGPM",$J,I,J)) Q:'J  I ^(J,"A")'=^("P") S DGOK=1 Q
 I DGOK D ^DGPMEVT ;Invoke Movement Event Driver
Q S:$D(DGPMBYP) DGPMBYP=DGPMDA
 K DGIDX,DGOWD,DGOTY ;variables set in DGPMGLC - G&L corrections
 K DGODS,DGODSPT ;ods variables
 K %DT,DA,DGER,DGNOW,DGOK,DGPM0,DGPM0ND,DGPM2,DGPMA,DGPMAB,DGPMABL,DGPMDA,DGPMER,DGPMHY,DGPMNI,DGPMOC,DGPMOS,DGPMOUT,DGPMP,DGPMPHY,DGPMPHY0,DGPMPTF,DGPMSP,DGPMTYP,DGPMTN,DGPMWD,DGT,DGSV,DGX,DGX1
 K DIC,DIE,DIK,DR,I,I1,J,K,X,X1,X2,Y,^UTILITY("DGPM",$J) Q
 ;
OKD K %DT W ! S DGPMER=0,(^UTILITY("DGPM",$J,DGPMT,DGPMDA,"P"),DGPMP)=^DGPM(DGPMDA,0),Y=DGPMDA D:DGPMT=6 PRIOR^DGPMV36 D @("D"_DGPMT_"^DGPMVDL"_$S(DGPMT>2:1,1:"")) G Q:DGPMER
 W !,"Are you sure you want to delete this movement" S %=2 D YN^DICN G Q:%<0,DT:%=2 I '% W !?5,"Answer yes to delete this ",DGPMUC," or no to continue" G OKD
 D @(DGPMT_"^DGPMVDL"_$S(DGPMT>2:1,1:""))
 I DGPMT'=3,(DGPMT'=5) S DIK="^DGPM(",DA=DGPMDA D ^DIK:DGPMDA
 S (^UTILITY("DGPM",$J,DGPMT,DGPMDA,"A"),DGPMA)=$S($P(DGPMP,"^",18)'=47:"",1:^DGPM(+DGPMDA,0)) I DGPMT=6 S Y=DGPMDA D AFTER^DGPMV36
 I DGPMDA,$O(^DGPM("APHY",DGPMDA,0)) S DIK="^DGPM(",DA=+$O(^(0)) I $D(^DGPM(+DA,0)) S ^UTILITY("DGPM",$J,6,DA,"P")=^(0),^("A")="",Y=DA D PRIOR^DGPMV36,^DIK S Y=DA D AFTER^DGPMV36
 G EVENTS
VAR ;Set up variables
 ;Modified in patch dg*5.3*692 to include privacy indicator node "DIR"
 S DA=DGPMDA,(^UTILITY("DGPM",$J,DGPMT,DGPMDA,"P"),DGPMP)=$S(DGPMN=1:"",1:$G(^DGPM(DA,0))_$S($G(^("DIR"))'="":U_^("DIR"),1:""),1:"") ;DGPMP=Before edit
 I DGPMT=6 S Y=DGPMDA D PRIOR^DGPMV36
 S DGX=DGPMY+($P(DGPMP,"^",22)/10000000)
 S X=$O(^DGPM("APMV",DFN,DGPMCA,(9999999.9999999-DGX))),X1=$O(^DGPM("APMV",DFN,DGPMCA,+X,0)) S DGPM0=$S($D(^DGPM(+X1,0)):^(0),1:"") ;DGPM0=prior movement
 S X=$O(^DGPM("APCA",DFN,DGPMCA,+DGX)),X=$O(^(+X,0)),DGPM2=$S($D(^DGPM(+X,0)):^(0),1:"") ;DGPM2=next movement
 S DGPMABL=0 I DGPM2,$D(^DG(405.2,+$P(DGPM2,"^",18),"E")) S DGPMABL=+^("E") ;is the next movement an absence?
 I DGPMT=6 S Y=DGPMDA D PRIOR^DGPMV36
 Q
NEW ;Entry point to add a new entry to ^DGPM
 D NEW^DGPMV301 ; continuation of routine DGPMV3 in DGPMV301
 Q
 ;
PRODAT(NODE) ;-- This function will add the ward and other data from the
 ; previous TS movement to the provider TS movement.
 ;
 N X,Y
 S Y=NODE,X=$O(^DGPM("ATS",DFN,DGPMCA,9999999.9999999-$P(NODE,U))) I X S X=$O(^(X,0)) I X S X=$O(^(X,0)) I X S X=^DGPM(X,0)
 S $P(Y,U,4)=$P(X,U,4),$P(Y,U,9)=$P(X,U,9)
 Q Y
 ;
