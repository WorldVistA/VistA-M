ENFABAL ;WIRMFO/SAB-MAINTAIN FILE 6915.9 FAP BALANCES ;4/23/96
 ;;7.0;ENGINEERING;**29**;AUG 17, 1883
 ;This routine should not be modified.
ADJBAL(STN,FUND,SGL,MTH,NET) ; Adjust Balance Amount in File #6915.9
 ; called from FAP Documents and Recalculation option
 ; Input
 ;   STN -  station number (3-5 char)
 ;   FUND - fund pointer (to NX FUND)
 ;   SGL -  standard general ledger pointer (to NX SGL)
 ;   MTH -  month (FileMan date)
 ;   NET -  net $ change (can include two decimals)
 N BAL,ENFDA,ENI,LMTH,LMTHI,NBAL,PMTH,PMTHI
 Q:$G(STN)=""!($G(FUND)="")!($G(SGL)="")!($G(MTH)="")!($G(NET)="")
 Q:MTH'?7N  ; not FileMan date
 Q:NET=0  ; no change
 I $E(MTH,6,7)'="00" S MTH=$E(MTH,1,5)_"00"
 ; add/find entry
 S ENFDA(6915.9,"?+1,",.01)=STN
 S ENFDA(6915.91,"?+2,?+1,",.01)=FUND
 S ENFDA(6915.911,"?+3,?+2,?+1,",.01)=SGL
 S ENFDA(6915.9111,"?+4,?+3,?+2,?+1,",.01)=MTH
 D UPDATE^DIE("","ENFDA","ENI") D MSG^DIALOG()
 ;
 L +^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,ENI(4),0):5
 ; get current balance
 S BAL=$$GETBAL(ENI(1),ENI(2),ENI(3),MTH)
 ; calc/post new balance
 S NBAL=BAL+NET
 S $P(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,ENI(4),0),U,2)=NBAL
 L -^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,ENI(4),0)
 ; increase balance in later months (if any)
 S LMTH=MTH
 F  S LMTH=$O(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,"B",LMTH)) Q:LMTH=""  D
 . S LMTHI=$O(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,"B",LMTH,0))
 . L +^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,LMTHI,0):5
 . S BAL=$P(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,LMTHI,0),U,2)
 . S NBAL=BAL+NET
 . S $P(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,LMTHI,0),U,2)=NBAL
 . L -^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,LMTHI,0)
 Q
 ;
GETBAL(IEN1,IEN2,IEN3,MTH) ; Get Balance Amount from File #6915.9
 ; called from ADJBAL and routine ENFAR5*
 ; Input
 ;   IEN1 - ien of station
 ;   IEN2 - ien of fund multiple
 ;   IEN3 - ien of sgl multiple
 ;   MTH  - month (FileMan date)
 ; Output
 ;   BAL  - balance amount
 N BAL,IEN4,PMTH,PMTHI
 S IEN4=$O(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,"B",MTH,0))
 S BAL=$S(IEN4:$P($G(^ENG(6915.9,IEN1,1,IEN2,1,IEN3,1,IEN4,0)),U,2),1:"")
 I BAL="" D  ; perhaps there is a balance in previous month
 . S PMTH=$O(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,"B",MTH),-1)
 . Q:PMTH=""
 . S PMTHI=$O(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,"B",PMTH,0))
 . S BAL=$P(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,PMTHI,0),U,2)
 Q BAL
 ;
RECALC ; Recalculate Net Activity for Month (optionally update file 6915.9)
 ; called from option ENFA RECALC BALANCES
 ; ask for period (month/year)
 S DIR(0)="D^::E^K:($E(Y,4,5)=""00"")!($E(Y,1,5)>$E(DT,1,5)) X"
 S DIR("A")="Enter month to recalculate"
 S X("Y")=$E(DT,1,3),X("M")=$E(DT,4,5)
 S X=$S(X("M")="01":(X("Y")-1)_"12",1:X("Y")_$E("00",1,2-$L(X("M")-1))_(X("M")-1))_"00"
 S DIR("B")=$$FMTE^XLFDT(X)
 K X
 S DIR("?",1)="Month and year are required and future dates are invalid."
 S DIR("?")="Enter the month and year to recalculate balances."
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S ENDTR=$E(Y,1,5)_"00" ; month to recalculate
 ;
 W !!,"You have chosen to recalculate the $ from FAP transactions during"
 W !,"the month of ",$$FMTE^XLFDT(ENDTR),"."
 I $E(DT,1,5)=$E(ENDTR,1,5) D
 . W $C(7),!!,"WARNING - Current month was selected. FAP Document Files will be"
 . W !,"locked to ensure that no FAP transactions (FA, FB, FC, FD, and FR)"
 . W !,"can be processed during the recalculation."
 W ! S DIR(0)="Y",DIR("A")="OK to proceed"
 D ^DIR K DIR G:'Y!$D(DIRUT) EXIT
 I $E(DT,1,5)=$E(ENDTR,1,5) D  I 'ENLOCK W !,$C(7),"Can't Proceed. Try Later" G EXIT
 . S ENLOCK=1
 . L +^ENG(6915.2):2  I '$T W !,"FA Document Log in use." S ENLOCK=0
 . L +^ENG(6915.3):2  I '$T W !,"FB Document Log in use." S ENLOCK=0
 . L +^ENG(6915.4):2  I '$T W !,"FC Document Log in use." S ENLOCK=0
 . L +^ENG(6915.5):2  I '$T W !,"FD Document Log in use." S ENLOCK=0
 . L +^ENG(6915.6):2  I '$T W !,"FR Document Log in use." S ENLOCK=0
 ;
 K ^TMP($J)
 ; calculating net activity and save in ^TMP($J,"R",
 W !!,"Calculating net activity from transactions..." D SUM^ENFABAL1
 ; compare and save problems in ^TMP($J,"P",
 W !,"Comparing FAP BALANCES file with transactions..." D FVST^ENFABAL1
 W !,"Comparing transactions with FAP BALANCES file..." D TVSF^ENFABAL2
 ;
 I '$D(^TMP($J,"P")) W !!,"No problems were found." G EXIT
 ;
 W $C(7),!!,"Problems were found..." D ^ENFABAL2 ; report
 ;
 W ! S DIR(0)="Y",DIR("A")="OK to correct file"
 D ^DIR K DIR G:'Y!$D(DIRUT) EXIT
 ;
 S ENSN="" F  S ENSN=$O(^TMP($J,"P",ENSN)) Q:ENSN=""  D
 . S ENFUND="" F  S ENFUND=$O(^TMP($J,"P",ENSN,ENFUND)) Q:ENFUND=""  D
 . . S ENFUNDI=$O(^ENG(6914.6,"B",ENFUND,0))
 . . S ENSGL=""
 . . F  S ENSGL=$O(^TMP($J,"P",ENSN,ENFUND,ENSGL)) Q:ENSGL=""  D
 . . . S ENSGLI=$O(^ENG(6914.3,"B",ENSGL,0))
 . . . S Y=$G(^TMP($J,"P",ENSN,ENFUND,ENSGL))
 . . . S ENADJ=$P(Y,U,2)-$P(Y,U)
 . . . D ADJBAL^ENFABAL(ENSN,ENFUNDI,ENSGLI,ENDTR,ENADJ)
 ;
EXIT ;
 I $E(DT,1,5)=$E($G(ENDTR),1,5) D
 . L -^ENG(6915.2):2
 . L -^ENG(6915.3):2
 . L -^ENG(6915.4):2
 . L -^ENG(6915.5):2
 . L -^ENG(6915.6):2
 K ^TMP($J)
 K ENADJ,ENDTR,ENFUND,ENFUNDI,ENLOCK,ENSGL,ENSGLI,ENSN
 K DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 Q
 ;ENFABAL
