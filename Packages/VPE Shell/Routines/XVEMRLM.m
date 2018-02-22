XVEMRLM ;DJB/VRR**RTN LBRY - Menu ;2017-08-15  2:01 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
EN ;Entry Point
 ;--> User can type ..LBRY ON/OFF to activate/deactivate Rtn Lbry.
 I ",ON,OFF,"[(","_$G(%1)_",") D ONOFF^XVEMRLU Q
 NEW CNT,COL,COLUMNS,COLCNT,HD,LAST,PROMPT,SET,SPACES,WIDTH,WRITE
 NEW CNTOLD,DX,DY,FLAGQ,I,OPT,TEST,TXT,XVVS,X,Y
 I $G(DUZ)'>0 D ID^XVEMKU Q:$G(DUZ)=""
 I '$D(XVV("OS")) NEW XVV
 S FLAGQ=0 D INIT Q:FLAGQ
 X XVVS("RM0")
TOP ;
 F  S FLAGQ=0 D HD^XVEMSHY,LIST,GETOPT Q:FLAGQ  D RUN Q:FLAGQ
EX ;
 X XVVS("RM0") W @XVV("IOF")
 Q
 ;
GETOPT ;
 X PROMPT S OPT=$$READ^XVEMKRN()
 I OPT="^" S FLAGQ=1 Q
 I ",<ESC>,<F1E>,<F1Q>,<TAB>,<TO>,"[(","_XVV("K")_",") S FLAGQ=1 Q
 I XVV("K")="<RET>" S OPT=CNT Q
 I XVV("K")?1"<A"1A1">" S CNTOLD=CNT D ARROW S OPT=CNT D REDRAW G GETOPT
 S OPT=$$ALLCAPS^XVEMKU(OPT),TEST=0 D  I TEST Q
 . F I=1:1 S X=$P($T(MENU+I),";",5) Q:X=""  I $E(X,1,$L(OPT))=OPT S (CNT,OPT)=I,COL=$P($T(MENU+I),";",3),TEST=1 Q
 G GETOPT
 ;
ARROW ;Arrow Keys
 I "<AU>,<AD>"[XVV("K") D  S COL=$P($T(MENU+CNT),";",3) Q
 . I XVV("K")="<AU>" S CNT=CNT-1 S:CNT<1 CNT=LAST Q
 . I XVV("K")="<AD>" S CNT=CNT+1 S:CNT>LAST CNT=1
 I XVV("K")="<AR>" Q:COL=COLCNT  D  D ADJUST Q
 . S CNT=CNT+COL(COL),COL=COL+1 S:CNT>LAST CNT=LAST
 I XVV("K")="<AL>" Q:COL=1  D  D ADJUST Q
 . S COL=COL-1,CNT=CNT-COL(COL)
 Q
 ;
RUN ;Run selected routine
 S X=$P($T(MENU+OPT),";",6) I X="QUIT" S FLAGQ=1 Q
 NEW CNT,COL,COLUMNS,COLCNT,HD,LAST,PROMPT,SET,SPACES,WIDTH,WRITE
 I X]"" W @XVV("IOF") D @X X XVVS("RM0")
 Q
 ;
LIST ;List Menu Options
 NEW HD
 F I=1:1 S TXT=$T(MENU+I) Q:TXT=""!(TXT[";***")  D  X SET,WRITE
 . ;
 . ;Display status of LIBRARY and VERSIONING
 . I $P(TXT,";",4)["L I B R A R Y" D  ;
 .. S X=$P(TXT,";",4)
 .. S X=X_$S($G(^XVV(19200.11,"A-STATUS"))="ON":" (Active)",1:" (Inactive)")
 .. S $P(TXT,";",4)=X
 . ;
 . I $P(TXT,";",4)["V E R S I O N I N G" D  ;
 .. S X=$P(TXT,";",4)
 .. S X=X_$S($G(^XVV(19200.112,"A-STATUS"))="ON":" (Active)",1:" (Inactive)")
 .. S $P(TXT,";",4)=X
 ;
 S TXT=$T(MENU+CNT) Q:TXT=""
 X SET W @XVV("RON") X WRITE W @XVV("ROFF")
 Q
 ;
REDRAW ;User moved cursor
 S TXT=$T(MENU+CNTOLD)
 X SET,WRITE
 S TXT=$T(MENU+CNT)
 X SET W @XVV("RON") X WRITE W @XVV("ROFF")
 Q
 ;
ADJUST ;Adjust CNT when you switch columns.
 F  Q:$P($T(MENU+CNT),";",3)=COL  S CNT=CNT-1
 Q
 ;
INIT ;Initialize variables
 S COLUMNS="7^6"
 S WIDTH=33
 S HD="ROUTINE LIBRARY/VERSIONING"
 D INIT^XVEMSHY
 S PROMPT="S DX=3,DY=22 X XVVS(""CRSR"") W ""SELECT: "",@XVVS(""BLANK_C_EOL"")"
 Q
 ;
MENU ;MENU OPTIONS
 ;;1;SO  Sign Out Routines;SO;^XVEMRLO;2;5
 ;;1;SI  Sign In Routines;SI;^XVEMRLI;2;6
 ;;1;LP  Print 'Signed Out' List;LP;^XVEMRLP;2;8
 ;;1;BE  Bulk Edit IDENTIFIER Field;BE;IDEDIT^XVEMRLI;2;9
 ;;1;BDL Bulk Delete IDENTIFIER Field;BDL;IDDEL^XVEMRLI;2;10
 ;;1;H   Help;H;HELP^XVEMKT("LIBRARY");2;12
 ;;1;Q   Quit;Q;QUIT;2;13
 ;;2;I   Inquire;I;INQ^XVEMRLY;42;5
 ;;2;U   Update Description Field;U;DESC^XVEMRLY;42;6
 ;;2;RV  Review a Version;RV;REVIEW^XVEMRLY;42;8
 ;;2;RS  Restore a Version;RS;RESTORE^XVEMRLY;42;9
 ;;2;D   Delete Version(s);D;DELETE^XVEMRLZ;42;11
 ;;2;BDV Bulk Delete Version(s);BDV;BULKDEL^XVEMRLZ;42;12
 ;;1;    L I B R A R Y;;;2;3
 ;;2;    V E R S I O N I N G;;;40;3
 ;;***
