HLUOPT6 ;CIOFO-O/LJA - Fix zero node of file 772 or 773 ;02/04/2004 09:02
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
 QUIT
 ;
 ; This utility queues a background job to recalculate and reset 
 ; pieces 3 (last IEN) and 4 (# entries) in the zero nodes for
 ; the HL Message Text file (#772) and the HL Message Administration
 ; file (#773).
 ;
FIXZERO ; Reset piece 3 & 4 of zero node of file 772 &/or 773...
 N FILE,GBL,IOINHI,IOINORM,LIST,X,Y
 D HD
 D EX
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 W !!,?3,IOINHI,"Note:",IOINORM,"  ",IOINHI
 W "This utility should be run when no purge processes are running.",IOINORM
 ;
 F  Q:($Y+4)>IOSL  W !
 QUIT:'$$BTE("Press RETURN to continue, or '^' to exit... ")  ;->
 ;
 D HD
 ;
 D FILE(.LIST) QUIT:'$D(LIST)  ;->
 W !!,"The process which fixes the zero node will now be queued to a background job."
 W !,"When complete, a verification Mailman message will be sent to you on this"
 W !,"system."
 S X=$$BTE("Press RETURN to queue job, or '^' to exit... ",1) I 'X D  QUIT  ;->
 .  W "   exiting... "
 D ZTSK
 S X=$$BTE("Press RETURN to exit... ",1)
 Q
 ;
ZTSK ;
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 S ZTIO="",ZTDTH=$H,ZTDESC="HL7 Zero Node Correction"
 S ZTRTN="QUEUE^HLUOPT6"
 S ZTSAVE("LIST(")=""
 D ^%ZTLOAD
 W !!,"Queued to task# ",ZTSK,"..."
 QUIT
 ;
QUEUE ;
 N FILE,ZERO
 S FILE=0
 F  S FILE=$O(LIST(FILE)) Q:FILE'>0  D
 .  D CORR(+FILE,.ZERO)
 D MAIL
 Q
 ;
CORR(FILE,ZERO) ; Correct zero node for file...
 ; NOTE: No purging actions should be occurring now...
 N CT,GBL,GBL0,IEN,LAST,NEW0
 ;
 S GBL=$S(FILE=772:"^HL(772)",1:"^HLMA")
 S GBL0=$S(FILE=772:"^HL(772,0)",1:"^HLMA(0)")
 S ZERO(1,FILE)=@GBL0
 ;
 S CT=0,IEN=0,LAST=""
 F  S IEN=$O(@GBL@(IEN)) Q:'IEN  D
 .  QUIT:$P($G(@GBL@(+IEN,0)),U)']""  ;->
 .  S CT=CT+1,LAST=IEN
 ;
 S (NEW0,ZERO(2,FILE))=$P(ZERO(1,FILE),U,1,2)_U_LAST_U_CT
 ;
 I FILE=772 D
 .  L +^HL(772,0):30  ; Reset zero node even if fail...
 .  S ^HL(772,0)=NEW0
 .  L -^HL(772,0)
 ;
 I FILE=773 D
 .  L +^HLMA(0):30
 .  S ^HLMA(0)=NEW0
 .  L -^HLMA(0)
 ;
 Q
 ;
MAIL ; Send Mailman message.
 N NO,TEXT,XMDUZ,XMSUB,XMTEXT,XMZ
 S XMDUZ=.5,XMSUB="HL7 Zero Node Correction"
 S XMTEXT="^TMP("_$J_",""HLMAILMSG"","
 KILL ^TMP($J,"HLMAILMSG")
 S NO=0
 D MSGBODY
 S XMY(DUZ)=""
 D ^XMD
 KILL ^TMP($J,"HLMAILMSG")
 QUIT
 ;
MSGBODY ; Add message bode...
 ; LIST,ZERO -- req
 N CT,FILE
 S CT=-1,FILE=0 F  S FILE=$O(LIST(FILE)) Q:'FILE  S CT=CT+1
 D MAILADD("The zero node for file"_$S(CT:"s 772 & 773 have",1:" "_$O(LIST(0))_" has")_" now been reset.")
 S FILE=0
 F  S FILE=$O(LIST(FILE)) Q:'FILE  D
 .  D MAILADD("")
 .  D MAILADD("File "_FILE_" zero node reset from... "_$G(ZERO(1,FILE)))
 .  D MAILADD("                           to... "_$G(ZERO(2,FILE)))
 Q
 ;
MAILADD(T) S NO=$G(NO)+1,^TMP($J,"HLMAILMSG",NO)=T
 QUIT
 ;
BTE(PMT,FF) ; 
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 F X=1:1:$G(FF) W !
 S DIR(0)="EA",DIR("A")=$G(PMT)
 D ^DIR
 QUIT:$D(DIRUT)!($D(DTOUT))!($D(DUOUT)) "" ;->
 Q $S(+Y=1:1,1:"")
 ;
FILE(LIST) ; Ask which files to correct..
 ; IOINHI,IOINORM -- req
 N DIR,DIRUT,DTOUT,DUOUT,TXT,X,Y
 KILL LIST
 W !!,"Select the file(s) now whose zero nodes should be corrected."
 W !!,?10,$$CJ^XLFSTR("Zero Node Current Value",60)
 W !,?10,$$REPEAT^XLFSTR("-",60)
 W !,?13,"^HL(772,0) = "
 D SH0($G(^HL(772,0)))
 W !,?13,"^HLMA(0) = "
 D SH0($G(^HLMA(0)))
 W !
 S DIR(0)="S^1:Correct file 772;2:Correct file 773;3:Correct both file 772 & 773"
 S DIR("A")="Select file(s) to correct"
 D ^DIR
 QUIT:$D(DIRUT)!($D(DTOUT))!($D(DUOUT))!(+Y'>0)  ;->
 S:+Y=1 LIST(772)=""
 S:+Y=2 LIST(773)=""
 I +Y=3 S LIST(772)="",LIST(773)=""
 Q
 ;
SH0(TXT) ; Highlight 3rd and 4th pieces...
 ; IOINHI,IOINORM -- req
 N PCE,VAL
 W $P(TXT,U,1,2),U,IOINHI,$P(TXT,U,3),IOINORM,U,IOINHI,$P(TXT,U,4),IOINORM
 Q
 ;
HD W @IOF,$$CJ^XLFSTR("File 772/773 Header Correction",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 QUIT
 ;
EX N I,T F I=1:1 S T=$T(EX+I) QUIT:T'[";;"  W !,$P(T,";;",2,99)
 ;;This utility corrects the zero node of the HL Message Text file (#772) and the
 ;;HL Message Administration file (#773.)  The following corrections will be made:
 ;;
 ;; - The last internal entry number will be found and set into piece 3 of the 
 ;;   file's zero node.  
 ;;
 ;; - The number of entries in the file being corrected will be recalculated and
 ;;   set into piece 4 of that file's zero node. 
 ;;
 ;;You may specify one or both of these files to be corrected.
 ;;
 ;;These files are corrected by a queued background job.  When the job completes,
 ;;you will be notified by email message.
 QUIT
 ;
EOR ; HLUOPT6 - Fix zero node of file 772 or 773 ;5/12/03 09:02
