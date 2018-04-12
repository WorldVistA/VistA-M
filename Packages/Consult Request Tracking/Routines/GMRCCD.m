GMRCCD ;SFVAMC/DAD - Consult Closure Tool: Interactive Consult Update ;01/20/17 15:19
 ;;3.0;CONSULT/REQUEST TRACKING;**89**;DEC 27, 1997;Build 62
 ;Consult Closure Tool
 ;
 ; IA#    Usage      Component
 ; ---------------------------   
 ;  4836  Private    $$GET1^DIQ(123.033,GM0CFG,.06,"I")
 ;  3005  Controlled $$GET1^DIQ(123.033,GM0CFG,".03:1","I")
 ; 10040  Supported  $$GET1^DIQ(123.033,GM0CFG,.06
 ;  4072  Controlled $$FIND1^DIC(8925.6
 ;  2051  Supported  $$FIND1^DIC
 ;  2051  Supported  LIST^DIC
 ;  2052  Supported  $$GET1^DID
 ;  2054  Supported  CLEAN^DILF
 ;  2056  Supported  $$GET1^DIQ
 ;  2607  Supported  DOCLIST^DDBR
 ;  2832  Controlled RPC^TIUSRV
 ;  2925  Controlled DT^GMRCSLM2
 ; 10026  Supported  ^DIR
 ; 10086  Supported  HOME^%ZIS
 ; 10096  Supported  ^%ZOSF(
 ;
INTERACT(GMROOT) ;
 ; *** Interactive consult update
 N GM0CON,GM0NOT,GMCCNT,GMCONS,GMCRPT,GMDOCS
 N GMEXIT,GMINDX,GMNAME,GMNCNT,GMNOTE,GMNRPT
 N GMNTXT,GMPCNT,GMTEXT,GMTITL,GMRCOER,GMRCQUT
 D HOME^%ZIS
 S GMDOCS=$NA(@GMROOT@("DOCS-LIST"))
 S GMNRPT=$NA(@GMROOT@("NOTE-TEXT"))
 S GMCRPT=$NA(^TMP("GMRCR",$J,"DT"))
 S GMNOTE=$NA(^TMP("TIUAUDIT",$J))
 D COUNT(GMROOT,.GMPCNT,.GMCCNT,.GMNCNT)
 S GMPCNT(0)=GMPCNT
 S GMCCNT(0)=GMCCNT
 S GMNCNT(0)=GMNCNT
 K GMTEXT
 S GMTEXT(1)="The Consult Closure Tool has identified"
 S GMTEXT(2)="  Patients: "_$J(GMPCNT,4)
 S GMTEXT(3)="  Consults: "_$J(GMCCNT,4)
 S GMTEXT(4)="  Notes:    "_$J(GMNCNT,4)
 S GMTEXT(5)="that meet your selected criteria."
 S GMTEXT(6)=""
 S GMTEXT="Enter RETURN to continue: "
 D HANGMSG(.GMTEXT,$G(DTIME,900),1)
 S GMNAME="",(GMEXIT,GMPCNT,GMCCNT,GMNCNT)=0
 I $O(@GMROOT@("DATA",GMNAME))="" D
 . K GMTEXT S GMTEXT="*** No data found ***"
 . D HANGMSG(.GMTEXT,0,1)
 . Q
 F  S GMNAME=$O(@GMROOT@("DATA",GMNAME)) Q:(GMNAME="")!(GMEXIT>0)  D
 . S GMPCNT=GMPCNT+1
 . S GMCONS=""
 . F  S GMCONS=$O(@GMROOT@("DATA",GMNAME,GMCONS)) Q:(GMCONS="")!(GMEXIT>0)  D
 .. S GMCCNT=GMCCNT+1
 .. K @GMCRPT,@GMDOCS,@GMNRPT
 .. ; Get consult text
 .. S GM0CON=$P(GMCONS,U,2)
 .. S GMRCOER=2
 .. K GMRCQUT
 .. D DT^GMRCSLM2(GM0CON)
 .. I $G(GMRCQUT)'>0 D
 ... S GMTITL="",GMINDX=0
 ... F  S GMTITL=$O(@GMROOT@("DATA",GMNAME,GMCONS,GMTITL)) Q:(GMTITL="")!(GMEXIT>0)  D
 .... S GMNCNT=GMNCNT+1
 .... S GM0NOT=$P(GMTITL,U,3)
 .... ; Build browser doc list
 .... I (GM0CON>0)&(GM0NOT>0) D
 ..... S GMINDX=GMINDX+1
 ..... ; Add consult to doc list
 ..... S GMTEXT="Consult Narrative"
 ..... S GMTEXT=GMTEXT_" ("_GMCCNT_" of "_GMCCNT(0)_")"
 ..... S @GMDOCS@(GMTEXT)=GMCRPT
 ..... ; Get progress note text
 ..... K @GMNOTE
 ..... D RPC^TIUSRV(.GMNOTE,GM0NOT)
 ..... S GMNTXT=$NA(@GMNRPT@(GM0NOT))
 ..... M @GMNTXT=@GMNOTE
 ..... K @GMNOTE
 ..... ; Add progress note to doc list
 ..... S GMTEXT="Note "_$TR($J(GMINDX,2)," ","0")
 ..... S GMTEXT=GMTEXT_": "_$P(GMTITL,U,1)
 ..... S @GMDOCS@(GMTEXT)=GMNTXT
 ..... Q
 .... Q
 ... D SHOWPICK(GMDOCS,GM0CON,.GMEXIT)
 ... Q
 .. K @GMCRPT,@GMDOCS,@GMNRPT
 .. Q
 . Q
 I GMEXIT'>0 D
 . K GMTEXT S GMTEXT="*** Done ***"
 . D HANGMSG(.GMTEXT,0,0)
 . Q
 Q
 ;
SHOWPICK(GMROOT,GM0CON,GMEXIT) ;
 ; *** Show consult & progress notes
 ; *** Pick progress note to close consult
 I $O(@GMROOT@(""))]"" F  D  Q:GMEXIT'="?"
 . D SHOWNOTE(GMROOT,GM0CON)
 . D PICKNOTE(GMROOT,GM0CON,.GMEXIT)
 . Q
 Q
 ;
SHOWNOTE(GMROOT,GM0CON) ;
 ; *** Show consult & progress notes to user
 N GMLINE,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 D HEADER(GM0CON,.GMLINE)
 D FOOTER(IOSL-2)
 D DOCLIST^DDBR(GMROOT,"R",GMLINE+2,IOSL-2)
 Q
 ;
PICKNOTE(GMROOT,GM0CON,GMEXIT) ;
 ; *** Pick progress note to close consult
 N GM0NOT,GMBELL,GMGLOB,GMINDX,GMMAXX
 N GMMSGS,GMTEXT,GMTIME,GMTITL
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ; Build reader doc list
 S DIR("A")="Select NOTE TO CLOSE CONSULT: "
 S DIR("A",1)="Select the note to close the consult"
 S DIR("A",2)=" "
 S DIR("A",3)="  0 - Do not close the consult"
 S GMTITL="Note 00: ",GMINDX=0
 F  S GMTITL=$O(@GMROOT@(GMTITL)) Q:GMTITL=""  D
 . ; The doc list data is a closed global root specifying
 . ; the location of the progress note text block.  The last
 . ; subscript of data root is the IEN of the progress note.
 . ; @GMROOT@(DocumentTitle) = ArrayName(...,ProgressNoteIEN)
 . S GMGLOB=$G(@GMROOT@(GMTITL))
 . S GM0NOT=$QS(GMGLOB,$QL(GMGLOB))
 . I GM0NOT>0 D
 .. S GMINDX=GMINDX+1
 .. S DIR("A",3+GMINDX)=$J(GMINDX,3)_" - "_GMTITL
 .. ; IndexNumber to ProgressNoteIEN^NoteTitle mapping array
 .. S GM0NOT(GMINDX)=GM0NOT_U_GMTITL
 .. Q
 . Q
 S GMMAXX=GMINDX+1
 S DIR("A",3+GMINDX+1)=$J(GMMAXX,3)_" - Redisplay the consult/progress note(s)"
 S DIR("A",3+GMINDX+2)="  ^ - Exit the Consult Closure Tool"
 S DIR("A",3+GMINDX+3)=" "
 S DIR("B")=GMMAXX
 S DIR(0)="NOA^0:"_GMMAXX_":0^K:X'?1.N X"
 S DIR("?")="^D HEADER^GMRCCD(GM0CON)"
 ; Display consult closure prompt screen
 D HEADER(GM0CON)
 W ! D ^DIR S GMINDX=+$G(Y)
 S GMEXIT=$S($$DIREXIT^GMRCCA>0:1,GMINDX=GMMAXX:"?",1:0)
 K GMTEXT S GMTIME=3,GMBELL=0
 I GMEXIT=0 D
 . S GM0NOT=+$P($G(GM0NOT(GMINDX)),U,1)
 . I (GM0CON>0)&(GM0NOT>0) D
 .. ; Attempt to close consult
 .. I $$CONUPDT^GMRCCC(GM0CON,GM0NOT,.GMMSGS)>0 D
 ... S GMTEXT(1)="*** The consult has been closed ***"
 ... S GMTEXT="Selection: "_$P(GM0NOT(GMINDX),U,2)
 ... Q
 .. E  D
 ... S GMTIME=$G(DTIME,900),GMBELL=1
 ... S GMTEXT(1)="*** The consult has NOT been closed ***"
 ... S GMTEXT(2)="Reason: "_$S($G(GMMSGS)]"":GMMSGS,1:"Unknown!")
 ... S GMTEXT(3)="Selection: "_$P(GM0NOT(GMINDX),U,2)
 ... S GMTEXT(4)=""
 ... S GMTEXT="Enter RETURN to continue: "
 ... Q
 .. Q
 . E  D
 .. S GMTEXT="*** No action taken on the consult ***"
 .. Q
 . Q
 E  D
 . I GMEXIT>0 D
 .. S GMTIME=0
 .. S GMTEXT="*** Exiting the Consult Closure Tool ***"
 .. Q
 . Q
 D HANGMSG(.GMTEXT,GMTIME,GMBELL)
 Q
 ;
HEADER(GM0CON,GMLINE) ;
 ; *** Pt name header
 W @IOF,"Consult closure for patient: "
 W $$GET1^DIQ(123,GM0CON,.02)
 W " (",$$GET1^DIQ(123,GM0CON,".02:.0905"),") "
 W $$DATE^GMRCCC($$GET1^DIQ(123,GM0CON,".02:.03","I"),"5DZ")
 W !,$$GET1^DIQ(123,GM0CON,1)
 W " (",$$GET1^DIQ(123,GM0CON,"8:.1"),") "
 W $$DATE^GMRCCC($$GET1^DIQ(123,GM0CON,3,"I"),"5DZ")
 S GMLINE=$Y
 Q
 ;
FOOTER(GMLINE) ;
 ; *** Page footer instructions
 F  Q:$Y'<(GMLINE-1)  W !
 W !,"Use <PF1>S to Switch between views of the consult and progress note(s)"
 W !,"Use R to Return to the previously viewed consult or progress note(s)"
 Q
 ;
HANGMSG(GMTEXT,GMTIME,GMBELL) ;
 ; *** Hang a message on the screen for a time
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 I $G(GMTEXT)]"" D
 . I $G(GMBELL)>0 S GMTEXT=GMTEXT_$C(7)
 . S DIR(0)="EA"
 . M DIR("A")=GMTEXT
 . S (DIR("?"),DIR("??"))=""
 . S DIR("T")=+$G(GMTIME)
 . D TYPEAHED(0)
 . W ! D ^DIR
 . D TYPEAHED(1)
 . Q
 Q
 ;
TYPEAHED(GMBOOL) ;
 ; *** Enable/Disable type-ahead
 N GMKRNL,GMUSER
 I GMBOOL>0 D
 . S GMUSER=$TR($$GET1^DIQ(200,DUZ,200.09,"I"),"YN","10")
 . S GMKRNL=$TR($$GET1^DIQ(8989.3,1,209,"I"),"YN","10")
 . I $S(GMUSER?1N:GMUSER,1:GMKRNL)>0 X ^%ZOSF("TYPE-AHEAD")
 . Q
 E  D
 . X ^%ZOSF("NO-TYPE-AHEAD")
 . Q
 Q
 ;
COUNT(GMROOT,GMPCNT,GMCCNT,GMNCNT) ;
 ; *** Count patients / consults / notes
 N GMCONS,GMNAME,GMTITL,GMUCON,GMUNAM,GMUTTL
 S GMUNAM=$NA(@GMROOT@("UNIQUE-NAME"))
 S GMUCON=$NA(@GMROOT@("UNIQUE-CONS"))
 S GMUTTL=$NA(@GMROOT@("UNIQUE-TITL"))
 K @GMUNAM,@GMUCON,@GMUTTL
 S (GMPCNT,GMCCNT,GMNCNT)=0
 S GMNAME=""
 F  S GMNAME=$O(@GMROOT@("DATA",GMNAME)) Q:GMNAME=""  D
 . I $D(@GMUNAM@(GMNAME))#2'>0 S GMPCNT=GMPCNT+1
 . S @GMUNAM@(GMNAME)=""
 . S GMCONS=""
 . F  S GMCONS=$O(@GMROOT@("DATA",GMNAME,GMCONS)) Q:GMCONS=""  D
 .. I $D(@GMUCON@(GMCONS))#2'>0 S GMCCNT=GMCCNT+1
 .. S @GMUCON@(GMCONS)=""
 .. S GMTITL=""
 .. F  S GMTITL=$O(@GMROOT@("DATA",GMNAME,GMCONS,GMTITL)) Q:GMTITL=""  D
 ... I $D(@GMUTTL@(GMTITL))#2'>0 S GMNCNT=GMNCNT+1
 ... S @GMUTTL@(GMTITL)=""
 ... Q
 .. Q
 . Q
 K @GMUNAM,@GMUCON,@GMUTTL
 Q
 ;
CLINLIST(GMROOT,GM0CFG) ;
 ; *** Get list of clinics
 N GM0CLN,GM0STP,GMINDX,GMLIST,GMSCRN
 S GM0CLN=0
 F  S GM0CLN=$O(^GMR(123.033,GM0CFG,"CLIN","B",GM0CLN)) Q:GM0CLN'>0  D
 . S @GMROOT@("XREF-CLIN",GM0CLN)=""
 . Q
 S GM0STP=$$GET1^DIQ(123.033,GM0CFG,.06,"I")
 I GM0STP>0 D
 . S GMLIST=$NA(^TMP("DILIST",$J))
 . K @GMLIST
 . S GMSCRN="I $P(^(0),U,7)="_GM0STP
 . D LIST^DIC(44,"","@","Q","*","",GM0STP,"AST",GMSCRN)
 . D CLEAN^DILF
 . S GMINDX=0
 . F  S GMINDX=$O(@GMLIST@(2,GMINDX)) Q:GMINDX'>0  D
 .. S GM0CLN=$G(@GMLIST@(2,GMINDX))
 .. I GM0CLN>0 S @GMROOT@("XREF-CLIN",GM0CLN)=""
 .. Q
 . K @GMLIST
 . Q
 Q
 ;
CONSOKAY(GM0CON) ;
 ; *** Consult status okay?
 Q $S("^c^dc^x^"[(U_$$GET1^DIQ(123,GM0CON,"8:.1")_U):0,1:1)
 ;
NOTESTAT(GMSTAT) ;
 ; *** Get list of note statuses
 N GM0STA,GMINDX
 K GMSTAT
 F GMINDX="AMENDED","COMPLETED" D
 . S GM0STA=$$FIND1^DIC(8925.6,"","X",GMINDX,"B")
 . I GM0STA>0 S GMSTAT(GM0STA)=GM0STA_U_GMINDX
 . Q
 Q
 ;
ISTM(GM0CFG) ;
 ; *** Manual patient team associated with configuration?
 Q ($$GET1^DIQ(123.033,GM0CFG,".03:1","I")="TM")
 ;
GLOBROOT(GMFILE,GMTRAN) ;
 ; *** Get file's global root
 N GMROOT
 S GMROOT=$$GET1^DID(GMFILE,"","","GLOBAL NAME")
 Q $S($D(GMTRAN)#2>0:$TR(GMROOT,U,GMTRAN),1:GMROOT)
 ;
SEEN(GMSTAT) ;
 ; *** Pt was seen in clinic?
 Q ("^I^NT^R^"[(U_GMSTAT_U))
 ;
UNSEEN(GMSTAT) ;
 ; *** Pt was not seen in clinic?
 Q ("^CC^CCR^CP^CPR^NS^NSR^"[(U_GMSTAT_U))
