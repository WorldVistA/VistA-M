DGYPPOST ;ALB/MLI - Clean-up cross-reference on Annual Means Test file ; 20 JUNE 95
 ;;5.3;Registration;**68**;Aug 13, 1993
 ;
 ; This routine will run through entries in the AD cross-reference on
 ; the ANNUAL MEANS TEST file (#408.31) to ensure they are accurate.
 ;
EN ; entry point
 N I,X
 W !! F I=1:1 S X=$P($T(TEXT+I),";;",2) Q:X="QUIT"  W !,X
 S ZTRTN="DQ^DGYPPOST",ZTIO="",ZTDESC="MT X-REF CLEAN-UP"
 D ^%ZTLOAD
 I $D(ZTSK) W !,"Task queued:  ",ZTSK
 E  W "...RUNNING IMMEDIATELY" D DQ W !,"Done!"
 K ZTDESC,ZTIO,ZTRTN,ZTSK
 Q
 ;
 ;
DQ ; call to begin processing
 N DGSTART,COUNT
 S DGSTART=$$NOW^XLFDT()
 D ADCLN,MAIL
 Q
 ;
 ;
ADCLN N I,J,K,X
 S COUNT=0,COUNT(1)=0
 I '$D(ZTQUEUED) W !,">>Checking AD cross-reference and killing erroneous entries..."
 S I=0 F  S I=$O(^DGMT(408.31,"AD",I)) Q:'I  D
 . F J=0:0 S J=$O(^DGMT(408.31,"AD",I,J)) Q:'J  D
 . . F K=0:0 S K=$O(^DGMT(408.31,"AD",I,J,K)) Q:'K  S DA=+$O(^(K,0)) D
 . . . S X=$G(^DGMT(408.31,DA,0))
 . . . S COUNT=COUNT+1 I '$D(ZTQUEUED),'(COUNT#250) W "."
 . . . I +X'=K!($P(X,"^",19)'=I)!($P(X,"^",2)'=J) S COUNT(1)=COUNT(1)+1 K ^DGMT(408.31,"AD",I,J,K,DA)
 I '$D(ZTQUEUED) W !,">>Done...",COUNT(1)," entr",$S(COUNT(1)'=1:"ies",1:"y")," deleted from ""AD"" cross-reference."
 Q
 ;
 ;
MAIL ; generate an e-mail bulletin when done
 N DIFROM
 S DGCOUNT=0
 D LINE("The post-init for patch DG*5.3*68 has run to completion."),LINE("")
 D LINE(COUNT(1)_" entr"_$S(COUNT(1)'=1:"ies",1:"y")_" deleted from ""AD"" cross-reference."),LINE("")
 D LINE("    Start Time:         "_DGSTART)
 D LINE("    End Time:           "_$$NOW^XLFDT()),LINE("")
 D LINE("Please remove routine DGYPPOST from all systems at this time.")
 S XMSUB="Patch DG*5.3*68 post-init has completed",XMN=0
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
