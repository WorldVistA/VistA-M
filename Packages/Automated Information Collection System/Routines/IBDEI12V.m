IBDEI12V ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18317,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,18317,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,18318,0)
 ;;=I71.2^^79^877^20
 ;;^UTILITY(U,$J,358.3,18318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18318,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,18318,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,18318,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,18319,0)
 ;;=I71.4^^79^877^1
 ;;^UTILITY(U,$J,358.3,18319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18319,1,3,0)
 ;;=3^AAA w/o Rupture
 ;;^UTILITY(U,$J,358.3,18319,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,18319,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,18320,0)
 ;;=I73.9^^79^877^17
 ;;^UTILITY(U,$J,358.3,18320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18320,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,18320,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,18320,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,18321,0)
 ;;=I74.2^^79^877^11
 ;;^UTILITY(U,$J,358.3,18321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18321,1,3,0)
 ;;=3^Embolism/Thrombosis of Upper Extremity Arteries
 ;;^UTILITY(U,$J,358.3,18321,1,4,0)
 ;;=4^I74.2
 ;;^UTILITY(U,$J,358.3,18321,2)
 ;;=^5007801
 ;;^UTILITY(U,$J,358.3,18322,0)
 ;;=I74.3^^79^877^10
 ;;^UTILITY(U,$J,358.3,18322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18322,1,3,0)
 ;;=3^Embolism/Thrombosis of Lower Extremity Arteries
 ;;^UTILITY(U,$J,358.3,18322,1,4,0)
 ;;=4^I74.3
 ;;^UTILITY(U,$J,358.3,18322,2)
 ;;=^5007802
 ;;^UTILITY(U,$J,358.3,18323,0)
 ;;=I83.019^^79^877^22
 ;;^UTILITY(U,$J,358.3,18323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18323,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer
 ;;^UTILITY(U,$J,358.3,18323,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,18323,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,18324,0)
 ;;=I83.029^^79^877^21
 ;;^UTILITY(U,$J,358.3,18324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18324,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer
 ;;^UTILITY(U,$J,358.3,18324,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,18324,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,18325,0)
 ;;=I83.91^^79^877^4
 ;;^UTILITY(U,$J,358.3,18325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18325,1,3,0)
 ;;=3^Asymptomatic Varicose Veins Right Lower Extremity
 ;;^UTILITY(U,$J,358.3,18325,1,4,0)
 ;;=4^I83.91
 ;;^UTILITY(U,$J,358.3,18325,2)
 ;;=^5008020
 ;;^UTILITY(U,$J,358.3,18326,0)
 ;;=I83.92^^79^877^3
 ;;^UTILITY(U,$J,358.3,18326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18326,1,3,0)
 ;;=3^Asymptomatic Varicose Veins Left Lower Extremity
 ;;^UTILITY(U,$J,358.3,18326,1,4,0)
 ;;=4^I83.92
 ;;^UTILITY(U,$J,358.3,18326,2)
 ;;=^5008021
 ;;^UTILITY(U,$J,358.3,18327,0)
 ;;=I83.93^^79^877^2
 ;;^UTILITY(U,$J,358.3,18327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18327,1,3,0)
 ;;=3^Asymptomatic Varicose Veins Bilateral Lower Extremities
 ;;^UTILITY(U,$J,358.3,18327,1,4,0)
 ;;=4^I83.93
 ;;^UTILITY(U,$J,358.3,18327,2)
 ;;=^5008022
 ;;^UTILITY(U,$J,358.3,18328,0)
 ;;=M79.604^^79^877^18
 ;;^UTILITY(U,$J,358.3,18328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18328,1,3,0)
 ;;=3^Right Limb Pain
 ;;^UTILITY(U,$J,358.3,18328,1,4,0)
 ;;=4^M79.604
 ;;^UTILITY(U,$J,358.3,18328,2)
 ;;=^5013328
 ;;^UTILITY(U,$J,358.3,18329,0)
 ;;=M79.605^^79^877^12
 ;;^UTILITY(U,$J,358.3,18329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18329,1,3,0)
 ;;=3^Left Limb Pain
 ;;^UTILITY(U,$J,358.3,18329,1,4,0)
 ;;=4^M79.605
 ;;^UTILITY(U,$J,358.3,18329,2)
 ;;=^5013329
 ;;^UTILITY(U,$J,358.3,18330,0)
 ;;=Z13.6^^79^877^19
 ;;^UTILITY(U,$J,358.3,18330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18330,1,3,0)
 ;;=3^Screening for Cardiovascular Disorders
