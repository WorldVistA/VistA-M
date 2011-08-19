TIUFC ; SLC/MAM - LM Template C (Create DDEF) INIT, Action NEXT LEVEL ;4/28/97  21:46
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
EN ; -- main entry point for LM Template TIUFC CREATE DDEF
 ; Requires TIUFWHO, set in options TIUFC CREATE DDEFS MGR/NATL
 ; TIUFCBEG is used to set message bar msgs:
 ; TIUFCBEG = 1 if done EN, no more, not even Start Over.
 ;            0 if Selected any action
 ; C in TIUFCDA,TIUFDITM,TIUFCNM,TIUFCTYP,TIUFCTDA,TIUFCLPS stands for 
 ;Current Position, the highlighted line.
 N TIUF,TIUFCMSG,CREATEDA,CREATENM,TIUFCONE,TIUFCBEG,TIUFCDA,TIUFCITM,TIUFCNM,TIUFTMPL,TIUFCTYP,TIUFCTDA,TIUFCLPS,TIUFVCN1,XQORM,TIUFXNOD,TIUFLFT
 S TIUFTMPL="C",TIUFCLPS=0
 N TIUFPRIV D SETUP^TIUFL S:$D(DTOUT) VALMQUIT=1 G:$G(VALMQUIT) ENX
 S TIUFCBEG=1
 I "NM"[TIUFWHO D EN^VALM("TIUFC CREATE DDEFS MGR")
ENX Q
 ;
HDR ; -- header code
 S VALMHDR(1)=$$CENTER^TIUFL("BASICS",79)
 Q
 ;
HEADER ; Header field of Protocol TIUFC ACTION MENU.
 N DEFAULT
 I $G(TIUFCONE) S TIUFCBEG=0 ;used in $$vmsg
 I '$G(TIUFCONE) S TIUFCONE=1
 S VALMSG=$$VMSG^TIUFL
 D SHOW^VALM
 S TIUFCITM=$$HASITEMS^TIUFLF1(TIUFCDA) ;Update since items could have been deleted
 S DEFAULT=$S($G(TIUFCTYP)="CL"&'$G(TIUFCITM):"Class/DocumentClass",$G(TIUFCTYP)="CL":"Next Level",$G(TIUFCTYP)="DC":"Title",$G(TIUFCTYP)="TL":"Component",$G(TIUFCTYP)='"CO":"Next Level",1:"")
 S XQORM("B")=$S(VALMCNT'>(VALMBG+VALM("LINES")-1):DEFAULT,1:"Next Screen")
 Q
 ;
INIT ; -- init variables and list array
 D INIT^TIUFH I $D(DTOUT) G INITX
 S TIUFCDA=^TMP("TIUF",$J,"CLINDOC") ;IFN of Current Position in Hier
 S TIUFCNM="CLINICAL DOCUMENTS",TIUFCITM=$$HASITEMS^TIUFLF1(TIUFCDA),TIUFCTYP="CL"
 K TIUFCMSG
 S VALMBG=1
 S TIUFCMSG(1)=" To create a new CLINICAL DOCUMENTS, Select Class/DocumentClass; or to Go Down a"
 I VALMCNT'>VALM("LINES") S TIUFCMSG(2)="Level, Select NEXT LEVEL." G INITX
 I VALMCNT>VALM("LINES") S TIUFCMSG(2)="Level, Screen to (+/-) Desired CLINICAL DOCUMENTS Item, and Select NEXT LEVEL."
INITX I $D(DTOUT) S VALMQUIT=1
 Q
 ;
NEXT ; TEMPLATE C Action Next Level: Navigate hierarchy.
 ; Called by Protocol TIUFC ACTION NEXT LEVEL
 ; Requires TIUFI,TIUFCNM,TIUFCDA,TIUFCITM
 N LINENO,INFO,BEG,END,XPDLCNT,DIR,X,Y,NODE0,LINENO,IINFO,NMWIDTH,TIUFY
 N MISSITEM,TIUFXNOD,XFLG,IFILEDA,DTOUT,DIRUT,DIROUT,ILINE
 S VALMBCK="",TIUFXNOD=$G(XQORNOD(0))
 S LINENO=$O(^TMP("TIUF1IDX",$J,"DAF",TIUFCDA,""))
 S INFO=^TMP("TIUF1IDX",$J,LINENO),XPDLCNT=$P(INFO,U,3)
 S BEG=(LINENO+1),END=LINENO+XPDLCNT
 I TIUFCTYP="TL" W !!," You are already at the bottom Level.  To create Components, enter Component,",!,"or to create Subcomponents, select Detailed Display for the Component, then",!,"edit Items of Component.",! D PAUSE^TIUFXHLX G NEXTX
 I 'TIUFCITM W !!," No Items: You must Create Items at this level before going down a level.",! D PAUSE^TIUFXHLX G NEXTX
 S TIUFY=+$P($P(TIUFXNOD,U,4),"=",2) I TIUFY'<BEG,TIUFY'>END,$D(^TMP("TIUF1IDX",$J,TIUFY)) G POSTSEL
 K TIUFY
 S DIR(0)="NA^"_BEG_":"_END_":0"
 S DIR("?",1)=" Your Current Position in the Hierarchy is "_TIUFCNM_"."
 S DIR("?",2)="You have chosen to go down another level.  This means you must select an Item"
 S DIR("?")="of "_TIUFCNM_", Line "_BEG_"-"_END_"."
 I TIUFCITM S DIR("A")=" Select "_TIUFCNM_" Item (Line "_BEG_"-"_END_"): " D ^DIR S TIUFY=Y K DIR,X,Y I 'TIUFY G NEXTX
POSTSEL S VALMBCK="R"
 S IINFO=^TMP("TIUF1IDX",$J,TIUFY),TIUFCDA=$P(IINFO,U,2),TIUFCTDA=$P(IINFO,U,6)
 S ILINE=^TMP("TIUF1",$J,TIUFY,0)
 S NODE0=^TIU(8925.1,TIUFCDA,0),TIUFCTYP=$P(NODE0,U,4) S:TIUFCTYP="DOC" TIUFCTYP="TL"
 I TIUFCTYP="" W !!," Entry has no Type.  Can't select entry",! D PAUSE^TIUFXHLX G NEXTX
 S TIUFCNM=$P(NODE0,U) I $L(TIUFCNM)>30 S TIUFCNM=$E(TIUFCNM,1,30)
 K TIUFCMSG
 D PARSE^TIUFLLM(.INFO)
 S VALMCNT=VALMCNT-XPDLCNT D COLLAPSE^TIUFH1(.INFO) S TIUFCLPS=1
 ; Has already been expanded; so items exist in file:
 S LINENO=+INFO+1
 D CEXPAND1 S VALMCNT=VALMCNT+1,TIUFCLPS=0
 D CNTRL^VALM10(LINENO-1,8,^TMP("TIUF",$J,"NMWIDTH"),IOINORM,IOINORM)
 D CNTRL^VALM10(LINENO,8,^TMP("TIUF",$J,"NMWIDTH"),IOINHI,IOINORM)
 D PARSE^TIUFLLM(.IINFO)
 S IFILEDA=$P(IINFO,U,2),MISSITEM=$$MISSITEM^TIUFLF4(IFILEDA)
 I MISSITEM W !!," Corrupt Database: File Entry "_IFILEDA_" Has Nonexistent Item "_MISSITEM_" ; See IRM",! D PAUSE^TIUFXHLX S VALMBCK="" G NEXTX
 D EXPAND1^TIUFH1(.IINFO)
 S VALMCNT=VALMCNT+IINFO("XPDLCNT")
 S VALMBG=+INFO
 S TIUFCITM=$S($P(IINFO,U,3):1,1:0)
 I TIUFCTYP="TL" S TIUFCMSG(1)=" You have reached the bottom of the tree.  Select COMPONENT to create a",TIUFCMSG(2)="Component of "_TIUFCNM_".  (SubComponents are created using Detailed Display",TIUFCMSG(3)="and then Item.)" G NEXTX
 S TIUFCMSG(1)=" Select "_$S(TIUFCTYP="DC":"TITLE",1:"CLASS/DOCUMENTCLASS")_" to create a new "_TIUFCNM
 S TIUFCMSG(2)="or to Go Down a Level, Select NEXT LEVEL."
 I VALMCNT>VALM("LINES") S TIUFCMSG(2)="or to Go Down a Level, Screen to (+/-) Desired ",TIUFCMSG(3)=TIUFCNM_" Item, and Select NEXT LEVEL."
NEXTX I $D(DTOUT) S VALMBCK="Q"
 Q
 ;
CEXPAND1 ; Set selected Next Level item of current branch into LM array (i.e. expands current branch to include next level. DOESN'T Update INFO.
 S $P(ILINE," ")=LINENO_$S($L(LINENO)<$L(+IINFO):" ",1:"")
 S ^TMP("TIUF1",$J,LINENO,0)=ILINE
 S $P(IINFO,U)=LINENO,^TMP("TIUF1IDX",$J,LINENO)=IINFO
 S ^TMP("TIUF1",$J,"IDX",LINENO,LINENO)=""
 S ^TMP("TIUF1IDX",$J,"DAF",TIUFCDA,LINENO)=""
 S $P(^TMP("TIUF1IDX",$J,+INFO),U,3)=1
 Q
 ;
EXIT ; -- exit code
 K ^TMP("TIUF1",$J),^TMP("TIUFB",$J),^TMP("TIUF1IDX",$J),^TMP("TIUFBIDX",$J),^TMP("TIUF",$J),IOELALL
 D CLEAN^VALM10
 Q
 ;
