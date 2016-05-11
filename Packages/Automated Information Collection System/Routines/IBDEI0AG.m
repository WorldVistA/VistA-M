IBDEI0AG ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4659,1,3,0)
 ;;=3^Lichen Sclerosus et Atrophicus
 ;;^UTILITY(U,$J,358.3,4659,1,4,0)
 ;;=4^L90.0
 ;;^UTILITY(U,$J,358.3,4659,2)
 ;;=^70699
 ;;^UTILITY(U,$J,358.3,4660,0)
 ;;=L28.0^^21^290^5
 ;;^UTILITY(U,$J,358.3,4660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4660,1,3,0)
 ;;=3^Lichen Simplex Chronicus
 ;;^UTILITY(U,$J,358.3,4660,1,4,0)
 ;;=4^L28.0
 ;;^UTILITY(U,$J,358.3,4660,2)
 ;;=^259859
 ;;^UTILITY(U,$J,358.3,4661,0)
 ;;=L66.1^^21^290^1
 ;;^UTILITY(U,$J,358.3,4661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4661,1,3,0)
 ;;=3^Lichen Planopilaris
 ;;^UTILITY(U,$J,358.3,4661,1,4,0)
 ;;=4^L66.1
 ;;^UTILITY(U,$J,358.3,4661,2)
 ;;=^5009253
 ;;^UTILITY(U,$J,358.3,4662,0)
 ;;=L43.0^^21^290^2
 ;;^UTILITY(U,$J,358.3,4662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4662,1,3,0)
 ;;=3^Lichen Planus,Hypertrophic
 ;;^UTILITY(U,$J,358.3,4662,1,4,0)
 ;;=4^L43.0
 ;;^UTILITY(U,$J,358.3,4662,2)
 ;;=^5009178
 ;;^UTILITY(U,$J,358.3,4663,0)
 ;;=L43.2^^21^290^6
 ;;^UTILITY(U,$J,358.3,4663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4663,1,3,0)
 ;;=3^Lichenoid Drug Reaction
 ;;^UTILITY(U,$J,358.3,4663,1,4,0)
 ;;=4^L43.2
 ;;^UTILITY(U,$J,358.3,4663,2)
 ;;=^5009180
 ;;^UTILITY(U,$J,358.3,4664,0)
 ;;=L43.9^^21^290^3
 ;;^UTILITY(U,$J,358.3,4664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4664,1,3,0)
 ;;=3^Lichen Planus,Unspec
 ;;^UTILITY(U,$J,358.3,4664,1,4,0)
 ;;=4^L43.9
 ;;^UTILITY(U,$J,358.3,4664,2)
 ;;=^5009183
 ;;^UTILITY(U,$J,358.3,4665,0)
 ;;=L93.0^^21^290^8
 ;;^UTILITY(U,$J,358.3,4665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4665,1,3,0)
 ;;=3^Lupus,Erythematosus,Discoid
 ;;^UTILITY(U,$J,358.3,4665,1,4,0)
 ;;=4^L93.0
 ;;^UTILITY(U,$J,358.3,4665,2)
 ;;=^5009467
 ;;^UTILITY(U,$J,358.3,4666,0)
 ;;=L93.2^^21^290^10
 ;;^UTILITY(U,$J,358.3,4666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4666,1,3,0)
 ;;=3^Lupus,Erythematosus,Local
 ;;^UTILITY(U,$J,358.3,4666,1,4,0)
 ;;=4^L93.2
 ;;^UTILITY(U,$J,358.3,4666,2)
 ;;=^5009469
 ;;^UTILITY(U,$J,358.3,4667,0)
 ;;=L93.1^^21^290^11
 ;;^UTILITY(U,$J,358.3,4667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4667,1,3,0)
 ;;=3^Lupus,Erythematosus,Subacute Cutaneous
 ;;^UTILITY(U,$J,358.3,4667,1,4,0)
 ;;=4^L93.1
 ;;^UTILITY(U,$J,358.3,4667,2)
 ;;=^5009468
 ;;^UTILITY(U,$J,358.3,4668,0)
 ;;=M32.0^^21^290^9
 ;;^UTILITY(U,$J,358.3,4668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4668,1,3,0)
 ;;=3^Lupus,Erythematosus,Drug-Induced Systemic
 ;;^UTILITY(U,$J,358.3,4668,1,4,0)
 ;;=4^M32.0
 ;;^UTILITY(U,$J,358.3,4668,2)
 ;;=^5011752
 ;;^UTILITY(U,$J,358.3,4669,0)
 ;;=M32.10^^21^290^12
 ;;^UTILITY(U,$J,358.3,4669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4669,1,3,0)
 ;;=3^Lupus,Erythematosus,Systemic
 ;;^UTILITY(U,$J,358.3,4669,1,4,0)
 ;;=4^M32.10
 ;;^UTILITY(U,$J,358.3,4669,2)
 ;;=^5011753
 ;;^UTILITY(U,$J,358.3,4670,0)
 ;;=M32.19^^21^290^14
 ;;^UTILITY(U,$J,358.3,4670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4670,1,3,0)
 ;;=3^Lupus,Erythematosus,Systemic,Skin Involvmnt
 ;;^UTILITY(U,$J,358.3,4670,1,4,0)
 ;;=4^M32.19
 ;;^UTILITY(U,$J,358.3,4670,2)
 ;;=^5011759
 ;;^UTILITY(U,$J,358.3,4671,0)
 ;;=M32.9^^21^290^13
 ;;^UTILITY(U,$J,358.3,4671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4671,1,3,0)
 ;;=3^Lupus,Erythematosus,Systemic w/o Organ Involvmnt
 ;;^UTILITY(U,$J,358.3,4671,1,4,0)
 ;;=4^M32.9
 ;;^UTILITY(U,$J,358.3,4671,2)
 ;;=^5011761
 ;;^UTILITY(U,$J,358.3,4672,0)
 ;;=E88.1^^21^290^7
 ;;^UTILITY(U,$J,358.3,4672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4672,1,3,0)
 ;;=3^Lipodystrophy NOS
 ;;^UTILITY(U,$J,358.3,4672,1,4,0)
 ;;=4^E88.1
 ;;^UTILITY(U,$J,358.3,4672,2)
 ;;=^5003028
