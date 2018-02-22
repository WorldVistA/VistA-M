XVEMKE ;DJB/KRN**Line Editor [9/9/95 2:43pm];2017-08-15  12:56 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
EDIT(PROMPT) ;Calling point for VPE modules
 S PROMPT=$G(PROMPT)
 I $G(^XVEMS("E","EDIT",DUZ))="LINE" D LINE(PROMPT) Q
 D SCREEN^XVEMKEA(PROMPT,1,XVV("IOM")-2)
 Q
 ;===========================Line Editor=============================
LINE(PROMPT) ;Line Editor
 NEW CHK,CHK1,NEW,OLD,TEMP,TEMP1
 I $G(CD)']"" W $C(7),!!?1,"Variable CD must contain string to be edited.",! Q
LINE1 ;
 W !!,$G(PROMPT),CD
 R !!?1,"Replace: ",OLD:600 Q:OLD=""  S:OLD="end" OLD="END"
 I OLD="..." S OLD=CD
 I OLD?.E1"...".E S TEMP=$P(OLD,"..."),TEMP1=$P(OLD,"...",2) D  I CD'[OLD!CHK1 D MSG1 G LINE1
 . S CHK1=0 S:TEMP]""&(CD'[TEMP) CHK1=1 S:TEMP1]""&(CD'[TEMP1) CHK1=1 Q:CHK1
 . I TEMP="" S OLD=$E(CD,1,($F(CD,TEMP1)-1)) Q
 . I TEMP1="" S OLD=$E(CD,($F(CD,TEMP)-$L(TEMP)),$L(CD)) Q
 . S CHK=$F(CD,TEMP),OLD=$E(CD,(CHK-$L(TEMP)),($F(CD,TEMP1,CHK)-1))
 I OLD'="END",CD'[OLD D MSG1 G LINE1
 R !?1,"With: ",NEW:600 Q:'$T
 I $L(CD_NEW)>244 D MSG2 G LINE1
 S CD=$S(OLD="END":CD_NEW,1:$P(CD,OLD)_NEW_$P(CD,OLD,2,999))
 Q:CD']""  G LINE1
MSG1 W $C(7),!!?2,"No match" Q
MSG2 W $C(7),!!?2,"Code length may not exceed 245" Q
