ORX1 ; slc/dcm - OE/RR Nature of Order entry points ;12/26/96  09:49
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**92,242**;Dec 17, 1997;Build 6
 ;
NA(DEFAULT,REQUIRD,FB,DIRA,DC,LIST) ;Function to get Nature of order
 ;DEFAULT [not required] =Free text code or pointer to Nature of order (file 100.02).
 ;                        Used for default response.
 ;REQUIRD [not required] =1 to require a response from user,
 ;                       =0 (default) not to require response.
 ;FB [not required] =F for frontdoor,
 ;                  =B (default) for backdoor.
 ;                  Screens on Frontdoor/Backdoor types.
 ;                  Nature of order entries are setup to be available for
 ;                  frontdoor or backdoor processing.
 ;DIRA [not required] =prompt for DIR("A")
 ;                     default:"Reason for Order/Change"
 ;DC [not required] =1 if you want to include 'DC only' types,
 ;                  =0 (default) includes all other types except for 'DC only'.
 ;LIST [not required] =List of 'Nature of Order' codes (from file 100.02)
 ;                   allowed.  If this is passed, then DC and FB params
 ;                   are ignored. Format: code1code2code3
 ;Example: S X=$$NA^ORX1(1,1,,,,"WVPIS")
 ;Returned value: ifn^name^code
 N DIR,X,Y,DIRUT,DUOUT
 S DIR("?",1)="This order/change will be recorded in the patient's electronic record."
 S DIR("?",2)="Depending on the nature of this activity, a notification may be sent to the"
 S DIR("?",3)="requesting clinician to electronically sign this action, and a copy of this"
 S DIR("?",4)="action may be printed on the ward/clinic to be placed in the patient's chart."
 S DIR("?",5)=""
 S DIR("?",6)="   Enter '??' for more information."
 S DIR("?")="  "
 S DIR("A")=$S($L($G(DIRA)):DIRA,1:"Reason for Order/Change")
 I '$G(DEFAULT),$L($G(DEFAULT)),$O(^ORD(100.02,"C",DEFAULT,0)) S DEFAULT=$O(^(0))
 I $G(DEFAULT) S DIR("B")=$S($D(^ORD(100.02,+DEFAULT,0)):$S('$L($G(LIST)):$P(^(0),"^"),1:$S($L($G(LIST))&($G(LIST)[$P(^(0),"^",2)):$P(^(0),"^"),1:""),1:""),1:"") K:DIR("B")="" DIR("B")
 S DIR(0)="P^100.02:EMZ"
 S:'$D(FB) FB="B" S:FB="" FB="B" S:'$D(DC) DC=0
 I $L($G(LIST)) S DIR("S")="I '$P(^(0),""^"",4),'$P(^(0),""^"",3),LIST[$P(^(0),""^"",2)"
 I '$L($G(LIST)) S DIR("S")="I '$P(^(0),""^"",4),'$P(^(0),""^"",3),('$P(^(0),""^"",6)!(DC)),"_$S(FB="B":"""XB""[$P(^(0),""^"",5)",FB="F":"""XF""[$P(^(0),""^"",5)",1:0)
 S DIR("S")=DIR("S")_",'$$SCREEN^XTID(100.02,,Y_"","")" ;inactive VUID
 S DIR("??")="^D NA1^ORX1(DIR(""S""))"
OT2 D ^DIR
 I 'Y,$G(REQUIRD)=1 W !,"A "_$S($L($G(DIRA)):DIRA,1:"NATURE OF ORDER/CHANGE")_" must be entered",$C(7),! G OT2
 I Y S $P(Y,"^",3)=$P(^ORD(100.02,+Y,0),"^",2)
 Q Y
NA1(SCREEN) ;Executable help for Nature of order
 ;SCREEN=Mumps code that is used like DIC("S") to screen out entries
 N X,X1,Y
 W !?30," Require",?43,"   Print",?56,"Print on"
 W !?2,"Nature of Order Activity",?29,"E.Signature",?43,"Chart Copy",?56,"Summary"
 W !?2,"------------------------",?29,"-----------",?43,"----------",?56,"--------"
 S Y=0 F  S Y=$O(^ORD(100.02,Y)) Q:Y<1  I $D(^(Y,0)) X:$D(SCREEN) SCREEN I $T S X=^ORD(100.02,Y,0),X1=$G(^(1)) W !,?2,$P(X,"^"),?34,$S($P(X1,"^",4)=2:"x",1:""),?47,$S($P(X1,"^",2):"x",1:""),?59,$S($P(X1,"^",3):"x",1:"")
 Q
NA2(SCREEN) ;Get help for DC Reasons
 ;SCREEN=Mumps code that is used like DIC("S") to screen out entries
 N X,X1,I
 W !?30," Require",?43,"   Print",?56,"Print on"
 W !,"Order Reason",?29,"E.Signature",?43,"Chart Copy",?56,"Summary"
 W !,"------------",?29,"-----------",?43,"----------",?56,"--------"
 S I=0 F  S I=$O(^ORD(100.03,I)) Q:I<1  I $D(^(I,0)) X:$D(SCREEN) SCREEN I $T S X=^(0) I $P(X,"^",7),$D(^ORD(100.02,$P(X,"^",7),0)) W !,$P(X,"^") S X=^(0),X1=$G(^(1)) D
 . W ?34,$S($P(X1,"^",4)=2:"x",1:""),?47,$S($P(X1,"^",2):"x",1:""),?59,$S($P(X1,"^",3):"x",1:"")
 Q
 ;
CREATE(X) ; -- Returns 1 or 0, if action should be created or not
 N Y Q:'$L($G(X)) 0
 I 'X S X=+$O(^ORD(100.02,"C",X,0))
 S Y=+$P($G(^ORD(100.02,+X,1)),U)
 Q Y
 ;
SIGSTS(X) ; -- Returns default signature status for nature X
 N Y S Y="" G:'$L($G(X)) SIGQ
 I 'X S X=+$O(^ORD(100.02,"C",X,0)) G:'X SIGQ
 S Y=$P($G(^ORD(100.02,+X,1)),U,4)
SIGQ Q Y
 ;
CHART(X) ; -- Returns 1 or 0, print chart copy for nature X
 N Y S Y="" G:'$L($G(X)) CHQ
 I 'X S X=+$O(^ORD(100.02,"C",X,0)) G:'X CHQ
 S Y=$P($G(^ORD(100.02,+X,1)),U,2)
CHQ Q Y
 ;
ACTV(X) ; -- Returns 1 or 0, include action in Active Orders
 N Y S Y="" G:'$L($G(X)) ACTQ
 I 'X S X=+$O(^ORD(100.02,"C",X,0)) G:'X ACTQ
 S Y=$P($G(^ORD(100.02,+X,1)),U,6)
ACTQ Q Y
 ;
DC(DEFAULT,REQ,PKG,DIRA) ;Function to get a DC Reason
 ;DEFAULT=ifn of default reason
 ;REQ=1 to require a response
 ;PKG=ptr to file 9.4 to only get reasons for a specific package
 ;DIRA=Default prompt to be used instead of DIR("A")
 N DIR,X,Y,DIRUT,DUOUT
 S DIR("?",1)="This order/change will be recorded in the patient's electronic record."
 S DIR("?",2)="Depending of the nature of this activity, a notification may be sent to the"
 S DIR("?",3)="requesting clinician to electronically sign this action, and a copy of this"
 S DIR("?",4)="action may be printed on the ward/clinic to be placed in the patient's chart."
 S DIR("?",5)=""
 S DIR("?")="  "
 S DIR("A")="Reason" I $L($G(DIRA)) S DIR("A")=DIRA
 I $G(DEFAULT) S DIR("B")=$S($G(DEFAULT):$S($D(^ORD(100.03,+DEFAULT,0)):$P(^(0),"^"),1:""),1:"")
 S DIR(0)="P^100.03:EMZ"
 S DIR("S")="I '$P(^(0),""^"",4)"_$S($G(PKG):",$P(^(0),""^"",5)=PKG",1:"")
 S DIR("??")="^D NA2^ORX1(DIR(""S""))"
OT1 D ^DIR
 I 'Y,$G(REQ)=1 W !,"A REASON FOR DC must be entered",$C(7),! G OT1
 Q $S(Y:+Y_"^"_$G(Y(0)),1:Y)
 ;
EDITDCR ; -- Edit DC Reason
 N X,Y,D,DIC,DIE,DR,DA,DLAYGO W !
EDC1 S DIC=100.03,DIC(0)="AELNQM",DIC("A")="Select DC REASON: ",DLAYGO=100.03
 S DIC("S")="I $P(^(0),U,5)="_+$O(^DIC(9.4,"C","OR",0)),D="B^S"
 S DIC("DR")=".05////"_+$O(^DIC(9.4,"C","OR",0)) D MIX^DIC1 Q:Y'>0
 S DA=+Y,DIE=DIC,DR=".01;.03;.04;.07" D ^DIE
 W ! G EDC1
 Q
 ;
EDITNAT ; -- Edit allowable Nature of Order fields
 N X,Y,DA,DR,DIE,DIC W !
EDN S DIC="^ORD(100.02,",DIC(0)="AEQM",DIC("A")="Select NATURE OF ORDER: "
 S DIC("S")="I '$P(^(0),""^"",4),'$$SCREEN^XTID(100.02,,Y_"","")" ;inactive VUID
 D ^DIC Q:Y<1
 S DA=+Y,DIE=DIC,DR=".12;.13;.15;.16" D ^DIE
 W ! G EDN
 Q
