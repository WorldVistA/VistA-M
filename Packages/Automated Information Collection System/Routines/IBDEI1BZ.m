IBDEI1BZ ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23867,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23867,1,2,0)
 ;;=2^Debr Rmvl Foreign Material;Skin,Subq Tissue,Muscle
 ;;^UTILITY(U,$J,358.3,23867,1,3,0)
 ;;=3^11011
 ;;^UTILITY(U,$J,358.3,23868,0)
 ;;=11042^^142^1481^6
 ;;^UTILITY(U,$J,358.3,23868,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23868,1,2,0)
 ;;=2^Debridement; Skin & Subcutaneous Tissue
 ;;^UTILITY(U,$J,358.3,23868,1,3,0)
 ;;=3^11042
 ;;^UTILITY(U,$J,358.3,23869,0)
 ;;=11043^^142^1481^7
 ;;^UTILITY(U,$J,358.3,23869,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23869,1,2,0)
 ;;=2^Debridement; Skin, Subcutaneous Tissue & Muscle 
 ;;^UTILITY(U,$J,358.3,23869,1,3,0)
 ;;=3^11043
 ;;^UTILITY(U,$J,358.3,23870,0)
 ;;=11044^^142^1481^8
 ;;^UTILITY(U,$J,358.3,23870,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23870,1,2,0)
 ;;=2^Debridement; Skin, Subcutaneous Tissue, Muscle & Bone
 ;;^UTILITY(U,$J,358.3,23870,1,3,0)
 ;;=3^11044
 ;;^UTILITY(U,$J,358.3,23871,0)
 ;;=11012^^142^1481^1^^^^1
 ;;^UTILITY(U,$J,358.3,23871,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23871,1,2,0)
 ;;=2^Debr Rmvl Foreign Material;Muscle,Bone
 ;;^UTILITY(U,$J,358.3,23871,1,3,0)
 ;;=3^11012
 ;;^UTILITY(U,$J,358.3,23872,0)
 ;;=11001^^142^1481^5^^^^1
 ;;^UTILITY(U,$J,358.3,23872,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23872,1,2,0)
 ;;=2^Debr of extensive eczematous;ea addl 10%
 ;;^UTILITY(U,$J,358.3,23872,1,3,0)
 ;;=3^11001
 ;;^UTILITY(U,$J,358.3,23873,0)
 ;;=97597^^142^1481^11^^^^1
 ;;^UTILITY(U,$J,358.3,23873,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23873,1,2,0)
 ;;=2^Rmvl Devital Tiss <= 20 Sq cm
 ;;^UTILITY(U,$J,358.3,23873,1,3,0)
 ;;=3^97597
 ;;^UTILITY(U,$J,358.3,23874,0)
 ;;=97602^^142^1481^10^^^^1
 ;;^UTILITY(U,$J,358.3,23874,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23874,1,2,0)
 ;;=2^Non-Selective Debridement
 ;;^UTILITY(U,$J,358.3,23874,1,3,0)
 ;;=3^97602
 ;;^UTILITY(U,$J,358.3,23875,0)
 ;;=97610^^142^1481^9^^^^1
 ;;^UTILITY(U,$J,358.3,23875,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23875,1,2,0)
 ;;=2^Low Freq Non-Thermal US,Wound Assess
 ;;^UTILITY(U,$J,358.3,23875,1,3,0)
 ;;=3^97610
 ;;^UTILITY(U,$J,358.3,23876,0)
 ;;=97598^^142^1481^12^^^^1
 ;;^UTILITY(U,$J,358.3,23876,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23876,1,2,0)
 ;;=2^Rmvl Devital Tiss > 20 Sq cm
 ;;^UTILITY(U,$J,358.3,23876,1,3,0)
 ;;=3^97598
 ;;^UTILITY(U,$J,358.3,23877,0)
 ;;=11300^^142^1482^1
 ;;^UTILITY(U,$J,358.3,23877,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23877,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesions, Single; trunk, arms, legs- 0.5 cm or less
 ;;^UTILITY(U,$J,358.3,23877,1,3,0)
 ;;=3^11300
 ;;^UTILITY(U,$J,358.3,23878,0)
 ;;=11301^^142^1482^2
 ;;^UTILITY(U,$J,358.3,23878,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23878,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single; trunk, arms or legs- 0.6 to 1.0 cm
 ;;^UTILITY(U,$J,358.3,23878,1,3,0)
 ;;=3^11301
 ;;^UTILITY(U,$J,358.3,23879,0)
 ;;=11302^^142^1482^3
 ;;^UTILITY(U,$J,358.3,23879,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23879,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single- trunk, arms or legs 1.1 to 2.0 cm
 ;;^UTILITY(U,$J,358.3,23879,1,3,0)
 ;;=3^11302
 ;;^UTILITY(U,$J,358.3,23880,0)
 ;;=11305^^142^1482^5
 ;;^UTILITY(U,$J,358.3,23880,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23880,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion Single; scalp, neck, hands, feet, genitalia- 0.5 cm or less
 ;;^UTILITY(U,$J,358.3,23880,1,3,0)
 ;;=3^11305
 ;;^UTILITY(U,$J,358.3,23881,0)
 ;;=11306^^142^1482^6
 ;;^UTILITY(U,$J,358.3,23881,1,0)
 ;;=^358.31IA^3^2
