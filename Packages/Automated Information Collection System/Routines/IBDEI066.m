IBDEI066 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2289,0)
 ;;=Z94.3^^19^192^27
 ;;^UTILITY(U,$J,358.3,2289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2289,1,3,0)
 ;;=3^Heart and Lungs Transplant Status
 ;;^UTILITY(U,$J,358.3,2289,1,4,0)
 ;;=4^Z94.3
 ;;^UTILITY(U,$J,358.3,2289,2)
 ;;=^5063657
 ;;^UTILITY(U,$J,358.3,2290,0)
 ;;=Z48.21^^19^192^1
 ;;^UTILITY(U,$J,358.3,2290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2290,1,3,0)
 ;;=3^Aftercare Following Heart Transplant
 ;;^UTILITY(U,$J,358.3,2290,1,4,0)
 ;;=4^Z48.21
 ;;^UTILITY(U,$J,358.3,2290,2)
 ;;=^5063038
 ;;^UTILITY(U,$J,358.3,2291,0)
 ;;=Z48.280^^19^192^2
 ;;^UTILITY(U,$J,358.3,2291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2291,1,3,0)
 ;;=3^Aftercare Following Heart-Lung Transplant
 ;;^UTILITY(U,$J,358.3,2291,1,4,0)
 ;;=4^Z48.280
 ;;^UTILITY(U,$J,358.3,2291,2)
 ;;=^5063042
 ;;^UTILITY(U,$J,358.3,2292,0)
 ;;=I25.10^^19^193^2
 ;;^UTILITY(U,$J,358.3,2292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2292,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2292,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,2292,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,2293,0)
 ;;=I25.110^^19^193^3
 ;;^UTILITY(U,$J,358.3,2293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2293,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2293,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,2293,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,2294,0)
 ;;=I25.111^^19^193^4
 ;;^UTILITY(U,$J,358.3,2294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2294,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/ Ang Pctrs w/ Spasm
 ;;^UTILITY(U,$J,358.3,2294,1,4,0)
 ;;=4^I25.111
 ;;^UTILITY(U,$J,358.3,2294,2)
 ;;=^5007109
 ;;^UTILITY(U,$J,358.3,2295,0)
 ;;=I25.118^^19^193^5
 ;;^UTILITY(U,$J,358.3,2295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2295,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/ Oth Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2295,1,4,0)
 ;;=4^I25.118
 ;;^UTILITY(U,$J,358.3,2295,2)
 ;;=^5007110
 ;;^UTILITY(U,$J,358.3,2296,0)
 ;;=I25.119^^19^193^6
 ;;^UTILITY(U,$J,358.3,2296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2296,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/ Unspec Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2296,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,2296,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,2297,0)
 ;;=I25.810^^19^193^1
 ;;^UTILITY(U,$J,358.3,2297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2297,1,3,0)
 ;;=3^Atherosclerosis of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,2297,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,2297,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,2298,0)
 ;;=I25.82^^19^193^10
 ;;^UTILITY(U,$J,358.3,2298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2298,1,3,0)
 ;;=3^Total Occlusion of Coronary Artery,Chronic
 ;;^UTILITY(U,$J,358.3,2298,1,4,0)
 ;;=4^I25.82
 ;;^UTILITY(U,$J,358.3,2298,2)
 ;;=^335262
 ;;^UTILITY(U,$J,358.3,2299,0)
 ;;=I25.83^^19^193^8
 ;;^UTILITY(U,$J,358.3,2299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2299,1,3,0)
 ;;=3^Coronary Atherosclerosis d/t Lipid Rich Plaque
 ;;^UTILITY(U,$J,358.3,2299,1,4,0)
 ;;=4^I25.83
 ;;^UTILITY(U,$J,358.3,2299,2)
 ;;=^336601
 ;;^UTILITY(U,$J,358.3,2300,0)
 ;;=I25.84^^19^193^7
 ;;^UTILITY(U,$J,358.3,2300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2300,1,3,0)
 ;;=3^Coronary Atherosclerosis d/t Calcified Coronary Lesion
 ;;^UTILITY(U,$J,358.3,2300,1,4,0)
 ;;=4^I25.84
 ;;^UTILITY(U,$J,358.3,2300,2)
 ;;=^340518
 ;;^UTILITY(U,$J,358.3,2301,0)
 ;;=I25.89^^19^193^9
 ;;^UTILITY(U,$J,358.3,2301,1,0)
 ;;=^358.31IA^4^2
