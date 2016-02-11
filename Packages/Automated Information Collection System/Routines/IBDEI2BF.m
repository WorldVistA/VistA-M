IBDEI2BF ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38885,1,3,0)
 ;;=3^Strain of unsp musc/fasc/tend at forarm lv, right arm, init
 ;;^UTILITY(U,$J,358.3,38885,1,4,0)
 ;;=4^S56.911A
 ;;^UTILITY(U,$J,358.3,38885,2)
 ;;=^5135513
 ;;^UTILITY(U,$J,358.3,38886,0)
 ;;=M77.01^^180^1988^29
 ;;^UTILITY(U,$J,358.3,38886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38886,1,3,0)
 ;;=3^Medial epicondylitis, right elbow
 ;;^UTILITY(U,$J,358.3,38886,1,4,0)
 ;;=4^M77.01
 ;;^UTILITY(U,$J,358.3,38886,2)
 ;;=^5013301
 ;;^UTILITY(U,$J,358.3,38887,0)
 ;;=M75.112^^180^1988^22
 ;;^UTILITY(U,$J,358.3,38887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38887,1,3,0)
 ;;=3^Incomplete rotatr-cuff tear/ruptr of l shoulder, not trauma
 ;;^UTILITY(U,$J,358.3,38887,1,4,0)
 ;;=4^M75.112
 ;;^UTILITY(U,$J,358.3,38887,2)
 ;;=^5013246
 ;;^UTILITY(U,$J,358.3,38888,0)
 ;;=M75.111^^180^1988^23
 ;;^UTILITY(U,$J,358.3,38888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38888,1,3,0)
 ;;=3^Incomplete rotatr-cuff tear/ruptr of r shoulder, not trauma
 ;;^UTILITY(U,$J,358.3,38888,1,4,0)
 ;;=4^M75.111
 ;;^UTILITY(U,$J,358.3,38888,2)
 ;;=^5013245
 ;;^UTILITY(U,$J,358.3,38889,0)
 ;;=M23.8X2^^180^1988^24
 ;;^UTILITY(U,$J,358.3,38889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38889,1,3,0)
 ;;=3^Internal Derangement,Left Knee NEC
 ;;^UTILITY(U,$J,358.3,38889,1,4,0)
 ;;=4^M23.8X2
 ;;^UTILITY(U,$J,358.3,38889,2)
 ;;=^5011274
 ;;^UTILITY(U,$J,358.3,38890,0)
 ;;=M23.8X1^^180^1988^25
 ;;^UTILITY(U,$J,358.3,38890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38890,1,3,0)
 ;;=3^Internal Derangement,Right Knee NEC
 ;;^UTILITY(U,$J,358.3,38890,1,4,0)
 ;;=4^M23.8X1
 ;;^UTILITY(U,$J,358.3,38890,2)
 ;;=^5011273
 ;;^UTILITY(U,$J,358.3,38891,0)
 ;;=M62.838^^180^1988^30
 ;;^UTILITY(U,$J,358.3,38891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38891,1,3,0)
 ;;=3^Muscle spasm NEC
 ;;^UTILITY(U,$J,358.3,38891,1,4,0)
 ;;=4^M62.838
 ;;^UTILITY(U,$J,358.3,38891,2)
 ;;=^5012682
 ;;^UTILITY(U,$J,358.3,38892,0)
 ;;=M76.52^^180^1988^43
 ;;^UTILITY(U,$J,358.3,38892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38892,1,3,0)
 ;;=3^Patellar tendinitis, left knee
 ;;^UTILITY(U,$J,358.3,38892,1,4,0)
 ;;=4^M76.52
 ;;^UTILITY(U,$J,358.3,38892,2)
 ;;=^5013283
 ;;^UTILITY(U,$J,358.3,38893,0)
 ;;=M76.51^^180^1988^44
 ;;^UTILITY(U,$J,358.3,38893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38893,1,3,0)
 ;;=3^Patellar tendinitis, right knee
 ;;^UTILITY(U,$J,358.3,38893,1,4,0)
 ;;=4^M76.51
 ;;^UTILITY(U,$J,358.3,38893,2)
 ;;=^5013282
 ;;^UTILITY(U,$J,358.3,38894,0)
 ;;=M65.4^^180^1988^45
 ;;^UTILITY(U,$J,358.3,38894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38894,1,3,0)
 ;;=3^Radial styloid tenosynovitis [de Quervain]
 ;;^UTILITY(U,$J,358.3,38894,1,4,0)
 ;;=4^M65.4
 ;;^UTILITY(U,$J,358.3,38894,2)
 ;;=^5012792
 ;;^UTILITY(U,$J,358.3,38895,0)
 ;;=M75.102^^180^1988^68
 ;;^UTILITY(U,$J,358.3,38895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38895,1,3,0)
 ;;=3^Unsp rotatr-cuff tear/ruptr of left shoulder, not trauma
 ;;^UTILITY(U,$J,358.3,38895,1,4,0)
 ;;=4^M75.102
 ;;^UTILITY(U,$J,358.3,38895,2)
 ;;=^5013243
 ;;^UTILITY(U,$J,358.3,38896,0)
 ;;=M75.101^^180^1988^69
 ;;^UTILITY(U,$J,358.3,38896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38896,1,3,0)
 ;;=3^Unsp rotatr-cuff tear/ruptr of right shoulder, not trauma
 ;;^UTILITY(U,$J,358.3,38896,1,4,0)
 ;;=4^M75.101
 ;;^UTILITY(U,$J,358.3,38896,2)
 ;;=^5013242
 ;;^UTILITY(U,$J,358.3,38897,0)
 ;;=M67.02^^180^1988^46
 ;;^UTILITY(U,$J,358.3,38897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38897,1,3,0)
 ;;=3^Short Achilles tendon (acquired), left ankle
