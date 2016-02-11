IBDEI303 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,50303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50303,1,3,0)
 ;;=3^Multiple Cranial Nerve Palsies in Sarcoidosis
 ;;^UTILITY(U,$J,358.3,50303,1,4,0)
 ;;=4^D86.82
 ;;^UTILITY(U,$J,358.3,50303,2)
 ;;=^5002447
 ;;^UTILITY(U,$J,358.3,50304,0)
 ;;=M32.8^^219^2447^60
 ;;^UTILITY(U,$J,358.3,50304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50304,1,3,0)
 ;;=3^Systemic Lupus Erythematosus NEC
 ;;^UTILITY(U,$J,358.3,50304,1,4,0)
 ;;=4^M32.8
 ;;^UTILITY(U,$J,358.3,50304,2)
 ;;=^5011760
 ;;^UTILITY(U,$J,358.3,50305,0)
 ;;=J84.17^^219^2447^18
 ;;^UTILITY(U,$J,358.3,50305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50305,1,3,0)
 ;;=3^Interstitial Pulmonary Diseases w/ Fibrosis
 ;;^UTILITY(U,$J,358.3,50305,1,4,0)
 ;;=4^J84.17
 ;;^UTILITY(U,$J,358.3,50305,2)
 ;;=^5008301
 ;;^UTILITY(U,$J,358.3,50306,0)
 ;;=J68.8^^219^2447^25
 ;;^UTILITY(U,$J,358.3,50306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50306,1,3,0)
 ;;=3^Respiratory Condition d/t Chemicals/Gases/Fumes/Vapors
 ;;^UTILITY(U,$J,358.3,50306,1,4,0)
 ;;=4^J68.8
 ;;^UTILITY(U,$J,358.3,50306,2)
 ;;=^5008286
 ;;^UTILITY(U,$J,358.3,50307,0)
 ;;=J69.0^^219^2447^22
 ;;^UTILITY(U,$J,358.3,50307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50307,1,3,0)
 ;;=3^Pneumonitis d/t Inhalation of Food/Vomit
 ;;^UTILITY(U,$J,358.3,50307,1,4,0)
 ;;=4^J69.0
 ;;^UTILITY(U,$J,358.3,50307,2)
 ;;=^5008288
 ;;^UTILITY(U,$J,358.3,50308,0)
 ;;=J69.1^^219^2447^23
 ;;^UTILITY(U,$J,358.3,50308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50308,1,3,0)
 ;;=3^Pneumonitis d/t Inhalation of Oils/Essences
 ;;^UTILITY(U,$J,358.3,50308,1,4,0)
 ;;=4^J69.1
 ;;^UTILITY(U,$J,358.3,50308,2)
 ;;=^95664
 ;;^UTILITY(U,$J,358.3,50309,0)
 ;;=J84.115^^219^2447^24
 ;;^UTILITY(U,$J,358.3,50309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50309,1,3,0)
 ;;=3^Respiratory Bronchiolitis Interstitial Lung Disease
 ;;^UTILITY(U,$J,358.3,50309,1,4,0)
 ;;=4^J84.115
 ;;^UTILITY(U,$J,358.3,50309,2)
 ;;=^340537
 ;;^UTILITY(U,$J,358.3,50310,0)
 ;;=M05.172^^219^2447^26
 ;;^UTILITY(U,$J,358.3,50310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50310,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Ankle/Foot
 ;;^UTILITY(U,$J,358.3,50310,1,4,0)
 ;;=4^M05.172
 ;;^UTILITY(U,$J,358.3,50310,2)
 ;;=^5009882
 ;;^UTILITY(U,$J,358.3,50311,0)
 ;;=M05.122^^219^2447^27
 ;;^UTILITY(U,$J,358.3,50311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50311,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Elbow
 ;;^UTILITY(U,$J,358.3,50311,1,4,0)
 ;;=4^M05.122
 ;;^UTILITY(U,$J,358.3,50311,2)
 ;;=^5009867
 ;;^UTILITY(U,$J,358.3,50312,0)
 ;;=M05.142^^219^2447^28
 ;;^UTILITY(U,$J,358.3,50312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50312,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Hand
 ;;^UTILITY(U,$J,358.3,50312,1,4,0)
 ;;=4^M05.142
 ;;^UTILITY(U,$J,358.3,50312,2)
 ;;=^5009873
 ;;^UTILITY(U,$J,358.3,50313,0)
 ;;=M05.152^^219^2447^29
 ;;^UTILITY(U,$J,358.3,50313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50313,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Hip
 ;;^UTILITY(U,$J,358.3,50313,1,4,0)
 ;;=4^M05.152
 ;;^UTILITY(U,$J,358.3,50313,2)
 ;;=^5009876
 ;;^UTILITY(U,$J,358.3,50314,0)
 ;;=M05.162^^219^2447^30
 ;;^UTILITY(U,$J,358.3,50314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50314,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Knee
 ;;^UTILITY(U,$J,358.3,50314,1,4,0)
 ;;=4^M05.162
 ;;^UTILITY(U,$J,358.3,50314,2)
 ;;=^5009879
 ;;^UTILITY(U,$J,358.3,50315,0)
 ;;=M05.112^^219^2447^31
 ;;^UTILITY(U,$J,358.3,50315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50315,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Shldr
