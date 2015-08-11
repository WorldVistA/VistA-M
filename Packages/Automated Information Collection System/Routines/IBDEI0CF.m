IBDEI0CF ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5903,1,4,0)
 ;;=4^V10.43
 ;;^UTILITY(U,$J,358.3,5903,1,5,0)
 ;;=5^Hx of Ovarian CA
 ;;^UTILITY(U,$J,358.3,5903,2)
 ;;=Hx of Ovarian CA^295221
 ;;^UTILITY(U,$J,358.3,5904,0)
 ;;=V12.71^^41^491^45
 ;;^UTILITY(U,$J,358.3,5904,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5904,1,4,0)
 ;;=4^V12.71
 ;;^UTILITY(U,$J,358.3,5904,1,5,0)
 ;;=5^Hx of Peptic Ulcer Disease
 ;;^UTILITY(U,$J,358.3,5904,2)
 ;;=^303400
 ;;^UTILITY(U,$J,358.3,5905,0)
 ;;=V10.46^^41^491^48
 ;;^UTILITY(U,$J,358.3,5905,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5905,1,4,0)
 ;;=4^V10.46
 ;;^UTILITY(U,$J,358.3,5905,1,5,0)
 ;;=5^Hx of Prostate Cancer
 ;;^UTILITY(U,$J,358.3,5905,2)
 ;;=Hx of Prostate Cancer^295224
 ;;^UTILITY(U,$J,358.3,5906,0)
 ;;=V11.0^^41^491^50
 ;;^UTILITY(U,$J,358.3,5906,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5906,1,4,0)
 ;;=4^V11.0
 ;;^UTILITY(U,$J,358.3,5906,1,5,0)
 ;;=5^Hx of Schizophrenia
 ;;^UTILITY(U,$J,358.3,5906,2)
 ;;=Hx of Schizophrenia^295249
 ;;^UTILITY(U,$J,358.3,5907,0)
 ;;=V10.83^^41^491^51
 ;;^UTILITY(U,$J,358.3,5907,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5907,1,4,0)
 ;;=4^V10.83
 ;;^UTILITY(U,$J,358.3,5907,1,5,0)
 ;;=5^Hx of Skin Cancer (Non-Melanoma)
 ;;^UTILITY(U,$J,358.3,5907,2)
 ;;=^295241
 ;;^UTILITY(U,$J,358.3,5908,0)
 ;;=V15.1^^41^491^53
 ;;^UTILITY(U,$J,358.3,5908,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5908,1,4,0)
 ;;=4^V15.1
 ;;^UTILITY(U,$J,358.3,5908,1,5,0)
 ;;=5^Hx of Surgery To Heart And Great Vessels
 ;;^UTILITY(U,$J,358.3,5908,2)
 ;;=^295283
 ;;^UTILITY(U,$J,358.3,5909,0)
 ;;=V15.82^^41^491^57
 ;;^UTILITY(U,$J,358.3,5909,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5909,1,4,0)
 ;;=4^V15.82
 ;;^UTILITY(U,$J,358.3,5909,1,5,0)
 ;;=5^Hx of Tobacco Use (not current)
 ;;^UTILITY(U,$J,358.3,5909,2)
 ;;=Hx of Tobacco Use (not current)^303405
 ;;^UTILITY(U,$J,358.3,5910,0)
 ;;=V12.01^^41^491^54
 ;;^UTILITY(U,$J,358.3,5910,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5910,1,4,0)
 ;;=4^V12.01
 ;;^UTILITY(U,$J,358.3,5910,1,5,0)
 ;;=5^Hx of TB
 ;;^UTILITY(U,$J,358.3,5910,2)
 ;;=Hx of TB^303393
 ;;^UTILITY(U,$J,358.3,5911,0)
 ;;=V13.01^^41^491^36
 ;;^UTILITY(U,$J,358.3,5911,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5911,1,4,0)
 ;;=4^V13.01
 ;;^UTILITY(U,$J,358.3,5911,1,5,0)
 ;;=5^Hx of Kidney Stones
 ;;^UTILITY(U,$J,358.3,5911,2)
 ;;=Hx of Kidney Stones^303403
 ;;^UTILITY(U,$J,358.3,5912,0)
 ;;=V12.51^^41^491^59
 ;;^UTILITY(U,$J,358.3,5912,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5912,1,4,0)
 ;;=4^V12.51
 ;;^UTILITY(U,$J,358.3,5912,1,5,0)
 ;;=5^Hx of Venous Thrombosis And Embolism
 ;;^UTILITY(U,$J,358.3,5912,2)
 ;;=^303397
 ;;^UTILITY(U,$J,358.3,5913,0)
 ;;=V17.89^^41^491^18
 ;;^UTILITY(U,$J,358.3,5913,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5913,1,4,0)
 ;;=4^V17.89
 ;;^UTILITY(U,$J,358.3,5913,1,5,0)
 ;;=5^Family h/o Musculosk Disease
 ;;^UTILITY(U,$J,358.3,5913,2)
 ;;=^332861
 ;;^UTILITY(U,$J,358.3,5914,0)
 ;;=V12.54^^41^491^56
 ;;^UTILITY(U,$J,358.3,5914,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5914,1,4,0)
 ;;=4^V12.54
 ;;^UTILITY(U,$J,358.3,5914,1,5,0)
 ;;=5^Hx of TIA
 ;;^UTILITY(U,$J,358.3,5914,2)
 ;;=^335309
 ;;^UTILITY(U,$J,358.3,5915,0)
 ;;=V12.54^^41^491^52
 ;;^UTILITY(U,$J,358.3,5915,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5915,1,4,0)
 ;;=4^V12.54
 ;;^UTILITY(U,$J,358.3,5915,1,5,0)
 ;;=5^Hx of Stroke w/o Residual
 ;;^UTILITY(U,$J,358.3,5915,2)
 ;;=^335309
 ;;^UTILITY(U,$J,358.3,5916,0)
 ;;=V15.88^^41^491^33
 ;;^UTILITY(U,$J,358.3,5916,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5916,1,4,0)
 ;;=4^V15.88
 ;;^UTILITY(U,$J,358.3,5916,1,5,0)
 ;;=5^Hx of Fall(s)
