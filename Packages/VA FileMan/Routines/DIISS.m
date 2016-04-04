DIISS ;SFISC/MKO-SAVE AS %ZISS IF STANDALONE FILEMAN ;01:39 PM  21 Dec 1994
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
%ZISS ;SFISC/MKO-RETURN SCREEN HANDLING IO VARIABLES ;
 ;
 ; This routine is for standalone FileMan sites that want to use
 ; FileMan's screen-oriented utilities.  It must be saved as %ZISS
 ; in the manager account.  There are four entry points:
 ;
 ;   ENDR  - returns the IO variables required for screen handling
 ;   KILL  - kills the IO variables set by ENDR
 ;   GSET  - returns the IO variables required to draw lines
 ;   GKILL - kills the IO variables set by GSET
 ;
 ; The input variable to all of these entry points is
 ;
 ;   IOST  - the terminal type name (e.g., C-VT100)
 ;
 ; The terminal types supported by this routine are C-VT100,
 ; C-VT220, and C-VT320.  To support another terminal
 ; type, modify the highlighted line in subroutine GETT, and create
 ; new subroutines that sets the IO variables appropriately.
 ;
 ; Also note that %ZIS must return in IOXY the code to position the
 ; cursor at column DX and row DY.
 ;
GETT ;Based on value of IOST, returns DITT with values:
 ;  1 = C-VT100 (default)
 ;  2 = C-VT220 or C-VT320
 ;  3 = C-DATATREE
 S U="^",DIIOST=$TR(IOST," ","")
 ;
 ;******
 ;**  To recognize other terminal types, modify the following line of
 ;**  code and add new subroutines (e.g., 4 and G4 for C-QUME) that
 ;**  set the IO variables equal to the codes for that terminal type.
 ;******
 ;
 S DITT=$S("^C-VT220^C-VT320^"[(U_DIIOST_U):2,DIIOST="C-DATATREE":3,1:1)
 ;*****
 K DIIOST
 Q
ENDR ;Set screen handler IO variables
 N DITT
 D GETT,@DITT
 Q
GSET ;Set graphics variables
 N DITT
 D GETT,@("G"_DITT)
 Q
KILL ;Kill screen handler IO variables
 K IOCUU,IOCUD,IOCUF,IOCUB,IOPF1,IOPF2,IOPF3,IOPF4
 K IOFIND,IOINSERT,IOREMOVE,IOSELECT,IOPREVSC,IONEXTSC,IOHELP,IODO
 K IOKPAM,IOKPNM
 K IOKP0,IOKP1,IOKP2,IOKP3,IOKP4,IOKP5,IOKP6,IOKP7,IOKP8,IOKP9
 K IOMINUS,IOCOMMA,IOPERIOD,IOENTER
 K IOEDALL,IOEDEOP,IOELEOL,IOELALL
 K IOINHI,IOINLOW,IOINORM,IORVON,IORVOFF,IOUON,IOUOFF,IOSGR0
 K IORI,IOSTBM,IOIL,IODL,IOICH,IODCH
 K IOIRM1,IOIRM0,IOAWM0,IOAWM1
 Q
GKILL ;Kill graphics variables
 K IOG0,IOG1,IOBLC,IOBRC,IOTLC,IOTRC,IOHL,IOVL,IOLT,IOTT,IORT,IOBT,IOMT
 Q
1 ;VT100 codes
 S IOCUU=$C(27)_"[A"
 S IOCUD=$C(27)_"[B"
 S IOCUF=$C(27)_"[C"
 S IOCUB=$C(27)_"[D"
 S IOPF1=$C(27)_"OP"
 S IOPF2=$C(27)_"OQ"
 S IOPF3=$C(27)_"OR"
 S IOPF4=$C(27)_"OS"
 S IOFIND=$C(27)_"[1~"
 S IOINSERT=$C(27)_"[2~"
 S IOREMOVE=$C(27)_"[3~"
 S IOSELECT=$C(27)_"[4~"
 S IOPREVSC=$C(27)_"[5~"
 S IONEXTSC=$C(27)_"[6~"
 S IOHELP=$C(27)_"[28~"
 S IODO=$C(27)_"[29~"
 S IOKP0=$C(27)_"Op"
 S IOKP1=$C(27)_"Oq"
 S IOKP2=$C(27)_"Or"
 S IOKP3=$C(27)_"Os"
 S IOKP4=$C(27)_"Ot"
 S IOKP5=$C(27)_"Ou"
 S IOKP6=$C(27)_"Ov"
 S IOKP7=$C(27)_"Ow"
 S IOKP8=$C(27)_"Ox"
 S IOKP9=$C(27)_"Oy"
 S IOMINUS=$C(27)_"Om"
 S IOCOMMA=$C(27)_"Ol"
 S IOPERIOD=$C(27)_"On"
 S IOENTER=$C(27)_"OM"
 S IOEDEOP=$C(27)_"[J"
 S IOEDALL=$C(27)_"[2J"
 S IOELEOL=$C(27)_"[K"
 S IOELALL=$C(27)_"[2K"
 S IOAWM0=$C(27)_"[?7l"
 S IOAWM1=$C(27)_"[?7h"
 S IOINHI=$C(27)_"[1m"
 S IOINLOW=$C(27)_"[m"
 S IOINORM=$C(27)_"[m"
 S IOUON=$C(27)_"[4m"
 S IOUOFF=$C(27)_"[m"
 S IORVON=$C(27)_"[7m"
 S IORVOFF=$C(27)_"[m"
 S IOSGR0=$C(27)_"[m"
 S IORI=$C(27)_"M"
 S IOSTBM="$C(27,91)_+IOTM_"";""_+IOBM_""r"""
 S IOIL=$C(27)_"[L"
 S IODL=$C(27)_"[M"
 S IOICH=$C(27)_"[@"
 S IODCH=$C(27)_"[P"
 S IOIRM1=$C(27)_"[4h"
 S IOIRM0=$C(27)_"[4l"
 S IOKPAM=$C(27)_"="
 S IOKPNM=$C(27)_">"
 Q
G1 ;VT100 line drawing codes
 S IOG0=$C(27)_"(B"
 S IOG1=$C(27)_"(0"
 S IOBLC="m"
 S IOBRC="j"
 S IOTLC="l"
 S IOTRC="k"
 S IOHL="q"
 S IOVL="x"
 S IOLT="t"
 S IOTT="w"
 S IORT="u"
 S IOBT="v"
 S IOMT="n"
 Q
2 ;VT220 and VT320 codes
 ;The codes are the same as VT100 except for a few
 D 1
 S IOINLOW=$C(27)_"[22m"
 S IOUOFF=$C(27)_"[24m"
 S IORVOFF=$C(27)_"[27m"
 Q
G2 ;VT220 and VT320 line drawing codes
 ;The codes are the same as those for VT100s
 D G1
 Q
3 ;C-DATATREE codes
 S IOXY="W /C(DX,DY)"
 S IOCUU=$C(1)
 S IOCUD=$C(11)
 S IOCUF=$C(18)
 S IOCUB=$C(14)
 S IOPF1=$C(21)
 S IOPF2=$C(22)
 S IOPF3=$C(23)
 S IOPF4=$C(24)
 S IOEDALL=$C(12)
 S IOEDEOP=$C(255)_"EF"
 S IOELEOL=$C(255)_"EL"
 S IOELALL=""
 S IOAWM0=""
 S IOAWM1=""
 S IOINHI=$C(255)_"AB"
 S IOINLOW=$C(255)_"AA"
 S IOUON=$C(255)_"AC"
 S IOUOFF=$C(255)_"AA"
 S IORVON=$C(255)_"AE"
 S IORVOFF=$C(255)_"AA"
 S IOINORM=$C(255)_"AA"
 S IOSGR0=$C(255)_"AA"
 S IORI=""
 S IOSTBM=""
 S IOIL=""
 S IODL=""
 S IOICH=""
 S IODCH=""
 S IOIRM1=""
 S IOIRM0=""
 Q
G3 ;C-DATATREE line drawing codes
 S IOG0=""
 S IOG1=""
 S IOBLC=$C(192)
 S IOBRC=$C(217)
 S IOTLC=$C(218)
 S IOTRC=$C(191)
 S IOHL=$C(196)
 S IOVL=$C(179)
 S IOLT=$C(195)
 S IOTT=$C(194)
 S IORT=$C(180)
 S IOBT=$C(193)
 S IOMT=$C(197)
 Q
