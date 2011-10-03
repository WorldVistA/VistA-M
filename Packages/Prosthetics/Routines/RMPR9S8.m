RMPR9S8 ;HOIFO/HNC - GUI 2319 TAB 8 HOME OXYGEN TRANSACTIONS LIST ;9/10/02  08:43
 ;;3.0;PROSTHETICS;**59,99**;Feb 09, 1996
 ;
 Q
A1(IEN) G A2
EN(RESULTS,IEN) ;broker
A2 S (RA,AN,ANS,RK,RZ)=0 K ^TMP($J,"TT"),^TMP($J,"AG"),IT
 K ^TMP($J,"RMPRB")
 K ^TMP($J,"RMPRC")
 ;IT IS RESULTS
 ;0;2 DFN in 668
 S RMPRDFN=$P($G(^RMPR(668,IEN,0)),U,2)
 I RMPRDFN="" S ^TMP($J,"RMPRB",1)="PATIENT NOT KNOWN" Q
 MERGE ^TMP($J,"TT")=^RMPR(660,"AC",RMPRDFN)
 S B=0
 F  S B=$O(^TMP($J,"TT",B)) Q:B'>0  D
 . S BC=0
 . F  S BC=$O(^TMP($J,"TT",B,BC)) Q:BC'>0  D
 . .;Q:$P($G(^RMPR(660,BC,0)),U,10)'=RMPR("STA")
 . .;home oxygen
 . .Q:'$D(^RMPO(665.72,"AC",BC))
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
 . .Q:'$D(^RMPO(665.72,"AC",RK))
 . .S ^TMP($J,"RMPRC",RC)=RK
 . .I $P(^TMP($J,"TT",B,RK),U,3) S $P(^TMP($J,"RMPRC",RC),U,3)=$P(^TMP($J,"TT",B,RK),U,3)
 . .S RC=RC+1
 S RK=0,RZ=0
 K ^TMP($J,"TT"),B
 ;
 G:'$D(^TMP($J,"RMPRC")) END
 ;
DIS ;format data string - only HOME OXYGEN
 S RC=""
 S RK=1
 F  S RK=$O(^TMP($J,"RMPRC",RK)) Q:RK=""  D
 .S AN=+^TMP($J,"RMPRC",RK)
 .S Y=^RMPR(660,AN,0)
 .D PRT
 ;
END ;
 ;
EXIT ;common exit point
 K ^TMP($J,"RMPRC")
 ;pass to broker
 M RESULTS=^TMP($J,"RMPRB")
 I '$D(RESULTS) S RESULTS(0)="NOTHING TO REPORT"
 K I,J,L,R0,RA
 Q
 ;
 Q
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
 ;
 ;set results array
 ;only home oxygen records at this point
 S ITEM=$S(TYPE'="":$P($G(^RMPR(661.1,TYPE,0)),U,2),$P(Y,U,26)="D":"DELIVERY",$P(Y,U,26)="P":"PICKUP",$P(Y,U,17):"SHIPPING",1:"")
 ;
 S HCPCS=$P($G(^RMPR(660,$P(^TMP($J,"RMPRC",RK),U,1),1)),U,4)
 I HCPCS'="" S HCPCS=$P($G(^RMPR(661.1,HCPCS,0)),U,1)
 S ^TMP($J,"RMPRB",RK)=$P(^TMP($J,"RMPRC",RK),U,1)_U_DATE_U_QTY_U_ITEM
 S ^TMP($J,"RMPRB",RK)=^TMP($J,"RMPRB",RK)_U_HCPCS_U_TRANS_TRANS1
 ;
 ;display source of procurement for 2529-3 under vendor header
 I $D(RMPRLPRO) S ^TMP($J,"RMPRB",RK)=^TMP($J,"RMPRB",RK)_U_RMPRLPRO
 I '$D(RMPRLPRO),VEN'="" S ^TMP($J,"RMPRB",RK)=^TMP($J,"RMPRB",RK)_U_$E(VEN,1,10)
 K RMPRLPRO
 ;
 S ^TMP($J,"RMPRB",RK)=^TMP($J,"RMPRB",RK)_U_$P($G(^DIC(4,STA,99)),U,1)_U_SN_U_DEL
 I $P(^TMP($J,"RMPRC",RK),U,3) S CST=$P(^TMP($J,"RMPRC",RK),U,3)
 S COST=$J($FN($S(CST'="":CST,$P(Y,U,17):$P(Y,U,17),1:""),"T",2),9)
 ;
 S ^TMP($J,"RMPRB",RK)=^TMP($J,"RMPRB",RK)_U_COST_U_REM
 ;
 I $P(^TMP($J,"RMPRC",RK),U,2)="" S $P(^TMP($J,"RMPRC",RK),U,2)=RZ
 ;
 Q
 ;END
