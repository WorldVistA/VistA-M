PSGCAPIV ;BIR/MV-ACTION PROFILE #2 IV ORDERS ; 8/28/09 12:24pm
 ;;5.0; INPATIENT MEDICATIONS ;**9,58,169,232**;16 DEC 97;Build 2
 ;
 ; Reference to ^PS(52.6 is supported by DBIA# 1231
 ; Reference to ^PS(52.7 is supported by DBIA# 2173
 ; Reference to ^PS(55 is supported by DBIA# 2191
 ;
START ;
 NEW P,ON,DRG S ON=""
 ;* S:PSGSS'="P" PSGDT=PSGAPSD-.0001 S:PSGSS="P" STP=9999999
 S PSGDT=PSGAPSD-.0001
 F PSGEXPDT=PSGDT:0 S PSGEXPDT=$O(^PS(55,PSGP,"IV","AIT",PST,PSGEXPDT)) Q:$S('PSGEXPDT:1,PSGAPO="E":PSGEXPDT>PSGAPFD,1:0)  F  S ON=$O(^PS(55,PSGP,"IV","AIT",PST,PSGEXPDT,ON)) Q:ON=""  D IV
 Q
IV ;
 N X,ON55 S DFN=PSGP D GT55^PSIVORFB
 Q:"DE"[P(17)
 S X=$P(P("MR"),U,2) Q:XTYPE=2&(X["IV")  Q:XTYPE=3&(PST="S")&'($S(X="IV":1,X["IVP":1,1:0))  ;If med route is IVPB or IVP do not quit (PSJ*5*232)
 S QST=$$ONE^PSJBCMA(DFN,ON,P(9),P(2),P(3))
 I QST'="O" S QST=$S(P(9)["PRN":"P",1:"C")
 I DRG S X=$S($G(DRG("AD",1)):DRG("AD",1),1:$G(DRG("SOL",1))),DRG=$S(P(4)="H":"* TPN *",1:$E($$ENPDN^PSGMI($P(X,U,6)),1,20))
 S ^TMP($J,S1,PSGAPWDN,PN,QST_U_$E(DRG,1,20),ON_"V")=""
 Q
PRT(ON) ;*** Print IV orders.
 NEW TYPE S TYPE=$P(DRG,U),ON=+ON,DCU=0
 N ON55,DRG,P,PRTST S DFN=PSGP,PRTST=1 D GT55^PSIVORFB
 F X=2,3 S:P(X) P(X)=$E($$ENDTC^PSGMI(P(X)),1,5)
 S PSJSI=$$ENSET^PSGSICHK($P(P("OPI"),"^"))
 ;PSJ*5*169 Set QST so one-time orders will not allow RENEW on report.
 N QST
 S QST=$$ONE^PSJBCMA(DFN,ON,P(9),P(2),P(3))
 I QST'="O" S QST=$S(P(9)["PRN":"P",1:"C")
 W !,$J(N,3)
 I '$O(DRG("AD",0)) D PRTST W !
 I $O(DRG("AD",0)) F X=0:0 S X=$O(DRG("AD",X)) Q:'X  W ?5,$$WRTDRG^PSIVUTL(DRG("AD",X),41) D:X=1 PRTST D DCU("AD",X),NP("AD") G:$G(PSJDLW) EXIT W !
 W ?5,"in "
 F X=0:0 S X=$O(DRG("SOL",X)) Q:'X  D:X>1 NP("SOL") W:X>1 ! W ?8,$$WRTDRG^PSIVUTL(DRG("SOL",X),41) D DCU("SOL",X) G:$G(PSJDLW) EXIT
 W:P(9)]"" " " W P(9)," ",P(8) D:'$G(DRG("AD",1))&PRTST PRTST
 I PSJSI]"" W !?5,"Special Instructions: " F Y=1:1:$L(PSJSI," ") S Y1=$P(PSJSI," ",Y) W:($L(Y1)+$X)>79 !?27 W Y1_" "
 W ! D ORDP1^PSGCAPP
 Q
PRTST ;*** Print the rest of the 1st line.
 W:PRTST ?46,TYPE,?49,P(2),?55,P(3),?61,P(17)
 S PRTST=0
 Q
NP(TYPE) ;*** Print end line after order.
 NEW X
 D:DRG(TYPE,0)>1&($Y+11>IOSL) NP^PSGCAPP
 Q
DCU(TYPE,X) ;*** Calculate drug cost.
 NEW COST
 S:TYPE="AD" COST=$P(^PS(52.6,+DRG(TYPE,X),0),U,7)
 S:TYPE="SOL" COST=$P(^PS(52.7,+DRG(TYPE,X),0),U,7)
 S DCU=DCU+(COST*+$P(DRG(TYPE,X),U,3))
 Q
EXIT ;
 Q
