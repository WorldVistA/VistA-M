IBDEI1OP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28179,1,4,0)
 ;;=4^M70.21
 ;;^UTILITY(U,$J,358.3,28179,2)
 ;;=^5013047
 ;;^UTILITY(U,$J,358.3,28180,0)
 ;;=M70.22^^132^1326^63
 ;;^UTILITY(U,$J,358.3,28180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28180,1,3,0)
 ;;=3^Olecranon Bursitis,Left Elbow
 ;;^UTILITY(U,$J,358.3,28180,1,4,0)
 ;;=4^M70.22
 ;;^UTILITY(U,$J,358.3,28180,2)
 ;;=^5013048
 ;;^UTILITY(U,$J,358.3,28181,0)
 ;;=M71.161^^132^1326^47
 ;;^UTILITY(U,$J,358.3,28181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28181,1,3,0)
 ;;=3^Infective Bursitis,Right Knee
 ;;^UTILITY(U,$J,358.3,28181,1,4,0)
 ;;=4^M71.161
 ;;^UTILITY(U,$J,358.3,28181,2)
 ;;=^5013139
 ;;^UTILITY(U,$J,358.3,28182,0)
 ;;=M71.162^^132^1326^46
 ;;^UTILITY(U,$J,358.3,28182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28182,1,3,0)
 ;;=3^Infective Bursitis,Left Knee
 ;;^UTILITY(U,$J,358.3,28182,1,4,0)
 ;;=4^M71.162
 ;;^UTILITY(U,$J,358.3,28182,2)
 ;;=^5013140
 ;;^UTILITY(U,$J,358.3,28183,0)
 ;;=M72.0^^132^1326^100
 ;;^UTILITY(U,$J,358.3,28183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28183,1,3,0)
 ;;=3^Palmar Fascial Fibromatosis
 ;;^UTILITY(U,$J,358.3,28183,1,4,0)
 ;;=4^M72.0
 ;;^UTILITY(U,$J,358.3,28183,2)
 ;;=^5013233
 ;;^UTILITY(U,$J,358.3,28184,0)
 ;;=M75.111^^132^1326^144
 ;;^UTILITY(U,$J,358.3,28184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28184,1,3,0)
 ;;=3^Rotator Cuff Syndrome,Right Shoulder
 ;;^UTILITY(U,$J,358.3,28184,1,4,0)
 ;;=4^M75.111
 ;;^UTILITY(U,$J,358.3,28184,2)
 ;;=^5013245
 ;;^UTILITY(U,$J,358.3,28185,0)
 ;;=M75.112^^132^1326^143
 ;;^UTILITY(U,$J,358.3,28185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28185,1,3,0)
 ;;=3^Rotator Cuff Syndrome,Left Shoulder
 ;;^UTILITY(U,$J,358.3,28185,1,4,0)
 ;;=4^M75.112
 ;;^UTILITY(U,$J,358.3,28185,2)
 ;;=^5013246
 ;;^UTILITY(U,$J,358.3,28186,0)
 ;;=M75.51^^132^1326^10
 ;;^UTILITY(U,$J,358.3,28186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28186,1,3,0)
 ;;=3^Bursitis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,28186,1,4,0)
 ;;=4^M75.51
 ;;^UTILITY(U,$J,358.3,28186,2)
 ;;=^5133690
 ;;^UTILITY(U,$J,358.3,28187,0)
 ;;=M75.52^^132^1326^9
 ;;^UTILITY(U,$J,358.3,28187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28187,1,3,0)
 ;;=3^Bursitis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,28187,1,4,0)
 ;;=4^M75.52
 ;;^UTILITY(U,$J,358.3,28187,2)
 ;;=^5133691
 ;;^UTILITY(U,$J,358.3,28188,0)
 ;;=M77.11^^132^1326^54
 ;;^UTILITY(U,$J,358.3,28188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28188,1,3,0)
 ;;=3^Lateral Epicondylitis,Right Elbow
 ;;^UTILITY(U,$J,358.3,28188,1,4,0)
 ;;=4^M77.11
 ;;^UTILITY(U,$J,358.3,28188,2)
 ;;=^5013304
 ;;^UTILITY(U,$J,358.3,28189,0)
 ;;=M77.12^^132^1326^53
 ;;^UTILITY(U,$J,358.3,28189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28189,1,3,0)
 ;;=3^Lateral Epicondylitis,Left Elbow
 ;;^UTILITY(U,$J,358.3,28189,1,4,0)
 ;;=4^M77.12
 ;;^UTILITY(U,$J,358.3,28189,2)
 ;;=^5013305
 ;;^UTILITY(U,$J,358.3,28190,0)
 ;;=M79.1^^132^1326^61
 ;;^UTILITY(U,$J,358.3,28190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28190,1,3,0)
 ;;=3^Myalgia
 ;;^UTILITY(U,$J,358.3,28190,1,4,0)
 ;;=4^M79.1
 ;;^UTILITY(U,$J,358.3,28190,2)
 ;;=^5013321
 ;;^UTILITY(U,$J,358.3,28191,0)
 ;;=M79.7^^132^1326^39
 ;;^UTILITY(U,$J,358.3,28191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28191,1,3,0)
 ;;=3^Fibromyalgia
 ;;^UTILITY(U,$J,358.3,28191,1,4,0)
 ;;=4^M79.7
 ;;^UTILITY(U,$J,358.3,28191,2)
 ;;=^46261
 ;;^UTILITY(U,$J,358.3,28192,0)
 ;;=M80.08XA^^132^1326^1
 ;;^UTILITY(U,$J,358.3,28192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28192,1,3,0)
 ;;=3^Age-Related Osteoporosis w/ Vertebra Fx,Init Encntr
 ;;^UTILITY(U,$J,358.3,28192,1,4,0)
 ;;=4^M80.08XA