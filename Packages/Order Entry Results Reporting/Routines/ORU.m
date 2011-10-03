ORU ; slc/dcm,JER - OE/RR Functions ;6/1/92  09:13
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**11,69**;Dec 17, 1997
UPPER(X) ; Convert lower case X to UPPER CASE
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
LOWER(X) ; Convert UPPER CASE X to lower case
 Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
MIXED(X) ; Return Mixed Case X
 N GMI,WORD,TMP
 S TMP="" F GMI=1:1:$L(X," ") S WORD=$$UPPER($E($P(X," ",GMI)))_$$LOWER($E($P(X," ",GMI),2,$L($P(X," ",GMI)))),TMP=TMP_" "_WORD
 Q TMP
INV() ;
 N DX,DY
 G:'$L($G(X))!($E(IOST)'="C") INVX
 W:$Y>24 @IOF
 W:$X>79 !
 S DX=$X,DY=$Y
 W @X
 X ^%ZOSF("XY")
INVX ;
 I $E(IOST)'="C",($L($G(X))) W:$Y'<IOSL @IOF W:$X>(IOM-1) ! W @X
 Q ""
HON() ; High intensity on
 I $E($G(IOST))="C",$D(ORTERM(7)),$L($P(ORTERM(7),"^")) W @$P(ORTERM(7),"^")
 Q ""
HOFF() ; High intensity off
 I $E($G(IOST))="C",$D(ORTERM(7)),$L($P(ORTERM(7),"^",3)) W @$P(ORTERM(7),"^",3)
 Q ""
TIME(X,FMT) ; Recieves X as 2910419.01 and FMT=Return Format of time (HH:MM:SS).
 N HR,MIN,SEC,ORI
 I $S('$D(FMT):1,'$L(FMT):1,1:0) S FMT="HR:MIN"
 S (HR,MIN,SEC)="",X=$P(X,".",2)
 I '$L(X),FMT["HR" S FMT=$P(FMT,"HR")
 I $L(X) S HR=$E(X,1,2)_$E("00",0,2-$L($E(X,1,2))),MIN=$E(X,3,4)_$E("00",0,2-$L($E(X,3,4))),SEC=$E(X,5,6)_$E("00",0,2-$L($E(X,5,6)))
 F ORI="HR","MIN","SEC" S:FMT[ORI FMT=$P(FMT,ORI)_@ORI_$P(FMT,ORI,2)
 Q FMT
DATE(X,FMT) ; Call with X=2910419.01 and FMT=Return Format of date ("MM/DD")
 N AMTH,MM,CC,DD,YY,ORI
 I +X'>0 S FMT="" G QDATE
 I $S('$D(FMT):1,'$L(FMT):1,1:0) S FMT="MM/DD/CCYY"
 S MM=$E(X,4,5),DD=$E(X,6,7),YY=$E(X,2,3),CC=17+$E(X)
 S:FMT["AMTH" AMTH=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+MM)
 F ORI="AMTH","MM","DD","CC","YY" S:FMT[ORI FMT=$P(FMT,ORI)_@ORI_$P(FMT,ORI,2)
 I FMT["HR" S FMT=$$TIME(X,FMT)
QDATE Q FMT
DATETIME(X,FMT) ;Gets date & time format
 Q:'$G(X) ""
 Q $$DATE(X,$S($L($G(FMT)):FMT,1:"MM/DD/CCYY HR:MIN"))
NAME(X,FMT) ; Call with X="LAST,FIRST MI", FMT=Return Format ("LAST, FI")
 N ORLAST,ORLI,ORFIRST,ORFI,ORMI,ORI
 I X']"" S FMT="" G NAMEX
 I $S('$D(FMT):1,'$L(FMT):1,1:0) S FMT="LAST,FIRST MI"
 S FMT=$$LOWER(FMT)
 S ORLAST=$P(X,","),ORLI=$E(ORLAST),ORFIRST=$P(X,",",2),ORFI=$E(ORFIRST),ORMI=$S($P(ORFIRST," ",2,5)'="NMI":$P(ORFIRST," ",2,5),1:""),ORFIRST=$P(ORFIRST," ")
 F ORI="last","li","first","fi","mi" I FMT[ORI S FMT=$P(FMT,ORI)_@("OR"_$$UPPER(ORI))_$P(FMT,ORI,2)
NAMEX Q FMT
SSN(X,FMT) ;Call with Unformatted SSN
 I '$L(X) Q ""
 S FMT=$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,99)
 Q FMT
SEX(X,FMT) ;Call with unformatted SEX
 I '$L($G(X)) Q ""
 S FMT=$S($E(X)="F":"Female",1:"Male")
 Q FMT
AGE(X,FMT) ;Pass DOB to calc age
 I '$G(X) Q ""
 S FMT=$S($L(X)=7:DT-X\10000,1:"??")
 Q FMT
DOB(X,FMT) ;Pass unformatted DOB
 I '$G(X) Q ""
 I $S('$D(FMT):1,'$L(FMT):1,1:0) S FMT="MM/DD/CCYY"
 Q $$DATE(X,FMT)
WORD(OROOT,FMT) ; Call with X=Word Processing array root, FMT=Wrap Width
 I '$L($G(OROOT)) Q ""
 S:'$G(FMT) FMT=80
 N X,DIWL,DIWF,ORI
 S DIWL=2,DIWF="WRC"_FMT,ORI=0
 F  S ORI=$O(@OROOT@(ORI)) Q:ORI'>0  S X=@OROOT@(ORI,0) D ^DIWP
 D ^DIWW
 Q ""
TEXT(OROOT,FMT) ;Non DIWP version of WORD function
 I '$L($G(OROOT)) Q ""
 S:'$G(FMT) FMT=80
 N X,ORI,ORTX,ORCL,ORINDX
 S ORCL=$X,ORINDX=1,ORI=0
 F  S ORI=$O(@OROOT@(ORI)) Q:ORI'>0  S X=@OROOT@(ORI,0),X=$$FMT^ORPRS09(FMT,ORINDX,X)
 F ORI=0:0 S ORI=$O(ORTX(ORI)) Q:'ORI  D FEED Q:$G(OREND)  W:ORI'=$O(ORTX(0))&(+ORI>0) ! W ?ORCL,ORTX(ORI)
 I '$G(OREND),$G(ORPDAD),$D(ORIFN) D DAD
 Q ""
TEXTWRAP(OROOT,FMT) ;Non DIWP Word function that really Raps!
 I '$L($G(OROOT)) Q ""
 S:'$G(FMT) FMT=80
 N X,ORI,ORTX,ORCL,ORINDX
 S ORCL=$X,ORINDX=0,ORI=0
 F  S ORI=$O(@OROOT@(ORI)) Q:ORI'>0  S X=@OROOT@(ORI,0),ORINDX=ORINDX+1,X=$$FMT^ORPRS09(FMT,ORINDX,X)
 F ORI=0:0 S ORI=$O(ORTX(ORI)) Q:'ORI  D FEED Q:$G(OREND)  W:ORI'=$O(ORTX(0))&(+ORI>0) ! W ?ORCL,ORTX(ORI)
 I '$G(OREND),$G(ORPDAD),$D(ORIFN) D DAD
 Q ""
TMPWRAP(OROOT,FMT) ;Non DIWP text function that Raps for ^TMP arays
 I '$L($G(OROOT)) Q ""
 S:'$G(FMT) FMT=80
 N X,ORI,ORTX,ORCL,ORINDX
 S ORCL=$X,ORINDX=0,ORI=0
 F  S ORI=$O(@OROOT@(ORI)) Q:ORI'>0  S X=$S($L($G(@OROOT@(ORI))):@OROOT@(ORI),$L($G(@OROOT@(ORI,0))):@OROOT@(ORI,0),1:""),ORINDX=ORINDX+1,X=$$FMT^ORPRS09(FMT,ORINDX,X)
 F ORI=0:0 S ORI=$O(ORTX(ORI)) Q:'ORI  D FEED Q:$G(OREND)  W:ORI'=$O(ORTX(0))&(+ORI>0) ! W ?ORCL,ORTX(ORI)
 I '$G(OREND),$G(ORPDAD),$D(ORIFN) D DAD
 Q ""
DAD ;
 N I,ORDAD
 I '$D(ORIOSL) S ORIOSL=$S($G(IOSL):IOSL,1:50)
 S ORDAD=1
 D PRT1^ORPRS03(ORIFN,FMT)
 K ORPDAD ;Set by print code in file 100.22
 Q
FEED ;Roomcheck
 Q:$G(ORTEST)
 I $Y+2<$S($G(ORIOSL):ORIOSL,1:IOSL) Q
 I $G(ORFOOT) D  Q
 . W ?(IOM-15),"(continued...)"
 . D FOOT^ORPR01(ORFOOT)
 . I '$G(OREND),$G(ORHEAD) D HEAD^ORPR01(ORHEAD) W !,"(...continued)"
 Q:$E(IOST)'="C"
 D PGBRK^ORUHDR
 W:'$D(ORTIT)&($G(ORIOF)]"") @ORIOF
 Q
