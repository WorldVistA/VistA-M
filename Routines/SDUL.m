SDUL ;MJK/ALB - List Manager; 12/1/91
 ;;5.3;Scheduling;;Aug 13, 1993
 ;
EN(NAME,PARMS) ; -- main entry point
 ;  input:   NAME := free text name of list template or routine call
 ;          PARMS := parameter list
 ;
 D INIT^SDUL0(.NAME,$G(PARMS)) G ENQ:$D(SDULQUIT)
 D BLD G ENQ:$D(SDULQUIT)
 D REFRESH,ASK
 X:$G(^TMP("SDUL DATA",$J,SDULEVL,"FNL"))]"" ^("FNL")
ENQ D POP^SDUL0
 Q
 ;
BLD ; -- build list of items
 I $G(^TMP("SDUL DATA",$J,SDULEVL,"INIT"))]"" X ^("INIT") G BLDQ:$D(SDULQUIT)
 S:'$D(SDULBG) SDULBG=1
 S SDULPGE=$$PAGE^SDUL4(SDULBG,SDUL("LINES"))
BLDQ Q
 ;
LIST ; -- list items
 S:'$D(SDULBG) SDULBG=1
 S SDULST=0,SDULPGE=$$PAGE^SDUL4(SDULBG,SDUL("LINES"))
 I $E(IOST,1,2)="C-" W ! S DX=0,DY=SDUL("TM")-2 X IOXY,^%ZOSF("XY")
 S I=SDULBG F LN=1:1:SDUL("LINES") S X=$G(@SDULAR@($$GET^SDUL4(I),0)) S SDULST=I W !,X S I=I+1
 S:SDULST>SDULCNT SDULST=SDULCNT
 K X S $P(X,$S(SDULCC:" ",1:"-"),SDULWD+1)=""
 S SDULDN=(SDULST<SDULCNT) S:SDULDN X="+"_$E(X,2,SDULWD+1)
 S:SDULCC X=IOUON_$C(13)_X_$C(13)_IOUOFF
 W !,X W:$E(IOST,1,2)="C-" !
 Q
 ;
ASK ; -- prompt user
 I SDULCC D RESET^SDUL4
 S X=SDUL("PROTOCOL"),XQORM(0)=SDUL("MAX")_"A\"
 S:$G(^TMP("SDUL DATA",$J,SDULEVL,"HLP"))]"" XQORM("??")=^("HLP")
 K SDULBCK,DTOUT,DIROUT,DUOUT
 D EN^XQOR
 I $D(SDULBCK),SDULBCK'="Q" D REFRESH:SDULBCK="R" G ASK
ASKQ K XQORM,DTOUT,DIROUT,DUOUT Q
 ;
COL ;
 K SDULDDF
 S I=0 F  S I=$O(^SD(409.61,SDUL("IFN"),"COL",I)) Q:'I  I $D(^(I,0)) S SDULDDF($P(^(0),U))=^(0)
 Q
 ;
CAPTION() ; -- set up caption line of header
 N X,COL,FLD
 S $P(X,$S(SDULCC:" ",1:"-"),SDULWD+1)=""
 S COL="" F  S COL=$O(SDULDDF(COL)) Q:COL=""  S FLD=SDULDDF(COL) D
 .S X=$$SETSTR^SDUL1($P(FLD,U,4),X,+$P(FLD,U,2),$S($L($P(FLD,U,4))<$P(FLD,U,3):$L($P(FLD,U,4)),1:+$P(FLD,U,3)))
 Q X
 ;
CHGCAP(FLD,LABEL) ; -- change label on caption
 ; input:  FLD := name of field
 ;        LABEL := text for column header
 S $P(SDULDDF(FLD),U,4)=LABEL,SDULCAP=$$CAPTION
 Q
 ;
HDR ; -- prt/display header
 N X,I
 I '$D(SDULHDR) X:$G(SDUL("HDR"))]"" SDUL("HDR")
 ; -- prt hdr line
 W @IOF
 W:SDULCC IOUON,IOINHI
 I $E(IOST,1,2)="C-" S DX=0,DY=0 X IOXY
 W $E(SDUL("TITLE"),1,30)
 W:SDULCC IOINORM,IOUON
 W $J("",30-$L(SDUL("TITLE")))
 I $E(IOST,1,2)="C-" W $C(13) S DX=30,DY=0 X IOXY
 W $$LOWER^SDUL1($$NOW^SDUL1),"             Page: ",$J(SDULPGE,3)," of ",$J($$PAGE^SDUL4(SDULCNT,SDUL("LINES")),3)
 W:SDULCC IOUOFF,$C(13)
 ;
 F I=1:1:SDUL("TM")-3 W !,$G(SDULHDR(I))
 S SDULUP=(SDULBG>1) S SDULCAP=$S(SDULUP:"+",'SDULCC:"-",1:" ")_$E(SDULCAP,2,SDULWD)
 I SDUL("TM")>2 D
 .W:SDULCC !,IOUON,$C(13),SDULCAP,$C(13),IOUOFF
 .W:'SDULCC !,SDULCAP
 Q
 ;
REFRESH ;
 S SDULPGE=$$PAGE^SDUL4(SDULBG,SDUL("LINES")) D HDR
 S SDULBCK="" D LIST
 Q
 ;
SHOW ; -- show items to user
 S DX=0,DY=SDUL("BM")-SDULMENU X IOXY
 I SDULMENU D
 .S X="?" D DISP^XQORM1
 Q
 ;
WP1(SDULREF) ; -- quick setup
 S SDULCNT=+$P(@SDULREF@(0),U,4)
 S SDUL("ARRAY")=SDULREF
 S:$D(SDULWPTL) SDUL("TITLE")=SDULWPTL
 Q
 ;
WP(SDULREF,SDULWPTL) ; -- quick entry to List Manager (c)
 D EN("WP1^SDUL(SDULREF)")
 Q
