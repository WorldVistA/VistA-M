IBDEI0QN ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12486,0)
 ;;=K52.2^^50^565^3
 ;;^UTILITY(U,$J,358.3,12486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12486,1,3,0)
 ;;=3^Allergic and dietetic gastroenteritis and colitis
 ;;^UTILITY(U,$J,358.3,12486,1,4,0)
 ;;=4^K52.2
 ;;^UTILITY(U,$J,358.3,12486,2)
 ;;=^5008701
 ;;^UTILITY(U,$J,358.3,12487,0)
 ;;=K52.89^^50^565^33
 ;;^UTILITY(U,$J,358.3,12487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12487,1,3,0)
 ;;=3^Noninfective Gastroenteritis/Colitis
 ;;^UTILITY(U,$J,358.3,12487,1,4,0)
 ;;=4^K52.89
 ;;^UTILITY(U,$J,358.3,12487,2)
 ;;=^5008703
 ;;^UTILITY(U,$J,358.3,12488,0)
 ;;=R19.4^^50^565^7
 ;;^UTILITY(U,$J,358.3,12488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12488,1,3,0)
 ;;=3^Change in bowel habit
 ;;^UTILITY(U,$J,358.3,12488,1,4,0)
 ;;=4^R19.4
 ;;^UTILITY(U,$J,358.3,12488,2)
 ;;=^5019273
 ;;^UTILITY(U,$J,358.3,12489,0)
 ;;=R19.8^^50^565^36
 ;;^UTILITY(U,$J,358.3,12489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12489,1,3,0)
 ;;=3^Symptoms and signs involving the dgstv sys and abdomen NEC
 ;;^UTILITY(U,$J,358.3,12489,1,4,0)
 ;;=4^R19.8
 ;;^UTILITY(U,$J,358.3,12489,2)
 ;;=^5019277
 ;;^UTILITY(U,$J,358.3,12490,0)
 ;;=R10.11^^50^565^35
 ;;^UTILITY(U,$J,358.3,12490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12490,1,3,0)
 ;;=3^Right upper quadrant pain
 ;;^UTILITY(U,$J,358.3,12490,1,4,0)
 ;;=4^R10.11
 ;;^UTILITY(U,$J,358.3,12490,2)
 ;;=^5019206
 ;;^UTILITY(U,$J,358.3,12491,0)
 ;;=R10.12^^50^565^29
 ;;^UTILITY(U,$J,358.3,12491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12491,1,3,0)
 ;;=3^Left upper quadrant pain
 ;;^UTILITY(U,$J,358.3,12491,1,4,0)
 ;;=4^R10.12
 ;;^UTILITY(U,$J,358.3,12491,2)
 ;;=^5019207
 ;;^UTILITY(U,$J,358.3,12492,0)
 ;;=R10.31^^50^565^34
 ;;^UTILITY(U,$J,358.3,12492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12492,1,3,0)
 ;;=3^Right lower quadrant pain
 ;;^UTILITY(U,$J,358.3,12492,1,4,0)
 ;;=4^R10.31
 ;;^UTILITY(U,$J,358.3,12492,2)
 ;;=^5019211
 ;;^UTILITY(U,$J,358.3,12493,0)
 ;;=R10.32^^50^565^28
 ;;^UTILITY(U,$J,358.3,12493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12493,1,3,0)
 ;;=3^Left lower quadrant pain
 ;;^UTILITY(U,$J,358.3,12493,1,4,0)
 ;;=4^R10.32
 ;;^UTILITY(U,$J,358.3,12493,2)
 ;;=^5019212
 ;;^UTILITY(U,$J,358.3,12494,0)
 ;;=R10.84^^50^565^23
 ;;^UTILITY(U,$J,358.3,12494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12494,1,3,0)
 ;;=3^Generalized abdominal pain
 ;;^UTILITY(U,$J,358.3,12494,1,4,0)
 ;;=4^R10.84
 ;;^UTILITY(U,$J,358.3,12494,2)
 ;;=^5019229
 ;;^UTILITY(U,$J,358.3,12495,0)
 ;;=R16.0^^50^565^27
 ;;^UTILITY(U,$J,358.3,12495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12495,1,3,0)
 ;;=3^Hepatomegaly, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,12495,1,4,0)
 ;;=4^R16.0
 ;;^UTILITY(U,$J,358.3,12495,2)
 ;;=^5019248
 ;;^UTILITY(U,$J,358.3,12496,0)
 ;;=R16.2^^50^565^26
 ;;^UTILITY(U,$J,358.3,12496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12496,1,3,0)
 ;;=3^Hepatomegaly with splenomegaly, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,12496,1,4,0)
 ;;=4^R16.2
 ;;^UTILITY(U,$J,358.3,12496,2)
 ;;=^5019250
 ;;^UTILITY(U,$J,358.3,12497,0)
 ;;=R18.8^^50^565^6
 ;;^UTILITY(U,$J,358.3,12497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12497,1,3,0)
 ;;=3^Ascites NEC
 ;;^UTILITY(U,$J,358.3,12497,1,4,0)
 ;;=4^R18.8
 ;;^UTILITY(U,$J,358.3,12497,2)
 ;;=^5019253
 ;;^UTILITY(U,$J,358.3,12498,0)
 ;;=R79.89^^50^565^2
 ;;^UTILITY(U,$J,358.3,12498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12498,1,3,0)
 ;;=3^Abnormal Findings of Blood Chemistry
 ;;^UTILITY(U,$J,358.3,12498,1,4,0)
 ;;=4^R79.89
 ;;^UTILITY(U,$J,358.3,12498,2)
 ;;=^5019593
