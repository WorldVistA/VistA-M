XUSFACHK ;ISF/RWF - FAILED ACCESS ATTEMPTS LOG MONITOR ;10/15/2003  15:25
 ;;8.0;KERNEL;**265**;July 10, 1995
 Q
 ;Built on work by DAF.
FAILED ;FAILED ACCESS ATTEMPTS SCAN PROGRAM
 ;This subroutine will watch over file 3.05 and report if it 
 ;finds repeated signon attempts from the same IP address
 N DA,DIC,DIE,DIK,DR,%,%Y,ZCNT,WORK,XKT,TCI
 N XLST,LAST,TCNT,NUM,NOW,ZTIO,AODLM,AODBUL,IRMLM,IRMBUL
 K ^TMP($J)
 S NOW=$$NOW^XLFDT,^XTMP("XUSFACHK",0)=$$HTFM^XLFDT($H+3)
 ;Check last time this ran. reset last run time to now.
 S XLST=$$GET1^DIQ(8989.3,"1,",405.15,"I"),DA=1,DIE="^XTV(8989.3,",DR="405.15////"_NOW D ^DIE
 S XKT=$$GET1^DIQ(8989.3,"1,",405.17,"I") ;Get Keep Threshold
 S TCI=$$GET1^DIQ(8989.3,"1,",405.18,"I") ;Get Total Count Increase
 ;loop through failed attempts log. count any that happened since last run time.
 S NUM=XLST-.0000001 S:NUM<0 NUM=0
 F  S NUM=$O(^%ZUA(3.05,NUM)) Q:NUM'>0  D
 . S ZTIO=$P(^%ZUA(3.05,NUM,0),"^",7) Q:'$L(ZTIO)  S ZTIO=$P(ZTIO,$S(ZTIO["/":"/",1:":"),1)
 . S ^TMP($J,ZTIO)=$G(^TMP($J,ZTIO))+1
CHKIT ;check to see if number of attempts on any one port is over KEEP THRESHOLD, if so save it.
 S IRMLM=$$GET1^DIQ(8989.3,"1,",405.12,"I"),AODLM=$$GET1^DIQ(8989.3,"1,",405.13,"I"),WORK=$$NBH(NOW)
 S (AODBUL,IRMBUL,TCNT)=0
 S ZTIO=""  F  S ZTIO=$O(^TMP($J,ZTIO)) Q:'$L(ZTIO)  D
 . S TCNT=TCNT+^TMP($J,ZTIO)
 . D:^TMP($J,ZTIO)>XKT SET
 . I WORK,($G(^XTMP("XUSFACHK",2,ZTIO))>IRMLM)!(TCNT>(IRMLM+TCI)) S IRMBUL=1
 . I 'WORK,($G(^XTMP("XUSFACHK",2,ZTIO))>AODLM)!(TCNT>(AODLM+TCI)) S AODBUL=1
 . Q
 D CLEAN
 ;send bulletin to irm if during work hours.  if after hours send to irm and aod.
 I IRMBUL!(AODBUL) D BULL
EXIT Q
 ;clean up and leave.
CLEAN ;clean up ^XTMP("XUSFACHK" global, If no new failed attempts remove.
 N ZNUM,ZZNUM
 S ZNUM="" F  S ZNUM=$O(^XTMP("XUSFACHK",2,ZNUM)) Q:'$L(ZNUM)  D
 .I '$D(^TMP($J,ZNUM)) D
 ..K ^XTMP("XUSFACHK",2,ZNUM)
 Q
SET ;set ^XTMP("XUSFACHK" global.
 S ^XTMP("XUSFACHK",2,ZTIO)=$G(^XTMP("XUSFACHK",2,ZTIO))+^TMP($J,ZTIO)
 Q
BULL ;send bulletin to irm. if after hours, send to aod and have irm paged.
 N NUM,DTE,X,Y,XMY,XMSUB,XMTEXT,ZCNT,I,XMDUZ,XMZ
 S XMSUB="THERE HAVE BEEN A LARGE NUMBER OF FAILED ACCESS ATTEMPTS!!"
 S XMTEXT="^TMP(""XM"",$J,",XMDUZ=.5,ZCNT=0
 S Y=$$GET1^DIQ(8989.3,"1,",.02,"I") I $L(Y) S XMY(Y)=""
 I AODBUL S Y=$$GET1^DIQ(8989.3,"1,",.03,"I") I $L(Y) S XMY(Y)=""
 I '$D(XMY) S XMY(.5)=""
 S DTE=$$FMTE^XLFDT(XLST,"1P")
 D TXT("Since "_DTE_" there have been "_TCNT_" failed access attempts on VistA")
 S NUM=""  F  S NUM=$O(^TMP($J,NUM)) Q:NUM']""  I ^TMP($J,NUM)>XKT D
 . D TXT("Device "_NUM_" has had "_$G(^XTMP("XUSFACHK",2,NUM))_" attempts total so far.")
 . Q
 D TXT(" ")
 D TXT("Someone from IRM should check the Failed Access Attempts log.")
 I AODBUL D TXT("AOD PLEASE PAGE THE IRM ON-CALL PERSON")
 N DO,DIX,DIY
 D ^XMD
 Q
 ;
TXT(S) ;Add text to ^TMP("XM",$J
 S ZCNT=ZCNT+1,^TMP("XM",$J,ZCNT)=S
 Q
 ;
NBH(DATE) ;FIND OUT IF NOW IS DURING NORMAL BUSINESS HOURS.
 ;SEND DATE/TIME IN FILEMAN FORMAT
 N %,%Y
 S %Y=$$DOW^XLFDT(DATE,1)
 Q:%Y<1!(%Y>5) 0
 Q:$D(^HOLIDAY($P(DATE,".",1))) 0
 Q:$E($P(DATE,".",2)_"0000",1,4)>1630!($E($P(DATE,".",2)_"0000",1,4)<0800) 0
 Q 1
