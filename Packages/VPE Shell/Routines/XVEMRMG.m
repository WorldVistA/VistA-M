XVEMRMG ;DJB/VRR**Goto Tag+Offset,XINDEX ;2019-08-20  5:29 PM
 ;;15.2;VICTORY PROG ENVIRONMENT;;Aug 27, 2019
 ; Original Code authored by David J. Bolduc 1985-2005
 ; Replace of ^XVEMS("ZS",3) & correct call to XINDEX (c) 2016 Sam Habiel
 ; XINDEX uses buffer code to XINDEX rather than saved code (c) 2019 Sam Habiel
 ;
EN ;
 I '$D(^TMP("XVV","IR"_VRRS,$J,1)) W $C(7) Q
 I $G(^TMP("XVV","IR"_VRRS,$J,1))=" <> <> <>" W $C(7) Q
 NEW FLAGQ,TAG,OFFSET
 Q:$G(LN)'["+"
 S TAG=$P(LN,"+",1)
 S OFFSET=$P(LN,"+",2) Q:OFFSET'>0
 S FLAGQ=0
 D FINDTAG Q:FLAGQ
 D OFFSET
 Q
 ;
FINDTAG ;Find line tag that contains TXT
 NEW CHK,I,TG,TMP
 S CHK=0
 F I=1:1 S TMP=$G(^TMP("XVV","IR"_VRRS,$J,I)) Q:TMP']""  Q:TMP=" <> <> <>"  D  Q:CHK
 . Q:TMP'[$C(30)
 . D GETTAG Q:TG'[TAG
 . ;Note: FLAGMENU=YND^XVVT("TOP")^YCUR^XCUR
 . S FLAGMENU=I_"^"_I_"^"_1
 . S CHK=1
 I 'CHK S FLAGQ=1,(XCUR,YCUR)=0 D MSG^XVEMRUM(16)
 Q
 ;
GETTAG ;Get tag from scroll array and convert to external format
 S TG=$P(TMP," "_$C(30),1)
 I TG?1.N1." " S TG="" Q
 F  Q:$E(TG)'=" "  S TG=$E(TG,2,999) ;Strip starting spaces
 Q
 ;
OFFSET ;Go to offset
 NEW HELP,NUM,X
 ;Convert node array number to line number
 S (NUM,X)=$P(FLAGMENU,U,1)
 S OFFSET=NUM+OFFSET
 F  S X=$O(^TMP("XVV","IR"_VRRS,$J,X)) Q:X'>0  D  Q:NUM=OFFSET
 . I ^(X)[$C(30) S NUM=NUM+1
 ;Show at least 1 line of code
 I X'>0 S X=$O(^TMP("XVV","IR"_VRRS,$J,""),-1) S:X>1 X=X-1
 S FLAGMENU=X_"^"_X_"^"_1
 Q
 ;====================================================================
 ;====================================================================
INDEX ;Run XINDEX
 I $T(^XINDEX)=""!($T(^XPDRSUM)="") DO  QUIT
 . W !,"XINDEX or XPDRSUM isn't present..."
 . D PAUSE^XVEMKC(2)
 ;
 D SYMTAB^XVEMKST("S","VRR",VRRS) ;......Save symbol table
 ;
 N RTN S RTN=$G(^TMP("XVV","VRR",$J,VRRS,"NAME"))
 W !,"*** RUNNING XINDEX ("_RTN_") ***",!
 ;
 D CONVERT^XVEMRV(VRRS) ; This kills ^UTILITY($J) and puts rtn in it
 ;
 ; Set up ^UTILITY nodes the way XINDEX likes them
 S ^UTILITY($J,RTN)=""
 M ^UTILITY($J,1,RTN,0)=^UTILITY($J,0)
 K ^UTILITY($J,0)
 N %,%1 F %=0:0 S %=$O(^UTILITY($J,1,RTN,0,%)) Q:'%  S %1=^(%) K ^(%) S ^(%,0)=%1 ; **NAKED INLINE**
 S ^UTILITY($J,1,RTN,0,0)=$O(^UTILITY($J,1,RTN,0," "),-1)
 S ^UTILITY($J,1,RTN,"RSUM")="B"_$$SUMB^XPDRSUM($NA(^UTILITY($J,1,RTN,0)))
 ;
 ; XINDEX Parameters
 N NRO S NRO=1 ; # of routines
 N Q,RTN,I,INP,INDDA,ROU ; XINDEX eats ROU; rest are XINDEX variables
 D PARAM^XINDX6
 S INP(1)=0,INP(6)=1 ;More then errors,Summary Only
 ;
 ; Call XINDEX. Change IOM and IOSL to use the user settings rather than the terminal's
 S IOM=XVV("IOM"),IOSL=XVV("IOSL")
 D ALIVE^XINDEX
 R !,"Press return to continue...",XVV("TIME")
 ;
 ; Return
 D SYMTAB^XVEMKST("R","VRR",VRRS) ;......Restore symbol table
 D ZS3^XVSS ; X ^XVEMS("ZS",3) ;.........Reset VShell variables
 Q
