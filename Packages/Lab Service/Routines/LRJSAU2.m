LRJSAU2 ;ALB/GTS/DK/TMK - Lab Vista Audit Utilities;08/16/2010 15:53:28
 ;;5.2;LAB SERVICE;**425**;Sep 27, 1994;Build 30
 ;
 ;
KILL ;Kill off build data
 K ^TMP("LRJ SYS MAP AUD MSG",$J)
 K ^TMP("LRJ SYS MAP AUD MANAGER",$J)
 Q
 ;
LISTHLMM(LRHLARY) ; Store audit information in the display array
 ; INPUT -
 ;   LRHLARY - Array of raw extract data
 ;
 N LRREF,LRFROM,LRTO
 ;get top level with date information
 S LRREF=$P(LRHLARY,")")_",1)"
 S LRFROM=$P($G(@LRREF),"^")
 S LRTO=$P($G(@LRREF),"^",2)
 D KILL
 D KILL^VALM10()
 D CRTRPTAR(LRHLARY,LRFROM,LRTO,"DISPLAY","")
 Q
 ;
CRTRPTAR(LRHLARY,LRFROM,LRTO,LROUTPT,LRMMARY) ; Store info in the display array
 ; INPUT -
 ;   LRHLARY - Array of raw extract data
 ;   LRFROM  - Start date for report
 ;   LRTO    - End date for report
 ;   LROUTPT - "DISPLAY" for Listman; "MAIL" for mail message
 ;   LRMMARY - Mail message output array
 ; 
 N X,XN,XP,NODE,X1,X2,X3
 N LRFSTLNE,LRPARAM,LRLNCTN,LRLNCNT,LRVALST
 S VALM("TITLE")=AUDES_" Audit Message"
 S:$G(LRMMARY)="" LRMMARY=""
 S:$G(LROUTPT)="" LROUTPT="DISPLAY"
 S LRFSTLNE=0
 S X=AUDES_$S($D(LRFROM):" from "_$$FMTE^XLFDT(LRFROM),1:"")_$S($D(LRTO):" to "_$$FMTE^XLFDT(LRTO),1:"")
 I LROUTPT="MAIL" D
 .S LRLNCNT=0
 .D LRADDNOD^LRJSAU3(.LRLNCNT,X,"",LROUTPT,LRMMARY)
 Q
 ;
 ;THE FOLLOWING API is to be called from a Taskman
 ;scheduled job LRJ SYS MAP [autyp] TASKMAN RPT where autyp=audit type
 ;;;TASKMAN should call D TSKMMARY^LRJSAU2(AUTYP,AUDES,"^TMP(""LRJ SYS F60 AUD MANAGER"",$J)","^TMP(""LRJ SYS F60 AUD MANAGER"",$J)")
TSKMMARY(AUTYP,AUDES,AUFMT) ;TASKMAN API for Mail Message array
 ;
 ;INPUT (Roots for arrays to be created)
 ;AUTYP=Audit Type (AUF60 = File 60, AUF60XT = File 60 extract delimited file
 ;AUDES=Description (File 60 Audit, New Person Audit)
 ; LRHLARY - Array of Raw Data
 ; LRMMARY - Mail Message array to send in message
 ;AUFMT=format (Readable Display=DISPLAY; Delimited file =FILE)
 ;
 ;
 N $ESTACK,$ETRAP S $ETRAP="D TSKERR^LRJSAU2"
 N LRFROM,LRTO,LRTOMM,LRMSUBJ,XQSND,ERR,LRTOVA,LRTASKVA,LRINSTVA,AUSUB,TSKCALL,ZTIO
 ;
 ;;TO DO: GIVE INSTRUCTIONS FOR SCHEDULING THE FREQUENCY OF TASK JOB VIA TASKMAN
 ;;
 D NOW^%DTC
 S LRTO=$E(%,1,12) ;NOW is end date/time
 K %,X,%H,%I(1),%I(2),%I(3)
 S LRFROM=$$GET^XPAR("SYS","LRJ LSRP "_AUTYP_" LAST END DATE",1,"Q")
 ;
 ;If report hasn't been run before, generate for previous 7 days
 I LRFROM="" D
 .S X1=LRTO
 .S X2=-7
 .D C^%DTC
 .S LRFROM=X
 .K X,%H
 ;
 D EN^XPAR("SYS","LRJ LSRP "_AUTYP_" LAST END DATE",,LRTO,.ERR)
 D EN^XPAR("SYS","LRJ LSRP "_AUTYP_" LAST START DATE",,LRFROM,.ERR)
 ;
 S TSKCALL=1,ZTIO=""
 I AUTYP["AUF60" D AUDISP^LRJSAU60
 I AUTYP'["AUF60" Q
 S AUSUB=$S(AUTYP["AUF60":"F60",1:"")
 S (LRHLARY,LRMMARY)="^TMP(""LRJ SYS ""_AUSUB_"" AUD MANAGER"",$J)"
 I AUTYP["XT" S (LRHLARY,LRMMARY)="^TMP(""LRJ SYS ""_AUSUB_"" AUD MANAGER"",$J,""EXTRACT"")"
 ;
 I $D(@LRHLARY) D
 . S LRLPCNT=1
 . S @LRMMARY@(LRLPCNT)=AUDES_$S($D(LRFROM):" from "_$$FMTE^XLFDT(LRFROM),1:"")_$S($D(LRTO):" to "_$$FMTE^XLFDT(LRTO),1:"")
 . I AUFMT="DISPLAY" D
 . . F XCAT="NEW","OLD" D
 . . . S (LRNODE,LRSUB)=0
 . . . I '$D(@LRHLARY@(XCAT)) D  Q
 . . . . S LRLPCNT=LRLPCNT+1
 . . . . S @LRMMARY@(LRLPCNT)="  No "_$S(XCAT="NEW":"new",1:"modified")_" entries"
 . . . S LRLPCNT=LRLPCNT+1
 . . . S @LRMMARY@(LRLPCNT)=""
 . . . S LRLPCNT=LRLPCNT+1
 . . . S @LRMMARY@(LRLPCNT)=$S(XCAT="NEW":"New",1:"Modified")_" entries"
 . . . S LRLPCNT=LRLPCNT+1
 . . . S @LRMMARY@(LRLPCNT)=""
 . . . F  S LRNODE=$O(@LRHLARY@(XCAT,LRNODE)) Q:LRNODE=""  D
 . . . . F  S LRSUB=$O(@LRHLARY@(XCAT,LRNODE,LRSUB)) Q:LRSUB=""  D
 . . . . . S LRLPCNT=LRLPCNT+1
 . . . . . S @LRMMARY@(LRLPCNT)=$G(@LRHLARY@(XCAT,LRNODE,LRSUB))
 . . S LRMSUBJ=AUDES_$S($D(LRFROM):" from "_$$FMTE^XLFDT(LRFROM),1:"")_$S($D(LRTO):" to "_$$FMTE^XLFDT(LRTO),1:"")
 . . S LRTOMM("G.LRJ "_AUTYP_" AUDIT TASK REPORT")=""
 . . S XQSND=DUZ
 . . D SNDMSG(LRMSUBJ,XQSND,LRMMARY,.LRTOMM,1) ;"1" = created by Taskman; send to Mailgroup
 . ;Send Extract message with attachments
 . Q:AUFMT="DISPLAY"
 . S LRMSUBJ=AUDES_$S($D(LRFROM):" from "_$$FMTE^XLFDT(LRFROM),1:"")_$S($D(LRTO):" to "_$$FMTE^XLFDT(LRTO),1:"")
 . ;
 . ;Check for Network addresses and mail attachment
 . S LRINSTVA("ADDR FLAGS")="R"  ;Do not Restrict Message addressing
 . S LRINSTVA("FROM")="LSRP_"_AUTYP_" USER_ACTION"
 . S XQSND=DUZ
 . S LRTOVA(XQSND)=""
 . ;Array of raw extract, Array of message text for networkd address, Message subject
 . ;
 . S LRTOMM("G.LRJ "_AUTYP_" AUDIT TASK REPORT")=""
 . D OUTLKARY(LRHLARY,"^TMP($J,""LRNETMSG"")",LRMSUBJ)
 . D SNDMSG(LRMSUBJ,XQSND,"^TMP($J,""LRNETMSG"")",.LRTOMM,1)
 . ;
 K @LRHLARY,@LRMMARY,^TMP($J,"LRNETMSG")
 Q
 ;
TSKERR ;  Error trap to send bulletin if queued report encounters a system error
 N XMTEXT,XMY,XMSUB,XQSND
 S XMY("G.LRJ "_AUTYP_" AUDIT TASK REPORT")=""
 S XMSUB=AUDES_" AUTOMATED REPORT ERROR"
 S XMTEXT(1)="This message is to inform you that the "_AUDES_" automated report"
 S XMTEXT(2)="has encountered an error and did not complete.  Please contact your"
 S XMTEXT(3)="system manager for further details."
 S XMTEXT(4)=" "
 S XMTEXT(5)="ERROR OCCURRED: "_$$FMTE^XLFDT($$NOW^XLFDT,"2")
 S XMTEXT(6)="ERROR MESSAGE : "_$$EC^%ZOSV
 S XQSND=DUZ
 D SNDMSG(XMSUB,XQSND,"XMTEXT",.XMY,1)
 ;
 ; log error in standard error trap
 D ^%ZTER
 D UNWIND^%ZTER
 Q
 ;
CRTMMARY(LRHLARY,AUTYP,AUDES,AURTN,LRMMARY) ;Load Mail Message array
 ;INPUT
 ; LRHLARY - Array of Raw Data
 ;AUTYP = audit type (ex: AUF60 for File 60 audit
 ;AUDES = audit description (ex. File 60, New Person)
 ;AURTN = audit specific utility routine (ex. LRJSAU60 for file 60)
 ; LRMMARY - Mail Message array to send in message
 ;
 N LRMSUBJ,XQSND,LRFROM,LRTO,XQSND,LRNODE,LRSAVE,LRLPCNT,XCAT,LRSUB,LRREF,LRTOMM
 ;
 D LISTHLMM(LRHLARY)
 ;get top level with date information
 ;may seem like duplicate work since LISTHLMM has the same logic
 ;but LISTHLMM also called from other routine(s)
 ;may be safer to keep this logic here
 S LRREF=$P(LRHLARY,")")_",1)"
 S LRFROM=$P($G(@LRREF),"^")
 S LRTO=$P($G(@LRREF),"^",2)
 I LRFROM="" D  Q
 . W !,?10,"First invoke ""DF"" option"
 . D PAUSE^VALM1
 . I AUTYP["F60" D F60^LRJSAU
 ;
 S LRMSUBJ=AUDES_$S($D(LRFROM):" from "_$$FMTE^XLFDT(LRFROM),1:"")_$S($D(LRTO):" to "_$$FMTE^XLFDT(LRTO),1:"")
 S XQSND=DUZ,LRLPCNT=1
 I '$G(LRMMARY) S LRMMARY="^TMP(""LRJ SYS "_$E(AUTYP,3,99)_" AUD MANAGER"",$J)"
 S @LRMMARY@(LRLPCNT)=LRMSUBJ
 F XCAT="NEW","OLD" D
 . S (LRNODE,LRSUB)=0
 . I '$D(@VALMAR@(XCAT)) D  Q
 . . S LRLPCNT=LRLPCNT+1
 . . S @LRMMARY@(LRLPCNT)="  No "_$S(XCAT="NEW":"new",1:"modified")_" entries"
 . S LRLPCNT=LRLPCNT+1
 . S @LRMMARY@(LRLPCNT)=$S(XCAT="NEW":"New",1:"Modified")_" entries"
 D SNDMSG(LRMSUBJ,XQSND,LRMMARY,.LRTOMM,0)
 S @LRREF=LRFROM_"^"_LRTO
 ;I $O(@VALMAR@(0))="" K @LRMMARY@(1),@LRMMARY@(2),@LRMMARY@(3)
 Q
 ;
SNDMSG(LRMSUBJ,XQSND,LRMSGARY,LRTOMM,LRTASK) ;Send message to requestor
 ;INPUT:
 ;  LRMSUBJ  - Subject of message being generated 
 ;  XQSND    - User's DUZ, Group Name, or S.server name
 ;  LRMSGARY - Array containing message text
 ;  LRTOMM   - Array containing users, groups, etc who should receive the message
 ;  LRTASK   - If defined, indicates this is called from TASKMAN job
 ;
 N LRINSTMM,LRTASKMM,XMERR,XMZ,LRLPCNT,LRTYPE
 ;
 S:'$D(LRTASK) LRTASK=0
 I 'LRTASK D
 . K XMERR
 . S LRINSTMM("ADDR FLAGS")="R"  ;Do not Restrict Message addressing
 . S LRTYPE="S"
 . D TOWHOM^XMXAPIU(DUZ,,LRTYPE,.LRINSTMM)
 . S LRLPCNT=""
 . F  S LRLPCNT=$O(^TMP("XMY",$J,LRLPCNT)) Q:LRLPCNT=""  S LRTOMM(LRLPCNT)=""
 ;
 I +$G(XMERR)'>0 DO
 . ;no need to set additional VistA recipients - added LRTOMM as parameter
 . S LRINSTMM("FROM")="LSRP_"_AUTYP_"_USER_ACTION"
 . S LRMSUBJ=$E(LRMSUBJ,1,65)
 . D SENDMSG^XMXAPI(XQSND,LRMSUBJ,LRMSGARY,.LRTOMM,.LRINSTMM,.LRTASKMM)
 ;
 ;K @LRMSGARY,^TMP("XMY",$J),^TMP("XMY0",$J),^TMP($J,"LRNETMSG")
 Q
 ;
 ;Following Protocol invokes this API: LRJ SYS MAP AUF60 SEND EXT
CRTXTMM(LRHLARY,AUTYP,AUDES,AURTN) ;Load Mail Message array
 ;INPUT
 ; LRHLARY - Array of Raw Data [^TMP($J,"LRJ SYS") when called by LRJ SYS MAP HL SEND MSG]
 ;
 N LRMSUBJ,XQSND
 S LRREF=$P(LRHLARY,"""EXTRACT""")_"1,0)"
 S LRMSUBJ=$G(@LRREF)
 I LRMSUBJ="" D  Q
 . W !,?10,"First invoke ""DF"" option"
 . D PAUSE^VALM1
 . I AUTYP["F60" D F60^LRJSAU
 ;
 S XQSND=DUZ
 D SNDEXT(LRMSUBJ,XQSND,LRHLARY)
 Q
 ;
SNDEXT(LRMSUBJ,XQSND,LREXTARY) ;Send extract to requestor
 ;INPUT:
 ;  LRMSUBJ  - Subject of message being generated 
 ;  XQSND    - User's DUZ, Group Name, or S.server name
 ;  LREXTARY - Array containing message text.
 ;
 N LRINSTMM,LRINSTVA,LRTASKMM,LRTASKVA,LRTOMM,LRTOVA,XMERR,XMZ,LRLPCNT,LRTYPE
 ;
 S LRINSTMM("ADDR FLAGS")="R"  ;Do not Restrict Message addressing
 S LRTYPE="S"
 K XMERR
 D TOWHOM^XMXAPIU(DUZ,,LRTYPE,.LRINSTMM)
 ;
 ;Check for Network addresses and mail attachment
 S LRINSTVA("ADDR FLAGS")="R"  ;Do not Restrict Message addressing
 S LRINSTVA("FROM")="LSRP_"_AUTYP_"_USER_ACTION"
 S LRMSUBJ=$E(LRMSUBJ,1,65)
 S LRLPCNT=""
 F  S LRLPCNT=$O(^TMP("XMY",$J,LRLPCNT)) Q:LRLPCNT=""  S LRTOVA(LRLPCNT)=""
 I +$G(XMERR)'>0 DO
 .D OUTLKARY(LREXTARY,"^TMP($J,""LRNETMSG"")",LRMSUBJ)
 .D SENDMSG^XMXAPI(XQSND,LRMSUBJ,"^TMP($J,""LRNETMSG"")",.LRTOVA,.LRINSTVA,.LRTASKVA)
 ;
 K ^TMP("XMY",$J),^TMP("XMY0",$J),^TMP($J,"LRNETMSG")
 Q
 ;
OUTLKARY(LRHLARY,LRHLOTLK,LRMSUBJ) ;Create array of attachments
 ;INPUT:
 ;  LRHLARY  - Array containing message text
 ;  LRHLOTLK - Array containing message text for network addresses
 ;  LRMSUBJ  - Subject of message
 ;
 N LRFILNM,LRFILNM1,LRFILNM2,LRDTTM,LRCRLF,LRSTR,LRNODE,LROUTNOD,LRNODATA,XSUB
 S LRSTR=""
 S LRNODATA=0
 S LRCRLF=$C(13,10)
 K @LRHLOTLK
 S @LRHLOTLK@(1)="Extract Generated......: "_$$FMTE^XLFDT($$NOW^XLFDT)_LRCRLF
 S @LRHLOTLK@(2)=" "
 S @LRHLOTLK@(3)="Extract Requested......: "_LRMSUBJ_LRCRLF
 S @LRHLOTLK@(4)=" "
 ;
 S LRDTTM=$$NOW^XLFDT
 S LRFILNM1=AUTYP_"_EXT_NEW_"_$P(LRDTTM,".",1)_"_"_$P(LRDTTM,".",2)_".csv"
 S LRFILNM2=AUTYP_"_EXT_MOD_"_$P(LRDTTM,".",1)_"_"_$P(LRDTTM,".",2)_".csv"
 S @LRHLOTLK@(5)=$S($D(@LRHLARY@("NEW")):"Attached LMOF",1:"No")_" NEW "_AUDES_" Entries"_$S($D(@LRHLARY@("NEW")):": "_LRFILNM1,1:"")_LRCRLF
 S @LRHLOTLK@(6)=" "
 S @LRHLOTLK@(7)=$S($D(@LRHLARY@("OLD")):"Attached LMOF",1:"No")_" MODIFIED "_AUDES_" Entries"_$S($D(@LRHLARY@("OLD")):": "_LRFILNM2,1:"")_LRCRLF
 S:($O(@LRHLARY@(0))="") LRNODATA=1
 S @LRHLOTLK@(8)=" "
 S:(LRNODATA=0) @LRHLOTLK@(9)=" "
 S:(LRNODATA=1) @LRHLOTLK@(9)="No data was extracted for date range!!"
 ;
 ;Begin output of "NEW" entries
 F XSUB="NEW","OLD" D
 . S LRNODE=0,LRSTR="",LROUTNOD=$S(XSUB="NEW":10,XSUB="OLD"&($D(@LRHLARY@("NEW"))):LROUTNOD+4,1:10)
 . I $D(@LRHLARY@(XSUB)) D
 . . S LRFILNM=$S(XSUB="NEW":LRFILNM1,1:LRFILNM2)
 . . S @LRHLOTLK@(LROUTNOD)=$$UUBEGFN(LRFILNM)
 . . F  S LRNODE=$O(@LRHLARY@(XSUB,LRNODE)) Q:(LRNODE)=""  D
 . . . S LRSTR=LRSTR_@LRHLARY@(XSUB,LRNODE)_LRCRLF
 . . . D ENCODE(.LRSTR,.LROUTNOD,LRHLOTLK)
 . . S:(LRSTR'="") @LRHLOTLK@(LROUTNOD+1)=$$UUEN(LRSTR)
 . . S @LRHLOTLK@(LROUTNOD+2)=" "
 . . S @LRHLOTLK@(LROUTNOD+3)="end"
 Q
 ;
UUBEGFN(LRFILENM) ; Construct uuencode "begin" coding
 ; Call with LRFILENM = name of uuencoded file attachment
 ;
 ; Returns LRX = string with "begin..."_file name
 ;
 N LRX
 S LRX="begin 644 "_LRFILENM
 Q LRX
 ;
ENCODE(LRSTR,LRDTANOD,LRHLOTLK) ;Encode a string, keep remainder for next line
 ;INPUT:
 ;  LRSTR     - String to send in message; call by reference, Remainder returned in LRSTR
 ;  LRDTANOD  - Number of next Node to store message line in array
 ;  LRHLOTLK  - Array containing message text for network addresses
 ;
 N LRQUIT,LRLEN,LRX
 S LRQUIT=0,LRLEN=$L(LRSTR)
 F  D  Q:LRQUIT
 . I $L(LRSTR)<45 S LRQUIT=1 Q
 . S LRX=$E(LRSTR,1,45)
 . S LRDTANOD=LRDTANOD+1,@LRHLOTLK@(LRDTANOD)=$$UUEN(LRX)
 . S LRSTR=$E(LRSTR,46,LRLEN)
 Q
 ;
UUEN(STR) ; Uuencode string passed in.
 N J,K,LEN,LRI,LRX,S,TMP,X,Y
 S TMP="",LEN=$L(STR)
 F LRI=1:3:LEN D
 . S LRX=$E(STR,LRI,LRI+2)
 . I $L(LRX)<3 S LRX=LRX_$E("   ",1,3-$L(LRX))
 . S S=$A(LRX,1)*256+$A(LRX,2)*256+$A(LRX,3),Y=""
 . F K=0:1:23 S Y=(S\(2**K)#2)_Y
 . F K=1:6:24 D
 . . S J=$$DEC^XLFUTL($E(Y,K,K+5),2)
 . . S TMP=TMP_$C(J+32)
 S TMP=$C(LEN+32)_TMP
 Q TMP
 ;
 ;
PARAMED(AUTYP,AUDES) ;Edit the Dates referenced by tasked Option "LRJ SYS MAP [autyp] TASKMAN RPT"
 ;where AUTYP=audit type (ex. AUF60 for File 60 audit
 ; This API invokes the Edit Instance and Value of a Parameter API to edit the following
 ; Parameters:
 ;   LRJ LSRP [autyp] LAST START DATE
 ;   LRJ LSRP [autyp] LAST END DATE
 ;   
 ; These parameters control the period that the Audit file extract is performed via the
 ; TaskMan scheduled job for the "LRJ SYS MAP [autyp] TASKMAN RPT" option
 ; 
 W !!,"Lab "_AUDES_" Audit extract dates record the report dates"
 W !," for the last extract created by the LRJ SYS MAP "_AUTYP_" TASKMAN RPT option."
 W !," The LRJ LSRP "_AUTYP_" LAST END DATE is the start date used by the next execution"
 W !," of the LRJ SYS MAP "_AUTYP_" TASKMAN RPT option.",!
 W !!,"WARNING: Editing the LRJ LSRP "_AUTYP_" LAST END DATE will affect the information"
 W !," reported by the LRJ SYS MAP "_AUTYP_" TASKMAN RPT option.  This option makes"
 W !," assumptions about data previously reported based upon this date."
 W !!,"A USER CHANGING THE 'LRJ LSRP "_AUTYP_" LAST END DATE' MUST UNDERSTAND THE RESULT"
 W !," OF THE CHANGE MADE AND RECONCILE THE REPORTS CREATED AGAINST THE PREVIOUS"
 W !," REPORT CREATED!",!!
 ;
 D EDITPAR^XPAREDIT("LRJ LSRP "_AUTYP_" LAST START "_$S(AUTYP["XT":"DT",1:"DATE"))
 W !!,"-------------------------------------------------------------------------------"
 D EDITPAR^XPAREDIT("LRJ LSRP "_AUTYP_" LAST END DATE")
 ;;D EN^XPAREDIT  ;;IA #2336
 Q
