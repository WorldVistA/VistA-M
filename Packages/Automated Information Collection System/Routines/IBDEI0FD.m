IBDEI0FD ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7087,0)
 ;;=M80.08XA^^30^402^1
 ;;^UTILITY(U,$J,358.3,7087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7087,1,3,0)
 ;;=3^Age-Related Osteoporosis w/ Vertebra Fx,Init Encntr
 ;;^UTILITY(U,$J,358.3,7087,1,4,0)
 ;;=4^M80.08XA
 ;;^UTILITY(U,$J,358.3,7087,2)
 ;;=^5013495
 ;;^UTILITY(U,$J,358.3,7088,0)
 ;;=M80.08XD^^30^402^2
 ;;^UTILITY(U,$J,358.3,7088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7088,1,3,0)
 ;;=3^Age-Related Osteoporosis w/ Vertebra Fx,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7088,1,4,0)
 ;;=4^M80.08XD
 ;;^UTILITY(U,$J,358.3,7088,2)
 ;;=^5013496
 ;;^UTILITY(U,$J,358.3,7089,0)
 ;;=M84.48XA^^30^402^109
 ;;^UTILITY(U,$J,358.3,7089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7089,1,3,0)
 ;;=3^Pathological Fx,Oth Site,Init Encntr
 ;;^UTILITY(U,$J,358.3,7089,1,4,0)
 ;;=4^M84.48XA
 ;;^UTILITY(U,$J,358.3,7089,2)
 ;;=^5014016
 ;;^UTILITY(U,$J,358.3,7090,0)
 ;;=M84.48XD^^30^402^110
 ;;^UTILITY(U,$J,358.3,7090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7090,1,3,0)
 ;;=3^Pathological Fx,Oth Site,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7090,1,4,0)
 ;;=4^M84.48XD
 ;;^UTILITY(U,$J,358.3,7090,2)
 ;;=^5014017
 ;;^UTILITY(U,$J,358.3,7091,0)
 ;;=M87.011^^30^402^45
 ;;^UTILITY(U,$J,358.3,7091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7091,1,3,0)
 ;;=3^Idiopathic Aseptic Necrosis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,7091,1,4,0)
 ;;=4^M87.011
 ;;^UTILITY(U,$J,358.3,7091,2)
 ;;=^5014658
 ;;^UTILITY(U,$J,358.3,7092,0)
 ;;=M87.012^^30^402^42
 ;;^UTILITY(U,$J,358.3,7092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7092,1,3,0)
 ;;=3^Idiopathic Aseptic Necrosis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,7092,1,4,0)
 ;;=4^M87.012
 ;;^UTILITY(U,$J,358.3,7092,2)
 ;;=^5014659
 ;;^UTILITY(U,$J,358.3,7093,0)
 ;;=M87.050^^30^402^43
 ;;^UTILITY(U,$J,358.3,7093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7093,1,3,0)
 ;;=3^Idiopathic Aseptic Necrosis of Pelvis
 ;;^UTILITY(U,$J,358.3,7093,1,4,0)
 ;;=4^M87.050
 ;;^UTILITY(U,$J,358.3,7093,2)
 ;;=^5014679
 ;;^UTILITY(U,$J,358.3,7094,0)
 ;;=M87.051^^30^402^44
 ;;^UTILITY(U,$J,358.3,7094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7094,1,3,0)
 ;;=3^Idiopathic Aseptic Necrosis of Right Femur
 ;;^UTILITY(U,$J,358.3,7094,1,4,0)
 ;;=4^M87.051
 ;;^UTILITY(U,$J,358.3,7094,2)
 ;;=^5014680
 ;;^UTILITY(U,$J,358.3,7095,0)
 ;;=M87.052^^30^402^41
 ;;^UTILITY(U,$J,358.3,7095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7095,1,3,0)
 ;;=3^Idiopathic Aseptic Necrosis of Left Femur
 ;;^UTILITY(U,$J,358.3,7095,1,4,0)
 ;;=4^M87.052
 ;;^UTILITY(U,$J,358.3,7095,2)
 ;;=^5014681
 ;;^UTILITY(U,$J,358.3,7096,0)
 ;;=M87.111^^30^402^74
 ;;^UTILITY(U,$J,358.3,7096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7096,1,3,0)
 ;;=3^Osteonecrosis d/t Drugs,Right Shoulder
 ;;^UTILITY(U,$J,358.3,7096,1,4,0)
 ;;=4^M87.111
 ;;^UTILITY(U,$J,358.3,7096,2)
 ;;=^5014701
 ;;^UTILITY(U,$J,358.3,7097,0)
 ;;=M87.112^^30^402^71
 ;;^UTILITY(U,$J,358.3,7097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7097,1,3,0)
 ;;=3^Osteonecrosis d/t Drugs,Left Shoulder
 ;;^UTILITY(U,$J,358.3,7097,1,4,0)
 ;;=4^M87.112
 ;;^UTILITY(U,$J,358.3,7097,2)
 ;;=^5014702
 ;;^UTILITY(U,$J,358.3,7098,0)
 ;;=M87.150^^30^402^72
 ;;^UTILITY(U,$J,358.3,7098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7098,1,3,0)
 ;;=3^Osteonecrosis d/t Drugs,Pelvis
 ;;^UTILITY(U,$J,358.3,7098,1,4,0)
 ;;=4^M87.150
 ;;^UTILITY(U,$J,358.3,7098,2)
 ;;=^5014722
 ;;^UTILITY(U,$J,358.3,7099,0)
 ;;=M87.151^^30^402^73
 ;;^UTILITY(U,$J,358.3,7099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7099,1,3,0)
 ;;=3^Osteonecrosis d/t Drugs,Right Femur
 ;;^UTILITY(U,$J,358.3,7099,1,4,0)
 ;;=4^M87.151
