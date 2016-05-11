IBDEI0XT ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15852,0)
 ;;=F98.1^^58^699^4
 ;;^UTILITY(U,$J,358.3,15852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15852,1,3,0)
 ;;=3^Encopresis
 ;;^UTILITY(U,$J,358.3,15852,1,4,0)
 ;;=4^F98.1
 ;;^UTILITY(U,$J,358.3,15852,2)
 ;;=^5003712
 ;;^UTILITY(U,$J,358.3,15853,0)
 ;;=N39.498^^58^699^2
 ;;^UTILITY(U,$J,358.3,15853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15853,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Oth Specified
 ;;^UTILITY(U,$J,358.3,15853,1,4,0)
 ;;=4^N39.498
 ;;^UTILITY(U,$J,358.3,15853,2)
 ;;=^5015686
 ;;^UTILITY(U,$J,358.3,15854,0)
 ;;=R15.9^^58^699^1
 ;;^UTILITY(U,$J,358.3,15854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15854,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Other Specified
 ;;^UTILITY(U,$J,358.3,15854,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,15854,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,15855,0)
 ;;=R32.^^58^699^3
 ;;^UTILITY(U,$J,358.3,15855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15855,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,15855,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,15855,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,15856,0)
 ;;=F63.0^^58^700^1
 ;;^UTILITY(U,$J,358.3,15856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15856,1,3,0)
 ;;=3^Gambling Disorder
 ;;^UTILITY(U,$J,358.3,15856,1,4,0)
 ;;=4^F63.0
 ;;^UTILITY(U,$J,358.3,15856,2)
 ;;=^5003640
 ;;^UTILITY(U,$J,358.3,15857,0)
 ;;=F99.^^58^701^1
 ;;^UTILITY(U,$J,358.3,15857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15857,1,3,0)
 ;;=3^Mental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,15857,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,15857,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,15858,0)
 ;;=F06.8^^58^701^2
 ;;^UTILITY(U,$J,358.3,15858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15858,1,3,0)
 ;;=3^Mental Disorders,Oth Specified,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,15858,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,15858,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,15859,0)
 ;;=F09.^^58^701^3
 ;;^UTILITY(U,$J,358.3,15859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15859,1,3,0)
 ;;=3^Mental Disorders,Unspec,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,15859,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,15859,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,15860,0)
 ;;=R45.851^^58^701^4
 ;;^UTILITY(U,$J,358.3,15860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15860,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,15860,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,15860,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,15861,0)
 ;;=F84.0^^58^702^1
 ;;^UTILITY(U,$J,358.3,15861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15861,1,3,0)
 ;;=3^Autistic Disorder
 ;;^UTILITY(U,$J,358.3,15861,1,4,0)
 ;;=4^F84.0
 ;;^UTILITY(U,$J,358.3,15861,2)
 ;;=^5003684
 ;;^UTILITY(U,$J,358.3,15862,0)
 ;;=F80.9^^58^702^2
 ;;^UTILITY(U,$J,358.3,15862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15862,1,3,0)
 ;;=3^Communication Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15862,1,4,0)
 ;;=4^F80.9
 ;;^UTILITY(U,$J,358.3,15862,2)
 ;;=^5003678
 ;;^UTILITY(U,$J,358.3,15863,0)
 ;;=F82.^^58^702^3
 ;;^UTILITY(U,$J,358.3,15863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15863,1,3,0)
 ;;=3^Developmental Coordination Disorder
 ;;^UTILITY(U,$J,358.3,15863,1,4,0)
 ;;=4^F82.
 ;;^UTILITY(U,$J,358.3,15863,2)
 ;;=^5003683
 ;;^UTILITY(U,$J,358.3,15864,0)
 ;;=F98.5^^58^702^4
 ;;^UTILITY(U,$J,358.3,15864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15864,1,3,0)
 ;;=3^Fluency Disorder,Adult-Onset
 ;;^UTILITY(U,$J,358.3,15864,1,4,0)
 ;;=4^F98.5
 ;;^UTILITY(U,$J,358.3,15864,2)
 ;;=^5003717
 ;;^UTILITY(U,$J,358.3,15865,0)
 ;;=F88.^^58^702^5
