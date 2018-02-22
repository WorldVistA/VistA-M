XVEMRUM ;DJB/VRR**Messages ;2017-08-15  4:32 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
MSG(NUM) ;Msgs for rtn editor
 Q:$G(NUM)'>0  NEW XX
 S DX=0,DY=XVVT("S2") X XVVS("CRSR")
 W @XVV("RON")
 X XVVS("XY")
 D @NUM
 W ?XVV("IOM")
 S DX=0,DY=XVVT("S2")+1 X XVVS("CRSR")
 W "<RETURN> to continue.."
 W ?XVV("IOM")
 S DX=23,DY=XVVT("S2")+1 X XVVS("CRSR")
 R XX:300
 W @XVV("ROFF")
 S DX=0,DY=XVVT("S2") X XVVS("CRSR")
 W ?XVV("IOM")
 X XVVS("CRSR")
 W XVVT("FT",1)
 S DX=0,DY=XVVT("S2")+1 X XVVS("CRSR")
 W ?XVV("IOM")
 X XVVS("CRSR")
 W XVVT("FT",2)
 S DX=XCUR,DY=YCUR X XVVS("CRSR")
 Q
 ;====================================================================
1 W "Select from menu bar above." Q
2 W $C(7),"Invalid line number" Q
3 W $C(7),"Invalid selection" Q
4 W "GOTO: 'n'=Line number  MK=Mark  <TAB>=Cursor" Q
5 W $C(7),"No editing. " D  Q
 . I $G(VRRS)>1 W "You've branched to another Program." Q
 . I $G(FLAGVPE)'["EDIT" W "You're using the Routine Reader." Q
6 W $C(7),"You haven't Marked any lines" Q
7 W $C(7),"You can't Branch to more than 4 programs" Q
8 W $C(7),"Invalid Line Tag" Q
9 W $C(7),"Line Tag has an invalid subscript" Q
10 W $C(7),"Illegal Line" Q
11 W $C(7),"A line may not exceed 245 characters" Q
13 W $C(7),"Invalid RANGE" Q
15 W "Enter code you wish inserted. Use <TAB> as a line start character." Q
16 W $C(7),"No match" Q
17 W "The line will be broken AFTER the code you enter" Q
18 W $C(7),"Line numbers can't match" Q
19 W $C(7),"Joined line would be too long" Q
20 W $C(7),"You must use <TAB> as a line start character" Q
21 W "Purge complete" Q
22 W "It is invalid to replace LINES with saved CHARACTERS." Q
23 W "It is invalid to replace CHARACTERS with saved LINES." Q
