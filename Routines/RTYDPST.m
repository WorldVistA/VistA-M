RTYDPST ;ALB/ABR - PULL LIST FILE NAME CLEANUP ; SEP 28 1995
 ;;v 2.0;Record Tracking;**23**;10/22/91 
EN ;
 N ZTDESC,ZTRTN,ZTIO,ZTQUEUED,ZTSK,I,X
 W !!,"<<CLEAN-UP OF PULL LIST NAMES IN PULL LIST FILE (#194.2)>>",!
 I '$G(DUZ)!'$D(DTIME)!'$D(U) W !!,*7,">> USER NOT DEFINED.  CANNOT CONTINUE" Q
 F I=1:1 S X=$P($T(TEXT+I),";;",2) Q:X="QUIT"  W !,X
QUE S ZTRTN="CLN^RTYDPST",ZTDESC="PULL LIST FILE NAME CLEAN-UP",ZTIO=""
 D ^%ZTLOAD
 W:$D(ZTSK) !!,">>>Task "_ZTSK_" has been queued."
 Q
CLN ;entry point from Queue
 N RTI,RTPULL,RTSTART,DA,DIE,DR
 S RTI=0,RTSTART=$$HTE^XLFDT($H)
 S DIE="^RTV(194.2,"
 F  S RTI=$O(^RTV(194.2,RTI)) Q:'RTI  D:$D(^(RTI,0))
 .S RTPULL=$P(^RTV(194.2,RTI,0),U) I RTPULL'?.E1L.E Q
 .S RTPULL=$$UP^XLFSTR(RTPULL),DA=RTI,DR=".01///"_RTPULL
 .D ^DIE
 I '$D(ZTQUEUED) W ">> DONE!",!
 D MAIL
 Q
 ;
MAIL ;
 N RTTEXT,DIFROM
 S RTTEXT(1)="The PULL LIST file clean-up began on "_RTSTART
 S RTTEXT(2)="and ran to completion on "_$$HTE^XLFDT($H)_"."
 S RTTEXT(3)=" ",RTTEXT(4)="** Please delete the RTYD* routines at this time. **"
 S XMSUB="PULL LIST File Clean-up Complete",XMTEXT="RTTEXT("
 S XMDUZ=.5,XMY(DUZ)=""
 D ^XMD
 Q
TEXT ;display text
 ;;This routine will loop through the PULL LIST file, changing all Pull List names 
 ;;to all UPPER CASE.
 ;;  
 ;;THIS CLEAN-UP WILL TAKE SOME TIME AND MUST BE QUEUED!!
 ;;
 ;;QUIT
 Q
