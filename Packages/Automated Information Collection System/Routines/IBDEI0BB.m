IBDEI0BB ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5321,0)
 ;;=14020^^40^460^1^^^^1
 ;;^UTILITY(U,$J,358.3,5321,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5321,1,2,0)
 ;;=2^14020
 ;;^UTILITY(U,$J,358.3,5321,1,3,0)
 ;;=3^Skin Tissue Rearrangement,S/A/L,Up to 10.0 sq cm
 ;;^UTILITY(U,$J,358.3,5322,0)
 ;;=14021^^40^460^2^^^^1
 ;;^UTILITY(U,$J,358.3,5322,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5322,1,2,0)
 ;;=2^14021
 ;;^UTILITY(U,$J,358.3,5322,1,3,0)
 ;;=3^Skin Tissue Rearrangement,S/A/L,10.1 to 30.0 sq cm
 ;;^UTILITY(U,$J,358.3,5323,0)
 ;;=14000^^40^461^1^^^^1
 ;;^UTILITY(U,$J,358.3,5323,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5323,1,2,0)
 ;;=2^14000
 ;;^UTILITY(U,$J,358.3,5323,1,3,0)
 ;;=3^Skin Tissue Rearrangement,Trunk,Up to 10.0 sq cm
 ;;^UTILITY(U,$J,358.3,5324,0)
 ;;=14001^^40^461^2^^^^1
 ;;^UTILITY(U,$J,358.3,5324,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5324,1,2,0)
 ;;=2^14001
 ;;^UTILITY(U,$J,358.3,5324,1,3,0)
 ;;=3^Skin Tissue Rearrangement,Trunk,10.1 to 30.0 sq cm
 ;;^UTILITY(U,$J,358.3,5325,0)
 ;;=13120^^40^462^1^^^^1
 ;;^UTILITY(U,$J,358.3,5325,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5325,1,2,0)
 ;;=2^13120
 ;;^UTILITY(U,$J,358.3,5325,1,3,0)
 ;;=3^Complex Repair Scalp;1.1 to 2.5 cm
 ;;^UTILITY(U,$J,358.3,5326,0)
 ;;=13121^^40^462^2^^^^1
 ;;^UTILITY(U,$J,358.3,5326,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5326,1,2,0)
 ;;=2^13121
 ;;^UTILITY(U,$J,358.3,5326,1,3,0)
 ;;=3^Complex Repair Scalp;2.6 to 7.5 cm
 ;;^UTILITY(U,$J,358.3,5327,0)
 ;;=13122^^40^462^3^^^^1
 ;;^UTILITY(U,$J,358.3,5327,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5327,1,2,0)
 ;;=2^13122
 ;;^UTILITY(U,$J,358.3,5327,1,3,0)
 ;;=3^Complex Repair Scalp;Ea Addl 5 cm
 ;;^UTILITY(U,$J,358.3,5328,0)
 ;;=14060^^40^463^1^^^^1
 ;;^UTILITY(U,$J,358.3,5328,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5328,1,2,0)
 ;;=2^14060
 ;;^UTILITY(U,$J,358.3,5328,1,3,0)
 ;;=3^Skin Tissue Rearrangement Eyelid,10sq cm or less
 ;;^UTILITY(U,$J,358.3,5329,0)
 ;;=14061^^40^463^2^^^^1
 ;;^UTILITY(U,$J,358.3,5329,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5329,1,2,0)
 ;;=2^14061
 ;;^UTILITY(U,$J,358.3,5329,1,3,0)
 ;;=3^Skin Tissue Rearrangement Eyelid,10.1 to 30.0sq cm
 ;;^UTILITY(U,$J,358.3,5330,0)
 ;;=14301^^40^463^3^^^^1
 ;;^UTILITY(U,$J,358.3,5330,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5330,1,2,0)
 ;;=2^14301
 ;;^UTILITY(U,$J,358.3,5330,1,3,0)
 ;;=3^Skin Tissue Rearrangement Eyelid,30.1 to 60.0sq cm
 ;;^UTILITY(U,$J,358.3,5331,0)
 ;;=14302^^40^463^4^^^^1
 ;;^UTILITY(U,$J,358.3,5331,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5331,1,2,0)
 ;;=2^14302
 ;;^UTILITY(U,$J,358.3,5331,1,3,0)
 ;;=3^Skin Tissue Rearrangement Eyelid,Ea Addl 30.0 sq cm
 ;;^UTILITY(U,$J,358.3,5332,0)
 ;;=67810^^40^464^2^^^^1
 ;;^UTILITY(U,$J,358.3,5332,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5332,1,2,0)
 ;;=2^67810
 ;;^UTILITY(U,$J,358.3,5332,1,3,0)
 ;;=3^Biopsy of Eyelid
 ;;^UTILITY(U,$J,358.3,5333,0)
 ;;=69100^^40^464^1^^^^1
 ;;^UTILITY(U,$J,358.3,5333,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5333,1,2,0)
 ;;=2^69100
 ;;^UTILITY(U,$J,358.3,5333,1,3,0)
 ;;=3^Biopsy of External Ear
 ;;^UTILITY(U,$J,358.3,5334,0)
 ;;=40490^^40^464^3^^^^1
 ;;^UTILITY(U,$J,358.3,5334,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5334,1,2,0)
 ;;=2^40490
 ;;^UTILITY(U,$J,358.3,5334,1,3,0)
 ;;=3^Biopsy of Lip
 ;;^UTILITY(U,$J,358.3,5335,0)
 ;;=54100^^40^464^5^^^^1
 ;;^UTILITY(U,$J,358.3,5335,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5335,1,2,0)
 ;;=2^54100
 ;;^UTILITY(U,$J,358.3,5335,1,3,0)
 ;;=3^Biopsy of Penis
 ;;^UTILITY(U,$J,358.3,5336,0)
 ;;=11755^^40^464^4^^^^1
 ;;^UTILITY(U,$J,358.3,5336,1,0)
 ;;=^358.31IA^3^2
