IBDEI0OL ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11049,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Oth Specified
 ;;^UTILITY(U,$J,358.3,11049,1,4,0)
 ;;=4^N39.498
 ;;^UTILITY(U,$J,358.3,11049,2)
 ;;=^5015686
 ;;^UTILITY(U,$J,358.3,11050,0)
 ;;=R15.9^^42^502^1
 ;;^UTILITY(U,$J,358.3,11050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11050,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Other Specified
 ;;^UTILITY(U,$J,358.3,11050,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,11050,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,11051,0)
 ;;=R32.^^42^502^4
 ;;^UTILITY(U,$J,358.3,11051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11051,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,11051,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,11051,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,11052,0)
 ;;=R15.9^^42^502^2
 ;;^UTILITY(U,$J,358.3,11052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11052,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,11052,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,11052,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,11053,0)
 ;;=F63.0^^42^503^1
 ;;^UTILITY(U,$J,358.3,11053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11053,1,3,0)
 ;;=3^Gambling Disorder
 ;;^UTILITY(U,$J,358.3,11053,1,4,0)
 ;;=4^F63.0
 ;;^UTILITY(U,$J,358.3,11053,2)
 ;;=^5003640
 ;;^UTILITY(U,$J,358.3,11054,0)
 ;;=F99.^^42^504^1
 ;;^UTILITY(U,$J,358.3,11054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11054,1,3,0)
 ;;=3^Mental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,11054,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,11054,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,11055,0)
 ;;=F06.8^^42^504^3
 ;;^UTILITY(U,$J,358.3,11055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11055,1,3,0)
 ;;=3^Mental Disorders,Oth Specified,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,11055,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,11055,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,11056,0)
 ;;=F09.^^42^504^4
 ;;^UTILITY(U,$J,358.3,11056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11056,1,3,0)
 ;;=3^Mental Disorders,Unspec,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,11056,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,11056,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,11057,0)
 ;;=F99.^^42^504^2
 ;;^UTILITY(U,$J,358.3,11057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11057,1,3,0)
 ;;=3^Mental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,11057,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,11057,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,11058,0)
 ;;=F84.0^^42^505^7
 ;;^UTILITY(U,$J,358.3,11058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11058,1,3,0)
 ;;=3^Autism Spectrum Disorder Assoc w/ a Known Med/Genetic Cond or Environ Factor
 ;;^UTILITY(U,$J,358.3,11058,1,4,0)
 ;;=4^F84.0
 ;;^UTILITY(U,$J,358.3,11058,2)
 ;;=^5003684
 ;;^UTILITY(U,$J,358.3,11059,0)
 ;;=F80.9^^42^505^10
 ;;^UTILITY(U,$J,358.3,11059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11059,1,3,0)
 ;;=3^Communication Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,11059,1,4,0)
 ;;=4^F80.9
 ;;^UTILITY(U,$J,358.3,11059,2)
 ;;=^5003678
 ;;^UTILITY(U,$J,358.3,11060,0)
 ;;=F82.^^42^505^11
 ;;^UTILITY(U,$J,358.3,11060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11060,1,3,0)
 ;;=3^Developmental Coordination Disorder
 ;;^UTILITY(U,$J,358.3,11060,1,4,0)
 ;;=4^F82.
 ;;^UTILITY(U,$J,358.3,11060,2)
 ;;=^5003683
 ;;^UTILITY(U,$J,358.3,11061,0)
 ;;=F88.^^42^505^12
 ;;^UTILITY(U,$J,358.3,11061,1,0)
 ;;=^358.31IA^4^2
