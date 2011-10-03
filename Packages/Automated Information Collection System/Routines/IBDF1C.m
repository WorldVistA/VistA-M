IBDF1C ;ALB/CJM - ENCOUNTER FORM (print sample form) ; FEB 11,1992
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**42**;APR 24, 1997
 ;
 ;This print routine forces queueing - so that allocation problems do not occur.
 ;
PRINT(IBFORM) ;
 N IBQUIT,NODE,HT,WD S IBQUIT=0
 D FULL^VALM1
 S VALMBCK="R"
 ;
 I ('$G(IBFORM))!$G(IBTKBLK) N IBFORM D FORM G:IBQUIT EXIT
 I $G(IBFORM) S NODE=$G(^IBE(357,IBFORM,0)),WD=$P(NODE,"^",9),HT=$P(NODE,"^",10) K NODE
 D DEVICE,HOME^%ZIS G EXIT
 ;
QUEUED ; entry
 D FORM^IBDF2A(IBFORM,0)
 I $D(ZTQUEUED) S ZTREQ="@"
 ;
EXIT ;
 K ZTSK,Y,X,J,D0,%,%I,D,DIC,DY,DX,I
 Q
 ;
DEVICE ;
 W !,"** You must queue the form to print. **"
 W !,$C(7),"** This Encounter Form requires "_WD_" columns and a page length of "_HT_" lines. **",!
 ;
 ;queuing is automatic - the device is not opened
 K %IS,%ZIS,IOP S %ZIS="N0Q",%ZIS("A")="Printer to queue to: ",%ZIS("B")="",%ZIS("S")="I $E($P($G(^%ZIS(2,+$G(^%ZIS(1,Y,""SUBTYPE"")),0)),U),1,2)=""P-""" D ^%ZIS
 Q:POP
 I $D(IO("S")) D  G DEVICE
 .W !!,"** Printer can not be a slave printer please try again.**",!
 S ZTRTN="QUEUED^IBDF1C",ZTSAVE("IBFORM")="",ZTDESC="ENCOUNTER FORM",ZTDTH=$H D ^%ZTLOAD W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 Q
 ;
FORM ;returns IBFORM
 N P4
 S IBFORM=0
 ;if the user used the '=' syntax then assume he wants to choose from the list
 S P4=$P(XQORNOD(0),"^",4)
 I P4["==" S P4=$P(P4,"==")_"="_$P(P4,"==",2),$P(XQORNOD(0),"^",4)=P4
 I $G(VALM("TITLE"))["FORMS",$P(P4,"=",2) D
 .I $G(IBAPI("SELECT"))'="" X IBAPI("SELECT")
 .S:IBFORM Y(0)=$G(^IBE(357,IBFORM,0))
 E  D
 .K DIR S DIR(0)="YA",DIR("A")="Do you want to print a form from the toolkit? "
 .D ^DIR K DIR Q:(Y=-1)!($D(DIRUT))
 .K DIC S DIC("S")=$S(Y:"I $P(^(0),U,7),$P(^(0),U)'=""WORKCOPY"",$P(^(0),U)'=""TOOL KIT""",1:"I '$P(^(0),U,7)"),DIC=357,DIC(0)="AEQZ",DIC("A")="Select any FORM by name: "
 .D ^DIC K DIC Q:$D(DIRUT)!(Y<0)
 .S IBFORM=+Y
 I 'IBFORM S IBQUIT=1 Q
 S WD=$P($G(Y(0)),"^",9),HT=$P($G(Y(0)),"^",10)
 Q
