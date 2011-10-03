TIUROR1 ;SLC/JER - New PATIENT Review screen ; 12/3/00
 ;;1.0;TEXT INTEGRATION UTILITIES;**100**;Jun 20, 1997
 ; New, created 11/27/00 by splitting TIUROR
 ;
ASKCTXT() ; Ask user for new context
 N TIUY,DIR,Y
 ; newed Y 9/21
 S DIR(0)="SAO^1:SIGNED;2:UNSIGNED;3:UNCOSIGNED;4:AUTHOR;5:DATES"
 S DIR("A")="Select context: ",DIR("A",1)="Valid selections are:"
 S DIR("A",2)="  1 - signed notes (all)   2 - unsigned notes       3 - uncosigned notes"
 S DIR("A",3)="  4 - signed notes/author  5 - signed notes/dates",DIR("A",4)="    "
 S DIR("?",1)="To change which notes are displayed, select the number"
 S DIR("?")="of the context you wish to work within.",DIR("B")="1"
 W ! D ^DIR
 Q +Y
 ;
SAVE ; -- Set aside original list
 K ^TMP("TIURSAVE",$J)
 M ^TMP("TIURSAVE",$J)=^TMP("TIUR",$J)
 M ^TMP("TIURSAVIDX",$J)=^TMP("TIURIDX",$J)
 Q
 ;
RESTORE ; -- restore original All Signed list
 I '$D(^TMP("TIURSAVE",$J)) D  Q
 . D INIT^TIUROR(+$G(^TMP("TIUR",$J,"CLASS")),1,+$G(^("DFN")),9999999)
 . S VALMBCK="R",VALMBG=1,VALMCNT=+$G(^TMP("TIUR",$J,0))
 K ^TMP("TIUR",$J)
 M ^TMP("TIUR",$J)=^TMP("TIURSAVE",$J)
 M ^TMP("TIURIDX",$J)=^TMP("TIURSAVIDX",$J)
 S VALMBCK="R",VALMBG=1,VALMCNT=+$G(^TMP("TIUR",$J,0))
 Q
 ;
BREATHE(ONCE) ; -- Collapse/Re-expand in reverse order to avoid collisions
 N TIUI
 S TIUI=""
 F  S TIUI=$O(^TMP("TIUR",$J,"EXPAND",TIUI),-1) Q:+TIUI'>0  D
 . D EC1^TIURECL(TIUI,1) ; Inhale
 . D:'+$D(ONCE) EC1^TIURECL(TIUI,1) ; Exhale
 . W "."
 Q
 ;
RELOAD(TIUEXP) ; Reload ^TMP("TIUR",$J,"EXPAND") w IFNs to expand, gotten
 ;from previous user expansions.  (Line numbers have changed.)
 N TIUI S TIUI=0
 F  S TIUI=$O(TIUEXP(TIUI)) Q:+TIUI'>0  D
 . N TIUDA,TIUJ
 . S TIUDA=$G(TIUEXP(TIUI)),TIUJ=$O(^TMP("TIUR",$J,"IEN",TIUDA,0)) Q:+TIUJ'>0
 . S ^TMP("TIUR",$J,"EXPAND",TIUJ)=TIUDA_U_1
 Q
 ;
LOAD(TIUXCTXT,TIUXCTX2) ; Load ^TMP("TIUR",$J,"EXPAND") w IFNs to expand,
 ;gotten from doing CONTEXT^TIUSRVLL
 ; These are parent records that must be expanded to display ID kids or
 ;addenda under them that fall within search criteria.
 N TIUDA,LINENO
 S TIUDA=0
 F  S TIUDA=$O(TIUXCTXT(TIUDA)) Q:'TIUDA  D
 . S LINENO=$O(^TMP("TIUR",$J,"IEN",TIUDA,0))
 . I 'LINENO S TIUXCTX2(TIUDA)="" Q
 . S ^TMP("TIUR",$J,"EXPAND",LINENO)=TIUDA_U_1
 Q
