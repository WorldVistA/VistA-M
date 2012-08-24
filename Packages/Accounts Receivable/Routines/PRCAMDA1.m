PRCAMDA1 ;ALB/TAZ - PRCA MDA WORKLIST SCREEN ;18-APR-2011
 ;;4.5;Accounts Receivable;**275**;Mar 20, 1995;Build 72
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;DBIA #3820
 ;
EN ; -- main entry point for MDA Worklist
 N PRCAEDT,PRCASDT,PRCASORT,PRCAQUIT,PRCASDV
 N VALMBCK,VALMCNT,VALMHDR,VALMQUIT
 D EN^VALM("PRCA MDA WORKLIST")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Part A Inpatient"
 S VALMHDR(2)=""
 Q
 ;
INIT ; -- init variables and list array
 N DIC,DIRUT,DIROUT,DTOUT,DUOUT,X,Y,DIR,LN,PRCADIV
 K ^TMP("PRCAMDA",$J),^TMP($J,"PRCAMDA")
 S PRCAQUIT=0
 ;
 D DIV(.PRCASDV) ;Build list of Divisions (or all divisions)
 I PRCAQUIT=1 S VALMQUIT="" G INITQ
 ;
 D DTR(.PRCASDT,.PRCAEDT) ;Get Worklist Dates
 I PRCAQUIT=1 S VALMQUIT="" G INITQ
 ;
 D SORT(.PRCASORT) ;Get Worklist Sort Direction
 I PRCAQUIT=1 S VALMQUIT="" G INITQ
 ;
 D BLD ;Build Arrays
 ;
INITQ ;
 Q
 ;
BLD ; -- Build the Arrays
 ;Build the DIV array
 K ^TMP($J,"PRCAMDA","DIV")
 S PRCAIEN=""
 F  S PRCAIEN=$O(^PRCA(436.1,"AMDA",1,PRCAIEN),PRCASORT) Q:'PRCAIEN  D
 . N PRCARDT,PRCAOK
 . S PRCARDT=$$GET1^DIQ(436.1,PRCAIEN_", ",.1,"I") I PRCARDT>PRCAEDT!(PRCARDT<PRCASDT) Q  ;Not in Date Range
 . S PRCADIV=$$GET1^DIQ(436.1,PRCAIEN_", ",1.03,"I") I 'PRCADIV S PRCADIV="99999"
 . I PRCASDV,'$D(^TMP($J,"PRCAMDA","DIV",PRCADIV)) Q  ; Not a selected division
 . S ^TMP($J,"PRCAMDA","DIV",PRCADIV,PRCAIEN)=""
 ;
 ; Build the List Array.
 S PRCADIV="",(LN,VALMCNT)=0
 F  S PRCADIV=$O(^TMP($J,"PRCAMDA","DIV",PRCADIV)) Q:'PRCADIV  D
 . D SET("Division: "_$S(PRCADIV=99999:"Unknown",1:$P(^DG(40.8,PRCADIV,0),U,1)),LN+1)
 . S PRCAIEN=""
 . F  S PRCAIEN=$O(^TMP($J,"PRCAMDA","DIV",PRCADIV,PRCAIEN)) Q:'PRCAIEN  D
 .. N PRCABN,PRCAFN,PRCAPN,PRCARS,LINEVAR
 .. S PRCABN=$$GET1^DIQ(436.1,PRCAIEN_", ",.01,"I"),PRCAPN="Unknown Patient"
 .. S PRCAFN=$$GET1^DIQ(436.1,PRCAIEN_", ",1.01,"I") I PRCAFN S PRCAPN=$$GET1^DIQ(399,PRCAFN_", ",.02,"E") ;DBIA #3820
 .. S PRCARS=$$GET1^DIQ(436.1,PRCAIEN_", ",1.02,"I")=1 ;Only place asterisk on REVIEW IN PROCESS entries.
 .. S LINEVAR=""
 .. S LN=LN+1
 .. S LINEVAR=$$SETFLD^VALM1(LN,LINEVAR,"NUMBER")
 .. S LINEVAR=$$SETFLD^VALM1(PRCABN,LINEVAR,"BILL")
 .. I PRCARS S LINEVAR=$$SETSTR^VALM1("*",LINEVAR,15,15)
 .. S LINEVAR=$$SETFLD^VALM1(PRCAPN,LINEVAR,"PTNAME")
 .. S LINEVAR=$$SETFLD^VALM1($$GET1^DIQ(436.1,PRCAIEN_", ",.03,"I"),LINEVAR,"SUBID")
 .. S LINEVAR=$$SETFLD^VALM1(" "_$P($$FMTE^XLFDT($$GET1^DIQ(436.1,PRCAIEN_", ",.08,"I"),"7D"),"/",1),LINEVAR,"SYEAR")
 .. S LINEVAR=$$SETFLD^VALM1(" "_$P($$FMTE^XLFDT($$GET1^DIQ(436.1,PRCAIEN_", ",.09,"I"),"7D"),"/",1),LINEVAR,"EYEAR")
 .. S LINEVAR=$$SETFLD^VALM1($J($$GET1^DIQ(436.1,PRCAIEN_", ",.06,"I"),6),LINEVAR,"DEDSUB")
 .. S LINEVAR=$$SETFLD^VALM1($J($$GET1^DIQ(436.1,PRCAIEN_", ",.07,"I"),6),LINEVAR,"DEDAVL")
 .. S LINEVAR=$$SETFLD^VALM1($J($$FMTE^XLFDT($$GET1^DIQ(436.1,PRCAIEN_", ",.1,"I"),"2DZ"),8),LINEVAR,"RPTDT")
 .. D SET(LINEVAR,LN,PRCAIEN)
BLDQ ;
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("PRCAMDA",$J),^TMP($J,"PRCAMDA","DIV")
 D CLEAN^VALM10
 Q
 ;
 ;Output:
 ;^TMP($J,"PRCAMDA","DIV",<div>) - List of selected divisions
 ;PRCASDV - Selected division switch - 1 = Divisions selected, 0 = all divisions
DIV(PRCASDV) ; Get Division
 N DIC,Y,PRCA1ST
 K ^TMP($J,"PRCAMDA","DIV")
 S PRCA1ST=1
 F  D  Q:(Y<0)!PRCAQUIT
 . S DIC="^DG(40.8,",DIC(0)="AEQMN",DIC("A")="Select "_$S(PRCA1ST:"",1:" Another ")_"Division: "_$S(PRCA1ST:"All Divisions// ",1:"")
 . D ^DIC
 . K DIC
 . I Y<0 W:PRCA1ST " All Divisions" S PRCASDV=0 Q
 . I $D(DTOUT)!$D(DUOUT) S PRCAQUIT=1 Q
 . S ^TMP($J,"PRCAMDA","DIV",+Y)="",PRCA1ST=0
 ;
DIVX ;
 Q
 ;
 ;Output:
 ;PRCASDT - Worklist Earliest Report Date
 ;PRCAEDT - Worklist Latest Report Date
 ;
DTR(PRCASDT,PRCAEDT) ;date range
 N %DT,DTOUT,DUOUT,X,Y
 S %DT="AEX"
 S %DT("A")="Select Earliest Report Date: ",%DT("B")="TODAY-7"
 W ! D ^%DT ;K %DT
 I $D(DTOUT)!$D(DUOUT)!(Y<0) S PRCAQUIT=1 G DTRX
 S PRCASDT=+Y
 S %DT="AEX"
 S %DT("A")="Select Latest Report Date: ",%DT("B")="TODAY"
 D ^%DT ;K %DT
 I $D(DTOUT)!$D(DUOUT)!(Y<0) S PRCAQUIT=1 G DTRX
 S PRCAEDT=+Y
 ;
DTRX ;
 Q
 ;
 ;Output:
 ;PRCASORT - Direction of report entries.
 ;
SORT(PRCASORT) ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^1:Earliest Report Date;2:Latest Report Date"
 S DIR("A")="Sort Report By: "
 S DIR("B")="Latest Report Date"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y<0) S PRCAQUIT=1 G SORTX
 S PRCASORT=$S(Y=2:"-1",1:"+1")
 ;
SORTX ;
 Q
 ;
SET(X,CNT,PRCAIEN) ;set up list manager screen array
 S VALMCNT=VALMCNT+1
 S ^TMP("PRCAMDA",$J,VALMCNT,0)=X
 S ^TMP("PRCAMDA",$J,"IDX",VALMCNT,CNT)=""
 I $G(PRCAIEN),$G(^TMP("PRCAMDA",$J,CNT))="" S ^TMP("PRCAMDA",$J,CNT)=VALMCNT_U_PRCAIEN
 Q
 ;
EXP ; -- expand code to show additional details of the EOB record
 S VALMBCK="R"
 Q
 ;
