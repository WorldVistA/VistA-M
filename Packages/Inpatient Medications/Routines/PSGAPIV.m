PSGAPIV ;BIR/MV-ACTION PROFILE #1 IV ORDERS ;07 Apr 98 / 1:10 PM
 ;;5.0; INPATIENT MEDICATIONS ;**9,58,169**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA# 2191
 ;
START ;
 NEW P,ON,DRG S ON=""
 F PSGEXPDT=PSGDT:0 S PSGEXPDT=$O(^PS(55,PSGP,"IV","AIT",PST,PSGEXPDT)) Q:'PSGEXPDT  F  S ON=$O(^PS(55,PSGP,"IV","AIT",PST,PSGEXPDT,ON)) Q:ON=""  D IV
 Q
IV ;
 N X,ON55 S DFN=PSGP D GT55^PSIVORFB
 I STP'=9999999\1,(P(2)>STP) Q
 Q:"DE"[P(17)
 S X=$P(P("MR"),U,2) Q:XTYPE=2&(X["IV")  Q:XTYPE=3&(PST="S")&'($S(X="IV":1,X="IVPB":1,1:0))
 S QST=$$ONE^PSJBCMA(DFN,ON,P(9),P(2),P(3))
 I QST'="O" S QST=$S(P(9)["PRN":"P",1:"C")
 I DRG S X=$S($G(DRG("AD",1)):DRG("AD",1),1:$G(DRG("SOL",1))),DRG=$S(P(4)="H":"* TPN *",1:$E($$ENPDN^PSGMI($P(X,U,6)),1,20))
 S ^TMP($J,$E(PSGAPWDN,1,20),TM,PN,QST_U_DRG,ON_"V")=""
 Q
PRT(ON) ;*** Print IV on Action Profile #1.
 NEW TYPE S TYPE=$P(DRG,U),ON=+ON
 N ON55,DRG,P,PRTST S DFN=PSGP,PRTST=1 D GT55^PSIVORFB
 F X=2,3 S:P(X) P(X)=$E($$ENDTC^PSGMI(P(X)),1,5)
 S PSJSI=$$ENSET^PSGSICHK($P(P("OPI"),"^"))
 S QST=$$ONE^PSJBCMA(DFN,ON,P(9),P(2),P(3))
 I QST'="O" S QST=$S(P(9)["PRN":"P",1:"C")
 W !,$J(N,3),$S(QST="O":"   ",1:"  R")_" D N "  ;PSJ*5*169 Don't allow RENEW on one-time orders.
 I '$D(DRG("AD",0)) D PRTST W !
 I $O(DRG("AD",0)) F X=0:0 S X=$O(DRG("AD",X)) Q:'X  W ?11,$$WRTDRG^PSIVUTL(DRG("AD",X),41) D:X=1 PRTST D NP("AD") G:$G(PSJDLW) EXIT W !
 W ?11,"in "
 F X=0:0 S X=$O(DRG("SOL",X)) Q:'X  D:X>1 NP("SOL") W:X>1 ! W ?14,$$WRTDRG^PSIVUTL(DRG("SOL",X),41) G:$G(PSJDLW) EXIT
 W:P(9)]"" " " W P(9)," ",P(8) D:'$G(DRG("AD",1))&PRTST PRTST
 I PSJSI]"" W !?11,"Special Instructions: " F Y=1:1:$L(PSJSI," ") S Y1=$P(PSJSI," ",Y) W:($L(Y1)+$X)>79 !?33 W Y1_" "
 W !
 Q
PRTST ;*** Print the rest of the 1st line.
 W:PRTST ?52,TYPE,?55,P(2),?61,P(3),?67,P(17)
 S PRTST=0
 Q
NP(TYPE) ;
 NEW X
 D:DRG(TYPE,0)>1&($Y+11>IOSL) NP^PSGAPP
 Q
EXIT ;
 Q
