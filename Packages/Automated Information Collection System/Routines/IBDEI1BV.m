IBDEI1BV ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21215,1,4,0)
 ;;=4^F98.1
 ;;^UTILITY(U,$J,358.3,21215,2)
 ;;=^5003712
 ;;^UTILITY(U,$J,358.3,21216,0)
 ;;=N39.498^^95^1054^3
 ;;^UTILITY(U,$J,358.3,21216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21216,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Oth Specified
 ;;^UTILITY(U,$J,358.3,21216,1,4,0)
 ;;=4^N39.498
 ;;^UTILITY(U,$J,358.3,21216,2)
 ;;=^5015686
 ;;^UTILITY(U,$J,358.3,21217,0)
 ;;=R15.9^^95^1054^1
 ;;^UTILITY(U,$J,358.3,21217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21217,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Other Specified
 ;;^UTILITY(U,$J,358.3,21217,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,21217,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,21218,0)
 ;;=R32.^^95^1054^4
 ;;^UTILITY(U,$J,358.3,21218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21218,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,21218,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,21218,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,21219,0)
 ;;=R15.9^^95^1054^2
 ;;^UTILITY(U,$J,358.3,21219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21219,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,21219,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,21219,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,21220,0)
 ;;=F63.0^^95^1055^1
 ;;^UTILITY(U,$J,358.3,21220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21220,1,3,0)
 ;;=3^Gambling Disorder
 ;;^UTILITY(U,$J,358.3,21220,1,4,0)
 ;;=4^F63.0
 ;;^UTILITY(U,$J,358.3,21220,2)
 ;;=^5003640
 ;;^UTILITY(U,$J,358.3,21221,0)
 ;;=F99.^^95^1056^1
 ;;^UTILITY(U,$J,358.3,21221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21221,1,3,0)
 ;;=3^Mental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,21221,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,21221,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,21222,0)
 ;;=F06.8^^95^1056^3
 ;;^UTILITY(U,$J,358.3,21222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21222,1,3,0)
 ;;=3^Mental Disorders,Oth Specified,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,21222,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,21222,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,21223,0)
 ;;=F09.^^95^1056^4
 ;;^UTILITY(U,$J,358.3,21223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21223,1,3,0)
 ;;=3^Mental Disorders,Unspec,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,21223,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,21223,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,21224,0)
 ;;=F99.^^95^1056^2
 ;;^UTILITY(U,$J,358.3,21224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21224,1,3,0)
 ;;=3^Mental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,21224,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,21224,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,21225,0)
 ;;=F84.0^^95^1057^7
 ;;^UTILITY(U,$J,358.3,21225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21225,1,3,0)
 ;;=3^Autism Spectrum Disorder Assoc w/ a Known Med/Genetic Cond or Environ Factor
 ;;^UTILITY(U,$J,358.3,21225,1,4,0)
 ;;=4^F84.0
 ;;^UTILITY(U,$J,358.3,21225,2)
 ;;=^5003684
 ;;^UTILITY(U,$J,358.3,21226,0)
 ;;=F80.9^^95^1057^10
 ;;^UTILITY(U,$J,358.3,21226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21226,1,3,0)
 ;;=3^Communication Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,21226,1,4,0)
 ;;=4^F80.9
 ;;^UTILITY(U,$J,358.3,21226,2)
 ;;=^5003678
 ;;^UTILITY(U,$J,358.3,21227,0)
 ;;=F82.^^95^1057^11
 ;;^UTILITY(U,$J,358.3,21227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21227,1,3,0)
 ;;=3^Developmental Coordination Disorder
