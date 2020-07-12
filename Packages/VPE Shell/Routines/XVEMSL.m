XVEMSL ;DJB/VSHL**VA KERNEL Library Functions [3/6/96 6:17pm];2017-08-15  5:03 PM
 ;;15.2;VICTORY PROG ENVIRONMENT;;Aug 27, 2019
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
EN ;Entry Point
 NEW CNT,COL,COLUMNS,COLCNT,HD,LAST,PROMPT,SET,SPACES,WIDTH,WRITE
 NEW CNTOLD,DX,DY,FLAGQ,I,OPT,TEST,TXT,XVVS,X,Y
 I $G(XVVSHL)'="RUN" NEW XVV
 S FLAGQ=0 D INIT Q:FLAGQ
 X XVVS("RM0")
TOP ;
 F  S FLAGQ=0 D HD^XVEMSHY,LIST,GETOPT Q:FLAGQ  D RUN Q:FLAGQ
EX ;
 X XVVS("RM0") W @XVV("IOF")
 Q
GETOPT ;
 X PROMPT S OPT=$$READ^XVEMKRN()
 I OPT="^" S FLAGQ=1 Q
 I ",<ESC>,<F1E>,<F1Q>,<TAB>,<TO>,"[(","_XVV("K")_",") S FLAGQ=1 Q
 I XVV("K")="<RET>" S OPT=CNT Q
 I XVV("K")?1"<A"1A1">" S CNTOLD=CNT D ARROW S OPT=CNT D REDRAW G GETOPT
 S OPT=$$ALLCAPS^XVEMKU(OPT),TEST=0 D  I TEST Q
 . F I=1:1 S X=$P($T(MENU+I),";",5) Q:X=""  I $E(X,1,$L(OPT))=OPT S (CNT,OPT)=I,TEST=1 Q
 G GETOPT
ARROW ;Arrow Keys
 I "<AU>,<AD>"[XVV("K") D  S COL=$P($T(MENU+CNT),";",3) Q
 . I XVV("K")="<AU>" S CNT=CNT-1 S:CNT<1 CNT=LAST Q
 . I XVV("K")="<AD>" S CNT=CNT+1 S:CNT>LAST CNT=1
 I XVV("K")="<AR>" Q:COL=COLCNT  D  D ADJUST Q
 . S CNT=CNT+COL(COL),COL=COL+1 S:CNT>LAST CNT=LAST
 I XVV("K")="<AL>" Q:COL=1  D  D ADJUST Q
 . S COL=COL-1,CNT=CNT-COL(COL)
 Q
RUN ;Run selected routine
 S X=$P($T(MENU+OPT),";",6) I X="QUIT" S FLAGQ=1 Q
 NEW CNT,COL,COLUMNS,COLCNT,HD,LAST,PROMPT,SET,SPACES,WIDTH,WRITE
 I X]"" W @XVV("IOF") D @X X XVVS("RM0")
 Q
LIST ;List Menu Options
 F I=1:1 S TXT=$T(MENU+I) Q:TXT=""!(TXT[";***")   X SET,WRITE
 S TXT=$T(MENU+CNT) Q:TXT=""  X SET W @XVV("RON") X WRITE W @XVV("ROFF")
 Q
REDRAW ;User moved cursor
 S TXT=$T(MENU+CNTOLD) X SET,WRITE
 S TXT=$T(MENU+CNT) X SET W @XVV("RON") X WRITE W @XVV("ROFF")
 Q
ADJUST ;Adjust CNT when you switch columns.
 F  Q:$P($T(MENU+CNT),";",3)=COL  S CNT=CNT-1
 Q
INIT ;Initialize variables
 S COLUMNS="5",WIDTH=30
 S HD="VA   K E R N E L   7.1   L I B R A R Y   F U N C T I O N S"
 D INIT^XVEMSHY
 Q
MENU ;MENU OPTIONS
 ;;1;Date Functions.........XLFDT;DATE FUNCTIONS;HELP^XVEMKT("DATE");7;4
 ;;1;String Functions.......XLFSTR;STRING FUNCTIONS;HELP^XVEMKT("STRING");7;6
 ;;1;Math Functions.........XLFMTH;MATH FUNCTIONS;HELP^XVEMKT("MATH");7;8
 ;;1;Measurement Functions..XLFMSMT;MEASUREMENT FUNCTIONS;HELP^XVEMKT("MEAS");7;10
 ;;1;Quit;QUIT;QUIT;7;12
