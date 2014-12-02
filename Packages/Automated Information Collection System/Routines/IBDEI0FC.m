IBDEI0FC ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7416,2)
 ;;=Hx of Myeloid Leukemia^295233
 ;;^UTILITY(U,$J,358.3,7417,0)
 ;;=V10.63^^55^580^41
 ;;^UTILITY(U,$J,358.3,7417,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7417,1,4,0)
 ;;=4^V10.63
 ;;^UTILITY(U,$J,358.3,7417,1,5,0)
 ;;=5^Hx of Monocytic Leukemia
 ;;^UTILITY(U,$J,358.3,7417,2)
 ;;=Hx of Monocytic Leukemia^295234
 ;;^UTILITY(U,$J,358.3,7418,0)
 ;;=V11.2^^55^580^32
 ;;^UTILITY(U,$J,358.3,7418,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7418,1,4,0)
 ;;=4^V11.2
 ;;^UTILITY(U,$J,358.3,7418,1,5,0)
 ;;=5^Hx of Dysthymia
 ;;^UTILITY(U,$J,358.3,7418,2)
 ;;=Hx of Dysthymia^295251
 ;;^UTILITY(U,$J,358.3,7419,0)
 ;;=V15.81^^55^580^60
 ;;^UTILITY(U,$J,358.3,7419,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7419,1,4,0)
 ;;=4^V15.81
 ;;^UTILITY(U,$J,358.3,7419,1,5,0)
 ;;=5^Noncompliance With Medical Treatment
 ;;^UTILITY(U,$J,358.3,7419,2)
 ;;=^295290
 ;;^UTILITY(U,$J,358.3,7420,0)
 ;;=V10.43^^55^580^44
 ;;^UTILITY(U,$J,358.3,7420,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7420,1,4,0)
 ;;=4^V10.43
 ;;^UTILITY(U,$J,358.3,7420,1,5,0)
 ;;=5^Hx of Ovarian CA
 ;;^UTILITY(U,$J,358.3,7420,2)
 ;;=Hx of Ovarian CA^295221
 ;;^UTILITY(U,$J,358.3,7421,0)
 ;;=V12.71^^55^580^45
 ;;^UTILITY(U,$J,358.3,7421,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7421,1,4,0)
 ;;=4^V12.71
 ;;^UTILITY(U,$J,358.3,7421,1,5,0)
 ;;=5^Hx of Peptic Ulcer Disease
 ;;^UTILITY(U,$J,358.3,7421,2)
 ;;=^303400
 ;;^UTILITY(U,$J,358.3,7422,0)
 ;;=V10.46^^55^580^48
 ;;^UTILITY(U,$J,358.3,7422,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7422,1,4,0)
 ;;=4^V10.46
 ;;^UTILITY(U,$J,358.3,7422,1,5,0)
 ;;=5^Hx of Prostate Cancer
 ;;^UTILITY(U,$J,358.3,7422,2)
 ;;=Hx of Prostate Cancer^295224
 ;;^UTILITY(U,$J,358.3,7423,0)
 ;;=V11.0^^55^580^50
 ;;^UTILITY(U,$J,358.3,7423,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7423,1,4,0)
 ;;=4^V11.0
 ;;^UTILITY(U,$J,358.3,7423,1,5,0)
 ;;=5^Hx of Schizophrenia
 ;;^UTILITY(U,$J,358.3,7423,2)
 ;;=Hx of Schizophrenia^295249
 ;;^UTILITY(U,$J,358.3,7424,0)
 ;;=V10.83^^55^580^51
 ;;^UTILITY(U,$J,358.3,7424,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7424,1,4,0)
 ;;=4^V10.83
 ;;^UTILITY(U,$J,358.3,7424,1,5,0)
 ;;=5^Hx of Skin Cancer (Non-Melanoma)
 ;;^UTILITY(U,$J,358.3,7424,2)
 ;;=^295241
 ;;^UTILITY(U,$J,358.3,7425,0)
 ;;=V15.1^^55^580^53
 ;;^UTILITY(U,$J,358.3,7425,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7425,1,4,0)
 ;;=4^V15.1
 ;;^UTILITY(U,$J,358.3,7425,1,5,0)
 ;;=5^Hx of Surgery To Heart And Great Vessels
 ;;^UTILITY(U,$J,358.3,7425,2)
 ;;=^295283
 ;;^UTILITY(U,$J,358.3,7426,0)
 ;;=V15.82^^55^580^57
 ;;^UTILITY(U,$J,358.3,7426,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7426,1,4,0)
 ;;=4^V15.82
 ;;^UTILITY(U,$J,358.3,7426,1,5,0)
 ;;=5^Hx of Tobacco Use (not current)
 ;;^UTILITY(U,$J,358.3,7426,2)
 ;;=Hx of Tobacco Use (not current)^303405
 ;;^UTILITY(U,$J,358.3,7427,0)
 ;;=V12.01^^55^580^54
 ;;^UTILITY(U,$J,358.3,7427,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7427,1,4,0)
 ;;=4^V12.01
 ;;^UTILITY(U,$J,358.3,7427,1,5,0)
 ;;=5^Hx of TB
 ;;^UTILITY(U,$J,358.3,7427,2)
 ;;=Hx of TB^303393
 ;;^UTILITY(U,$J,358.3,7428,0)
 ;;=V13.01^^55^580^36
 ;;^UTILITY(U,$J,358.3,7428,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7428,1,4,0)
 ;;=4^V13.01
 ;;^UTILITY(U,$J,358.3,7428,1,5,0)
 ;;=5^Hx of Kidney Stones
 ;;^UTILITY(U,$J,358.3,7428,2)
 ;;=Hx of Kidney Stones^303403
 ;;^UTILITY(U,$J,358.3,7429,0)
 ;;=V12.51^^55^580^59
 ;;^UTILITY(U,$J,358.3,7429,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7429,1,4,0)
 ;;=4^V12.51
 ;;^UTILITY(U,$J,358.3,7429,1,5,0)
 ;;=5^Hx of Venous Thrombosis And Embolism
