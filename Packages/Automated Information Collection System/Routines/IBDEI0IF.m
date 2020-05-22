IBDEI0IF ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8036,2)
 ;;=^5001145
 ;;^UTILITY(U,$J,358.3,8037,0)
 ;;=C4A.39^^65^517^83
 ;;^UTILITY(U,$J,358.3,8037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8037,1,3,0)
 ;;=3^Merkle Cell CA,Parts of Face,Other
 ;;^UTILITY(U,$J,358.3,8037,1,4,0)
 ;;=4^C4A.39
 ;;^UTILITY(U,$J,358.3,8037,2)
 ;;=^5001146
 ;;^UTILITY(U,$J,358.3,8038,0)
 ;;=C4A.59^^65^517^84
 ;;^UTILITY(U,$J,358.3,8038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8038,1,3,0)
 ;;=3^Merkle Cell CA,Parts of Trunk,Other
 ;;^UTILITY(U,$J,358.3,8038,1,4,0)
 ;;=4^C4A.59
 ;;^UTILITY(U,$J,358.3,8038,2)
 ;;=^5001150
 ;;^UTILITY(U,$J,358.3,8039,0)
 ;;=C4A.8^^65^517^82
 ;;^UTILITY(U,$J,358.3,8039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8039,1,3,0)
 ;;=3^Merkle Cell CA,Overlapping Sites
 ;;^UTILITY(U,$J,358.3,8039,1,4,0)
 ;;=4^C4A.8
 ;;^UTILITY(U,$J,358.3,8039,2)
 ;;=^5001157
 ;;^UTILITY(U,$J,358.3,8040,0)
 ;;=C4A.9^^65^517^88
 ;;^UTILITY(U,$J,358.3,8040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8040,1,3,0)
 ;;=3^Merkle Cell CA,Unspec
 ;;^UTILITY(U,$J,358.3,8040,1,4,0)
 ;;=4^C4A.9
 ;;^UTILITY(U,$J,358.3,8040,2)
 ;;=^5001158
 ;;^UTILITY(U,$J,358.3,8041,0)
 ;;=C84.09^^65^517^93
 ;;^UTILITY(U,$J,358.3,8041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8041,1,3,0)
 ;;=3^Mycosis Fungoides,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,8041,1,4,0)
 ;;=4^C84.09
 ;;^UTILITY(U,$J,358.3,8041,2)
 ;;=^5001630
 ;;^UTILITY(U,$J,358.3,8042,0)
 ;;=C84.03^^65^517^96
 ;;^UTILITY(U,$J,358.3,8042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8042,1,3,0)
 ;;=3^Mycosis Fungoides,Intra-Abdominal Lymph Nodes
 ;;^UTILITY(U,$J,358.3,8042,1,4,0)
 ;;=4^C84.03
 ;;^UTILITY(U,$J,358.3,8042,2)
 ;;=^5001624
 ;;^UTILITY(U,$J,358.3,8043,0)
 ;;=C84.06^^65^517^97
 ;;^UTILITY(U,$J,358.3,8043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8043,1,3,0)
 ;;=3^Mycosis Fungoides,Intrapelvic Lymph Nodes
 ;;^UTILITY(U,$J,358.3,8043,1,4,0)
 ;;=4^C84.06
 ;;^UTILITY(U,$J,358.3,8043,2)
 ;;=^5001627
 ;;^UTILITY(U,$J,358.3,8044,0)
 ;;=C84.02^^65^517^98
 ;;^UTILITY(U,$J,358.3,8044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8044,1,3,0)
 ;;=3^Mycosis Fungoides,Intrathoracic Lymph Nodes
 ;;^UTILITY(U,$J,358.3,8044,1,4,0)
 ;;=4^C84.02
 ;;^UTILITY(U,$J,358.3,8044,2)
 ;;=^5001623
 ;;^UTILITY(U,$J,358.3,8045,0)
 ;;=C84.04^^65^517^92
 ;;^UTILITY(U,$J,358.3,8045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8045,1,3,0)
 ;;=3^Mycosis Fungoides,Axilla/Upper Limb Lymph Nodes
 ;;^UTILITY(U,$J,358.3,8045,1,4,0)
 ;;=4^C84.04
 ;;^UTILITY(U,$J,358.3,8045,2)
 ;;=^5001625
 ;;^UTILITY(U,$J,358.3,8046,0)
 ;;=C84.01^^65^517^94
 ;;^UTILITY(U,$J,358.3,8046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8046,1,3,0)
 ;;=3^Mycosis Fungoides,Head/Face/Neck Lymph Nodes
 ;;^UTILITY(U,$J,358.3,8046,1,4,0)
 ;;=4^C84.01
 ;;^UTILITY(U,$J,358.3,8046,2)
 ;;=^5001622
 ;;^UTILITY(U,$J,358.3,8047,0)
 ;;=C84.05^^65^517^95
 ;;^UTILITY(U,$J,358.3,8047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8047,1,3,0)
 ;;=3^Mycosis Fungoides,Inguinal Region/LE Lymph Nodes
 ;;^UTILITY(U,$J,358.3,8047,1,4,0)
 ;;=4^C84.05
 ;;^UTILITY(U,$J,358.3,8047,2)
 ;;=^5001626
 ;;^UTILITY(U,$J,358.3,8048,0)
 ;;=C84.08^^65^517^99
 ;;^UTILITY(U,$J,358.3,8048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8048,1,3,0)
 ;;=3^Mycosis Fungoides,Multiple Site Lymph Nodes
 ;;^UTILITY(U,$J,358.3,8048,1,4,0)
 ;;=4^C84.08
 ;;^UTILITY(U,$J,358.3,8048,2)
 ;;=^5001629
