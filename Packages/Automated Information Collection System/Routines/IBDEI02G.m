IBDEI02G ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,655,1,3,0)
 ;;=3^Gambling Disorder
 ;;^UTILITY(U,$J,358.3,655,1,4,0)
 ;;=4^F63.0
 ;;^UTILITY(U,$J,358.3,655,2)
 ;;=^5003640
 ;;^UTILITY(U,$J,358.3,656,0)
 ;;=F99.^^3^66^1
 ;;^UTILITY(U,$J,358.3,656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,656,1,3,0)
 ;;=3^Mental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,656,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,656,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,657,0)
 ;;=F06.8^^3^66^2
 ;;^UTILITY(U,$J,358.3,657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,657,1,3,0)
 ;;=3^Mental Disorders,Oth Specified,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,657,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,657,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,658,0)
 ;;=F09.^^3^66^3
 ;;^UTILITY(U,$J,358.3,658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,658,1,3,0)
 ;;=3^Mental Disorders,Unspec,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,658,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,658,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,659,0)
 ;;=R45.851^^3^66^4
 ;;^UTILITY(U,$J,358.3,659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,659,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,659,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,659,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,660,0)
 ;;=F84.0^^3^67^1
 ;;^UTILITY(U,$J,358.3,660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,660,1,3,0)
 ;;=3^Autistic Disorder
 ;;^UTILITY(U,$J,358.3,660,1,4,0)
 ;;=4^F84.0
 ;;^UTILITY(U,$J,358.3,660,2)
 ;;=^5003684
 ;;^UTILITY(U,$J,358.3,661,0)
 ;;=F80.9^^3^67^2
 ;;^UTILITY(U,$J,358.3,661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,661,1,3,0)
 ;;=3^Communication Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,661,1,4,0)
 ;;=4^F80.9
 ;;^UTILITY(U,$J,358.3,661,2)
 ;;=^5003678
 ;;^UTILITY(U,$J,358.3,662,0)
 ;;=F82.^^3^67^3
 ;;^UTILITY(U,$J,358.3,662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,662,1,3,0)
 ;;=3^Developmental Coordination Disorder
 ;;^UTILITY(U,$J,358.3,662,1,4,0)
 ;;=4^F82.
 ;;^UTILITY(U,$J,358.3,662,2)
 ;;=^5003683
 ;;^UTILITY(U,$J,358.3,663,0)
 ;;=F98.5^^3^67^4
 ;;^UTILITY(U,$J,358.3,663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,663,1,3,0)
 ;;=3^Fluency Disorder,Adult-Onset
 ;;^UTILITY(U,$J,358.3,663,1,4,0)
 ;;=4^F98.5
 ;;^UTILITY(U,$J,358.3,663,2)
 ;;=^5003717
 ;;^UTILITY(U,$J,358.3,664,0)
 ;;=F88.^^3^67^5
 ;;^UTILITY(U,$J,358.3,664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,664,1,3,0)
 ;;=3^Global Developmental Delay
 ;;^UTILITY(U,$J,358.3,664,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,664,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,665,0)
 ;;=F80.2^^3^67^6
 ;;^UTILITY(U,$J,358.3,665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,665,1,3,0)
 ;;=3^Language Disorder
 ;;^UTILITY(U,$J,358.3,665,1,4,0)
 ;;=4^F80.2
 ;;^UTILITY(U,$J,358.3,665,2)
 ;;=^331959
 ;;^UTILITY(U,$J,358.3,666,0)
 ;;=F81.2^^3^67^7
 ;;^UTILITY(U,$J,358.3,666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,666,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Mathematics
 ;;^UTILITY(U,$J,358.3,666,1,4,0)
 ;;=4^F81.2
 ;;^UTILITY(U,$J,358.3,666,2)
 ;;=^331957
 ;;^UTILITY(U,$J,358.3,667,0)
 ;;=F81.0^^3^67^8
 ;;^UTILITY(U,$J,358.3,667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,667,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Reading
 ;;^UTILITY(U,$J,358.3,667,1,4,0)
 ;;=4^F81.0
 ;;^UTILITY(U,$J,358.3,667,2)
 ;;=^5003679
 ;;^UTILITY(U,$J,358.3,668,0)
 ;;=F81.81^^3^67^9
 ;;^UTILITY(U,$J,358.3,668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,668,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Writing
 ;;^UTILITY(U,$J,358.3,668,1,4,0)
 ;;=4^F81.81
 ;;^UTILITY(U,$J,358.3,668,2)
 ;;=^5003680
