DVBAB99 ;ALB/SPH - CAPRI CONVERSION OF VALM FOR SUPPORT GUI CALLS ;09/06/000
 ;;2.7;AMIE;**35**;Apr 10, 1995
 ;
EN(NAME,PARMS) ; -- main entry point
 ;  input:   NAME := free text name of list template or routine call
 ;          PARMS := parameter list
 ;
 I $G(PARMS)["T" K VALMEVL ; kill if 'T'op level
 D INIT^VALM0(.NAME,$G(PARMS)) G ENQ:$D(VALMQUIT)
 ; -- build list of items
 I $G(^TMP("VALM DATA",$J,VALMEVL,"INIT"))]"" X ^("INIT") G ENQ:$D(VALMQUIT)
 ; -- start event loop
 S VALMBCK="R" D ASK
 X:$G(^TMP("VALM DATA",$J,VALMEVL,"FNL"))]"" ^("FNL")
ENQ D POP^VALM0
 Q
 ;
ASK ; -- event loop
 S X=VALM("PROTOCOL") D XQORM
 ;,EN^XQOR
 ;I $D(VALMBCK),VALMBCK'="Q" G ASK
ASKQ K XQORM,DTOUT,DIROUT,DUOUT Q
 ;
COL ; -- set up column dd array
 K VALMDDF
 S I=0 F  S I=$O(^SD(409.61,VALM("IFN"),"COL",I)) Q:'I  I $D(^(I,0)) S VALMDDF($P(^(0),U))=^(0)
 Q
 ;
CAPTION() ; -- set up caption line of header
 N X,COL,FLD
 S $P(X,$S(VALMCC:" ",1:"-"),VALM("RM")+1)=""
 S COL="" F  S COL=$O(VALMDDF(COL)) Q:COL=""  S FLD=VALMDDF(COL) D
 .S X=$$SETSTR^VALM1($P(FLD,U,4),X,+$P(FLD,U,2),$S($L($P(FLD,U,4))<$P(FLD,U,3):$L($P(FLD,U,4)),1:+$P(FLD,U,3)))
 Q X
 ;
CHGCAP(FLD,LABEL) ; -- change label on caption
 ; input:  FLD := name of field
 ;        LABEL := text for column header
 S $P(VALMDDF(FLD),U,4)=LABEL,VALMCAP=$$CAPTION
 Q
 ;
REFRESH ; -- refresh display
 S VALMPGE=$$PAGE^VALM4(VALMBG,VALM("LINES"))
 S X=0 X ^%ZOSF("RM")
 D HDR:$G(VALMBCK)'["P",TBAR,LIST,LBAR
 S VALMBCK=""
 Q
 ;
HDR ; -- prt/display header
 N X,I
 I '$D(VALMHDR) X:$G(VALM("HDR"))]"" VALM("HDR")
 ; -- prt hdr line
 W:'$D(VALMPG1) @IOF K VALMPG1
 W:VALMCC $C(13)_IOUON_$C(13)_IOINHI_$C(13)       ; -- turn on undln/hi
 I $E(IOST,1,2)="C-" D IOXY^VALM4(0,0)            ; -- position cursor
 W $E(VALM("TITLE"),1,30)                         ; -- prt title
 W:VALMCC IOINORM,IOUON                           ; -- turn off hi
 W $J("",30-$L(VALM("TITLE")))                    ; -- fill in w/blanks
 I $E(IOST,1,2)="C-" W $C(13) D IOXY^VALM4(30,0)  ; -- position cursor
 W $J("",((VALMWD-80)/2)),$$LOWER^VALM1($$NOW^VALM1),$J("",10+((VALMWD-80)/2)),"Page: ",$J(VALMPGE,4)," of ",$J($$PAGE^VALM4(VALMCNT,VALM("LINES")),4)_$S($D(VALMORE):"+",1:" ") ; -- prt rest of hdr
 W:VALMCC IOUOFF I $E(IOST,1,2)="C-" D IOXY^VALM4(0,0) ; -- turn off undln
 F I=1:1:VALM("TM")-3 W !,$S('$D(VALMHDR(I)):"",$L(VALMHDR(I))>(VALMWD-1):$$EXTRACT^VALM4($G(VALMHDR(I))),1:VALMHDR(I)) ; -- prt hdr
 Q
 ;
TBAR ; -- print caption/top bar
 N X
 D CRT(0,VALM("TM")-3)
 S VALMUP=(VALMBG>1),VALMCAP=$S(VALMUP:"+",VALMCC:" ",1:"-")_$E(VALMCAP,2,VALM("RM"))
 S X=$E(VALMCAP,1,VALM("FIXED"))_$E(VALMCAP,VALMLFT,VALMLFT+VALMWD-1-VALM("FIXED"))
 I VALM("TM")>2 D
 .S:VALMCC X=IOUON_$C(13)_X_$C(13)_IOUOFF_$C(13)
 .W !,X
 Q
 ;
LIST ; -- list items
 N I,LN,DY,DX
 S DY=0
 I $E(IOST,1,2)="C-" W ! S DX=0,DY=VALM("TM")-2 X IOXY
 S I=VALMBG,VALMLST=I+VALM("LINES")-1 S:VALMLST>VALMCNT VALMLST=VALMCNT
 F LN=1:1:VALM("LINES") D WRITE^VALM4(I,1,1,DY+LN) S I=I+1
 Q
 ;
LBAR ; -- print low bar
 N CHR,X
 D CRT(0,VALM("BM")-1)
 S CHR=$S(VALMCC:" ",1:"-")
 K X S $P(X,CHR,VALMWD+1)=""
 S X=$E(X,1,10)_$E($E($S($G(VALMSG)="":$$MSG(),1:VALMSG),1,50)_$E(X,11,75),1,65)_$E(X,76,VALMWD) K VALMSG
 S VALMDN=(VALMLST<VALMCNT)
 S X=$S(VALMDN:"+",1:CHR)_CHR_$S(VALMLFT>(VALM("FIXED")+1):"<<<",1:CHR_CHR_CHR)_$E(X,6,VALMWD-3)_$S((VALMLFT+(VALMWD-VALM("FIXED")))<VALM("RM"):">>>",1:CHR_CHR_CHR)
 S:VALMCC X=$C(13)_IORVON_$C(13)_X_$C(13)_IORVOFF_$C(13)
 W !,X
 I $E(IOST,1,2)="C-" W !
 Q
 ;
MSG() ;
 Q "Enter ?? for more actions"
 ;
CRT(DX,DY) ;
 I DX'<0,DY'<0,$E(IOST,1,2)="C-" W $C(13) D IOXY^VALM4(.DX,.DY)
 Q
 ;
SHOW ; -- show items to user / main call back
 W VALMCOFF
 N DX,DY
 S:'$D(VALMBG) VALMBG=1
 S:'$D(VALMLFT) VALMLFT=VALM("FIXED")+1
 S VALMPGE=$$PAGE^VALM4(VALMBG,VALM("LINES"))
 I $G(VALMBCK)="R" D REFRESH
 I $D(VALMSG) D MSG^VALM10(VALMSG) K VALMSG
 I '$D(XQORM("B")),VALM("DEFS") S XQORM("B")=$S(VALMLST<VALMCNT:"Next Screen",1:"Quit")
 I VALMCC D RESET^VALM4
 S DX=0,DY=VALM("BM")-$S(VALM("TYPE")=2:0,1:VALMMENU) X IOXY
 I VALMMENU D
 .S X="?" D DISP^XQORM1
 .W:VALMCC IOEDEOP
 W VALMCON
 D XQORM,KEYS K VALMBCK,VALMDY
 Q
 ;
WP1(VALMREF) ; -- quick setup
 S VALMCNT=+$P(@VALMREF@(0),U,4)
 S VALM("ARRAY")=VALMREF
 S:$D(VALMWPTL) VALM("TITLE")=VALMWPTL
 Q
 ;
WP(VALMREF,VALMWPTL) ; -- quick entry to List Manager (c)
 D EN("WP1^VALM(VALMREF)")
 Q
 ;
XQORM ; -- set XQOR init vars
 S XQORM(0)=VALM("MAX")_"AR\"
 S XQORM("??")="D HELP^VALM2"
 K DTOUT,DIROUT,DUOUT
 Q
 ;
KEYS ; -- set XQOR auto-protocols
 N I S I=0
 F  S I=$O(VALMKEY(I)) Q:'I  S X=VALMKEY(I) S:$P(X,U,2)]"" XQORM("KEY",$P(X,U,2))=+X_"^1"
 S XQORM("XLATE","LEFT")="<=1",XQORM("XLATE","RIGHT")=">=1"
 S XQORM("XLATE","FIND")="SE",XQORM("XLATE","HELP")="??"
 S XQORM("XLATE","DOWN")="DN",XQORM("XLATE","UP")="UP"
 Q
