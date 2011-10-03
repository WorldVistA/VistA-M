RCRCEL ;WASH@ALTOONA/LDB/CMS - RCRC TRANSMISISON LOG ; 27-MAR-1998
V ;;4.5;Accounts Receivable;**63**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified
EN ; -- main entry point for RCRC TRANSMISSION LOG
 W !!,?3,"Building Transmission Log list ......."
 D EN^VALM("RCRC TRANSMISSION LOG")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="                         Regional Counsel"
 S VALMHDR(2)="                    Transmission Message Handler"
 I +$G(VALMCNT)=0 S VALMSG="NO MESSAGES FOUND"
 Q
 ;
INIT ; -- init variables and list array
 N RCBN0,RCBN2,RCCNT,RCDATE,RCCOM,RCNT,RCX,RCY,X,Y
 K ^TMP("RCRCE",$J),^TMP("RCRCEX",$J)
 ;
REQ ;Reverse order of entries  entry for Resequenceing
 S RCY=0 F  S RCY=$O(^RCT(349.3,RCY)) Q:'RCY  D
 .S ^TMP("RCRCE",$J,"D",9999999.999999-+$G(^RCT(349.3,RCY,2)),99999999999-RCY)=RCY
 I '$O(^TMP("RCRCE",$J,"D",0)) S VALMCNT=0 G INITQ
 ;
 ;Set "B" to new order
 S (RCDATE,RCCNT)=0 F  S RCDATE=$O(^TMP("RCRCE",$J,"D",RCDATE)) Q:'RCDATE  D
 .S RCX=0 F  S RCX=$O(^TMP("RCRCE",$J,"D",RCDATE,RCX)) Q:'RCX  D
 ..S RCCNT=RCCNT+1
 ..S ^TMP("RCRCE",$J,"B",RCCNT)=^TMP("RCRCE",$J,"D",RCDATE,RCX)
 K ^TMP("RCRCE",$J,"D")
 ;
 ;Set data in TMP
 S (RCCNT,VALMCNT)=0 F  S RCCNT=$O(^TMP("RCRCE",$J,"B",RCCNT)) Q:'RCCNT  D
 .S RCY=^TMP("RCRCE",$J,"B",RCCNT),VALMCNT=VALMCNT+1
 .S RCBN0=$G(^RCT(349.3,+RCY,0)),RCBN2=$G(^RCT(349.3,+RCY,2))
 .S (RCNT,RCX)=0 K RCCOM F  S RCX=$O(^RCT(349.3,+RCY,3,RCX)) Q:'RCX  D
 ..I $G(^RCT(349.3,+RCY,3,RCX,0))]"" S RCNT=RCNT+1,RCCOM(RCNT)=$E(^(0),1,80)
 .S X="",X=$$SETFLD^VALM1(RCCNT,X,"NUMBER")
 .S RCX=$S($P(RCBN0,U,2)]"":$E($P(RCBN0,U,2),1,42),1:"No Subject"),X=$$SETFLD^VALM1(RCX,X,"SUBJECT")
 .S X=$$SETFLD^VALM1(+RCBN0,X,"MM#")
 .S RCX=$$FMTE^XLFDT(+RCBN2,"5ZD"),X=$$SETFLD^VALM1(RCX,X,"DATE")
 .S RCX=$$FMTE^XLFDT(+$G(^RCT(349.3,+RCY,4)),"5ZD"),X=$$SETFLD^VALM1(RCX,X,"PDATE")
 .S ^TMP("RCRCE",$J,VALMCNT,0)=X
 .S ^TMP("RCRCE",$J,"IDX",VALMCNT,RCCNT)=""
 .S ^TMP("RCRCEX",$J,RCCNT)=VALMCNT_U_RCY
 .S VALMCNT=VALMCNT+1
 .S ^TMP("RCRCE",$J,VALMCNT,0)="     Sender: "_$P($G(RCBN0),U,3)_"    Recipient: "_$P($G(RCBN0),U,4)
 .S ^TMP("RCRCE",$J,"IDX",VALMCNT,RCCNT)=""
 .S RCX=0 F  S RCX=$O(RCCOM(RCX)) Q:'RCX  D
 ..S VALMCNT=VALMCNT+1
 ..S ^TMP("RCRCE",$J,VALMCNT,0)=$S(RCX=1:"     Comment: ",1:"     ")_RCCOM(RCX)
 ..S ^TMP("RCRCE",$J,"IDX",VALMCNT,RCCNT)=""
 .D FLDCTRL^VALM10(VALMCNT)
INITQ Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("RCRCE",$J),^TMP("RCRCEX",$J)
 K RCOUT,VALMBCK,VALMSG,VALMCNT
 D CLEAN^VALM10,CLEAR^VALM1
 Q
 ;
EXPND ; -- expand code
 Q
 ;RCRCEL
