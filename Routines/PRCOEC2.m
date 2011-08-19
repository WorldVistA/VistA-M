PRCOEC2 ;WISC/DJM-IFCAP SEGMENTS IT,DE ;7/8/96  9:37 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
IT(VAR1,VAR2) ;ITEMS INFORMATION SEGMENT
 N AZ,DC,DE,DIS,DIWF,DIWL,DIWR,I0,I2,IT,ITEM,LI,LIN,OT,Q,TD,TOTAL,UC,UNIT,UP,UPN,X
 S A23=$G(^PRC(442,VAR1,23))
 I $P(A23,U,11)="P" S F1="" G IT0
 S A1=$G(^PRC(442,VAR1,1)),F1=$P(A1,U,7) S:F1="" VAR2="ERROR" W:F1="" !,"NSC-No SORCE CODE for this P.O." S F1=","_F1_",",F1=$S(",1,4,6,10,"[F1:"D",1:"")
IT0 S (ITEM,ITEMCNT)=0,TOTAL=$P($G(^PRC(442,VAR1,2,0)),U,4)+7 F  S ITEM=$O(^PRC(442,VAR1,2,ITEM)) Q:ITEM'>0  S ITEMCNT=ITEMCNT+1 D  Q:VAR2]""
 .S I0=$G(^PRC(442,VAR1,2,ITEM,0)),I2=$G(^PRC(442,VAR1,2,ITEM,2)) S:I2="" VAR2="ERROR" W:I2="" !,"NI2N"_U_ITEM_"-No contract number for this P.O."
IT1 .S Q=$P(I0,U,2) S:Q="" VAR2="ERROR" W:Q="" !,"NQTY"_U_$P(I0,U)_"-No quantity listed for this ITEM."
 .S UP=$P(I0,U,3) S:UP="" VAR2="ERROR" W:UP="" !,"NUOP"_U_$P(I0,U)_"-No unit of purchase pointer for this ITEM."
 .I UP'="" S UPN=$G(^PRCD(420.5,UP,0)) S:UPN="" VAR2="ERROR" W:UPN="" !,"NUPN"_U_$P(I0,U)_"-No entry in unit of issue file for unit of purchase pointer in",!,"ITEM entry in P.O. file."
 .I $G(UPN)'="" S UNIT=$P(UPN,U) S:UNIT="" VAR2="ERROR" W:UNIT="" !,"NUNI"_U_$P(I0,U)_"-No name entry in unit of purchase file for unit of",!,"purchase pointer in ITEM entry in P.O. file."
 .S UC=$P(I0,U,9) S:UC="" VAR2="ERROR" W:UC="" !,"NAUC"_U_$P(I0,U)_"-No actual unit cost for this ITEM."
IT2 .S LIN=$P(I0,U),(DIS,TD)=0 F  S DIS=$O(^PRC(442,VAR1,3,DIS)) G:DIS'>0 IT3 S DC=$G(^PRC(442,VAR1,3,DIS,0)),LI=$P(DC,U,6) Q:LIN=LI
IT3 .S CN=$P(I2,U,2) I F1="D",CN="" S VAR2="ERROR" W !,"NCNO"_U_$P(I0,U)_"-This order requires a contract number but none was entered",!,"for this ITEM."
 Q
