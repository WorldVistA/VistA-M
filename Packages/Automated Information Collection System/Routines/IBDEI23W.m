IBDEI23W ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35725,1,4,0)
 ;;=4^M32.8
 ;;^UTILITY(U,$J,358.3,35725,2)
 ;;=^5011760
 ;;^UTILITY(U,$J,358.3,35726,0)
 ;;=J84.17^^134^1730^18
 ;;^UTILITY(U,$J,358.3,35726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35726,1,3,0)
 ;;=3^Interstitial Pulmonary Diseases w/ Fibrosis
 ;;^UTILITY(U,$J,358.3,35726,1,4,0)
 ;;=4^J84.17
 ;;^UTILITY(U,$J,358.3,35726,2)
 ;;=^5008301
 ;;^UTILITY(U,$J,358.3,35727,0)
 ;;=J68.8^^134^1730^25
 ;;^UTILITY(U,$J,358.3,35727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35727,1,3,0)
 ;;=3^Respiratory Condition d/t Chemicals/Gases/Fumes/Vapors
 ;;^UTILITY(U,$J,358.3,35727,1,4,0)
 ;;=4^J68.8
 ;;^UTILITY(U,$J,358.3,35727,2)
 ;;=^5008286
 ;;^UTILITY(U,$J,358.3,35728,0)
 ;;=J69.0^^134^1730^22
 ;;^UTILITY(U,$J,358.3,35728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35728,1,3,0)
 ;;=3^Pneumonitis d/t Inhalation of Food/Vomit
 ;;^UTILITY(U,$J,358.3,35728,1,4,0)
 ;;=4^J69.0
 ;;^UTILITY(U,$J,358.3,35728,2)
 ;;=^5008288
 ;;^UTILITY(U,$J,358.3,35729,0)
 ;;=J69.1^^134^1730^23
 ;;^UTILITY(U,$J,358.3,35729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35729,1,3,0)
 ;;=3^Pneumonitis d/t Inhalation of Oils/Essences
 ;;^UTILITY(U,$J,358.3,35729,1,4,0)
 ;;=4^J69.1
 ;;^UTILITY(U,$J,358.3,35729,2)
 ;;=^95664
 ;;^UTILITY(U,$J,358.3,35730,0)
 ;;=J84.115^^134^1730^24
 ;;^UTILITY(U,$J,358.3,35730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35730,1,3,0)
 ;;=3^Respiratory Bronchiolitis Interstitial Lung Disease
 ;;^UTILITY(U,$J,358.3,35730,1,4,0)
 ;;=4^J84.115
 ;;^UTILITY(U,$J,358.3,35730,2)
 ;;=^340537
 ;;^UTILITY(U,$J,358.3,35731,0)
 ;;=M05.172^^134^1730^26
 ;;^UTILITY(U,$J,358.3,35731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35731,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Ankle/Foot
 ;;^UTILITY(U,$J,358.3,35731,1,4,0)
 ;;=4^M05.172
 ;;^UTILITY(U,$J,358.3,35731,2)
 ;;=^5009882
 ;;^UTILITY(U,$J,358.3,35732,0)
 ;;=M05.122^^134^1730^27
 ;;^UTILITY(U,$J,358.3,35732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35732,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Elbow
 ;;^UTILITY(U,$J,358.3,35732,1,4,0)
 ;;=4^M05.122
 ;;^UTILITY(U,$J,358.3,35732,2)
 ;;=^5009867
 ;;^UTILITY(U,$J,358.3,35733,0)
 ;;=M05.142^^134^1730^28
 ;;^UTILITY(U,$J,358.3,35733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35733,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Hand
 ;;^UTILITY(U,$J,358.3,35733,1,4,0)
 ;;=4^M05.142
 ;;^UTILITY(U,$J,358.3,35733,2)
 ;;=^5009873
 ;;^UTILITY(U,$J,358.3,35734,0)
 ;;=M05.152^^134^1730^29
 ;;^UTILITY(U,$J,358.3,35734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35734,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Hip
 ;;^UTILITY(U,$J,358.3,35734,1,4,0)
 ;;=4^M05.152
 ;;^UTILITY(U,$J,358.3,35734,2)
 ;;=^5009876
 ;;^UTILITY(U,$J,358.3,35735,0)
 ;;=M05.162^^134^1730^30
 ;;^UTILITY(U,$J,358.3,35735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35735,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Knee
 ;;^UTILITY(U,$J,358.3,35735,1,4,0)
 ;;=4^M05.162
 ;;^UTILITY(U,$J,358.3,35735,2)
 ;;=^5009879
 ;;^UTILITY(U,$J,358.3,35736,0)
 ;;=M05.112^^134^1730^31
 ;;^UTILITY(U,$J,358.3,35736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35736,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Shldr
 ;;^UTILITY(U,$J,358.3,35736,1,4,0)
 ;;=4^M05.112
 ;;^UTILITY(U,$J,358.3,35736,2)
 ;;=^5009864
 ;;^UTILITY(U,$J,358.3,35737,0)
 ;;=M05.132^^134^1730^32
 ;;^UTILITY(U,$J,358.3,35737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35737,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Wrist
 ;;^UTILITY(U,$J,358.3,35737,1,4,0)
 ;;=4^M05.132
 ;;^UTILITY(U,$J,358.3,35737,2)
 ;;=^5009870
