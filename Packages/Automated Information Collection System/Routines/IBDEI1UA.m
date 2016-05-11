IBDEI1UA ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31230,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,31231,0)
 ;;=F06.8^^123^1572^2
 ;;^UTILITY(U,$J,358.3,31231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31231,1,3,0)
 ;;=3^Mental Disorders,Oth Specified,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,31231,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,31231,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,31232,0)
 ;;=F09.^^123^1572^3
 ;;^UTILITY(U,$J,358.3,31232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31232,1,3,0)
 ;;=3^Mental Disorders,Unspec,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,31232,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,31232,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,31233,0)
 ;;=R45.851^^123^1572^4
 ;;^UTILITY(U,$J,358.3,31233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31233,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,31233,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,31233,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,31234,0)
 ;;=F84.0^^123^1573^1
 ;;^UTILITY(U,$J,358.3,31234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31234,1,3,0)
 ;;=3^Autistic Disorder
 ;;^UTILITY(U,$J,358.3,31234,1,4,0)
 ;;=4^F84.0
 ;;^UTILITY(U,$J,358.3,31234,2)
 ;;=^5003684
 ;;^UTILITY(U,$J,358.3,31235,0)
 ;;=F80.9^^123^1573^2
 ;;^UTILITY(U,$J,358.3,31235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31235,1,3,0)
 ;;=3^Communication Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31235,1,4,0)
 ;;=4^F80.9
 ;;^UTILITY(U,$J,358.3,31235,2)
 ;;=^5003678
 ;;^UTILITY(U,$J,358.3,31236,0)
 ;;=F82.^^123^1573^3
 ;;^UTILITY(U,$J,358.3,31236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31236,1,3,0)
 ;;=3^Developmental Coordination Disorder
 ;;^UTILITY(U,$J,358.3,31236,1,4,0)
 ;;=4^F82.
 ;;^UTILITY(U,$J,358.3,31236,2)
 ;;=^5003683
 ;;^UTILITY(U,$J,358.3,31237,0)
 ;;=F98.5^^123^1573^4
 ;;^UTILITY(U,$J,358.3,31237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31237,1,3,0)
 ;;=3^Fluency Disorder,Adult-Onset
 ;;^UTILITY(U,$J,358.3,31237,1,4,0)
 ;;=4^F98.5
 ;;^UTILITY(U,$J,358.3,31237,2)
 ;;=^5003717
 ;;^UTILITY(U,$J,358.3,31238,0)
 ;;=F88.^^123^1573^5
 ;;^UTILITY(U,$J,358.3,31238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31238,1,3,0)
 ;;=3^Global Developmental Delay
 ;;^UTILITY(U,$J,358.3,31238,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,31238,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,31239,0)
 ;;=F80.2^^123^1573^6
 ;;^UTILITY(U,$J,358.3,31239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31239,1,3,0)
 ;;=3^Language Disorder
 ;;^UTILITY(U,$J,358.3,31239,1,4,0)
 ;;=4^F80.2
 ;;^UTILITY(U,$J,358.3,31239,2)
 ;;=^331959
 ;;^UTILITY(U,$J,358.3,31240,0)
 ;;=F81.2^^123^1573^7
 ;;^UTILITY(U,$J,358.3,31240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31240,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Mathematics
 ;;^UTILITY(U,$J,358.3,31240,1,4,0)
 ;;=4^F81.2
 ;;^UTILITY(U,$J,358.3,31240,2)
 ;;=^331957
 ;;^UTILITY(U,$J,358.3,31241,0)
 ;;=F81.0^^123^1573^8
 ;;^UTILITY(U,$J,358.3,31241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31241,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Reading
 ;;^UTILITY(U,$J,358.3,31241,1,4,0)
 ;;=4^F81.0
 ;;^UTILITY(U,$J,358.3,31241,2)
 ;;=^5003679
 ;;^UTILITY(U,$J,358.3,31242,0)
 ;;=F81.81^^123^1573^9
 ;;^UTILITY(U,$J,358.3,31242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31242,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Writing
 ;;^UTILITY(U,$J,358.3,31242,1,4,0)
 ;;=4^F81.81
 ;;^UTILITY(U,$J,358.3,31242,2)
 ;;=^5003680
 ;;^UTILITY(U,$J,358.3,31243,0)
 ;;=F88.^^123^1573^10
 ;;^UTILITY(U,$J,358.3,31243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31243,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,31243,1,4,0)
 ;;=4^F88.
