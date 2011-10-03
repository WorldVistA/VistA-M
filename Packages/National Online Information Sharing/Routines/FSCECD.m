FSCECD ;SLC/STAFF-NOIS List Edit Close Data ;12/15/96  17:18
 ;;1.1;NOIS;;Sep 06, 1998
 ;
CDATE(CALL,CDATE,OK) ; from FSCEC, FSCEDC
 N DIR,ODATE,X,Y K DIR
 S OK=1,CDATE=$S($G(CDATE):$$FMTE^XLFDT(CDATE),$L($G(CDATE)):CDATE,1:"TODAY")
 S ODATE=$P($G(^FSCD("CALL",+$G(CALL),0)),U,3) I 'ODATE S ODATE=DT
 S DIR(0)="DA^"_ODATE_":DT:EPX",DIR("A")="Date resolved: " S:$L(CDATE) DIR("B")=CDATE
 S DIR("?",1)="Enter the date the call was closed."
 S DIR("?",2)="Date must be from "_$$FMTE^XLFDT(ODATE)_" to TODAY."
 S DIR("?",3)="Enter '^' to exit or '??' for more help."
 S DIR("?")="^D HELP^%DTC,HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) S OK=0 Q
 S CDATE=Y
 Q
 ;
FUNC(FUNC,OK) ; from FSCEC
 N DIC,X,Y K DIC
 S OK=1,FUNC=$S($G(FUNC):$$VALUE^FSCGET(FUNC,7106.4,.01),$L($G(FUNC)):FUNC,1:"SUPPORT")
 S DIC=7106.4,DIC(0)="AEMOQ",DIC("A")="Functional Area: ",DIC("B")=FUNC,DIC("S")="I '$P(^(0),U,2)"
 D ^DIC K DIC
 I Y<1 S FUNC="",OK=0 Q
 S FUNC=+Y
 Q
 ;
TASK(TASK,OK) ; from FSCEC
 N DIC,X,Y K DIC
 S OK=1,TASK=$S($G(TASK):$$VALUE^FSCGET(TASK,7106.3,.01),$L($G(TASK)):TASK,1:"PROBLEM RESOLUTION")
 S DIC=7106.3,DIC(0)="AEMOQ",DIC("A")="Task: ",DIC("B")=TASK,DIC("S")="I '$P(^(0),U,2)"
 D ^DIC K DIC
 I Y<1 S TASK="",OK=0 Q
 S TASK=+Y
 Q
