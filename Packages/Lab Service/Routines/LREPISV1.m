LREPISV1 ;DALOI/CKA LAB EPI EXTRACT SERVER ; 4/1/2003
 ;;5.2;LAB SERVICE;**281**;Sep 27, 1994
 ;
 ; Reference to $$SITE^VASITE supported by IA #10112
 ; Reference to ^%ZOSF supported by IA #10096
START ;
 K ^TMP($J,"LREPDATA")
 ;Send message to the mail group each time the server is triggered
 ;containing the name of the person who triggered the server, their
 ;location, and the action initiated.
 S LREPST=$P($$SITE^VASITE,"^",2),LRRTYPE=1
 ;Determine station number
 S X=XQSUB X ^%ZOSF("UPPERCASE") S LREPSUB=Y
 S ^TMP($J,"LREPDATA",1)=LREPSUB_" triggered at "_LREPST_" by "_XMFROM_" on "_XQDATE
 ;The first line of the message tells who requested the action and when
 S ^TMP($J,"LREPDATA",2)=$S(LREPSUB["RETRANSMIT":" RETRANSMISSION of EPI data",1:"????")_" at "_LREPST
 ;The second line tells when the server is activated and no data can be gathered from the MailMan message.
 S LREPLNT=1
 I LREPSUB'["RETRANSMIT" S ^TMP($J,"LREPDATA",3)="SUBJECT OF MAIL MESSAGE MUST BE RETRANSMIT" G EXIT
RETRANS ;RETRANSMIT
 ;first read the text of the message
 S LRERROR=0
READ F XMA=1:1  X XMREC Q:XMER<0  S XMTEXT=XMRG D
 .;
PROCESS .;
 .I XMA=1,XMTEXT'="******password******" S ^TMP($J,"LREPDATA",3)="INVALID PASSWORD" S LRERROR=1 Q
 .;
 .S LRPROT=1696
DATE .;
 .I XMA=3 D
 ..S X=XMTEXT,%DT="X" D ^%DT
 ..I Y=-1 S ^TMP($J,"LREPDATA",3)="INVALID STOP DATE" S LRERROR=1 Q
 ..S LRRPE=Y  ;Stop date
 .I XMA=2 D
 ..S X=XMTEXT,%DT="X" D ^%DT
 ..I Y=-1 S ^TMP($J,"LREPDATA",3)="INVALID START DATE" S LRERROR=1 Q
 ..S LRRPS=Y  ;Start date
 .;
TEST .;pathogens
 .F LRI=4:1 Q:LRI'=XMA  D:XMTEXT="ALL"  Q:XMTEXT="ALL"  S LREPI(LRI)=XMTEXT  Q:'$D(XMTEXT)  S LREPI(XMTEXT)=""
 ..S LRI=0 F  S LRI=$O(^LAB(69.5,LRI)) Q:'LRI!(LRI>99)  S LREPI(LRI)=""
 .;
 .;
 I LRERROR G MAIL
TASK ;
 D NOW^%DTC
 S ZTDTH=%
 Q:'$D(LREPI)
 K ZTSAVE
 S ZTSAVE("LR*")=""
 S ZTIO="",ZTRTN="EN^LREPI",ZTDESC="Laboratory Search/Extract"
 D ^%ZTLOAD
 I $D(ZTSK)[0 W !!?5,"Report canceled!"
 ;
 ;
MAIL ;
 ;
 ;If the subject contains "RETRANSMIT" DATA EXTRACTION 
EXIT ;If all went well, report that too.
 S %H=$H D YMD^%DTC S XMDUN="EPI SYSTEM",XMDUZ=".5",XMSUB=LREPST_" EPI ("_X_%_")",XMTEXT="^TMP($J,""LREPDATA"","
 S XMY("G.EPI-SITE@CINCINNATI.VA.GOV")=""
 ;S XMY("ANZALDUA,CAROL@VAHVSS.FO-ALBANY.MED.VA.GOV")="" ;,XMY("CAROL.ANZALDUA@MED.VA.GOV")=""
 D ^XMD
 ;Mail the errors and successes back to the EPI group at Cincinnati.
 K ^TMP($J,"LREPDATA")
 K %,%DT,%H,D,DIC,X,XMDUN,XMDUZ,XMER,XMFROM,XMREC,XMRG,XMSUB,XMTEXT,XMY,XMZ,XQDATE,XQSUB,Y,LREPA,LREPB,LREPDA,LREPDA1,LREPDATA,LREPDFN,LREPDM,LREPDOC
 K LREPDOM,LREPDTA,LREPED,LREPER,LREPLNT,LREPNM,LREPPT,LREPSD1,LREPSDT,LREPSSN,LREPST,LREPSUB,LREPTC,YSPR,LREPWB,LREPX,ZTQUEUED,ZTSK
 K XMA,LRA,LRCOND,LRDATA,LRFILL,LRI,LRPATH,LRTEST,LRERROR
 Q
 ;
