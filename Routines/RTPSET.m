RTPSET ;MJK/TROY ISC;Sign-on Parameter Routine; ; 5/7/87  1:50 PM ;
 ;;2.0;Record Tracking;**46**;10/22/91 ;Build 46
 ;
 ;entry point to set-up variables for application and file room
 ;X is defined as the application's name
 I $D(RTSYS),$D(RTAPL),$D(RTFR),$D(RTDIV) K XQUIT Q
 K RTSYS,RTAPL,RTFR,RTDIV D APL,SET:'$D(XQUIT) K:$D(XQUIT) RTAPL,RTSYS,RTFR,RTDIV Q
 ;
DUZ ;sets up RTDUZ variable for template use
 S RTDUZ=$S($D(DUZ)[0:"",DUZ:DUZ,1:"") Q
 ;
SET ;entry point to assign file room parameters; RTAPL defined
 S X="T",%DT="" D ^%DT S DT=Y K %DT
 I $D(RTSYS),$D(RTAPL),$D(RTFR),$D(RTDIV) K XQUIT Q
 K RTDIV,RTFR S XQUIT=""
 D FR^RTPSET1,DIV:$D(RTFR) I $D(RTFR),$D(RTDIV) D INFO K XQUIT
 I $D(RTDIV),$D(DUZ(2)),+DUZ(2)'=+RTDIV W !!,*7,"WARNING: User 'institution' and file room's 'institution' are different:",!?20,"USER      : ",$S($D(^DIC(4,+DUZ(2),0)):$P(^(0),"^"),1:DUZ(2)),!?20,"FILE ROOM : ",$P(^DIC(4,RTDIV,0),"^")
 K F,F1,C,D,I K:'$D(RTFR)!('$D(RTDIV)) RTDIV,RTFR Q
 ;
KILL K RTSYS,RTAPL,RTDIV,RTFR,RTC,DICS
 K D,DO,DGO,DA,D0,DIC,DIC1,DIE,DIY,DIYS,DR,X1,A,F,O,N,I,J,P,V,Z,%,%H,%I,POP,IO("Q") Q
DIV ;entry point to get file room institution; RTAPL and RTFR defined
 K RTDIV S X1=+$P(RTFR,"^",2) K RTINST D DIV^RTUTL S:$D(RTINST) RTDIV=RTINST K X1,RTINST Q
 ;
DIV1 ;entry point to determine institution for non-file room users
 K RTDIV I $O(^DIC(195.1,+RTAPL,"INST",0)) S I=+$O(^(0)) I '$O(^(I)),$D(^DIC(4,I,0)) S RTDIV=I Q
 S DIC(0)="AEMQI",DIC="^DIC(4,",DIC("A")="Select Institution: ",DIC("S")="I $D(^DIC(195.1,"_+RTAPL_",""INST"",Y,0))" S:$S('$D(DUZ(2)):0,$D(^DIC(195.1,+RTAPL,"INST",+DUZ(2),0)):1,1:0) DIC("B")=$P(^DIC(4,+DUZ(2),0),"^")
 D ^DIC K DIC S:Y>0 RTDIV=+Y Q
 ;
APL ;entry point to set-up local variables for application; X is defined as the application's name
 Q:$D(RTAPL)&($D(RTSYS))  S XQUIT="",DIC(0)="IM",DIC="^DIC(195.1," D ^DIC Q:Y<0  D APL1 K:$D(RTAPL) XQUIT Q
APL1 K RTAPL,RTSYS Q:'$D(^DIC(195.4,1,0))  S RTSYS=^(0) Q:'$D(^DIC(195.1,+Y,0))  S RTAPL=+Y_";"_^(0) Q
 ;
APL2 K RTAPL,RTSYS S XQUIT="",DIC(0)="AEMQI",DIC="^DIC(195.1," D ^DIC Q:Y<0  D APL1 K:$D(RTAPL) XQUIT Q
 ;
INFO I $D(RTFR),$D(RTAPL)!($D(RTTY)) W !!,"You are tracking '",$S($D(RTTY):$P($P(RTTY,"^"),";",2)_"S'",1:$P($P(RTAPL,"^"),";",2)_"' records"),!?10,"..."," from the '",$P(^SC(+$P(RTFR,"^",2),0),"^"),"' file room.",! Q
 ;
XR S Y=^DIC(195.4,1,"RAD") G SETUP
MR S Y=^DIC(195.4,1,"MAS")
SETUP D APL1 S Y=+$P(Y,"^",2) D TYPE1^RTUTL K:'$D(RTAPL)!('$D(RTTY)) RTAPL,RTTY Q
 ;
OVERALL ;entry point for RT OVERALL menu
 Q:$D(RTAPL)&($D(RTSYS))  S XQUIT="",DIC(0)="IAEMQ",DIC="^DIC(195.1," D ^DIC Q:Y<0  K XQUIT D APL1,SET K:'$D(DUOUT) XQUIT K DUOUT Q
 ;
TYPE K RTTY,RTDIV,RTFR S XQUIT="",DIC(0)="IAQEMZ",DIC="^DIC(195.2,",DIC("S")="I $S('$D(RTAPL):1,$P(^(0),U,3)=+RTAPL:1,1:0),$S('$D(^(""I"")):1,'^(""I""):1,DT'>+^(""I""):1,1:0)",DIC("A")="Select Record Type: " D ^DIC K DIC Q:Y<0
 S RTTY=+Y_";"_Y(0) S Y=$S($D(RTAPL):+RTAPL,1:+$P(Y(0),"^",3)) D APL1
 D FR^RTPSET1:$D(RTAPL),DIV:$D(RTFR) K:'$D(RTDIV)!('$D(RTAPL))!('$D(RTFR))!('$D(RTTY)) RTTY,RTDIV,RTAPL,RTFR K:$D(RTTY) XQUIT Q
 ;
MAS S Y=+^DIC(195.4,1,"MAS") D APL1 Q
RAD S Y=+^DIC(195.4,1,"RAD") D APL1 Q
