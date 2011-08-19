XTKERMIT ;SF-ISC/RWF - Kermit protocol controler ;9/14/94  08:38
 ;;7.3;TOOLKIT;;Apr 25, 1995
 ;To call from outside on KERMIT
 ;set XTKDIC = fileman type global root, DWLC = last current data node
 ;Return DWLC = last data node, XTKDIC is killed.
 ;For Send: XTKFILE = The file name for target.
 ;Optional
 ;set XTKMODE = 0 to send/receive in Image mode (no conversion)
 ;              1 to send/receive in DATA mode (just convert control char.).
 ;              2 to send/receive as TEXT (Mac) (FM word-processing).
 ;              3 to send/receive as TEXT (PC).
 ;Text mode sends a CR after each global node
 ;          make a new global node for each CR received.
S ;MENU ENTRY POINT ONLY.
 D SFILE^XTKERM4,SEND K DWLC,XTKDIC,XTKMODE Q
SEND ;Send data from host.
 D INIT^XTKERM4 G ABORT:XTKERR D READY^XTKERM4,^XTKERM1,DONE
 Q
R ;MENU ENTRY POINT ONLY.
 D RFILE^XTKERM4,RECEIVE K DWLC,XTKDIC,XTKMODE Q
RECEIVE ;Load a file into the host.
 D INIT^XTKERM4 G ABORT:XTKERR D READY^XTKERM4,^XTKERM2,DONE
 Q
 ;Close up shop
ABORT W !!,$C(7),$S($L(XTKERR)>1:XTKERR,1:"Aborting File Transfer!")
DONE D RESTORE^XTKERM4 S Y=$S(XTKERR:-1,1:1) Q
 ;Modes  0 = Image or binary, 1 = Data, 2 = Text
MODE U IO(0) S DIR(0)="8980,3",DIR("B")=$S('$D(XTKMODE):"TEXT",1:$P("IMAGE^DATA^TEXT (Mac)^TEXT (PC)",U,XTKMODE+1)) D ^DIR K DIR Q:$D(DIRUT)  S XTKMODE=+Y
 U IO
 Q
SR S DIR(0)="S^S:SEND;R:RECEIVE",DIR("A")="Send from the Host, Receive to the Host"
 D ^DIR K DIR
 Q
CLEAN K XTKERR,XTMODE,XTKDIC Q
TEST K ^TMP("XTKERM",$J),XTKDIC S XTKDEBUG=0 D SR Q:$D(DIRUT)  D @Y
 Q
KERM ;Entry from Mailman Talkman
 U IO(0) K ^TMP("XTKERM",$J),XTKDIC D SR Q:$D(DIRUT)  U IO D @Y
