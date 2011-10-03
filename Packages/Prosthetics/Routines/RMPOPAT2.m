RMPOPAT2 ;HINES CIO/RVD-DISPLAY PATIENT ITEM ACTIVITY ;9/16/02  11:16
 ;;3.0;PROSTHETICS;**70,99**;Feb 09, 1996
 ;RVD 7/5/02 patch #70 - Go to RMPOPAT if Read Only 2319, and
 ;
 ;DBIA # 800 - for this routine, the agreement covers the field #.01 NAME
 ;             file #440.
 ;DBIA # 801 - for this routine, the agreement covers the field
 ;             #.05 Short Description, file #441.
 ;DBIA # 10090 - Fileman read on file #4, field #99
 D HDR
 K ^UTILITY("DIQ1",$J) N DIC,DIQ
 S (RA,AN,ANS,RK,RZ)=0 K ^TMP($J,"TT"),^TMP($J,"AG"),IT
 MERGE ^TMP($J,"TT")=^RMPR(660,"AC",RMPRDFN)
 S B=0
 F  S B=$O(^TMP($J,"TT",B)) Q:B'>0  D
 . S BC=0
 . F  S BC=$O(^TMP($J,"TT",B,BC)) Q:BC'>0  D
 . .Q:$P($G(^RMPR(660,BC,0)),U,10)'=RMPR("STA")
 . .S GN=$P($G(^RMPR(660,BC,"AMS")),U,1)
 . .S ND=$P($G(^RMPR(660,BC,1)),U,4)
 . .I ND S ND=$P(^RMPR(661.1,ND,0),U,8)
 . .S:ND="" ND=2
 . .S:GN="" GN=BC
 . .S ^TMP($J,"AG",GN,ND,BC)=B
 S B=""
 F  S B=$O(^TMP($J,"AG",B)) Q:B'>0  D
 .S BC=""
 .F  S BC=$O(^TMP($J,"AG",B,BC)) Q:BC'>0  D
 . .Q:BC=2
 . .MERGE ^TMP($J,"AGG")=^TMP($J,"AG",B)
 . .S HC="",GTCST=0
 . .K HCC1
 . .F  S HC=$O(^TMP($J,"AGG",HC)) Q:HC'>0  D
 . . .S HCC=0
 . . .;changes for Surgical Implants
 . . .S BDC=""
 . . .F BDC=1:1 S HCC=$O(^TMP($J,"AGG",HC,HCC)) Q:HCC'>0  D
 . . . .S GTCST=GTCST+$P(^RMPR(660,HCC,0),U,16)
 . . . .I BDC=1&(HC'=2) S HCC1=HCC
 . . . .I BDC'=1 K ^TMP($J,"TT",^TMP($J,"AGG",HC,HCC),HCC)
 . . . .I HC=2 K ^TMP($J,"TT",^TMP($J,"AGG",HC,HCC),HCC)
 . .I $G(HCC1) S $P(^TMP($J,"TT",^TMP($J,"AGG",1,HCC1),HCC1),U,3)=GTCST K HCC1
 . .K GTCST,^TMP($J,"AGG")
 K ^TMP($J,"AG"),BDC
 S B=0,RC=1
 F  S B=$O(^TMP($J,"TT",B)) Q:B'>0  D
 .S RK=0
 .F  S RK=$O(^TMP($J,"TT",B,RK)) Q:RK'>0  D
 . .Q:$D(^RMPO(665.72,"AC",RK))
 . .S IT(RC)=RK
 . .I $P(^TMP($J,"TT",B,RK),U,3) S $P(IT(RC),U,3)=$P(^TMP($J,"TT",B,RK),U,3)
 . .S RC=RC+1
 S RK=0,RZ=0
 K ^TMP($J,"TT"),B
 ;
 G:'$D(IT) END
DIS ;DISPLAY APPLIANCES OR REPAIRS
 I $G(RK)="" S RK="",RC=""
 I (RK+1'>RC)&($G(IT(RK+1))) S RK=RK+1 S AN=+IT(RK),Y=^RMPR(660,AN,0) D PRT,OVER:((IOSL-4)<$Y) G:'$D(ANS)!(ANS=U)!($D(DUOUT))!($D(DTOUT)) EXIT G DIS
END I RC=0 W !,"No Appliances or Repairs exist for this veteran!",!! H 3 G EXIT
 ;
 I RC>0 W !!,"End of Appliance/Repair records for this veteran!" D OVER I $G(RK)+1'>$G(RC)&($G(IT($G(RK)+1))) D DIS
 ;
EXIT K I,J,L,R0,IT,RA,RMPRSTN,RMYSAV,DIQ,^UTILITY("DIQ1",$J)
 Q:'$D(RMPRDFN)
 W !
 I $D(DUOUT)!($D(DTOUT)) G ASK1^RMPOPAT
 S FL=4 G ASK2^RMPOPAT
 Q
PRT MERGE RMYSAV=Y
 S DATE=$P(Y,U,3),TYPE=$P(Y,U,6),QTY=$P(Y,U,7)
 S VEN=$P(Y,U,9),TRANS=$P(Y,U,4),STA=$P(Y,U,10),SN=$P(Y,U,11)
 S DEL=$P(Y,U,12)
 S CST=$S($P(Y,U,16)'="":$P(Y,U,16),$D(^RMPR(660,AN,"LB")):$P(^RMPR(660,AN,"LB"),U,9),1:"")
 ;lab source of procurement
 I $D(^RMPR(660,AN,"LB")) S RMPRLPRO=$P(^("LB"),U,3) D
 .I RMPRLPRO="O" S RMPRLPRO="ORTHOTIC" Q
 .I RMPRLPRO="R" S RMPRLPRO="RESTORATION" Q
 .I RMPRLPRO="S" S RMPRLPRO="SHOE" Q
 .I RMPRLPRO="W" S RMPRLPRO="WHEELCHAIR" Q
 .I RMPRLPRO="N" S RMPRLPRO="FOOT CENTER" Q
 .I RMPRLPRO="D" S RMPRLPRO="DDC" Q
 ;form requested on
 S FRM=$P(Y,U,13),REM=$P(Y,U,18)
 S DATE=$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)
 S TYPE=$P($G(^RMPR(660,AN,1)),U,4)
 ;S TYPE=$S(TYPE="":"",$D(^RMPR(661,TYPE,0)):$P(^(0),U,1),1:"")
 S AMIS=$P(Y,U,15),VEN=$S(VEN="":"",$D(^PRC(440,VEN,0)):$P(^(0),U,1),1:"")
 I $D(^RMPR(660.1,"AC",AN)),$P(^RMPR(660.1,$O(^RMPR(660.1,"AC",AN,0)),0),U,11)]"" S AMIS=AMIS_"+"
 S TRANS=$S(TRANS]"":TRANS,1:""),TRANS1="" S:TRANS="X" TRANS1=TRANS,TRANS=""
 S DEL=$E(DEL,4,5)_"/"_$E(DEL,6,7)_"/"_$E(DEL,2,3) S:DEL="//" DEL=""
 W !,RK,". ",DATE,?13,QTY,?17
 W AMIS_$S(TYPE'="":$E($P($G(^RMPR(661.1,TYPE,0)),U,2),1,10),$P(Y,U,26)="D":"DELIVERY",$P(Y,U,26)="P":"PICKUP",$P(Y,U,17):"SHIPPING",1:"")
 ;W AMIS_$S(TYPE'="":$E($P(^PRC(441,TYPE,0),U,2),1,10),$P(Y,U,26)="D":"DELIVERY",$P(Y,U,26)="P":"PICKUP",$P(Y,U,17):"SHIPPING",1:"")
 ;historical item
 I TYPE=""&($D(^RMPR(660,$P(IT(RK),U,1),"HST"))) W $E($P(^("HST"),U,1),1,10)
 W ?30,TRANS,?31,TRANS1
 ;display source of procurement for 2529-3 under vendor header
 I $D(RMPRLPRO) W ?33,RMPRLPRO
 I '$D(RMPRLPRO),VEN'="" W ?33,$E(VEN,1,10)
 K RMPRLPRO
 W:$D(^RMPR(660,$P(IT(RK),U,1),"HST")) $E($P(^("HST"),U,3),1,10)
 I STA'="" D
 .S DIC="^DIC(4,",DIQ(0)="E",DR=99,DIQ="RMPRSTN",DA=STA D EN^DIQ1
 .W:$D(RMPRSTN(4,STA,99,"E")) ?45,RMPRSTN(4,STA,99,"E")
 W ?50,$E(SN,1,9),?60,DEL
 I $P(IT(RK),U,3) S CST=$P(IT(RK),U,3)
 W ?71,$J($FN($S(CST'="":CST,$P(RMYSAV,U,17):$P(RMYSAV,U,17),1:""),"T",2),9)
 W:REM]"" !,?3,REM
 I $P(IT(RK),U,2)="" S $P(IT(RK),U,2)=RZ
 Q
OVER ;
 N ANS
 S RZ=RK W !,"+=Turned-In  *=Historical Data  I=Initial  X=Repair  S=Spare  R=Replacement",!,"Enter 1-",RK," to show full entry, '^' to exit or `return` to continue.  " R ANS:DTIME S:'$T ANS="^"
 I ANS="^^" S ANS="^" G ASK1^RMPOPAT Q
 I ANS="^" G ASK1^RMPOPAT Q
 I ANS="",RK+1'>RC&($G(IT(RK+1))) D HDR Q
 I ANS="" Q
 I ANS'?1N.N!(ANS>RK)!(+ANS=0)!(+ANS'=ANS) W $C(7),!," Must be between 1 and ",RK," to be valid" G OVER
 I ANS>0,(ANS<(RK+1)) S AN=ANS,RZ=RK D ^RMPOPAT3
 S RK=$P(IT(ANS),U,2)
 Q
HDR ;Print Header, Screen 4
 W @IOF
 S PAGE=3
 W !,$E(RMPRNAM,1,20),?23,"SSN: "
 W $E(RMPRSSN,1,3)_"-"_$E(RMPRSSN,4,5)_"-"_$E(RMPRSSN,6,10)
 W ?42,"DOB: "
 S Y=RMPRDOB X ^DD("DD") W Y K Y
 W ?61,"CLAIM# ",$G(RMPRCNUM)
 W !?4,"Date",?12,"Qty",?19,"HCPCS",?28,"Type",?34,"Vendor",?45,"Sta",?50,"Serial",?58,"Delivery Date",?72,"Tot Cost"
 Q
