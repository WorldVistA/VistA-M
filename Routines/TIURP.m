TIURP ; SLC/JER - List problems for linking ;9/12/00  11:52
 ;;1.0;TEXT INTEGRATION UTILITIES;**78**;Jun 20, 1997
MAIN ; Control branching
 N TIUPL,TIUI
 D ACTIVE^GMPLUTL(DFN,.TIUPL)
 I +$G(TIUPL(0))'>0 D NOPROBLM Q
 D CLEAN^VALM10,BUILD(.TIUPL)
 Q
NOPROBLM ; Handle empty list
 S ^TMP("TIURP",$J,0)=0
 S ^TMP("TIURP",$J,1,0)=""
 S ^TMP("TIURP",$J,2,0)="No active problems."
 Q
BUILD(TIUPL) ; Build list
 N TIUI,TIUPICK S (TIUI,VALMCNT)=0
 S TIUPICK=+$O(^ORD(101,"B","TIU ACTION SELECT LIST ELEMENT",0))
 F  S TIUI=$O(TIUPL(TIUI)) Q:+TIUI'>0  D
 . N PRBLM,DATE,STATUS,ICD9,LINE S LINE=""
 . S PRBLM=$$MIXED^TIULS($P($G(TIUPL(TIUI,1)),U,2))
 . S ICD9="("_$P($G(TIUPL(TIUI,2)),U,2)_")"
 . S DATE=$$DATE^TIULS($P($G(TIUPL(TIUI,3)),U),"MM/DD/YY")
 . ;S STATUS=$S($P($G(TIUPL(TIUI,6)),U)="A":" ",1:"i")
 . S STATUS=$S($$DUPROB^TIURB1(TIUDA,$G(TIUPL(TIUI,0)))=1:"L",1:"")
 . S LINE=$$SETFLD^VALM1(TIUI,LINE,"NUMBER")
 . S LINE=$$SETFLD^VALM1(STATUS,LINE,"STATUS")
 . S LINE=$$SETFLD^VALM1(PRBLM,LINE,"PROBLEM")
 . S LINE=$$SETFLD^VALM1(ICD9,LINE,"ICD9")
 . S LINE=$$SETFLD^VALM1(DATE,LINE,"DATE")
 . S VALMCNT=VALMCNT+1
 . S ^TMP("TIURP",$J,TIUI,0)=LINE
 . S ^TMP("TIURP",$J,"IDX",VALMCNT,TIUI)="" W:'TIUI#5 "."
 . S ^TMP("TIURPIDX",$J,TIUI)=TIUI_U_+$G(TIUPL(TIUI,0))_U_U_+$G(TIUPL(TIUI,1))_U_$P($G(TIUPL(TIUI,1)),U,2)_U_+$G(TIUPL(TIUI,2))
 . S ^TMP("TIURP",$J,"#")=TIUPICK_"^1:"_VALMCNT
 . D FLDCTRL^VALM10(TIUI,"NUMBER",IOINHI,IOINORM)
 S ^TMP("TIURP",$J,0)=VALMCNT
 Q
HDR ; header code
 N TIUPCNT,TIUID,TIUAGE,TIUDOB,TIUWT,HDR
 S TIUID=$G(VADM(1))_"   "_VA("PID")
 S TIUDOB=$P($G(VADM(3)),U,2),TIUAGE="("_+$G(VADM(4))_")"
 S TIUWT="Wt (lb): "_"   "
 S TIUPCNT=$J(+$G(^TMP("TIURP",$J,0)),4)_" active problems"
 S HDR=$$SETSTR^VALM1(TIUID,$G(HDR),1,38)
 S HDR=$$SETSTR^VALM1(TIUDOB,$G(HDR),50,11)
 S HDR=$$SETSTR^VALM1(TIUAGE,$G(HDR),63,$L(TIUAGE))
 S HDR=$$SETSTR^VALM1(TIUWT,$G(HDR),68,12)
 S VALMHDR(1)=HDR
 ;S VALMHDR(1)=$$SETSTR^VALM1(TIUPCNT,VALMHDR(1),(IOM-$L(TIUPCNT)),$L(TIUPCNT))
 Q
 ;
HELP ; -- help code
 N X
 W !!?4,"To update the problem list first select from Add, Remove, Edit,"
 W !?4 W:GMPARAM("VER") "Verify, "
 W "Inactivate, or Comment, then enter the problem number(s)."
 W !?4,"If you need more information on a problem, select Detailed"
 W !?4,"Display; to change whether all or only selected problems for this"
 W !?4,"patient are listed, choose Select View.  Enter ?? to see more"
 W !?4,"actions for facilitating navigation of the list."
 W !?4,"Problem statuses:  * - Acute   I - Inactive"
 W:GMPARAM("VER") "   $ - Unverified"
 W !!,"Press <return> to continue ... " R X:DTIME
 S VALMSG=$$MSG^GMPLX,VALMBCK=$S(VALMCC:"",1:"R")
 Q
EXIT ; Joel, clean up your mess!
 K ^TMP("TIURP",$J),^TMP("TIURPIDX",$J)
 K XQORM("KEY","="),XQORM("XLATE")
 Q
