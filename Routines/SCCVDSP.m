SCCVDSP ; ALB/TMP - SCHED VSTS CONVERT/ARCHIVE - TEMPLATE LISTS ; 25-NOV-97
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
BLD(SCCVTYP) ; -- build list of template entries
 ; SCCVTYP = 'AST or 'CST' for type of template
 ;
 K ^TMP("SCCV."_SCCVTYP,$J),^TMP("SCCV."_SCCVTYP_".DX",$J)
 N SCCVFL,SCCVFIL,SCCVTMP,SCCV0,SCCV1,SCCVCT,SCCVDT,SCCVLDT,SCCVGAP,SCCVX
 N SCCV1ST,SCCVCAN
 S (SCCVCT,VALMCNT)=0,SCCVSCRN=1
 S SCCVFIL=$S(SCCVTYP="CST":404.98,1:404.99)
 S SCCVCAN=+$P($G(^SD(404.91,1,"CNV")),U,9)
 ;
 ; -- find all templates
 S SCCVFL="^SD("_SCCVFIL_")"
 ;
 S SCCV1ST=1
 S SCCVGAP=" "
 S SCCVDT=0,SCCVLDT=+$G(^SD(404.91,1,"CNV"))
 ;
 F  S SCCVDT=$O(@SCCVFL@("C",SCCVDT)) Q:'SCCVDT  D
 . S SCCVTMP=0 F  S SCCVTMP=$O(@SCCVFL@("C",SCCVDT,SCCVTMP)) Q:'SCCVTMP  S SCCV0=$G(@SCCVFL@(SCCVTMP,0)),SCCV1=$G(^(1)) D
 . . ; if cancelled and should be listed ... list last
 . . I $P(SCCV0,U,9) S:SCCVCAN SCCVX(SCCVDT,SCCVTMP)="" Q
 . . ;
 . . ; -- Check for gaps
 . . I 'SCCV1ST D  ;Chk for date gaps between templates
 . . . S SCCVGAP=$S($$FMADD^XLFDT(SCCVLDT,1)=SCCVDT:" ",1:"*")
 . . . S SCCVLDT=$P(SCCV0,U,4)
 . . ;
 . . I SCCV1ST D  ;Chk for gaps from selected start dt to 1st date
 . . . IF SCCVDT<SCCVLDT S SCCVGAP=" " Q
 . . . S SCCV1ST=0
 . . . S SCCVGAP=$S(SCCVLDT'=SCCVDT:"*",1:" ")
 . . . S SCCVLDT=$P(SCCV0,U,4)
 . . ;
 . . D ADDLIST(.SCCVCT,SCCV0,SCCV1,SCCVGAP,SCCVTMP)
 ;
 ; Now add any canceled templates
 S SCCVDT=0
 F  S SCCVDT=$O(SCCVX(SCCVDT)) Q:'SCCVDT  D
 . S SCCVTMP=0 F  S SCCVTMP=$O(SCCVX(SCCVDT,SCCVTMP)) Q:'SCCVTMP  D
 . . S SCCV0=$G(@SCCVFL@(SCCVTMP,0)),SCCV1=$G(^(1))
 . . D ADDLIST(.SCCVCT,SCCV0,SCCV1," ",SCCVTMP)
 ;
 I '$D(^TMP("SCCV."_SCCVTYP,$J)) S VALMCNT=2,SCCVCT=2,^TMP("SCCV."_SCCVTYP,$J,1,0)=" ",^TMP("SCCV."_SCCVTYP,$J,2,0)="    No Templates On File"
 Q
 ;
ADDLIST(SCCVCT,SCCV0,SCCV1,SCCVGAP,SCCVTMP) ; add to list
 N X,SCCVACT
 S SCCVCT=SCCVCT+1,X="" W "."
 ;
 S X=$$SETFLD^VALM1($J(SCCVCT,4),X,"NUMBER")
 S X=$$SETFLD^VALM1($J(SCCVGAP_$$FMTE^XLFDT($P(SCCV0,U,3),1)_" - "_$$FMTE^XLFDT($P(SCCV0,U,4),1),27),X,"DTRANGE")
 ;
 I SCCVTYP="CST" D  ;Conversion templates only
 . S X=$$SETFLD^VALM1($$EXPAND^SCCVDSP2(404.98,.05,$P(SCCV0,U,5)),X,"EVENT")
 . S SCCVACT=$S($P(SCCV0,U,5)=3:"",1:$P(SCCV0,U,7))
 . S X=$$SETFLD^VALM1($$EXPAND^SCCVDSP2(404.98,.07,SCCVACT),X,"ACTION")
 S X=$$SETFLD^VALM1($J(SCCVTMP,5),X,"TEMPLATE")
 ;
 D SET(X)
 Q
 ;
FNL(SCCVTYP) ; -- Clean up template list
 ; SCCVTYP = 'AST or 'CST' for type of template
 ;
 K ^TMP("SCCV."_SCCVTYP_".DX",$J),^TMP("SCCV."_SCCVTYP,$J)
 K SCCVDONE,SCCVDA,SCCVSCRN
 D CLEAN^VALM10
 Q
 ;
SET(X) ; -- set arrays for template list
 S VALMCNT=VALMCNT+1,^TMP("SCCV."_SCCVTYP,$J,VALMCNT,0)=X
 S ^TMP("SCCV."_SCCVTYP,$J,"IDX",VALMCNT,SCCVCT)=""
 S ^TMP("SCCV."_SCCVTYP_".DX",$J,SCCVCT)=VALMCNT_"^"_SCCVTMP
 Q
 ;
SELX(SCCVTYP,CANCEL) ; -- Select the entry to process
 ; SCCVTYP = 'AST or 'CST' for type of template
 ; CANCEL = Flag ... 1 = don't allow to be selected if canceled
 ;                   0 = allow to be selected even if canceled
 ;
 D EN^VALM2($G(XQORNOD(0)),"S")
 S SCCVDA=$P($G(^TMP("SCCV."_SCCVTYP_".DX",$J,+$O(VALMY("")))),U,2)
 I $G(CANCEL),$S(SCCVTYP="AST":$P($G(^SD(404.99,+SCCVDA,0)),U,5)=6,1:$P($G(^SD(404.98,+SCCVDA,0)),U,9)) D
 .W !,"You cannot select a canceled template!"
 .D PAUSE^SCCVU
 .K SCCVDA
 Q
 ;
FNLX ; Clean up after select action
 K SCCVDA
 D CLEAN^VALM10
 S VALMBCK="R"
 Q
 ;
HDRX ; -- Hdr for select action
 S VALMHDR(1)=" "
 S VALMHDR(2)=SCCVTYP_" #: "_$G(SCCVDA)
 Q
 ;
FASTEX ; -- Sets a flag that system should be exited
 S VALMBCK="Q"
 I $G(VALMEVL) D  ;Ask this for all but the last level
 .D FULL^VALM1
 .N DIR
 .S DIR(0)="Y"
 .S DIR("A")="Exit option entirely"
 .S DIR("B")="NO"
 .D ^DIR
 .I $D(DIRUT)!(Y) S SCFASTXT=1
 Q
 ;
