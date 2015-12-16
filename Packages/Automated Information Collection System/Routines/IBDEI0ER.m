IBDEI0ER ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6747,1,5,0)
 ;;=5^Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,6747,2)
 ;;=Ulcer of Ankle, non-diabetic^322145
 ;;^UTILITY(U,$J,358.3,6748,0)
 ;;=707.12^^31^414^70
 ;;^UTILITY(U,$J,358.3,6748,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6748,1,4,0)
 ;;=4^707.12
 ;;^UTILITY(U,$J,358.3,6748,1,5,0)
 ;;=5^Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,6748,2)
 ;;=Ulcer of Calf, non-diabetic^322144
 ;;^UTILITY(U,$J,358.3,6749,0)
 ;;=707.15^^31^414^71
 ;;^UTILITY(U,$J,358.3,6749,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6749,1,4,0)
 ;;=4^707.15
 ;;^UTILITY(U,$J,358.3,6749,1,5,0)
 ;;=5^Ulcer of Foot
 ;;^UTILITY(U,$J,358.3,6749,2)
 ;;=Ulcer of Foot, non-diabetic^322148
 ;;^UTILITY(U,$J,358.3,6750,0)
 ;;=707.14^^31^414^72
 ;;^UTILITY(U,$J,358.3,6750,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6750,1,4,0)
 ;;=4^707.14
 ;;^UTILITY(U,$J,358.3,6750,1,5,0)
 ;;=5^Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,6750,2)
 ;;=Ulcer of Heel/Midfoot, non-d-diabetic^322146
 ;;^UTILITY(U,$J,358.3,6751,0)
 ;;=707.10^^31^414^68
 ;;^UTILITY(U,$J,358.3,6751,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6751,1,4,0)
 ;;=4^707.10
 ;;^UTILITY(U,$J,358.3,6751,1,5,0)
 ;;=5^Ulcer Lower Extremity
 ;;^UTILITY(U,$J,358.3,6751,2)
 ;;=Ulcer, LE, non-diabetic^322142
 ;;^UTILITY(U,$J,358.3,6752,0)
 ;;=707.11^^31^414^73
 ;;^UTILITY(U,$J,358.3,6752,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6752,1,4,0)
 ;;=4^707.11
 ;;^UTILITY(U,$J,358.3,6752,1,5,0)
 ;;=5^Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,6752,2)
 ;;=Ulcer of Thigh, non-diabetic^322143
 ;;^UTILITY(U,$J,358.3,6753,0)
 ;;=695.3^^31^414^58
 ;;^UTILITY(U,$J,358.3,6753,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6753,1,4,0)
 ;;=4^695.3
 ;;^UTILITY(U,$J,358.3,6753,1,5,0)
 ;;=5^Rosacea
 ;;^UTILITY(U,$J,358.3,6753,2)
 ;;=^107114
 ;;^UTILITY(U,$J,358.3,6754,0)
 ;;=706.1^^31^414^1
 ;;^UTILITY(U,$J,358.3,6754,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6754,1,4,0)
 ;;=4^706.1
 ;;^UTILITY(U,$J,358.3,6754,1,5,0)
 ;;=5^Acne Vulgaris
 ;;^UTILITY(U,$J,358.3,6754,2)
 ;;=^87239
 ;;^UTILITY(U,$J,358.3,6755,0)
 ;;=702.0^^31^414^2
 ;;^UTILITY(U,$J,358.3,6755,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6755,1,4,0)
 ;;=4^702.0
 ;;^UTILITY(U,$J,358.3,6755,1,5,0)
 ;;=5^Actinic Keratosis
 ;;^UTILITY(U,$J,358.3,6755,2)
 ;;=^66900
 ;;^UTILITY(U,$J,358.3,6756,0)
 ;;=704.00^^31^414^3
 ;;^UTILITY(U,$J,358.3,6756,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6756,1,4,0)
 ;;=4^704.00
 ;;^UTILITY(U,$J,358.3,6756,1,5,0)
 ;;=5^Alopecia Nos
 ;;^UTILITY(U,$J,358.3,6756,2)
 ;;=^5078
 ;;^UTILITY(U,$J,358.3,6757,0)
 ;;=680.9^^31^414^5
 ;;^UTILITY(U,$J,358.3,6757,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6757,1,4,0)
 ;;=4^680.9
 ;;^UTILITY(U,$J,358.3,6757,1,5,0)
 ;;=5^Carbuncle/Furuncle
 ;;^UTILITY(U,$J,358.3,6757,2)
 ;;=^19191
 ;;^UTILITY(U,$J,358.3,6758,0)
 ;;=680.5^^31^414^4
 ;;^UTILITY(U,$J,358.3,6758,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6758,1,4,0)
 ;;=4^680.5
 ;;^UTILITY(U,$J,358.3,6758,1,5,0)
 ;;=5^Carbuncle Of Buttock
 ;;^UTILITY(U,$J,358.3,6758,2)
 ;;=^271878
 ;;^UTILITY(U,$J,358.3,6759,0)
 ;;=709.9^^31^414^65
 ;;^UTILITY(U,$J,358.3,6759,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6759,1,4,0)
 ;;=4^709.9
 ;;^UTILITY(U,$J,358.3,6759,1,5,0)
 ;;=5^Skin Lesion, Unsp
 ;;^UTILITY(U,$J,358.3,6759,2)
 ;;=^111083
 ;;^UTILITY(U,$J,358.3,6760,0)
 ;;=078.11^^31^414^15
 ;;^UTILITY(U,$J,358.3,6760,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6760,1,4,0)
 ;;=4^078.11
 ;;^UTILITY(U,$J,358.3,6760,1,5,0)
 ;;=5^Condyloma Acuminatum
 ;;^UTILITY(U,$J,358.3,6760,2)
 ;;=^295788
 ;;^UTILITY(U,$J,358.3,6761,0)
 ;;=700.^^31^414^16
