IBDEI1XT ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34390,1,3,0)
 ;;=3^Idiopathic Non-Specific Interstitial Pneumonitis
 ;;^UTILITY(U,$J,358.3,34390,1,4,0)
 ;;=4^J84.113
 ;;^UTILITY(U,$J,358.3,34390,2)
 ;;=^340535
 ;;^UTILITY(U,$J,358.3,34391,0)
 ;;=J84.112^^192^1998^16
 ;;^UTILITY(U,$J,358.3,34391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34391,1,3,0)
 ;;=3^Idiopathic Pulmonary Fibrosis
 ;;^UTILITY(U,$J,358.3,34391,1,4,0)
 ;;=4^J84.112
 ;;^UTILITY(U,$J,358.3,34391,2)
 ;;=^340534
 ;;^UTILITY(U,$J,358.3,34392,0)
 ;;=J84.111^^192^1998^13
 ;;^UTILITY(U,$J,358.3,34392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34392,1,3,0)
 ;;=3^Idiopathic Interstitial Pneumonia NOS
 ;;^UTILITY(U,$J,358.3,34392,1,4,0)
 ;;=4^J84.111
 ;;^UTILITY(U,$J,358.3,34392,2)
 ;;=^340610
 ;;^UTILITY(U,$J,358.3,34393,0)
 ;;=J84.9^^192^1998^17
 ;;^UTILITY(U,$J,358.3,34393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34393,1,3,0)
 ;;=3^Interstitial Pulmonary Disease,Unspec
 ;;^UTILITY(U,$J,358.3,34393,1,4,0)
 ;;=4^J84.9
 ;;^UTILITY(U,$J,358.3,34393,2)
 ;;=^5008304
 ;;^UTILITY(U,$J,358.3,34394,0)
 ;;=M32.13^^192^1998^19
 ;;^UTILITY(U,$J,358.3,34394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34394,1,3,0)
 ;;=3^Lung Involvement in Systemic Lupus Erythematosus
 ;;^UTILITY(U,$J,358.3,34394,1,4,0)
 ;;=4^M32.13
 ;;^UTILITY(U,$J,358.3,34394,2)
 ;;=^5011756
 ;;^UTILITY(U,$J,358.3,34395,0)
 ;;=J84.2^^192^1998^20
 ;;^UTILITY(U,$J,358.3,34395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34395,1,3,0)
 ;;=3^Lymphoid Interstitial Pneumonia
 ;;^UTILITY(U,$J,358.3,34395,1,4,0)
 ;;=4^J84.2
 ;;^UTILITY(U,$J,358.3,34395,2)
 ;;=^5008302
 ;;^UTILITY(U,$J,358.3,34396,0)
 ;;=D86.82^^192^1998^21
 ;;^UTILITY(U,$J,358.3,34396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34396,1,3,0)
 ;;=3^Multiple Cranial Nerve Palsies in Sarcoidosis
 ;;^UTILITY(U,$J,358.3,34396,1,4,0)
 ;;=4^D86.82
 ;;^UTILITY(U,$J,358.3,34396,2)
 ;;=^5002447
 ;;^UTILITY(U,$J,358.3,34397,0)
 ;;=M32.8^^192^1998^60
 ;;^UTILITY(U,$J,358.3,34397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34397,1,3,0)
 ;;=3^Systemic Lupus Erythematosus NEC
 ;;^UTILITY(U,$J,358.3,34397,1,4,0)
 ;;=4^M32.8
 ;;^UTILITY(U,$J,358.3,34397,2)
 ;;=^5011760
 ;;^UTILITY(U,$J,358.3,34398,0)
 ;;=J84.17^^192^1998^18
 ;;^UTILITY(U,$J,358.3,34398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34398,1,3,0)
 ;;=3^Interstitial Pulmonary Diseases w/ Fibrosis
 ;;^UTILITY(U,$J,358.3,34398,1,4,0)
 ;;=4^J84.17
 ;;^UTILITY(U,$J,358.3,34398,2)
 ;;=^5008301
 ;;^UTILITY(U,$J,358.3,34399,0)
 ;;=J68.8^^192^1998^25
 ;;^UTILITY(U,$J,358.3,34399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34399,1,3,0)
 ;;=3^Respiratory Condition d/t Chemicals/Gases/Fumes/Vapors
 ;;^UTILITY(U,$J,358.3,34399,1,4,0)
 ;;=4^J68.8
 ;;^UTILITY(U,$J,358.3,34399,2)
 ;;=^5008286
 ;;^UTILITY(U,$J,358.3,34400,0)
 ;;=J69.0^^192^1998^22
 ;;^UTILITY(U,$J,358.3,34400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34400,1,3,0)
 ;;=3^Pneumonitis d/t Inhalation of Food/Vomit
 ;;^UTILITY(U,$J,358.3,34400,1,4,0)
 ;;=4^J69.0
 ;;^UTILITY(U,$J,358.3,34400,2)
 ;;=^5008288
 ;;^UTILITY(U,$J,358.3,34401,0)
 ;;=J69.1^^192^1998^23
 ;;^UTILITY(U,$J,358.3,34401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34401,1,3,0)
 ;;=3^Pneumonitis d/t Inhalation of Oils/Essences
 ;;^UTILITY(U,$J,358.3,34401,1,4,0)
 ;;=4^J69.1
 ;;^UTILITY(U,$J,358.3,34401,2)
 ;;=^95664
 ;;^UTILITY(U,$J,358.3,34402,0)
 ;;=J84.115^^192^1998^24
 ;;^UTILITY(U,$J,358.3,34402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34402,1,3,0)
 ;;=3^Respiratory Bronchiolitis Interstitial Lung Disease
 ;;^UTILITY(U,$J,358.3,34402,1,4,0)
 ;;=4^J84.115
 ;;^UTILITY(U,$J,358.3,34402,2)
 ;;=^340537
