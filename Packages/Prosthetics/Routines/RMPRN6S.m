RMPRN6S ;HINES IOFO/HNC ;NPPD SORT LOGIC - 11/10/00
 ;;3.0;PROSTHETICS;**51,90**;Feb 09, 1996
 ;
 ;
DISP ;display info before dir call
 W !
 W !,?6,"Sort Options"
 W !,?6,"------------"
 W !,?6,"2 or 5 = USED INVENTORY ONLY (NEW REPORT)"
 W !!,?6,"1 or 4 = NEW ITEM COSTS, USED INVENTORY (VA) COST AS ZERO,"
 W !,?6,"         (PREVIOUS BRIEF/DETAILED NPPD REPORT)"
 W !!,?6,"3 or 6 = NEW AND USED COST, BOTH DOLLAR AMOUNTS TOTALED (NEW REPORT)"
 Q
SORTUSED ;sort only recovered items cost from PIP
 ;
 S TYPE=$P(^RMPR(660,RD,0),U,4)
 S TY=$S(TYPE="X":2,TYPE=5:2,TYPE="I":1,1:3)
 S SOURCE=$P(^RMPR(660,RD,0),U,14)
 ;only va, or used, recovered items
 Q:SOURCE'="V"
 ;stock issue null (not PIP) and source VA (used)
 I $P(^RMPR(660,RD,1),U,5)="" Q
 S CATEGRY=$P($G(^RMPR(660,RD,"AM")),U,3),SPEC=$P($G(^("AM")),U,4),GN=$P(^("AMS"),U,1)
 S COST=$P(^RMPR(660,RD,0),U,16)
 ;form
 ;S FORM=$P(^RMPR(660,RD,0),U,13)
 ;I (FORM=4)!(FORM=15) S COST=0,SOURCE="V"
 S QTY=$P(^RMPR(660,RD,0),U,7)
 S B1=RD
 S ^TMP($J,CODE,RD)=COST
 I TY=2 D REP^RMPRN6
 I TY'=2 D NEW^RMPRN6
 Q
 ;
 ;
 ;
SORTBOTH ;sort both new and used recovered items cost
 S TYPE=$P(^RMPR(660,RD,0),U,4)
 S TY=$S(TYPE="X":2,TYPE=5:2,TYPE="I":1,1:3)
 S SOURCE=$P(^RMPR(660,RD,0),U,14)
 ;
 S CATEGRY=$P($G(^RMPR(660,RD,"AM")),U,3),SPEC=$P($G(^("AM")),U,4),GN=$P(^("AMS"),U,1)
 S COST=$P(^RMPR(660,RD,0),U,16)
 ;stock issue source VA, used cost calculation is ACTUAL FOR BOTH
 ;I $P(^RMPR(660,RD,1),U,5)'=""&(SOURCE["V") S COST=0
 ;form
 S FORM=$P(^RMPR(660,RD,0),U,13)
 I (FORM=4)!(FORM=15) S COST=0,SOURCE="V"
 S QTY=$P(^RMPR(660,RD,0),U,7)
 S B1=RD
 S ^TMP($J,CODE,RD)=COST
 I TY=2 D REP^RMPRN6
 I TY'=2 D NEW^RMPRN6
 Q
HDR(X) ;display nppd sort header new or used
 I X=2!(X=5) S X="USED INVENTORY ONLY"
 I X=1!(X=4) S X="NEW ITEM COSTS, USED INVENTORY (VA) COST AS ZERO"
 I X=3!(X=6) S X="NEW AND USED COST, BOTH DOLLAR AMOUNTS TOTALED"
 Q X
END ;
