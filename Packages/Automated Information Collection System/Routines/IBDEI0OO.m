IBDEI0OO ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11289,0)
 ;;=M80.08XA^^68^681^1
 ;;^UTILITY(U,$J,358.3,11289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11289,1,3,0)
 ;;=3^Age-Related Osteoporosis w/ Vertebra Fx,Init Encntr
 ;;^UTILITY(U,$J,358.3,11289,1,4,0)
 ;;=4^M80.08XA
 ;;^UTILITY(U,$J,358.3,11289,2)
 ;;=^5013495
 ;;^UTILITY(U,$J,358.3,11290,0)
 ;;=M80.08XD^^68^681^2
 ;;^UTILITY(U,$J,358.3,11290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11290,1,3,0)
 ;;=3^Age-Related Osteoporosis w/ Vertebra Fx,Subs Encntr
 ;;^UTILITY(U,$J,358.3,11290,1,4,0)
 ;;=4^M80.08XD
 ;;^UTILITY(U,$J,358.3,11290,2)
 ;;=^5013496
 ;;^UTILITY(U,$J,358.3,11291,0)
 ;;=M84.48XA^^68^681^101
 ;;^UTILITY(U,$J,358.3,11291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11291,1,3,0)
 ;;=3^Pathological Fx,Oth Site,Init Encntr
 ;;^UTILITY(U,$J,358.3,11291,1,4,0)
 ;;=4^M84.48XA
 ;;^UTILITY(U,$J,358.3,11291,2)
 ;;=^5014016
 ;;^UTILITY(U,$J,358.3,11292,0)
 ;;=M84.48XD^^68^681^102
 ;;^UTILITY(U,$J,358.3,11292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11292,1,3,0)
 ;;=3^Pathological Fx,Oth Site,Subs Encntr
 ;;^UTILITY(U,$J,358.3,11292,1,4,0)
 ;;=4^M84.48XD
 ;;^UTILITY(U,$J,358.3,11292,2)
 ;;=^5014017
 ;;^UTILITY(U,$J,358.3,11293,0)
 ;;=M87.011^^68^681^45
 ;;^UTILITY(U,$J,358.3,11293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11293,1,3,0)
 ;;=3^Idiopathic Aseptic Necrosis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,11293,1,4,0)
 ;;=4^M87.011
 ;;^UTILITY(U,$J,358.3,11293,2)
 ;;=^5014658
 ;;^UTILITY(U,$J,358.3,11294,0)
 ;;=M87.012^^68^681^42
 ;;^UTILITY(U,$J,358.3,11294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11294,1,3,0)
 ;;=3^Idiopathic Aseptic Necrosis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,11294,1,4,0)
 ;;=4^M87.012
 ;;^UTILITY(U,$J,358.3,11294,2)
 ;;=^5014659
 ;;^UTILITY(U,$J,358.3,11295,0)
 ;;=M87.050^^68^681^43
 ;;^UTILITY(U,$J,358.3,11295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11295,1,3,0)
 ;;=3^Idiopathic Aseptic Necrosis of Pelvis
 ;;^UTILITY(U,$J,358.3,11295,1,4,0)
 ;;=4^M87.050
 ;;^UTILITY(U,$J,358.3,11295,2)
 ;;=^5014679
 ;;^UTILITY(U,$J,358.3,11296,0)
 ;;=M87.051^^68^681^44
 ;;^UTILITY(U,$J,358.3,11296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11296,1,3,0)
 ;;=3^Idiopathic Aseptic Necrosis of Right Femur
 ;;^UTILITY(U,$J,358.3,11296,1,4,0)
 ;;=4^M87.051
 ;;^UTILITY(U,$J,358.3,11296,2)
 ;;=^5014680
 ;;^UTILITY(U,$J,358.3,11297,0)
 ;;=M87.052^^68^681^41
 ;;^UTILITY(U,$J,358.3,11297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11297,1,3,0)
 ;;=3^Idiopathic Aseptic Necrosis of Left Femur
 ;;^UTILITY(U,$J,358.3,11297,1,4,0)
 ;;=4^M87.052
 ;;^UTILITY(U,$J,358.3,11297,2)
 ;;=^5014681
 ;;^UTILITY(U,$J,358.3,11298,0)
 ;;=M87.111^^68^681^74
 ;;^UTILITY(U,$J,358.3,11298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11298,1,3,0)
 ;;=3^Osteonecrosis d/t Drugs,Right Shoulder
 ;;^UTILITY(U,$J,358.3,11298,1,4,0)
 ;;=4^M87.111
 ;;^UTILITY(U,$J,358.3,11298,2)
 ;;=^5014701
 ;;^UTILITY(U,$J,358.3,11299,0)
 ;;=M87.112^^68^681^71
 ;;^UTILITY(U,$J,358.3,11299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11299,1,3,0)
 ;;=3^Osteonecrosis d/t Drugs,Left Shoulder
 ;;^UTILITY(U,$J,358.3,11299,1,4,0)
 ;;=4^M87.112
 ;;^UTILITY(U,$J,358.3,11299,2)
 ;;=^5014702
 ;;^UTILITY(U,$J,358.3,11300,0)
 ;;=M87.150^^68^681^72
 ;;^UTILITY(U,$J,358.3,11300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11300,1,3,0)
 ;;=3^Osteonecrosis d/t Drugs,Pelvis
 ;;^UTILITY(U,$J,358.3,11300,1,4,0)
 ;;=4^M87.150
 ;;^UTILITY(U,$J,358.3,11300,2)
 ;;=^5014722
 ;;^UTILITY(U,$J,358.3,11301,0)
 ;;=M87.151^^68^681^73
 ;;^UTILITY(U,$J,358.3,11301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11301,1,3,0)
 ;;=3^Osteonecrosis d/t Drugs,Right Femur
