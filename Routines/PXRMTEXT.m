PXRMTEXT ; SLC/PKR - Text formatting utility routines. ;03/25/2009
 ;;2.0;CLINICAL REMINDERS;**6,12**;Feb 04, 2005;Build 73
 ;
 ;============================================
NEWLINE ;Put TEXT on a new line to the output, make sure it does not end
 ;with a " ".
 N TLEN
 ;If there is no text in TEXT don't do anything.
 I TEXT=INDSTR Q
 S TLEN=$L(TEXT)
 I $E(TEXT,TLEN)=" " S TEXT=$E(TEXT,1,TLEN-1)
 S NOUT=NOUT+1,TEXTOUT(NOUT)=TEXT
 S TEXT=INDSTR,CLEN=0
 Q
 ;
 ;============================================
BLANK ;Add a blank line (line containing just " ") to the output.
 S NOUT=NOUT+1,TEXTOUT(NOUT)=" "
 S TEXT=INDSTR,CLEN=0
 Q
 ;
 ;============================================
CHECKLEN(WORD) ;Check to see if adding the next word makes the line too long.
 ;If it does add it to the output and start a new line.
 N LENWORD,SPLEFT,TLEN
 S LENWORD=$L(WORD)
 S TLEN=CLEN+LENWORD
 I TLEN'>WIDTH D  Q
 . I WORD'[" " S WORD=WORD_" ",LENWORD=LENWORD+1
 . S TEXT=TEXT_WORD,CLEN=CLEN+LENWORD
 ;Width exceeded.
 ;If at least 70% of the width is filled go ahead and break.
 I CLEN>(0.7*WIDTH) D  Q
 . D NEWLINE
 . I WORD'[" " S WORD=WORD_" ",LENWORD=LENWORD+1
 . S TEXT=INDSTR_WORD,CLEN=LENWORD
 S SPLEFT=WIDTH-CLEN+1
 I (LENWORD-SPLEFT)<2 D  Q
 . D NEWLINE
 . I WORD'[" " S WORD=WORD_" ",LENWORD=LENWORD+1
 . S TEXT=INDSTR_WORD,CLEN=LENWORD
 S TEXT=TEXT_$E(WORD,1,SPLEFT-1)
 D NEWLINE
 S WORD=$E(WORD,SPLEFT,LENWORD)
 D CHECKLEN(WORD)
 Q
 ;
 ;============================================
COLFMT(FMTSTR,TEXTSTR,PC,NL,OUTPUT) ;Columnar text formatter.
 ;FMTSTR - format string; ^ separated string for each column in the
 ;output. 35R2 defines a right justified column 35 characters wide
 ;with 2 blank spaces following. Columns can be centered (C) left
 ;justified (L) or right justified (R).
 ;TEXTSTR - string to be formated, text for each column separated by "^"
 ;PC - the pad character
 ;NL - number of lines of output
 ;OUTPUT - array containing output lines.
 N COLOUT,ENTRY,FMT,JND,JUS,IND,LEN,NCOL,NLO,NROW
 N SP,TEMP,TEXT,TEXTOUT,WIDTH,WPSP
 S NCOL=$L(FMTSTR,U),NROW=1
 F IND=1:1:NCOL D
 . S FMT=$P(FMTSTR,U,IND)
 . S JUS(IND)=$S(FMT["C":"C",FMT["L":"L",FMT["R":"R",1:"C")
 . S WIDTH(IND)=$P(FMT,JUS(IND),1)
 . S SP(IND)=$P(FMT,JUS(IND),2)
 . S WPSP(IND)=WIDTH(IND)+SP(IND)
 F IND=1:1:NCOL D
 . S ENTRY=$S(JUS(IND)="C":"CJ",JUS(IND)="L":"LJ",JUS(IND)="R":"RJ")
 . S TEMP=$P(TEXTSTR,U,IND)
 . S LEN=$L(TEMP)
 . I LEN'>WIDTH(IND) D
 .. S TEMP=$$@ENTRY^XLFSTR(TEMP,WIDTH(IND),PC)
 .. S COLOUT(1,IND)=TEMP_$$LJ^XLFSTR("",SP(IND)," ")
 . I LEN>WIDTH(IND) D
 .. D FORMATS(1,WIDTH(IND),TEMP,.NLO,.TEXTOUT)
 .. F JND=1:1:NLO D
 ... S TEMP=$$@ENTRY^XLFSTR(TEXTOUT(JND),WIDTH(IND),PC)
 ... S COLOUT(JND,IND)=TEMP_$$LJ^XLFSTR("",SP(IND)," ")
 .. I NLO>NROW S NROW=NLO
 F IND=1:1:NROW D
 . S TEXT=""
 . F JND=1:1:NCOL D
 .. I $D(COLOUT(IND,JND)) S TEXT=TEXT_COLOUT(IND,JND)
 .. E  S TEXT=TEXT_$$LJ^XLFSTR("",(WPSP(JND))," ")
 . S OUTPUT(IND)=TEXT
 S NL=NROW
 Q
 ;
 ;============================================
COLFMTA(FMTSTR,INPUT,PC,NL,OUTPUT) ;Columnar text formatter.
 ;Array version of COLFMT. Input array is ^TMP($J,INPUT,M) and
 ;output is ^TMP(OUTPUT,$J,N,0).
 N COLOUT,ENTRY,FMT,JND,JUS,IND,LEN,NCOL,NLO,NROW,NUM
 N SP,TEMP,TEXT,WIDTH,WPSP
 S NCOL=$L(FMTSTR,U)
 F IND=1:1:NCOL D
 . S FMT=$P(FMTSTR,U,IND)
 . S JUS(IND)=$S(FMT["C":"C",FMT["L":"L",FMT["R":"R",1:"C")
 . S WIDTH(IND)=$P(FMT,JUS(IND),1)
 . S SP(IND)=$P(FMT,JUS(IND),2)
 . S WPSP(IND)=WIDTH(IND)+SP(IND)
 S NL=0,NUM=""
 F  S NUM=$O(^TMP($J,INPUT,NUM)) Q:NUM=""  D
 . K COLOUT
 . S NROW=1
 . F IND=1:1:NCOL D
 .. S ENTRY=$S(JUS(IND)="C":"CJ",JUS(IND)="L":"LJ",JUS(IND)="R":"RJ")
 .. S TEMP=$P(^TMP($J,INPUT,NUM),U,IND)
 .. S LEN=$L(TEMP)
 .. I LEN'>WIDTH(IND) D
 ... S TEMP=$$@ENTRY^XLFSTR(TEMP,WIDTH(IND),PC)
 ... S COLOUT(1,IND)=TEMP_$$LJ^XLFSTR("",SP(IND)," ")
 .. I LEN>WIDTH(IND) D
 ... D FORMATS(1,WIDTH(IND),TEMP,.NLO,.TEXTOUT)
 ... F JND=1:1:NLO D
 .... S TEMP=$$@ENTRY^XLFSTR(TEXTOUT(JND),WIDTH(IND),PC)
 .... S COLOUT(JND,IND)=TEMP_$$LJ^XLFSTR("",SP(IND)," ")
 ... I NLO>NROW S NROW=NLO
 . F IND=1:1:NROW D
 .. S TEXT=""
 .. F JND=1:1:NCOL D
 ... I $D(COLOUT(IND,JND)) S TEXT=TEXT_COLOUT(IND,JND)
 ... E  S TEXT=TEXT_$$LJ^XLFSTR("",(WPSP(JND))," ")
 .. S NL=NL+1,^TMP(OUTPUT,$J,NL,0)=TEXT
 Q
 ;
 ;============================================
FORMAT(LM,RM,NIN,TEXTIN,NOUT,TEXTOUT) ;Format the text in TEXTIN so it has
 ;a left margin of LM and a right margin of RM. The formatted text
 ;is in TEXTOUT. "\\" is the end of line marker. Lines ending with
 ;"\\" will not have anything appended to them. A blank line can
 ;be created with a line containing just "\\". Lines containing
 ;nothing but whitespace will also act like a "\\".
 I NIN=0 S NOUT=0 Q
 N ACHAR,ALLWSP,CHAR,CLEN,END,IND,INDENT,INDSTR,JND
 N LWSP,NWSP,START,TEMP,TEXT,TLEN,WIDTH,W1,W2,WORD
 ;Catalog the whitespace so we have places to break and look for
 ;end of line markers.
 F IND=1:1:NIN D
 . S TEMP=TEXTIN(IND)
 . I TEMP="" S TEMP=" "
 . S TLEN=$L(TEMP)
 . S ALLWSP=1,NWSP=0
 . F JND=1:1:TLEN D
 .. S CHAR=$E(TEMP,JND)
 .. S ACHAR=$A(CHAR)
 .. I ACHAR>32 S ALLWSP=0
 .. E  S NWSP=NWSP+1,LWSP(IND,NWSP)=JND
 .;Mark the end of the line unless it is already whitespace.
 . I ACHAR>32 S NWSP=NWSP+1,LWSP(IND,NWSP)=TLEN
 . S LWSP(IND)=NWSP
 . I ALLWSP S LWSP(IND,"ALLWSP")=""
 I LM<1 S LM=1
 S WIDTH=RM-LM+1
 S INDENT=LM-1
 S INDSTR=""
 F IND=1:1:INDENT S INDSTR=INDSTR_" "
 S NOUT=0
 S TEXT=INDSTR,CLEN=0
 F IND=1:1:NIN D
 .;If there is a blank line force whatever is in TEXT to be output by
 .;calling NEWLINE and then add the blank.
 . I $D(LWSP(IND,"ALLWSP")) D NEWLINE,BLANK Q
 . S TEMP=TEXTIN(IND)
 . S (END,NWSP)=0
 . F NWSP=1:1:LWSP(IND) D
 .. S START=END+1,END=LWSP(IND,NWSP)
 .. S WORD=$E(TEMP,START,END)
 .. I WORD["\\" D  Q
 ... S W1=$P(WORD,"\\",1)
 ... D CHECKLEN(W1)
 ... D NEWLINE
 ... S W2=$P(WORD,"\\",2)
 ... I W2'="" D CHECKLEN(W2)
 .. D CHECKLEN(WORD)
 ;Output the last line.
 D NEWLINE
 Q
 ;
 ;============================================
FORMATS(LM,RM,TEXTLINE,NOUT,TEXTOUT) ;Take a single line of input text
 ;and format it.
 N TEXTIN
 S TEXTIN(1)=TEXTLINE
 D FORMAT(LM,RM,1,.TEXTIN,.NOUT,.TEXTOUT)
 Q
 ;
 ;============================================
LMFMTSTR(VALMDDF,JSTR) ;The List Manager variable VALMDDF contains the
 ;list template caption column formatting information. It contains
 ;the starting column and the width in the form
 ;VALMDDF(COLUMN NAME)=COLUMN NAME^COLUMN^WIDTH^CAPTION^VIDEO^SCROLL
 ;LOCK. JUSSTR, which is optional,is the justification for each column;
 ;(L=left, C=center, R=right) the default is center. Use this information
 ;to build the format string for the column formatter COLFMT.
 N CN,COL,FMTSTR,IND,JC,JUSSTR,PLCOL,SCOL,SP,TEMP,WIDTH
 ;Sort by columns
 S IND=""
 F  S IND=$O(VALMDDF(IND)) Q:IND=""  D
 . S TEMP=VALMDDF(IND)
 . S COL($P(TEMP,U,2))=$P(TEMP,U,3)
 S JUSSTR=$G(JSTR)
 S (CN,PLCOL,SCOL,SP)=0
 S FMTSTR=""
 S SCOL=0
 F  S SCOL=$O(COL(SCOL)) Q:SCOL=""  D
 . S CN=CN+1
 . S WIDTH=COL(SCOL)
 . I CN=1 S PLCOL=WIDTH
 . E  S SP=SCOL-PLCOL-1,FMTSTR=FMTSTR_SP_U,PLCOL=SCOL+WIDTH-1
 . S JC=$E(JUSSTR,CN)
 . I JC="" S JC="C"
 . S TEMP=WIDTH_JC
 . S FMTSTR=FMTSTR_TEMP
 Q FMTSTR
 ;
