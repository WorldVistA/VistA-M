IBDEI0FY ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7058,1,3,0)
 ;;=3^Lichen Simplex Chronicus
 ;;^UTILITY(U,$J,358.3,7058,1,4,0)
 ;;=4^L28.0
 ;;^UTILITY(U,$J,358.3,7058,2)
 ;;=^259859
 ;;^UTILITY(U,$J,358.3,7059,0)
 ;;=L66.1^^46^464^1
 ;;^UTILITY(U,$J,358.3,7059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7059,1,3,0)
 ;;=3^Lichen Planopilaris
 ;;^UTILITY(U,$J,358.3,7059,1,4,0)
 ;;=4^L66.1
 ;;^UTILITY(U,$J,358.3,7059,2)
 ;;=^5009253
 ;;^UTILITY(U,$J,358.3,7060,0)
 ;;=L43.0^^46^464^2
 ;;^UTILITY(U,$J,358.3,7060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7060,1,3,0)
 ;;=3^Lichen Planus,Hypertrophic
 ;;^UTILITY(U,$J,358.3,7060,1,4,0)
 ;;=4^L43.0
 ;;^UTILITY(U,$J,358.3,7060,2)
 ;;=^5009178
 ;;^UTILITY(U,$J,358.3,7061,0)
 ;;=L43.2^^46^464^6
 ;;^UTILITY(U,$J,358.3,7061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7061,1,3,0)
 ;;=3^Lichenoid Drug Reaction
 ;;^UTILITY(U,$J,358.3,7061,1,4,0)
 ;;=4^L43.2
 ;;^UTILITY(U,$J,358.3,7061,2)
 ;;=^5009180
 ;;^UTILITY(U,$J,358.3,7062,0)
 ;;=L43.9^^46^464^3
 ;;^UTILITY(U,$J,358.3,7062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7062,1,3,0)
 ;;=3^Lichen Planus,Unspec
 ;;^UTILITY(U,$J,358.3,7062,1,4,0)
 ;;=4^L43.9
 ;;^UTILITY(U,$J,358.3,7062,2)
 ;;=^5009183
 ;;^UTILITY(U,$J,358.3,7063,0)
 ;;=L93.0^^46^464^8
 ;;^UTILITY(U,$J,358.3,7063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7063,1,3,0)
 ;;=3^Lupus,Erythematosus,Discoid
 ;;^UTILITY(U,$J,358.3,7063,1,4,0)
 ;;=4^L93.0
 ;;^UTILITY(U,$J,358.3,7063,2)
 ;;=^5009467
 ;;^UTILITY(U,$J,358.3,7064,0)
 ;;=L93.2^^46^464^10
 ;;^UTILITY(U,$J,358.3,7064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7064,1,3,0)
 ;;=3^Lupus,Erythematosus,Local
 ;;^UTILITY(U,$J,358.3,7064,1,4,0)
 ;;=4^L93.2
 ;;^UTILITY(U,$J,358.3,7064,2)
 ;;=^5009469
 ;;^UTILITY(U,$J,358.3,7065,0)
 ;;=L93.1^^46^464^11
 ;;^UTILITY(U,$J,358.3,7065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7065,1,3,0)
 ;;=3^Lupus,Erythematosus,Subacute Cutaneous
 ;;^UTILITY(U,$J,358.3,7065,1,4,0)
 ;;=4^L93.1
 ;;^UTILITY(U,$J,358.3,7065,2)
 ;;=^5009468
 ;;^UTILITY(U,$J,358.3,7066,0)
 ;;=M32.0^^46^464^9
 ;;^UTILITY(U,$J,358.3,7066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7066,1,3,0)
 ;;=3^Lupus,Erythematosus,Drug-Induced Systemic
 ;;^UTILITY(U,$J,358.3,7066,1,4,0)
 ;;=4^M32.0
 ;;^UTILITY(U,$J,358.3,7066,2)
 ;;=^5011752
 ;;^UTILITY(U,$J,358.3,7067,0)
 ;;=M32.10^^46^464^12
 ;;^UTILITY(U,$J,358.3,7067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7067,1,3,0)
 ;;=3^Lupus,Erythematosus,Systemic
 ;;^UTILITY(U,$J,358.3,7067,1,4,0)
 ;;=4^M32.10
 ;;^UTILITY(U,$J,358.3,7067,2)
 ;;=^5011753
 ;;^UTILITY(U,$J,358.3,7068,0)
 ;;=M32.19^^46^464^14
 ;;^UTILITY(U,$J,358.3,7068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7068,1,3,0)
 ;;=3^Lupus,Erythematosus,Systemic,Skin Involvmnt
 ;;^UTILITY(U,$J,358.3,7068,1,4,0)
 ;;=4^M32.19
 ;;^UTILITY(U,$J,358.3,7068,2)
 ;;=^5011759
 ;;^UTILITY(U,$J,358.3,7069,0)
 ;;=M32.9^^46^464^13
 ;;^UTILITY(U,$J,358.3,7069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7069,1,3,0)
 ;;=3^Lupus,Erythematosus,Systemic w/o Organ Involvmnt
 ;;^UTILITY(U,$J,358.3,7069,1,4,0)
 ;;=4^M32.9
 ;;^UTILITY(U,$J,358.3,7069,2)
 ;;=^5011761
 ;;^UTILITY(U,$J,358.3,7070,0)
 ;;=E88.1^^46^464^7
 ;;^UTILITY(U,$J,358.3,7070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7070,1,3,0)
 ;;=3^Lipodystrophy NOS
 ;;^UTILITY(U,$J,358.3,7070,1,4,0)
 ;;=4^E88.1
 ;;^UTILITY(U,$J,358.3,7070,2)
 ;;=^5003028
 ;;^UTILITY(U,$J,358.3,7071,0)
 ;;=L60.1^^46^465^2
 ;;^UTILITY(U,$J,358.3,7071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7071,1,3,0)
 ;;=3^Onycholysis
 ;;^UTILITY(U,$J,358.3,7071,1,4,0)
 ;;=4^L60.1
