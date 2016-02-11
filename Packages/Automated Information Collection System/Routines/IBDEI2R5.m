IBDEI2R5 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,46195,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46195,1,2,0)
 ;;=2^94620
 ;;^UTILITY(U,$J,358.3,46195,1,3,0)
 ;;=3^Pulmonary Stress test, simple
 ;;^UTILITY(U,$J,358.3,46196,0)
 ;;=94621^^204^2283^4^^^^1
 ;;^UTILITY(U,$J,358.3,46196,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46196,1,2,0)
 ;;=2^94621
 ;;^UTILITY(U,$J,358.3,46196,1,3,0)
 ;;=3^Pulmonary Stress Test, Cmplx
 ;;^UTILITY(U,$J,358.3,46197,0)
 ;;=93016^^204^2283^1^^^^1
 ;;^UTILITY(U,$J,358.3,46197,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46197,1,2,0)
 ;;=2^93016
 ;;^UTILITY(U,$J,358.3,46197,1,3,0)
 ;;=3^Cardiovascular Stress Test Only w/o Rpt
 ;;^UTILITY(U,$J,358.3,46198,0)
 ;;=90471^^204^2284^1^^^^1
 ;;^UTILITY(U,$J,358.3,46198,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46198,1,2,0)
 ;;=2^90471
 ;;^UTILITY(U,$J,358.3,46198,1,3,0)
 ;;=3^Immunization Admin,1st Vaccine
 ;;^UTILITY(U,$J,358.3,46199,0)
 ;;=90472^^204^2284^2^^^^1
 ;;^UTILITY(U,$J,358.3,46199,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46199,1,2,0)
 ;;=2^90472
 ;;^UTILITY(U,$J,358.3,46199,1,3,0)
 ;;=3^Immunization Admin,Ea Addl Vaccine
 ;;^UTILITY(U,$J,358.3,46200,0)
 ;;=90658^^204^2285^1^^^^1
 ;;^UTILITY(U,$J,358.3,46200,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46200,1,2,0)
 ;;=2^90658
 ;;^UTILITY(U,$J,358.3,46200,1,3,0)
 ;;=3^Flu Vaccine IM (Flulaval)
 ;;^UTILITY(U,$J,358.3,46201,0)
 ;;=90656^^204^2285^2^^^^1
 ;;^UTILITY(U,$J,358.3,46201,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46201,1,2,0)
 ;;=2^90656
 ;;^UTILITY(U,$J,358.3,46201,1,3,0)
 ;;=3^Flu Vaccine Single Dose Syringe (Afluria)
 ;;^UTILITY(U,$J,358.3,46202,0)
 ;;=90662^^204^2285^3^^^^1
 ;;^UTILITY(U,$J,358.3,46202,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46202,1,2,0)
 ;;=2^90662
 ;;^UTILITY(U,$J,358.3,46202,1,3,0)
 ;;=3^Flu Vaccine High Dose Syringe (Fluzone)
 ;;^UTILITY(U,$J,358.3,46203,0)
 ;;=90732^^204^2285^4^^^^1
 ;;^UTILITY(U,$J,358.3,46203,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46203,1,2,0)
 ;;=2^90732
 ;;^UTILITY(U,$J,358.3,46203,1,3,0)
 ;;=3^Pneumovax
 ;;^UTILITY(U,$J,358.3,46204,0)
 ;;=31610^^204^2286^1^^^^1
 ;;^UTILITY(U,$J,358.3,46204,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46204,1,2,0)
 ;;=2^31610
 ;;^UTILITY(U,$J,358.3,46204,1,3,0)
 ;;=3^Trach Fenestration w/ Skin Flaps
 ;;^UTILITY(U,$J,358.3,46205,0)
 ;;=31605^^204^2286^3^^^^1
 ;;^UTILITY(U,$J,358.3,46205,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46205,1,2,0)
 ;;=2^31605
 ;;^UTILITY(U,$J,358.3,46205,1,3,0)
 ;;=3^Tracheostomy,Emerg,Cricothyroid
 ;;^UTILITY(U,$J,358.3,46206,0)
 ;;=31603^^204^2286^2^^^^1
 ;;^UTILITY(U,$J,358.3,46206,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46206,1,2,0)
 ;;=2^31603
 ;;^UTILITY(U,$J,358.3,46206,1,3,0)
 ;;=3^Tracheostomy Emerg,Transtracheal
 ;;^UTILITY(U,$J,358.3,46207,0)
 ;;=31600^^204^2286^4^^^^1
 ;;^UTILITY(U,$J,358.3,46207,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46207,1,2,0)
 ;;=2^31600
 ;;^UTILITY(U,$J,358.3,46207,1,3,0)
 ;;=3^Tracheostomy,Planned
 ;;^UTILITY(U,$J,358.3,46208,0)
 ;;=99358^^204^2287^1^^^^1
 ;;^UTILITY(U,$J,358.3,46208,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46208,1,2,0)
 ;;=2^99358
 ;;^UTILITY(U,$J,358.3,46208,1,3,0)
 ;;=3^Prolonged Svc,Before/After Visit,1st hr
 ;;^UTILITY(U,$J,358.3,46209,0)
 ;;=99359^^204^2287^2^^^^1
 ;;^UTILITY(U,$J,358.3,46209,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46209,1,2,0)
 ;;=2^99359
 ;;^UTILITY(U,$J,358.3,46209,1,3,0)
 ;;=3^Prolonged Svc,Before/After Visit,Ea Add 30min
 ;;^UTILITY(U,$J,358.3,46210,0)
 ;;=31500^^204^2288^3^^^^1
 ;;^UTILITY(U,$J,358.3,46210,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46210,1,2,0)
 ;;=2^31500
