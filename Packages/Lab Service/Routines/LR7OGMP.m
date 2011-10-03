LR7OGMP ;DALOI/STAFF- Interim report rpc memo print ;7/15/09  12:15
 ;;5.2;LAB SERVICE;**187,246,282,286,344,395**;Sep 27, 1994;Build 27
 ;
PRINT(OUTCNT) ; from LR7OGMC
 N ACC,AGE,CDT,CMNT,DATA,DOC,FLAG,HIGH,IDT,INTP,LINE,LOW,LRCW,LRX,PORDER,PRNTCODE,RANGE,REFHIGH,REFLOW,SEX,SITE,SPEC,SUB,TESTNUM
 N TESTSPEC,THER,THERHIGH,THERLOW,UNITS,VALUE,X,ZERO
 ; the variables AGE, SEX, LRCW, and X are used withing the lab's print codes and ref ranges
 S AGE=$P(^TMP("LR7OG",$J,"G"),U,4),SEX=$P(^("G"),U,5),LRCW=$P(^("G"),U,6)
 S CDT=0
 F  S CDT=$O(^TMP("LR7OG",$J,"TP",CDT)) Q:CDT=""  D
 . S IDT=9999999-CDT
 . S ZERO=$S($D(^TMP("LR7OG",$J,"TP",CDT))#2:^(CDT),1:"")
 . S SPEC=+$P(ZERO,U,5)
 . S DOC=$$NAME(+$P(ZERO,U,10))
 . D SETLINE("",.OUTCNT)
 . S LINE="Report Released Date/Time: "_$$FMTE^XLFDT($P(ZERO,"^",3),"M")
 . D SETLINE(LINE,.OUTCNT)
 . S LINE="Provider: "_DOC
 . D SETLINE(LINE,.OUTCNT)
 . S LINE="  Specimen: "_$P($G(^LAB(61,SPEC,0),"<no specimen on file>"),U)_"."
 . S ACC=$P(ZERO,U,6)
 . S LINE=$$SETSTR^VALM1(" "_ACC,LINE,30,1+$L(ACC))
 . D SETLINE(LINE,.OUTCNT)
 . D SETLINE("    Specimen Collection Date: "_$$LRUDT^LR7OSUM6(CDT),.OUTCNT)
 . D SETLINE("     Test name                Result    units      Ref.   range   Site Code",.OUTCNT)
 . S PORDER=0
 . F  S PORDER=$O(^TMP("LR7OG",$J,"TP",CDT,PORDER)) Q:PORDER'>0  S DATA=^(PORDER) D
 .. I $P(DATA,U,7)="" Q
 .. S TESTNUM=+DATA,PRNTCODE=$P(DATA,U,5),SUB=$P(DATA,U,6),FLAG=$P(DATA,U,8),X=$P(DATA,U,7),UNITS=$P(DATA,U,9),RANGE=$P(DATA,U,10),SITE=$P(DATA,U,11)
 .. S LOW=$P(RANGE,"-"),HIGH=$P(RANGE,"-",2),THER=$P(DATA,U,12)
 .. I $L($P(DATA,U,2))>28,$P(DATA,U,3)'="" S LINE=$P(DATA,U,3)
 .. E  S LINE=$E($P(DATA,U,2),1,28)
 .. S LINE=$$SETSTR^VALM1("",LINE,28,0)
 .. I PRNTCODE="" S LINE=LINE_$J(X,8)
 .. E  S @("VALUE="_PRNTCODE),LINE=LINE_VALUE
 .. S LINE=LINE_" "_FLAG
 .. I $L(LINE)>38 D SETLINE(LINE,.OUTCNT) S LINE=""
 .. I UNITS'="" S LINE=$$SETSTR^VALM1("  "_UNITS,LINE,39,2+$L(UNITS))
 .. S LRX=RANGE
 .. I LRX'="" S LINE=$$SETSTR^VALM1(LRX,LINE,52,$L(LRX))
 .. I $L(LINE)>67,SITE D SETLINE(LINE,.OUTCNT) S LINE=""
 .. I SITE S LINE=$$SETSTR^VALM1(" ["_SITE_"]",LINE,68,3+$L(SITE))
 .. I LINE'="" D SETLINE(LINE,.OUTCNT)
 .. I $O(^TMP("LR7OG",$J,"TP",CDT,PORDER,0))>0 D
 ... S INTP=0
 ... F  S INTP=+$O(^TMP("LR7OG",$J,"TP",CDT,PORDER,INTP)) Q:INTP<1  D SETLINE("      Eval: "_^(INTP),.OUTCNT)
 . I $D(^TMP("LR7OG",$J,"TP",CDT,"C")) D
 .. S LINE="Comment: "
 .. S CMNT=0
 .. F  S CMNT=+$O(^TMP("LR7OG",$J,"TP",CDT,"C",CMNT)) Q:CMNT<1  S LINE=LINE_^(CMNT) D
 ... D SETLINE(LINE,.OUTCNT)
 ... I $O(^TMP("LR7OG",$J,"TP",CDT,"C",CMNT)) S LINE="        "
 . D SETLINE("===============================================================================",.OUTCNT)
 . D SETLINE(" ",.OUTCNT)
 Q
 ;
 ;
SETLINE(LINE,CNT) ;
 S ^TMP("LR7OGX",$J,"OUTPUT",CNT)=LINE
 S CNT=CNT+1
 Q
 ;
 ;
NAME(X) ; $$(#) -> name
 N LRDOC
 D DOC^LRX
 Q LRDOC
 ;
 ;
DD(Y) ; $$(date/time) -> date/time format
 D DD^LRX
 Q Y
 ;
 ;
PLS ; List performing laboratories
 ;
 N LINE,LRPLS,X
 D SETLINE("Performing Lab Sites",.OUTCNT)
 S LRPLS=0
 F  S LRPLS=$O(^TMP("LRPLS",$J,LRPLS)) Q:LRPLS<1  D
 . S LINE=$$LJ^XLFSTR("["_LRPLS_"] ",8)_$$NAME^XUAF4(LRPLS)
 . D SETLINE(LINE,.OUTCNT)
 . S X=$$PADD^XUAF4(LRPLS)
 . S LINE=$$REPEAT^XLFSTR(" ",8)_$P(X,U)_"  "_$P(X,U,2)_", "_$P(X,U,3)_" "_$P(X,U,4)
 . D SETLINE(LINE,.OUTCNT)
 ;
 D SETLINE("===============================================================================",.OUTCNT)
 ;
 K ^TMP("LRPLS",$J)
 Q
