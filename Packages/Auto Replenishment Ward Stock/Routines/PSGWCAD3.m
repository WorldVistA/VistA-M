PSGWCAD3 ;BHAM ISC/CML-Check for non-pharmacy items in AOUs before updating AMIS Stats ; 12/18/90 14:10
 ;;2.3; Automatic Replenishment/Ward Stock ;**17**;4 JAN 94
START ;Locate all non-pharmacy items in Drug file
 K APP,AOU,ERR3 S (AOUCNT,DRGCNT)=0
 S APP="" F JJ=0:0 S APP=$O(^PSDRUG("IU",APP)) Q:APP=""  I APP'["O"&(APP'["U")&(APP'["I")&(APP'["N")&(APP'["X") F DRG=0:0 S DRG=$O(^PSDRUG("IU",APP,DRG)) Q:'DRG  S APP(DRG)=""
 Q
AOU ;Check AOUs for non-pharmacy items
 G:'$O(APP(0)) QUIT F AOU=0:0 S AOU=$O(^PSI(58.1,AOU)) Q:'AOU  I $S('$D(^PSI(58.1,AOU,"I")):1,'^("I"):1,^("I")>DT:1,1:0) S AOU(AOU)=""
 G:'$O(AOU(0)) QUIT F AOU=0:0 S AOU=$O(AOU(AOU)) Q:'AOU  F ITM=0:0 S ITM=$O(^PSI(58.1,AOU,1,ITM)) Q:'ITM  S ITMNUM=$P(^PSI(58.1,AOU,1,ITM,0),"^") I $D(APP(ITMNUM)) D CHK
 I $D(ERR3) D MAIL
QUIT K %,%H,%I,AOU,AOUCNT,APP,CNT,DRG,DRGCNT,ERR3,I,INACT,ITM,ITMNUM,J,JJ,K,NUM,PRT1,PRT2,PRT3,PSGWDUZ,RDT,X,XMDUZ,XMKK,XMLOCK,XMR,XMSUB,XMT,XMTEXT,XMY,XMZ,Y,^TMP("PSGWMSG",$J) Q
CHK ;Check non-pharmacy items for inactivation date in AOU
 ;ERR3(ITMNUM,AOU)=""
 S INACT=$P(^PSI(58.1,AOU,1,ITM,0),"^",3) I $S('INACT:1,INACT>DT:1,1:0) S ERR3(ITMNUM,AOU)=""
 Q
MAIL ;Send message for non-pharmacy items found in AOUs
 Q:'$O(ERR3(0))  S NUM=6,CNT=0 F JJ=0:0 S JJ=$O(ERR3(JJ)) Q:'JJ  S DRGCNT=DRGCNT+1 F KK=0:0 S KK=$O(ERR3(JJ,KK)) Q:'KK  S AOUCNT=AOUCNT+1
 K XMY,^TMP("PSGWMSG",$J) D NOW^%DTC S Y=X X ^DD("DD") S RDT=Y
 F PSGWDUZ=0:0 S PSGWDUZ=$O(^XUSEC("PSGWMGR",PSGWDUZ)) Q:'PSGWDUZ  S XMY(PSGWDUZ)=""
 I '$D(XMY) F PSGWDUZ=0:0 S PSGWDUZ=$O(^XUSEC("PSGW PARAM",PSGWDUZ)) Q:'PSGWDUZ  S XMY(PSGWDUZ)=""
 S:'$D(XMY) XMY(.5)="" S PRT1=$S(AOUCNT>1:"AOUs",1:"AOU"),PRT2=$S(DRGCNT>1:"items",1:"item"),$P(PRT3,"-",78)=""
 S ^TMP("PSGWMSG",$J,1,0)="On "_RDT_", the nightly job to update the AR/WS AMIS Stats file (#58.5)"
 S ^TMP("PSGWMSG",$J,2,0)="identified the following "_PRT2_" in the following "_PRT1_" that "_$S(DRGCNT>1:"have",1:"has")_" been marked"
 S ^TMP("PSGWMSG",$J,3,0)="in the Drug file (#50) for NON-PHARMACY use.",^TMP("PSGWMSG",$J,4,0)=""
 S ^TMP("PSGWMSG",$J,5,0)="ITEM           AOU",^TMP("PSGWMSG",$J,6,0)=PRT3
 F DRG=0:0 S DRG=$O(ERR3(DRG)) Q:'DRG  S NUM=NUM+1,CNT=CNT+1 S ^TMP("PSGWMSG",$J,NUM,0)=CNT_"."_" "_$P(^PSDRUG(DRG,0),"^") F AOU=0:0 S AOU=$O(ERR3(DRG,AOU)) Q:'AOU  D SET
 S NUM=NUM+1,^TMP("PSGWMSG",$J,NUM,0)="",NUM=NUM+1,^TMP("PSGWMSG",$J,NUM,0)="It will be necessary to either inactivate "_$S(DRGCNT>1:"these ",1:"this ")_PRT2_" in the "_PRT1_" or mark"
 S NUM=NUM+1,^TMP("PSGWMSG",$J,NUM,0)="the "_PRT2_" for PHARMACY use in the Drug file.  For further explanation, please"
 S NUM=NUM+1,^TMP("PSGWMSG",$J,NUM,0)="refer to item #7 ([PSGW UPDATE AMIS STATS]) under the Supervisor's Menu in"
 S NUM=NUM+1,^TMP("PSGWMSG",$J,NUM,0)="the AR/WS version 2.2 USER MANUAL."
 S XMSUB="NON-PHARMACY ITEMS FOUND",XMDUZ="INPATIENT PHARMACY AR/WS",XMTEXT="^TMP(""PSGWMSG"",$J," D ^XMD
 Q
SET ;
 S NUM=NUM+1,^TMP("PSGWMSG",$J,NUM,0)="               "_$P(^PSI(58.1,AOU,0),"^") Q
