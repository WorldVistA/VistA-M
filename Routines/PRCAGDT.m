PRCAGDT ;WASH-ISC@ALTOONA,PA/CMS - BALANCE DISCREPANCY REPORT TEXT ;12/3/93  10:36 AM
V ;;4.5;Accounts Receivable;**219**;Mar 20, 1995;Build 18
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
OK ;Statement should print
 N X,Y
 W !!,"Everything is Okay!  This patient's statement will print."
 S CHK=1
 I $D(ZTQUEUED) W !!! D ^PRCAGST1
 Q
1(DEB,BBAL,TBAL,PBAL,BEG) ;;balance discrepancy
 N X,Y
 W !!,"The balance of the outstanding AR bills is: ",?50,"$",$J(BBAL,10,2)
 W !,"The Patient Statement balance (*amount due) is: ",?50,"$",$J((TBAL+PBAL),10,2)
 W !,"The difference between these two balances is: ",?50,"$",$J((BBAL-(TBAL+PBAL)),10,2)
 W !!,"The *amount due balance on the Patient Statement contains:"
 S Y=BEG X ^DD("DD")
 W !,"Previous Statement balance of $",$J(PBAL,0,2),$S(Y'=0:" (all activity through "_Y_")",1:"")
 W !,?23,"+ New activity $",$J(TBAL,0,2)
 W !!,"Please create the appropriate transactions to get the overall account balance",!,"to equal the Patient Statement balance. Then review all bills to ensure the",!,"patient is being billed accurately."
 G OUT
2 ;Total amount due is in an unprocessed status
 W !!,"This patient's statement will not print at this time because the total",!,"outstanding amount of this account is in an unprocessed status.",!,"The unprocessed status may be Refund Review or Pending Calm Code."
 W !!,"You should process all unprocessed bills!"
 G OUT
3 ;outstanding bills and unprocessed Prepay bills
 W !!,"This patient's statement will not print at this time because it has an Open",!,"or Active bill and an unprocessed Prepayment bill.  The unprocessed status",!,"may be Refund Review or Pending Calm Code."
 W !!,"You should process all unprocessed bills!"
 G OUT
4 ;Site parameter says not to print zero balance statements
 W !!,"This patient's statement will not print at this time because it has a zero",!,"balance and the site parameter 'Suppress Zero Balance' field is set to Yes."
 G OUT
5 ;no amt due and no activity, might have prepay with no activity
 W !!,"This patient's statement will not print at this time because either there is",!,"no amount due and no new activity or this account has a credit balance with",!,"no new activity."
 G OUT
6 ;refund amount is less than $1.00
 W !!,"This patient's statement will not print because it has a refund balance",!,"less than a dollar."
 G OUT
7 ;no new activity (something other than int/admin charges) since the last three statement dates
 W !!,"This patient's statement will not print because it has no new activity",!,"for the past three statement dates other than int/admin charges."
 G OUT
8(BEG) ;statement print on or after this date
 N Y
 W !!,"This patient's statement will not print at this time because it printed",!
 S Y=BEG X ^DD("DD") W "on ",Y," and will not print until the next statement date."
 G OUT
9 ;statement date is unknown
 W !!,"Patient Statement Day is UNKNOWN!"
 G OUT
10 ;third letter already printed
 W !!,"This patient's statement will not print because the third letter has",!,"already been printed."
 W !!,"If you want to force a statement to print you can create a comment",!,"transaction and mark it so that it will appear on the statement."
 G OUT
OUT ;Exit here if account will not print statement
 S CHK=0
 I STD,$D(PDAT),$D(ZTQUEUED) W !!! D ^PRCAGST1
 Q
