TIUHL7A ; SLC/AJB - TIUHL7 Msg Mgr ; 10OCT05
 ;;1.0;TEXT INTEGRATION UTILITIES;**200,228**;Jun 20, 1997
 Q
DELETE ;
 D FULL^VALM1
 W ! I $$READ^TIUU("Y","Are you sure you wish to delete this message") D
 . K ^XTMP("TIUHL7",$P(TIUMSG(TIUSEL),U,2),$P(TIUMSG(TIUSEL),U))
 . W !!,"Message deleted."
 W ! I $$READ^TIUU("EA","Press <RETURN> to continue")
 Q
REPROC ;
 N HL771RF,HL771SF,HLCS,HLDOM,HLINSTN,HLPARAM,HLPID,HLREC,HLRFREQ,HLSFREQ
 D FULL^VALM1
 W !!,"Reprocessing message..."
 I '$$REPROC^HLUTIL($P(TIUMSG(TIUSEL),U),"PROCMSG^TIUHL7P1") W !,"finished.",! I $$READ^TIUU("EA","Press <RETURN> to continue") Q
 W "ERROR.  Unable to reprocess this message.",!
 I $$READ^TIUU("EA","Press <RETURN> to continue")
 Q
EN ; main entry point for TIUHL7 MSG VIEW
 N TIULVL
 D EN^VALM("TIUHL7 MSG VIEW")
 K ^TMP("VALMAR",$J,TIULVL)
 Q
HDR ;
 Q
INIT ;
 N TIULINE,TIUX
 S TIULVL=VALMEVL,VALMCNT=0
 F TIUX="MSGRESULT","MSG" D
 . N TIUCNT,TIUTEXT,TIUVAL S TIUVAL=80 ; TIUVAL is column width for display in LM - each line will be <=TIUVAL
 . S TIULINE="" F  S TIULINE=$O(^XTMP("TIUHL7",$P(TIUMSG(TIUSEL),U,2),$P(TIUMSG(TIUSEL),U),TIUX,TIULINE)) Q:'+TIULINE  D
 . . S TIUTEXT=^XTMP("TIUHL7",$P(TIUMSG(TIUSEL),U,2),$P(TIUMSG(TIUSEL),U),TIUX,TIULINE)
 . . F TIUCNT=1:1:(($L(TIUTEXT)\TIUVAL)+1) S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,$E(TIUTEXT,(TIUVAL*(TIUCNT-1)+1),(TIUVAL*TIUCNT)))
 . S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,"")
 Q
HELP ; help code
 I X="?" S POP=1
 D FULL^VALM1
 W !!,"The following actions are available:"
 W !!,"Delete Message    - Delete the current message"
 W !,"Reprocess Message - Reprocess the current message",!
 I +$G(POP) I $$READ^TIUU("EA","Press <RETURN> to continue")
 S VALMBCK="R",POP=0
 Q
EXIT ; exit code
 Q
EXPND ; expand code
 Q
