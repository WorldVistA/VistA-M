PRSEED10 ;HISC/MD/MH-PRSE NON-LOCAL C.E. ATTENDANCE ;06/15/94
 ;;4.0;PAID;**18,23**;Sep 21, 1995
EN1 ; ENTRY FROM OPTION PRSE-NCEATTEND
 S X=$G(^PRSE(452.7,1,"OFF")) I X=""!(X=1) D MSG6^PRSEMSG Q
 K ^TMP($J) S (PRSESW,NOUT)=0,PRSESEL="C",(PRSECOD,PRSELCL,PRSEROU)="N",PRSEGF="G" D EN2^PRSEUTL3($G(DUZ)) I PRSESER=""&'(DUZ(0)="@") D MSG3^PRSEMSG G Q1
OTHER D SCUB G:PRSENAM=""!(PRSEDT="")!("^^"[X) Q1
ASK K POUT D NAM G:$D(POUT) EN1
 S (NSW,NDUPSW)=0,PRSENAM(0)=PRSENAM D RECHK^PRSEED7 G:NOUT EN1
 I 'NDUPSW S DIC("S")="I $P($G(^(0)),U,7)=PRSESEL"  S PRSESEL="C",(PRSECOD,PRSELCL)="N",PRSEGF="G",PRSEROU="N" K POUT D ADD^PRSEED12 G Q1:$G(POUT)
 S X="",PRSESEL="C",(PRSECOD,PRSELCL)="N",PRSEGF="G",PRSEROU="N" G ASK
Q1 W ! D ^PRSEKILL
 Q
NAM ;
 K POUT,X,Y
 I $S($G(DUZ(0))["@":1,+$$EN4^PRSEUTL3($G(DUZ)):1,1:0) I $P($G(^PRSE(452.7,1,0)),U,3) D  Q:$G(POUT)  G NAM1
 . W !
 . S Y=$$ADD^XUSERNEW(9)
 . I $G(Y)'>0 S POUT=1
 ;
 I $S($P($G(^PRSE(452.7,1,0)),U,3)'>0:1,'+$$EN4^PRSEUTL3($G(DUZ)):1,$G(DUZ(0))'["@":1,1:0) D
 . W !!,$C(7),"NEW ENTRIES CANNOT BE ADDED TO THE NEW PERSON FILE FROM THIS OPTION - CONTACT",!,"THE EDUCATION PACKAGE COORDINATOR OR IRM OR SELECT A NAME ALREADY IN FILE.",!
 . S DIC("A")="Select Student Name: "
 . S DIC=200,DIC(0)="AEQM"
 . W ! D ^DIC I X=""!(X["^")!(+Y'>0) K DIC S POUT=1 Q
 . S PRDA(0)=Y
 . ;S DIE=DIC,DA=+Y,DR="9R" D ^DIE K DIC,DIE,DR,DA
 . S Y=PRDA(0)
 ;
NAM1 Q:$D(POUT)
 I $G(Y)'>0 G NAM
 S (PRDA,VA200DA)=+Y
 S PRSESTUD=$P($G(^VA(200,+Y,0)),U),(SSN,PRSESSN)=$P($G(^VA(200,+Y,1)),U,9) I $G(PRSESSN)="" W !!,"NO SSN OR NEW PERSON (#200) FILE ENTRY FOR THIS EMPLOYEE-CANNOT CONTINUE" G NAM
 S PDA(1)=$S((+$O(^PRSPC("SSN",PRSESSN,0))>0):$O(^PRSPC("SSN",PRSESSN,0)),1:"")
 S PRSESRCE="NON-GOVERNMENT (e.g. Institution, Company or University)"
 ;
 ;get service of user taking non-local course
 D EN2^PRSEUTL3($G(VA200DA)) ;returns PRSESER,PRSESER("TX")
 ;PRSESER=ien of service (454.1)
 ;PRSESER("TX")=name of service
 I PRSESER="" S PRSESER("TX")="NON-EMPLOYEE"  ;no CC/Org code
 Q
SCUB ;
 K DA,DIC,DR,DIE,POUT S (PRSENAM,PRSEDT)="",PRSESW=0
 F  K POUT,PRSEY,PRSEED S Y=-1 R !!,"Select NON-LOCAL C.E. CLASS: ",X:DTIME S:'$T X="^^" S:X="" Y="" Q:"^^"[X  D  Q:Y'=""!(Y<0)
 .    S DIC("S")="S DATA=$G(^PRSE(452,Y,0)) I $P($G(^PRSE(452,+Y,6)),U)=""N"",$P(DATA,U,21)=""C"""
 .    S DIC("W")="W ?($X+4),$P($G(^(0)),U,13)"
 .    S DIC=452,DLAYGO=452,DIC(0)=$E("SZE",1,(X'=" ")+2),D="AK" D IX^DIC K DIC S PRSEDA=+Y I X?1"?".E!(Y>0) W:X=" " "   ",$P(Y(0),U,2) S Y=$S(Y>0:$P(Y(0),U,2),1:"") Q
 .   I $G(X)'="",$G(X)'=" ",$L(X)<2!($L(X)>53) W !!,$C(7),"Answer should be between 2 and 53 characters" S Y="" Q
 .   I X=" ",'(+Y>0)!($L(X)<2) S POUT=1 Q
 .   S X=$$UP^XLFSTR(X)
 .   F  W !?3,"ARE YOU ADDING '"_X_"' AS A NEW CLASS" S %=0 D YN^DICN Q:%  W !?7,"ANSWER YES OR NO."
 .   S Y=$S(%=1:X,%=2:"",1:-1)
 .   Q
 Q:Y=""!(Y<0)  S PRSENAM=Y K Y
DATE D EN4^PRSEUTL1($G(PRSENAM)) F  S Y=-1 W !!,"Select CLASS DATE: "_$S($G(PRSEY(1))'="":PRSEY(1)_"// ",1:"") R X:DTIME S:'$T X="^^" S:X=""&(+$G(PRSEY)) X=$G(PRSEY) S:X=""&'(+$G(PRSEY)>0) Y="" Q:"^^"[X  D  Q:Y'=""!(Y<0)
 .   I X'?1"?".E S %DT="ET" D ^%DT S:Y'>0 Y="" Q:+Y>DT!(Y'>0)  D  Q
 .   .   S X=Y,Y=$S($O(^PRSE(452,"AL"_PRSENAM,Y,0)):Y,1:"") Q:Y>0
 .   .   F  W !?3,"ARE YOU ADDING '" S Y=X D DT^DIQ W "' AS A NEW CLASS DATE" S %=0 D YN^DICN Q:%  W !?7,"ANSWER YES OR NO."
 .   .   S Y=$S(%=1:X,%=2:"",1:-1)
 .   .   Q
 .   W @IOF S (Z,X)=0 F  S X=$O(^PRSE(452,"AL"_PRSENAM,X)) Q:X'>0!Z  S PRSEDA=0 F  S PRSEDA=$O(^PRSE(452,"AL"_PRSENAM,X,PRSEDA)) Q:PRSEDA'>0  D  Q:Z
 .   .   S Y=$P($G(^PRSE(452,PRSEDA,0)),U,3) W !?8 D DT^DIQ
 .   .   I $Y>(IOSL-3) R !?8,"""^"" TO STOP: ",Z:DTIME S:'$T Z="^^" S Z=(Z="^"!(Z="^^")) W @IOF
 .   .   Q
 .   S %DT="ET" D HELP^%DTC
 .   S Y=""
 .   Q
 Q:Y=""!(Y<0)  D NOW^%DTC I +Y>% W $C(7),!,"You cannot take attendance for a class with a future date!" G DATE
 S PRSEDT=Y
 Q
