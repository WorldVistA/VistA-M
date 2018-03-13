PSIVSP ;BIR/RGY,PR,CML3 - DOSE PROCESSOR ;1/3/12 3:36pm
 ;;5.0;INPATIENT MEDICATIONS;**30,37,41,50,56,74,83,111,133,138,134,213,229,279,305,331,256,347**;16 DEC 97;Build 6
 ;
 ; Reference to ^PS(51.1 is supported by DBIA #2177
 ;
EN ;
 NEW PSJORGX
 Q:'$D(X)
 S ATZERO=0 I X["@",$P(X,"@",2)=0 S ATZERO=1,X=$P(X,"@")
 ;D EN^PSGS0 S (P(9),PSIVSC1)=$S($G(X)]"":X,1:$G(P(9))),P(11)=$S($G(PSGS0Y):PSGS0Y,1:$G(P(11))),(XT,P(15))=$S(($G(PSGS0XT)!($G(PSGS0XT)="O")!($G(PSGS0XT)="D")):$G(PSGS0XT),1:$G(P(15)))
 ;PSJ*5*256 - not set P(9) when FN order so the Old schedule name is not auto replaced with .01 value
 S PSJORGX=X
 D EN^PSGS0 S:$S((($G(PSJOCFG)="FN IV")&(($G(P(9))="")&($G(X)]""))):1,(($G(X)]"")&($G(X)'=PSJORGX)):1,$G(PSJOCFG)="":0,1:1) P(9)=$S($G(X)]"":X,1:$G(P(9)))
 S P(11)=$S($G(PSGS0Y):PSGS0Y,1:$G(P(11))),(XT,P(15))=$S(($G(PSGS0XT)!($G(PSGS0XT)="O")!($G(PSGS0XT)="D")):$G(PSGS0XT),1:$G(P(15)))
 I $G(ATZERO) S P(7)=1
 K ATZERO Q
EN1 ;
 S (PSIVAT,PSIVWAT,Y)="",XT=-1,X0=X,X=$S(X="ON CALL":X,X="ONCALL":X,X="ON-CALL":X,X="ONETIME":X,X="ONE-TIME":X,X="ONE TIME":X,X="1TIME":X,X="1 TIME":X,X="1-TIME":X,$L(X," ")<3:$P(X," "),1:$P(X," ",1,2))
 S:$E(X)="^" X=$E(X,2,999) G:X="" Q S:(X["@0")&($$SCHREQ^PSJLIVFD(.P)) ATZERO=1 S X=$S(X["@0":$P(X,"@"),1:X),P(7)=$S($G(ATZERO):1,1:"") K ATZERO
 I $S($D(^PS(51.1,"AC","PSJ",X)):1,1:$E($O(^(X)),1,$L(X))=X) D DIC I Y'<0 G SH
NS0 S Y=""
 I $E(X,1,2)="AD" S XT=-1 Q
 I $E(X,1,3)="BID"!($E(X,1,3)="TID")!($E(X,1,3)="QID") S XT=1440\$F("BTQ",$E(X))
 E  S:$E(X)="Q" X=$E(X,2,99) S:'X X=$E(X)["O"+1_X S I=+X,X=$P(X,I,2),XT=I*$S(X["'":1,(X["D"&(X'["AD"))!(X["AM")!(X["PM")!(X["HS"&(X'["THS")):1440,X["H"&(X'["TH"):60,X["AC"!(X["PC"):480,X["W":10080,X["M":40320,1:0),X=X0 D 
 . I 'XT,X'="NOW",X'="STAT",X'="ONCE",X'="ONE-TIME",X'="ONE TIME",X'="ONETIME",X'="1-TIME",X'="1 TIME",X'="1TIME",Y="" S XT=-1
SH ;
 I +Y<1,$E(X0)'="^" W:$G(ON)'["P" "  ",$S(XT=0&($S("^NOW^STAT^ONCE^ONE-TIME^ONETIME^1TIME^1-TIME^"[(U_$P(X," ")_U):1,X["1 TIME":1,1:X["ONE TIME")):"(ONCE ONLY)",XT>0:"Nonstandard schedule",XT<0:"",1:"(??)") W:XT>0 " (",XT," MINUTES)"
Q Q:X="ONE TIME"
 N I S X0=$P(X," ")_$S($L(X0," ")-1:" ",1:"")_$P(X0," ",2,99) K:XT<0!($L(X0)>22) X S:$D(X) X=X0 K X0 S:$G(P(7)) XT="" Q
NEWQ ;N I S X0=$P(X," ")_$S($L(X0," ")-1:" ",1:"")_$P(X0," ",2,99) K:XT<0!($L(X0)>22) X S:$D(X) X=X0 S:P(7) X=X0 K X0 K:XT>0&('P(7)) X Q
 Q
 ;
 ;*229 Add Temp val for dose limit in IOE
ENDL N PSIVLIMT W "   Dose limit ....  " S PSIVLIMT="a"_X,PSIVMIN=P(15)*X,PSIVSD=+P(2)
 I PSIVMIN<0 W !!," --- There is something wrong with this order !!",!,"     Call inpatient supervisor ....." S Y=-1 K PSIVMIN Q
 I P(15)'["D",P(4)="P"!(P(5))!(P(23)="P"),PSIVMIN=0,"^NOW^STAT^ONCE^ONE-TIME^ONE TIME^ON CALL^ONETIME^1TIME^1 TIME^1-TIME^"'[(U_P(9)_U) D DLP G QDL
 ;*229 DOW Calc and dose lim should match CPRS, if it's vol limit, we leave old functionality
 I $G(P(9))]"",$G(P(11))]"" D ENSTOP^PSIVCAL S Y=X I 1 ;*229 ENSTOP^PSIVCAL returns X, we wanted Y.
 E  D ENT^PSIVWL
QDL I $D(X) S X=Y X ^DD("DD") W $P(Y,"@")," ",$P(Y,"@",2) S Y=X
 Q
DLP ;
 S X=X+1,$P(PSIVSD,".",2)=$P(PSIVSD,".",2)_$E("0000",1,4-$L($P(PSIVSD,".",2))) D CHK S X2=0,Y=1 I X<2 S Y=+PSIVSD G QDLP
 I $P(PSIVSD,".",2)>$P(P(11),"-",$L(P(11),"-")) S X2=1 G OV
 G:$P(P(11),"-")>$P(PSIVSD,".",2) OV
 F Y=1:1 S X1=$P(P(11),"-",Y) I X1=$P(PSIVSD,".",2)!($P(PSIVSD,".",2)<X1) Q
OV I P(11)="" W $C(7)," ???",!?15,"*** You have not defined any administration times !!" K X Q
 F Y=Y:1 S:$P(P(11),"-",Y)="" X2=X2+1,Y=0,X=X+1 S X=X-1 Q:X<1
 S X=PSIVSD\1 I X2>0 S X1=PSIVSD D C^%DTC S X=$P(X,".") ; install with version 17.3 of fileman
 S Y=+(X_"."_$P(P(11),"-",Y))
QDLP K X1,X2 Q
 ;
ENI ;
 N PSIZEROX S PSIZEROX=0_+X
 K:$L(X)<1!($L(X)>30)!(X["""")!($A(X)=45) X I '$D(X)!'$D(P(4)) Q
 ;*229 Reset ATZERO flag.
 I $P(X,"@",2)'=0!'$$SCHREQ^PSJLIVFD(.P) S P(7)=""
 I P(4)="P"!(P(5))!(P(23)="P") Q:'X  S X="INFUSE OVER "_X_" MINUTE"_$S(X>1:"S",1:"") W "   ",X Q
 I $E(X)="." K X Q  ;Enforce leading zero.
 I X'=+X!(X'=0_+X),X["@",($P(X,"@",2,999)'=+$P(X,"@",2,999)!(+$P(X,"@",2,999)<0)) K X Q
 S SPSOL=$O(DRG("SOL",0)) I 'SPSOL K SPSOL,X W "  You must define at least one solution !!" Q
 I (X=+X)!(X=PSIZEROX) I X'["@" S X=X_" ml/hr" W " ml/hr" D SPSOL S P(15)=$S('X:0,1:SPSOL\X*60+(SPSOL#X/X*60+.5)\1) K SPSOL Q
 S SPSOL=$S(($P(X,"@",2)?1.N):$P(X,"@",2),1:$G(P("NUMLBL"))) I SPSOL S P("NUMLBL")=+SPSOL
 S:$P(X,"@")=+X!($P(X,"@")=PSIZEROX) $P(X,"@")=$P(X,"@")_" ml/hr" W "   ",+SPSOL," Label",$S(SPSOL'=1:"s",1:"")," per day",!?15,"at an infusion rate of: ",$P(X,"@") S P(15)=$S('SPSOL:0,1:1440/SPSOL\1) K SPSOL
 I X["@",$P(X,"@",2)=0,$$SCHREQ^PSJLIVFD(.P) S P(7)=1  ; Set ATZERO flag
 ;*305
 I '$G(PSJEXMSG) D EXPINF^PSIVEDT1(.X)
 Q
SPSOL S SPSOL=0 F XXX=0:0 S XXX=$O(DRG("SOL",XXX)) Q:'XXX  S SPSOL=SPSOL+$P(DRG("SOL",XXX),U,3)
 K XXX Q
CHK F Y=1:1 Q:$L(P(11))>240!($P(P(11),"-",Y)="")  S $P(P(11),"-",Y)=$P(P(11),"-",Y)_$E("0000",1,4-$L($P(P(11),"-",Y)))
 Q
 ;
DIC ; 51.1 look-up
 N PSJSCH S PSJSCH=X I '$D(WSCHADM) N VAIP D IN5^VADPT S WSCHADM=VAIP(5),X=PSJSCH
 K DIC S DIC="^PS(51.1,",DIC(0)=$E("E",'$D(NOECH))_"ISZ"
 ; The naked reference below refers to the full reference inside indirection to ^PS(51.1
 S DIC("W")="W ""  "","_$S('$D(WSCHADM):"$P(^(0),""^"",2)",'+WSCHADM:"$P(^(0),""^"",2)",1:"$S($D(^PS(51.1,+Y,1,+WSCHADM,0)):$P(^(0),""^"",2),1:$P(^PS(51.1,+Y,0),""^"",2))"),D="APPSJ" S:$D(PSIVSPQF) DIC(0)=DIC(0)_"O"
 D IX^DIC K DIC
 S:$D(DIE)#2 DIC=DIE Q:Y<0
 S X=Y(0,0),ZZY=Y,(XT,Y)="" I $D(WSCHADM),$D(^PS(51.1,+ZZY,1,+WSCHADM,0)),$P(^(0),"^",2)]"" S (PSIVWAT,Y)=$P(^(0),"^",2)
 K ZZY,WSCHADM S:Y="" (X,PSIVSC1)=$P(Y(0),U),(PSIVAT,Y)=$P(Y(0),"^",2) S XT=$P(Y(0),"^",3) Q
 ;
ORINF ;  OERR input transform for Infusion Rate
 ;  X=data
 N INFUSE
 K:$L(X)<1!($L(X)>30)!(X["""")!($A(X)=45) X I '$D(X) Q
 I X?.E1L.E S INFUSE=$$ENLU^PSGMI(X) Q:(INFUSE="TITRATE")!(INFUSE="BOLUS")!($P(INFUSE," ")="INFUSE")!($P(INFUSE," ")="Infuse")
 Q:(X="TITRATE")!(X="BOLUS")!($P(X," ")="INFUSE")!($P(X," ")="Infuse")
 I X["=" D  Q   ; NOIS LOU-0501-42191
 .N X2,X1 S X1=$P(X,"="),X2=$P(X,"=",2)
 .I X1["ML/HR",(+X1=$P(X1,"ML/HR"))!(+X1=$P(X1," ML/HR")) D
 ..S X1=$TR(X1,"ML/HR","ml/hr")
 .I X2["ML/HR",(+X2=$P(X2,"ML/HR"))!(+X2=$P(X2," ML/HR")) D
 ..S X2=$TR(X2,"ML/HR","ml/hr")
 .I X1[" ml/hr",(+X1=$P(X1," ml/hr")) D
 ..S X1=$P(X1," ml/hr")_$P(X1," ml/hr",2,9999)
 .I X2[" ml/hr",(+X2=$P(X2," ml/hr")) D
 ..S X2=$P(X2," ml/hr")_$P(X2," ml/hr",2,9999)
 .I X1["ml/hr",(+X1=$P(X1,"ml/hr")) D
 ..S X1=$P(X1,"ml/hr")_$P(X1,"ml/hr",2,9999)
 .I X2["ml/hr",(+X2=$P(X2,"ml/hr")) D
 ..S X2=$P(X2,"ml/hr")_$P(X2,"ml/hr",2,9999)
 .I X2'=+X2 D
 ..I X2>0&(X2<1) Q
 ..I ($P(X2,"@",2,999)'=+$P(X2,"@",2,999)!(+$P(X2,"@",2,999)<0)) K X Q
 .I X1>0&(X1<1) I +X1="."_$P(X1,".",2) S X1=X1_" ml/hr"
 .I X2>0&(X2<1) I +X2="."_$P(X2,".",2) S X2=X2_" ml/hr"
 .I X1=+X1 S X1=X1_" ml/hr"
 .I X2=+X2 S X2=X2_" ml/hr"
 .S:$P(X2,"@")=+X2 $P(X2,"@")=$P(X2,"@")_" ml/hr"
 .S X=X1_"="_X2
 I X["ML/HR",(+X=$P(X,"ML/HR"))!(+X=$P(X," ML/HR")) S X=$TR(X,"ML/HR","ml/hr")
 I X[" ml/hr",+X=$P(X," ml/hr") S X=$P(X," ml/hr")_$P(X," ml/hr",2,9999)
 I X["ml/hr",+X=$P(X,"ml/hr") S X=$P(X,"ml/hr")_$P(X,"ml/hr",2,9999)
 I X>0,X<1 D  Q
 .I X["ML/HR",(+X=$P($P(X,"ML/HR"),".",2))!(+X=$P($P(X," ML/HR"),".",2)) S X=$TR(X,"ML/HR","ml/hr")
 .I X[" ml/hr",(+X=$P($P(X," ml/hr"),".",2)) S X=$P(X," ml/hr")_$P(X," ml/hr",2,9999)
 .I X["ml/hr",+X=$P(X,"ml/hr") S X=$P(X,"ml/hr")_$P(X,"ml/hr",2,9999)
 .I +X=X S X=X_" ml/hr"
 .I $P(X,0,2)=+X S X=X_" ml/hr"
 .S X=0_+X_$P(X,+X,2)
 I '(X>0&X<1) I X'=+X,($P(X,"@",2,999)'=+$P(X,"@",2,999)!(+$P(X,"@",2,999)<0)) K X Q
 I X=+X S X=X_" ml/hr" Q
 S:$P(X,"@")=+X $P(X,"@")=$P(X,"@")_" ml/hr"
 Q
