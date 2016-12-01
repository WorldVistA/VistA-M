IBDEI05L ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6933,0)
 ;;=R25.1^^26^407^7
 ;;^UTILITY(U,$J,358.3,6933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6933,1,3,0)
 ;;=3^Tremor,Unspec
 ;;^UTILITY(U,$J,358.3,6933,1,4,0)
 ;;=4^R25.1
 ;;^UTILITY(U,$J,358.3,6933,2)
 ;;=^5019300
 ;;^UTILITY(U,$J,358.3,6934,0)
 ;;=R25.9^^26^407^3
 ;;^UTILITY(U,$J,358.3,6934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6934,1,3,0)
 ;;=3^Abnormal Involuntary Movements,Unspec
 ;;^UTILITY(U,$J,358.3,6934,1,4,0)
 ;;=4^R25.9
 ;;^UTILITY(U,$J,358.3,6934,2)
 ;;=^5019303
 ;;^UTILITY(U,$J,358.3,6935,0)
 ;;=R25.3^^26^407^5
 ;;^UTILITY(U,$J,358.3,6935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6935,1,3,0)
 ;;=3^Fasciculation/Twitching
 ;;^UTILITY(U,$J,358.3,6935,1,4,0)
 ;;=4^R25.3
 ;;^UTILITY(U,$J,358.3,6935,2)
 ;;=^44985
 ;;^UTILITY(U,$J,358.3,6936,0)
 ;;=R25.8^^26^407^2
 ;;^UTILITY(U,$J,358.3,6936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6936,1,3,0)
 ;;=3^Abnormal Involuntary Movements,Other
 ;;^UTILITY(U,$J,358.3,6936,1,4,0)
 ;;=4^R25.8
 ;;^UTILITY(U,$J,358.3,6936,2)
 ;;=^5019302
 ;;^UTILITY(U,$J,358.3,6937,0)
 ;;=M02.30^^26^408^132
 ;;^UTILITY(U,$J,358.3,6937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6937,1,3,0)
 ;;=3^Reiter's Disease,Unspec Site
 ;;^UTILITY(U,$J,358.3,6937,1,4,0)
 ;;=4^M02.30
 ;;^UTILITY(U,$J,358.3,6937,2)
 ;;=^5009790
 ;;^UTILITY(U,$J,358.3,6938,0)
 ;;=M10.9^^26^408^40
 ;;^UTILITY(U,$J,358.3,6938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6938,1,3,0)
 ;;=3^Gout,Unspec
 ;;^UTILITY(U,$J,358.3,6938,1,4,0)
 ;;=4^M10.9
 ;;^UTILITY(U,$J,358.3,6938,2)
 ;;=^5010404
 ;;^UTILITY(U,$J,358.3,6939,0)
 ;;=G90.59^^26^408^34
 ;;^UTILITY(U,$J,358.3,6939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6939,1,3,0)
 ;;=3^Complex Regional Pain Syndrome I,Unspec
 ;;^UTILITY(U,$J,358.3,6939,1,4,0)
 ;;=4^G90.59
 ;;^UTILITY(U,$J,358.3,6939,2)
 ;;=^5004171
 ;;^UTILITY(U,$J,358.3,6940,0)
 ;;=G56.01^^26^408^12
 ;;^UTILITY(U,$J,358.3,6940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6940,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Right Upper Limb
 ;;^UTILITY(U,$J,358.3,6940,1,4,0)
 ;;=4^G56.01
 ;;^UTILITY(U,$J,358.3,6940,2)
 ;;=^5004018
 ;;^UTILITY(U,$J,358.3,6941,0)
 ;;=G56.02^^26^408^11
 ;;^UTILITY(U,$J,358.3,6941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6941,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,6941,1,4,0)
 ;;=4^G56.02
 ;;^UTILITY(U,$J,358.3,6941,2)
 ;;=^5004019
 ;;^UTILITY(U,$J,358.3,6942,0)
 ;;=G56.21^^26^408^56
 ;;^UTILITY(U,$J,358.3,6942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6942,1,3,0)
 ;;=3^Lesion of Ulnar Nerve,Right Upper Limb
 ;;^UTILITY(U,$J,358.3,6942,1,4,0)
 ;;=4^G56.21
 ;;^UTILITY(U,$J,358.3,6942,2)
 ;;=^5004024
 ;;^UTILITY(U,$J,358.3,6943,0)
 ;;=G56.22^^26^408^55
 ;;^UTILITY(U,$J,358.3,6943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6943,1,3,0)
 ;;=3^Lesion of Ulnar Nerve,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,6943,1,4,0)
 ;;=4^G56.22
 ;;^UTILITY(U,$J,358.3,6943,2)
 ;;=^5004025
 ;;^UTILITY(U,$J,358.3,6944,0)
 ;;=M26.60^^26^408^171
 ;;^UTILITY(U,$J,358.3,6944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6944,1,3,0)
 ;;=3^Temporomandibular Joint Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,6944,1,4,0)
 ;;=4^M26.60
 ;;^UTILITY(U,$J,358.3,6944,2)
 ;;=^5011714
 ;;^UTILITY(U,$J,358.3,6945,0)
 ;;=L40.52^^26^408^128
 ;;^UTILITY(U,$J,358.3,6945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6945,1,3,0)
 ;;=3^Psoriatic Arthritis Mutilans
 ;;^UTILITY(U,$J,358.3,6945,1,4,0)
 ;;=4^L40.52
 ;;^UTILITY(U,$J,358.3,6945,2)
 ;;=^5009167
 ;;^UTILITY(U,$J,358.3,6946,0)
 ;;=L40.53^^26^408^129
 ;;^UTILITY(U,$J,358.3,6946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6946,1,3,0)
 ;;=3^Psoriatic Spondylitis
 ;;^UTILITY(U,$J,358.3,6946,1,4,0)
 ;;=4^L40.53
 ;;^UTILITY(U,$J,358.3,6946,2)
 ;;=^5009168
 ;;^UTILITY(U,$J,358.3,6947,0)
 ;;=M32.9^^26^408^170
 ;;^UTILITY(U,$J,358.3,6947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6947,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Unspec
 ;;^UTILITY(U,$J,358.3,6947,1,4,0)
 ;;=4^M32.9
 ;;^UTILITY(U,$J,358.3,6947,2)
 ;;=^5011761
 ;;^UTILITY(U,$J,358.3,6948,0)
 ;;=M32.0^^26^408^166
 ;;^UTILITY(U,$J,358.3,6948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6948,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Drug-Induced
 ;;^UTILITY(U,$J,358.3,6948,1,4,0)
 ;;=4^M32.0
 ;;^UTILITY(U,$J,358.3,6948,2)
 ;;=^5011752
 ;;^UTILITY(U,$J,358.3,6949,0)
 ;;=M32.13^^26^408^168
 ;;^UTILITY(U,$J,358.3,6949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6949,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Lung Involvement
 ;;^UTILITY(U,$J,358.3,6949,1,4,0)
 ;;=4^M32.13
 ;;^UTILITY(U,$J,358.3,6949,2)
 ;;=^5011756
 ;;^UTILITY(U,$J,358.3,6950,0)
 ;;=M32.14^^26^408^167
 ;;^UTILITY(U,$J,358.3,6950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6950,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Glomerular Disease
 ;;^UTILITY(U,$J,358.3,6950,1,4,0)
 ;;=4^M32.14
 ;;^UTILITY(U,$J,358.3,6950,2)
 ;;=^5011757
 ;;^UTILITY(U,$J,358.3,6951,0)
 ;;=M32.12^^26^408^169
 ;;^UTILITY(U,$J,358.3,6951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6951,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Pericarditis
 ;;^UTILITY(U,$J,358.3,6951,1,4,0)
 ;;=4^M32.12
 ;;^UTILITY(U,$J,358.3,6951,2)
 ;;=^5011755
 ;;^UTILITY(U,$J,358.3,6952,0)
 ;;=M05.59^^26^408^150
 ;;^UTILITY(U,$J,358.3,6952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6952,1,3,0)
 ;;=3^Rheumatoid Polyneuropathy w/ Rheumatoid Arthritis of Mult Sites
 ;;^UTILITY(U,$J,358.3,6952,1,4,0)
 ;;=4^M05.59
 ;;^UTILITY(U,$J,358.3,6952,2)
 ;;=^5009976
 ;;^UTILITY(U,$J,358.3,6953,0)
 ;;=M05.711^^26^408^144
 ;;^UTILITY(U,$J,358.3,6953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6953,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,6953,1,4,0)
 ;;=4^M05.711
 ;;^UTILITY(U,$J,358.3,6953,2)
 ;;=^5010001
 ;;^UTILITY(U,$J,358.3,6954,0)
 ;;=M05.712^^26^408^137
 ;;^UTILITY(U,$J,358.3,6954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6954,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,6954,1,4,0)
 ;;=4^M05.712
 ;;^UTILITY(U,$J,358.3,6954,2)
 ;;=^5010002
 ;;^UTILITY(U,$J,358.3,6955,0)
 ;;=M05.731^^26^408^145
 ;;^UTILITY(U,$J,358.3,6955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6955,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Wrist
 ;;^UTILITY(U,$J,358.3,6955,1,4,0)
 ;;=4^M05.731
 ;;^UTILITY(U,$J,358.3,6955,2)
 ;;=^5010007
 ;;^UTILITY(U,$J,358.3,6956,0)
 ;;=M05.732^^26^408^138
 ;;^UTILITY(U,$J,358.3,6956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6956,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Wrist
 ;;^UTILITY(U,$J,358.3,6956,1,4,0)
 ;;=4^M05.732
 ;;^UTILITY(U,$J,358.3,6956,2)
 ;;=^5010008
 ;;^UTILITY(U,$J,358.3,6957,0)
 ;;=M05.741^^26^408^141
 ;;^UTILITY(U,$J,358.3,6957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6957,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,6957,1,4,0)
 ;;=4^M05.741
 ;;^UTILITY(U,$J,358.3,6957,2)
 ;;=^5010010
 ;;^UTILITY(U,$J,358.3,6958,0)
 ;;=M05.742^^26^408^134
 ;;^UTILITY(U,$J,358.3,6958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6958,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,6958,1,4,0)
 ;;=4^M05.742
 ;;^UTILITY(U,$J,358.3,6958,2)
 ;;=^5010011
 ;;^UTILITY(U,$J,358.3,6959,0)
 ;;=M05.751^^26^408^142
 ;;^UTILITY(U,$J,358.3,6959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6959,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Hip
 ;;^UTILITY(U,$J,358.3,6959,1,4,0)
 ;;=4^M05.751
 ;;^UTILITY(U,$J,358.3,6959,2)
 ;;=^5010013
 ;;^UTILITY(U,$J,358.3,6960,0)
 ;;=M05.752^^26^408^135
 ;;^UTILITY(U,$J,358.3,6960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6960,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Hip
 ;;^UTILITY(U,$J,358.3,6960,1,4,0)
 ;;=4^M05.752
 ;;^UTILITY(U,$J,358.3,6960,2)
 ;;=^5010014
 ;;^UTILITY(U,$J,358.3,6961,0)
 ;;=M05.761^^26^408^143
 ;;^UTILITY(U,$J,358.3,6961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6961,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Knee
 ;;^UTILITY(U,$J,358.3,6961,1,4,0)
 ;;=4^M05.761
 ;;^UTILITY(U,$J,358.3,6961,2)
 ;;=^5010016
 ;;^UTILITY(U,$J,358.3,6962,0)
 ;;=M05.762^^26^408^136
 ;;^UTILITY(U,$J,358.3,6962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6962,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Knee
 ;;^UTILITY(U,$J,358.3,6962,1,4,0)
 ;;=4^M05.762
 ;;^UTILITY(U,$J,358.3,6962,2)
 ;;=^5010017
 ;;^UTILITY(U,$J,358.3,6963,0)
 ;;=M05.771^^26^408^140
 ;;^UTILITY(U,$J,358.3,6963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6963,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Ankle
 ;;^UTILITY(U,$J,358.3,6963,1,4,0)
 ;;=4^M05.771
 ;;^UTILITY(U,$J,358.3,6963,2)
 ;;=^5010019
 ;;^UTILITY(U,$J,358.3,6964,0)
 ;;=M05.772^^26^408^133
 ;;^UTILITY(U,$J,358.3,6964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6964,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Ankle
 ;;^UTILITY(U,$J,358.3,6964,1,4,0)
 ;;=4^M05.772
 ;;^UTILITY(U,$J,358.3,6964,2)
 ;;=^5010020
 ;;^UTILITY(U,$J,358.3,6965,0)
 ;;=M05.79^^26^408^139
 ;;^UTILITY(U,$J,358.3,6965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6965,1,3,0)
 ;;=3^Rheumatoid Arthritis of Multiple Sites
 ;;^UTILITY(U,$J,358.3,6965,1,4,0)
 ;;=4^M05.79
 ;;^UTILITY(U,$J,358.3,6965,2)
 ;;=^5010022
 ;;^UTILITY(U,$J,358.3,6966,0)
 ;;=M06.00^^26^408^146
 ;;^UTILITY(U,$J,358.3,6966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6966,1,3,0)
 ;;=3^Rheumatoid Arthritis w/o Rhematoid Factor,Unspec Site
 ;;^UTILITY(U,$J,358.3,6966,1,4,0)
 ;;=4^M06.00
 ;;^UTILITY(U,$J,358.3,6966,2)
 ;;=^5010047
 ;;^UTILITY(U,$J,358.3,6967,0)
 ;;=M06.30^^26^408^149
 ;;^UTILITY(U,$J,358.3,6967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6967,1,3,0)
 ;;=3^Rheumatoid Nodule,Unspec Site
 ;;^UTILITY(U,$J,358.3,6967,1,4,0)
 ;;=4^M06.30
 ;;^UTILITY(U,$J,358.3,6967,2)
 ;;=^5010096
 ;;^UTILITY(U,$J,358.3,6968,0)
 ;;=M06.4^^26^408^48
 ;;^UTILITY(U,$J,358.3,6968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6968,1,3,0)
 ;;=3^Inflammatory Polyarthropathy
 ;;^UTILITY(U,$J,358.3,6968,1,4,0)
 ;;=4^M06.4
