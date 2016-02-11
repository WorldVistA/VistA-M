IBDEI28P ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37613,1,3,0)
 ;;=3^Complete rotatr-cuff tear/ruptr of r shoulder, not trauma
 ;;^UTILITY(U,$J,358.3,37613,1,4,0)
 ;;=4^M75.121
 ;;^UTILITY(U,$J,358.3,37613,2)
 ;;=^5013248
 ;;^UTILITY(U,$J,358.3,37614,0)
 ;;=S40.012A^^172^1888^13
 ;;^UTILITY(U,$J,358.3,37614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37614,1,3,0)
 ;;=3^Contusion of left shoulder, initial encounter
 ;;^UTILITY(U,$J,358.3,37614,1,4,0)
 ;;=4^S40.012A
 ;;^UTILITY(U,$J,358.3,37614,2)
 ;;=^5026156
 ;;^UTILITY(U,$J,358.3,37615,0)
 ;;=S40.011A^^172^1888^15
 ;;^UTILITY(U,$J,358.3,37615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37615,1,3,0)
 ;;=3^Contusion of right shoulder, initial encounter
 ;;^UTILITY(U,$J,358.3,37615,1,4,0)
 ;;=4^S40.011A
 ;;^UTILITY(U,$J,358.3,37615,2)
 ;;=^5026153
 ;;^UTILITY(U,$J,358.3,37616,0)
 ;;=S42.002A^^172^1888^25
 ;;^UTILITY(U,$J,358.3,37616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37616,1,3,0)
 ;;=3^Fracture of unsp part of left clavicle, init for clos fx
 ;;^UTILITY(U,$J,358.3,37616,1,4,0)
 ;;=4^S42.002A
 ;;^UTILITY(U,$J,358.3,37616,2)
 ;;=^5026376
 ;;^UTILITY(U,$J,358.3,37617,0)
 ;;=S42.001A^^172^1888^26
 ;;^UTILITY(U,$J,358.3,37617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37617,1,3,0)
 ;;=3^Fracture of unsp part of right clavicle, init for clos fx
 ;;^UTILITY(U,$J,358.3,37617,1,4,0)
 ;;=4^S42.001A
 ;;^UTILITY(U,$J,358.3,37617,2)
 ;;=^5026369
 ;;^UTILITY(U,$J,358.3,37618,0)
 ;;=M75.42^^172^1888^29
 ;;^UTILITY(U,$J,358.3,37618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37618,1,3,0)
 ;;=3^Impingement syndrome of left shoulder
 ;;^UTILITY(U,$J,358.3,37618,1,4,0)
 ;;=4^M75.42
 ;;^UTILITY(U,$J,358.3,37618,2)
 ;;=^5013258
 ;;^UTILITY(U,$J,358.3,37619,0)
 ;;=M75.41^^172^1888^30
 ;;^UTILITY(U,$J,358.3,37619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37619,1,3,0)
 ;;=3^Impingement syndrome of right shoulder
 ;;^UTILITY(U,$J,358.3,37619,1,4,0)
 ;;=4^M75.41
 ;;^UTILITY(U,$J,358.3,37619,2)
 ;;=^5013257
 ;;^UTILITY(U,$J,358.3,37620,0)
 ;;=M75.112^^172^1888^31
 ;;^UTILITY(U,$J,358.3,37620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37620,1,3,0)
 ;;=3^Incomplete rotatr-cuff tear/ruptr of l shoulder, not trauma
 ;;^UTILITY(U,$J,358.3,37620,1,4,0)
 ;;=4^M75.112
 ;;^UTILITY(U,$J,358.3,37620,2)
 ;;=^5013246
 ;;^UTILITY(U,$J,358.3,37621,0)
 ;;=M75.111^^172^1888^32
 ;;^UTILITY(U,$J,358.3,37621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37621,1,3,0)
 ;;=3^Incomplete rotatr-cuff tear/ruptr of r shoulder, not trauma
 ;;^UTILITY(U,$J,358.3,37621,1,4,0)
 ;;=4^M75.111
 ;;^UTILITY(U,$J,358.3,37621,2)
 ;;=^5013245
 ;;^UTILITY(U,$J,358.3,37622,0)
 ;;=M25.512^^172^1888^33
 ;;^UTILITY(U,$J,358.3,37622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37622,1,3,0)
 ;;=3^Pain in left shoulder
 ;;^UTILITY(U,$J,358.3,37622,1,4,0)
 ;;=4^M25.512
 ;;^UTILITY(U,$J,358.3,37622,2)
 ;;=^5011603
 ;;^UTILITY(U,$J,358.3,37623,0)
 ;;=M25.511^^172^1888^34
 ;;^UTILITY(U,$J,358.3,37623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37623,1,3,0)
 ;;=3^Pain in right shoulder
 ;;^UTILITY(U,$J,358.3,37623,1,4,0)
 ;;=4^M25.511
 ;;^UTILITY(U,$J,358.3,37623,2)
 ;;=^5011602
 ;;^UTILITY(U,$J,358.3,37624,0)
 ;;=S43.025A^^172^1888^37
 ;;^UTILITY(U,$J,358.3,37624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37624,1,3,0)
 ;;=3^Posterior dislocation of left humerus, initial encounter
 ;;^UTILITY(U,$J,358.3,37624,1,4,0)
 ;;=4^S43.025A
 ;;^UTILITY(U,$J,358.3,37624,2)
 ;;=^5027699
 ;;^UTILITY(U,$J,358.3,37625,0)
 ;;=S43.024A^^172^1888^39
 ;;^UTILITY(U,$J,358.3,37625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37625,1,3,0)
 ;;=3^Posterior dislocation of right humerus, initial encounter
