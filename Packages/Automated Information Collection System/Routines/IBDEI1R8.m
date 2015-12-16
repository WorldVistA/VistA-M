IBDEI1R8 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31008,1,3,0)
 ;;=3^Bursitis of right shoulder
 ;;^UTILITY(U,$J,358.3,31008,1,4,0)
 ;;=4^M75.51
 ;;^UTILITY(U,$J,358.3,31008,2)
 ;;=^5133690
 ;;^UTILITY(U,$J,358.3,31009,0)
 ;;=M75.32^^179^1938^9
 ;;^UTILITY(U,$J,358.3,31009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31009,1,3,0)
 ;;=3^Calcific tendinitis of left shoulder
 ;;^UTILITY(U,$J,358.3,31009,1,4,0)
 ;;=4^M75.32
 ;;^UTILITY(U,$J,358.3,31009,2)
 ;;=^5013255
 ;;^UTILITY(U,$J,358.3,31010,0)
 ;;=M75.31^^179^1938^10
 ;;^UTILITY(U,$J,358.3,31010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31010,1,3,0)
 ;;=3^Calcific tendinitis of right shoulder
 ;;^UTILITY(U,$J,358.3,31010,1,4,0)
 ;;=4^M75.31
 ;;^UTILITY(U,$J,358.3,31010,2)
 ;;=^5013254
 ;;^UTILITY(U,$J,358.3,31011,0)
 ;;=M75.122^^179^1938^11
 ;;^UTILITY(U,$J,358.3,31011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31011,1,3,0)
 ;;=3^Complete rotatr-cuff tear/ruptr of left shoulder, not trauma
 ;;^UTILITY(U,$J,358.3,31011,1,4,0)
 ;;=4^M75.122
 ;;^UTILITY(U,$J,358.3,31011,2)
 ;;=^5013249
 ;;^UTILITY(U,$J,358.3,31012,0)
 ;;=M75.121^^179^1938^12
 ;;^UTILITY(U,$J,358.3,31012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31012,1,3,0)
 ;;=3^Complete rotatr-cuff tear/ruptr of r shoulder, not trauma
 ;;^UTILITY(U,$J,358.3,31012,1,4,0)
 ;;=4^M75.121
 ;;^UTILITY(U,$J,358.3,31012,2)
 ;;=^5013248
 ;;^UTILITY(U,$J,358.3,31013,0)
 ;;=S40.012A^^179^1938^13
 ;;^UTILITY(U,$J,358.3,31013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31013,1,3,0)
 ;;=3^Contusion of left shoulder, initial encounter
 ;;^UTILITY(U,$J,358.3,31013,1,4,0)
 ;;=4^S40.012A
 ;;^UTILITY(U,$J,358.3,31013,2)
 ;;=^5026156
 ;;^UTILITY(U,$J,358.3,31014,0)
 ;;=S40.011A^^179^1938^14
 ;;^UTILITY(U,$J,358.3,31014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31014,1,3,0)
 ;;=3^Contusion of right shoulder, initial encounter
 ;;^UTILITY(U,$J,358.3,31014,1,4,0)
 ;;=4^S40.011A
 ;;^UTILITY(U,$J,358.3,31014,2)
 ;;=^5026153
 ;;^UTILITY(U,$J,358.3,31015,0)
 ;;=S42.002A^^179^1938^19
 ;;^UTILITY(U,$J,358.3,31015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31015,1,3,0)
 ;;=3^Fracture of unsp part of left clavicle, init for clos fx
 ;;^UTILITY(U,$J,358.3,31015,1,4,0)
 ;;=4^S42.002A
 ;;^UTILITY(U,$J,358.3,31015,2)
 ;;=^5026376
 ;;^UTILITY(U,$J,358.3,31016,0)
 ;;=S42.001A^^179^1938^20
 ;;^UTILITY(U,$J,358.3,31016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31016,1,3,0)
 ;;=3^Fracture of unsp part of right clavicle, init for clos fx
 ;;^UTILITY(U,$J,358.3,31016,1,4,0)
 ;;=4^S42.001A
 ;;^UTILITY(U,$J,358.3,31016,2)
 ;;=^5026369
 ;;^UTILITY(U,$J,358.3,31017,0)
 ;;=M75.42^^179^1938^21
 ;;^UTILITY(U,$J,358.3,31017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31017,1,3,0)
 ;;=3^Impingement syndrome of left shoulder
 ;;^UTILITY(U,$J,358.3,31017,1,4,0)
 ;;=4^M75.42
 ;;^UTILITY(U,$J,358.3,31017,2)
 ;;=^5013258
 ;;^UTILITY(U,$J,358.3,31018,0)
 ;;=M75.41^^179^1938^22
 ;;^UTILITY(U,$J,358.3,31018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31018,1,3,0)
 ;;=3^Impingement syndrome of right shoulder
 ;;^UTILITY(U,$J,358.3,31018,1,4,0)
 ;;=4^M75.41
 ;;^UTILITY(U,$J,358.3,31018,2)
 ;;=^5013257
 ;;^UTILITY(U,$J,358.3,31019,0)
 ;;=M75.112^^179^1938^23
 ;;^UTILITY(U,$J,358.3,31019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31019,1,3,0)
 ;;=3^Incomplete rotatr-cuff tear/ruptr of l shoulder, not trauma
 ;;^UTILITY(U,$J,358.3,31019,1,4,0)
 ;;=4^M75.112
 ;;^UTILITY(U,$J,358.3,31019,2)
 ;;=^5013246
 ;;^UTILITY(U,$J,358.3,31020,0)
 ;;=M75.111^^179^1938^24
 ;;^UTILITY(U,$J,358.3,31020,1,0)
 ;;=^358.31IA^4^2
