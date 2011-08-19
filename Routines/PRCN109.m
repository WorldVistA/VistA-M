PRCN109 ;WOIFO/SU-Extract Equipment Turn-In user counts ; 04/09/2001  03:30 PM
V ;;1.0;PRCN;**9**;Sep 13, 1996
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
POST ;
 ;
 NEW I,J,K,STA,PSTA,LC,FDT,XMSUB,XMTEXT,XMY
 NEW DIFROM
 S U="^",DT=$$DT^XLFDT
 K ^TMP("PRCN109")
 S PSTA=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
EQP ;
 ;     Equipment Committee
 S I=0,STA=PSTA F  S I=$O(^PRCN(413.2,"B",I)) Q:'I  D SETP(1)
 ;
CNCROFF ;
 ;     Concurrence Officials
 S I=0 F  S I=$O(^PRCN(413.3,"B",I)) Q:'I  D SETP(2)
 ;
KEYCHK ;
 ;   Find user with security key
 S I=0 F  S I=$O(^VA(200,I)) Q:'I  D
 . ;   Staff pick up turn-in requests
 . I $D(^XUSEC("PRCNWHSE",I)) D SETP(5)
 . ;   Examiner of new/turn-in requests
 . I $D(^XUSEC("PRCNEN",I)) D SETP(6)
 ;
CMROFC ;
 ;     CMR Officials
 S J=0 F  S J=$O(^ENG(6914,"AD",J)) Q:'J  D
 . ;  get station number
 . S STA=+$P($G(^ENG(6914.1,J,0)),"^",7)
 . I STA'?3N S STA=PSTA
 . Q:STA=""
 . ;  Responsible Official
 . S I=$P($G(^ENG(6914.1,J,0)),"^",2) I I D SETP(3) I $D(^XUSEC("PRCNCMR",I)) D SETP(4)
 . ;  Alternate Responsible Official
 . S I=+$G(^ENG(6914.1,J,20)) I I D SETP(3) I $D(^XUSEC("PRCNCMR",I)) D SETP(4)
 ;
 D RPT
EXIT ;
 K ^TMP("PRCN109")
 Q
 ;
RPT ;
 ;   Generate report from ^TMP("PRCN109")
 ;     1. count from ^TMP
 S STA=0 F  S STA=$O(^TMP("PRCN109",$J,STA)) Q:'STA  D
 . K FDT S (FDT,I)=0
 . F  S I=$O(^TMP("PRCN109",$J,STA,I)) Q:'I  S J=$G(^(I)) D
 .. F K=1:1:6 I $P(J,"^",K) S FDT(K)=$G(FDT(K))+1
 .. S FDT=FDT+1
 . F K=1:1:6 D
 .. S $P(^TMP("PRCN109",$J,STA),"^",K)=$G(FDT(K))
 . S $P(^TMP("PRCN109",$J,STA),"^",7)=FDT
 ;     2. message for user before report
 K FDT S FDT(1)="Counts are only broken out by station for CMR Official and CMR"
 S FDT(2)="Official with PRCNCMR key as the files and security keys used"
 S FDT(3)="in the analysis of the other roles do not distinguish users"
 S FDT(4)="by station.  For the latter, the users are reported in totals"
 S FDT(5)="for the main station of the VistA installation."
 ;     3. format report using local array
 F J=6,7 S FDT(J)=""
 S LC=8,FDT(LC)="$REPORT"
 S STA=0 F  S STA=$O(^TMP("PRCN109",$J,STA)) Q:'STA  S I=$G(^(STA)) D
 . I LC>1 F J=1:1:3 S LC=LC+1,FDT(LC)=""
 . S LC=LC+1,FDT(LC)="   EQUIPMENT TURN-IN USERS BY ROLE"
 . S LC=LC+1,FDT(LC)="   STATION #: "_STA
 . S LC=LC+1,FDT(LC)="       Role"_$J("Count",53)
 . F K=1:1:6 D
 .. S J=$P($T(FORMAT+K),";;",2)
 .. S LC=LC+1,FDT(LC)="       "_J_$J(+$P(I,"^",K),57-$L(J))
 . S LC=LC+1,J="Total Unique Equipment Turn-In Users"
 . S FDT(LC)="   "_J_$J(+$P(I,"^",7),61-$L(J))
 ;
 ;   $DATA
 ;     Equipment Turn-In data
 S LC=LC+1,FDT(LC)="$DATA(Equipment Turn-In)"
 S STA=0 F  S STA=$O(^TMP("PRCN109",$J,STA)) Q:'STA  S J=^(STA) D
 . S K="" F I=1:1:6 S K=K_+$P(J,"^",I)_","
 . S LC=LC+1,FDT(LC)="Station"_STA_","_K_+$P(J,"^",7)
 S LC=LC+1,FDT(LC)="$END"
 ;
MAIL ;
 ;   Send report to mail group member and patch installer
 X ^%ZOSF("UCI") S J=^%ZOSF("PROD")
 S:J'["," Y=$P(Y,",")
 ;   send report to mail group for PRODUCTION UCI only
 I Y=J F I=1:1 S J=$T(MAILGRP+I),J=$P(J,";;",2) Q:J=""  S XMY(J)=""
 ;   mail to user who install patch 9
 I $G(DUZ),$D(^VA(200,DUZ)) S XMY(DUZ)=""
 S STA=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",.01)
 I STA="" S STA="UNKNOWN"
 S XMSUB="Extract Equipment Turn-In Users by Role ("_STA_")"
 S XMTEXT="FDT("
 D ^XMD
 Q
MAILGRP ;
 ;;G.coreFLS VistA Stats@FORUM.VA.GOV
 ;;
 Q
FORMAT ;
 ;;Equipment Committee
 ;;Concurrence Officials
 ;;CMR Official
 ;;CMR Official with PRCNCMR key
 ;;Staff who assign pickups for turn-in Requests
 ;;Engineering staff who examine new/turn-in Requests
 ;;
SETP(PC) ;
 ; set value into ^TMP,    STA -- station number,    I -- DUZ
 ;   If termination date is smaller than today's date
 I $P($G(^VA(200,I,0)),"^",11),DT>$P(^(0),"^",11) Q
 I '$P($G(^TMP("PRCN109",$J,STA,I)),"^",PC) S $P(^(I),"^",PC)=1
 Q
