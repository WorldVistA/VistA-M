PRCSAPP1 ;WISC/KMB-CHECK 2237 BEFORE APPROVAL ;12/17/93
 ;;5.1;IFCAP;**148**;Oct 20, 2000;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
CHEC ;
 I +$P(^PRCS(410,DA,0),"-")'=PRC("SITE") S SPENDCP=1 G EVAL
 I +$P(^PRCS(410,DA,0),"-",4)'=PRC("CP") S SPENDCP=2 G EVAL
 S D0=DA,DIC="^PRCS(410," L +^PRCS(410,DA):5 W @IOF D ^PRCST5 H 1
 L -^PRCS(410,DA)
 I $D(^PRCS(410,DA,7)),$P(^(7),U,6)'="" S SPENDCP=3 D EVAL Q
 S:'$D(^PRCS(410,DA,11)) ^(11)="" I '$P(^(11),U,3) S SPENDCP=4 D EVAL Q
 ; PRC*5.1*148
 I $P(^PRCS(410,DA,0),"^",11)="" D ERS410^PRC0G(DA)
 S PRCSN=^PRCS(410,DA,0),PRCHQ=$P(PRCSN,"^",4),PRC("FY")=$P(PRCSN,"-",2),PRC("QTR")=$P(PRCSN,"-",3)
T1 ;   this is the 'jump' entry point for the CP official
 ;   to approve a request just after s/he creates it
 I '$D(ALL) N JUMP,ALL S JUMP=1,ALL=0
 N ESTSHP,CST S ESTSHP=$P($G(^PRCS(410,DA,9)),"^",4),CST=$P($G(^PRCS(410,DA,4)),"^",8)
 S PRC("RBDT")=$P(^PRCS(410,DA,0),"^",11),PRCST1=$$DATE^PRC0C(PRC("RBDT"),"I")
 S PRCST1=$S($D(^PRC(420,PRC("SITE"),1,+PRC("CP"),4,$E($P(PRCST1,"^"),3,4),0)):$P(^(0),U,$P(PRCST1,"^",2)+1),1:0),PRCST=$S($D(^PRCS(410,DA,4)):$P(^(4),U,8),1:0)
 S PRCST=ESTSHP+CST I PRCST<0,$P(^PRCS(410,DA,0),"^",4)'=1 S SPENDCP=9 D EVAL Q
 ;Check for different costs
 N PRCCOMCT,PRCBOCCT
 S PRCCOMCT=$S($D(^PRCS(410,DA,4)):$P(^(4),"^"),1:0)
 S PRCBOCCT=$S($D(^PRCS(410,DA,3)):$P(^(3),"^",7),1:0)
 I $P(^PRCS(410,DA,0),"^",2)="O",$P(^(0),"^",4)=1,$J(PRCCOMCT,0,2)'=$J(PRCBOCCT,0,2) S SPENDCP=10 D EVAL Q
 ;
 W !,"Current Control Point balance: $",$J(PRCST1,0,2),!,"Estimated cost of this request: $",$J(PRCST,0,2) H 1
T2 ;
 ;N ALLTOT,MINUS S ALLTOT=0 F Z=2:1:PRC("QTR")+1 S ALLTOT=ALLTOT+$P($G(^PRC(420,PRC("SITE"),1,+PRC("CP"),4,PRC("FY"),0)),"^",Z)
 ;S MINUS="" I ALLTOT<0 S ALLTOT=-ALLTOT,MINUS="-"
 ;W !,"Total uncommitted balance from current and prior quarters: ",MINUS,"$",$J(ALLTOT,0,2),!
 Q:$D(REPORT2)
 ;S STRING=PRC("SITE")_"^"_PRC("CP")_"^"_PRC("FY")_"^"_PRC("QTR")
 ;S TEST=$$YEAR^PRC0C(PRC("FY"))'<$$DATE^PRC0C("N","E")
 ;I TEST S TEST=$$OVCOM^PRCS0A(STRING,PRCST,2) I TEST'=0 S SPENDCP=5 D EVAL Q
 I $$OVCOM^PRCS0A(PRC("SITE")_"^"_PRC("CP")_"^"_$P($$DATE^PRC0C(PRC("RBDT"),"I"),"^",1,2),PRCST,2)'=0 S SPENDCP=5 D EVAL Q
 I $P(PRCSN,"^",4)="" S SPENDCP=6 D EVAL Q
 I $P(PRCSN,"^",4)>1,'$D(^PRCS(410,DA,"IT",0)) S SPENDCP=7 D EVAL Q
 I +$P(^PRCS(410,DA,3),"^",3)=0 S SPENDCP=8 D EVAL Q
 I '$$CHECK^PRCEN(DA) S SPENDCP=11 D EVAL Q
 S OK=1 QUIT
EVAL ;
 I SPENDCP'=0 W !,$P($T(MESSAGE+SPENDCP),";;",2) H 2 Q:$D(JUMP)  R !!,"Press return to continue: ",X:DTIME I X["^" D
 .I ALL=0 S STOP1=-1 Q
 .S %=1 W !,"Continue looping through your control points" D YN^DICN I %=2 S STOP1=-1 Q
 .I %=0 W !,"Enter yes or no.  Continue" S %=1 D YN^DICN S:%<2 STOP1=-1
 Q
MESSAGE ;
 ;;This transaction was not entered for your site
 ;;This transaction was not entered for your control point
 ;;This transaction has already been approved!
 ;;This transaction is not ready for approval
 ;;You do not have the funds to approve this request
 ;;This request does not have a form type
 ;;Requests without items cannot be approved
 ;;This transaction does not have a cost center
 ;;This request has a negative dollar amount
 ;;Committed Cost does not equal BOC $ Amount - Please re-edit.
 ;;Missing required data, request needs to be edited.
