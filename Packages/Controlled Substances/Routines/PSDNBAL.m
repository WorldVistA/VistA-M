PSDNBAL ;EPIP/RTW - Ask CS Remaining Balance ;29 Aug 94
 ;;3.0;CONTROLLED SUBSTANCES NARCOTIC BALANCE;**84**;13 Feb 97;Build 15
 ; ICR#   TYPE    DESCRIPTION
 ;-----  -------  ------------------------------------
 ;10026  Support  ^DIR
 ;4986   Support  ^%DTC
 ;1140   Support  ^XMD
 ;---------------------------------------------------------------------
 S PSDTRY=1
ENTER ;
 N DIRUT
 S PSDOUT=0
 S DIR(0)="N"
 S DIR("A")="            Enter the remaining balance (^ to quit)"
 S DIR("T")=DTIME
 S DIR("?",1)="Enter The remaining Balance on hand"
 S DIR("?",2)="The system will compare against the database."
 S DIR("?",3)="You will have 3 tries to complete before a message is sent"
 S DIR("?",4)="to the CS BALANCE DISCREPANCY mail group"
 S DIR("?")=" "
 D ^DIR K DIR S PSDANS=Y I $D(DIRUT) S PSDOUT=1 G EXIT
 S PSDQDB=(BAL-QTY)
 W:PSDANS=PSDQDB !!,"Balance confirmed, Thank you ",! ;RTW
 S PSDQCHO=$S(PSDANS=PSDQDB:"EXIT",1:"PSDATMPT")
 D @PSDQCHO
 Q
EXIT ;
 K PSDTRY,PSDQCHO,PSDANS,PSDQDB,PSDPHN,XMDUZ,XMY,XMSUB,XMZ,PSDWANS,PSDRN
 K ^TMP($J,"MSG")
 Q
 ;;
PSDATMPT I PSDTRY=1 D MESS1 S PSDTRY=PSDTRY+1 G ENTER
 I PSDTRY=2 D MESS2 S PSDTRY=PSDTRY+1 G ENTER
 I PSDTRY=3 D MESG
 Q
MESS1 W !!,"Sorry the remaining balance you entered does not match the balance",!,"on record in the CS package.",!!,"Please check to ensure you have dispensed the right drug and",!," dispensed the correct quantity.",!
 Q
MESS2 W !!,"This will be the last entry in the remaining balance check.",!!,"If the entry still does not match a message will be sent to the",!,"appropriate person for review."
 W "  You may proceed if you have dispensed the",!,"correct drug in the correct quantity.  Thank you.",!
 Q
MESG ;Ask comment and send message
 S DIR(0)="F"
 S DIR("A")="Enter a comment (^ to quit)"
 S DIR("T")=DTIME
 S DIR("?",1)="Enter comment with any concerns about the balance discrepancy."
 S DIR("?",2)="You are limited to 245 characters."
 S DIR("?")=" "
 D ^DIR K DIR S PSDWANS=Y I $D(DIRUT) G EXIT
 K XMTEXT
 S XMSUB="Possible CS Balance Remaining Discrepancy"
 S XMY(DUZ)="" ;To User
 S XMY("G.CS BALANCE DISCREPANCY")="" ; 
 S ^TMP($J,"MSG","B",1)="There were three failed attempts to enter the current remaining balance for the following drug."
 S ^TMP($J,"MSG","B",2)=" "
 S ^TMP($J,"MSG","B",3)="           Drug  : "_PSDRN
 S ^TMP($J,"MSG","B",4)="           Rx #  : "_RXNUM
 S ^TMP($J,"MSG","B",5)="         Rx Qty  : "_QTY
 S ^TMP($J,"MSG","B",6)="Balance Entered  : "_PSDANS
 S ^TMP($J,"MSG","B",7)="Balance in VistA : "_PSDQDB
 N Y,DIFROM
 D NOW^%DTC S Y=% X ^DD("DD")
 S ^TMP($J,"MSG","B",8)="           Time : "_Y
 S XMDUZ=.5
 S PSDPHN=$P(^VA(200,DUZ,0),"^",1)
 S ^TMP($J,"MSG","B",9)="     Pharmacist : "_PSDPHN
 S ^TMP($J,"MSG","B",10)="       Comment : "_PSDWANS
 S ^TMP($J,"MSG","B",11)=" "
 S ^TMP($J,"MSG","B",12)="Thank you for checking on this possible discrepancy."  ;
 S XMTEXT="^TMP($J,""MSG"",""B"","
 D ^XMD
 W:$D(XMZ) !!,"Message sent to the CS BALANCE DISCREPANCY Mail Group",!!,"                You entered a remaining balance of ",PSDANS
 D EXIT
 Q
