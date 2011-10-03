ORUHDR ; slc/dcm - Order entry display headers ;3/25/92  15:05 ;
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
OE ;Main Order Entry Header, expects ORUIEN (variable pointer)
 ;From: OR USER MENU
 K ORDG S ORTIT="ORDER ENTRY",ORSTIT=""
 S ORSTIT=$P(@("^"_$P(ORUIEN,";",2)_+ORUIEN_",0)"),"^",2),ORSTIT=$P(ORSTIT,"...")
 D TIT,STIT3 W:'$G(ORANSI) ! D:$G(ORANSI) STIT2
 K ORDG,ORPD,ORTIT,ORSTIT Q
OE2 ;Accept Orders Screen Header  From: ORREV31
 K ORDG S ORTIT="ORDER ENTRY"
 D TIT I $D(ORSTIT),$L(ORSTIT) D STIT3 D:$G(ORANSI) STIT2
 Q
EXT ;Detailed Display Header  From: ORSED
 Q:'$D(^OR(100,+$G(ORIFN),0))
 N ORL,OROLD
 S:'$D(ORTIT) ORTIT="DETAILED DISPLAY" S X=^OR(100,ORIFN,0),ORDG=$P(X,"^",11),ORDG=$P(^ORD(100.98,ORDG,0),"^",3),ORVP=$P(X,"^",2),Y=+ORVP D END^ORUDPA Q:'$D(ORPNM)
 S:'$D(ORANSI) ORANSI=0 S:'$D(ORFT) ORFT=0 S:'$D(ORIO) ORIO="HOME"
 I '$D(IOF) S IOP=ORIO D ^%ZIS Q:POP  S X=0 X ^%ZOSF("RM") S (ORFT,ORANSI)=0
 D TIT K ORDG,ORTIT Q
TIT ;General Header  From: OROPRO
 N ORCWAD S ORCWAD=""
 I '$D(ORDG),$D(^OR(100,+$G(ORIFN),0)) D
 . S ORDG=$P($G(^ORD(100.98,+$P($G(^OR(100,+$G(ORIFN),0)),U,11),0)),U,3)
 I $L($T(CWAD^GMRPNOR1)),$D(ORVP) S ORCWAD=$$CWAD^GMRPNOR1(+ORVP) K GMRPCWAD
 I $G(ORANSI) D:ORFT=0 ANSIH^ORPRS09 Q:ORFT=0  S ORFT=0 D ANSIR
 ;W !! F I=1:1:79 W "-"
 S:'$D(XQORSPEW) XQORSPEW=0 W @IOF I $L($G(ORDG)),(ORTIT'[$G(ORDG)) S ORTIT=$G(ORDG)_" "_ORTIT
 S X="" F I=1:1:$L(ORTIT) S X=X_" "_$E(ORTIT,I)
 W $C(13),$$HON^ORU,$S($L(ORCWAD):"<"_ORCWAD_">",1:""),$$HOFF^ORU,?(80-($L(ORTIT)*2))/2,X,?(IOM-12),$$HON^ORU,$S(XQORSPEW:"Quick mode",1:""),$$HOFF^ORU
 I $D(ORPNM),$D(ORSSN),$D(ORL),$D(ORDOB) D HDG
 W ! F I=1:1:79 W "-"
 I $G(ORANSI) K ORANSI("ST") S ORANSI("T")=$Y+2,ORANSI("B")=24,ORANSI("SL")=ORANSI("B")-ORANSI("T") D ANSIS,ANSIT
 Q
STIT ;Print Sub-header
 S ORSTIT=$P(@("^"_$P(ORUIEN,";",2)_+ORUIEN_",0)"),"^",2) W !
STIT1 W $C(13),?(40-($L(ORSTIT)\2)-4),"--- "_ORSTIT_" ---"
 K ORSTIT Q
STIT2 I '$D(ORANSI("ST")) S ORANSI("T")=ORANSI("T")+1,ORANSI("SL")=ORANSI("SL")-1
 D ANSIS,ANSIT
 Q
STIT3 I $G(ORANSI),'$D(ORANSI("ST")) S ORANSI("ST")=ORANSI("T"),ORANSI("T")=ORANSI("T")+1,ORANSI("SL")=ORANSI("SL")-1
 I $G(ORANSI) S DX=1,DY=ORANSI("ST") W @ORANSI("XY"),@ORANSI("EOLN")
 W:'$G(ORANSI) ! D STIT1
 Q
HDG ;PRINT HEADING
 ;I $D(VAIN("5")) S Y=+ORVP D END^ORUDPA
 S X=" "_ORDOB_" ("_ORAGE_")   "_"Wt (lb): "_$S($D(ORPD):ORPD,1:"  ")
 S X1=$S($G(ORL):$S($L($P(^SC(+ORL,0),"^",2)):$P(^(0),"^",2),1:$E($P(^(0),"^"),1,4)),1:"")_$S($L($G(ORL(1))):"/"_ORL(1),1:"")
 W !,ORPNM_"   "_ORSSN_" ",?(39-($L(X1)\2))," "_X1_" ",?(79-$L(X)),X
 Q
PGBRK ;Call for page break
 N I,X I $D(IOST),$E(IOST)["C" F I=$Y:1:IOSL-4 W !
PGBRK1 S OREND=0,X="" I $S($D(IOST):$E(IOST)["C",1:1) R !!,"Press return to continue or ""^"" to escape ",X:$S($D(DTIME):DTIME,1:300)
 I X["^" S:X="^^" DIROUT=1 S OREND=1
 Q
ANSIR ;Reset scroll region to full screen
 W $C(27),$C(91),"1",$C(59),"24",$C(114),$C(13),#,$C(27),$C(91),$C(50),$C(74),$C(27),$C(91),$C(72)
 Q
ANSIS ;Set scroll region
 W $C(27),$C(91),ORANSI("T"),$C(59),ORANSI("B"),$C(114),$C(13)
 S (DX,DY)=0 X ^%ZOSF("XY")
 Q
ANSIT ;Move cursor to top of scroll region
 S DX=1,DY=ORANSI("T") W @ORANSI("XY"),$C(13)
 Q
