TIUFPR ;SLC/MAM - Action Print List ;;3/7/00
 ;;1.0;TEXT INTEGRATION UTILITIES;**2,8,99**;Jun 20, 1997
 ;
CAPTION(RMSUFFIX) ; -- set up caption line of header
 N X,COL,FLD
 S $P(X," ",TIUF("RM"_RMSUFFIX)+1)=""
 S COL="" F  S COL=$O(VALMDDF(COL)) Q:COL=""  S FLD=VALMDDF(COL) D
 .S X=$$SETSTR^VALM1($P(FLD,U,4),X,+$P(FLD,U,2),$S($L($P(FLD,U,4))<$P(FLD,U,3):$L($P(FLD,U,4)),1:+$P(FLD,U,3)))
 Q X
 ;
TBAR(RMSUFFIX) ; -- print caption/top bar
 ; Needs TIUFWD,TIUFCAP,RMSUFFIX
 N X
 D CRT(0,2)
 S TIUFCAP=" "_$E(TIUFCAP,2,TIUF("RM"_RMSUFFIX))
 S X=$E(TIUFCAP,1,VALM("FIXED"))_$E(TIUFCAP,VALMLFT,VALMLFT+TIUFWD-1-VALM("FIXED"))
 W:"DX"'[$G(TIUFSTMP) ! W X
 Q
 ;
CRT(DX,DY) ;
 I DX'<0,DY'<0,$E(IOST,1,2)="C-" W $C(13) X IOXY
 Q
 ;
PRTL ; Action Print List. Prints whole list of items, but if Template permits right/left scroll, prints only the present right/left portion of each item.
 N DIR,DA,X,Y,TIUFANS,TIUFAR,TIUFCAP,RMSUFFIX,WHO,DTOUT,DIRUT,DIROUT
 S WHO=$S(TIUFWHO="N":"M",1:TIUFWHO)
 S TIUFAR=$S($G(TIUFSTMP)="D"!($G(TIUFSTMP)="X"):"^TMP(""TIUF3"",$J)",$G(TIUFSTMP)="T":"^TMP(""TIUF2"",$J)",1:"^TMP(""TIUF1"",$J)")
 S RMSUFFIX=$S($D(TIUFSTMP):TIUFSTMP,1:TIUFTMPL),RMSUFFIX=RMSUFFIX_$S("TD"'[RMSUFFIX:WHO,1:"")
 S TIUFCAP=$$CAPTION(RMSUFFIX)
 D:VALMCC FULL^VALM1
 S DIR("?",1)="You can print only those columns that appear on this screen, or you can print"
 S DIR("?")="ALL columns including those you see by scrolling to the right"
 D  I $D(DIRUT) G PRTLX
 . K DIRUT I $G(TIUFSTMP)="D" S TIUFANS=1 Q
 . S DIR(0)="Y",DIR("A")=$S($G(TIUFSTMP)="":"Print Name and Type Only",1:"Print Item and Sequence Only"),DIR("B")="YES"
 . I $G(TIUFSTMP)="",VALMLFT=49 D ^DIR S TIUFANS=Y Q
 . I $G(TIUFSTMP)="T",VALMLFT=32 D ^DIR S TIUFANS=Y Q
 . S TIUFANS=1
 S %ZIS="Q" D ^%ZIS I POP G PRTLX
 I '$D(IO("Q")),IO=IO(0) D CLEAR^VALM1 S X=0 X ^%ZOSF("RM")
 I '$D(IO("Q")) G PRTL1
 S ZTRTN="PRTL1^TIUFPR",ZTIO=ION,ZTDESC="TIUF Print List -- List Manager Action"
 D SAVE,^%ZTLOAD G PRTLX
 ;
PRTL1 ;
 N TIUFWD,TIUFPGE,TIUFLNS,TIUFHDR,NOSCRNS,NOPGES,TIUFOFPG,TIUFJ,FIRST,LAST,TIUFESC
 S TIUFWD=IOM,TIUFPGE=1,TIUFLNS=IOSL-6
 S TIUFHDR=VALMHDR(1),TIUFESC=0
 I TIUFANS S NOSCRNS=1
 E  S NOSCRNS=$S($G(TIUFSTMP)="T":2,1:4)
 S NOPGES=$$PAGE(VALMCNT,TIUFLNS),TIUFOFPG=NOPGES*NOSCRNS
 U IO
 F TIUFJ=1:1:NOPGES D  Q:TIUFESC
 . S FIRST=TIUFLNS*(TIUFJ-1)+1,LAST=FIRST+TIUFLNS-1
 . D COLUMNS(FIRST,LAST,NOSCRNS,.TIUFPGE,RMSUFFIX)
PRTLX S VALMBCK="R" N IOSTBM D ^%ZISC D TERM S X=0 X ^%ZOSF("RM")
 I $D(ZTQUEUED) S ZTREQ="@"
 I $D(DTOUT) S VALMBCK="Q"
 Q
 ;
TERM ; -- set up term characteristics
 D HOME^%ZIS
 S X="IORVON;IORVOFF;IOIL;IOSTBM;IOSC;IORC;IOEDEOP;IOINHI;IOINORM;IOUON;IOUOFF;IOBON;IOBOFF;IOSGR0" D ENDR^%ZISS
 Q
 ;
COLUMNS(FIRST,LAST,NOSCRNS,TIUFPAGE,RMSUFFIX) ; Writes columns for LM entries FIRST through LAST;
 ; Returns the display back to far left before quitting.
 ; NOSCRNS = Number of (left/right) screens to be printed (depends on LM Template Right Margin) and on users choice to print all or only first left/right screen.
 N TIUFI,LINENO,TEXT
 ;TIUFESC is newed in PRTL; DON'T new it here.
 S TIUFESC=0
 F TIUFI=1:1:NOSCRNS D  Q:TIUFESC
 . D HDR,TBAR(RMSUFFIX)
 . F LINENO=FIRST:1:LAST Q:LINENO>VALMCNT  Q:TIUFESC  S TEXT=$$EXTRACT($G(@TIUFAR@(LINENO,0))) W !,TEXT
 . D FTR
 . Q:TIUFESC
 . D:NOSCRNS>1 RIGHT^TIUFL1("0^0^PL")
 . S TIUFPGE=TIUFPGE+1
 . Q
 D:NOSCRNS>1 LEFT^TIUFL1("0^0^PL")
 Q
 ;
EXTRACT(X) ; -- extract string
 ; Requires  TIUFWD
 Q $S(X="":X,1:$E($E(X,1,+VALM("FIXED"))_$E(X,VALMLFT,VALMLFT+TIUFWD-1-VALM("FIXED"))_$J("",TIUFWD),1,TIUFWD))
 ;
HDR ; -- prt/display header
 ; Requires TIUFHDR, TIUFWD, TIUFPGE, TIUFIOFPG, TIUFAR, TITLE
 N X,I,DX,DY,TITLE
 ; -- prt hdr line
 W @IOF
 I $E(IOST,1,2)="C-" S DX=0,DY=0 X IOXY ; -- position cursor
 S TITLE=$S('$D(VALM("TITLE")):$E($P(TIUFNOD0,U),1,30),1:VALM("TITLE"))
 W $J(" ",30-$L(TITLE))
 I $E(IOST,1,2)="C-" W $C(13) S DX=30,DY=0 X IOXY ; -- position cursor
 W $J("",((TIUFWD-80)/2)),$$MIXED^TIULS($$NOW^TIULO),$J("",10+((TIUFWD-80)/2)),"Page: ",$J(TIUFPGE,4)," of ",$J(TIUFOFPG,4)
 W !,TIUFHDR,!
 Q
 ;
FTR ; -- footer to print
 N PAUSEANS
 S TIUFESC=0
 I $E(IOST,1,2)="C-" D XPAUSE(.PAUSEANS) S TIUFESC='PAUSEANS
 Q
 ;
XPAUSE(Y) ; Pause with ^ to exit; omits carriage return that scrolls top line off
 N DIR,X,DA
 W ! S DIR(0)="E" D ^DIR
 Q
 ;
PAGE(BEG,LINES) ; -- calc page #
 ; Requires TIUFAR
 S BEG=$S($D(@TIUFAR@(BEG,0)):BEG,1:0)
 Q (BEG\LINES)+((BEG#LINES)>0)
 ;
SAVE ; -- save to queue for PRTL
 ; TIU*1*99: add VALM(, VALMCC to list:
 F X="TIUFSTMP","TIUFTMPL","TIUFXNOD","VALMDDF","TIUFWD","TIUF(","VALM(","VALMCC","VALMLFT","VALMWD","VALMCNT","VALMHDR(","TIUFWHO","TIUFANS","TIUFCAP","RMSUFFIX" S ZTSAVE(X)=""
 F X="TIUFAR",$E(TIUFAR,1,$L(TIUFAR)-1)_"," S ZTSAVE(X)=""
 Q
 ;
