IBDEI28Q ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37625,1,4,0)
 ;;=4^S43.024A
 ;;^UTILITY(U,$J,358.3,37625,2)
 ;;=^5027696
 ;;^UTILITY(U,$J,358.3,37626,0)
 ;;=M19.012^^172^1888^41
 ;;^UTILITY(U,$J,358.3,37626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37626,1,3,0)
 ;;=3^Primary osteoarthritis, left shoulder
 ;;^UTILITY(U,$J,358.3,37626,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,37626,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,37627,0)
 ;;=M19.011^^172^1888^42
 ;;^UTILITY(U,$J,358.3,37627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37627,1,3,0)
 ;;=3^Primary osteoarthritis, right shoulder
 ;;^UTILITY(U,$J,358.3,37627,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,37627,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,37628,0)
 ;;=M24.412^^172^1888^43
 ;;^UTILITY(U,$J,358.3,37628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37628,1,3,0)
 ;;=3^Recurrent dislocation, left shoulder
 ;;^UTILITY(U,$J,358.3,37628,1,4,0)
 ;;=4^M24.412
 ;;^UTILITY(U,$J,358.3,37628,2)
 ;;=^5011372
 ;;^UTILITY(U,$J,358.3,37629,0)
 ;;=M24.411^^172^1888^44
 ;;^UTILITY(U,$J,358.3,37629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37629,1,3,0)
 ;;=3^Recurrent dislocation, right shoulder
 ;;^UTILITY(U,$J,358.3,37629,1,4,0)
 ;;=4^M24.411
 ;;^UTILITY(U,$J,358.3,37629,2)
 ;;=^5011371
 ;;^UTILITY(U,$J,358.3,37630,0)
 ;;=M75.122^^172^1888^45
 ;;^UTILITY(U,$J,358.3,37630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37630,1,3,0)
 ;;=3^Rotatr-cuff tear/ruptr of left shoulder, not trauma, complete
 ;;^UTILITY(U,$J,358.3,37630,1,4,0)
 ;;=4^M75.122
 ;;^UTILITY(U,$J,358.3,37630,2)
 ;;=^5013249
 ;;^UTILITY(U,$J,358.3,37631,0)
 ;;=M75.121^^172^1888^46
 ;;^UTILITY(U,$J,358.3,37631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37631,1,3,0)
 ;;=3^Rotatr-cuff tear/ruptr of r shoulder, not trauma, complete
 ;;^UTILITY(U,$J,358.3,37631,1,4,0)
 ;;=4^M75.121
 ;;^UTILITY(U,$J,358.3,37631,2)
 ;;=^5013248
 ;;^UTILITY(U,$J,358.3,37632,0)
 ;;=M12.512^^172^1888^49
 ;;^UTILITY(U,$J,358.3,37632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37632,1,3,0)
 ;;=3^Traumatic arthropathy, left shoulder
 ;;^UTILITY(U,$J,358.3,37632,1,4,0)
 ;;=4^M12.512
 ;;^UTILITY(U,$J,358.3,37632,2)
 ;;=^5010620
 ;;^UTILITY(U,$J,358.3,37633,0)
 ;;=M12.511^^172^1888^50
 ;;^UTILITY(U,$J,358.3,37633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37633,1,3,0)
 ;;=3^Traumatic arthropathy, right shoulder
 ;;^UTILITY(U,$J,358.3,37633,1,4,0)
 ;;=4^M12.511
 ;;^UTILITY(U,$J,358.3,37633,2)
 ;;=^5010619
 ;;^UTILITY(U,$J,358.3,37634,0)
 ;;=S43.102A^^172^1888^17
 ;;^UTILITY(U,$J,358.3,37634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37634,1,3,0)
 ;;=3^Dislocation of left acromioclavicular joint, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,37634,1,4,0)
 ;;=4^S43.102A
 ;;^UTILITY(U,$J,358.3,37634,2)
 ;;=^5027732
 ;;^UTILITY(U,$J,358.3,37635,0)
 ;;=S43.005A^^172^1888^19
 ;;^UTILITY(U,$J,358.3,37635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37635,1,3,0)
 ;;=3^Dislocation of left shoulder joint, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,37635,1,4,0)
 ;;=4^S43.005A
 ;;^UTILITY(U,$J,358.3,37635,2)
 ;;=^5027666
 ;;^UTILITY(U,$J,358.3,37636,0)
 ;;=S43.101A^^172^1888^21
 ;;^UTILITY(U,$J,358.3,37636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37636,1,3,0)
 ;;=3^Dislocation of right acromioclavicular joint, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,37636,1,4,0)
 ;;=4^S43.101A
 ;;^UTILITY(U,$J,358.3,37636,2)
 ;;=^5027729
 ;;^UTILITY(U,$J,358.3,37637,0)
 ;;=S43.004A^^172^1888^23
 ;;^UTILITY(U,$J,358.3,37637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37637,1,3,0)
 ;;=3^Dislocation of right shoulder joint, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,37637,1,4,0)
 ;;=4^S43.004A
