IBDEI22Z ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35290,1,2,0)
 ;;=2^93015
 ;;^UTILITY(U,$J,358.3,35290,1,3,0)
 ;;=3^Cardiovascular Stress test, Complete
 ;;^UTILITY(U,$J,358.3,35291,0)
 ;;=93017^^132^1708^2^^^^1
 ;;^UTILITY(U,$J,358.3,35291,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35291,1,2,0)
 ;;=2^93017
 ;;^UTILITY(U,$J,358.3,35291,1,3,0)
 ;;=3^Cardiovascular Stress Test,Tracing Only
 ;;^UTILITY(U,$J,358.3,35292,0)
 ;;=94620^^132^1708^5^^^^1
 ;;^UTILITY(U,$J,358.3,35292,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35292,1,2,0)
 ;;=2^94620
 ;;^UTILITY(U,$J,358.3,35292,1,3,0)
 ;;=3^Pulmonary Stress test, simple
 ;;^UTILITY(U,$J,358.3,35293,0)
 ;;=94621^^132^1708^4^^^^1
 ;;^UTILITY(U,$J,358.3,35293,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35293,1,2,0)
 ;;=2^94621
 ;;^UTILITY(U,$J,358.3,35293,1,3,0)
 ;;=3^Pulmonary Stress Test, Cmplx
 ;;^UTILITY(U,$J,358.3,35294,0)
 ;;=93016^^132^1708^1^^^^1
 ;;^UTILITY(U,$J,358.3,35294,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35294,1,2,0)
 ;;=2^93016
 ;;^UTILITY(U,$J,358.3,35294,1,3,0)
 ;;=3^Cardiovascular Stress Test Only w/o Rpt
 ;;^UTILITY(U,$J,358.3,35295,0)
 ;;=90471^^132^1709^1^^^^1
 ;;^UTILITY(U,$J,358.3,35295,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35295,1,2,0)
 ;;=2^90471
 ;;^UTILITY(U,$J,358.3,35295,1,3,0)
 ;;=3^Immunization Admin,1st Vaccine
 ;;^UTILITY(U,$J,358.3,35296,0)
 ;;=90472^^132^1709^2^^^^1
 ;;^UTILITY(U,$J,358.3,35296,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35296,1,2,0)
 ;;=2^90472
 ;;^UTILITY(U,$J,358.3,35296,1,3,0)
 ;;=3^Immunization Admin,Ea Addl Vaccine
 ;;^UTILITY(U,$J,358.3,35297,0)
 ;;=90658^^132^1710^1^^^^1
 ;;^UTILITY(U,$J,358.3,35297,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35297,1,2,0)
 ;;=2^90658
 ;;^UTILITY(U,$J,358.3,35297,1,3,0)
 ;;=3^Flu Vaccine IM (Flulaval)
 ;;^UTILITY(U,$J,358.3,35298,0)
 ;;=90656^^132^1710^2^^^^1
 ;;^UTILITY(U,$J,358.3,35298,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35298,1,2,0)
 ;;=2^90656
 ;;^UTILITY(U,$J,358.3,35298,1,3,0)
 ;;=3^Flu Vaccine Single Dose Syringe (Afluria)
 ;;^UTILITY(U,$J,358.3,35299,0)
 ;;=90662^^132^1710^3^^^^1
 ;;^UTILITY(U,$J,358.3,35299,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35299,1,2,0)
 ;;=2^90662
 ;;^UTILITY(U,$J,358.3,35299,1,3,0)
 ;;=3^Flu Vaccine High Dose Syringe (Fluzone)
 ;;^UTILITY(U,$J,358.3,35300,0)
 ;;=90732^^132^1710^4^^^^1
 ;;^UTILITY(U,$J,358.3,35300,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35300,1,2,0)
 ;;=2^90732
 ;;^UTILITY(U,$J,358.3,35300,1,3,0)
 ;;=3^Pneumovax
 ;;^UTILITY(U,$J,358.3,35301,0)
 ;;=31610^^132^1711^1^^^^1
 ;;^UTILITY(U,$J,358.3,35301,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35301,1,2,0)
 ;;=2^31610
 ;;^UTILITY(U,$J,358.3,35301,1,3,0)
 ;;=3^Trach Fenestration w/ Skin Flaps
 ;;^UTILITY(U,$J,358.3,35302,0)
 ;;=31605^^132^1711^3^^^^1
 ;;^UTILITY(U,$J,358.3,35302,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35302,1,2,0)
 ;;=2^31605
 ;;^UTILITY(U,$J,358.3,35302,1,3,0)
 ;;=3^Tracheostomy,Emerg,Cricothyroid
 ;;^UTILITY(U,$J,358.3,35303,0)
 ;;=31603^^132^1711^2^^^^1
 ;;^UTILITY(U,$J,358.3,35303,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35303,1,2,0)
 ;;=2^31603
 ;;^UTILITY(U,$J,358.3,35303,1,3,0)
 ;;=3^Tracheostomy Emerg,Transtracheal
 ;;^UTILITY(U,$J,358.3,35304,0)
 ;;=31600^^132^1711^4^^^^1
 ;;^UTILITY(U,$J,358.3,35304,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35304,1,2,0)
 ;;=2^31600
 ;;^UTILITY(U,$J,358.3,35304,1,3,0)
 ;;=3^Tracheostomy,Planned
 ;;^UTILITY(U,$J,358.3,35305,0)
 ;;=99358^^132^1712^1^^^^1
 ;;^UTILITY(U,$J,358.3,35305,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35305,1,2,0)
 ;;=2^99358
 ;;^UTILITY(U,$J,358.3,35305,1,3,0)
 ;;=3^Prolonged Svc,Before/After Visit,1st hr
