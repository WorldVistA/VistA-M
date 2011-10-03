DGYSPOST ;ALB/MLI - POST-INIT FOR PATCH DG*5.3*54 ; 10 APRIL 95
 ;;5.3;Registration;**54**;Aug 13, 1993
 ;
 ; This is the post-init routine for patch DG*5.3*54.
 ;
EN ; entry point
 N I,X
 W !! F I=1:1 S X=$P($T(TEXT+I),";;",2) Q:X="QUIT"  W !,X
 S ZTRTN="DQ^DGYSPOST",ZTIO="",ZTDESC="Patch DG*5.3*54 post-init"
 D ^%ZTLOAD
 I $D(ZTSK) W !,"Task queued:  ",ZTSK
 E  W "...RUNNING IMMEDIATELY" D DQ W !,"Done!"
 K ZTDESC,ZTIO,ZTRTN,ZTSK
 Q
 ;
 ;
DQ ; called to begin processing
 N DGSTART
 S DGSTART=$$NOW^XLFDT()
 D SSNXREF,ARMCLN,MAIL
 Q
 ;
 ;
SSNXREF ; update SSN x-ref in ^DPT if not currently set
 N DFN,X
 I '$D(ZTQUEUED) W !,">> Resetting SSN cross-reference on PATIENT file (#2)..."
 F DFN=0:0 S DFN=$O(^DPT(DFN)) Q:'DFN  D
 . I '(DFN#1000),'$D(ZTQUEUED) W "."
 . S X=$P($G(^DPT(DFN,0)),"^",9)
 . I X]"",'$D(^DPT("SSN",X,DFN)) S ^(DFN)=""
 Q
 ;
 ;
ARMCLN ; loop through ^DGPM("ARM" and make sure entries are valid
 N CT,DFN,I,J
 I '$D(ZTQUEUED) W !,">> Checking ARM cross-reference on PATIENT MOVEMENT file (#405)..."
 S (CT,I)=0
 F  S I=$O(^DGPM("ARM",I)) Q:I']""  F J=0:0 S J=$O(^DGPM("ARM",I,J)) Q:'J  D
 . S CT=CT+1
 . S DFN=$P($G(^DGPM(J,0)),"^",3)
 . I $G(^DPT(+DFN,.108))'=I K ^DGPM("ARM",I,J)
 . I '$D(ZTQUEUED),'(CT#50) W "."
 Q
 ;
 ;
MAIL ; generate an e-mail bulletin when done
 N DIFROM
 S DGCOUNT=0
 D LINE("The post-init for patch DG*5.3*54 has run to completion."),LINE("")
 D LINE("    Start Time:         "_DGSTART)
 D LINE("    End Time:           "_$$NOW^XLFDT()),LINE("")
 D LINE("Please remove routine DGYSPOST from all systems at this time.")
 S XMSUB="Patch DG*5.3*54 post-init has completed",XMN=0
 S XMTEXT="DGTEXT("
 S XMDUZ=.5,XMY(DUZ)=""
 D ^XMD
 K DGCOUNT,DGTEXT,XMDUZ,XMN,XMSUB,XMTEXT,XMY
 Q
 ;
 ;
LINE(TEXT) ; add text to mail message
 S DGCOUNT=DGCOUNT+1,DGTEXT(DGCOUNT)=TEXT
 Q
 ;
 ;
TEXT ; text to display
 ;;You will now be asked for a time to queue the cross-reference
 ;;clean-up.  We recommend you respond NOW as this update can be done
 ;;with users on the system.  It is being queued in order to make the
 ;;initialization finish faster.  Once the clean-up has finished, you
 ;;will receive an e-mail message.
 ;;
 ;;Please note, if you exit (^) without answering the 'Requested Start
 ;;Time: NOW//' prompt, the cross-reference clean-up will occur
 ;;immediately.
 ;;
 ;;QUIT
