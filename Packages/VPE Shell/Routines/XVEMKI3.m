XVEMKI3 ;DJB/KRN**Indiv Fld DD - STRING,WORD ;2017-08-15  12:57 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
 ;Print STRING in lines of 59 characters
STRING ;--> STRING=Code
 Q:$G(STRING)']""
 NEW CNT
 F CNT=1:1 Q:STRING=""  D  Q:$$CHECK
 . W:CNT>1 !
 . W ?C4,$E(STRING,1,59)
 . S STRING=$E(STRING,60,9999)
 Q
 ;
WORD ;Display single Text node
 Q:$G(STRING)']""!(STRING?1." ")
 NEW I,LINE
WORD1 F I=1:1 Q:$E(STRING,I)'=" "
 S STRING=$E(STRING,I,999) ;Strip off starting spaces
 Q:$G(STRING)']""
 S LINE=$E(STRING,1,59)
 I $L(STRING)>59,LINE[" ",$E(STRING,60)'=" " D  ;
 . S LINE=$P(LINE," ",1,$L(LINE," ")-1)
 W:I>1 !
 W ?C4,LINE Q:$$CHECK
 S STRING=$E(STRING,$L(LINE)+1,9999)
 G WORD1
 ;
WORDA(ROOT,ND) ;Display Text array
 ;ROOT = The global root that contains text (Enter as closed root)
 ;ND   = The node that contains text
 ;Example:  ROOT="^XVEMS(""ZZ"",""%DT"")"
 ;          ND  = ""
 ;          Will display text at: ^XVEMS("ZZ","%DT",1)
 ;                                ^XVEMS("ZZ","%DT",2)
 ;                                etc
 ;
 NEW COMMA,GLB,I,IEN,LEFTOVER,LINE,ROOT1,STRING
 ;
 Q:$G(ROOT)']""
 S ND=$G(ND)
 I ND]"",+ND'=ND S ND=""""_ND_"""" ;Enclose ND in quotes if alpha
 ;
 S ROOT1=ROOT
 S COMMA=1 ;Needs a comma in subscript
 I ROOT1'["(" S ROOT1=ROOT1_"("
 I $E(ROOT1,$L(ROOT1))="(" S COMMA=0
 I $E(ROOT,$L(ROOT))=")" S ROOT1=$P(ROOT,")",1)
 ;
 S LEFTOVER=""
 S IEN=0
 F I=1:1 S IEN=$O(@ROOT@(IEN)) Q:'IEN!FLAGQ  D  ;
 . ;
 . ;Get text
 . I ND]"" D  ;
 .. I COMMA S GLB=ROOT1_","_IEN_","_ND_")"
 .. E  S GLB=ROOT1_IEN_","_ND_")"
 .. Q:'$D(@GLB)  S STRING=@GLB
 . E  D  ;
 .. I COMMA S GLB=ROOT1_","_IEN_")"
 .. E  S GLB=ROOT1_IEN_")"
 .. Q:'$D(@GLB)  S STRING=@GLB
 . ;
 . I LEFTOVER]"" S STRING=LEFTOVER_" "_STRING,LEFTOVER=""
 . D WORDA1(STRING)
 ;
 ;Write final line of text
 Q:LEFTOVER']""!FLAGQ
 S STRING=LEFTOVER
 D WORDA1(STRING)
 Q
 ;
WORDA1(STRING) ;Write text
 NEW LINE
WORDA1A S LINE=$E(STRING,1,59)
 ;
 I $L(STRING)>59,LINE[" ",$E(STRING,60)'=" " D  ;
 . S LINE=$P(LINE," ",1,$L(LINE," ")-1)
 ;
 W:I>1 !
 W ?C4,LINE
 Q:$$CHECK
 ;
 S STRING=$E(STRING,$L(LINE)+1,999)
 I $L(STRING)>59 G WORDA1A
 S LEFTOVER=STRING
 ;Strip any leading spaces from LEFTOVER.
 F  Q:$E(LEFTOVER)'=" "  S LEFTOVER=$E(LEFTOVER,2,$L(LEFTOVER))
 Q
 ;
PAGE ;
 I $G(FLAGP) D  Q
 . W @XVV("IOF") I $E(XVVIOST,1,2)="P-" W !!!
 NEW I
 I $Y'>(XVVSIZE+1) F I=$Y:1:(XVVSIZE+2) W !
 W !,$E(XVVLINE,1,XVV("IOM"))
 D PAUSEQE^XVEMKC(1) Q:FLAGQ
 W @XVV("IOF"),?55,"FLD NUM: ",FNUM
 W !,$E(XVVLINE,1,XVV("IOM"))
 Q
 ;
CHECK() ;Check page length. 0=Ok  1=Quit
 I $Y'>(XVVSIZE+1) Q 0
 D PAGE I FLAGQ Q 1
 Q 0
