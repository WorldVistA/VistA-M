PSGWPOST ;BHAM/CML-POST INIT CONVERSION ROUTINE ; 27 Dec 93 / 11:12 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
START ;
 S XQABT4=$H
 W !!,"Beginning post-init..." S RRFLG=0 D POST1,POST2,POST3,POST4,^PSGWPST1
FINAL ;Set AR/WS node in file #59.7
 I '$D(^PS(59.7,1,0)) S X=$S($D(^DD("SITE"))[0:"UNKNOWN",^("SITE")]"":^("SITE"),1:"UNKNOWN"),$P(^PS(59.7,0),"^",3,4)="1^1",^(1,0)=X,^PS(59.7,"B",X,1)=""
 S $P(^PS(59.7,1,59.99),"^")="2.3",$P(^(59.99),"^",2)=INITDT S:RRFLG $P(^(59.99),"^",6)=INITDT
QUIT D NOW^%DTC S (DONE,Y)=% X ^DD("DD") S PRT=Y I $D(START) D TIME
 W !!,"Post-init completed ",PRT,".",!,"AR/WS Version 2.3 has been successfully installed!",!!,"Initialization process took ",MIN," minutes."
 S XQABT5=$H,X="PSGWINIY" X ^%ZOSF("TEST") I $T D @("^"_X)
 K AOU,CNT,INITDT,ITM,REA,RET,RRFLG,DONE,MIN,PRT,START,X1,X2,%,X,Y,XQABT1,XQABT2,XQABT3,XQABT4,XQABT5 Q
TIME S X=START,X1=DONE,Y=$E(X1_"000",9,10)-$E(X_"000",9,10)*60+$E(X1_"00000",11,12)-$E(X_"00000",11,12),X2=X,X=$P(X,".",1)'=$P(X1,".",1) D ^%DTC:X S X=X*1440+Y,MIN=X Q
POST1 ;Convert RETURN REASON subfield to new location as multiple
 I $D(^PS(59.7,1,59.99)),$P(^(59.99),"^",6)]"" W !!,"Post-init conversion of RETURN REASON subfield has already been done!" Q
 W !!,"Now moving existing RETURN REASON data to new location"
 F AOU=0:0 S AOU=$O(^PSI(58.1,AOU)) Q:'AOU  F ITM=0:0 S ITM=$O(^PSI(58.1,AOU,1,ITM)) Q:'ITM  F RET=0:0 S RET=$O(^PSI(58.1,AOU,1,ITM,3,RET)) Q:'RET  I $D(^PSI(58.1,AOU,1,ITM,3,RET,0)) D MOVE
 S RRFLG=1 Q
MOVE ;
 S REA=$P(^PSI(58.1,AOU,1,ITM,3,RET,0),"^",3)
 I REA]"" S ^PSI(58.1,AOU,1,ITM,3,RET,1,0)="^58.152S^1^1",^PSI(58.1,AOU,1,ITM,3,RET,1,1,0)=REA W "." S $P(^PSI(58.1,AOU,1,ITM,3,RET,0),"^",3)=""
 Q
POST2 ;Re-index "IU" cross-reference in the Drug file (#50)
 W !!,"Now re-indexing the ""IU"" cross-reference in the Drug file (#50)"
 K ^PSDRUG("IU") S CNT=0 F DRG=0:0 S DRG=$O(^PSDRUG(DRG)) Q:'DRG  I $D(^PSDRUG(DRG,2)),$P(^(2),"^",3)]"" S ^PSDRUG("IU",$P(^(2),"^",3),DRG)="" S CNT=CNT+1 W:CNT#50=0 "."
 K DRG Q
POST3 ;Re-initialize sort keys for AOU Inventory Groups
 Q:'$O(^PSI(58.2,0))
 W !!,"Now re-initializing sort keys for AOUs in AOU Inventory Group file (#58.2)" D IG^PSGWUTL1
 Q
POST4 ;Check for duplicate entries in ITEM subfile (#58.11) of 58.1   
 W !!,"Now checking for duplicate entries in the ITEM subfile of the Pharmacy",!,"AOU Stock file."
 D NOW^%DTC S PSGWDT=X,CNT=0
 F AOU=0:0 S AOU=$O(^PSI(58.1,AOU)) Q:'AOU  F DRG=0:0 S DRG=$O(^PSI(58.1,AOU,1,"B",DRG)) Q:'DRG  S ITM=$O(^PSI(58.1,AOU,1,"B",DRG,0)) I $O(^PSI(58.1,AOU,1,"B",DRG,ITM)) S ACNT=0 D
 .S ITMT=ITM,IDT=$P($G(^PSI(58.1,AOU,1,ITMT,0)),"^",3) S:IDT=""!(IDT>PSGWDT) ACNT=1 F  S ITMT=$O(^PSI(58.1,AOU,1,"B",DRG,ITMT)) Q:'ITMT  D ACHK I ACNT'<2 S CNT=CNT+1
 I CNT=0 W !!,"No duplicate entries exist !" G EPST4
 W !!,"Duplicate entries exist.",!,"A MailMan message is being sent to you regarding the problem." D
 .K XMY S ^TMP("PSGWDUP",$J,1,0)="Duplicate entries exist in the ITEM subfile (#58.11) of the PHARMACY AOU"
 .S ^TMP("PSGWDUP",$J,2,0)="STOCK file (#58.1).  Please execute the following procedures to clean the",^TMP("PSGWDUP",$J,3,0)="subfile:",(^TMP("PSGWDUP",$J,4,0),^TMP("PSGWDUP",$J,5,0))=""
 .S ^TMP("PSGWDUP",$J,6,0)="     1. Run the option Duplicate Entry Report to obtain a listing of the",^TMP("PSGWDUP",$J,7,0)="        duplicates with their inventory, on-demand, and return data."
 .S ^TMP("PSGWDUP",$J,8,0)=""
 .S ^TMP("PSGWDUP",$J,9,0)="     2. With the information provided on the report, choose the duplicate",^TMP("PSGWDUP",$J,10,0)="        that needs to be removed.",^TMP("PSGWDUP",$J,11,0)=""
 .S ^TMP("PSGWDUP",$J,12,0)="     3. Enter a phrase such as ""DO NOT USE"" in the LOCATION field of the",^TMP("PSGWDUP",$J,13,0)="        inactivated item.  The option Stock Items - Enter/Edit will allow"
 .S ^TMP("PSGWDUP",$J,14,0)="        one to edit the LOCATION field.",(^TMP("PSGWDUP",$J,15,0),^TMP("PSGWDUP",$J,16,0))=""
 .S ^TMP("PSGWDUP",$J,17,0)="     4. Inactivate the chosen item in the option Inactivate AOU Stock Item.",^TMP("PSGWDUP",$J,18,0)=""
 .S ^TMP("PSGWDUP",$J,19,0)="The Purge Dispensing Data option will purge the item from the subfile 100 days from the date of the item's last activity."
 .S XMSUB="Duplicate entries in ITEM subfile.",XMTEXT="^TMP(""PSGWDUP"",$J," S XMDUZ="INPATIENT PHARMACY AR/WS"
 .S XMY(DUZ)="" F PSGWDUZ=0:0 S PSGWDUZ=$O(^XUSEC("PSGWMGR",PSGWDUZ)) Q:'PSGWDUZ  S XMY(PSGWDUZ)=""
 .D ^XMD K XMY,^TMP("PSGWDUP",$J),XMDUZ,XMTEXT,XMSUB,PSGWDUZ
EPST4 K ACNT,IDT,ITMT,PSGWDT
 Q
ACHK ;** continue checking for number of active items
 S IDT=$P($G(^PSI(58.1,AOU,1,ITMT,0)),"^",3) S:IDT=""!(IDT>PSGWDT) ACNT=ACNT+1
 Q
