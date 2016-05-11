IBDEI06W ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2908,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,2909,0)
 ;;=I35.0^^18^210^13
 ;;^UTILITY(U,$J,358.3,2909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2909,1,3,0)
 ;;=3^Aortic Valve Stenosis,Nonrheumatic
 ;;^UTILITY(U,$J,358.3,2909,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,2909,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,2910,0)
 ;;=I35.9^^18^210^10
 ;;^UTILITY(U,$J,358.3,2910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2910,1,3,0)
 ;;=3^Aortic Valve Disorder,Nonrheumatic,Unspec
 ;;^UTILITY(U,$J,358.3,2910,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,2910,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,2911,0)
 ;;=I35.8^^18^210^9
 ;;^UTILITY(U,$J,358.3,2911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2911,1,3,0)
 ;;=3^Aortic Valve Disorder,Nonrheumatic,Other
 ;;^UTILITY(U,$J,358.3,2911,1,4,0)
 ;;=4^I35.8
 ;;^UTILITY(U,$J,358.3,2911,2)
 ;;=^5007177
 ;;^UTILITY(U,$J,358.3,2912,0)
 ;;=I77.6^^18^210^14
 ;;^UTILITY(U,$J,358.3,2912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2912,1,3,0)
 ;;=3^Arteritis,Unspec
 ;;^UTILITY(U,$J,358.3,2912,1,4,0)
 ;;=4^I77.6
 ;;^UTILITY(U,$J,358.3,2912,2)
 ;;=^5007813
 ;;^UTILITY(U,$J,358.3,2913,0)
 ;;=I25.810^^18^210^15
 ;;^UTILITY(U,$J,358.3,2913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2913,1,3,0)
 ;;=3^Atherosclerosis of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,2913,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,2913,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,2914,0)
 ;;=I70.91^^18^210^16
 ;;^UTILITY(U,$J,358.3,2914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2914,1,3,0)
 ;;=3^Atherosclerosis,Generalized
 ;;^UTILITY(U,$J,358.3,2914,1,4,0)
 ;;=4^I70.91
 ;;^UTILITY(U,$J,358.3,2914,2)
 ;;=^5007785
 ;;^UTILITY(U,$J,358.3,2915,0)
 ;;=I70.90^^18^210^17
 ;;^UTILITY(U,$J,358.3,2915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2915,1,3,0)
 ;;=3^Atherosclerosis,Unspec
 ;;^UTILITY(U,$J,358.3,2915,1,4,0)
 ;;=4^I70.90
 ;;^UTILITY(U,$J,358.3,2915,2)
 ;;=^5007784
 ;;^UTILITY(U,$J,358.3,2916,0)
 ;;=I25.10^^18^210^18
 ;;^UTILITY(U,$J,358.3,2916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2916,1,3,0)
 ;;=3^Athscl Hrt Disease Native Coronary Artery w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,2916,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,2916,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,2917,0)
 ;;=I48.91^^18^210^19
 ;;^UTILITY(U,$J,358.3,2917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2917,1,3,0)
 ;;=3^Atrial Fibrillation,Unspec
 ;;^UTILITY(U,$J,358.3,2917,1,4,0)
 ;;=4^I48.91
 ;;^UTILITY(U,$J,358.3,2917,2)
 ;;=^5007229
 ;;^UTILITY(U,$J,358.3,2918,0)
 ;;=Z95.1^^18^210^21
 ;;^UTILITY(U,$J,358.3,2918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2918,1,3,0)
 ;;=3^Bypass Graft,Aortocoronary
 ;;^UTILITY(U,$J,358.3,2918,1,4,0)
 ;;=4^Z95.1
 ;;^UTILITY(U,$J,358.3,2918,2)
 ;;=^5063669
 ;;^UTILITY(U,$J,358.3,2919,0)
 ;;=I78.9^^18^210^22
 ;;^UTILITY(U,$J,358.3,2919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2919,1,3,0)
 ;;=3^Capillary Disease,Unspec
 ;;^UTILITY(U,$J,358.3,2919,1,4,0)
 ;;=4^I78.9
 ;;^UTILITY(U,$J,358.3,2919,2)
 ;;=^5007816
 ;;^UTILITY(U,$J,358.3,2920,0)
 ;;=I51.7^^18^210^23
 ;;^UTILITY(U,$J,358.3,2920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2920,1,3,0)
 ;;=3^Cardiomegaly
 ;;^UTILITY(U,$J,358.3,2920,1,4,0)
 ;;=4^I51.7
 ;;^UTILITY(U,$J,358.3,2920,2)
 ;;=^5007257
 ;;^UTILITY(U,$J,358.3,2921,0)
 ;;=I42.1^^18^210^24
 ;;^UTILITY(U,$J,358.3,2921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2921,1,3,0)
 ;;=3^Cardiomyopathy,Obstructive Hypertrophic
 ;;^UTILITY(U,$J,358.3,2921,1,4,0)
 ;;=4^I42.1
 ;;^UTILITY(U,$J,358.3,2921,2)
 ;;=^340520
 ;;^UTILITY(U,$J,358.3,2922,0)
 ;;=I42.2^^18^210^25
