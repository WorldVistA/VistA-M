IBDEI0FC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6760,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 80-89% Body Surface
 ;;^UTILITY(U,$J,358.3,6760,1,4,0)
 ;;=4^L49.8
 ;;^UTILITY(U,$J,358.3,6760,2)
 ;;=^5009198
 ;;^UTILITY(U,$J,358.3,6761,0)
 ;;=L49.9^^46^447^25
 ;;^UTILITY(U,$J,358.3,6761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6761,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ > 89% Body Surface
 ;;^UTILITY(U,$J,358.3,6761,1,4,0)
 ;;=4^L49.9
 ;;^UTILITY(U,$J,358.3,6761,2)
 ;;=^5009199
 ;;^UTILITY(U,$J,358.3,6762,0)
 ;;=Z65.5^^46^447^26
 ;;^UTILITY(U,$J,358.3,6762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6762,1,3,0)
 ;;=3^Exposure to Disaster/War/Hostilities
 ;;^UTILITY(U,$J,358.3,6762,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,6762,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,6763,0)
 ;;=Z77.22^^46^447^27
 ;;^UTILITY(U,$J,358.3,6763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6763,1,3,0)
 ;;=3^Exposure to/Contact w/ Environmental Tobacco Smoke
 ;;^UTILITY(U,$J,358.3,6763,1,4,0)
 ;;=4^Z77.22
 ;;^UTILITY(U,$J,358.3,6763,2)
 ;;=^5063324
 ;;^UTILITY(U,$J,358.3,6764,0)
 ;;=L30.9^^46^447^5
 ;;^UTILITY(U,$J,358.3,6764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6764,1,3,0)
 ;;=3^Eczema,Unspec
 ;;^UTILITY(U,$J,358.3,6764,1,4,0)
 ;;=4^L30.9
 ;;^UTILITY(U,$J,358.3,6764,2)
 ;;=^5009159
 ;;^UTILITY(U,$J,358.3,6765,0)
 ;;=L23.9^^46^447^2
 ;;^UTILITY(U,$J,358.3,6765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6765,1,3,0)
 ;;=3^Eczema,Allergic Contact,Unspec
 ;;^UTILITY(U,$J,358.3,6765,1,4,0)
 ;;=4^L23.9
 ;;^UTILITY(U,$J,358.3,6765,2)
 ;;=^5009125
 ;;^UTILITY(U,$J,358.3,6766,0)
 ;;=L20.82^^46^447^3
 ;;^UTILITY(U,$J,358.3,6766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6766,1,3,0)
 ;;=3^Eczema,Flexural
 ;;^UTILITY(U,$J,358.3,6766,1,4,0)
 ;;=4^L20.82
 ;;^UTILITY(U,$J,358.3,6766,2)
 ;;=^5009109
 ;;^UTILITY(U,$J,358.3,6767,0)
 ;;=L20.84^^46^447^4
 ;;^UTILITY(U,$J,358.3,6767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6767,1,3,0)
 ;;=3^Eczema,Intrinsic
 ;;^UTILITY(U,$J,358.3,6767,1,4,0)
 ;;=4^L20.84
 ;;^UTILITY(U,$J,358.3,6767,2)
 ;;=^5009111
 ;;^UTILITY(U,$J,358.3,6768,0)
 ;;=L51.8^^46^447^10
 ;;^UTILITY(U,$J,358.3,6768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6768,1,3,0)
 ;;=3^Erythema Multiforme,Other
 ;;^UTILITY(U,$J,358.3,6768,1,4,0)
 ;;=4^L51.8
 ;;^UTILITY(U,$J,358.3,6768,2)
 ;;=^336639
 ;;^UTILITY(U,$J,358.3,6769,0)
 ;;=R23.4^^46^447^14
 ;;^UTILITY(U,$J,358.3,6769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6769,1,3,0)
 ;;=3^Eschar/Desquamination of Skin
 ;;^UTILITY(U,$J,358.3,6769,1,4,0)
 ;;=4^R23.4
 ;;^UTILITY(U,$J,358.3,6769,2)
 ;;=^5019296
 ;;^UTILITY(U,$J,358.3,6770,0)
 ;;=L49.9^^46^447^23
 ;;^UTILITY(U,$J,358.3,6770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6770,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 90% or More Body Surface
 ;;^UTILITY(U,$J,358.3,6770,1,4,0)
 ;;=4^L49.9
 ;;^UTILITY(U,$J,358.3,6770,2)
 ;;=^5009199
 ;;^UTILITY(U,$J,358.3,6771,0)
 ;;=L74.9^^46^447^1
 ;;^UTILITY(U,$J,358.3,6771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6771,1,3,0)
 ;;=3^Eccrine Sweat Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,6771,1,4,0)
 ;;=4^L74.9
 ;;^UTILITY(U,$J,358.3,6771,2)
 ;;=^5009296
 ;;^UTILITY(U,$J,358.3,6772,0)
 ;;=L92.3^^46^448^1
 ;;^UTILITY(U,$J,358.3,6772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6772,1,3,0)
 ;;=3^FB Granuloma Skin/Subcutaneous Tissue
 ;;^UTILITY(U,$J,358.3,6772,1,4,0)
 ;;=4^L92.3
 ;;^UTILITY(U,$J,358.3,6772,2)
 ;;=^5009464
 ;;^UTILITY(U,$J,358.3,6773,0)
 ;;=L66.2^^46^448^2
 ;;^UTILITY(U,$J,358.3,6773,1,0)
 ;;=^358.31IA^4^2
