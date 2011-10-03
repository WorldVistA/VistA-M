PSGWCAD1 ;BHAM ISC/CML-Send 'Update AMIS Stats' MailMan message for missing Inpatient Site assignment ; 09/05/90 12:42
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
MAIL ;Send message for AOUs missing INPATIENT SITE Data
 Q:'$O(ERR1(0))  S NUM=5,CNT=0
 K XMY,^TMP("PSGWMSG",$J) D NOW^%DTC S Y=X X ^DD("DD") S RDT=Y
 F PSGWDUZ=0:0 S PSGWDUZ=$O(^XUSEC("PSGWMGR",PSGWDUZ)) Q:'PSGWDUZ  S XMY(PSGWDUZ)=""
 I '$D(XMY) F PSGWDUZ=0:0 S PSGWDUZ=$O(^XUSEC("PSGW PARAM",PSGWDUZ)) Q:'PSGWDUZ  S XMY(PSGWDUZ)=""
 S:'$D(XMY) XMY(.5)="" S ^TMP("PSGWMSG",$J,1,0)="              ********** MISSING DATA NOTIFICATION **********"
 S ^TMP("PSGWMSG",$J,2,0)="",^TMP("PSGWMSG",$J,3,0)="On "_RDT_", the nightly job to update the AR/WS AMIS Stats file (#58.5)"
 F AOU=0:0 S AOU=$O(ERR1(AOU)) Q:'AOU  S NUM=NUM+1,CNT=CNT+1,^TMP("PSGWMSG",$J,NUM,0)="          "_CNT_". "_$P(^PSI(58.1,AOU,0),"^")
 S PRT1=$S(CNT>1:"AOUs",1:"AOU"),PRT2=$S(CNT>1:"are",1:"is")
 S ^TMP("PSGWMSG",$J,4,0)="was unable to process the AMIS activity for the following "_PRT1_":",^TMP("PSGWMSG",$J,5,0)="",^TMP("PSGWMSG",$J,NUM+1,0)=""
 S ^TMP("PSGWMSG",$J,NUM+2,0)="The above "_PRT1_" "_PRT2_" missing an Inpatient Site assignment in the PHARMACY AOU",^TMP("PSGWMSG",$J,NUM+3,0)="STOCK file (#58.1).  Until this information is supplied, NO AMIS data can"
 S ^TMP("PSGWMSG",$J,NUM+4,0)="be stored for the "_PRT1_".",^TMP("PSGWMSG",$J,NUM+5,0)="",^TMP("PSGWMSG",$J,NUM+6,0)="One of the following Supervisor options may be used to supply the missing"
 S ^TMP("PSGWMSG",$J,NUM+7,0)="data:     1. Create the Area of Use",^TMP("PSGWMSG",$J,NUM+8,0)="          2. Identify AOU INPATIENT SITE",^TMP("PSGWMSG",$J,NUM+9,0)=""
 S ^TMP("PSGWMSG",$J,NUM+10,0)="*** Please note that the AMIS data for the listed "_PRT1_" has NOT been lost.",^TMP("PSGWMSG",$J,NUM+11,0)="It will be picked up the next time the nightly job runs AFTER an Inpatient"
 S ^TMP("PSGWMSG",$J,NUM+12,0)="Site assignment has been made!!",XMSUB="UPDATE AR/WS AMIS STATS/MISSING DATA",XMDUZ="INPATIENT PHARMACY AR/WS",XMTEXT="^TMP(""PSGWMSG"",$J," D ^XMD
 K AOU,CNT,NUM,PSGWDUZ,PRT1,PRT2,RDT,XMDUZ,XMZ,XMY,^TMP("PSGWMSG",$J) Q
