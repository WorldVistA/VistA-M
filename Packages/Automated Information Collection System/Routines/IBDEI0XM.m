IBDEI0XM ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16355,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16355,1,2,0)
 ;;=2^31620
 ;;^UTILITY(U,$J,358.3,16355,1,3,0)
 ;;=3^Endobronch Ultrasound,Use w/ Bronchs
 ;;^UTILITY(U,$J,358.3,16356,0)
 ;;=31231^^82^965^25^^^^1
 ;;^UTILITY(U,$J,358.3,16356,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16356,1,2,0)
 ;;=2^31231
 ;;^UTILITY(U,$J,358.3,16356,1,3,0)
 ;;=3^Nasal Endoscopy,Diag,Uni/Bilateral
 ;;^UTILITY(U,$J,358.3,16357,0)
 ;;=93015^^82^966^3^^^^1
 ;;^UTILITY(U,$J,358.3,16357,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16357,1,2,0)
 ;;=2^93015
 ;;^UTILITY(U,$J,358.3,16357,1,3,0)
 ;;=3^Cardiovascular Stress test, Complete
 ;;^UTILITY(U,$J,358.3,16358,0)
 ;;=93017^^82^966^2^^^^1
 ;;^UTILITY(U,$J,358.3,16358,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16358,1,2,0)
 ;;=2^93017
 ;;^UTILITY(U,$J,358.3,16358,1,3,0)
 ;;=3^Cardiovascular Stress Test,Tracing Only
 ;;^UTILITY(U,$J,358.3,16359,0)
 ;;=94620^^82^966^5^^^^1
 ;;^UTILITY(U,$J,358.3,16359,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16359,1,2,0)
 ;;=2^94620
 ;;^UTILITY(U,$J,358.3,16359,1,3,0)
 ;;=3^Pulmonary Stress test, simple
 ;;^UTILITY(U,$J,358.3,16360,0)
 ;;=94621^^82^966^4^^^^1
 ;;^UTILITY(U,$J,358.3,16360,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16360,1,2,0)
 ;;=2^94621
 ;;^UTILITY(U,$J,358.3,16360,1,3,0)
 ;;=3^Pulmonary Stress Test, Cmplx
 ;;^UTILITY(U,$J,358.3,16361,0)
 ;;=93016^^82^966^1^^^^1
 ;;^UTILITY(U,$J,358.3,16361,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16361,1,2,0)
 ;;=2^93016
 ;;^UTILITY(U,$J,358.3,16361,1,3,0)
 ;;=3^Cardiovascular Stress Test Only w/o Rpt
 ;;^UTILITY(U,$J,358.3,16362,0)
 ;;=90471^^82^967^1^^^^1
 ;;^UTILITY(U,$J,358.3,16362,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16362,1,2,0)
 ;;=2^90471
 ;;^UTILITY(U,$J,358.3,16362,1,3,0)
 ;;=3^Immunization Admin,1st Vaccine
 ;;^UTILITY(U,$J,358.3,16363,0)
 ;;=90472^^82^967^2^^^^1
 ;;^UTILITY(U,$J,358.3,16363,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16363,1,2,0)
 ;;=2^90472
 ;;^UTILITY(U,$J,358.3,16363,1,3,0)
 ;;=3^Immunization Admin,Ea Addl Vaccine
 ;;^UTILITY(U,$J,358.3,16364,0)
 ;;=90658^^82^968^1^^^^1
 ;;^UTILITY(U,$J,358.3,16364,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16364,1,2,0)
 ;;=2^90658
 ;;^UTILITY(U,$J,358.3,16364,1,3,0)
 ;;=3^Flu Vaccine IM (Flulaval)
 ;;^UTILITY(U,$J,358.3,16365,0)
 ;;=90656^^82^968^2^^^^1
 ;;^UTILITY(U,$J,358.3,16365,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16365,1,2,0)
 ;;=2^90656
 ;;^UTILITY(U,$J,358.3,16365,1,3,0)
 ;;=3^Flu Vaccine Single Dose Syringe (Afluria)
 ;;^UTILITY(U,$J,358.3,16366,0)
 ;;=90662^^82^968^3^^^^1
 ;;^UTILITY(U,$J,358.3,16366,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16366,1,2,0)
 ;;=2^90662
 ;;^UTILITY(U,$J,358.3,16366,1,3,0)
 ;;=3^Flu Vaccine High Dose Syringe (Fluzone)
 ;;^UTILITY(U,$J,358.3,16367,0)
 ;;=90732^^82^968^4^^^^1
 ;;^UTILITY(U,$J,358.3,16367,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16367,1,2,0)
 ;;=2^90732
 ;;^UTILITY(U,$J,358.3,16367,1,3,0)
 ;;=3^Pneumovax
 ;;^UTILITY(U,$J,358.3,16368,0)
 ;;=31610^^82^969^1^^^^1
 ;;^UTILITY(U,$J,358.3,16368,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16368,1,2,0)
 ;;=2^31610
 ;;^UTILITY(U,$J,358.3,16368,1,3,0)
 ;;=3^Incision of Windpipe
 ;;^UTILITY(U,$J,358.3,16369,0)
 ;;=31605^^82^969^3^^^^1
 ;;^UTILITY(U,$J,358.3,16369,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16369,1,2,0)
 ;;=2^31605
 ;;^UTILITY(U,$J,358.3,16369,1,3,0)
 ;;=3^Tracheostomy,Cricothyroid
 ;;^UTILITY(U,$J,358.3,16370,0)
 ;;=31603^^82^969^2^^^^1
 ;;^UTILITY(U,$J,358.3,16370,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16370,1,2,0)
 ;;=2^31603
