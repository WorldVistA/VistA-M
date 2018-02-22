XVEMRE2 ;DJB/VRR**EDIT - Block Mode ;2017-08-15  1:40 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
BLOCK ;Block Mode
 ;<AU>/<AD>: Highlight lines of code.
 ;           Clipboard marked: ^XVEMS("E","SAVEVRR",$J)="LINE"
 ;<AL>/<AR>: Highlight characters of code on a single line.
 ;           Clipboard marked: ^XVEMS("E","SAVEVRR",$J)="CHAR"
 ;
 I VK="<DEL>" D DEL Q  ;.....Delete code
 I VK="<ESCC>" D ESCC Q  ;...Copy code to clipboard
 I VK="<ESCD>" D ESCD Q  ;...Delete code
 I VK="<ESCV>" D ESCV Q  ;...Paste code
 I VK="<ESCX>" D ESCX Q  ;...Cut code to clipboard
 I VK="<F3>" D F3 Q  ;.......Turn Block mode ON/OFF
 Q
 ;
DEL ;Delete code
 D ESCD
 Q
 ;
ESCC ;Copy code to clipboard
 D COPY^XVEMRP1
 D BLOCK^XVEMRER()
 Q
 ;
ESCD ;Delete code
 ;
 ;Block mode ON
 I FLAGMODE["BLOCK" D  Q
 . I $D(^TMP("XVV","SAVECHAR",$J)) D ESCDC Q  ;Delete characters
 . D ESCDL1 ;..................................Delete lines
 ;
 ;Block mode OFF
 D ESCDL2 ;....................................Delete lines
 Q
 ;
ESCDC ;Delete characters - Block mode must be ON.
 D DELETE^XVEMRP2
 D BLOCK^XVEMRER()
 Q
 ;
ESCDL1 ;Delete lines - Block mode ON
 D DELETE^XVEMRP1()
 D REDRAW1^XVEMRU
 D BLOCK^XVEMRER(1)
 S QUIT=1
 Q
 ;
ESCDL2 ;Delete lines - Block mode OFF
 D ESCD^XVEMRP1
 D REDRAW1^XVEMRU
 S QUIT=1
 Q
 ;
ESCV ;Paste characters/lines
 NEW CHAR,CLIPTYPE,LINE
 ;
 ;Block Mode OFF
 I FLAGMODE'["BLOCK" D  D REDRAW^XVEMRU(YND) Q
 . I $G(^XVEMS("E","SAVEVRR",$J))="CHAR" D INSERT^XVEMRP2 Q  ;Chars
 . D PREPASTE^XVEMRP1 ;Lines
 ;
 ;Block Mode ON
 S CLIPTYPE=$G(^XVEMS("E","SAVEVRR",$J))
 S CHAR=$D(^TMP("XVV","SAVECHAR",$J))
 S LINE=$D(^TMP("XVV","SAVE",$J))
 ;
 I CLIPTYPE="LINE" D  ;...Replace lines
 . I CHAR D  Q  ;.........Can't replace lines with chars
 .. D MSG^XVEMRUM(23)
 .. D CLEARALL^XVEMRP
 . D ESCV1
 ;
 I CLIPTYPE="CHAR" D  ;...Replace characters
 . I LINE D  Q  ;.........Can't replace chars with lines
 .. D MSG^XVEMRUM(22)
 .. D CLEARALL^XVEMRP
 . D ESCV2
 ;
 ;Turn off Block Mode
 D BLOCK^XVEMRER()
 Q
 ;
ESCV1 ;Replace lines
 ;Set YND=Highest line number of highlighted code. Insert saved lines
 ;after this number, and then delete highlighted lines.
 ;
 Q:'$D(^TMP("XVV","SAVE",$J))
 S YND=$O(^TMP("XVV","SAVE",$J,""),-1) ;Highest line number
 D PREPASTE^XVEMRP1 ;..................Insert saved lines
 D DELETE^XVEMRP1("") ;................Delete highlighted lines
 D REDRAW2^XVEMRU ;....................Redraw screen
 Q
 ;
ESCV2 ;Replace characters
 D DELETE^XVEMRP2 ;...Cut characters
 D INSERT^XVEMRP2 ;...Insert new characters
 D REDRAW^XVEMRU(YND)
 Q
 ;
ESCX ;Cut characters/lines
 ;
 ;Cut characters
 I $D(^TMP("XVV","SAVECHAR",$J)) D  Q
 . D SAVE1^XVEMRP1
 . D DELETE^XVEMRP2
 . D BLOCK^XVEMRER()
 ;
 ;Cut lines
 D CUT^XVEMRP1
 D BLOCK^XVEMRER(1)
 D REDRAW2^XVEMRU
 Q
 ;
F3 ;Block mode ON/OFF
 ;
 ;Turn Block mode OFF
 I $G(FLAGMODE)["BLOCK" D  Q
 . D CLEARALL^XVEMRP
 . D BLOCK^XVEMRER()
 ;
 ;Turn Block mode ON
 S $P(FLAGMODE,"^",1)="BLOCK"
 D MODEON^XVEMRU("BLOCK")
 KILL ^TMP("XVV","SAVE",$J)
 KILL ^TMP("XVV","SAVECHAR",$J)
 Q
