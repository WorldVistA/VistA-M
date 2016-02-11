IBDEI12R ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17927,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,17927,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,17928,0)
 ;;=K52.2^^91^888^3
 ;;^UTILITY(U,$J,358.3,17928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17928,1,3,0)
 ;;=3^Allergic and dietetic gastroenteritis and colitis
 ;;^UTILITY(U,$J,358.3,17928,1,4,0)
 ;;=4^K52.2
 ;;^UTILITY(U,$J,358.3,17928,2)
 ;;=^5008701
 ;;^UTILITY(U,$J,358.3,17929,0)
 ;;=K52.89^^91^888^33
 ;;^UTILITY(U,$J,358.3,17929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17929,1,3,0)
 ;;=3^Noninfective Gastroenteritis/Colitis
 ;;^UTILITY(U,$J,358.3,17929,1,4,0)
 ;;=4^K52.89
 ;;^UTILITY(U,$J,358.3,17929,2)
 ;;=^5008703
 ;;^UTILITY(U,$J,358.3,17930,0)
 ;;=R19.4^^91^888^7
 ;;^UTILITY(U,$J,358.3,17930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17930,1,3,0)
 ;;=3^Change in bowel habit
 ;;^UTILITY(U,$J,358.3,17930,1,4,0)
 ;;=4^R19.4
 ;;^UTILITY(U,$J,358.3,17930,2)
 ;;=^5019273
 ;;^UTILITY(U,$J,358.3,17931,0)
 ;;=R19.8^^91^888^36
 ;;^UTILITY(U,$J,358.3,17931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17931,1,3,0)
 ;;=3^Symptoms and signs involving the dgstv sys and abdomen NEC
 ;;^UTILITY(U,$J,358.3,17931,1,4,0)
 ;;=4^R19.8
 ;;^UTILITY(U,$J,358.3,17931,2)
 ;;=^5019277
 ;;^UTILITY(U,$J,358.3,17932,0)
 ;;=R10.11^^91^888^35
 ;;^UTILITY(U,$J,358.3,17932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17932,1,3,0)
 ;;=3^Right upper quadrant pain
 ;;^UTILITY(U,$J,358.3,17932,1,4,0)
 ;;=4^R10.11
 ;;^UTILITY(U,$J,358.3,17932,2)
 ;;=^5019206
 ;;^UTILITY(U,$J,358.3,17933,0)
 ;;=R10.12^^91^888^29
 ;;^UTILITY(U,$J,358.3,17933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17933,1,3,0)
 ;;=3^Left upper quadrant pain
 ;;^UTILITY(U,$J,358.3,17933,1,4,0)
 ;;=4^R10.12
 ;;^UTILITY(U,$J,358.3,17933,2)
 ;;=^5019207
 ;;^UTILITY(U,$J,358.3,17934,0)
 ;;=R10.31^^91^888^34
 ;;^UTILITY(U,$J,358.3,17934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17934,1,3,0)
 ;;=3^Right lower quadrant pain
 ;;^UTILITY(U,$J,358.3,17934,1,4,0)
 ;;=4^R10.31
 ;;^UTILITY(U,$J,358.3,17934,2)
 ;;=^5019211
 ;;^UTILITY(U,$J,358.3,17935,0)
 ;;=R10.32^^91^888^28
 ;;^UTILITY(U,$J,358.3,17935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17935,1,3,0)
 ;;=3^Left lower quadrant pain
 ;;^UTILITY(U,$J,358.3,17935,1,4,0)
 ;;=4^R10.32
 ;;^UTILITY(U,$J,358.3,17935,2)
 ;;=^5019212
 ;;^UTILITY(U,$J,358.3,17936,0)
 ;;=R10.84^^91^888^23
 ;;^UTILITY(U,$J,358.3,17936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17936,1,3,0)
 ;;=3^Generalized abdominal pain
 ;;^UTILITY(U,$J,358.3,17936,1,4,0)
 ;;=4^R10.84
 ;;^UTILITY(U,$J,358.3,17936,2)
 ;;=^5019229
 ;;^UTILITY(U,$J,358.3,17937,0)
 ;;=R16.0^^91^888^27
 ;;^UTILITY(U,$J,358.3,17937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17937,1,3,0)
 ;;=3^Hepatomegaly, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,17937,1,4,0)
 ;;=4^R16.0
 ;;^UTILITY(U,$J,358.3,17937,2)
 ;;=^5019248
 ;;^UTILITY(U,$J,358.3,17938,0)
 ;;=R16.2^^91^888^26
 ;;^UTILITY(U,$J,358.3,17938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17938,1,3,0)
 ;;=3^Hepatomegaly with splenomegaly, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,17938,1,4,0)
 ;;=4^R16.2
 ;;^UTILITY(U,$J,358.3,17938,2)
 ;;=^5019250
 ;;^UTILITY(U,$J,358.3,17939,0)
 ;;=R18.8^^91^888^6
 ;;^UTILITY(U,$J,358.3,17939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17939,1,3,0)
 ;;=3^Ascites NEC
 ;;^UTILITY(U,$J,358.3,17939,1,4,0)
 ;;=4^R18.8
 ;;^UTILITY(U,$J,358.3,17939,2)
 ;;=^5019253
 ;;^UTILITY(U,$J,358.3,17940,0)
 ;;=R79.89^^91^888^2
 ;;^UTILITY(U,$J,358.3,17940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17940,1,3,0)
 ;;=3^Abnormal Findings of Blood Chemistry
