XVEMKT ;DJB/KRN**Txt Scroll-Start ;2017-08-15  1:13 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; New Error trap throughout (c) 2016 Sam Habiel
 ;
IMPORT ;Display imported text passed in variable XVVT
 N $ESTACK,$ETRAP S $ETRAP="D ERROR^XVEMKT"
 X XVVT("GET")
 D LIST^XVEMKT1
 Q
 ;
IMPORTS(PKG) ;START - Call here BEFORE calling IMPORT
 ;PKG=Calling package (G=VGL).
 NEW TYPE
 S TYPE="I"
 KILL ^TMP("XVV",PKG,$J)
 S FLAGQ=0
 D INIT Q:FLAGQ  D INIT1,INIT2
 S XVVT("IMPORT")="YES"
 D SCROLL^XVEMKT2()
 Q
 ;
IMPORTF ;FINISH - Call here AFTER calling IMPORT
 G:'$D(XVVT) EX
 I '$G(FLAGQ) S XVVT=" <> <> <>" D IMPORT
 D ENDSCR^XVEMKT2
 G EX
 ;====================================================================
GLB(GLB,XVVMODE,XVVPAGE) ;Display a global
 ;GLB=Global. Example: ^VA(200)
 ;XVVMODE="SC"    Display without scrolling (for screen capture).
 ;XVVPAGE=Number  Used when XVVMODE="SC".
 ;                Pause after that many nodes display.
 I $G(GLB)']"" D  Q
 . W !?1,"You must include a global reference..",!
 D  Q:GLB=""
 . N $ETRAP S $ETRAP="D ERROR S $EC="""""
 . I GLB["(",$E(GLB,$L(GLB))'=")" S GLB=GLB_")"
 . I '$D(@(GLB)) S GLB="" ;Check for valid glb
 NEW GLBHLD,TYPE
 S GLBHLD=$P(GLB,")",1)
 S TYPE="G"
 I GLBHLD?1"^[".E S GLBHLD="^"_$P(GLBHLD,"]",2)
 I GLBHLD?1"^|".E S GLBHLD="^"_$P(GLBHLD,"|",3)
 G TOP
 ;
RTN(RTN,TAG) ;;RTN=Routine,TAG=LineTag
 ;;If TAG, use Help text format. TYPE=R..Routine  TYPE=H..Help text
 I $G(RTN)["^" F  S RTN=$P(RTN,"^",2,99) Q:RTN'["^"
 Q:$G(RTN)']""
 Q:'$$EXIST^XVEMKU(RTN)
 NEW TYPE
 S TYPE="R",TAG=$G(TAG)
 I TAG]"" S TYPE="H"
 G TOP
 ;
VERSION(IEN) ;;Display a routine from the Version file.
 ;;IEN to file 19200.112
 Q:'$G(IEN)
 Q:'$D(^XVV(19200.112,IEN,"WP"))
 NEW GLB,TYPE
 S TYPE="V"
 S GLB="^XVV(19200.112,"_IEN_",""WP"",0)"
 G TOP
 ;
HELP(GLB) ;;GLB=Help text title for VPE VShell. Example: DIE
 Q:$G(GLB)']""
 S GLB="^XVEMS(""ZZ"","""_GLB_""")"
 D  Q:GLB=""  ;Check for valid global
 . N $ETRAP S $ETRAP="D ERROR S $EC="""""
 . I '$D(@(GLB)) S GLB=""
 NEW GLBHLD,TYPE
 S GLBHLD=$P(GLB,")",1)
 S TYPE="G"
 G TOP
 ;
LIST(GLB,FM) ;;Generic Lister.
 ;GLB=Global containing choices.
 ;FM=1 if you want to list a Fileman word processing field.
 ;   Example: D LIST^XVEMKT("^XVV(19200.114,2,""WP"",0)")
 ;                   NOTE--Always reference zero node ^
 Q:$G(GLB)']""
 Q:GLB'?1.E1"("1.E1")"
 D  Q:GLB=""  ;Check for valid global
 . N $ETRAP S $ETRAP="D ERROR S $EC="""""
 . I '$D(@(GLB)) S GLB=""
 NEW GLBHLD,TYPE
 S GLBHLD=$P(GLB,")",1)
 S TYPE="L"
 I $G(FM) S GLBHLD=$P(GLBHLD,",",1,$L(GLBHLD,",")-1)
 G TOP
 ;
SELECT(GLB,NUMBER,NEW,TEMPLATE) ;;Generic Selector.
 ;GLB.....: Global containing choices.
 ;NUMBER..: If 1, number each line.
 ;NEW.....: If 1, allow adding new entry
 ;TEMPLATE: Array of preselected nodes
 ;
 Q:$G(GLB)']""
 Q:GLB'?1.E1"("1.E1")"
 D  Q:GLB=""  ;Error trap to check if valid global
 . N $ETRAP S $ETRAP="D ERROR S $EC="""""
 . I '$D(@(GLB)) S GLB=""
 NEW GLBHLD,TYPE
 S GLBHLD=$P(GLB,")",1)
 S TYPE="S"
 G TOP^XVEMKTS
 ;====================================================================
TOP ;
 N $ESTACK,$ETRAP S $ETRAP="D ERROR^XVEMKT2,UNWIND^XVEMSY"
 NEW DX,DY,FLAGQ,XVVT
 NEW:'$D(XVV) XVV
 NEW:'$D(XVVS) XVVS
 KILL ^TMP("XVV","K",$J) ;"K" for VPE Kernel rtn
 S FLAGQ=0
 D INIT G:FLAGQ EX D INIT1,INIT2
 I $G(XVVMODE)="SC" W @XVV("IOF") D LISTSC^XVEMKT1 G EX
 W @XVV("IOF") D SCROLL^XVEMKT2()
 D LIST^XVEMKT1,ENDSCR^XVEMKT2
EX ;
 KILL ^TMP("XVV","K",$J)
 Q
 ;
INIT ;Screen variables
 I '$D(XVV("OS")) D OS^XVEMKY Q:FLAGQ
 D IO^XVEMKY
 D REVVID^XVEMKY2
 D SCRNVAR^XVEMKY2
 D BLANK^XVEMKY3
 D CRSROFF^XVEMKY2
 D SCRL^XVEMKY2
 Q
 ;
INIT1 ;Scroll area, Header, Footer
 NEW LINE,MAR
 S MAR=$G(XVV("IOM")) S:MAR'>0 MAR=80
 S $P(LINE,"=",MAR)=""
 S:'$D(XVVT("S1")) XVVT("S1")=2 ;S1 to S2 is the scroll region
 S:'$D(XVVT("S2")) XVVT("S2")=(XVV("IOSL")-2)
 I '$D(XVVT("HD")) S XVVT("HD")=1,XVVT("HD",1)=LINE ;Header
 I '$D(XVVT("FT")) S XVVT("FT")=2 D  ;Footer
 . S XVVT("FT",1)=LINE,XVVT("FT",2)="<>  <ESC>H=ScrollHelp  F=Find  L=Locate"
 S:'$D(XVVT("GET")) XVVT("GET")="D GET"_TYPE_"^XVEMKTG"
 KILL TYPE
 Q
 ;
INIT2 ;Scroller variables
 S (XVVT("GAP"),XVVT("SL"))=XVVT("S2")-XVVT("S1")+1
 S (XVVT("BOT"),XVVT("LNCNT"),XVVT("TOP"))=1
 S XVVT("HLN")=1 ;Highlight line #
 S XVVT("H$Y")=XVVT("S1")-1 ;Highlight line $Y
 Q
 ;
ERROR ;
 S GLB=""
 W $C(7),!?1,"Invalid global reference..",!
 Q
