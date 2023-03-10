IBDEI0KZ ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9443,0)
 ;;=R22.0^^39^413^109
 ;;^UTILITY(U,$J,358.3,9443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9443,1,3,0)
 ;;=3^Localized Swelling/Mass/Lump,Head
 ;;^UTILITY(U,$J,358.3,9443,1,4,0)
 ;;=4^R22.0
 ;;^UTILITY(U,$J,358.3,9443,2)
 ;;=^5019284
 ;;^UTILITY(U,$J,358.3,9444,0)
 ;;=R22.1^^39^413^112
 ;;^UTILITY(U,$J,358.3,9444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9444,1,3,0)
 ;;=3^Localized Swelling/Mass/Lump,Neck
 ;;^UTILITY(U,$J,358.3,9444,1,4,0)
 ;;=4^R22.1
 ;;^UTILITY(U,$J,358.3,9444,2)
 ;;=^5019285
 ;;^UTILITY(U,$J,358.3,9445,0)
 ;;=R22.2^^39^413^115
 ;;^UTILITY(U,$J,358.3,9445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9445,1,3,0)
 ;;=3^Localized Swelling/Mass/Lump,Trunk
 ;;^UTILITY(U,$J,358.3,9445,1,4,0)
 ;;=4^R22.2
 ;;^UTILITY(U,$J,358.3,9445,2)
 ;;=^5019286
 ;;^UTILITY(U,$J,358.3,9446,0)
 ;;=R22.31^^39^413^114
 ;;^UTILITY(U,$J,358.3,9446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9446,1,3,0)
 ;;=3^Localized Swelling/Mass/Lump,Right Upper Limb
 ;;^UTILITY(U,$J,358.3,9446,1,4,0)
 ;;=4^R22.31
 ;;^UTILITY(U,$J,358.3,9446,2)
 ;;=^5019288
 ;;^UTILITY(U,$J,358.3,9447,0)
 ;;=R22.32^^39^413^111
 ;;^UTILITY(U,$J,358.3,9447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9447,1,3,0)
 ;;=3^Localized Swelling/Mass/Lump,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,9447,1,4,0)
 ;;=4^R22.32
 ;;^UTILITY(U,$J,358.3,9447,2)
 ;;=^5019289
 ;;^UTILITY(U,$J,358.3,9448,0)
 ;;=R22.33^^39^413^107
 ;;^UTILITY(U,$J,358.3,9448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9448,1,3,0)
 ;;=3^Localized Swelling/Mass/Lump,Bilateral Upper Limb
 ;;^UTILITY(U,$J,358.3,9448,1,4,0)
 ;;=4^R22.33
 ;;^UTILITY(U,$J,358.3,9448,2)
 ;;=^5019290
 ;;^UTILITY(U,$J,358.3,9449,0)
 ;;=R22.42^^39^413^110
 ;;^UTILITY(U,$J,358.3,9449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9449,1,3,0)
 ;;=3^Localized Swelling/Mass/Lump,Left Lower Limb
 ;;^UTILITY(U,$J,358.3,9449,1,4,0)
 ;;=4^R22.42
 ;;^UTILITY(U,$J,358.3,9449,2)
 ;;=^5134179
 ;;^UTILITY(U,$J,358.3,9450,0)
 ;;=R22.41^^39^413^113
 ;;^UTILITY(U,$J,358.3,9450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9450,1,3,0)
 ;;=3^Localized Swelling/Mass/Lump,Right Lower Limb
 ;;^UTILITY(U,$J,358.3,9450,1,4,0)
 ;;=4^R22.41
 ;;^UTILITY(U,$J,358.3,9450,2)
 ;;=^5134178
 ;;^UTILITY(U,$J,358.3,9451,0)
 ;;=R22.43^^39^413^108
 ;;^UTILITY(U,$J,358.3,9451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9451,1,3,0)
 ;;=3^Localized Swelling/Mass/Lump,Bilateral Lower Limb
 ;;^UTILITY(U,$J,358.3,9451,1,4,0)
 ;;=4^R22.43
 ;;^UTILITY(U,$J,358.3,9451,2)
 ;;=^5019291
 ;;^UTILITY(U,$J,358.3,9452,0)
 ;;=R22.9^^39^413^116
 ;;^UTILITY(U,$J,358.3,9452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9452,1,3,0)
 ;;=3^Localized Swelling/Mass/Lump,Unspec
 ;;^UTILITY(U,$J,358.3,9452,1,4,0)
 ;;=4^R22.9
 ;;^UTILITY(U,$J,358.3,9452,2)
 ;;=^5019292
 ;;^UTILITY(U,$J,358.3,9453,0)
 ;;=R23.0^^39^413^60
 ;;^UTILITY(U,$J,358.3,9453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9453,1,3,0)
 ;;=3^Cyanosis
 ;;^UTILITY(U,$J,358.3,9453,1,4,0)
 ;;=4^R23.0
 ;;^UTILITY(U,$J,358.3,9453,2)
 ;;=^5019293
 ;;^UTILITY(U,$J,358.3,9454,0)
 ;;=R23.1^^39^413^132
 ;;^UTILITY(U,$J,358.3,9454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9454,1,3,0)
 ;;=3^Pallor
 ;;^UTILITY(U,$J,358.3,9454,1,4,0)
 ;;=4^R23.1
 ;;^UTILITY(U,$J,358.3,9454,2)
 ;;=^5019294
 ;;^UTILITY(U,$J,358.3,9455,0)
 ;;=R23.2^^39^413^79
 ;;^UTILITY(U,$J,358.3,9455,1,0)
 ;;=^358.31IA^4^2
