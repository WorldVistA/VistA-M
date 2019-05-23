PRCSUT ;WISC/SAW/DGL - CONTROL POINT ACTIVITY UTILITY PROGRAM ;9/14/00  15:49
V ;;5.1;IFCAP;**93,204**;Oct 20, 2000;Build 14
 ;Per VHA Directive 6402, this routine should not be modified.
 ;
ENF(PRCIPFLG) ;Entry point for Inv. Pt. selection
EN ;STA,FY,QTR,CP W/SCREEN FOR INACTIVE CP
 I '$G(PRCIPFLG) N:'$D(PRCIPFLG) PRCIPFLG S PRCIPFLG=0
 D STA G EX:'SI!(Y<0)
 D FY G EX:PRC("FY")="^"
 D QT G EX:PRC("QTR")="^"
 S DIC("S")="I '$P(^(0),""^"",19),$D(^PRC(420,""A"",DUZ,PRC(""SITE""),+Y,1))!($D(^(2)))"
 I $D(PRCSC),PRCSC D CPF^PRCSUT1(PRCIPFLG)
 I '$D(PRCSC) D CPF(PRCIPFLG)
 G EX:'SI!(Y<0)
 G:'$$BBFY(PRC("SITE"),PRC("FY"),PRC("CP")) EX
 G EN11
 ;
EN1F(PRCIPFLG) ; Entry point for Inv. Pt. selection
EN1 ;STA,FY,QTR,CP
 I '$G(PRCIPFLG) N:'$D(PRCIPFLG) PRCIPFLG S PRCIPFLG=0
 D STA G EX:'SI!(Y<0)
 D FY G EX:PRC("FY")="^"
 D QT G EX:PRC("QTR")="^"
 I $D(PRCSC),PRCSC D CPF^PRCSUT1(PRCIPFLG)
 I '$D(PRCSC) D CPF(PRCIPFLG)
 G EX:'SI!(Y<0)
 G:'$$BBFY(PRC("SITE"),PRC("FY"),PRC("CP")) EX
EN11 S Z=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(PRC("CP")," ")
 S X=$P(Z,"-",1,2)_"-"_$P(PRC("CP")," ")
 G EXIT
 ;
EN2 ;STA,FY,QTR
 D STA G EX:'SI!(Y<0)
 D FY G EX:PRC("FY")="^"
 D QT G EX:PRC("QTR")="^"
 G EXIT
 ;
EN3F(PRCIPFLG) ; Entry point for Inv. Pt. selection
EN3 ;STA,CP
 I '$G(PRCIPFLG) N:'$D(PRCIPFLG) PRCIPFLG S PRCIPFLG=0
 D STA G EX:'SI!(Y<0)
 I $D(PRCSC),PRCSC D CPF^PRCSUT1(PRCIPFLG)
 D:'$D(PRCSC) CPF(PRCIPFLG)
 G EX:'SI!(Y<0)
 G EXIT
 ;
EN4 ;STA,FY,QTR,CC
 D STA G EX:'SI!(Y<0)
 D FY G EX:PRC("FY")="^"
 D QT G EX:PRC("QTR")="^"
 D CC
 G EXIT
 ;
EN5 ;STA,FY,QTR,BOC
 D STA G EX:'SI!(Y<0)
 D FY G EX:PRC("FY")="^"
 D QT G EX:PRC("QTR")="^"
 D SUB
 G EXIT
 ;
EN6F(PRCIPFLG) ; Entry point for Inv. Pt. selection
EN6 ;STA,CP,FY
 I '$G(PRCIPFLG) N:'$D(PRCIPFLG) PRCIPFLG S PRCIPFLG=0
 D STA G EX:'SI!(Y<0)
 I $D(PRCSC),PRCSC D CPF^PRCSUT1(PRCIPFLG)
 I '$D(PRCSC) D CPF(PRCIPFLG)
 G EX:'SI!(Y<0)
 D FY G EX:PRC("FY")="^"
 G EXIT
 ;
 ;PRCSST is flag to not ask substation
 ;PRCSK is flag to allow selection of any station
STA ;SELECT STATION NUMBER
 S N="",Y=0
 I $D(PRCSK) S SI=2 ; if privilege flag is set, ask STATION
 ; else restrict station selection to user's authorized stations
 E  F SI=0:1:2 S N=$O(^PRC(420,"A",DUZ,N)) Q:N'>0  S N(1)=N
 Q:'SI  ; user not allowed to access any station
 I SI>1 D
 . S DIC="^PRC(420,",DIC(0)="AEMQ",DIC("A")="Select STATION NUMBER: "
 . I '$D(PRCSK) S DIC("S")="I $D(^PRC(420,""A"",DUZ,+Y))"
 . I $D(PRC("SITE")) S DIC("B")=PRC("SITE")
 . S D="B^C"
 . D MIX^DIC1 I Y>0 S PRC("SITE")=+Y
 I SI=1 S PRC("SITE")=N(1)
 I '$D(PRC("SITE")) S PRC("SITE")="",PRC("SST")=""
 I PRC("SITE")=""!(Y<0) K DIC,N Q
 ; substation
 I '$D(PRC("SST"))!'$D(^PRC(411,"UP",+PRC("SITE"))) S PRC("SST")=""
 I '$G(PRCSST),$D(^PRC(411,"UP",+PRC("SITE"))) D
 . S DIC("B")=PRC("SST")
 . S DIC="^PRC(411,",DIC(0)="AEQZ",DIC("A")="Select SUBSTATION: "
 . S DIC("S")="I $E($G(^PRC(411,+Y,0)),1,3)=PRC(""SITE"")"
 . D ^DIC I Y>0 S PRC("SST")=+Y
 K DIC,N
 Q
 ;
FY ;SELECT FISCAL YEAR
 D:'$D(DT) DT^DICRW
 S FYT=$E(100+$E(DT,2,3)+$E(DT,4),2,3),PRC("FY")=FYT
 W !,"Select FISCAL YEAR: ",FYT,"// " R PRC("FY"):DTIME
 S:'$T PRC("FY")=U
 S:PRC("FY")="" PRC("FY")=FYT
 Q:PRC("FY")="^"
 I PRC("FY")'?2N W $C(7),!,"Enter a two digit fiscal year (e.g., 87).",! G FY
 Q
 ;
QT ;SELECT QUARTER
 D:'$D(DT) DT^DICRW
 I '$D(QTT) S:$D(PRC("QTR")) QTT=PRC("QTR") I '$D(QTT) S SI=$E(DT,4,5),QTT=$P("2^2^2^3^3^3^4^4^4^1^1^1","^",SI)
 W !,"Select QUARTER: ",QTT,"// " R PRC("QTR"):DTIME
 S:'$T PRC("QTR")=U
 S:PRC("QTR")="" PRC("QTR")=QTT
 Q:PRC("QTR")=U
 I PRC("QTR")<1!(PRC("QTR")>4)!(PRC("QTR")'?1N) W $C(7),!,"Enter a single digit number from 1 to 4.",! G QT
 Q
 ;
CPF(PRCIPFLG) ; Entry point for inv. pt. selection
CP ;SELECT CONTROL POINT
 N FCPDA
 K PRCSIP ; inventory distribution point variable
 I '$G(PRCIPFLG) N:'$D(PRCIPFLG) PRCIPFLG S PRCIPFLG=0
 S FCPDA=$O(^PRC(420,"A",DUZ,PRC("SITE"),0)) Q:'FCPDA  ; no fcps
 I '$O(^PRC(420,"A",DUZ,PRC("SITE"),FCPDA)) D  Q  ; access to 1 fcp
 . S PRC("CP")=$P($G(^PRC(420,PRC("SITE"),1,FCPDA,0)),U)
 . I PRC("CP"),PRCIPFLG D IP
 ; more than one fcp
 S DIC="^PRC(420,"_PRC("SITE")_",1,"
 S DIC(0)="AEMNQZ",DIC("A")="Select CONTROL POINT: "
 I '$D(DIC("S")) S DIC("S")="I '$P(^(0),""^"",19),$D(^PRC(420,""A"",DUZ,PRC(""SITE""),+Y,1))!($D(^(2)))"
 I $D(PRC("CP")),PRC("CP"),$D(^PRC(420,PRC("SITE"),1,PRC("CP"))) S DIC("B")=+PRC("CP")
 S D="B^C" D MIX^DIC1 S:Y<0 PRC("CP")="^"
 I Y>0 S PRC("CP")=$P(Y(0),"^") I PRCIPFLG=1 D IP
 K DIC
 Q
 ;
 ;A=station #, B=fiscal year, C=fcp #, PRCA=1 if no user interactive
BBFY(A,B,C,PRCA) ;extrinsic function of beginning budget fiscal year
 N D,E,F,X,Y
 K PRC("BBFY")
 S E=$G(^PRC(420,A,1,+C,5))
 I $P(E,"^")]"" S F=$O(^PRCD(420.3,"B",$P(E,"^"),"")) I F I $P(^PRCD(420.3,F,0),"^",8)="Y" S PRC("BBFY")=+$$DATE^PRC0C($P(E,"^",8),"I") QUIT PRC("BBFY")
 S B=+$$YEAR^PRC0C(B)
 S D=$$APP^PRC0C(A,$E(B,3,4),C)
 I $P(D,"^")'["_/_" S PRC("BBFY")=B QUIT PRC("BBFY")
 S F=$$BBFY^PRC0D(A,C,'$G(PRCA))
 I F="",$G(PRCA)=1 S PRC("BBFY")=B QUIT PRC("BBFY")
 I $G(PRCA)=1 S PRC("BBFY")=B-(B-$P(F,"~",2)#$P(F,"~",3)) QUIT PRC("BBFY")
BBFY1 S E="^2:4^K:X'?2N&(X'?4N) X I $G(X)]"""" S X=+$$YEAR^PRC0C(X) K:X-$P(F,""~"",2)#$P(F,""~"",3) X"
 S Y(1)="Enter a 2 or 4 digit year."
 D FT^PRC0A(.X,.Y,"First Year of the Multi-Appropriation ("_$P(D,"^")_")",E,$S(F="":B,1:B-(B-$P(F,"~",2)#$P(F,"~",3))))
 I Y?2.4N S Y=+$$YEAR^PRC0C(Y) I B<Y!(Y+$P(F,"~",3)-1<B) D EN^DDIOL("You must enter a BBFY such that the document's fiscal year is between"),EN^DDIOL("beginning and ending budget fiscal years") G BBFY1
 S PRC("BBFY")=$S(Y?4N:Y,1:""),PRCBBMY=1
 QUIT PRC("BBFY")
 ;
CC ;SELECT COST CENTER
 S DIC="^PRCD(420.1,",DIC(0)="AEMNQZ"
 D ^DIC Q:Y<0
 S PRCS("CC")=$P(Y(0),"^")
 Q
 ;
SUB ;SELECT BOC
 S DIC="^PRCD(420.2,",DIC(0)="AEMNQZ"
 D ^DIC Q:Y<0
 S PRCS("SUB")=$P(Y(0),"^")
 Q
 ;
LOCK ;LOCK GLOBAL THAT IS BEING ACCESSED BY ANOTHER USER
 N PRCLOCK
 S PRCLOCK=DIC_DA_")" L +(@PRCLOCK):($G(DILOCKTM,15))
 S PRCSL=$T
 W:$T=0 !!,$C(7),"Sorry, record is being accessed by another user.  Please try later."
 Q
 ;
EX S Y=-1
 K PRC("QTR"),PRC("FY"),PRC("BBFY"),SI,PRCBBMY
 I $D(PRC("CP")) K:PRC("CP")="ALL"!(PRC("CP")="^") PRC("CP")
EXIT K FYT,SI,PRCSK,QTT,DIC("A")
 Q
 ;
NSCRNF(PRCIPFLG) ; Entry point for Inv. Pt. selection
NSCRN ;STA,FY,QTR,CP
 I '$G(PRCIPFLG) N:'$D(PRCIPFLG) PRCIPFLG S PRCIPFLG=0
 D STA G EX:'SI!(Y<0)
 D FY G EX:PRC("FY")="^"
 D QT G EX:PRC("QTR")="^"
 S PRCSC=4 D CPF^PRCSUT1(PRCIPFLG)
 I '$D(PRCSC) D CPF(PRCIPFLG)
 G EX:'SI!(Y<0)
 G:'$$BBFY(PRC("SITE"),PRC("FY"),PRC("CP")) EX
 QUIT
 ;
IP ; Get Inventory point
 Q:'$D(PRC("SITE"))!('$D(PRC("CP")))
 N CTR,I
 K ^TMP($J,"PRCSUT")
 S (CTR,I)=0,PRCSIP=""
 F  S I=$O(^PRC(420,"AF",PRC("SITE"),+PRC("CP"),I)) Q:'I  S CTR=CTR+1,^TMP($J,"PRCSUT",CTR)=I_"^"_$P(^PRCP(445,I,0),"^")
 I CTR=0 G IPQ
 I CTR=1!$G(PRCRMPR) S PRCSIP=$P(^TMP($J,"PRCSUT",1),"^") G IPQ
 F I=1:1:CTR D  Q:$D(DIRUT)
 .   W !,?5,I,") ",$P(^TMP($J,"PRCSUT",I),"^",2)
 .   I I#(IOSL-2)=0 K DIR S DIR(0)="E" D ^DIR
 S DIR(0)="NO^1:"_CTR_":0"
 S DIR("A")="Select INVENTORY POINT"
 S DIR("?",1)="Enter a number from 1 to "_CTR_" to select the displayed"
 S DIR("?")="Inventory Point. This is an optional response."
 D ^DIR K DIR
 I Y>0 S PRCSIP=$P(^TMP($J,"PRCSUT",Y),"^") W "  ",$P(^TMP($J,"PRCSUT",Y),"^",2),!
IPQ K ^TMP($J,"PRCSUT")
 Q
