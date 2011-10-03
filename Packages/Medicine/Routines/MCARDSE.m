MCARDSE ;WISC/MLH-MEDICINE SCREEN HANDLER-PROCESS FIELD ;5/2/96  13:31
 ;;2.3;Medicine;;09/13/1996
RESPONSE(MHX,MHFL,MHDX,MHDY) ;    process a response from the user
 N DX,DY,MCHAR,MHY,QUIT,X
 ;
 S X=0 X ^%ZOSF("RM") ;    turn off auto wrap
 X ^%ZOSF("EOFF") ;    turn off echo
 S DX=MHDX,DY=MHDY X IOXY ;    position cursor
 S MHY="" ;    the output string
 ;
 ;    read and process characters until the user says quit
 S QUIT=0
 F  D RD Q:QUIT  D:MCHAR>31&(MCHAR'=126)&(MCHAR<128) PROC D:MCHAR=27 PCK Q:QUIT  ;    don't process control chars or tilde
 ;
 I MCHAR=13,(MHY[U) S MCMASS=1 K MCDID
 I $E(MHY,1)="?" S MCMASS=1 K MCDID
 I MHY="^D"!(MHY="^U") S MCMASS=1 K MCDID
 ;    did user enter anything?
 I MHY="" S MHY=MHX ;    nope, default to input
 S X=+$G(IOM) X ^%ZOSF("RM") ;    reset margin
 X ^%ZOSF("EON") ;    echo on
 S:$E(MHY,1)=U MHY=$$UPPER(MHY)
 S:$P(DJJ(V),U,4)["S" MHY=$$UPPER(MHY)
 QUIT MHY_"~"_(QUIT'=2) ;    second piece indicates a timeout
UPPER(X) ;CONVERT TO UPPERCASE
 N Y
 X ^%ZOSF("UPPERCASE")
 Q Y
 ;
RD ;    read one character
 R *MCHAR:DTIME
 I MCHAR'=-1,MCHAR'=13 ;,MCHAR'=27 ;Allow the escape charcter
 E  S QUIT=$S(MCHAR=-1:2,1:1) ;    bailout (QUIT=1) or timeout (QUIT=2)
 Q
 ;
PROC ;    process one character
 I MCHAR'=127 D  ;    process ordinary character
 .  D PROCCHAR
 E  I MHY'="" D PROCDEL ;    process <DELETE> if possible
 Q
 ;
PROCCHAR ;    process ordinary character
 IF $L(MHY)<MHFL D  ;    not at the end yet
 .  W $C(MCHAR)
 .  I MHDX<79 S MHDX=MHDX+1
 .  E  S (DY,MHDY)=MHDY+1,(DX,MHDX)=0 X IOXY
 .  S MHY=MHY_$C(MCHAR)
 .  Q
 ELSE  D  ;    we're at the end, start overwriting
 .  W $C(8,7),$C(MCHAR) ;    get rid of the last char
 .  S MHY=$$INSERT^MCU(MHY,MHFL,MCHAR)
 .  Q
 ;END IF
 Q
 ;
PROCDEL ;    process <DELETE>
 I MHDX>0 W $C(8,32,8) S MHDX=MHDX-1
 E  S (DX,MHDX)=79,(DY,MHDY)=MHDY-1 X IOXY W " "
 S MHY=$E(MHY,1,$L(MHY)-1)
 Q
 ;
MLH ;TEST TAG
 W @IOF S TEST=$$RESPONSE^MCARDSE($G(TEST),110,0,10)
 Q
PCK ;WISC/DCB-Process the escape keys see bottom for mapping
 N STR,CHR S STR=$C(27) ;Set the String to Escape
 F  R *CHR:.001 Q:CHR=-1  S STR=STR_$C(CHR) ; Clear the buffer
 I STR=IOCUD K MCDID S QUIT=1 Q
 I STR=IOKP4 D JUMP Q
 S MHY=$S(STR=IOCUB:"^U",STR=IOCUU:"<",STR=IOCUF:"^D",STR=IOPF1:"^T",STR=IOPF2:"^O",STR=IOPF3:"?",STR=IOPF4:"??",STR=IOKP1:"^C",STR=IOKP3:"^",STR=IOKP5:"^R",STR=IOKP6:" ",STR=IOKP9:"@",STR=IOKP7:"^H",1:"")
 S:MHY'="" QUIT=1
 Q
 ;
JUMP ;This allow the user to type in a field number w/o pressing return
 N NUM,LOW,HI
 S LOW=$O(DJJ("")),HI=DJL
 X DJCP X XY W DJLIN X ^%ZOSF("EON") K MCDID S MCMASS=1
 W !,"Input a field number",LOW," to ",HI," to jump to."
 R !,"Field Number: ",NUM:DTIME I ('$T)!(NUM["^") S QUIT=2 Q
 G:NUM["?" JUMP
 S NUM=+NUM
 I (NUM<LOW)!(NUM>HI) S MHY=U_V,QUIT=1 Q
 S MHY="^"_NUM,QUIT=1
 Q
