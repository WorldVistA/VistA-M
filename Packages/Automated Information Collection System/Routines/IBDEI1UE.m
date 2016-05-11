IBDEI1UE ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31287,0)
 ;;=11011^^125^1579^3
 ;;^UTILITY(U,$J,358.3,31287,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31287,1,2,0)
 ;;=2^Debr Rmvl Foreign Material;Skin,Subq Tissue,Muscle
 ;;^UTILITY(U,$J,358.3,31287,1,3,0)
 ;;=3^11011
 ;;^UTILITY(U,$J,358.3,31288,0)
 ;;=11042^^125^1579^8
 ;;^UTILITY(U,$J,358.3,31288,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31288,1,2,0)
 ;;=2^Debridement; Skin & Subcutaneous Tissue
 ;;^UTILITY(U,$J,358.3,31288,1,3,0)
 ;;=3^11042
 ;;^UTILITY(U,$J,358.3,31289,0)
 ;;=11043^^125^1579^9
 ;;^UTILITY(U,$J,358.3,31289,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31289,1,2,0)
 ;;=2^Debridement; Skin, Subcutaneous Tissue & Muscle 
 ;;^UTILITY(U,$J,358.3,31289,1,3,0)
 ;;=3^11043
 ;;^UTILITY(U,$J,358.3,31290,0)
 ;;=11044^^125^1579^10
 ;;^UTILITY(U,$J,358.3,31290,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31290,1,2,0)
 ;;=2^Debridement; Skin, Subcutaneous Tissue, Muscle & Bone
 ;;^UTILITY(U,$J,358.3,31290,1,3,0)
 ;;=3^11044
 ;;^UTILITY(U,$J,358.3,31291,0)
 ;;=11012^^125^1579^1^^^^1
 ;;^UTILITY(U,$J,358.3,31291,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31291,1,2,0)
 ;;=2^Debr Rmvl Foreign Material;Muscle,Bone
 ;;^UTILITY(U,$J,358.3,31291,1,3,0)
 ;;=3^11012
 ;;^UTILITY(U,$J,358.3,31292,0)
 ;;=11001^^125^1579^5^^^^1
 ;;^UTILITY(U,$J,358.3,31292,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31292,1,2,0)
 ;;=2^Debr of extensive eczematous;ea addl 10%
 ;;^UTILITY(U,$J,358.3,31292,1,3,0)
 ;;=3^11001
 ;;^UTILITY(U,$J,358.3,31293,0)
 ;;=97597^^125^1579^13^^^^1
 ;;^UTILITY(U,$J,358.3,31293,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31293,1,2,0)
 ;;=2^Rmvl Devital Tiss <= 20 Sq cm
 ;;^UTILITY(U,$J,358.3,31293,1,3,0)
 ;;=3^97597
 ;;^UTILITY(U,$J,358.3,31294,0)
 ;;=97602^^125^1579^12^^^^1
 ;;^UTILITY(U,$J,358.3,31294,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31294,1,2,0)
 ;;=2^Non-Selective Debridement
 ;;^UTILITY(U,$J,358.3,31294,1,3,0)
 ;;=3^97602
 ;;^UTILITY(U,$J,358.3,31295,0)
 ;;=97610^^125^1579^11^^^^1
 ;;^UTILITY(U,$J,358.3,31295,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31295,1,2,0)
 ;;=2^Low Freq Non-Thermal US,Wound Assess
 ;;^UTILITY(U,$J,358.3,31295,1,3,0)
 ;;=3^97610
 ;;^UTILITY(U,$J,358.3,31296,0)
 ;;=97598^^125^1579^14^^^^1
 ;;^UTILITY(U,$J,358.3,31296,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31296,1,2,0)
 ;;=2^Rmvl Devital Tiss,Ea Addl 20 sq cm
 ;;^UTILITY(U,$J,358.3,31296,1,3,0)
 ;;=3^97598
 ;;^UTILITY(U,$J,358.3,31297,0)
 ;;=11721^^125^1579^7^^^^1
 ;;^UTILITY(U,$J,358.3,31297,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31297,1,2,0)
 ;;=2^Debride Nails any method,6 or more
 ;;^UTILITY(U,$J,358.3,31297,1,3,0)
 ;;=3^11721
 ;;^UTILITY(U,$J,358.3,31298,0)
 ;;=11720^^125^1579^6^^^^1
 ;;^UTILITY(U,$J,358.3,31298,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31298,1,2,0)
 ;;=2^Debride Nails any method,1-5
 ;;^UTILITY(U,$J,358.3,31298,1,3,0)
 ;;=3^11720
 ;;^UTILITY(U,$J,358.3,31299,0)
 ;;=11300^^125^1580^5
 ;;^UTILITY(U,$J,358.3,31299,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31299,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Trunk,Arms,Legs;0.5cm or less
 ;;^UTILITY(U,$J,358.3,31299,1,3,0)
 ;;=3^11300
 ;;^UTILITY(U,$J,358.3,31300,0)
 ;;=11301^^125^1580^6
 ;;^UTILITY(U,$J,358.3,31300,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31300,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Trunk,Arms,Legs;0.6cm-1.0cm
 ;;^UTILITY(U,$J,358.3,31300,1,3,0)
 ;;=3^11301
 ;;^UTILITY(U,$J,358.3,31301,0)
 ;;=11302^^125^1580^7
 ;;^UTILITY(U,$J,358.3,31301,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31301,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Trunk,Arms,Legs;1.1cm-2.0cm
