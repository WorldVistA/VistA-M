IBDEI25S ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36623,2)
 ;;=^5008304
 ;;^UTILITY(U,$J,358.3,36624,0)
 ;;=M32.13^^137^1768^19
 ;;^UTILITY(U,$J,358.3,36624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36624,1,3,0)
 ;;=3^Lung Involvement in Systemic Lupus Erythematosus
 ;;^UTILITY(U,$J,358.3,36624,1,4,0)
 ;;=4^M32.13
 ;;^UTILITY(U,$J,358.3,36624,2)
 ;;=^5011756
 ;;^UTILITY(U,$J,358.3,36625,0)
 ;;=J84.2^^137^1768^20
 ;;^UTILITY(U,$J,358.3,36625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36625,1,3,0)
 ;;=3^Lymphoid Interstitial Pneumonia
 ;;^UTILITY(U,$J,358.3,36625,1,4,0)
 ;;=4^J84.2
 ;;^UTILITY(U,$J,358.3,36625,2)
 ;;=^5008302
 ;;^UTILITY(U,$J,358.3,36626,0)
 ;;=D86.82^^137^1768^21
 ;;^UTILITY(U,$J,358.3,36626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36626,1,3,0)
 ;;=3^Multiple Cranial Nerve Palsies in Sarcoidosis
 ;;^UTILITY(U,$J,358.3,36626,1,4,0)
 ;;=4^D86.82
 ;;^UTILITY(U,$J,358.3,36626,2)
 ;;=^5002447
 ;;^UTILITY(U,$J,358.3,36627,0)
 ;;=M32.8^^137^1768^60
 ;;^UTILITY(U,$J,358.3,36627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36627,1,3,0)
 ;;=3^Systemic Lupus Erythematosus NEC
 ;;^UTILITY(U,$J,358.3,36627,1,4,0)
 ;;=4^M32.8
 ;;^UTILITY(U,$J,358.3,36627,2)
 ;;=^5011760
 ;;^UTILITY(U,$J,358.3,36628,0)
 ;;=J84.17^^137^1768^18
 ;;^UTILITY(U,$J,358.3,36628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36628,1,3,0)
 ;;=3^Interstitial Pulmonary Diseases w/ Fibrosis
 ;;^UTILITY(U,$J,358.3,36628,1,4,0)
 ;;=4^J84.17
 ;;^UTILITY(U,$J,358.3,36628,2)
 ;;=^5008301
 ;;^UTILITY(U,$J,358.3,36629,0)
 ;;=J68.8^^137^1768^25
 ;;^UTILITY(U,$J,358.3,36629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36629,1,3,0)
 ;;=3^Respiratory Condition d/t Chemicals/Gases/Fumes/Vapors
 ;;^UTILITY(U,$J,358.3,36629,1,4,0)
 ;;=4^J68.8
 ;;^UTILITY(U,$J,358.3,36629,2)
 ;;=^5008286
 ;;^UTILITY(U,$J,358.3,36630,0)
 ;;=J69.0^^137^1768^22
 ;;^UTILITY(U,$J,358.3,36630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36630,1,3,0)
 ;;=3^Pneumonitis d/t Inhalation of Food/Vomit
 ;;^UTILITY(U,$J,358.3,36630,1,4,0)
 ;;=4^J69.0
 ;;^UTILITY(U,$J,358.3,36630,2)
 ;;=^5008288
 ;;^UTILITY(U,$J,358.3,36631,0)
 ;;=J69.1^^137^1768^23
 ;;^UTILITY(U,$J,358.3,36631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36631,1,3,0)
 ;;=3^Pneumonitis d/t Inhalation of Oils/Essences
 ;;^UTILITY(U,$J,358.3,36631,1,4,0)
 ;;=4^J69.1
 ;;^UTILITY(U,$J,358.3,36631,2)
 ;;=^95664
 ;;^UTILITY(U,$J,358.3,36632,0)
 ;;=J84.115^^137^1768^24
 ;;^UTILITY(U,$J,358.3,36632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36632,1,3,0)
 ;;=3^Respiratory Bronchiolitis Interstitial Lung Disease
 ;;^UTILITY(U,$J,358.3,36632,1,4,0)
 ;;=4^J84.115
 ;;^UTILITY(U,$J,358.3,36632,2)
 ;;=^340537
 ;;^UTILITY(U,$J,358.3,36633,0)
 ;;=M05.172^^137^1768^26
 ;;^UTILITY(U,$J,358.3,36633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36633,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Ankle/Foot
 ;;^UTILITY(U,$J,358.3,36633,1,4,0)
 ;;=4^M05.172
 ;;^UTILITY(U,$J,358.3,36633,2)
 ;;=^5009882
 ;;^UTILITY(U,$J,358.3,36634,0)
 ;;=M05.122^^137^1768^27
 ;;^UTILITY(U,$J,358.3,36634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36634,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Elbow
 ;;^UTILITY(U,$J,358.3,36634,1,4,0)
 ;;=4^M05.122
 ;;^UTILITY(U,$J,358.3,36634,2)
 ;;=^5009867
 ;;^UTILITY(U,$J,358.3,36635,0)
 ;;=M05.142^^137^1768^28
 ;;^UTILITY(U,$J,358.3,36635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36635,1,3,0)
 ;;=3^Rheu Lung Disease w/ Rheu Arth of Left Hand
 ;;^UTILITY(U,$J,358.3,36635,1,4,0)
 ;;=4^M05.142
 ;;^UTILITY(U,$J,358.3,36635,2)
 ;;=^5009873
 ;;^UTILITY(U,$J,358.3,36636,0)
 ;;=M05.152^^137^1768^29
 ;;^UTILITY(U,$J,358.3,36636,1,0)
 ;;=^358.31IA^4^2
