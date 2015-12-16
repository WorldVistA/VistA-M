IBDEI1SR ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31693,0)
 ;;=S15.001A^^180^1962^3
 ;;^UTILITY(U,$J,358.3,31693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31693,1,3,0)
 ;;=3^Injury of right carotid artery, init encntr
 ;;^UTILITY(U,$J,358.3,31693,1,4,0)
 ;;=4^S15.001A
 ;;^UTILITY(U,$J,358.3,31693,2)
 ;;=^5022220
 ;;^UTILITY(U,$J,358.3,31694,0)
 ;;=M23.92^^180^1962^4
 ;;^UTILITY(U,$J,358.3,31694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31694,1,3,0)
 ;;=3^Internal derangement of left knee
 ;;^UTILITY(U,$J,358.3,31694,1,4,0)
 ;;=4^M23.92
 ;;^UTILITY(U,$J,358.3,31694,2)
 ;;=^5133807
 ;;^UTILITY(U,$J,358.3,31695,0)
 ;;=M23.91^^180^1962^5
 ;;^UTILITY(U,$J,358.3,31695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31695,1,3,0)
 ;;=3^Internal derangement of right knee
 ;;^UTILITY(U,$J,358.3,31695,1,4,0)
 ;;=4^M23.91
 ;;^UTILITY(U,$J,358.3,31695,2)
 ;;=^5133806
 ;;^UTILITY(U,$J,358.3,31696,0)
 ;;=M75.102^^180^1962^126
 ;;^UTILITY(U,$J,358.3,31696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31696,1,3,0)
 ;;=3^Rotatr-cuff tear/ruptr of left shoulder, not trauma
 ;;^UTILITY(U,$J,358.3,31696,1,4,0)
 ;;=4^M75.102
 ;;^UTILITY(U,$J,358.3,31696,2)
 ;;=^5013243
 ;;^UTILITY(U,$J,358.3,31697,0)
 ;;=M75.101^^180^1962^127
 ;;^UTILITY(U,$J,358.3,31697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31697,1,3,0)
 ;;=3^Rotatr-cuff tear/ruptr of right shoulder, not trauma
 ;;^UTILITY(U,$J,358.3,31697,1,4,0)
 ;;=4^M75.101
 ;;^UTILITY(U,$J,358.3,31697,2)
 ;;=^5013242
 ;;^UTILITY(U,$J,358.3,31698,0)
 ;;=R32.^^180^1962^146
 ;;^UTILITY(U,$J,358.3,31698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31698,1,3,0)
 ;;=3^Urinary incontinence,Unspec
 ;;^UTILITY(U,$J,358.3,31698,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,31698,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,31699,0)
 ;;=R53.1^^180^1962^147
 ;;^UTILITY(U,$J,358.3,31699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31699,1,3,0)
 ;;=3^Weakness
 ;;^UTILITY(U,$J,358.3,31699,1,4,0)
 ;;=4^R53.1
 ;;^UTILITY(U,$J,358.3,31699,2)
 ;;=^5019516
 ;;^UTILITY(U,$J,358.3,31700,0)
 ;;=F31.81^^180^1963^8
 ;;^UTILITY(U,$J,358.3,31700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31700,1,3,0)
 ;;=3^Bipolar II disorder
 ;;^UTILITY(U,$J,358.3,31700,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,31700,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,31701,0)
 ;;=F41.9^^180^1963^7
 ;;^UTILITY(U,$J,358.3,31701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31701,1,3,0)
 ;;=3^Anxiety disorder, unspecified
 ;;^UTILITY(U,$J,358.3,31701,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,31701,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,31702,0)
 ;;=F34.1^^180^1963^10
 ;;^UTILITY(U,$J,358.3,31702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31702,1,3,0)
 ;;=3^Dysthymic disorder
 ;;^UTILITY(U,$J,358.3,31702,1,4,0)
 ;;=4^F34.1
 ;;^UTILITY(U,$J,358.3,31702,2)
 ;;=^331913
 ;;^UTILITY(U,$J,358.3,31703,0)
 ;;=F60.4^^180^1963^11
 ;;^UTILITY(U,$J,358.3,31703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31703,1,3,0)
 ;;=3^Histrionic personality disorder
 ;;^UTILITY(U,$J,358.3,31703,1,4,0)
 ;;=4^F60.4
 ;;^UTILITY(U,$J,358.3,31703,2)
 ;;=^5003636
 ;;^UTILITY(U,$J,358.3,31704,0)
 ;;=F60.7^^180^1963^9
 ;;^UTILITY(U,$J,358.3,31704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31704,1,3,0)
 ;;=3^Dependent personality disorder
 ;;^UTILITY(U,$J,358.3,31704,1,4,0)
 ;;=4^F60.7
 ;;^UTILITY(U,$J,358.3,31704,2)
 ;;=^5003637
 ;;^UTILITY(U,$J,358.3,31705,0)
 ;;=F43.21^^180^1963^3
 ;;^UTILITY(U,$J,358.3,31705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31705,1,3,0)
 ;;=3^Adjustment disorder with depressed mood
 ;;^UTILITY(U,$J,358.3,31705,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,31705,2)
 ;;=^331948
