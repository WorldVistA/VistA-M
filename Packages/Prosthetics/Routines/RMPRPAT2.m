RMPRPAT2 ;PHX/RFM/JLT/HNC-DISPLAY PATIENT ITEM ACTIVITY ;10/19/1993
 ;;3.0;PROSTHETICS;**32,34,29,44,99,75,137,146,162**;Feb 09, 1996;Build 5
 N BDAT,HITM
 D HDR N RMPRMERG S RMPRMERG=0
 S (RA,AN,ANS,RK,RZ)=0 K ^TMP($J,"TT"),^TMP($J,"AG"),IT
 MERGE ^TMP($J,"TT")=^RMPR(660,"AC",RMPRDFN)
 ;Check for merged accounts
 I $D(^XDRM("B",RMPRDFN_";DPT(")) D
 . S RMPRMERG=$O(^XDRM("B",RMPRDFN_";DPT(",RMPRMERG)) Q:RMPRMERG=""
 . S RMPRMERG=+^XDRM(RMPRMERG,0) Q:RMPRMERG=0
 . MERGE ^TMP($J,"TT")=^RMPR(660,"AC",RMPRMERG)
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
 . .S ^TMP($J,"AG",GN,BC,ND)=B  ;set linked grouper counter structure differently in array;RMPR*3.0*162
 ;COMBINE ITEMS FOR CALC FLAG
 ;modified linked grouper structure determination in patch RMPR*3.0*162
 S B=""
 F  S B=$O(^TMP($J,"AG",B)),ITM=0,HITM=0 Q:+B=0  D
 .F  S ITM=$O(^TMP($J,"AG",B,ITM)),BC=0 Q:+ITM=0  D
 . .F  S BC=$O(^TMP($J,"AG",B,ITM,BC)) Q:+BC=0  D
 . . .I $P($G(^RMPR(660,ITM,0)),U,17) Q
 . . .I HITM=0,BC=2 Q
 . . .I BC=1 S HITM=ITM,BDAT=^TMP($J,"AG",B,ITM,BC),^TMP($J,"TTT",B,HITM,HITM)=HITM
 . . .S $P(^TMP($J,"TT",BDAT,HITM),U,3)=$P(^TMP($J,"TT",BDAT,HITM),U,3)+$P($G(^RMPR(660,ITM,0)),U,16)
 . . .I BC=2 S ^TMP($J,"TTT",B,HITM,ITM)=HITM K ^TMP($J,"TT",BDAT,ITM)
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
 K B,^TMP($J,"TT")
 ;
 G:'$D(IT) END
DIS ;DISPLAY APPLIANCES OR REPAIRS
 I $G(RK)="" S RK="",RC=""
 I (RK+1'>RC)&($G(IT(RK+1))) S RK=RK+1 S AN=+IT(RK),Y=$G(^RMPR(660,AN,0)) G:Y="" EXITD D PRT,OVER:((IOSL-4)<$Y) G:'$D(ANS)!(ANS=U)!($D(DUOUT))!($D(DTOUT)) EXIT G DIS
END I RC=0 W !,"No Appliances or Repairs exist for this veteran!",!! H 3 G EXIT
 ;
 I RC>0 W !!,"End of Appliance/Repair records for this veteran!" D OVER I $G(RK)+1'>$G(RC)&($G(IT($G(RK)+1))) D DIS
 ;
EXIT K I,J,L,R0,IT,RA,AMIS,AN,CST,DEL,FL,FRM,ITM,PAGE,QTY,RC,RK,REM
 K RMPRCNUM,RZ,SN,TRANS,TRANS1,TYPE,VEN
 K ^TMP($J,"TTT")
 Q:'$D(RMPRDFN)
 W !
 I $D(DUOUT)!($D(DTOUT)) G ASK1^RMPRPAT
 S FL=4 G ASK2^RMPRPAT
 Q
EXITD W !!,"Appliance/Repair record was deleted during view for this veteran",!,"...Enter 'return' to continue." R TYPE:20
 G EXIT
PRT S DATE=$P(Y,U,3),TYPE=$P(Y,U,6),QTY=$P(Y,U,7)
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
 ;W AMIS_$S(TYPE'="":$E($P(^PRC(441,TYPE,0),U,2),1,10),$P(Y,U,26)="D":"DELIVERY",$P(Y,U,26)="P":"PICKUP",$P(Y,U,17):"SHIPPING",1:"")
 W AMIS_$S(TYPE'="":$E($P($G(^RMPR(661.1,TYPE,0)),U,2),1,10),$P(Y,U,26)="D":"DELIVERY",$P(Y,U,26)="P":"PICKUP",$P(Y,U,17):"SHIPPING",1:"")
 ;historical item
 I TYPE=""&($D(^RMPR(660,$P(IT(RK),U,1),"HST"))) W $E($P(^("HST"),U,1),1,10)
 W ?30,TRANS,?31,TRANS1
 ;display source of procurement for 2529-3 under vendor header
 I $D(RMPRLPRO) W ?33,RMPRLPRO
 ;I '$D(RMPRLPRO),VEN'="" W ?33,$E(VEN,1,10)
 I VEN'="" W ?33,$E(VEN,1,10)
 K RMPRLPRO
 ;historical vendor
 W:$D(^RMPR(660,$P(IT(RK),U,1),"HST")) $E($P(^("HST"),U,3),1,10)
 W:STA'="" ?45,$P(^DIC(4,STA,99),U,1)
 W ?50,$E(SN,1,9),?60,DEL
 I $P(IT(RK),U,3) S CST=$P(IT(RK),U,3)
 W ?71,$J($FN($S(CST'="":CST,$P(Y,U,17):$P(Y,U,17),1:""),"T",2),9)
 W:REM]"" !,?3,REM
 I $P(IT(RK),U,2)="" S $P(IT(RK),U,2)=RZ
 Q
OVER ;
 N ANS
 S RZ=RK W !,"+=Turned-In  *=Historical Data  I=Initial  X=Repair  S=Spare  R=Replacement",!,"Enter 1-",RK," to show full entry, '^' to exit or `return` to continue.  " R ANS:DTIME S:'$T ANS="^"
 I ANS="^^" S ANS="^" S DUOUT=1 Q  ;modified escape as it left a DO loop hanging due to GOTO, patch RMPR*3.0*162
 I ANS="^" S DUOUT=1 Q   ;modified escape as it left a DO loop hanging due to GOTO, patch RMPR*3.0*162
 I ANS="",RK+1'>RC&($G(IT(RK+1))) D HDR Q
 I ANS="" Q
 I ANS'?1N.N!(ANS>RK)!(+ANS=0)!(+ANS'=ANS) W $C(7),!," Must be between 1 and ",RK," to be valid" G OVER
 I ANS>0,(ANS<(RK+1)) S AN=ANS,RZ=RK D ^RMPRPAT3
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
