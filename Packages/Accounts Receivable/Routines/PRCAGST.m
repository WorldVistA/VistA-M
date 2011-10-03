PRCAGST ;WASH-ISC@ALTOONA,PA/CMS-Print Patient Statement ;12/12/96  9:39 AM
V ;;4.5;Accounts Receivable;**34,181,190,249**;Mar 20, 1995;Build 2
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;ENTRY WITH DEBTOR PRINT STATEMENT
EN(DEB,TBAL,PDAT,PBAL,LDT) ;
 NEW ADD,DA,LN,NAM,PAGE,SSN,X,X1,X2,Y
 I '$D(SITE) D SITE^PRCAGU
 S SSN=$$SSN^RCFN01(DEB),SSN=$S(SSN=-1:"XXXXXXXXX",1:SSN)
 S ADD=$$SADD^RCFN01(8) I ADD="" S ADD=$$SADD^RCFN01(1)
 S X=0 F Y=1:1:3 I $P(ADD,U,Y)]"" S X=X+1 S ADD(X)=$P(ADD,U,Y)
 S X=X+1,ADD(X)=$P(ADD,U,4)_", "_$P(ADD,U,5)_"  "_$P(ADD,U,6)
 S X=X+1,ADD(X)=$P(ADD,U,7)
 W @IOF
 W !!,"Department of Veterans Affairs",?50,"Acct No.: ",$P($$SITE^VASITE(),U,3)_"/"_$E(SSN,6,9)
 W !,$G(ADD(1))
 S Y=$$FPS^RCAMFN01($S($G(LDT)>0:$E(LDT,1,5),1:$E(DT,1,5))_$TR($J($$PST^RCAMFN01(DEB),2)," ",0),$S(+$E($G(LDT),6,7)>$$STD^RCCPCFN:2,1:1)) D DD^%DT
 W !,$G(ADD(2)),?50 I TBAL>0 W "Due: UPON RECEIPT"
 W !,$G(ADD(3)),?50,$S(TBAL>0:"Amount Due: $"_$J(TBAL,0,2),1:"NO AMOUNT DUE")
 W !,$G(ADD(4)),?50,$S(TBAL'>0:"*THIS IS NOT A BILL*",1:"Amount Paid: _____________")
 W !,$G(ADD(5)),?50,"Today's Date: " S Y=DT D DD^%DT W Y
 I TBAL'>0 D MES G LB
 W !!,?2,"Please Make your Check or Money Order payable to the ""Department of Veterans"
 W !,?2,"Affairs"" and send payment to the above address.  If you have any questions"
 W !,?2,"regarding this statement, please call the number listed above.",!!!
LB K ADD S NAM=$$NAM^RCFN01(DEB)
 W !,?7,NAM
 S ADD=$$DADD^RCAMADD(DEB,1) ; Get debtor address, confidential if applicable
 S X=0 F Y=1:1:3 I $P(ADD,U,Y)]"" S X=X+1 S ADD(X)=$P(ADD,U,Y)
 S X=X+1,ADD(X)=$P(ADD,U,4)_", "_$P(ADD,U,5)_"  "_$P(ADD,U,6)
 F X=0:0 S X=$O(ADD(X)) Q:'X  W !,?7,$E(ADD(X),1,40) I X=1 W ?50 X $G(SITE("SCAN"))
 W !
 I $G(SITE("COM1"))'="" W !,?2,SITE("COM1")
 I $$GMT(DEB) W !,?2,"REDUCTION OF INPATIENT COPAYMENT DUE TO GEOGRAPHIC MEANS TEST STATUS"
 W !! I TBAL>0 W !,?10,"Please Detach and Return Top Portion with Payment"
 S Y="",$P(Y,"=",80)="" W !,Y
 W !,"IMPORTANT: Please read the Notice of Rights accompanying this statement!",!
 D ^PRCAGST1
 Q
MES ;text for no amount due
 W !!,?2,"This statement is being sent to you to provide you with information"
 W !,?2,"concerning transactions affecting your account. If a prepayment offset"
 W !,?2,"a bill or you have made one or more payments or charges were removed,"
 W !,?2,"from your account, you are being sent this statement to confirm these actions.",!!
 Q
 ;
 ; Detect GMT-related status for the statement (fetch all patient's bills)
 ; Input: Temporary global ^TMP("PRCAGT",$J,PRDEB)
 ; Output: 1 - 'Yes', 0 - 'No'
GMT(PRDEB) N PRDAT,PRBN,PRGMT
 S PRGMT=0 ; Default
 I $G(PRDEB)'="" S PRDAT=0 F  S PRDAT=$O(^TMP("PRCAGT",$J,PRDEB,PRDAT)) Q:'PRDAT  D  Q:PRGMT
 . S PRBN=0 F  S PRBN=$O(^TMP("PRCAGT",$J,PRDEB,PRDAT,PRBN)) Q:'PRBN  D  Q:PRGMT
 .. I $$ISGMTBIL^IBAGMT($P($G(^PRCA(430,PRBN,0)),U,1)) S PRGMT=1
 Q PRGMT
