IBDEI0GO ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7227,1,4,0)
 ;;=4^G56.01
 ;;^UTILITY(U,$J,358.3,7227,2)
 ;;=^5004018
 ;;^UTILITY(U,$J,358.3,7228,0)
 ;;=G56.02^^58^473^11
 ;;^UTILITY(U,$J,358.3,7228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7228,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,7228,1,4,0)
 ;;=4^G56.02
 ;;^UTILITY(U,$J,358.3,7228,2)
 ;;=^5004019
 ;;^UTILITY(U,$J,358.3,7229,0)
 ;;=G56.21^^58^473^56
 ;;^UTILITY(U,$J,358.3,7229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7229,1,3,0)
 ;;=3^Lesion of Ulnar Nerve,Right Upper Limb
 ;;^UTILITY(U,$J,358.3,7229,1,4,0)
 ;;=4^G56.21
 ;;^UTILITY(U,$J,358.3,7229,2)
 ;;=^5004024
 ;;^UTILITY(U,$J,358.3,7230,0)
 ;;=G56.22^^58^473^55
 ;;^UTILITY(U,$J,358.3,7230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7230,1,3,0)
 ;;=3^Lesion of Ulnar Nerve,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,7230,1,4,0)
 ;;=4^G56.22
 ;;^UTILITY(U,$J,358.3,7230,2)
 ;;=^5004025
 ;;^UTILITY(U,$J,358.3,7231,0)
 ;;=L40.52^^58^473^140
 ;;^UTILITY(U,$J,358.3,7231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7231,1,3,0)
 ;;=3^Psoriatic Arthritis Mutilans
 ;;^UTILITY(U,$J,358.3,7231,1,4,0)
 ;;=4^L40.52
 ;;^UTILITY(U,$J,358.3,7231,2)
 ;;=^5009167
 ;;^UTILITY(U,$J,358.3,7232,0)
 ;;=L40.53^^58^473^141
 ;;^UTILITY(U,$J,358.3,7232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7232,1,3,0)
 ;;=3^Psoriatic Spondylitis
 ;;^UTILITY(U,$J,358.3,7232,1,4,0)
 ;;=4^L40.53
 ;;^UTILITY(U,$J,358.3,7232,2)
 ;;=^5009168
 ;;^UTILITY(U,$J,358.3,7233,0)
 ;;=M32.9^^58^473^182
 ;;^UTILITY(U,$J,358.3,7233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7233,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Unspec
 ;;^UTILITY(U,$J,358.3,7233,1,4,0)
 ;;=4^M32.9
 ;;^UTILITY(U,$J,358.3,7233,2)
 ;;=^5011761
 ;;^UTILITY(U,$J,358.3,7234,0)
 ;;=M32.0^^58^473^178
 ;;^UTILITY(U,$J,358.3,7234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7234,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Drug-Induced
 ;;^UTILITY(U,$J,358.3,7234,1,4,0)
 ;;=4^M32.0
 ;;^UTILITY(U,$J,358.3,7234,2)
 ;;=^5011752
 ;;^UTILITY(U,$J,358.3,7235,0)
 ;;=M32.13^^58^473^180
 ;;^UTILITY(U,$J,358.3,7235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7235,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Lung Involvement
 ;;^UTILITY(U,$J,358.3,7235,1,4,0)
 ;;=4^M32.13
 ;;^UTILITY(U,$J,358.3,7235,2)
 ;;=^5011756
 ;;^UTILITY(U,$J,358.3,7236,0)
 ;;=M32.14^^58^473^179
 ;;^UTILITY(U,$J,358.3,7236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7236,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Glomerular Disease
 ;;^UTILITY(U,$J,358.3,7236,1,4,0)
 ;;=4^M32.14
 ;;^UTILITY(U,$J,358.3,7236,2)
 ;;=^5011757
 ;;^UTILITY(U,$J,358.3,7237,0)
 ;;=M32.12^^58^473^181
 ;;^UTILITY(U,$J,358.3,7237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7237,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Pericarditis
 ;;^UTILITY(U,$J,358.3,7237,1,4,0)
 ;;=4^M32.12
 ;;^UTILITY(U,$J,358.3,7237,2)
 ;;=^5011755
 ;;^UTILITY(U,$J,358.3,7238,0)
 ;;=M05.59^^58^473^162
 ;;^UTILITY(U,$J,358.3,7238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7238,1,3,0)
 ;;=3^Rheumatoid Polyneuropathy w/ Rheumatoid Arthritis of Mult Sites
 ;;^UTILITY(U,$J,358.3,7238,1,4,0)
 ;;=4^M05.59
 ;;^UTILITY(U,$J,358.3,7238,2)
 ;;=^5009976
 ;;^UTILITY(U,$J,358.3,7239,0)
 ;;=M05.711^^58^473^156
 ;;^UTILITY(U,$J,358.3,7239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7239,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,7239,1,4,0)
 ;;=4^M05.711
