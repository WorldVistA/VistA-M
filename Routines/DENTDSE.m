DENTDSE ;WISC/MLH-DENTAL SCREEN HANDLER-PROCESS FIELD > 80 CHAR IN LENGTH ;9/1/92  10:26
 ;;1.2;DENTAL;***15**;Oct 08, 1992
RESPONSE(MHX,MHFL,MHDX,MHDY) ;    process a response from the user
 N DX,DY,DEHAR,MHY,QUIT,X
 ;
 S X=0 X ^%ZOSF("RM") ;    turn off auto wrap
 X ^%ZOSF("EOFF") ;    turn off echo
 S DX=MHDX,DY=MHDY X IOXY ;    position cursor
 S MHY="" ;    the output string
 ;
 ;    read and process characters until the user says quit
 S QUIT=0
 FOR  D RD Q:QUIT  D:DEHAR>31!(DEHAR=126) PROC Q:QUIT  ;    don't process control chars or tilde
 ;
 ;    did user enter anything?
 I MHY="" S MHY=MHX ;    nope, default to input
 S X=+$G(IOM) X ^%ZOSF("RM") ;    reset margin
 X ^%ZOSF("EON") ;    echo on
 QUIT MHY_"~"_(QUIT'=2) ;    second piece indicates a timeout
 ;
RD ;    read one character
 R *DEHAR:DTIME
 IF DEHAR'=-1,DEHAR'=13,DEHAR'=27
 E  S QUIT=$S(DEHAR=-1:2,1:1) ;    bailout (QUIT=1) or timeout (QUIT=2)
 Q
 ;
PROC ;    process one character
 I DEHAR'=127 D  ;    process ordinary character
 .  D PROCCHAR
 E  I MHY'="" D PROCDEL ;    process <DELETE> if possible
 ;I $L(MHY)'<MHFL S QUIT=1
 Q
 ;
PROCCHAR ;    process ordinary character
 IF $L(MHY)<MHFL D  ;    not at the end yet
 .  W $C(DEHAR)
 .  I MHDX<79 S MHDX=MHDX+1
 .  E  S (DY,MHDY)=MHDY+1,(DX,MHDX)=0 X IOXY
 .  S MHY=MHY_$C(DEHAR)
 .  Q
 ELSE  D  ;    we're at the end, start overwriting
 .  W *8,*7,$C(DEHAR) ;    get rid of the last char
 .  S $E(MHY,MHFL)=$C(DEHAR)
 .  Q
 ;END IF
 ;
 Q
 ;
PROCDEL ;    process <DELETE>
 I MHDX>0 W $C(8,32,8) S MHDX=MHDX-1
 E  S (DX,MHDX)=79,(DY,MHDY)=MHDY-1 X IOXY W " "
 S MHY=$E(MHY,1,$L(MHY)-1)
 Q
 ;
MLH ;TEST TAG
 W @IOF S TEST=$$^DENTDSE($G(TEST),110,0,10)
 Q
