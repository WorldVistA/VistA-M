PSSQOC ;BIR/MLM-CONVERT PSJ 4.5 QUICK ORDERS FOR USE IN OE/RR 3.0 ;09/09/97
 ;;1.0;PHARMACY DATA MANAGEMENT;*100,123*;9/30/97;Build 6
 ;External reference to ^ORD(101 supported by DBIA 872
 ;External reference to ^PS(57.1 supported by DBIA 2139
 ;
EN(PROTIEN)        ;
 N DD,OI,ND0,ND1,PSJBAD,TVOLUME,X S (PSJBAD,TVOLUME)=0 K ^TMP("PSJQO",$J)
 S PSJQOPTR=+$E($P($P($G(^ORD(101,+PROTIEN,0)),U)," "),5,99)
 S ND0=$G(^PS(57.1,PSJQOPTR,0)),ND1=$G(^(1)) I ND0=""!(ND1="") Q
 I $P(ND0,U,3)'=1,$P(ND0,U,3)'=2 Q
 D @$P(ND0,U,3) Q:'OI
 S ^TMP("PSJQO",$J,1)=$P(ND0,U)_U_$P(ND0,U,3)_U_OI_U_$P(ND1,U,2,6)
 S:$G(DD) ^TMP("PSJQO",$J,"DD")=DD
 D GTPC
 ;  check infusion rate
 S X=$P(ND1,"^",5) I $G(X) D
 .D ENI K FREQ I '$D(X) S PSJBAD=1
 .E  S $P(^TMP("PSJQO",$J,1),"^",7)=X
 K:PSJBAD=1 ^TMP("PSJQO",$J)
 Q
 ;
1 ; Convert IV Fluid Quick Order
 S CNT=0 F X=0:0 S X=$O(^PS(57.1,PSJQOPTR,3,X)) Q:'X  D
 .S Y=$G(^PS(52.6,+$G(^PS(57.1,PSJQOPTR,3,X,0)),0)),OI=$P(Y,U,11)
 .S UNITS=$P("ML^LITER^MCG^MG^GM^UNITS^IU^MEQ^MM^MU^THOUU^MG-PE^NANOGRAM^MMOL",U,+$P(Y,U,3))
 .I OI]"" S CNT=CNT+1
 .I  S ^TMP("PSJQO",$J,"AD",CNT,0)=OI_U_+$P($G(^PS(57.1,PSJQOPTR,3,X,0)),"^",2)_U_UNITS
 I CNT S ^TMP("PSJQO",$J,"AD",0)=CNT_U_CNT
 S CNT=0 F X=0:0 S X=$O(^PS(57.1,PSJQOPTR,4,X)) Q:'X  D
 .S Y=$G(^PS(52.7,+$G(^PS(57.1,PSJQOPTR,4,X,0)),0)),OI=$P(Y,U,11)
 .N VOL S VOL=$P($G(^PS(57.1,PSJQOPTR,4,X,0)),"^",2)
 .S TVOLUME=TVOLUME++VOL
 .I (VOL'=+VOL)&(VOL'?1.6N1" "1"ML") S PSJBAD=1
 .I OI]"" S CNT=CNT+1
 .I  S ^TMP("PSJQO",$J,"SOL",CNT,0)=OI_U_VOL
 I CNT S ^TMP("PSJQO",$J,"SOL",0)=CNT_U_CNT
 Q
2 ;
 S OI="",PD=+ND1
 F DD=0:0 S DD=$O(^PSDRUG("AP",PD,DD)) Q:'DD  I $G(^PSDRUG(DD,"I"))=""!($G(^PSDRUG(DD,"I"))>DT) S OI=+$G(^PSDRUG(DD,2))
 I '$O(^PSDRUG("AP",PD,DD)) S ^TMP("PSJQO",$J,"DD")=DD Q
 S MATCH=1 F  S DD=$O(^PSDRUG("AP",PD,DD)) Q:'DD!'MATCH  D
 .I ($G(^PSDRUG(DD,"I"))=""!($G(^PSDRUG(DD,"I"))>DT))&(+$G(^PSDRUG(DD,2))'=OI) S MATCH=0 Q
 S:'MATCH OI=""
 Q
 ;
 ;
GTPC ; Set up TMP for provider comments    
 I $O(^PS(57.1,+PSJQOPTR,2,0))  D
 .S CNT=0 F X=0:0 S X=$O(^PS(57.1,+PSJQOPTR,2,X)) Q:'X  D
 ..S Y=$G(^PS(57.1,PSJQOPTR,2,X,0)) S:Y]"" CNT=CNT+1,^TMP("PSJQO",$J,"PC",CNT,0)=Y
 .S:$O(^TMP("PSJQO",$J,"PC",0)) ^TMP("PSJQO",$J,"PC",0)=CNT_U_CNT
 Q
ENI ;Calculate Frequency for IV orders
 K:$L(X)<1!($L(X)>30)!(X["""")!($A(X)=45) X I '$D(X) Q
 I X'=+X,($P(X,"@",2,999)'=+$P(X,"@",2,999)!(+$P(X,"@",2,999)<0)),($P(X," ml/hr")'=+$P(X," ml/hr")!(+$P(X," ml/hr")<0)) K X Q
 I X=+X S X=X_" ml/hr" D SPSOL S FREQ=$S('X:0,1:SPSOL\X*60+(SPSOL#X/X*60+.5)\1) K SPSOL Q
 I X[" ml/hr" D SPSOL S FREQ=$S('X:0,1:SPSOL\X*60+(SPSOL#X/X*60+.5)\1) K SPSOL Q
 S SPSOL=$P(X,"@",2) S:$P(X,"@")=+X $P(X,"@")=$P(X,"@")_" ml/hr" S FREQ=$S('SPSOL:0,1:1440/SPSOL\1) K SPSOL
 Q
SPSOL S SPSOL=+TVOLUME Q
