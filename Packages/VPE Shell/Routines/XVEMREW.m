XVEMREW ;DJB/VRR**EDIT - WEB..Insert HTML Codes ;2017-08-15  1:47 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
WEB ;Insert HTML tags:
 NEW CD,I
 D HTML^XVEMREP ;...Display HTML in upper right of screen
 S CD="" D INSERT
 D HTML^XVEMREP ;...Remove HTML from upper right of screen
 Q
INSERT ;Insert HTML code
 D ASK
 S CD=$$ALLCAPS^XVEMKU(CD)
 Q:CD=""!(CD=".")!(CD="..")
 I CD="?"!(CD="??") D HELP Q
 I $E(CD)="." D  Q
 . S CD=$E(CD,2,99)
 . I CD="AQUA" D CLINE("#238E68","","") Q
 . I CD="BLACK" D CLINE("#000000","","") Q
 . I CD="BLUE" D CLINE("#0000FF","","") Q
 . I CD="FUCHSIA" D CLINE("#FF00FF","","") Q
 . I CD="GRAY" D CLINE("#C0C0C0","","") Q
 . I CD="GREEN" D CLINE("#00FF00","","") Q
 . I CD="LIME" D CLINE("#32CD32","","") Q
 . I CD="MAROON" D CLINE("#8E236B","","") Q
 . I CD="NAVY" D CLINE("#23238E","","") Q
 . I CD="OLIVE" D CLINE("#238E23","","") Q
 . I CD="PURPLE" D CLINE("#871F78","","") Q
 . I CD="RED" D CLINE("#FF0000","","") Q
 . I CD="SILVER" D CLINE("#545454","","") Q
 . I CD="TEAL" D CLINE("#00FFFF","","") Q
 . I CD="WHITE" D CLINE("#FFFFFF","","") Q
 . I CD="YELLOW" D CLINE("#FFFF00","","") Q
 . D CLINE(CD,"<",">")
 I CD="C" D COMMENT Q
 I CD="I" D IMAGE Q
 I CD="L" D LIST Q
 I CD="LK" D LINK Q
 I CD="R" D REQUIRED Q
 I CD="T" D TABLE Q
 D GENERIC
 Q
ASK ;Get user's input
 ;<SPACEBAR>=LastTag  /=/LastTag
 ;LastTag is always stored in CDHLD without the /.
 NEW DX,DY,I,PROMPT
 S PROMPT="HTML Tag" I $G(CDHLD)]"" S PROMPT=PROMPT_" | "_CDHLD
ASK1 S CD=$$GETTEXT^XVEMRM2(PROMPT)
 I CD=" "!(CD="/") D  G:CD']"" ASK1 I 1
 . I $G(CDHLD)']"" W $C(7) S CD="" Q
 . I CD=" " D  Q
 . . I $E(CDHLD)="/" S CD=$E(CDHLD,2,99) Q
 . . I $E(CDHLD)="./" S CD="."_$E(CDHLD,3,99) Q
 . . S CD=CDHLD
 . I $E(CDHLD,1,2)="./" S CD=CDHLD Q
 . I $E(CDHLD)="/" S CD=CDHLD Q
 . I $E(CDHLD)="." S CD="./"_$E(CDHLD,2,99) Q
 . S CD="/"_CDHLD Q
 E  D  ;........................................Preserve CD in CDHLD
 . Q:",,?,??,"[(","_CD_",")
 . I $E(CD)="/" S CDHLD=$E(CD,2,99) Q
 . I $E(CD,1,2)="./" S CDHLD="."_$E(CD,3,99) Q
 . S CDHLD=CD
 ;--> Redraw bottom line and return cursor to routine.
 S DX=0,DY=XVVT("S2")
 F I=1:1:XVVT("FT") X XVVS("CRSR") W XVVT("FT",I) S DY=DY+1
 S DX=XCUR,DY=YCUR X XVVS("CRSR")
 Q
 ;=================================================================
COMMENT ;HTML comment tag.
 NEW VAR
 S VAR="<!-- "_" -->"
 D NLINE(VAR)
 Q
GENERIC ;HTML generic tag. All tags except <TR>,<P>,<BR> get closing tag.
 NEW VAR
 S VAR="<"_CD_">"
 D NLINE(VAR)
 Q
IMAGE ;HTML image tag.
 NEW VAR
 S VAR="<IMG SRC=""""X.GIF"""" ALT=""""txt"""" ALIGN=LEFT WIDTH=64 HEIGHT=64>"
 D NLINE(VAR)
 Q
LINK ;HTML Link tag.
 NEW VAR
 S VAR="<A HREF=""""X.HTM"""">Click Here</A>"
 D NLINE(VAR)
 Q
LIST ;HTML List tag.
 NEW VAR
 S VAR="<UL TYPE=DISK>,  <LI></LI>,  <LI></LI>,</UL>"
 D NLINE(VAR)
 Q
REQUIRED ;HTML required tag.
 NEW VAR
 S VAR="<HTML>,<HEAD>,<TITLE></TITLE>,</HEAD>,<BODY BGCOLOR=""""white"""" TEXT=""""black"""">,</BODY>,</HTML>"
 D NLINE(VAR)
 Q
TABLE ;HTML Table tag.
 NEW VAR
 S VAR="<TABLE BORDER=0 WIDTH=100% CELLPADDING=0 CELLSPACING=0>,  <TR>,    <TD></TD>,  </TR>,</TABLE>"
 D NLINE(VAR)
 Q
 ;=================================================================
NLINE(VAR) ;Insert HTML into new lines
 NEW I,NUM,SUB,TAG
 S (NUM,SUB)=1 ;...NUM=Rtn line #, SUB=Subscript #
 F I=1:1 S TAG=$P(VAR,",",I) Q:TAG']""  D NLINE1
 D PREPASTE^XVEMRP1,REDRAW^XVEMRU(YND) ;...Inserts code into rtn
 S FLAGSAVE=1
 Q
NLINE1 ;Build Save array
 S TAG="W !,"""_TAG_""""
 S ^XVEMS("E","SAVEVRR",$J,SUB)=NUM_$J("",9-$L(NUM))_$C(30)_$E(TAG,1,XVV("IOM")-11)
 S NUM=NUM+1,SUB=SUB+1,TAG=$E(TAG,XVV("IOM")-10,9999)
 F  Q:TAG']""  D  ;
 . S ^XVEMS("E","SAVEVRR",$J,SUB)=$J("",9)_$E(TAG,1,XVV("IOM")-11)
 . S SUB=SUB+1,TAG=$E(TAG,XVV("IOM")-10,9999)
 S ^XVEMS("E","SAVEVRR",$J,SUB)=""
 Q
CLINE(TXT,LEFT,RIGHT) ;Insert HTML into current line
 ;TXT=Code to be inserted
 ;LEFT=Attach to left side of TXT (<,",etc.)
 ;RIGHT=Attach to right side of TXT (>,",etc.)
 NEW I,KEY
 D HIGHOFF^XVEMRE S DX=XCUR,DY=YCUR X XVVS("CRSR") ;...Highlite off
 F I=1:1 S KEY=$E($G(LEFT),I) Q:KEY']""  W KEY D ^XVEMREA
 F I=1:1 S KEY=$E(TXT,I) Q:KEY']""  W KEY D ^XVEMREA
 F I=1:1 S KEY=$E($G(RIGHT),I) Q:KEY']""  W KEY D ^XVEMREA
 D HIGHON^XVEMRE ;...Highlite on
 S FLAGSAVE=1
 Q
 ;=================================================================
HELP ;Help text
 D HELP^XVEMKT("WEB")
 D REDRAW2^XVEMRU
 D MODEON^XVEMRU("WEB",1) ;Redraw WEB in upper right of screen
 Q
