IBDEI0KO ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9120,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,9120,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,9121,0)
 ;;=T14.91XA^^69^622^3
 ;;^UTILITY(U,$J,358.3,9121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9121,1,3,0)
 ;;=3^Suicide Attempt,Initial Encntr
 ;;^UTILITY(U,$J,358.3,9121,1,4,0)
 ;;=4^T14.91XA
 ;;^UTILITY(U,$J,358.3,9121,2)
 ;;=^5151779
 ;;^UTILITY(U,$J,358.3,9122,0)
 ;;=T14.91XD^^69^622^4
 ;;^UTILITY(U,$J,358.3,9122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9122,1,3,0)
 ;;=3^Suicide Attempt,Subsequent Encntr
 ;;^UTILITY(U,$J,358.3,9122,1,4,0)
 ;;=4^T14.91XD
 ;;^UTILITY(U,$J,358.3,9122,2)
 ;;=^5151780
 ;;^UTILITY(U,$J,358.3,9123,0)
 ;;=T14.91XS^^69^622^5
 ;;^UTILITY(U,$J,358.3,9123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9123,1,3,0)
 ;;=3^Suicide Attempt,Sequela
 ;;^UTILITY(U,$J,358.3,9123,1,4,0)
 ;;=4^T14.91XS
 ;;^UTILITY(U,$J,358.3,9123,2)
 ;;=^5151781
 ;;^UTILITY(U,$J,358.3,9124,0)
 ;;=90471^^70^623^1^^^^1
 ;;^UTILITY(U,$J,358.3,9124,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9124,1,2,0)
 ;;=2^90471
 ;;^UTILITY(U,$J,358.3,9124,1,3,0)
 ;;=3^1 Immunization Administration (Use w/ Vacs Below)
 ;;^UTILITY(U,$J,358.3,9125,0)
 ;;=90472^^70^623^2^^^^1
 ;;^UTILITY(U,$J,358.3,9125,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9125,1,2,0)
 ;;=2^90472
 ;;^UTILITY(U,$J,358.3,9125,1,3,0)
 ;;=3^2 or more Immunization Administration (use w/ Vacs below)
 ;;^UTILITY(U,$J,358.3,9126,0)
 ;;=90732^^70^623^7^^^^1
 ;;^UTILITY(U,$J,358.3,9126,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9126,1,2,0)
 ;;=2^90732
 ;;^UTILITY(U,$J,358.3,9126,1,3,0)
 ;;=3^Pneumovax 23 (Pneumococcal Vaccine)
 ;;^UTILITY(U,$J,358.3,9127,0)
 ;;=90714^^70^623^10^^^^1
 ;;^UTILITY(U,$J,358.3,9127,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9127,1,2,0)
 ;;=2^90714
 ;;^UTILITY(U,$J,358.3,9127,1,3,0)
 ;;=3^Td Vaccine
 ;;^UTILITY(U,$J,358.3,9128,0)
 ;;=90715^^70^623^11^^^^1
 ;;^UTILITY(U,$J,358.3,9128,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9128,1,2,0)
 ;;=2^90715
 ;;^UTILITY(U,$J,358.3,9128,1,3,0)
 ;;=3^Tdap Vaccine
 ;;^UTILITY(U,$J,358.3,9129,0)
 ;;=90662^^70^623^3^^^^1
 ;;^UTILITY(U,$J,358.3,9129,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9129,1,2,0)
 ;;=2^90662
 ;;^UTILITY(U,$J,358.3,9129,1,3,0)
 ;;=3^Flu Vaccine High Dose Syringe (Fluzone)
 ;;^UTILITY(U,$J,358.3,9130,0)
 ;;=90675^^70^623^9^^^^1
 ;;^UTILITY(U,$J,358.3,9130,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9130,1,2,0)
 ;;=2^90675
 ;;^UTILITY(U,$J,358.3,9130,1,3,0)
 ;;=3^Rabies
 ;;^UTILITY(U,$J,358.3,9131,0)
 ;;=90670^^70^623^8^^^^1
 ;;^UTILITY(U,$J,358.3,9131,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9131,1,2,0)
 ;;=2^90670
 ;;^UTILITY(U,$J,358.3,9131,1,3,0)
 ;;=3^Prevnar 13 (Pneumococcal Vaccine)
 ;;^UTILITY(U,$J,358.3,9132,0)
 ;;=90688^^70^623^4^^^^1
 ;;^UTILITY(U,$J,358.3,9132,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9132,1,2,0)
 ;;=2^90688
 ;;^UTILITY(U,$J,358.3,9132,1,3,0)
 ;;=3^Flu Vaccine Multidose (Flulaval)
 ;;^UTILITY(U,$J,358.3,9133,0)
 ;;=90686^^70^623^5^^^^1
 ;;^UTILITY(U,$J,358.3,9133,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9133,1,2,0)
 ;;=2^90686
 ;;^UTILITY(U,$J,358.3,9133,1,3,0)
 ;;=3^Flu Vaccine,Sngl Dose (Afluria)
 ;;^UTILITY(U,$J,358.3,9134,0)
 ;;=90653^^70^623^6^^^^1
 ;;^UTILITY(U,$J,358.3,9134,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9134,1,2,0)
 ;;=2^90653
 ;;^UTILITY(U,$J,358.3,9134,1,3,0)
 ;;=3^Flu Vaccine,Sngl Dose (Fluad)
