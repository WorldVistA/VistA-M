USRLS ; SLC/JER - String functions for ASU ;09/22/1998
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**3,9**;Jun 20, 1997
 ;======================================================================
CENTER(X) ; Center X
 N SP
 S $P(SP," ",((IOM-$L(X))\2))=""
 Q $G(SP)_X
 ;======================================================================
DATE(X,FMT) ; Call with X=2910419.01 and FMT=Return Format of date ("MM/DD")
 N AMTH,MM,CC,DD,YY,GMRDI,GMRDTMP
 I +X'>0 S $P(GMRDTMP," ",$L($G(FMT))+1)="",FMT=GMRDTMP G QDATE
 I $S('$D(FMT):1,'$L(FMT):1,1:0) S FMT="MM/DD/YY"
 S MM=$E(X,4,5),DD=$E(X,6,7),YY=$E(X,2,3),CC=17+$E(X)
 S:FMT["AMTH" AMTH=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+MM)
 F GMRDI="AMTH","MM","DD","CC","YY" S:FMT[GMRDI FMT=$P(FMT,GMRDI)_@GMRDI_$P(FMT,GMRDI,2)
 I FMT["HR" S FMT=$$TIME(X,FMT)
QDATE Q FMT
 ;======================================================================
MIXED(X) ; Return Mixed Case X
 N USRI,WORD,TMP
 S TMP="" F USRI=1:1:$L(X," ") S WORD=$$UP^XLFSTR($E($P(X," ",USRI)))_$$LOW^XLFSTR($E($P(X," ",USRI),2,$L($P(X," ",USRI)))),TMP=$S(TMP="":WORD,1:TMP_" "_WORD)
 Q TMP
 ;======================================================================
SIGNAME(GMDA) ; Get/Return Signature Block Printed Name
 N MSG,NAME,SBPN
 S NAME=$P(^VA(200,+GMDA,0),U,1)
 S SBPN=$P($G(^VA(200,+GMDA,20)),U,2)
 I SBPN="" D
 . S NAME=NAME_" (?SBPN)"
 Q NAME
 ;======================================================================
TIME(X,FMT) ; Recieves X as 2910419.01 and FMT=Return Format of time (HH:MM:SS).
 N HR,MIN,SEC,TIUI
 I $S('$D(FMT):1,'$L(FMT):1,1:0) S FMT="HR:MIN"
 S X=$P(X,".",2),HR=$E(X,1,2)_$E("00",0,2-$L($E(X,1,2))),MIN=$E(X,3,4)_$E("00",0,2-$L($E(X,3,4))),SEC=$E(X,5,6)_$E("00",0,2-$L($E(X,5,6)))
 F TIUI="HR","MIN","SEC" S:FMT[TIUI FMT=$P(FMT,TIUI)_@TIUI_$P(FMT,TIUI,2)
 Q FMT
 ;======================================================================
UPPER(X) ; Convert lower case X to UPPER CASE
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;======================================================================
WRAP(TEXT,LENGTH) ; Breaks text string into substrings of length LENGTH
 N USRI,USRJ,LINE,USRX,USRX1,USRX2,USRY
 I $G(TEXT)']"" Q ""
 F USRI=1:1 D  Q:USRI=$L(TEXT," ")
 . S USRX=$P(TEXT," ",USRI)
 . I $L(USRX)>LENGTH D
 . . S USRX1=$E(USRX,1,LENGTH),USRX2=$E(USRX,LENGTH+1,$L(USRX))
 . . S $P(TEXT," ",USRI)=USRX1_" "_USRX2
 S LINE=1,USRX(1)=$P(TEXT," ")
 F USRI=2:1 D  Q:USRI'<$L(TEXT," ")
 . S:$L($G(USRX(LINE))_" "_$P(TEXT," ",USRI))>LENGTH LINE=LINE+1,USRY=1
 . S USRX(LINE)=$G(USRX(LINE))_$S(+$G(USRY):"",1:" ")_$P(TEXT," ",USRI),USRY=0
 S USRJ=0,TEXT="" F USRI=1:1 S USRJ=$O(USRX(USRJ)) Q:+USRJ'>0  S TEXT=TEXT_$S(USRI=1:"",1:"|")_USRX(USRJ)
 Q TEXT
