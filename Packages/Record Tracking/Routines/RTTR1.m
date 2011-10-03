RTTR1 ;ALB/PKE,JLU-Record Transfer Option ; 11/09/90  14:24 ; 1/16/03 4:23pm
 ;;2.0;Record Tracking;**6,33,38**;10/22/91 
 ;
PT W @IOF D EQUALS^RTUTL3
 W !,?20,XMB(CT) D LINE^RTUTL3 W !,"|    |",?20,"Station Name            Number      Mail Routing Symbol",?79,"|"
 Q
 ;
PN I $D(XMB(CT)) W !,"| 1a |",XMB(CT),?79,"|"
 I $D(XMB(CT+1)) W !,"| 1b |",XMB(CT+1),?79,"|"
 I $D(XMB(CT+2)) W !,"| 1c |",XMB(CT+2),?79,"|"
 Q
 ;
PN1 D LINE^RTUTL3
 W !,"| 4. NAME (Last,First,Middle)",?79,"|"
 Q
 ;
PN2 W !,"|  ",XMB(CT),?$X+46,"|"
 Q
 ;
PY5 D LINE^RTUTL3
 W !,"| 5a. [CN] ",XMB(CT),?39,"|","  [SS] ",XMB(CT+1),?79,"|"
 Q
 ;
PY6 D LINE^RTUTL3
 W !,"| 6.  [SN] ",XMB(CT),?79,"|"
 Q
 ;
PL16 D LINE^RTUTL3
 W !,"| 16.  FROM (Originating office)   ",XMB(CT)
 Q
 ;
PL16A W $C(13),"| 17.  Date ",XMB(CT+1),?$X+49,"|"
 Q
 ;
PL17 W $C(13),"| 18. Check when copy 2 is sent to Telecom  [",XMB(CT),"] UNIT ",?$X+26,"|"
 Q
 ;
REQ ;can screen also on domain entry to only select setup domains
 ;no laygo?
 ;entry for action on  transferred TO other
 ;need to format xmb(1-3)
4 ;1,2,3   Station Name, No,  Mail Routing
 S RTVAR=0
 S DIC="^RTV(195.9,",DIC("A")="Select Institution: ",DIC(0)="IAEQM"
 S DIC("S")="S Z0=^(0),Z=$P($P(Z0,U),"";"",2) I Z=""DIC(4,"",$P(Z0,U,3)="_+RTAPL
 S DIC("V")="I $P(Y(0),U,4)=""I"""
 K XMB,XMY
 S CT=1,XMB(CT)="REQUEST FOR TRANSFER OF VETERANS RECORDS "
 D PT
 ;
 S CT=2,DIC("B")=""
AGN F CT=CT:1:4 S DIC("A")="| 1"_$C(95+CT)_" |  " D ^DIC Q:Y<0  G:$D(RTB(+Y)) AGN S RTB(+Y)=CT,RTB=+Y,Y=$P(Y,"^",2) D NAM S XMB(CT)=$J(Y,25)_$J(N,18) D WHOTO K X0,X1,X2,X3
 I $D(DUOUT)!($D(DTOUT)) D EX Q
XXX ;S BL=".",$P(BL,".",50)=""
 K DIC
 D INST
 ;4 name ,5 cn    ssn , 6 sn
Y4 S DIC("A")="|  ",DIC("B")="",CT=5
 S DIC(0)="AIEMQZ",DIC="^DPT(" D PN1 S NDIC="N XMB D ^DIC" X NDIC K NDIC I $D(DUOUT)!($D(DTOUT))!(Y<1) D EX Q
 S XMB(CT)=$J($P(Y,"^",2),30)
 S CT=1 D PT
 S CT=2 D PN
 S CT=5 D PN1,PN2
 K DIC
 ;
Y5 S CT=6 I $D(^DPT(+Y,.31)) S J=$P(^(.31),U,3)
 E  S J=""
 S XMB(CT)=$S(J:J,1:"Unknown"),XMB(CT+1)=$S(+$P(Y(0),U,9):$P(Y(0),U,9),1:"Unknown")
 D PY5
 ;
Y6 S CT=8 I $D(^DPT(+Y,.32)) S J=$P(^(.32),U,8)
 E  S J=""
 S XMB(CT)=$S(J:J,1:"Unknown")
 D PY6
 ;
 K DUOUT,DTOUT D Y7^RTTR11 I $D(DUOUT)!($D(DTOUT)) D EX Q
 ;
L16 ;16 FROM (originating office)
 S CT=35
 ;saved incase want to make this field editable.
 ;S DIR("A")="| 16.  FROM (Originating office)  ",DIR(0)="FAO^1:40"
 ;D ^DIR I $D(DUOUT)!($D(DTOUT)) D EX Q
 ;K DIR
 S XMB(CT)=$S($D(RTDIV):$P(^DIC(4,RTDIV,0),U),1:"Unknown")
 D PL16
 ;
 D LINE^RTUTL3
 K X,Y,DIR
 S DIR(0)="D^::AET",DIR("A")="| 17.  Date  ? ",DIR("B")="NOW"
 D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) D EX Q
 D DD^%DT S XMB(CT+1)=Y
 D PL16A
 I $D(RTKEY) Q
 ;
L17 S CT=37
 I XMB(12)="" S XMB(CT)="" D XM1,LINE^RTUTL3 Q
 D LINE^RTUTL3
 S DIR("A")="| 18. Check when copy 2 is sent to Telecom  [ ] UNIT ",DIR(0)="YOA"
 D ^DIR I $D(DUOUT)!($D(DTOUT)) D EX Q
 S XMB(CT)=$S(Y=1:"X",1:"")
 D PL17
 D LINE^RTUTL3
 D XM1
XM S XMY(DUZ)="",XMB="RT REQUEST/NOTICE TRANSFER" D ^XMB K XMB
 D EX Q
 ;
BOR S DA=+Y,DR="[RT BORROWER SET-UP]",DIE="^RTV(195.9," D ^DIE K DE,DQ Q
NAM S Z="^"_$P(Y,";",2) I "^DIC(4,^"[(Z_"^"),$D(@(Z_+Y_",0)")) S Y=$P(^(0),"^"),N=$S($D(^(99)):$P(^(99),"^"),1:"") Q
 Q
WHOTO ;
 N RTQUIT
 I $D(^RTV(195.9,RTB,0)),$D(^(1)) S X0=$P(^(0),U,5),X1=^(1)
 E  Q
 ;X0 request prt ;X1 domain ;X2 remot mail grp ;x3 mail routing sym
 S X2=$P(X1,"^",2),X3=$P(X1,"^",3),XMB(CT)=XMB(CT)_$J(X3,25),X1=$P(X1,"^")
 I $G(X0)']""&($G(X2)']"") W !!,"Routing information for this Borrower/Location is incomplete - see Site Manager." S RTQUIT=1
 I '$L(X1) W !,"Domain for this Borrower/Loacation is missing - see Site Manager." S RTQUIT=1
 I $G(RTQUIT)=1 W !?20,"No message will be sent.",!!! Q
 I $D(^DIC(4.2,X1,0)) S X1=$P(^(0),"^")
 E  Q
 I '$L(X0),'$L(X2) Q
 S:$L(X0) AXMY("D."_X0_"@"_X1)=""
 S:$L(X2) AXMY("G."_X2_"@"_X1)=""
 Q
INST S AN=""
 F AZ=0:0 S AN=$O(AXMY(AN)) Q:AN=""  I $E(AN,$L(AN))="@" K AXMY(AN)
 S (AN,XMN)=0,XMDUZ=DUZ F AZ=0:0 S AN=$O(AXMY(AN)) Q:AN=""  S X=AN D INST^XMA21
 K AZ,AN,AXMY,XMN,XMM,XMQ,XMMG,XMDUZ Q
 ;
EX K RTB,DIR,CT,DA,DIE,DIC,DR,DTOUT,DUOUT,XMB,A,BL,C,N,X0,X1,X2,X3,XMY
 K RTVAR,RTV,Y,YZ,Z,X,Y Q
 ;
XM1 S CT=1 D PT^RTTR1
 S CT=2 D PN^RTTR1
 S CT=5 D PN1^RTTR1,PN2^RTTR1
 S CT=6 D PY5^RTTR1
 S CT=8 D PY6^RTTR1
 S CT=10 D LINE^RTUTL3 W ! D PY8^RTTR11
 S CT=12 D LINE^RTUTL3 W ! D PY11^RTTR11,LINE^RTUTL3
 W ! K DIR S DIR(0)="E" D ^DIR K DIR Q:'Y
 S CT=21 W ! D LINE^RTUTL3,PY13D^RTTR11 W ! D PY13^RTTR11,PY13A^RTTR11 W ! D PY13B^RTTR11,PY13C^RTTR11
 S CT=31 D LINE^RTUTL3,PL14^RTTR11 W ! D PL14A^RTTR11 W ! D PL14B^RTTR11
 S CT=33 D LINE^RTUTL3 W ! D PL15^RTTR11
 S CT=35 D PL16^RTTR1,LINE^RTUTL3 W ! D PL16A^RTTR1
 S CT=37 D LINE^RTUTL3 W ! D PL17^RTTR1,LINE^RTUTL3
 Q
