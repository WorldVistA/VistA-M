IBDEI1C1 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21538,0)
 ;;=D86.82^^70^921^21
 ;;^UTILITY(U,$J,358.3,21538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21538,1,3,0)
 ;;=3^Multiple Cranial Nerve Palsies in Sarcoidosis
 ;;^UTILITY(U,$J,358.3,21538,1,4,0)
 ;;=4^D86.82
 ;;^UTILITY(U,$J,358.3,21538,2)
 ;;=^5002447
 ;;^UTILITY(U,$J,358.3,21539,0)
 ;;=M32.8^^70^921^60
 ;;^UTILITY(U,$J,358.3,21539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21539,1,3,0)
 ;;=3^Systemic Lupus Erythematosus NEC
 ;;^UTILITY(U,$J,358.3,21539,1,4,0)
 ;;=4^M32.8
 ;;^UTILITY(U,$J,358.3,21539,2)
 ;;=^5011760
 ;;^UTILITY(U,$J,358.3,21540,0)
 ;;=J68.8^^70^921^25
 ;;^UTILITY(U,$J,358.3,21540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21540,1,3,0)
 ;;=3^Respiratory Condition d/t Chemicals/Gases/Fumes/Vapors
 ;;^UTILITY(U,$J,358.3,21540,1,4,0)
 ;;=4^J68.8
 ;;^UTILITY(U,$J,358.3,21540,2)
 ;;=^5008286
 ;;^UTILITY(U,$J,358.3,21541,0)
 ;;=J69.0^^70^921^22
 ;;^UTILITY(U,$J,358.3,21541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21541,1,3,0)
 ;;=3^Pneumonitis d/t Inhalation of Food/Vomit
 ;;^UTILITY(U,$J,358.3,21541,1,4,0)
 ;;=4^J69.0
 ;;^UTILITY(U,$J,358.3,21541,2)
 ;;=^5008288
 ;;^UTILITY(U,$J,358.3,21542,0)
 ;;=J69.1^^70^921^23
 ;;^UTILITY(U,$J,358.3,21542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21542,1,3,0)
 ;;=3^Pneumonitis d/t Inhalation of Oils/Essences
 ;;^UTILITY(U,$J,358.3,21542,1,4,0)
 ;;=4^J69.1
 ;;^UTILITY(U,$J,358.3,21542,2)
 ;;=^95664
 ;;^UTILITY(U,$J,358.3,21543,0)
 ;;=J84.115^^70^921^24
 ;;^UTILITY(U,$J,358.3,21543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21543,1,3,0)
 ;;=3^Respiratory Bronchiolitis Interstitial Lung Disease
 ;;^UTILITY(U,$J,358.3,21543,1,4,0)
 ;;=4^J84.115
 ;;^UTILITY(U,$J,358.3,21543,2)
 ;;=^340537
 ;;^UTILITY(U,$J,358.3,21544,0)
 ;;=M05.172^^70^921^26
 ;;^UTILITY(U,$J,358.3,21544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21544,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Ankle/Foot
 ;;^UTILITY(U,$J,358.3,21544,1,4,0)
 ;;=4^M05.172
 ;;^UTILITY(U,$J,358.3,21544,2)
 ;;=^5009882
 ;;^UTILITY(U,$J,358.3,21545,0)
 ;;=M05.122^^70^921^27
 ;;^UTILITY(U,$J,358.3,21545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21545,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Elbow
 ;;^UTILITY(U,$J,358.3,21545,1,4,0)
 ;;=4^M05.122
 ;;^UTILITY(U,$J,358.3,21545,2)
 ;;=^5009867
 ;;^UTILITY(U,$J,358.3,21546,0)
 ;;=M05.142^^70^921^28
 ;;^UTILITY(U,$J,358.3,21546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21546,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Hand
 ;;^UTILITY(U,$J,358.3,21546,1,4,0)
 ;;=4^M05.142
 ;;^UTILITY(U,$J,358.3,21546,2)
 ;;=^5009873
 ;;^UTILITY(U,$J,358.3,21547,0)
 ;;=M05.152^^70^921^29
 ;;^UTILITY(U,$J,358.3,21547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21547,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Hip
 ;;^UTILITY(U,$J,358.3,21547,1,4,0)
 ;;=4^M05.152
 ;;^UTILITY(U,$J,358.3,21547,2)
 ;;=^5009876
 ;;^UTILITY(U,$J,358.3,21548,0)
 ;;=M05.162^^70^921^30
 ;;^UTILITY(U,$J,358.3,21548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21548,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Knee
 ;;^UTILITY(U,$J,358.3,21548,1,4,0)
 ;;=4^M05.162
 ;;^UTILITY(U,$J,358.3,21548,2)
 ;;=^5009879
 ;;^UTILITY(U,$J,358.3,21549,0)
 ;;=M05.112^^70^921^31
 ;;^UTILITY(U,$J,358.3,21549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21549,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Shldr
 ;;^UTILITY(U,$J,358.3,21549,1,4,0)
 ;;=4^M05.112
