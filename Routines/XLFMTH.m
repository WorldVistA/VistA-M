XLFMTH ;SF-ISC/RWF,HINES/CFB,DW - MATH FUNCTIONS;07/16/93  10:21 ;03/03/95  15:29
 ;;8.0;KERNEL;;Jul 10, 1995
ABS(X) ;absolute value
 Q $S(X<0:-X,1:X)
LN(X,PR) ;log base e
 N L,M,N,O,P,Y,LIM S PR=$$PR($G(PR),11) D A G Q
LOG(X,PR) ;log base 10
 N L,M,N,O,P,Y,LIM S PR=$$PR($G(PR),11) D A S Y=Y/2.30258509298749 G Q
 ;
A S M=1 I X>0 F N=0:1 Q:(X/M)<10  S M=M*10
 I X<1 F N=0:-1 Q:(X/M)>.1  S M=M*.1
 S X=X/M
B S X=(X-1)/(X+1),(Y,L)=X D LIM F O=3:2 S L=L*X*X,M=L/O,Y=M+Y S:M<0 M=-M Q:M<LIM
 S Y=Y*2+(N*2.30258509298749) Q
 ;
EXP(X,PR) ;e to the X power
 N L,M,N,O,P,Y,LIM S PR=$$PR($G(PR),11) D EX G Q
 ;
EX S (Y,L)=X,Y=Y+1 D LIM F O=2:1 S L=L*X/O,Y=Y+L Q:($TR(L,"-")<LIM)
 Q
PWR(Y,X,PR) ;X to the Y power
 N L,M,N,O,P,LIM S PR=$$PR($G(PR),11) D P G Q
 ;
P S:X<0 X=X*-1,Y=1/Y S P=X,X=Y D A S X=Y*P D EX
 Q
LIM S LIM=$S((PR+3)'>11:PR+3,1:11),@("LIM=1E-"_LIM) Q
 ;
Q Q +$J(Y,0,$S((PR-$L(Y\1))'<0:PR-$L(Y\1),1:0))
PR(PR,PL) Q $S('$L(PR):PL,PR>PL:PL,1:PR)
E(PR) ;e
 N Y S Y=2.71828182845905 S PR=$$PR($G(PR),12) G Q
PI(PR) ;PI
 N Y S Y=3.14159265358979 S PR=$$PR($G(PR),12) G Q
 ;
SQRT(X,PR) ;square root of X
 N Y,T S Y=0,PR=$$PR($G(PR),12) Q:X'>0 Y S Y=X+.5
L F  S T=Y,Y=X/T+T/2 Q:Y'<T
 G Q
SD(%S1,%S2,%N) ;%S1=SUM, %S2=SUM OF SQUARES, %N=COUNT
 N %X,%SD S %SD=-1,%X=-1 Q:%N<2 %SD
 S %X=%N*%S2-(%S1*%S1)/(%N*(%N-1)),%SD=$$SQRT(%X),%X=%S1/%N Q %SD
MIN(%1,%2) Q $S(%1<%2:%1,1:%2)
MAX(%1,%2) Q $S(%1<%2:%2,1:%1)
 ;
DMSDEC(X,PR) ;degrees:min:sec to decimal
 N Y S PR=$$PR($G(PR),12),Y=$P(X,":")+($P(X,":",2)/60)+($P(X,":",3)/3600) G Q
DECDMS(X,PR) ;decimal to degrees:min:sec
 N Y S PR=$$PR($G(PR),5),Y=X\1,X=X-(X\1)*60,Y=Y_":"_(X\1),X=X-(X\1)*60,X=+$J(X,0,$S((PR-$L(X\1))'<0:PR-$L(X\1),1:0)) Q Y_":"_X
DTR(X,PR) ;degrees to radians
 N Y S Y=X*3.14159265358979/180 S PR=$$PR($G(PR),12) G Q
RTD(X,PR) ;radians to degrees
 N Y S Y=X*180/3.14159265358979 S PR=$$PR($G(PR),12) G Q
SINDEG(X,PR) ;sine in degrees
 S:X[":" X=$$DMSDEC(X,12) S PR=$$PR($G(PR),10),X=$$DTR(X) Q $$SIN(X,PR)
SIN(X,PR) ;sine in radians
 N L,M,N,O,P,Y,LIM,SIGN S PR=$$PR($G(PR),10) D S G Q
S S X=X#(2*3.14159265358979),(Y,L)=X,SIGN=-1 D LIM F O=3:2 S L=L/(O-1)*X/O*X,Y=Y+(SIGN*L) Q:($TR(L,"-")<LIM)  S SIGN=SIGN*-1
 Q
CSCDEG(X,PR) ;cosecant in degrees
 S:X[":" X=$$DMSDEC(X,12) S PR=$$PR($G(PR),10),X=$$DTR(X) Q $$CSC(X,PR)
CSC(X,PR) ;cosecant in radians
 N L,M,N,O,P,Y,LIM,SIGN S PR=$$PR($G(PR),10) D S S Y=1/Y G Q
COSDEG(X,PR) ;cosine in degrees
 S:X[":" X=$$DMSDEC(X,12) S PR=$$PR($G(PR),10),X=$$DTR(X) Q $$COS(X,PR)
COS(X,PR) ;cosine in radians
 N L,M,N,O,P,Y,LIM,SIGN S PR=$$PR($G(PR),10) D C G Q
C S X=X#(2*3.14159265358979),(Y,L)=1,SIGN=-1 D LIM F O=2:2 S L=L*X*X/(O-1*O),Y=Y+(SIGN*L) Q:($TR(L,"-")<LIM)  S SIGN=SIGN*-1
 Q
SECDEG(X,PR) ;secant in degrees
 S:X[":" X=$$DMSDEC(X,12) S PR=$$PR($G(PR),10),X=$$DTR(X) Q $$SEC(X,PR)
SEC(X,PR) ;secant in radians
 N L,M,N,O,P,Y,LIM,SIGN S PR=$$PR($G(PR),10) D C S Y=1/Y G Q
TANDEG(X,PR) ;tangent in degrees
 S:X[":" X=$$DMSDEC(X,12) S PR=$$PR($G(PR),10),X=$$DTR(X) Q $$TAN(X,PR)
TAN(X,PR) ;tangent in radians
 N L,M,N,O,P,Y,LIM,S,SIGN S PR=$$PR($G(PR),10) D S S S=Y D C S Y=S/Y G Q
COTDEG(X,PR) ;cotangent in degrees
 S:X[":" X=$$DMSDEC(X,12) S PR=$$PR($G(PR),10),X=$$DTR(X) Q $$COT(X,PR)
COT(X,PR) ;contangent in radians
 N L,M,N,O,P,Y,LIM,C,SIGN S PR=$$PR($G(PR),10) D C S C=Y D S S Y=C/Y G Q
ASINDEG(X,PR) ;arc-sine in degrees
 G ASIND^XLFMTH1
ASIN(X,PR) ;arc-sine in radians
 G ASIN^XLFMTH1
ACOSDEG(X,PR) ;arc-cosine in degrees
 G ACOSD^XLFMTH1
ACOS(X,PR) ;arc-cosine in radians
 G ACOS^XLFMTH1
ATANDEG(X,PR) ;arc-tangent in degrees
 G ATAND^XLFMTH1
ATAN(X,PR) ;arc-tangent in radians
 G ATAN^XLFMTH1
ACOTDEG(X,PR) ;arc-cotangent in degrees
 G ACOTD^XLFMTH1
ACOT(X,PR) ;arc-cotangent in radians
 G ACOT^XLFMTH1
ASECDEG(X,PR) ;arc-secant in degrees
 G ASECD^XLFMTH1
ASEC(X,PR) ;arc-secant in radians
 G ASEC^XLFMTH1
ACSCDEG(X,PR) ;arc-cosecant in degrees
 G ACSCD^XLFMTH1
ACSC(X,PR) ;arc-cosecant in radians
 G ACSC^XLFMTH1
