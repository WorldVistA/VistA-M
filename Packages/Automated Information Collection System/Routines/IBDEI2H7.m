IBDEI2H7 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41539,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41539,1,2,0)
 ;;=2^Debr Rmvl Foreign Material;Muscle,Bone
 ;;^UTILITY(U,$J,358.3,41539,1,3,0)
 ;;=3^11012
 ;;^UTILITY(U,$J,358.3,41540,0)
 ;;=11001^^191^2107^5^^^^1
 ;;^UTILITY(U,$J,358.3,41540,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41540,1,2,0)
 ;;=2^Debr of extensive eczematous;ea addl 10%
 ;;^UTILITY(U,$J,358.3,41540,1,3,0)
 ;;=3^11001
 ;;^UTILITY(U,$J,358.3,41541,0)
 ;;=97597^^191^2107^11^^^^1
 ;;^UTILITY(U,$J,358.3,41541,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41541,1,2,0)
 ;;=2^Rmvl Devital Tiss <= 20 Sq cm
 ;;^UTILITY(U,$J,358.3,41541,1,3,0)
 ;;=3^97597
 ;;^UTILITY(U,$J,358.3,41542,0)
 ;;=97602^^191^2107^10^^^^1
 ;;^UTILITY(U,$J,358.3,41542,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41542,1,2,0)
 ;;=2^Non-Selective Debridement
 ;;^UTILITY(U,$J,358.3,41542,1,3,0)
 ;;=3^97602
 ;;^UTILITY(U,$J,358.3,41543,0)
 ;;=97610^^191^2107^9^^^^1
 ;;^UTILITY(U,$J,358.3,41543,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41543,1,2,0)
 ;;=2^Low Freq Non-Thermal US,Wound Assess
 ;;^UTILITY(U,$J,358.3,41543,1,3,0)
 ;;=3^97610
 ;;^UTILITY(U,$J,358.3,41544,0)
 ;;=97598^^191^2107^12^^^^1
 ;;^UTILITY(U,$J,358.3,41544,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41544,1,2,0)
 ;;=2^Rmvl Devital Tiss,Ea Addl 20 sq cm
 ;;^UTILITY(U,$J,358.3,41544,1,3,0)
 ;;=3^97598
 ;;^UTILITY(U,$J,358.3,41545,0)
 ;;=11300^^191^2108^5
 ;;^UTILITY(U,$J,358.3,41545,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41545,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Trunk,Arms,Legs;0.5cm or less
 ;;^UTILITY(U,$J,358.3,41545,1,3,0)
 ;;=3^11300
 ;;^UTILITY(U,$J,358.3,41546,0)
 ;;=11301^^191^2108^6
 ;;^UTILITY(U,$J,358.3,41546,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41546,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Trunk,Arms,Legs;0.6cm-1.0cm
 ;;^UTILITY(U,$J,358.3,41546,1,3,0)
 ;;=3^11301
 ;;^UTILITY(U,$J,358.3,41547,0)
 ;;=11302^^191^2108^7
 ;;^UTILITY(U,$J,358.3,41547,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41547,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Trunk,Arms,Legs;1.1cm-2.0cm
 ;;^UTILITY(U,$J,358.3,41547,1,3,0)
 ;;=3^11302
 ;;^UTILITY(U,$J,358.3,41548,0)
 ;;=11305^^191^2108^1
 ;;^UTILITY(U,$J,358.3,41548,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41548,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Scalp,Neck,Hand;0.5cm or less
 ;;^UTILITY(U,$J,358.3,41548,1,3,0)
 ;;=3^11305
 ;;^UTILITY(U,$J,358.3,41549,0)
 ;;=11306^^191^2108^2
 ;;^UTILITY(U,$J,358.3,41549,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41549,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Scalp,Neck,Hand;0.6cm-1.0cm
 ;;^UTILITY(U,$J,358.3,41549,1,3,0)
 ;;=3^11306
 ;;^UTILITY(U,$J,358.3,41550,0)
 ;;=11307^^191^2108^3
 ;;^UTILITY(U,$J,358.3,41550,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41550,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Scalp,Neck,Hand;1.1cm-2.0cm
 ;;^UTILITY(U,$J,358.3,41550,1,3,0)
 ;;=3^11307
 ;;^UTILITY(U,$J,358.3,41551,0)
 ;;=11308^^191^2108^4
 ;;^UTILITY(U,$J,358.3,41551,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41551,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Scalp,Neck,Hand > 2.0cm
 ;;^UTILITY(U,$J,358.3,41551,1,3,0)
 ;;=3^11308
 ;;^UTILITY(U,$J,358.3,41552,0)
 ;;=11303^^191^2108^8^^^^1
 ;;^UTILITY(U,$J,358.3,41552,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41552,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Trunk,Arms,Legs;> 2.0cm
 ;;^UTILITY(U,$J,358.3,41552,1,3,0)
 ;;=3^11303
 ;;^UTILITY(U,$J,358.3,41553,0)
 ;;=11719^^191^2109^10^^^^1
 ;;^UTILITY(U,$J,358.3,41553,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41553,1,2,0)
 ;;=2^Trimming Nondystrophic Nails, any number
