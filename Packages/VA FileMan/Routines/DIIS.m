DIIS ;SFISC/GFT-DELETE THIS LINE AND SAVE AS '%ZIS' IF YOU DON'T HAVE A '%ZIS' ROUTINE ;27OCT2011
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
%ZIS ;
 I $D(IOP)#2 S IO=$I G PARAMS
 S IO=$I ;READ "DEVICE: ",IO ;INSERT DEVICE SELECTION HERE
PARAMS S IOM=80,IOSL=24,IOF="#",IOPAR="",POP=0,ION=$P(IO,";"),IOT="TRM"
 S IO(0)=$P,IOBS="$C(8)"
 ;
 ; DIISS uses the variable IOST to determine what to set the screen
 ; handling variables to.  (See routine DIISS.)  DIISS currently
 ; looks for values of IOST equal to C-VT220 and C-VT320.  If it
 ; equals anything else, the IO variables default to the codes for
 ; C-VT100 terminals.
 ;
 ; The variable IOXY contains the code to position the cursor at
 ; column position DX and row position DY.  Unmodified, this
 ; routine sets IOXY to the code for VT100, VT220, and VT320
 ; terminals.
 ;
 S IOST="C-VT100"
 S IOXY="W $C(27,91)_(DY+1)_$C(59)_(DX+1)_$C(72)"
 Q
 ;
 ;
 ;
REWIND(IO2,IOT,IOPAR) ;Rewind Device
 Q 0
 ;
HOME ;called from DDFIX,DDMP2,DDSCLONE,DIAR,DIARR,DIARR5,DIARX,DIFGO
 S IO=$I G PARAMS
