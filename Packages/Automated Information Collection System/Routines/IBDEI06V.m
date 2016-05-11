IBDEI06V ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2895,1,3,0)
 ;;=3^Cancer,Skin,Unspec
 ;;^UTILITY(U,$J,358.3,2895,1,4,0)
 ;;=4^C44.90
 ;;^UTILITY(U,$J,358.3,2895,2)
 ;;=^5001091
 ;;^UTILITY(U,$J,358.3,2896,0)
 ;;=C26.1^^18^209^26
 ;;^UTILITY(U,$J,358.3,2896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2896,1,3,0)
 ;;=3^Cancer,Spleen
 ;;^UTILITY(U,$J,358.3,2896,1,4,0)
 ;;=4^C26.1
 ;;^UTILITY(U,$J,358.3,2896,2)
 ;;=^267116
 ;;^UTILITY(U,$J,358.3,2897,0)
 ;;=C16.9^^18^209^27
 ;;^UTILITY(U,$J,358.3,2897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2897,1,3,0)
 ;;=3^Cancer,Stomach,Unspec
 ;;^UTILITY(U,$J,358.3,2897,1,4,0)
 ;;=4^C16.9
 ;;^UTILITY(U,$J,358.3,2897,2)
 ;;=^5000923
 ;;^UTILITY(U,$J,358.3,2898,0)
 ;;=C79.82^^18^209^30
 ;;^UTILITY(U,$J,358.3,2898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2898,1,3,0)
 ;;=3^Secondary Malig Neop,Genital Organs
 ;;^UTILITY(U,$J,358.3,2898,1,4,0)
 ;;=4^C79.82
 ;;^UTILITY(U,$J,358.3,2898,2)
 ;;=^267339
 ;;^UTILITY(U,$J,358.3,2899,0)
 ;;=I25.3^^18^210^2
 ;;^UTILITY(U,$J,358.3,2899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2899,1,3,0)
 ;;=3^Aneurysm of Heart
 ;;^UTILITY(U,$J,358.3,2899,1,4,0)
 ;;=4^I25.3
 ;;^UTILITY(U,$J,358.3,2899,2)
 ;;=^5007112
 ;;^UTILITY(U,$J,358.3,2900,0)
 ;;=I72.9^^18^210^6
 ;;^UTILITY(U,$J,358.3,2900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2900,1,3,0)
 ;;=3^Aneurysm,Unspec Site
 ;;^UTILITY(U,$J,358.3,2900,1,4,0)
 ;;=4^I72.9
 ;;^UTILITY(U,$J,358.3,2900,2)
 ;;=^5007795
 ;;^UTILITY(U,$J,358.3,2901,0)
 ;;=I71.4^^18^210^1
 ;;^UTILITY(U,$J,358.3,2901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2901,1,3,0)
 ;;=3^AAA w/o Rupture
 ;;^UTILITY(U,$J,358.3,2901,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,2901,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,2902,0)
 ;;=I71.9^^18^210^3
 ;;^UTILITY(U,$J,358.3,2902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2902,1,3,0)
 ;;=3^Aneurysm,Aortic w/o Rupture,Unspec Site
 ;;^UTILITY(U,$J,358.3,2902,1,4,0)
 ;;=4^I71.9
 ;;^UTILITY(U,$J,358.3,2902,2)
 ;;=^5007792
 ;;^UTILITY(U,$J,358.3,2903,0)
 ;;=I71.2^^18^210^4
 ;;^UTILITY(U,$J,358.3,2903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2903,1,3,0)
 ;;=3^Aneurysm,Thoracic Aortic w/o Rupture
 ;;^UTILITY(U,$J,358.3,2903,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,2903,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,2904,0)
 ;;=I71.6^^18^210^5
 ;;^UTILITY(U,$J,358.3,2904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2904,1,3,0)
 ;;=3^Aneurysm,Thoracoabdominal Aortic w/o Rupture
 ;;^UTILITY(U,$J,358.3,2904,1,4,0)
 ;;=4^I71.6
 ;;^UTILITY(U,$J,358.3,2904,2)
 ;;=^5007791
 ;;^UTILITY(U,$J,358.3,2905,0)
 ;;=I20.1^^18^210^7
 ;;^UTILITY(U,$J,358.3,2905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2905,1,3,0)
 ;;=3^Angina Pectoris w/ Spasm
 ;;^UTILITY(U,$J,358.3,2905,1,4,0)
 ;;=4^I20.1
 ;;^UTILITY(U,$J,358.3,2905,2)
 ;;=^5007077
 ;;^UTILITY(U,$J,358.3,2906,0)
 ;;=I20.9^^18^210^8
 ;;^UTILITY(U,$J,358.3,2906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2906,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,2906,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,2906,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,2907,0)
 ;;=I35.1^^18^210^11
 ;;^UTILITY(U,$J,358.3,2907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2907,1,3,0)
 ;;=3^Aortic Valve Insufficiency,Nonrheumatic
 ;;^UTILITY(U,$J,358.3,2907,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,2907,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,2908,0)
 ;;=I35.2^^18^210^12
 ;;^UTILITY(U,$J,358.3,2908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2908,1,3,0)
 ;;=3^Aortic Valve Stenosis w/ Insufficiency,Nonrheumatic
 ;;^UTILITY(U,$J,358.3,2908,1,4,0)
 ;;=4^I35.2
