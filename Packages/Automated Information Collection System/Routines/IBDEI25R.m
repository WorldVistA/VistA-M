IBDEI25R ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36611,1,3,0)
 ;;=3^CR(E)ST Syndrome
 ;;^UTILITY(U,$J,358.3,36611,1,4,0)
 ;;=4^M34.1
 ;;^UTILITY(U,$J,358.3,36611,2)
 ;;=^5011779
 ;;^UTILITY(U,$J,358.3,36612,0)
 ;;=J84.116^^137^1768^6
 ;;^UTILITY(U,$J,358.3,36612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36612,1,3,0)
 ;;=3^Cryptogenic Organizing Pneumonia
 ;;^UTILITY(U,$J,358.3,36612,1,4,0)
 ;;=4^J84.116
 ;;^UTILITY(U,$J,358.3,36612,2)
 ;;=^340539
 ;;^UTILITY(U,$J,358.3,36613,0)
 ;;=J84.117^^137^1768^7
 ;;^UTILITY(U,$J,358.3,36613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36613,1,3,0)
 ;;=3^Desquamative Interstitial Pneumonia
 ;;^UTILITY(U,$J,358.3,36613,1,4,0)
 ;;=4^J84.117
 ;;^UTILITY(U,$J,358.3,36613,2)
 ;;=^340540
 ;;^UTILITY(U,$J,358.3,36614,0)
 ;;=M32.0^^137^1768^8
 ;;^UTILITY(U,$J,358.3,36614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36614,1,3,0)
 ;;=3^Drug-Induced Systemic Lupus Erythematosus
 ;;^UTILITY(U,$J,358.3,36614,1,4,0)
 ;;=4^M32.0
 ;;^UTILITY(U,$J,358.3,36614,2)
 ;;=^5011752
 ;;^UTILITY(U,$J,358.3,36615,0)
 ;;=M32.11^^137^1768^9
 ;;^UTILITY(U,$J,358.3,36615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36615,1,3,0)
 ;;=3^Endocarditis in Systemic Lupus Erythematosus
 ;;^UTILITY(U,$J,358.3,36615,1,4,0)
 ;;=4^M32.11
 ;;^UTILITY(U,$J,358.3,36615,2)
 ;;=^5011754
 ;;^UTILITY(U,$J,358.3,36616,0)
 ;;=J67.0^^137^1768^10
 ;;^UTILITY(U,$J,358.3,36616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36616,1,3,0)
 ;;=3^Farmer's Lung
 ;;^UTILITY(U,$J,358.3,36616,1,4,0)
 ;;=4^J67.0
 ;;^UTILITY(U,$J,358.3,36616,2)
 ;;=^44962
 ;;^UTILITY(U,$J,358.3,36617,0)
 ;;=M32.14^^137^1768^11
 ;;^UTILITY(U,$J,358.3,36617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36617,1,3,0)
 ;;=3^Glomerular Disease in Systemic Lupus Erythematosus
 ;;^UTILITY(U,$J,358.3,36617,1,4,0)
 ;;=4^M32.14
 ;;^UTILITY(U,$J,358.3,36617,2)
 ;;=^5011757
 ;;^UTILITY(U,$J,358.3,36618,0)
 ;;=J67.9^^137^1768^12
 ;;^UTILITY(U,$J,358.3,36618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36618,1,3,0)
 ;;=3^Hypersensitivity Pneumonitis d/t Unspec Organic Dust
 ;;^UTILITY(U,$J,358.3,36618,1,4,0)
 ;;=4^J67.9
 ;;^UTILITY(U,$J,358.3,36618,2)
 ;;=^5008280
 ;;^UTILITY(U,$J,358.3,36619,0)
 ;;=J84.17^^137^1768^14
 ;;^UTILITY(U,$J,358.3,36619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36619,1,3,0)
 ;;=3^Idiopathic Interstitial Pneumonia in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,36619,1,4,0)
 ;;=4^J84.17
 ;;^UTILITY(U,$J,358.3,36619,2)
 ;;=^5008301
 ;;^UTILITY(U,$J,358.3,36620,0)
 ;;=J84.113^^137^1768^15
 ;;^UTILITY(U,$J,358.3,36620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36620,1,3,0)
 ;;=3^Idiopathic Non-Specific Interstitial Pneumonitis
 ;;^UTILITY(U,$J,358.3,36620,1,4,0)
 ;;=4^J84.113
 ;;^UTILITY(U,$J,358.3,36620,2)
 ;;=^340535
 ;;^UTILITY(U,$J,358.3,36621,0)
 ;;=J84.112^^137^1768^16
 ;;^UTILITY(U,$J,358.3,36621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36621,1,3,0)
 ;;=3^Idiopathic Pulmonary Fibrosis
 ;;^UTILITY(U,$J,358.3,36621,1,4,0)
 ;;=4^J84.112
 ;;^UTILITY(U,$J,358.3,36621,2)
 ;;=^340534
 ;;^UTILITY(U,$J,358.3,36622,0)
 ;;=J84.111^^137^1768^13
 ;;^UTILITY(U,$J,358.3,36622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36622,1,3,0)
 ;;=3^Idiopathic Interstitial Pneumonia NOS
 ;;^UTILITY(U,$J,358.3,36622,1,4,0)
 ;;=4^J84.111
 ;;^UTILITY(U,$J,358.3,36622,2)
 ;;=^340610
 ;;^UTILITY(U,$J,358.3,36623,0)
 ;;=J84.9^^137^1768^17
 ;;^UTILITY(U,$J,358.3,36623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36623,1,3,0)
 ;;=3^Interstitial Pulmonary Disease,Unspec
 ;;^UTILITY(U,$J,358.3,36623,1,4,0)
 ;;=4^J84.9
