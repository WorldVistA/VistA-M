IBDEI069 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2329,0)
 ;;=Z95.1^^19^195^4
 ;;^UTILITY(U,$J,358.3,2329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2329,1,3,0)
 ;;=3^Presence of Aortocoronary Bypass Graft
 ;;^UTILITY(U,$J,358.3,2329,1,4,0)
 ;;=4^Z95.1
 ;;^UTILITY(U,$J,358.3,2329,2)
 ;;=^5063669
 ;;^UTILITY(U,$J,358.3,2330,0)
 ;;=Z98.61^^19^195^1
 ;;^UTILITY(U,$J,358.3,2330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2330,1,3,0)
 ;;=3^Coronary Angioplasty Status
 ;;^UTILITY(U,$J,358.3,2330,1,4,0)
 ;;=4^Z98.61
 ;;^UTILITY(U,$J,358.3,2330,2)
 ;;=^5063742
 ;;^UTILITY(U,$J,358.3,2331,0)
 ;;=Z95.2^^19^195^7
 ;;^UTILITY(U,$J,358.3,2331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2331,1,3,0)
 ;;=3^Presence of Prosthetic Heart Valve
 ;;^UTILITY(U,$J,358.3,2331,1,4,0)
 ;;=4^Z95.2
 ;;^UTILITY(U,$J,358.3,2331,2)
 ;;=^5063670
 ;;^UTILITY(U,$J,358.3,2332,0)
 ;;=Z95.3^^19^195^8
 ;;^UTILITY(U,$J,358.3,2332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2332,1,3,0)
 ;;=3^Presence of Xenogenic Heart Valve
 ;;^UTILITY(U,$J,358.3,2332,1,4,0)
 ;;=4^Z95.3
 ;;^UTILITY(U,$J,358.3,2332,2)
 ;;=^5063671
 ;;^UTILITY(U,$J,358.3,2333,0)
 ;;=Z95.4^^19^195^5
 ;;^UTILITY(U,$J,358.3,2333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2333,1,3,0)
 ;;=3^Presence of Heart Valve Replacement NEC
 ;;^UTILITY(U,$J,358.3,2333,1,4,0)
 ;;=4^Z95.4
 ;;^UTILITY(U,$J,358.3,2333,2)
 ;;=^5063672
 ;;^UTILITY(U,$J,358.3,2334,0)
 ;;=Z79.01^^19^195^2
 ;;^UTILITY(U,$J,358.3,2334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2334,1,3,0)
 ;;=3^Long Term Current Use of Anticoagulants
 ;;^UTILITY(U,$J,358.3,2334,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,2334,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,2335,0)
 ;;=I10.^^19^196^3
 ;;^UTILITY(U,$J,358.3,2335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2335,1,3,0)
 ;;=3^Hypertension,Essential
 ;;^UTILITY(U,$J,358.3,2335,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,2335,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,2336,0)
 ;;=I11.0^^19^196^6
 ;;^UTILITY(U,$J,358.3,2336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2336,1,3,0)
 ;;=3^Hypertensive Heart Disease w/ Heart Failure
 ;;^UTILITY(U,$J,358.3,2336,1,4,0)
 ;;=4^I11.0
 ;;^UTILITY(U,$J,358.3,2336,2)
 ;;=^5007063
 ;;^UTILITY(U,$J,358.3,2337,0)
 ;;=I11.9^^19^196^7
 ;;^UTILITY(U,$J,358.3,2337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2337,1,3,0)
 ;;=3^Hypertensive Heart Disease w/o Heart Failure
 ;;^UTILITY(U,$J,358.3,2337,1,4,0)
 ;;=4^I11.9
 ;;^UTILITY(U,$J,358.3,2337,2)
 ;;=^5007064
 ;;^UTILITY(U,$J,358.3,2338,0)
 ;;=I15.8^^19^196^5
 ;;^UTILITY(U,$J,358.3,2338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2338,1,3,0)
 ;;=3^Hypertension,Secondary
 ;;^UTILITY(U,$J,358.3,2338,1,4,0)
 ;;=4^I15.8
 ;;^UTILITY(U,$J,358.3,2338,2)
 ;;=^5007074
 ;;^UTILITY(U,$J,358.3,2339,0)
 ;;=I15.0^^19^196^4
 ;;^UTILITY(U,$J,358.3,2339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2339,1,3,0)
 ;;=3^Hypertension,Renovascular
 ;;^UTILITY(U,$J,358.3,2339,1,4,0)
 ;;=4^I15.0
 ;;^UTILITY(U,$J,358.3,2339,2)
 ;;=^5007071
 ;;^UTILITY(U,$J,358.3,2340,0)
 ;;=I70.1^^19^196^1
 ;;^UTILITY(U,$J,358.3,2340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2340,1,3,0)
 ;;=3^Atherosclerosis of Renal Artery
 ;;^UTILITY(U,$J,358.3,2340,1,4,0)
 ;;=4^I70.1
 ;;^UTILITY(U,$J,358.3,2340,2)
 ;;=^269760
 ;;^UTILITY(U,$J,358.3,2341,0)
 ;;=R03.0^^19^196^2
 ;;^UTILITY(U,$J,358.3,2341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2341,1,3,0)
 ;;=3^Elevated B/P Reading w/o HTN Diagnosis
 ;;^UTILITY(U,$J,358.3,2341,1,4,0)
 ;;=4^R03.0
 ;;^UTILITY(U,$J,358.3,2341,2)
 ;;=^5019171
 ;;^UTILITY(U,$J,358.3,2342,0)
 ;;=I95.1^^19^196^10
 ;;^UTILITY(U,$J,358.3,2342,1,0)
 ;;=^358.31IA^4^2
