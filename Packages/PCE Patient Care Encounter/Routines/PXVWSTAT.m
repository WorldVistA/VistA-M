PXVWSTAT ;ISP/LMT - Manage Status of ICE Interface ;12/13/17  12:24
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**217**;Aug 12, 1996;Build 134
 ;
 ;
LOGSTAT(DFN) ; Log if call succeeded or failed
 ;
 N PXNOW,PXRETCODE,PXSUB,PXSUCCESS
 ;
 S PXSUB="PXICESTAT-"_DT
 S PXNOW=$$NOW^XLFDT()
 ;
 S PXSUCCESS=1
 S PXRETCODE=$P($G(^TMP("PXICEWEB",$J,0)),U,1)
 ; Should we only consider fail if -2, -3, and -4?
 I PXRETCODE<0 S PXSUCCESS=0
 I PXRETCODE=-6 Q
 ;
 L +^XTMP(PXSUB):DILOCKTM
 ;
 I '$D(^XTMP(PXSUB)) D
 . S ^XTMP(PXSUB,0)=$$FMADD^XLFDT(PXNOW,30)_U_PXNOW_U_"ICE Web Stat Log"
 . ;M ^XTMP(PXSUB,"LAST")=^XTMP("PXICESTAT-"_$$FMADD^XLFDT(DT,-1),"LAST")
 ;
 I PXSUCCESS D
 . ;I '$$ISUP() D ENABLE
 . S ^XTMP(PXSUB,"TOTAL","SUCCESS")=$G(^XTMP(PXSUB,"TOTAL","SUCCESS"))+1
 . ;S ^XTMP(PXSUB,"LAST","SUCCESS")=PXNOW
 . ;K ^XTMP(PXSUB,"LAST","FAIL")
 . S ^XTMP(PXSUB,"LAST")=1_U_PXNOW
 ;
 I 'PXSUCCESS D
 . S ^XTMP(PXSUB,"TOTAL","FAIL")=$G(^XTMP(PXSUB,"TOTAL","FAIL"))+1
 . ;I $D(^XTMP(PXSUB,"LAST","FAIL")),DFN'=$P($G(^XTMP(PXSUB,"LAST","FAIL")),U,2) D
 . ;. ; if ICE is enabled, mark ICE as unavailable
 . ;. I $$CHKSTAT() D UNAVLBL
 . ;S ^XTMP(PXSUB,"LAST","FAIL")=PXNOW_U_DFN
 . I $P($G(^XTMP(PXSUB,"LAST")),U,1)=0,DFN'=$P($G(^XTMP(PXSUB,"LAST")),U,3) D
 . . ; if ICE is enabled, mark ICE as unavailable
 . . I $$CHKSTAT() D UNAVLBL
 . ;
 . S ^XTMP(PXSUB,"LAST")=0_U_PXNOW_U_DFN
 ;
 L -^XTMP(PXSUB)
 ;
 Q
 ;
 ;
RESTORE ; Mark ICE interface as up
 ;
 ;enable interface
 D UPDSTAT(1)
 ;send bulletin
 D SMSGRST
 ;
 Q
 ;
 ;
UNAVLBL ; Mark ICE interface as down due to too many failed attempts
 ;
 N PXDESC,PXFREQ,PXRTN,PXTASK,PXVARS,PXVOTH
 ;
 ;mark interface as unavailable
 D UPDSTAT(2)
 ;
 ;send bulletin
 D SMSGDWN
 ;
 ; Task job to run every 15 to test if ICE is back up
 S PXRTN="TASKTST^PXVWSTAT"
 S PXDESC="Test Immunization Calculation Engine (ICE)"
 S PXFREQ=15  ;Frequency (in min) to check if ICE is back up
 S PXVARS="PXFREQ"
 S PXVOTH("ZTDTH")=$$HADD^XLFDT($H,0,0,PXFREQ,0)
 S PXTASK=$$NODEV^XUTMDEVQ(PXRTN,PXDESC,PXVARS,.PXVOTH)
 ;
 Q
 ;
 ;
SMSGDWN ; send a bulletin that ICE Interface connection is down.
 ;
 N PXFDB,XMB,XMBTMP,XMDF,XMDT,XMTEXT,XMY,XMYBLOB,XMV,XMDUZ
 ;
 S XMDUZ="PX ICE MANAGER"
 S XMB="PX ICE INTERFACE DOWN"
 S XMTEXT="PXFDB"
 S PXFDB(1)="Connection to the Immunization Calculation Engine (ICE) is down!  The"
 S PXFDB(2)="ICE immunization recommendations will not be able to be utilized until"
 S PXFDB(3)="the connection is reestablished!!!"
 S XMY("G.PXRM MANAGER")=""  ;TODO: CHANGE
 D ^XMB
 ;
 Q
 ;
 ;
SMSGRST ; send a bulletin that ICE Interface connection is restored
 N PXFDB,XMB,XMBTMP,XMDF,XMDT,XMTEXT,XMY,XMYBLOB,XMV,XMDUZ
 S XMDUZ="PX ICE MANAGER"
 S XMB="PX ICE INTERFACE RESTORED"
 S XMTEXT="PXFDB"
 S PXFDB(1)="Connection to the Immunization Calculation Engine (ICE) has been restored!"
 S PXFDB(2)="The ICE immunization recommendations can now be utilized."
 S XMY("G.PXRM MANAGER")=""  ;TODO: CHANGE
 D ^XMB
 Q
 ;
 ;
CHKSTAT() ; Return ICE Status
 ; 0 - Disabled
 ; 1 - Enabled
 ; 0^1 - Enabled/Unavailable
 N PXSTATUS
 S PXSTATUS=$P($G(^PXV(920.76,1,0)),U,1)
 I PXSTATUS=2 S PXSTATUS="0^1"
 Q PXSTATUS
 ;
 ;
TASKTST ; Tasked job to test ICE
 ;
 ; ZEXCEPT: PXFREQ,ZTQUEUED,ZTREQ
 N PXSUCCESS
 ;
 S ZTREQ="@"
 ;
 ; If ICE is enabled or disabled, quit.
 ; only check ICE availability when status=enabled/unavailable
 I $$CHKSTAT()'="0^1" Q
 ;
 S PXSUCCESS=$$TESTICE^PXVWICE()
 ;
 I PXSUCCESS D  Q
 . D RESTORE
 ;
 S PXFREQ=$G(PXFREQ,15)
 I 'PXSUCCESS D
 . S ZTREQ=$$HADD^XLFDT($H,0,0,PXFREQ,0)
 ;
 Q
 ;
 ;
UPDSTAT(PXSTATUS,PXDT,PXUSER) ;
 ;
 N PXFDA,PXIEN,PXIENS
 ;
 I $G(PXSTATUS)'?1(1"0",1"1",1"2") Q
 I '$G(PXDT) S PXDT=$$NOW^XLFDT()
 S PXUSER=$G(PXUSER)
 ;
 S PXIENS="1,"
 I '$D(^PXV(920.76,1,0)) D
 . S PXIENS="+1,"
 . S PXIEN(1)=1
 ;
 S PXFDA(920.76,PXIENS,.01)=PXSTATUS
 S PXIENS="+2,"_PXIENS
 S PXFDA(920.761,PXIENS,.01)=PXDT
 S PXFDA(920.761,PXIENS,.02)=PXUSER
 S PXFDA(920.761,PXIENS,.03)=PXSTATUS
 ;
 L +^PXV(920.76,1):DILOCKTM
 ; If interface is disabled, do not let the status be changed
 ; to enabled/unavailable
 I $P($G(^PXV(920.76,1,0)),U,1)=0,PXSTATUS=2 D  Q
 . L -^PXV(920.76,1)
 D UPDATE^DIE("U","PXFDA","PXIEN")
 L -^PXV(920.76,1)
 ;
 Q
 ;
 ;
ENCHGSTA ; Entry for a user to enable/disable the ICE interface
 ;
 N PXNEWSTAT,PXOLDSTAT,PXSUCCESS
 ;
 S PXOLDSTAT=$$CHKSTAT()
 I PXOLDSTAT="0^1" S PXOLDSTAT=2
 ;
 L +^PXV(920.76,1):DILOCKTM
 I '$T D  Q
 . W !,"Another terminal is modifying this field!"
 ;
 S PXNEWSTAT=$$ASKCHNGE(PXOLDSTAT)
 ;
 I PXNEWSTAT'=-1,PXNEWSTAT'=PXOLDSTAT D UPDSTAT(PXNEWSTAT,$$NOW^XLFDT(),DUZ)
 ;
 I PXOLDSTAT=0,PXNEWSTAT=1 D
 . W !,"Please wait while we test the ICE interface..."
 . S PXSUCCESS=$$TESTICE^PXVWICE()
 . I PXSUCCESS W !!,"Connection to ICE was successful.",!!
 . I 'PXSUCCESS W !!,"Connection could not be made to ICE.",!!
 . H 1
 ;
 L -^PXV(920.76,1)
 ;
 Q
 ;
 ;
ASKCHNGE(PXOLDSTAT) ; Ask the user if they want to enable/disable the ICE interface
 ;
 N DIR,DIRUT,PXNEWSTAT,Y
 ;
 S PXNEWSTAT=PXOLDSTAT
 ;
 ; Display old status
 W !!,"The connection to ICE is currently "_$S('PXOLDSTAT:"DISABLED",1:"ENABLED")_"."
 I PXOLDSTAT=2 W !,"However, the systems is currently having issues connecting to ICE."
 W !
 ;
 ; Ask if user wants to change status
 S DIR(0)="Y^A"
 S DIR("A")="Do you wish to "_$S('PXOLDSTAT:"ENABLE",1:"DISABLE")_" the interface to ICE"
 S DIR("B")=$S(PXOLDSTAT:"NO",1:"YES")
 S DIR("?")="Enter either 'Y' or 'N'.  This will control if the interface to the Immunization Calculation Engine (ICE) is enabled or disabled."
 D ^DIR
 I $D(DIRUT)!('$G(Y)) Q -1
 ;
 ; Confirm
 K DIR,Y
 S DIR(0)="Y^A"
 S DIR("B")="NO"
 S DIR("A")="Are you sure you want to "_$S('PXOLDSTAT:"ENABLE",1:"DISABLE")_" the ICE interface"
 D ^DIR
 W !
 I $D(DIRUT)!('$G(Y)) Q -1
 ;
 S PXNEWSTAT='PXOLDSTAT
 ;
 Q PXNEWSTAT
