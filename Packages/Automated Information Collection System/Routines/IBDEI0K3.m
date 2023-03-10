IBDEI0K3 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9040,1,3,0)
 ;;=3^Abnormal Involuntary Movements,Unspec
 ;;^UTILITY(U,$J,358.3,9040,1,4,0)
 ;;=4^R25.9
 ;;^UTILITY(U,$J,358.3,9040,2)
 ;;=^5019303
 ;;^UTILITY(U,$J,358.3,9041,0)
 ;;=R25.3^^39^406^5
 ;;^UTILITY(U,$J,358.3,9041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9041,1,3,0)
 ;;=3^Fasciculation/Twitching
 ;;^UTILITY(U,$J,358.3,9041,1,4,0)
 ;;=4^R25.3
 ;;^UTILITY(U,$J,358.3,9041,2)
 ;;=^44985
 ;;^UTILITY(U,$J,358.3,9042,0)
 ;;=R25.8^^39^406^2
 ;;^UTILITY(U,$J,358.3,9042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9042,1,3,0)
 ;;=3^Abnormal Involuntary Movements,Other
 ;;^UTILITY(U,$J,358.3,9042,1,4,0)
 ;;=4^R25.8
 ;;^UTILITY(U,$J,358.3,9042,2)
 ;;=^5019302
 ;;^UTILITY(U,$J,358.3,9043,0)
 ;;=M02.30^^39^407^147
 ;;^UTILITY(U,$J,358.3,9043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9043,1,3,0)
 ;;=3^Reiter's Disease,Unspec Site
 ;;^UTILITY(U,$J,358.3,9043,1,4,0)
 ;;=4^M02.30
 ;;^UTILITY(U,$J,358.3,9043,2)
 ;;=^5009790
 ;;^UTILITY(U,$J,358.3,9044,0)
 ;;=M10.9^^39^407^41
 ;;^UTILITY(U,$J,358.3,9044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9044,1,3,0)
 ;;=3^Gout,Unspec
 ;;^UTILITY(U,$J,358.3,9044,1,4,0)
 ;;=4^M10.9
 ;;^UTILITY(U,$J,358.3,9044,2)
 ;;=^5010404
 ;;^UTILITY(U,$J,358.3,9045,0)
 ;;=G90.59^^39^407^35
 ;;^UTILITY(U,$J,358.3,9045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9045,1,3,0)
 ;;=3^Complex Regional Pain Syndrome I,Unspec
 ;;^UTILITY(U,$J,358.3,9045,1,4,0)
 ;;=4^G90.59
 ;;^UTILITY(U,$J,358.3,9045,2)
 ;;=^5004171
 ;;^UTILITY(U,$J,358.3,9046,0)
 ;;=G56.01^^39^407^13
 ;;^UTILITY(U,$J,358.3,9046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9046,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Right Upper Limb
 ;;^UTILITY(U,$J,358.3,9046,1,4,0)
 ;;=4^G56.01
 ;;^UTILITY(U,$J,358.3,9046,2)
 ;;=^5004018
 ;;^UTILITY(U,$J,358.3,9047,0)
 ;;=G56.02^^39^407^12
 ;;^UTILITY(U,$J,358.3,9047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9047,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,9047,1,4,0)
 ;;=4^G56.02
 ;;^UTILITY(U,$J,358.3,9047,2)
 ;;=^5004019
 ;;^UTILITY(U,$J,358.3,9048,0)
 ;;=G56.21^^39^407^60
 ;;^UTILITY(U,$J,358.3,9048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9048,1,3,0)
 ;;=3^Lesion of Ulnar Nerve,Right Upper Limb
 ;;^UTILITY(U,$J,358.3,9048,1,4,0)
 ;;=4^G56.21
 ;;^UTILITY(U,$J,358.3,9048,2)
 ;;=^5004024
 ;;^UTILITY(U,$J,358.3,9049,0)
 ;;=G56.22^^39^407^59
 ;;^UTILITY(U,$J,358.3,9049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9049,1,3,0)
 ;;=3^Lesion of Ulnar Nerve,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,9049,1,4,0)
 ;;=4^G56.22
 ;;^UTILITY(U,$J,358.3,9049,2)
 ;;=^5004025
 ;;^UTILITY(U,$J,358.3,9050,0)
 ;;=L40.52^^39^407^143
 ;;^UTILITY(U,$J,358.3,9050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9050,1,3,0)
 ;;=3^Psoriatic Arthritis Mutilans
 ;;^UTILITY(U,$J,358.3,9050,1,4,0)
 ;;=4^L40.52
 ;;^UTILITY(U,$J,358.3,9050,2)
 ;;=^5009167
 ;;^UTILITY(U,$J,358.3,9051,0)
 ;;=L40.53^^39^407^144
 ;;^UTILITY(U,$J,358.3,9051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9051,1,3,0)
 ;;=3^Psoriatic Spondylitis
 ;;^UTILITY(U,$J,358.3,9051,1,4,0)
 ;;=4^L40.53
 ;;^UTILITY(U,$J,358.3,9051,2)
 ;;=^5009168
 ;;^UTILITY(U,$J,358.3,9052,0)
 ;;=M32.9^^39^407^187
 ;;^UTILITY(U,$J,358.3,9052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9052,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Unspec
 ;;^UTILITY(U,$J,358.3,9052,1,4,0)
 ;;=4^M32.9
 ;;^UTILITY(U,$J,358.3,9052,2)
 ;;=^5011761
