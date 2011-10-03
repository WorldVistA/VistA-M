TIULS ; SLC/JER - String Library functions ;10/7/94  17:18 [1/5/04 11:29am]
 ;;1.0;TEXT INTEGRATION UTILITIES;**178**;Jun 20, 1997
 ;
 ;                   **** WARNING ****
 ;
 ; Any patch which makes ANY changes to this rtn must include a
 ;note in the patch desc reminding sites to update the Imaging
 ;Gateway.  See IA # 3622.
 ; IN ADDITION, if changes are made to components used by Imaging,
 ;namely, MIXED, backward compatibility may not be enough. If
 ;changes call additional rtns, TIU should consult with Imaging
 ;on need to add additional rtns to list of TIU rtns copied for
 ;Imaging Gateway.
 ;                         ****
 ;
TIME(X,FMT) ; Recieves X as 2910419.01 and FMT=Return Format of time (HH:MM:SS).
 N HR,MIN,SEC,TIUI
 I $S('$D(FMT):1,'$L(FMT):1,1:0) S FMT="HR:MIN"
 S X=$P(X,".",2),HR=$E(X,1,2)_$E("00",0,2-$L($E(X,1,2))),MIN=$E(X,3,4)_$E("00",0,2-$L($E(X,3,4))),SEC=$E(X,5,6)_$E("00",0,2-$L($E(X,5,6)))
 F TIUI="HR","MIN","SEC" S:FMT[TIUI FMT=$P(FMT,TIUI)_@TIUI_$P(FMT,TIUI,2)
 Q FMT
DATE(X,FMT) ; Call with X=2910419.01 and FMT=Return Format of date ("MM/DD")
 N AMTH,MM,CC,DD,YY,TIUI,TIUTMP
 I +X'>0 S $P(TIUTMP," ",$L($G(FMT))+1)="",FMT=TIUTMP G QDATE
 I $S('$D(FMT):1,'$L(FMT):1,1:0) S FMT="MM/DD/YY"
 S MM=$E(X,4,5),DD=$E(X,6,7),YY=$E(X,2,3),CC=17+$E(X)
 S:FMT["AMTH" AMTH=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+MM)
 F TIUI="AMTH","MM","DD","CC","YY" S:FMT[TIUI FMT=$P(FMT,TIUI)_@TIUI_$P(FMT,TIUI,2)
 I FMT["HR" S FMT=$$TIME(X,FMT)
QDATE Q FMT
NAME(X,FMT) ; Call with X="LAST,FIRST MI", FMT=Return Format ("LAST, FI")
 N TIULAST,TIULI,TIUFIRST,TIUFI,TIUMI,TIUI
 I X']"" S FMT="" G NAMEX
 I $S('$D(FMT):1,'$L(FMT):1,1:0) S FMT="LAST,FIRST"
 S FMT=$$LOWER(FMT)
 S TIULAST=$P(X,","),TIULI=$E(TIULAST),TIUFIRST=$P(X,",",2)
 S TIUFI=$E(TIUFIRST)
 S TIUMI=$S($P(TIUFIRST," ",2)'="NMI":$E($P(TIUFIRST," ",2)),1:"")
 S TIUFIRST=$P(TIUFIRST," ")
 F TIUI="last","li","first","fi","mi" I FMT[TIUI S FMT=$P(FMT,TIUI)_@("TIU"_$$UPPER(TIUI))_$P(FMT,TIUI,2)
NAMEX Q FMT
INAME(X) ; Call with X="FIRST MI[.] LAST[,M.D.]", RETURNS "LAST,FIRST MI"
 N LAST,FIRST,MIDDLE,NAME,MI
 I X'?1.A1" ".E S NAME=X G INAMEX
 S NAME=$P(X,","),FIRST=$P(NAME," "),MIDDLE=$S($L(NAME," ")=3:$P(NAME," ",2),1:"")
 S LAST=$P(NAME," ",$L(NAME," ")),MI=$S($L(MIDDLE):$E(MIDDLE),1:"")
 S NAME=LAST_","_FIRST_$S($L(MI):" "_MI,1:"")
INAMEX Q NAME
WORD(X,FMT) ; Call with X=Word Processing array root, FMT=Wrap Width
 N X,DIWL,DIWF,TIUI K ^UTILITY($J,"W")
 S DIWL=2,DIWF="WRC"_FMT
 S TIUI=0 F  S TIUI=$O(@X@(TIUI)) Q:TIUI'>0  S X=^(TIUI,0) D ^DIWP
 D ^DIWW K ^UTILITY($J,"W")
 Q ""
UPPER(X) ; Convert lower case X to UPPER CASE
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
LOWER(X) ; Convert UPPER CASE X to lower case
 Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
MIXED(X) ; Return Mixed Case X
 N TIUI,WORD,TMP
 S TMP="" F TIUI=1:1:$L(X," ") S WORD=$$UPPER($E($P(X," ",TIUI)))_$$LOWER($E($P(X," ",TIUI),2,$L($P(X," ",TIUI)))),TMP=$S(TMP="":WORD,1:TMP_" "_WORD)
 Q TMP
STRIP(TEXT) ; Strips white space from text
 N TIUTI,TIUX
 ; First remove TABS
 F TIUTI=1:1:$L(TEXT) S:$A(TEXT,TIUTI)=9 TEXT=$E(TEXT,1,(TIUTI-1))_" "_$E(TEXT,(TIUTI+1),$L(TEXT))
 S TIUX="" F TIUTI=1:1:$L(TEXT," ") S:$A($P(TEXT," ",TIUTI))>0 TIUX=TIUX_$S(TIUTI=1:"",1:" ")_$P(TEXT," ",TIUTI)
 S TEXT=TIUX S:$P(TEXT," ")']"" TEXT=$P(TEXT," ",2,$L(TEXT," "))
 Q TEXT
SIGNAME(TIUDA) ; Get/Return Signature Block Printed Name
 Q $P($G(^VA(200,+TIUDA,20)),U,2)
SIGTITL(TIUDA) ; Get/Return Signature Block Printed Name
 Q $P($G(^VA(200,+TIUDA,20)),U,3)
CENTER(X) ; Center X
 N SP
 S $P(SP," ",((IOM-$L(X))\2))=""
 Q $G(SP)_X
URGENCY(X) ; Input transform for urgency codes
 Q $S($$UPPER(X)="STAT":"P",1:$E(X))
FILL(X,Y,LEN) ; Append ", "_X to Y, unless Y would excede LEN
 Q $S('$L(Y):X,($L(Y_$C(44)_" "_X)'>LEN):Y_$C(44)_" "_X,1:X)
PARSE(X,Y) ; Parse string X, return array Y with list of words from X
 N I,WORD
 F I=1:1:$L(X," ") D
 . S WORD=$P(X," ",I),WORD=$TR(WORD,".,!&?/|\{}[];:=+*^%$#@~`""><")
 . S:WORD]"" Y(I)=$$UPPER(WORD)
 Q
HASNUM(X) ; Boolean - evaluates whether X contains a number
 N I,Y F I=0:1:9 I X[I S Y=1
 Q +$G(Y)
WRAP(TEXT,LENGTH) ; Breaks text string into substrings of length LENGTH
 N TIUI,TIUJ,LINE,TIUX,TIUX1,TIUX2,TIUY
 I $G(TEXT)']"" Q ""
 F TIUI=1:1 D  Q:TIUI=$L(TEXT," ")
 . S TIUX=$P(TEXT," ",TIUI)
 . I $L(TIUX)>LENGTH D
 . . S TIUX1=$E(TIUX,1,LENGTH),TIUX2=$E(TIUX,LENGTH+1,$L(TIUX))
 . . S $P(TEXT," ",TIUI)=TIUX1_" "_TIUX2
 S LINE=1,TIUX(1)=$P(TEXT," ")
 F TIUI=2:1 D  Q:TIUI'<$L(TEXT," ")
 . S:$L($G(TIUX(LINE))_" "_$P(TEXT," ",TIUI))>LENGTH LINE=LINE+1,TIUY=1
 . S TIUX(LINE)=$G(TIUX(LINE))_$S(+$G(TIUY):"",1:" ")_$P(TEXT," ",TIUI),TIUY=0
 S TIUJ=0,TEXT="" F TIUI=1:1 S TIUJ=$O(TIUX(TIUJ)) Q:+TIUJ'>0  S TEXT=TEXT_$S(TIUI=1:"",1:"|")_TIUX(TIUJ)
 Q TEXT
