LR7OC0 ;slc/dcm - Convert orders from old to new format ;8/11/97
 ;;5.2;LAB SERVICE;**121,187**;Sep 27, 1994
 ;
EN ;For a good time, enter here. Lab order conversion with KIDS.
 I $$VER^LR7OU1<3 Q  ;OE/RR 2.5 Check
 S ZTDTH=$H,ZTIO="",ZTRTN="EN1^LR7OC0" D ^%ZTLOAD
 Q
EN1 ;Convert orders without KIDS
 I $$VER^LR7OU1<3 Q  ;OE/RR 2.5 Check
 Q:$G(^ORD(100.99,1,"CONV"))
 N LRORD,LRODT,LRSN,TST,LR1,X,SUBHEAD
 S LRORD=$S($G(^LRO(69,"LRORD CONV",0)):+^(0),1:0) D:'LRORD CK
 F  S LRORD=$O(^LRO(69,"C",LRORD)) Q:LRORD<1  L +^LRCNVRT(LRORD):9999 D  L -^LRCNVRT(LRORD)
 . S LRODT=0 F  S LRODT=$O(^LRO(69,"C",LRORD,LRODT)) Q:LRODT<1  S LRSN=0 F  S LRSN=$O(^LRO(69,"C",LRORD,LRODT,LRSN)) Q:LRSN<1  I $D(^LRO(69,LRODT,1,LRSN,0)),'$P(^(0),"^",11) D
 .. D NEW1^LR7OB0(LRODT,LRSN,"ZC")
 .. S $P(^LRO(69,LRODT,1,LRSN,0),"^",11)=1.69
 . S ^LRO(69,"LRORD CONV",0)=LRORD
 D NOW^%DTC S Y=% X ^DD("DD")
 K ^LRO(69,"LRORD CONV",0)
 S X(1)="Conversion of lab orders for patch LR*5.2*121 completed: "_Y
 S X(2)="Task #"_$G(ZTSK)
 D BULL(.X,"Lab Conversion")
 I $D(ZTSK) D KILL^%ZTLOAD K ZTSK
 Q
CHK ;Check that all lab orders were converted.
 N LRORD,LRODT,LRSN,TST,LINK,X0
 S LRORD=0
 F  S LRORD=$O(^LRO(69,"C",LRORD)) Q:LRORD<1  D
 . S LRODT=0 F  S LRODT=$O(^LRO(69,"C",LRORD,LRODT)) Q:LRODT<1  S LRSN=0 F  S LRSN=$O(^LRO(69,"C",LRORD,LRODT,LRSN)) Q:LRSN<1  I $D(^LRO(69,LRODT,1,LRSN,0)) S X0=^(0) I $D(^LR(+X0,0)),$P(^(0),"^",2)=2 D
 .. S TST=0 F  S TST=$O(^LRO(69,LRODT,1,LRSN,2,TST)) Q:TST<1  S T0=^(TST,0) I $P(T0,"^",7),'$P(T0,"^",11),'$P(T0,"^",14) D
 ... ;I '$P(X0,"^",6),$P(T0,"^",7),$D(^OR(100,$P(T0,"^",7),0)),$P(^(0),"^",4) S X=$P(^(0),"^",4),$P(^LRO(69,LRODT,1,LRSN,0),"^",6)=X,$P(X0,"^",6)=X
 ... I $P(T0,"^",7),$D(^OR(100,$P(T0,"^",7),0)),$G(^(4))["^" D
 .... S X=$P($G(^OR(100,$P(T0,"^",7),3)),"^",3) I X=""!(X=1)!(X=2)!(X=14) Q
 .... W !,"NOT CNVRTD-ODT:"_LRODT_" SN:"_LRSN_" ORIFN:"_$P(T0,"^",7)_$S('$P(X0,"^",6):" No Provider",1:"") S ORX4=^(4),ORIFN=$P(T0,"^",7)
 Q
CK1 ;Check please (more validity checking).  Find bad/missing ptrs to OE/RR 3.0
 N LRORD,LRODT,LRSN,TST,ORIFN
 S LRORD=0
 F  S LRORD=$O(^LRO(69,"C",LRORD)) Q:LRORD<1  D
 . S LRODT=0 F  S LRODT=$O(^LRO(69,"C",LRORD,LRODT)) Q:LRODT<1  S LRSN=0 F  S LRSN=$O(^LRO(69,"C",LRORD,LRODT,LRSN)) Q:LRSN<1  I $D(^LRO(69,LRODT,1,LRSN,0)) S X=^(0),ORIFN=$P(X,"^",11) I $D(^LR(+X,0)),$P(^(0),"^",2)=2 D
 .. I '$L(ORIFN),$O(^LRO(69,LRODT,1,LRSN,2,0)) W !,"Missing ptr at LRSN level to 100:LRODT:"_LRODT_" LRSN:"_LRSN Q
 .. I ORIFN,ORIFN'=1.69 D
 ... I '$D(^OR(100,ORIFN,0)) W !,"Bad ptr to 100:"_X_" LRODT:"_LRODT_" LRSN:"_LRSN
 ... S TST=0 F  S TST=$O(^LRO(69,LRODT,1,LRSN,2,TST)) Q:TST<1  S X=^(TST,0) I '$P(X,"^",6),'$P(X,"^",7) W !,"Missing ORIFN at test level:LRODT:"_LRODT_" LRSN:"_LRSN_" IFN:"_TST_">>"_X
 Q
CK ;Rebuild C & D -xref in 69
 N ODT,SN,X
 S ODT=0
 F  S ODT=$O(^LRO(69,ODT)) Q:ODT<1  S SN=0 F  S SN=$O(^LRO(69,ODT,1,SN)) Q:SN<1  I $D(^(SN,0)) S X=^(0) D
 . I +X,'$D(^LRO(69,"D",+X,ODT,SN)) S ^LRO(69,"D",+X,ODT,SN)=""
 . I '$D(^LRO(69,ODT,1,SN,.1)) Q
 . S X=+^LRO(69,ODT,1,SN,.1) I 'X Q
 . I '$D(^LRO(69,"C",X,ODT,SN)) S ^LRO(69,"C",X,ODT,SN)=""
 Q
COUNT ;Count orders in file 69
 N ORD,ODT,SN,X,CT1,CT2,CT3,CT4,X3
 S (CT1,CT2,CT3,CT4,ORD)=0
 F  S ORD=$O(^LRO(69,"C",ORD)) Q:ORD<1  S ODT=0 F  S ODT=$O(^LRO(69,"C",ORD,ODT)) Q:ODT<1  S SN=0 F  S SN=$O(^LRO(69,"C",ORD,ODT,SN)) Q:SN<1  D
 . S CT1=CT1+1
 . I $D(^LRO(69,ODT,1,SN)) S CT2=CT2+1 D
 .. S TST=0 F  S TST=$O(^LRO(69,ODT,1,SN,2,TST)) Q:TST<1  I $D(^(TST,0)) S CT3=CT3+1 I $P(^(0),"^",7),$D(^OR(100,+$P(^(0),"^",7),3)) S X3=$P(^(3),"^",3) I X3'=1,X3'=2,X3'=14 S CT4=CT4+1
 W !!,"Valid Specimen Nodes: "_CT2
 W !,"Total Specimen Count: "_CT1
 W !,"Total Tests: "_CT3
 W !,"Tests to Convert: "_CT4
 Q
BULL(X,XMSUB) ;Send bulletin
 ;X()=Array of text to be in bulletin
 ;XMSUB=Subject of bulletin
 S XMY(DUZ)="",XMDUZ=.5,XMTEXT="X("
 D ^XMD
 Q
TEST(ODT,SN) ;Test HL7 message build without calling
 Q:'$L($T(MSG^XQOR))
 N MSG,CHMSG,BBMSG,APMSG,LRORD,LRODT,LRSN,LRNIFN,LRTMPO,X,CONTROL
 K ^TMP("LRAP",$J),^TMP("LRCH",$J),^TMP("LRBB",$J)
 S CONTROL="TEST"
 D ORD1^LR7OB1(ODT,SN)
 I '$D(LRTMPO("LRIFN")) W !!,"NO LRTMPO(""LRIFN"",LRNIFN) BUILT." D EN1^LR7OB0(ODT,SN,CONTROL) Q
 S LRNIFN=0 F  S LRNIFN=$O(LRTMPO("LRIFN",LRNIFN)) Q:LRNIFN<1  S X=LRTMPO("LRIFN",LRNIFN) D
 . I CONTROL="ZC",$P(X,"^",7) S X=$P($G(^OR(100,+$P(X,"^",7),3)),"^",3) I X=1!(X=2)!(X=14) Q
 . D EN1^LR7OB0(ODT,SN,CONTROL)
 D DISP
 Q
DISP ;Display HL7 message
 F I="LRAP","LRBB","LRCH" I $D(^TMP(I,$J)) S J=0 F  S J=$O(^TMP(I,$J,J)) Q:J<1  W !,^(J)
 Q
