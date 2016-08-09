IBDEI080 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7938,1,3,0)
 ;;=3^Complex Regional Pain Syndrome I,Unspec
 ;;^UTILITY(U,$J,358.3,7938,1,4,0)
 ;;=4^G90.59
 ;;^UTILITY(U,$J,358.3,7938,2)
 ;;=^5004171
 ;;^UTILITY(U,$J,358.3,7939,0)
 ;;=G56.01^^42^504^12
 ;;^UTILITY(U,$J,358.3,7939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7939,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Right Upper Limb
 ;;^UTILITY(U,$J,358.3,7939,1,4,0)
 ;;=4^G56.01
 ;;^UTILITY(U,$J,358.3,7939,2)
 ;;=^5004018
 ;;^UTILITY(U,$J,358.3,7940,0)
 ;;=G56.02^^42^504^11
 ;;^UTILITY(U,$J,358.3,7940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7940,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,7940,1,4,0)
 ;;=4^G56.02
 ;;^UTILITY(U,$J,358.3,7940,2)
 ;;=^5004019
 ;;^UTILITY(U,$J,358.3,7941,0)
 ;;=G56.21^^42^504^56
 ;;^UTILITY(U,$J,358.3,7941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7941,1,3,0)
 ;;=3^Lesion of Ulnar Nerve,Right Upper Limb
 ;;^UTILITY(U,$J,358.3,7941,1,4,0)
 ;;=4^G56.21
 ;;^UTILITY(U,$J,358.3,7941,2)
 ;;=^5004024
 ;;^UTILITY(U,$J,358.3,7942,0)
 ;;=G56.22^^42^504^55
 ;;^UTILITY(U,$J,358.3,7942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7942,1,3,0)
 ;;=3^Lesion of Ulnar Nerve,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,7942,1,4,0)
 ;;=4^G56.22
 ;;^UTILITY(U,$J,358.3,7942,2)
 ;;=^5004025
 ;;^UTILITY(U,$J,358.3,7943,0)
 ;;=M26.60^^42^504^171
 ;;^UTILITY(U,$J,358.3,7943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7943,1,3,0)
 ;;=3^Temporomandibular Joint Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,7943,1,4,0)
 ;;=4^M26.60
 ;;^UTILITY(U,$J,358.3,7943,2)
 ;;=^5011714
 ;;^UTILITY(U,$J,358.3,7944,0)
 ;;=L40.52^^42^504^128
 ;;^UTILITY(U,$J,358.3,7944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7944,1,3,0)
 ;;=3^Psoriatic Arthritis Mutilans
 ;;^UTILITY(U,$J,358.3,7944,1,4,0)
 ;;=4^L40.52
 ;;^UTILITY(U,$J,358.3,7944,2)
 ;;=^5009167
 ;;^UTILITY(U,$J,358.3,7945,0)
 ;;=L40.53^^42^504^129
 ;;^UTILITY(U,$J,358.3,7945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7945,1,3,0)
 ;;=3^Psoriatic Spondylitis
 ;;^UTILITY(U,$J,358.3,7945,1,4,0)
 ;;=4^L40.53
 ;;^UTILITY(U,$J,358.3,7945,2)
 ;;=^5009168
 ;;^UTILITY(U,$J,358.3,7946,0)
 ;;=M32.9^^42^504^170
 ;;^UTILITY(U,$J,358.3,7946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7946,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Unspec
 ;;^UTILITY(U,$J,358.3,7946,1,4,0)
 ;;=4^M32.9
 ;;^UTILITY(U,$J,358.3,7946,2)
 ;;=^5011761
 ;;^UTILITY(U,$J,358.3,7947,0)
 ;;=M32.0^^42^504^166
 ;;^UTILITY(U,$J,358.3,7947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7947,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Drug-Induced
 ;;^UTILITY(U,$J,358.3,7947,1,4,0)
 ;;=4^M32.0
 ;;^UTILITY(U,$J,358.3,7947,2)
 ;;=^5011752
 ;;^UTILITY(U,$J,358.3,7948,0)
 ;;=M32.13^^42^504^168
 ;;^UTILITY(U,$J,358.3,7948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7948,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Lung Involvement
 ;;^UTILITY(U,$J,358.3,7948,1,4,0)
 ;;=4^M32.13
 ;;^UTILITY(U,$J,358.3,7948,2)
 ;;=^5011756
 ;;^UTILITY(U,$J,358.3,7949,0)
 ;;=M32.14^^42^504^167
 ;;^UTILITY(U,$J,358.3,7949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7949,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Glomerular Disease
 ;;^UTILITY(U,$J,358.3,7949,1,4,0)
 ;;=4^M32.14
 ;;^UTILITY(U,$J,358.3,7949,2)
 ;;=^5011757
 ;;^UTILITY(U,$J,358.3,7950,0)
 ;;=M32.12^^42^504^169
 ;;^UTILITY(U,$J,358.3,7950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7950,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Pericarditis
 ;;^UTILITY(U,$J,358.3,7950,1,4,0)
 ;;=4^M32.12
 ;;^UTILITY(U,$J,358.3,7950,2)
 ;;=^5011755
 ;;^UTILITY(U,$J,358.3,7951,0)
 ;;=M05.59^^42^504^150
 ;;^UTILITY(U,$J,358.3,7951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7951,1,3,0)
 ;;=3^Rheumatoid Polyneuropathy w/ Rheumatoid Arthritis of Mult Sites
 ;;^UTILITY(U,$J,358.3,7951,1,4,0)
 ;;=4^M05.59
 ;;^UTILITY(U,$J,358.3,7951,2)
 ;;=^5009976
 ;;^UTILITY(U,$J,358.3,7952,0)
 ;;=M05.711^^42^504^144
 ;;^UTILITY(U,$J,358.3,7952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7952,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,7952,1,4,0)
 ;;=4^M05.711
 ;;^UTILITY(U,$J,358.3,7952,2)
 ;;=^5010001
 ;;^UTILITY(U,$J,358.3,7953,0)
 ;;=M05.712^^42^504^137
 ;;^UTILITY(U,$J,358.3,7953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7953,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,7953,1,4,0)
 ;;=4^M05.712
 ;;^UTILITY(U,$J,358.3,7953,2)
 ;;=^5010002
 ;;^UTILITY(U,$J,358.3,7954,0)
 ;;=M05.731^^42^504^145
 ;;^UTILITY(U,$J,358.3,7954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7954,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Wrist
 ;;^UTILITY(U,$J,358.3,7954,1,4,0)
 ;;=4^M05.731
 ;;^UTILITY(U,$J,358.3,7954,2)
 ;;=^5010007
 ;;^UTILITY(U,$J,358.3,7955,0)
 ;;=M05.732^^42^504^138
 ;;^UTILITY(U,$J,358.3,7955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7955,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Wrist
 ;;^UTILITY(U,$J,358.3,7955,1,4,0)
 ;;=4^M05.732
 ;;^UTILITY(U,$J,358.3,7955,2)
 ;;=^5010008
 ;;^UTILITY(U,$J,358.3,7956,0)
 ;;=M05.741^^42^504^141
 ;;^UTILITY(U,$J,358.3,7956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7956,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,7956,1,4,0)
 ;;=4^M05.741
 ;;^UTILITY(U,$J,358.3,7956,2)
 ;;=^5010010
 ;;^UTILITY(U,$J,358.3,7957,0)
 ;;=M05.742^^42^504^134
 ;;^UTILITY(U,$J,358.3,7957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7957,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,7957,1,4,0)
 ;;=4^M05.742
 ;;^UTILITY(U,$J,358.3,7957,2)
 ;;=^5010011
 ;;^UTILITY(U,$J,358.3,7958,0)
 ;;=M05.751^^42^504^142
 ;;^UTILITY(U,$J,358.3,7958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7958,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Hip
 ;;^UTILITY(U,$J,358.3,7958,1,4,0)
 ;;=4^M05.751
 ;;^UTILITY(U,$J,358.3,7958,2)
 ;;=^5010013
 ;;^UTILITY(U,$J,358.3,7959,0)
 ;;=M05.752^^42^504^135
 ;;^UTILITY(U,$J,358.3,7959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7959,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Hip
 ;;^UTILITY(U,$J,358.3,7959,1,4,0)
 ;;=4^M05.752
 ;;^UTILITY(U,$J,358.3,7959,2)
 ;;=^5010014
 ;;^UTILITY(U,$J,358.3,7960,0)
 ;;=M05.761^^42^504^143
 ;;^UTILITY(U,$J,358.3,7960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7960,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Knee
 ;;^UTILITY(U,$J,358.3,7960,1,4,0)
 ;;=4^M05.761
 ;;^UTILITY(U,$J,358.3,7960,2)
 ;;=^5010016
 ;;^UTILITY(U,$J,358.3,7961,0)
 ;;=M05.762^^42^504^136
 ;;^UTILITY(U,$J,358.3,7961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7961,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Knee
 ;;^UTILITY(U,$J,358.3,7961,1,4,0)
 ;;=4^M05.762
 ;;^UTILITY(U,$J,358.3,7961,2)
 ;;=^5010017
 ;;^UTILITY(U,$J,358.3,7962,0)
 ;;=M05.771^^42^504^140
 ;;^UTILITY(U,$J,358.3,7962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7962,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Ankle
 ;;^UTILITY(U,$J,358.3,7962,1,4,0)
 ;;=4^M05.771
 ;;^UTILITY(U,$J,358.3,7962,2)
 ;;=^5010019
 ;;^UTILITY(U,$J,358.3,7963,0)
 ;;=M05.772^^42^504^133
 ;;^UTILITY(U,$J,358.3,7963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7963,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Ankle
 ;;^UTILITY(U,$J,358.3,7963,1,4,0)
 ;;=4^M05.772
 ;;^UTILITY(U,$J,358.3,7963,2)
 ;;=^5010020
 ;;^UTILITY(U,$J,358.3,7964,0)
 ;;=M05.79^^42^504^139
 ;;^UTILITY(U,$J,358.3,7964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7964,1,3,0)
 ;;=3^Rheumatoid Arthritis of Multiple Sites
 ;;^UTILITY(U,$J,358.3,7964,1,4,0)
 ;;=4^M05.79
 ;;^UTILITY(U,$J,358.3,7964,2)
 ;;=^5010022
 ;;^UTILITY(U,$J,358.3,7965,0)
 ;;=M06.00^^42^504^146
 ;;^UTILITY(U,$J,358.3,7965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7965,1,3,0)
 ;;=3^Rheumatoid Arthritis w/o Rhematoid Factor,Unspec Site
 ;;^UTILITY(U,$J,358.3,7965,1,4,0)
 ;;=4^M06.00
 ;;^UTILITY(U,$J,358.3,7965,2)
 ;;=^5010047
 ;;^UTILITY(U,$J,358.3,7966,0)
 ;;=M06.30^^42^504^149
