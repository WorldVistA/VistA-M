RGUT ;CAIRO/DKM - General purpose utilities;17-Sep-1998 14:14;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; Replaces delimited arguments in string, returning result
MSG(%RGTXT,%RGDLM) ;
 N %RGZ1,%RGZ2
 I $$NEWERR^%ZTER N $ET S $ET=""
 S:$G(%RGDLM)="" %RGDLM="%"
 S %RGZ2="",%RGTXT=$TR(%RGTXT,"~","^"),@$$TRAP^RGZOSF("M1^RGUT")
 F  Q:%RGTXT=""  D
 .S %RGZ2=%RGZ2_$P(%RGTXT,%RGDLM),%RGZ1=$P(%RGTXT,%RGDLM,2),%RGTXT=$P(%RGTXT,%RGDLM,3,999)
 .I %RGZ1="" S:%RGTXT'="" %RGZ2=%RGZ2_%RGDLM
 .E  X "S %RGZ2=%RGZ2_("_%RGZ1_")"
M1 Q %RGZ2
 ; Case-insensitive string comparison
 ; Returns 0: X=Y, 1: X>Y, -1: X<Y
STRICMP(X,Y) ;
 S X=$$UP^XLFSTR(X),Y=$$UP^XLFSTR(Y)
 Q $S(X=Y:0,X]]Y:1,1:-1)
 ; Output an underline X bytes long
UND(X) Q $$REPEAT^XLFSTR("-",$G(X,$G(IOM,80)))
 ; Truncate a string if > Y bytes long
TRUNC(X,Y) ;
 Q $S($L(X)'>Y:X,1:$E(X,1,Y-3)_"...")
 ; Formatting for singular/plural
SNGPLR(RGNUM,RGSNG,RGPLR) ;
 N RGZ
 S RGZ=RGSNG?.E1L.E,RGPLR=$G(RGPLR,RGSNG_$S(RGZ:"s",1:"S"))
 Q $S('RGNUM:$S(RGZ:"no ",1:"NO ")_RGPLR,RGNUM=1:"1 "_RGSNG,1:RGNUM_" "_RGPLR)
 ; Convert code to external form from set of codes
SET(RGCODE,RGSET) ;
 N RGZ,RGZ1
 F RGZ=1:1:$L(RGSET,";") D  Q:RGZ1'=""
 .S RGZ1=$P(RGSET,";",RGZ),RGZ1=$S($P(RGZ1,":")=RGCODE:$P(RGZ1,":",2),1:"")
 Q RGZ1
 ; Replace each occurrence of RGOLD in RGSTR with RGNEW
SUBST(RGSTR,RGOLD,RGNEW) ;
 N RGP,RGL1,RGL2
 S RGNEW=$G(RGNEW),RGP=0,RGL1=$L(RGOLD),RGL2=$L(RGNEW)
 F  S RGP=$F(RGSTR,RGOLD,RGP) Q:'RGP  D
 .S RGSTR=$E(RGSTR,1,RGP-RGL1-1)_RGNEW_$E(RGSTR,RGP,9999)
 .S RGP=RGP-RGL1+RGL2
 Q RGSTR
 ; Trim leading (Y=-1)/trailing (Y=1)/leading & trailing (Y=0) spaces
TRIM(X,Y) ;
 N RGZ1,RGZ2
 S Y=+$G(Y),RGZ1=1,RGZ2=$L(X)
 I Y'>0 F RGZ1=1:1 Q:$A(X,RGZ1)'=32
 I Y'<0 F RGZ2=RGZ2:-1 Q:$A(X,RGZ2)'=32
 Q $E(X,RGZ1,RGZ2)
 ; Format a number with commas
FMTNUM(RGNUM) ;
 N RGZ,RGZ1,RGZ2
 S:RGNUM<0 RGNUM=-RGNUM,RGZ2="-"
 F RGZ=$L(RGNUM):-3:1 S RGZ1=$E(RGNUM,RGZ-2,RGZ)_$S($D(RGZ1):","_RGZ1,1:"")
 Q $G(RGZ2)_$G(RGZ1)
 ; Convert X to base Y padded to length L
BASE(X,Y,L) ;
 Q:(Y<2)!(Y>62) ""
 N RGZ,RGZ1
 S RGZ1="",X=$S(X<0:-X,1:X)
 F  S RGZ=X#Y,X=X\Y,RGZ1=$C($S(RGZ<10:RGZ+48,RGZ<36:RGZ+55,1:RGZ+61))_RGZ1 Q:'X
 Q $S('$G(L):RGZ1,1:$$REPEAT^XLFSTR(0,L-$L(RGZ1))_$E(RGZ1,1,L))
 ; Convert a string to its SOUNDEX equivalent
SOUNDEX(RGVALUE) ;
 N RGCODE,RGSOUND,RGPREV,RGCHAR,RGPOS,RGTRANS
 S RGCODE="01230129022455012623019202"
 S RGSOUND=$C($A(RGVALUE)-(RGVALUE?1L.E*32))
 S RGPREV=$E(RGCODE,$A(RGVALUE)-64)
 F RGPOS=2:1 S RGCHAR=$E(RGVALUE,RGPOS) Q:","[RGCHAR  D  Q:$L(RGSOUND)=4
 .Q:RGCHAR'?1A
 .S RGTRANS=$E(RGCODE,$A(RGCHAR)-$S(RGCHAR?1U:64,1:96))
 .Q:RGTRANS=RGPREV!(RGTRANS=9)
 .S RGPREV=RGTRANS
 .S:RGTRANS'=0 RGSOUND=RGSOUND_RGTRANS
 Q $E(RGSOUND_"000",1,4)
 ; Display formatted title
TITLE(RGTTL,RGVER,RGFN) ;
 I '$D(IOM) N IOM,IOF S IOM=80,IOF="#"
 S RGVER=$G(RGVER,"1.0")
 S:RGVER RGVER="Version "_RGVER
 U $G(IO,$I)
 W @IOF,$S(IO=IO(0):$C(27,91,55,109),1:""),*13,$$^RGCVTDT(+$H_","),?(IOM-$L(RGTTL)\2),RGTTL,?(IOM-$L(RGVER)),RGVER,!,$S(IO=IO(0):$C(27,91,109),1:$$UND),!
 W:$D(RGFN) ?(IOM-$L(RGFN)\2),RGFN,!
 Q
 ; Create a unique 8.3 filename
UFN(Y) N X
 S Y=$E($G(Y),1,3),X=$$BASE($R(100)_$J_$TR($H,","),36,$S($L(Y):8,1:11))_Y
 Q $E(X,1,8)_"."_$E(X,9,11)
 ; Return formatted SSN
SSN(X) Q $S(X="":X,1:$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,12))
 ; Performs security check on patient access
DGSEC(Y) N DIC
 S DIC(0)="E"
 D ^DGSEC
 Q $S(Y<1:0,1:Y)
 ; Displays spinning icon to indicate progress
WORKING(RGST,RGP,RGS) ;
 Q:'$D(IO(0))!$D(ZTQUEUED) 0
 N RGZ
 S RGZ(0)=$I,RGS=$G(RGS,"|/-\"),RGST=+$G(RGST)
 S RGST=$S(RGST<0:0,1:RGST#$L(RGS)+1)
 U IO(0)
 W:'$G(RGP) *8,$S(RGST:$E(RGS,RGST),1:" ")
 R *RGZ:0
 U RGZ(0)
 Q RGZ=94
 ; Ask for Y/N response
ASK(RGP,RGD,RGZ) ;
 S RGD=$G(RGD,"N")
 S RGZ=$$GETCH(RGP_"? ","YN")
 S:RGZ="" RGZ=$E(RGD)
 W !
 Q $S(RGZ[U:"",1:RGZ="Y")
 ; Pause for user response
PAUSE(RGP,RGX,RGY) ;
 Q $$GETCH($G(RGP,"Press RETURN or ENTER to continue..."),U,.RGX,.RGY)
 ; Single character read
GETCH(RGP,RGV,RGX,RGY,RGT,RGD) ;
 N RGZ,RGC
 W:$D(RGX)!$D(RGY) $$XY($G(RGX,$X),$G(RGY,$Y))
 W $G(RGP)
 S RGT=$G(RGT,$G(DTIME,999999999999)),RGD=$G(RGD,U),RGC=""
 S:$D(RGV) RGV=$$UP^XLFSTR(RGV)_U
 F  D  Q:'$L(RGZ)
 .R RGZ#1:RGT
 .E  S RGC=RGD Q
 .W *8
 .Q:'$L(RGZ)
 .S RGZ=$$UP^XLFSTR(RGZ)
 .I $D(RGV) D
 ..I RGV[RGZ S RGC=RGZ
 ..E  W *7,*32,*8 S RGC=""
 .E  S RGC=RGZ
 W !
 Q RGC
 ; Position cursor
XY(DX,DY) ;
 D:$G(IOXY)="" HOME^%ZIS
 S DX=$S(+$G(DX)>0:+DX,1:0),DY=$S(+$G(DY)>0:+DY,1:0),$X=0
 X IOXY
 S $X=DX,$Y=DY
 Q ""
 ; Parameterized calls to date routines
%DT(RGD,RGX) ;
 N %D,%P,%C,%H,%I,%X,%Y,RGZ
 D DT^DILF($G(RGX),RGD,.RGZ)
 W:$D(RGZ(0)) RGZ(0),!
 Q $G(RGZ,-1)
%DTC(X1,X2) ;
 N X3
 S X2=$$%DTF(X1)+X2,X1=X1\1,X3=X2\1,X2=X2-X3
 S:X2<0 X3=X3-1,X2=X2+1
 Q $$FMADD^XLFDT(X1,X3)+$J($$%DTT(X2),0,6)
%DTD(X1,X2) ;
 Q $$FMDIFF^XLFDT(X1\1,X2\1)+($$%DTF(X1)-$$%DTF(X2))
%DTF(X) S X=X#1*100
 Q X\1*3600+(X*100#100\1*60)+(X*10000#100)/86400
%DTT(X) S X=X*86400
 Q X\3600*100+(X#3600/3600*60)/10000
 ; THE FOLLOWING ENTRY POINTS WILL BE PHASED OUT IN FAVOR OF
 ; THEIR EQUIVALENTS WITHIN KERNEL
 ; Normalize global root
GBL(RGGBL) ;
 Q $$CREF^DILF(RGGBL)
 ; Convert lower to upper case
UPCASE(X) Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ; Convert upper to lower case
LOCASE(X) Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 ; Return a string of X repeated Y times
RPT(X,Y) Q $$REPEAT^XLFSTR(X,Y)
%DTDW(X) Q $$DOW^XLFDT(X)
%DTDOW(X) ;
 Q $$DOW^XLFDT(X,1)
%DTNOW() Q $$NOW^XLFDT
%DTH(X) Q $$FMTH^XLFDT(X)
%DTYX(X) Q $$HTFM^XLFDT(X)
