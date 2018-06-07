YTXCHGL ;SLC/KCM - MH Exchange List Manager Calls  ; 08-AUG-2016
 ;;5.01;MENTAL HEALTH;**121**;Dec 30, 1994;Build 61
 ;
EN ; -- main entry point for YTXCHG MAIN
 D EN^VALM("YTXCHG MAIN")
 D FULL^VALM1
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Instrument Exchange File Entries"
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("YTXLST",$J)
 N CNT,NM,DT,IEN,ROW,X0,PKEY
 D OWNSKEY^XUSRB(.PKEY,"XUPROG")
 S CNT=0
 S NM="" F  S NM=$O(^YTT(601.95,"C",NM)) Q:NM=""  D
 . S DT=0 F  S DT=$O(^YTT(601.95,"C",NM,DT)) Q:'DT  D
 . . S IEN=0 F  S IEN=$O(^YTT(601.95,"C",NM,DT,IEN)) Q:'IEN  D
 . . . S X0=^YTT(601.95,IEN,0)
 . . . I 'PKEY(0),$P(X0,U,3)="backup copy" Q  ; screen out backup copies
 . . . S CNT=CNT+1,ROW=""
 . . . S ROW=$$SETFLD^VALM1(CNT,ROW,"ITEM")
 . . . S ROW=$$SETFLD^VALM1($P(X0,U),ROW,"ENTRY")
 . . . S ROW=$$SETFLD^VALM1($P(X0,U,3),ROW,"SOURCE")
 . . . S ROW=$$SETFLD^VALM1($$FMTE^XLFDT($P(X0,U,2),"5Z"),ROW,"CREATED")
 . . . S ^TMP("YTXLST",$J,CNT,0)=ROW
 . . . S ^TMP("YTXLST",$J,"IDX",CNT,IEN)=""
 S VALMCNT=CNT
 Q
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
EXIT ; -- exit code
 Q
EXPND ; -- expand code
 Q
 ;
CREATE ; create new instrument exchange entry
 D FULL^VALM1
 K ^TMP("YTXCHG",$J,"WP",2)
 N TESTS,REC
 D LIST^YTXCHGP(601.71,.TESTS) I TESTS=0 G XREFR
 S REC(.01)=$$PRMTNAME^YTXCHGP("Exchange Name") I '$L(REC(.01)) G XREFR ; name
 S REC(.02)=$$NOW^XLFDT                                                 ; date/time
 S REC(.03)=$P($$GET1^DIQ(200,DUZ,.01),",")_"@"_$P($$SITE^VASITE,U,2)   ; source
 S REC(2)=$NA(^TMP("YTXCHG",$J,"WP",2))                                 ; description
 D EDITWP^YTXCHGP("Enter a description for "_REC(.01),REC(2))
 W !!,"Creating:",?11,REC(.01)
 W !,?11,$$FMTE^XLFDT(REC(.02),"5Z")
 D CREATE^YTXCHG(.TESTS,.REC)
 K ^TMP("YTXCHG",$J,"WP",2)
 D XPAUSE
 Q
REBUILD ; rebuild spec for existing exchange entry (with new date)
 D FULL^VALM1
 N XCHGIEN,INFO,TESTS,I
 S XCHGIEN=$$SELECT() I 'XCHGIEN G XREFR
 K ^TMP("YTXCHG",$J,"WP")
 D INFO^YTXCHG(XCHGIEN,.INFO)
 W !!," Rebuilding:",?14,INFO(.01)
 W !,?14,$$FMTE^XLFDT(INFO(.02),"5Z")
 W !,"Instruments:"
 S I=0 F  S I=$O(INFO("tests",I)) Q:'I  D
 . W ?14,INFO("tests",I),!
 . S TESTS(I)=$O(^YTT(601.71,"B",INFO("tests",I),0))
 K INFO("tests")
 I $$CONFIRM^YTXCHGP("Do you want to continue? ")<1 G XREBUILD
 D DELETE^YTXCHG(XCHGIEN)
 D CREATE^YTXCHG(.TESTS,.INFO)
 D XPAUSE
XREBUILD ; exit REBUILD here
 K ^TMP("YTXCHG",$J,"WP")
 Q
DELETE ; delete instrument exchange entry
 N XCHGIEN,XCHGNM
 S XCHGIEN=$$SELECT() I 'XCHGIEN G XREFR
 S XCHGNM=$P(^YTT(601.95,XCHGIEN,0),U)
 I $$CONFIRM^YTXCHGP("Are you sure you want to delete "_XCHGNM_"? ")<1 G XREFR
 D DELETE^YTXCHG(XCHGIEN)
 D XINIT
 Q
DRYRUN ; Trial install without database changes
 N DRYRUN S DRYRUN=1
 ; drop through to install with DRYRUN set
INSTALL ; Install instrument exchange entry locally
 D FULL^VALM1
 N XCHGIEN,STATS,YTXVRB
 S XCHGIEN=$$SELECT() I 'XCHGIEN G XREFR
 S YTXVRB=$$CONFIRM^YTXCHGP("Use verbose mode? ","No") G:YTXVRB<0 XREFR
 W !!,$S($G(DRYRUN):"Trial ",1:"")_"Installing "_$P(^YTT(601.95,XCHGIEN,0),U)
 I $G(DRYRUN) W !,"*** No database changes will be made. ***",!
 D INSTALL^YTXCHG(XCHGIEN,$G(DRYRUN))
 D XPAUSE
 Q
BROWSE ; Browse instrument specification
 D FULL^VALM1
 N XCHGIEN,NUM,NAME
 S XCHGIEN=$$SELECT() I 'XCHGIEN G XREFR
 K ^TMP("YTXCHG",$J,"TREE")
 K ^TMP("YTXCHG",$J,"BROWSE")
 D SPEC2TR^YTXCHGT(XCHGIEN,$NA(^TMP("YTXCHG",$J,"TREE")))
 S NUM=$$PICKTEST^YTXCHGP($NA(^TMP("YTXCHG",$J,"TREE"))) I 'NUM G XREFR
 S NAME=^TMP("YTXCHG",$J,"TREE","test",NUM,"info","name")_" Specification"
 D BLDVIEW^YTXCHG($NA(^TMP("YTXCHG",$J,"TREE","test",NUM)),$NA(^TMP("YTXCHG",$J,"BROWSE")))
 D BROWSE^DDBR($NA(^TMP("YTXCHG",$J,"BROWSE")),"NR",NAME)
 K ^TMP("YTXCHG",$J,"TREE")
 K ^TMP("YTXCHG",$J,"BROWSE")
 D XREFR
 Q
SAVEHOST ; Save exchange entry to host file
 N XCHGIEN,FULLNM,OK
 S XCHGIEN=$$SELECT() I 'XCHGIEN G XREFR
 I $D(^YTT(601.95,XCHGIEN,1))'>1 W !,"No data to save." G XREFR
 S FULLNM=$$PRMTNAME^YTXCHGP("Enter file name","Enter full path and filename.",245)
 I '$L(FULLNM) G XREFR
 S OK=$$SAVEHFS^YTXCHG(XCHGIEN,FULLNM)
 W !,$S(OK:"File saved.",1:"Save failed.")
 D XPAUSE
 Q
LOADHOST ; Load exchange entry from host file
 D FULL^VALM1
 K ^TMP("YTXCHG",$J,"WP")
 N FULLNM,XCHGREC
 S FULLNM=$$PRMTNAME^YTXCHGP("Enter file name","Enter full path and filename.",245)
 I '$L(FULLNM) G XREFR
 D LOADFILE^YTXCHG(FULLNM,.XCHGREC) I $G(XCHGREC)=-1 G XLOADHST
 D LOAD2FM(.XCHGREC)
XLOADHST ; exit LOADHOST here
 D XPAUSE
 K ^TMP("YTXCHG",$J,"WP")
 Q
LOADURL ; Load exchange entry from URL
 D FULL^VALM1
 K ^TMP("YTXCHG",$J,"WP")
 N URL,XCHGREC
 S URL=$$PRMTNAME^YTXCHGP("Enter the URL","Enter the full URL of the desired file.",245)
 S URL=$$LOW^XLFSTR(URL)
 I '$L(URL) G XREFR
 I $E(URL,1,5)'="http:" W !,"Only HTTP is currently supported." G XREFR
 D LOADFILE^YTXCHG(URL,.XCHGREC) I $G(XCHGREC)=-1 G XLOADURL
 D LOAD2FM(.XCHGREC)
XLOADURL ; exit LOADURL here
 D XPAUSE
 K ^TMP("YTXCHG",$J,"WP")
 Q
LOAD2FM(XCHGREC) ; confirm and load into Fileman entry (file 601.95)
 N I,REPLACE,XCHGIEN
 I '$L($G(XCHGREC(.01)))!'$L($G(XCHGREC(.02))) W !,"File is wrong format." QUIT
 W !
 W !,"This will load:  "_XCHGREC(.01)
 W !,"    created on:  "_$$FMTE^XLFDT(XCHGREC(.02),"5Z")
 W !,"        source:  "_XCHGREC(.03)
 W !,"Description ---"
 S I=0 F  S I=$O(^TMP("YTXCHG",$J,"WP",2,I)) Q:'I  W !,?3,^TMP("YTXCHG",$J,"WP",2,I,0)
 S REPLACE=$D(^YTT(601.95,"C",XCHGREC(.01),XCHGREC(.02)))
 I REPLACE W !!,">>> This will OVERWRITE the current entry!"
 I '$$CONFIRM^YTXCHGP("Do you want to continue? ",$S(REPLACE:"No",1:"Yes")) QUIT
 I REPLACE D
 . S XCHGIEN=$O(^YTT(601.95,"C",XCHGREC(.01),XCHGREC(.02),0))
 . D FMUPD^YTXCHGU(601.95,.XCHGREC,.XCHGIEN)
 E  D FMADD^YTXCHGU(601.95,.XCHGREC,.XCHGIEN)
 W !,$P(^YTT(601.95,XCHGIEN,0),U)_" loaded."
 Q
 ;
XINIT ; exit back to LM, update listing
 D INIT S VALMBCK="R"
 Q
XPAUSE ; exit back to LM, pause first
 D PAUSE^YTXCHGP
 D INIT S VALMBCK="R"
 Q
XREFR ; exit back to LM, refresh screen only
 S VALMBCK="R"
 Q
 ;
SELECT() ; return IEN for selection from list
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,IEN
 S DIR(0)="N^1:"_VALMCNT_":0"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) Q 0
 I 'Y Q 0
 S IEN=$O(@VALMAR@("IDX",+Y,""))
 Q IEN
 ;
