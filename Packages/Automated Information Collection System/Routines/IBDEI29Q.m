IBDEI29Q ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38466,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Oth Specified
 ;;^UTILITY(U,$J,358.3,38466,1,4,0)
 ;;=4^N39.498
 ;;^UTILITY(U,$J,358.3,38466,2)
 ;;=^5015686
 ;;^UTILITY(U,$J,358.3,38467,0)
 ;;=R15.9^^145^1869^1
 ;;^UTILITY(U,$J,358.3,38467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38467,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Other Specified
 ;;^UTILITY(U,$J,358.3,38467,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,38467,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,38468,0)
 ;;=R32.^^145^1869^3
 ;;^UTILITY(U,$J,358.3,38468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38468,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,38468,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,38468,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,38469,0)
 ;;=F63.0^^145^1870^1
 ;;^UTILITY(U,$J,358.3,38469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38469,1,3,0)
 ;;=3^Gambling Disorder
 ;;^UTILITY(U,$J,358.3,38469,1,4,0)
 ;;=4^F63.0
 ;;^UTILITY(U,$J,358.3,38469,2)
 ;;=^5003640
 ;;^UTILITY(U,$J,358.3,38470,0)
 ;;=F99.^^145^1871^1
 ;;^UTILITY(U,$J,358.3,38470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38470,1,3,0)
 ;;=3^Mental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,38470,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,38470,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,38471,0)
 ;;=F06.8^^145^1871^2
 ;;^UTILITY(U,$J,358.3,38471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38471,1,3,0)
 ;;=3^Mental Disorders,Oth Specified,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,38471,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,38471,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,38472,0)
 ;;=F09.^^145^1871^3
 ;;^UTILITY(U,$J,358.3,38472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38472,1,3,0)
 ;;=3^Mental Disorders,Unspec,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,38472,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,38472,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,38473,0)
 ;;=R45.851^^145^1871^4
 ;;^UTILITY(U,$J,358.3,38473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38473,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,38473,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,38473,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,38474,0)
 ;;=F84.0^^145^1872^1
 ;;^UTILITY(U,$J,358.3,38474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38474,1,3,0)
 ;;=3^Autistic Disorder
 ;;^UTILITY(U,$J,358.3,38474,1,4,0)
 ;;=4^F84.0
 ;;^UTILITY(U,$J,358.3,38474,2)
 ;;=^5003684
 ;;^UTILITY(U,$J,358.3,38475,0)
 ;;=F80.9^^145^1872^2
 ;;^UTILITY(U,$J,358.3,38475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38475,1,3,0)
 ;;=3^Communication Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,38475,1,4,0)
 ;;=4^F80.9
 ;;^UTILITY(U,$J,358.3,38475,2)
 ;;=^5003678
 ;;^UTILITY(U,$J,358.3,38476,0)
 ;;=F82.^^145^1872^3
 ;;^UTILITY(U,$J,358.3,38476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38476,1,3,0)
 ;;=3^Developmental Coordination Disorder
 ;;^UTILITY(U,$J,358.3,38476,1,4,0)
 ;;=4^F82.
 ;;^UTILITY(U,$J,358.3,38476,2)
 ;;=^5003683
 ;;^UTILITY(U,$J,358.3,38477,0)
 ;;=F98.5^^145^1872^4
 ;;^UTILITY(U,$J,358.3,38477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38477,1,3,0)
 ;;=3^Fluency Disorder,Adult-Onset
 ;;^UTILITY(U,$J,358.3,38477,1,4,0)
 ;;=4^F98.5
 ;;^UTILITY(U,$J,358.3,38477,2)
 ;;=^5003717
 ;;^UTILITY(U,$J,358.3,38478,0)
 ;;=F88.^^145^1872^5
 ;;^UTILITY(U,$J,358.3,38478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38478,1,3,0)
 ;;=3^Global Developmental Delay
 ;;^UTILITY(U,$J,358.3,38478,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,38478,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,38479,0)
 ;;=F80.2^^145^1872^6
