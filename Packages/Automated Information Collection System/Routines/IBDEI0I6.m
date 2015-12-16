IBDEI0I6 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8497,0)
 ;;=V12.03^^35^485^39
 ;;^UTILITY(U,$J,358.3,8497,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8497,1,4,0)
 ;;=4^V12.03
 ;;^UTILITY(U,$J,358.3,8497,1,5,0)
 ;;=5^Hx of Malaria
 ;;^UTILITY(U,$J,358.3,8497,2)
 ;;=Hx of Malaria^303395
 ;;^UTILITY(U,$J,358.3,8498,0)
 ;;=V10.82^^35^485^40
 ;;^UTILITY(U,$J,358.3,8498,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8498,1,4,0)
 ;;=4^V10.82
 ;;^UTILITY(U,$J,358.3,8498,1,5,0)
 ;;=5^Hx of Malignant Melanoma
 ;;^UTILITY(U,$J,358.3,8498,2)
 ;;=Hx of Malignant Melanoma^295240
 ;;^UTILITY(U,$J,358.3,8499,0)
 ;;=V10.62^^35^485^43
 ;;^UTILITY(U,$J,358.3,8499,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8499,1,4,0)
 ;;=4^V10.62
 ;;^UTILITY(U,$J,358.3,8499,1,5,0)
 ;;=5^Hx of Myeloid Leukemia
 ;;^UTILITY(U,$J,358.3,8499,2)
 ;;=Hx of Myeloid Leukemia^295233
 ;;^UTILITY(U,$J,358.3,8500,0)
 ;;=V10.63^^35^485^41
 ;;^UTILITY(U,$J,358.3,8500,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8500,1,4,0)
 ;;=4^V10.63
 ;;^UTILITY(U,$J,358.3,8500,1,5,0)
 ;;=5^Hx of Monocytic Leukemia
 ;;^UTILITY(U,$J,358.3,8500,2)
 ;;=Hx of Monocytic Leukemia^295234
 ;;^UTILITY(U,$J,358.3,8501,0)
 ;;=V11.2^^35^485^32
 ;;^UTILITY(U,$J,358.3,8501,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8501,1,4,0)
 ;;=4^V11.2
 ;;^UTILITY(U,$J,358.3,8501,1,5,0)
 ;;=5^Hx of Dysthymia
 ;;^UTILITY(U,$J,358.3,8501,2)
 ;;=Hx of Dysthymia^295251
 ;;^UTILITY(U,$J,358.3,8502,0)
 ;;=V15.81^^35^485^60
 ;;^UTILITY(U,$J,358.3,8502,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8502,1,4,0)
 ;;=4^V15.81
 ;;^UTILITY(U,$J,358.3,8502,1,5,0)
 ;;=5^Noncompliance With Medical Treatment
 ;;^UTILITY(U,$J,358.3,8502,2)
 ;;=^295290
 ;;^UTILITY(U,$J,358.3,8503,0)
 ;;=V10.43^^35^485^44
 ;;^UTILITY(U,$J,358.3,8503,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8503,1,4,0)
 ;;=4^V10.43
 ;;^UTILITY(U,$J,358.3,8503,1,5,0)
 ;;=5^Hx of Ovarian CA
 ;;^UTILITY(U,$J,358.3,8503,2)
 ;;=Hx of Ovarian CA^295221
 ;;^UTILITY(U,$J,358.3,8504,0)
 ;;=V12.71^^35^485^45
 ;;^UTILITY(U,$J,358.3,8504,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8504,1,4,0)
 ;;=4^V12.71
 ;;^UTILITY(U,$J,358.3,8504,1,5,0)
 ;;=5^Hx of Peptic Ulcer Disease
 ;;^UTILITY(U,$J,358.3,8504,2)
 ;;=^303400
 ;;^UTILITY(U,$J,358.3,8505,0)
 ;;=V10.46^^35^485^48
 ;;^UTILITY(U,$J,358.3,8505,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8505,1,4,0)
 ;;=4^V10.46
 ;;^UTILITY(U,$J,358.3,8505,1,5,0)
 ;;=5^Hx of Prostate Cancer
 ;;^UTILITY(U,$J,358.3,8505,2)
 ;;=Hx of Prostate Cancer^295224
 ;;^UTILITY(U,$J,358.3,8506,0)
 ;;=V11.0^^35^485^50
 ;;^UTILITY(U,$J,358.3,8506,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8506,1,4,0)
 ;;=4^V11.0
 ;;^UTILITY(U,$J,358.3,8506,1,5,0)
 ;;=5^Hx of Schizophrenia
 ;;^UTILITY(U,$J,358.3,8506,2)
 ;;=Hx of Schizophrenia^295249
 ;;^UTILITY(U,$J,358.3,8507,0)
 ;;=V10.83^^35^485^51
 ;;^UTILITY(U,$J,358.3,8507,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8507,1,4,0)
 ;;=4^V10.83
 ;;^UTILITY(U,$J,358.3,8507,1,5,0)
 ;;=5^Hx of Skin Cancer (Non-Melanoma)
 ;;^UTILITY(U,$J,358.3,8507,2)
 ;;=^295241
 ;;^UTILITY(U,$J,358.3,8508,0)
 ;;=V15.1^^35^485^53
 ;;^UTILITY(U,$J,358.3,8508,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8508,1,4,0)
 ;;=4^V15.1
 ;;^UTILITY(U,$J,358.3,8508,1,5,0)
 ;;=5^Hx of Surgery To Heart And Great Vessels
 ;;^UTILITY(U,$J,358.3,8508,2)
 ;;=^295283
 ;;^UTILITY(U,$J,358.3,8509,0)
 ;;=V15.82^^35^485^57
 ;;^UTILITY(U,$J,358.3,8509,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8509,1,4,0)
 ;;=4^V15.82
 ;;^UTILITY(U,$J,358.3,8509,1,5,0)
 ;;=5^Hx of Tobacco Use (not current)
 ;;^UTILITY(U,$J,358.3,8509,2)
 ;;=Hx of Tobacco Use (not current)^303405
