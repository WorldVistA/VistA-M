IBDEI121 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16952,2)
 ;;=^5004018
 ;;^UTILITY(U,$J,358.3,16953,0)
 ;;=G56.02^^88^885^12
 ;;^UTILITY(U,$J,358.3,16953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16953,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,16953,1,4,0)
 ;;=4^G56.02
 ;;^UTILITY(U,$J,358.3,16953,2)
 ;;=^5004019
 ;;^UTILITY(U,$J,358.3,16954,0)
 ;;=G56.21^^88^885^60
 ;;^UTILITY(U,$J,358.3,16954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16954,1,3,0)
 ;;=3^Lesion of Ulnar Nerve,Right Upper Limb
 ;;^UTILITY(U,$J,358.3,16954,1,4,0)
 ;;=4^G56.21
 ;;^UTILITY(U,$J,358.3,16954,2)
 ;;=^5004024
 ;;^UTILITY(U,$J,358.3,16955,0)
 ;;=G56.22^^88^885^59
 ;;^UTILITY(U,$J,358.3,16955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16955,1,3,0)
 ;;=3^Lesion of Ulnar Nerve,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,16955,1,4,0)
 ;;=4^G56.22
 ;;^UTILITY(U,$J,358.3,16955,2)
 ;;=^5004025
 ;;^UTILITY(U,$J,358.3,16956,0)
 ;;=L40.52^^88^885^143
 ;;^UTILITY(U,$J,358.3,16956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16956,1,3,0)
 ;;=3^Psoriatic Arthritis Mutilans
 ;;^UTILITY(U,$J,358.3,16956,1,4,0)
 ;;=4^L40.52
 ;;^UTILITY(U,$J,358.3,16956,2)
 ;;=^5009167
 ;;^UTILITY(U,$J,358.3,16957,0)
 ;;=L40.53^^88^885^144
 ;;^UTILITY(U,$J,358.3,16957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16957,1,3,0)
 ;;=3^Psoriatic Spondylitis
 ;;^UTILITY(U,$J,358.3,16957,1,4,0)
 ;;=4^L40.53
 ;;^UTILITY(U,$J,358.3,16957,2)
 ;;=^5009168
 ;;^UTILITY(U,$J,358.3,16958,0)
 ;;=M32.9^^88^885^187
 ;;^UTILITY(U,$J,358.3,16958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16958,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Unspec
 ;;^UTILITY(U,$J,358.3,16958,1,4,0)
 ;;=4^M32.9
 ;;^UTILITY(U,$J,358.3,16958,2)
 ;;=^5011761
 ;;^UTILITY(U,$J,358.3,16959,0)
 ;;=M32.0^^88^885^183
 ;;^UTILITY(U,$J,358.3,16959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16959,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Drug-Induced
 ;;^UTILITY(U,$J,358.3,16959,1,4,0)
 ;;=4^M32.0
 ;;^UTILITY(U,$J,358.3,16959,2)
 ;;=^5011752
 ;;^UTILITY(U,$J,358.3,16960,0)
 ;;=M32.13^^88^885^185
 ;;^UTILITY(U,$J,358.3,16960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16960,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Lung Involvement
 ;;^UTILITY(U,$J,358.3,16960,1,4,0)
 ;;=4^M32.13
 ;;^UTILITY(U,$J,358.3,16960,2)
 ;;=^5011756
 ;;^UTILITY(U,$J,358.3,16961,0)
 ;;=M32.14^^88^885^184
 ;;^UTILITY(U,$J,358.3,16961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16961,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Glomerular Disease
 ;;^UTILITY(U,$J,358.3,16961,1,4,0)
 ;;=4^M32.14
 ;;^UTILITY(U,$J,358.3,16961,2)
 ;;=^5011757
 ;;^UTILITY(U,$J,358.3,16962,0)
 ;;=M32.12^^88^885^186
 ;;^UTILITY(U,$J,358.3,16962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16962,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Pericarditis
 ;;^UTILITY(U,$J,358.3,16962,1,4,0)
 ;;=4^M32.12
 ;;^UTILITY(U,$J,358.3,16962,2)
 ;;=^5011755
 ;;^UTILITY(U,$J,358.3,16963,0)
 ;;=M05.59^^88^885^165
 ;;^UTILITY(U,$J,358.3,16963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16963,1,3,0)
 ;;=3^Rheumatoid Polyneuropathy w/ Rheumatoid Arthritis of Mult Sites
 ;;^UTILITY(U,$J,358.3,16963,1,4,0)
 ;;=4^M05.59
 ;;^UTILITY(U,$J,358.3,16963,2)
 ;;=^5009976
 ;;^UTILITY(U,$J,358.3,16964,0)
 ;;=M05.711^^88^885^159
 ;;^UTILITY(U,$J,358.3,16964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16964,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,16964,1,4,0)
 ;;=4^M05.711
