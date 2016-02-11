IBDEI2S3 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,46642,1,3,0)
 ;;=3^Pneumonitis d/t Inhalation of Food/Vomit
 ;;^UTILITY(U,$J,358.3,46642,1,4,0)
 ;;=4^J69.0
 ;;^UTILITY(U,$J,358.3,46642,2)
 ;;=^5008288
 ;;^UTILITY(U,$J,358.3,46643,0)
 ;;=J69.1^^206^2305^23
 ;;^UTILITY(U,$J,358.3,46643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46643,1,3,0)
 ;;=3^Pneumonitis d/t Inhalation of Oils/Essences
 ;;^UTILITY(U,$J,358.3,46643,1,4,0)
 ;;=4^J69.1
 ;;^UTILITY(U,$J,358.3,46643,2)
 ;;=^95664
 ;;^UTILITY(U,$J,358.3,46644,0)
 ;;=J84.115^^206^2305^24
 ;;^UTILITY(U,$J,358.3,46644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46644,1,3,0)
 ;;=3^Respiratory Bronchiolitis Interstitial Lung Disease
 ;;^UTILITY(U,$J,358.3,46644,1,4,0)
 ;;=4^J84.115
 ;;^UTILITY(U,$J,358.3,46644,2)
 ;;=^340537
 ;;^UTILITY(U,$J,358.3,46645,0)
 ;;=M05.172^^206^2305^26
 ;;^UTILITY(U,$J,358.3,46645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46645,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Ankle/Foot
 ;;^UTILITY(U,$J,358.3,46645,1,4,0)
 ;;=4^M05.172
 ;;^UTILITY(U,$J,358.3,46645,2)
 ;;=^5009882
 ;;^UTILITY(U,$J,358.3,46646,0)
 ;;=M05.122^^206^2305^27
 ;;^UTILITY(U,$J,358.3,46646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46646,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Elbow
 ;;^UTILITY(U,$J,358.3,46646,1,4,0)
 ;;=4^M05.122
 ;;^UTILITY(U,$J,358.3,46646,2)
 ;;=^5009867
 ;;^UTILITY(U,$J,358.3,46647,0)
 ;;=M05.142^^206^2305^28
 ;;^UTILITY(U,$J,358.3,46647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46647,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Hand
 ;;^UTILITY(U,$J,358.3,46647,1,4,0)
 ;;=4^M05.142
 ;;^UTILITY(U,$J,358.3,46647,2)
 ;;=^5009873
 ;;^UTILITY(U,$J,358.3,46648,0)
 ;;=M05.152^^206^2305^29
 ;;^UTILITY(U,$J,358.3,46648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46648,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Hip
 ;;^UTILITY(U,$J,358.3,46648,1,4,0)
 ;;=4^M05.152
 ;;^UTILITY(U,$J,358.3,46648,2)
 ;;=^5009876
 ;;^UTILITY(U,$J,358.3,46649,0)
 ;;=M05.162^^206^2305^30
 ;;^UTILITY(U,$J,358.3,46649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46649,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Knee
 ;;^UTILITY(U,$J,358.3,46649,1,4,0)
 ;;=4^M05.162
 ;;^UTILITY(U,$J,358.3,46649,2)
 ;;=^5009879
 ;;^UTILITY(U,$J,358.3,46650,0)
 ;;=M05.112^^206^2305^31
 ;;^UTILITY(U,$J,358.3,46650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46650,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Shldr
 ;;^UTILITY(U,$J,358.3,46650,1,4,0)
 ;;=4^M05.112
 ;;^UTILITY(U,$J,358.3,46650,2)
 ;;=^5009864
 ;;^UTILITY(U,$J,358.3,46651,0)
 ;;=M05.132^^206^2305^32
 ;;^UTILITY(U,$J,358.3,46651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46651,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Wrist
 ;;^UTILITY(U,$J,358.3,46651,1,4,0)
 ;;=4^M05.132
 ;;^UTILITY(U,$J,358.3,46651,2)
 ;;=^5009870
 ;;^UTILITY(U,$J,358.3,46652,0)
 ;;=M05.19^^206^2305^33
 ;;^UTILITY(U,$J,358.3,46652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46652,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Mult Sites
 ;;^UTILITY(U,$J,358.3,46652,1,4,0)
 ;;=4^M05.19
 ;;^UTILITY(U,$J,358.3,46652,2)
 ;;=^5009884
 ;;^UTILITY(U,$J,358.3,46653,0)
 ;;=M05.171^^206^2305^34
 ;;^UTILITY(U,$J,358.3,46653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46653,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Right Ankle/Foot
 ;;^UTILITY(U,$J,358.3,46653,1,4,0)
 ;;=4^M05.171
 ;;^UTILITY(U,$J,358.3,46653,2)
 ;;=^5009881
 ;;^UTILITY(U,$J,358.3,46654,0)
 ;;=M05.121^^206^2305^35
 ;;^UTILITY(U,$J,358.3,46654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46654,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Right Elbow
