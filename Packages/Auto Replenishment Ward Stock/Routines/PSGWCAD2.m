PSGWCAD2 ;BHAM ISC/CML-Send 'Update AMIS Stats' MailMan message for invalid Inpatient Site assignment ; 08/29/90 9:54
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
MAIL ;Send message for AOUs with invalid INPATIENT SITE Data
 Q:'$O(ERR2(0))  S NUM=6,CNT=0
 K XMY,^TMP("PSGWMSG",$J) D NOW^%DTC S Y=X X ^DD("DD") S RDT=Y
 F PSGWDUZ=0:0 S PSGWDUZ=$O(^XUSEC("PSGWMGR",PSGWDUZ)) Q:'PSGWDUZ  S XMY(PSGWDUZ)=""
 I '$D(XMY) F PSGWDUZ=0:0 S PSGWDUZ=$O(^XUSEC("PSGW PARAM",PSGWDUZ)) Q:'PSGWDUZ  S XMY(PSGWDUZ)=""
 S:'$D(XMY) XMY(.5)="" S ^TMP("PSGWMSG",$J,1,0)="              ********** INVALID DATA NOTIFICATION **********"
 S ^TMP("PSGWMSG",$J,2,0)="",^TMP("PSGWMSG",$J,3,0)="On "_RDT_", the nightly job to update the AR/WS AMIS Stats file (#58.5)"
 F AOU=0:0 S AOU=$O(ERR2(AOU)) Q:'AOU  S NUM=NUM+1,CNT=CNT+1,^TMP("PSGWMSG",$J,NUM,0)=CNT_". "_$P(^PSI(58.1,AOU,0),"^") D CURSITE
 S PRT1=$S(CNT>1:"AOUs",1:"AOU"),^TMP("PSGWMSG",$J,4,0)="identified INVALID Inpatient Site data in the PHARMACY AOU STOCK file (#58.1)",^TMP("PSGWMSG",$J,5,0)="for the following "_PRT1_":"
 S ^TMP("PSGWMSG",$J,6,0)="",^TMP("PSGWMSG",$J,NUM+1,0)="",^TMP("PSGWMSG",$J,NUM+2,0)="Until a VALID Inpatient Site selection (i.e. an Inpatient Site that has been"
 S ^TMP("PSGWMSG",$J,NUM+3,0)="flagged as 'Selectable for AR/WS' in the INPATIENT SITE file (#59.4)) is made"
 S ^TMP("PSGWMSG",$J,NUM+4,0)="for the above "_PRT1_", NO AMIS data can be stored.  The Inpatient Site field",^TMP("PSGWMSG",$J,NUM+5,0)="can be edited through the Supervisor option 'Create the Area of Use'."
 S ^TMP("PSGWMSG",$J,NUM+6,0)=""
 S ^TMP("PSGWMSG",$J,NUM+7,0)="*** Please note that the AMIS data for the listed "_PRT1_" has NOT been lost.",^TMP("PSGWMSG",$J,NUM+8,0)="It will be picked up the next time the nightly job runs AFTER a VALID"
 S ^TMP("PSGWMSG",$J,NUM+9,0)="Inpatient Site assignment has been made!!",XMSUB="UPDATE AR/WS AMIS STATS/INVALID DATA",XMDUZ="INPATIENT PHARMACY AR/WS",XMTEXT="^TMP(""PSGWMSG"",$J," D ^XMD
 K AOU,CNT,NUM,PSGWDUZ,PRT1,RDT,SITE,SITENM,XMDUZ,XMZ,XMY,^TMP("PSGWMSG",$J) Q
CURSITE ;
 S SITE=^PSI(58.1,AOU,"SITE"),SITENM="" S:$D(^PS(59.4,SITE,0)) SITENM=$P(^PS(59.4,SITE,0),"^") S:SITENM="" SITENM="INVALID DATA VALUE"
 S NUM=NUM+1,^TMP("PSGWMSG",$J,NUM,0)=" =>currently has an Inpatient Site assignment of "_SITENM Q
