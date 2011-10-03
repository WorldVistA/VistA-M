YSASNAR ;ALB/ASF SLC/DKG-ASI INTERVIEW REPORTER ;3/7/03  14:55
 ;;5.01;MENTAL HEALTH;**24,30,37,38,44,55,67,76**;Dec 30, 1994
 ;
 ;Reference to ^%ZISC supported by IA #10089
 ;Reference to ^%ZTLOAD supported by IA #10063
 ;Reference to HOME^%ZIS supported by IA #1008
 ;Reference to ^%ZIS supported by IA #10086
 ;Reference to $$GET1^DIQ() supported by IA #2056
 ;Reference to $$FMTE^XLFDT supported by IA #10103
 ;Reference to DEM^VADPT supported by IA #10061
 ;Reference to ^DIWP supported by IA #10011
 ;Reference to ^DIR supported by IA #10026
 ;Reference to ^DD("DD" supported by IA #10017
 ;Reference to ^VA(200 supported by IA #10060
 ;Reference to ^DPT( supported by IA #10035
 ;
EN1(YSASDA) ;Entry point to display ASI
 Q:$G(YSASDA)'>0
 N YSASN,YSASNA,YSZZ,YSHDR,YSASD,YSAST,YSAS0,DIERR,YSI,YSASC,YSASN2
 ;ASK DEVICE 
 N YSASQUIT,%ZIS,POP
 S %ZIS="QM"
 D ^%ZIS
 Q:$G(POP)
 I $D(IO("Q")) D  Q
 .N ZTRTN,ZTDESC,ZTSAVE
 .S ZTRTN="QTEP^YSASNAR"
 .S ZTDESC="YSASPRT ASI NARRATIVE PRINT"
 .S ZTSAVE("YSASDA")=""
 .D ^%ZTLOAD W:$D(ZTSK) !!,"Your Task Number is "_ZTSK
 .D HOME^%ZIS
 .Q
 U IO
QTEP ;Queued Task Entry Point
 S:$D(ZTQUEUED) ZTREQ="@"
 N G,G2,N,P1,P2,R,V,V1,Y1,YSA,YSAGE,YSAS0,YSASC,YSASD,YSASIG,YSASN,YSASNA,YSASQUIT,YSAST,YSASWP
 N YSASWP,YSBID,YSDOB,YSHDR,YSHIML,YSHIMU,YSI,YSJ,YSLAST,YSLCK,YSLFN,YSNM,YSPART,YSPOSL,YSPOSU
 N YSPROL,YSPROU,YSSC,YSSCK,YSSEX,YSSSN,YSSTEM,YSTITLE,YSX,YSYCK,YSYX,YSZ,YSZZ
 S YSZZ=0
 S YSAS0=^YSTX(604,YSASDA,0),DFN=$P(YSAS0,"^",2)
 D DEM^VADPT
 S YSASD=$$FMTE^XLFDT($P(YSAS0,U,5),"5ZD")
 S YSAST=$$GET1^DIQ(604,YSASDA_",",.04)
 S YSASC=$$GET1^DIQ(604,YSASDA_",",.09)
 S YSASIG=$$GET1^DIQ(604,YSASDA_",",.51,"I")
 S YSNM=VADM(1),YSSEX=$P(VADM(5),U),YSDOB=$P(VADM(3),U,2),YSAGE=VADM(4),YSSSN=VA("PID"),YSBID=VA("BID")
 S YSHDR=VADM(1)_"  "_$P(VADM(2),U,2)_$J("",(20-$L(VADM(1))))_" ASI "_YSAST_"  on "_YSASD_" by: "_YSASC
 ;
MAIN ;
 K ^UTILITY($J,"YSTMP"),^UTILITY($J,"W")
 S YSLFN=1,^UTILITY($J,"YSTMP",0,1,0)=""
 D VARPRO
 D R1
 D SIG
 D PRT
 D ^%ZISC
 Q
R1 ;
 S X=$S(YSAST?1"ASI-MV".E:"ASI-MV NARRATIVE",YSAST?1"FO".E:"FOLLOWUP NARRATIVE",1:"GENERAL"),YSPART=$O(^YSTX(604.68,"B",X,0))
 F YSJ=1:1 Q:'$D(^YSTX(604.68,YSPART,1,YSJ,0))  S YSA=^(0) D R2
 Q
R2 ;
 I YSA?1"~".E Q
 I YSA?1"W{".E1"}" K YSWP S YSWP=$$GET1^DIQ(604,YSASDA_",",$E(YSA,3,$L(YSA)-1),"Z","YSWP") D:YSWP'=""  K YSWP Q
 . S YSN2="" F  S YSN2=$O(YSWP(YSN2)) Q:YSN2'>0  S YSLFN=YSLFN+1,^UTILITY($J,"YSTMP",0,YSLFN,0)=YSWP(YSN2,0)
 ;
 I YSA'["{" S X=YSA D:$L(X) L Q  ;DIWL=0,DIWR=IOM,X=YSA D ^DIWP Q
PRO ;evaluate pronoun, possessive etc
 F YSZ=1:1:999 Q:YSA'["{"  D
 . S P1=$F(YSA,"{")-1,P2=$F(YSA,"}")
 . Q:'P1!'P2
 . S G=$E(YSA,P1+1,P2-2),V=0
 . I $P(G,";")?."."1N.NP D  D CONDIT,ULP
 .. S G2=$$GET1^DIQ(604,YSASDA_",",$P(G,";"),"","YSASWP")
 .. S V=$S(G2?1N.N:+G2,1:G2) ;5/30 ASF
 . S:G="Pro" V=$S(YSSEX="F":"She",1:"He")
 . S:G="pro" V=$S(YSSEX="F":"she",1:"he")
 . S:G="Pos" V=$S(YSSEX="F":"Her",1:"His")
 . S:G="pos" V=$S(YSSEX="F":"her",1:"his")
 . S:G="him" V=$S(YSSEX="F":"her",1:"him")
 . S:G="himself" V=$S(YSSEX="F":"herself",1:"himself")
 . S:G="Title" V=$S(YSSEX="F":"Ms.",1:"Mr.")
 . I G="Blank" S:$L($G(^UTILITY($J,"YSTMP",0,YSLFN,0))) YSLFN=YSLFN+1 S ^UTILITY($J,"YSTMP",0,YSLFN,0)=$G(^UTILITY($J,"YSTMP",0,YSLFN,0))_"|BLANK(1)||NOBLANKLINE|",YSLFN=YSLFN+1,V=""
 . S:G="Line" YSLFN=YSLFN+1,^UTILITY($J,"YSTMP",0,YSLFN,0)="",V=""
 . I G="Last" S X=$P($P(^DPT(DFN,0),U),",") D
 .. F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)
 .. S V=X
 . I $P(G,";")="Field" S @($P(G,";",2))=$$GET1^DIQ(604,YSASDA_",",$P(G,";",3)),V="" I $P(G,";",4)'="" S YSSC=";",YSX="S @($P(G,YSSC,2))=$S("_$P(G,";",4)_")" X YSX
 . I $P(G,";")="List" K V D  K V S V=""
 .. S V1=$P(G,";",2),I1=0 F I=1:1 Q:$P(V1,",",I)=""  S:@($P(V1,",",I))'="" I1=I1+1,V(I1)=@($P(V1,",",I))
 .. I '$D(V(1)) S X=$P(G,";",3) D L Q
 .. F I1=1:1 Q:'$D(V(I1))  S X=$S(I1=1:" ",'$D(V(I1+1)):" and ",1:", ")_V(I1) D L
R . S X=$E(YSA,1,P1-1) D:$L(X) L
 . I $D(YSASWP) S V="" D  K YSASWP
 .. F I3=1:1 Q:'$D(YSASWP(I3))  S X=YSASWP(I3)_" " D:$L(X) L
 . S X=V D:$L(X) L
 . S YSA=$E(YSA,P2,999)
 . I YSA'["{" S X=YSA D:$L(X) L
 ;
 Q
SIG ; signature
 S YSLFN=YSLFN+1,^UTILITY($J,"YSTMP",0,YSLFN,0)=""
 S YSLFN=YSLFN+1,^UTILITY($J,"YSTMP",0,YSLFN,0)="esig: "
 S Y=$P($G(^YSTX(604,YSASDA,.5)),U,2) S:Y?1N.N Y=$G(^VA(200,Y,20)),Y=$P(Y,U,2)_" "_$P(Y,U,3)
 S ^UTILITY($J,"YSTMP",0,YSLFN,0)=^UTILITY($J,"YSTMP",0,YSLFN,0)_Y
 S Y=$G(^YSTX(604,YSASDA,12)) I Y'="" X ^DD("DD") S YSLFN=YSLFN+1,^UTILITY($J,"YSTMP",0,YSLFN,0)="signed: "_Y
 Q
END ;
 K I,YSLCK,R,YSSTEM,YSYX,YSYCK,YSSCK Q
L ;
 S ^UTILITY($J,"YSTMP",0,YSLFN,0)=$G(^UTILITY($J,"YSTMP",0,YSLFN,0))_X
 I $L(^UTILITY($J,"YSTMP",0,YSLFN,0))>80 D
 . S Y=^UTILITY($J,"YSTMP",0,YSLFN,0)
 . F I=$L(Y):-1:1 S Y1=$E(Y,I) I Y1=" "&(I<81) S ^UTILITY($J,"YSTMP",0,YSLFN,0)=$E(Y,1,I-1),YSLFN=YSLFN+1,^UTILITY($J,"YSTMP",0,YSLFN,0)=$E(Y,I+1,999) Q 
 Q
PRT ; Print output
 W @IOF,YSHDR,! W:'YSASIG ?25,"##### Unsigned Draft #####",!
 S N=0 F  S N=$O(^UTILITY($J,"YSTMP",0,N)) Q:N'>0!YSZZ  D
 . S X=^UTILITY($J,"YSTMP",0,N,0),DIWL=1,DIWF="WN" D ^DIWP
 . I IOT'="HFS" D:$Y+4>IOSL WAIT ;ASF 3/7/03
 ;
 Q
WAIT ;
 F I0=1:1:IOSL-$Y-2 W !
 N DTOUT,DUOUT,DIRUT
 I IOST?1"C".E W $C(7) K DIR S DIR(0)="E" D ^DIR K DIR S YSZZ=$D(DIRUT)
 Q:YSZZ
 W @IOF,YSHDR,! W:'YSASIG ?25,"##### Unsigned Draft #####",!
 Q
TEST S G="X;;L",V="TEST"
ULP ;
 Q:$P(G,";",3)=""
 Q:$P(G,";",3)="P"&($P(G,";")=".09:20.3")  ;MJD 01/06/2000
 I $P(G,";",3)="P" F %=2:1:$L(V) I $E(V,%)?1U,$E(V,%-1)?1A S V=$E(V,0,%-1)_$C($A(V,%)+32)_$E(V,%+1,999)
 I $P(G,";",3)="L" F %=1:1:$L(V) I $E(V,%)?1U S V=$E(V,0,%-1)_$C($A(V,%)+32)_$E(V,%+1,999)
 I $P(G,";",3)="U" F %=1:1:$L(V) S:$E(V,%)?1L V=$E(V,0,%-1)_$C($A(V,%)-32)_$E(V,%+1,999)
 Q
CONDIT ;conditional
 Q:$P(G,";",2)=""
 S YSX="S V=$S("_$P(G,";",2)_")"
 ;S X=YSX D ^DIM
 ;I '$D(X) S V="###ERROR Line "_YSJ_" ###" Q
 X YSX
 Q
VARPRO ; PATIENT VARIABLES
 S YSPROU=$S(YSSEX="F":"She",1:"He")
 S YSPROL=$S(YSSEX="F":"she",1:"he")
 S YSPOSU=$S(YSSEX="F":"Her",1:"His")
 S YSPOSL=$S(YSSEX="F":"her",1:"his")
 S YSHIML=$S(YSSEX="F":"her",1:"him")
 S YSHIMU=$S(YSSEX="F":"Her",1:"Him")
 S YSTITLE=$S(YSSEX="F":"Ms.",1:"Mr.")
 S X=$P($P(^DPT(DFN,0),U),",") D  S YSLAST=X
 . F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)
 Q
