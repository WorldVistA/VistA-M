IBDEI1IS ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24302,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Lower Leg w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,24302,1,4,0)
 ;;=4^L97.924
 ;;^UTILITY(U,$J,358.3,24302,2)
 ;;=^5133686
 ;;^UTILITY(U,$J,358.3,24303,0)
 ;;=L97.929^^107^1201^211
 ;;^UTILITY(U,$J,358.3,24303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24303,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Lower Leg w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,24303,1,4,0)
 ;;=4^L97.929
 ;;^UTILITY(U,$J,358.3,24303,2)
 ;;=^5133689
 ;;^UTILITY(U,$J,358.3,24304,0)
 ;;=L98.2^^107^1201^152
 ;;^UTILITY(U,$J,358.3,24304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24304,1,3,0)
 ;;=3^Febrile Neutrophilic Dermatosis
 ;;^UTILITY(U,$J,358.3,24304,1,4,0)
 ;;=4^L98.2
 ;;^UTILITY(U,$J,358.3,24304,2)
 ;;=^5009575
 ;;^UTILITY(U,$J,358.3,24305,0)
 ;;=L98.9^^107^1201^307
 ;;^UTILITY(U,$J,358.3,24305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24305,1,3,0)
 ;;=3^Skin/Subcutaneous Tissue Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24305,1,4,0)
 ;;=4^L98.9
 ;;^UTILITY(U,$J,358.3,24305,2)
 ;;=^5009595
 ;;^UTILITY(U,$J,358.3,24306,0)
 ;;=I70.731^^107^1201^81
 ;;^UTILITY(U,$J,358.3,24306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24306,1,3,0)
 ;;=3^Athscl of Bypass Graft of Right Leg w/ Thigh Ulcer
 ;;^UTILITY(U,$J,358.3,24306,1,4,0)
 ;;=4^I70.731
 ;;^UTILITY(U,$J,358.3,24306,2)
 ;;=^5007769
 ;;^UTILITY(U,$J,358.3,24307,0)
 ;;=I70.732^^107^1201^82
 ;;^UTILITY(U,$J,358.3,24307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24307,1,3,0)
 ;;=3^Athscl of Bypass Graft of Right Leg w/ Calf Ulcer
 ;;^UTILITY(U,$J,358.3,24307,1,4,0)
 ;;=4^I70.732
 ;;^UTILITY(U,$J,358.3,24307,2)
 ;;=^5007770
 ;;^UTILITY(U,$J,358.3,24308,0)
 ;;=I70.733^^107^1201^83
 ;;^UTILITY(U,$J,358.3,24308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24308,1,3,0)
 ;;=3^Athscl of Bypass Graft of Right Leg w/ Ankle Ulcer
 ;;^UTILITY(U,$J,358.3,24308,1,4,0)
 ;;=4^I70.733
 ;;^UTILITY(U,$J,358.3,24308,2)
 ;;=^5007771
 ;;^UTILITY(U,$J,358.3,24309,0)
 ;;=I70.734^^107^1201^84
 ;;^UTILITY(U,$J,358.3,24309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24309,1,3,0)
 ;;=3^Athscl of Bypass Graft of Right Leg w/ Heel/Midfoot Ulcer
 ;;^UTILITY(U,$J,358.3,24309,1,4,0)
 ;;=4^I70.734
 ;;^UTILITY(U,$J,358.3,24309,2)
 ;;=^5007772
 ;;^UTILITY(U,$J,358.3,24310,0)
 ;;=I70.735^^107^1201^85
 ;;^UTILITY(U,$J,358.3,24310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24310,1,3,0)
 ;;=3^Athscl of Bypass Graft of Right Leg w/ Oth Part Foot Ulcer
 ;;^UTILITY(U,$J,358.3,24310,1,4,0)
 ;;=4^I70.735
 ;;^UTILITY(U,$J,358.3,24310,2)
 ;;=^5007773
 ;;^UTILITY(U,$J,358.3,24311,0)
 ;;=I70.741^^107^1201^80
 ;;^UTILITY(U,$J,358.3,24311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24311,1,3,0)
 ;;=3^Athscl of Bypass Graft of Left Leg w/ Thigh Ulcer
 ;;^UTILITY(U,$J,358.3,24311,1,4,0)
 ;;=4^I70.741
 ;;^UTILITY(U,$J,358.3,24311,2)
 ;;=^5133601
 ;;^UTILITY(U,$J,358.3,24312,0)
 ;;=I70.742^^107^1201^77
 ;;^UTILITY(U,$J,358.3,24312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24312,1,3,0)
 ;;=3^Athscl of Bypass Graft of Left Leg w/ Calf Ulcer
 ;;^UTILITY(U,$J,358.3,24312,1,4,0)
 ;;=4^I70.742
 ;;^UTILITY(U,$J,358.3,24312,2)
 ;;=^5133602
 ;;^UTILITY(U,$J,358.3,24313,0)
 ;;=I70.743^^107^1201^76
 ;;^UTILITY(U,$J,358.3,24313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24313,1,3,0)
 ;;=3^Athscl of Bypass Graft of Left Leg w/ Ankle Ulcer
 ;;^UTILITY(U,$J,358.3,24313,1,4,0)
 ;;=4^I70.743
