IBDEI0E5 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6173,1,3,0)
 ;;=3^Urinary Incontinence,Unspec
 ;;^UTILITY(U,$J,358.3,6173,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,6173,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,6174,0)
 ;;=R35.0^^40^384^19
 ;;^UTILITY(U,$J,358.3,6174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6174,1,3,0)
 ;;=3^Frequency of Micturition
 ;;^UTILITY(U,$J,358.3,6174,1,4,0)
 ;;=4^R35.0
 ;;^UTILITY(U,$J,358.3,6174,2)
 ;;=^5019334
 ;;^UTILITY(U,$J,358.3,6175,0)
 ;;=I83.019^^40^385^21
 ;;^UTILITY(U,$J,358.3,6175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6175,1,3,0)
 ;;=3^Varicose Veins of Right Lower Extremity w/ Ulcer
 ;;^UTILITY(U,$J,358.3,6175,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,6175,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,6176,0)
 ;;=I83.029^^40^385^12
 ;;^UTILITY(U,$J,358.3,6176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6176,1,3,0)
 ;;=3^Varicose Veins of Left Lower Extremity w/ Ulcer
 ;;^UTILITY(U,$J,358.3,6176,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,6176,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,6177,0)
 ;;=I83.014^^40^385^13
 ;;^UTILITY(U,$J,358.3,6177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6177,1,3,0)
 ;;=3^Varicose Veins of Right Lower Extrem w/ Heel/Midfoot Ulcer
 ;;^UTILITY(U,$J,358.3,6177,1,4,0)
 ;;=4^I83.014
 ;;^UTILITY(U,$J,358.3,6177,2)
 ;;=^5007976
 ;;^UTILITY(U,$J,358.3,6178,0)
 ;;=I83.013^^40^385^14
 ;;^UTILITY(U,$J,358.3,6178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6178,1,3,0)
 ;;=3^Varicose Veins of Right Lower Extrem w/ Ankle Ulcer
 ;;^UTILITY(U,$J,358.3,6178,1,4,0)
 ;;=4^I83.013
 ;;^UTILITY(U,$J,358.3,6178,2)
 ;;=^5007975
 ;;^UTILITY(U,$J,358.3,6179,0)
 ;;=I83.012^^40^385^15
 ;;^UTILITY(U,$J,358.3,6179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6179,1,3,0)
 ;;=3^Varicose Veins of Right Lower Extrem w/ Calf Ulcer
 ;;^UTILITY(U,$J,358.3,6179,1,4,0)
 ;;=4^I83.012
 ;;^UTILITY(U,$J,358.3,6179,2)
 ;;=^5007974
 ;;^UTILITY(U,$J,358.3,6180,0)
 ;;=I83.011^^40^385^16
 ;;^UTILITY(U,$J,358.3,6180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6180,1,3,0)
 ;;=3^Varicose Veins of Right Lower Extrem w/ Thigh Ulcer
 ;;^UTILITY(U,$J,358.3,6180,1,4,0)
 ;;=4^I83.011
 ;;^UTILITY(U,$J,358.3,6180,2)
 ;;=^5007973
 ;;^UTILITY(U,$J,358.3,6181,0)
 ;;=I83.018^^40^385^17
 ;;^UTILITY(U,$J,358.3,6181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6181,1,3,0)
 ;;=3^Varicose Veins of Right Lower Extrem w/ Lower Leg Ulcer
 ;;^UTILITY(U,$J,358.3,6181,1,4,0)
 ;;=4^I83.018
 ;;^UTILITY(U,$J,358.3,6181,2)
 ;;=^5007978
 ;;^UTILITY(U,$J,358.3,6182,0)
 ;;=I83.015^^40^385^18
 ;;^UTILITY(U,$J,358.3,6182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6182,1,3,0)
 ;;=3^Varicose Veins of Right Lower Extrem w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,6182,1,4,0)
 ;;=4^I83.015
 ;;^UTILITY(U,$J,358.3,6182,2)
 ;;=^5007977
 ;;^UTILITY(U,$J,358.3,6183,0)
 ;;=I83.019^^40^385^19
 ;;^UTILITY(U,$J,358.3,6183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6183,1,3,0)
 ;;=3^Varicose Veins of Right Lower Extrem w/ Ulcer,Unspec Site
 ;;^UTILITY(U,$J,358.3,6183,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,6183,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,6184,0)
 ;;=I83.11^^40^385^20
 ;;^UTILITY(U,$J,358.3,6184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6184,1,3,0)
 ;;=3^Varicose Veins of Right Lower Extrem w/ Inflammation
 ;;^UTILITY(U,$J,358.3,6184,1,4,0)
 ;;=4^I83.11
 ;;^UTILITY(U,$J,358.3,6184,2)
 ;;=^5007988
 ;;^UTILITY(U,$J,358.3,6185,0)
 ;;=I83.91^^40^385^3
 ;;^UTILITY(U,$J,358.3,6185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6185,1,3,0)
 ;;=3^Asymptomatic Varicose Veins of Right Lower Extrem 
