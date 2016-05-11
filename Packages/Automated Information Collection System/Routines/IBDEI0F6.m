IBDEI0F6 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6995,1,4,0)
 ;;=4^M26.60
 ;;^UTILITY(U,$J,358.3,6995,2)
 ;;=^5011714
 ;;^UTILITY(U,$J,358.3,6996,0)
 ;;=L40.52^^30^402^128
 ;;^UTILITY(U,$J,358.3,6996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6996,1,3,0)
 ;;=3^Psoriatic Arthritis Mutilans
 ;;^UTILITY(U,$J,358.3,6996,1,4,0)
 ;;=4^L40.52
 ;;^UTILITY(U,$J,358.3,6996,2)
 ;;=^5009167
 ;;^UTILITY(U,$J,358.3,6997,0)
 ;;=L40.53^^30^402^129
 ;;^UTILITY(U,$J,358.3,6997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6997,1,3,0)
 ;;=3^Psoriatic Spondylitis
 ;;^UTILITY(U,$J,358.3,6997,1,4,0)
 ;;=4^L40.53
 ;;^UTILITY(U,$J,358.3,6997,2)
 ;;=^5009168
 ;;^UTILITY(U,$J,358.3,6998,0)
 ;;=M32.9^^30^402^170
 ;;^UTILITY(U,$J,358.3,6998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6998,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Unspec
 ;;^UTILITY(U,$J,358.3,6998,1,4,0)
 ;;=4^M32.9
 ;;^UTILITY(U,$J,358.3,6998,2)
 ;;=^5011761
 ;;^UTILITY(U,$J,358.3,6999,0)
 ;;=M32.0^^30^402^166
 ;;^UTILITY(U,$J,358.3,6999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6999,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Drug-Induced
 ;;^UTILITY(U,$J,358.3,6999,1,4,0)
 ;;=4^M32.0
 ;;^UTILITY(U,$J,358.3,6999,2)
 ;;=^5011752
 ;;^UTILITY(U,$J,358.3,7000,0)
 ;;=M32.13^^30^402^168
 ;;^UTILITY(U,$J,358.3,7000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7000,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Lung Involvement
 ;;^UTILITY(U,$J,358.3,7000,1,4,0)
 ;;=4^M32.13
 ;;^UTILITY(U,$J,358.3,7000,2)
 ;;=^5011756
 ;;^UTILITY(U,$J,358.3,7001,0)
 ;;=M32.14^^30^402^167
 ;;^UTILITY(U,$J,358.3,7001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7001,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Glomerular Disease
 ;;^UTILITY(U,$J,358.3,7001,1,4,0)
 ;;=4^M32.14
 ;;^UTILITY(U,$J,358.3,7001,2)
 ;;=^5011757
 ;;^UTILITY(U,$J,358.3,7002,0)
 ;;=M32.12^^30^402^169
 ;;^UTILITY(U,$J,358.3,7002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7002,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Pericarditis
 ;;^UTILITY(U,$J,358.3,7002,1,4,0)
 ;;=4^M32.12
 ;;^UTILITY(U,$J,358.3,7002,2)
 ;;=^5011755
 ;;^UTILITY(U,$J,358.3,7003,0)
 ;;=M05.59^^30^402^150
 ;;^UTILITY(U,$J,358.3,7003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7003,1,3,0)
 ;;=3^Rheumatoid Polyneuropathy w/ Rheumatoid Arthritis of Mult Sites
 ;;^UTILITY(U,$J,358.3,7003,1,4,0)
 ;;=4^M05.59
 ;;^UTILITY(U,$J,358.3,7003,2)
 ;;=^5009976
 ;;^UTILITY(U,$J,358.3,7004,0)
 ;;=M05.711^^30^402^144
 ;;^UTILITY(U,$J,358.3,7004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7004,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,7004,1,4,0)
 ;;=4^M05.711
 ;;^UTILITY(U,$J,358.3,7004,2)
 ;;=^5010001
 ;;^UTILITY(U,$J,358.3,7005,0)
 ;;=M05.712^^30^402^137
 ;;^UTILITY(U,$J,358.3,7005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7005,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,7005,1,4,0)
 ;;=4^M05.712
 ;;^UTILITY(U,$J,358.3,7005,2)
 ;;=^5010002
 ;;^UTILITY(U,$J,358.3,7006,0)
 ;;=M05.731^^30^402^145
 ;;^UTILITY(U,$J,358.3,7006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7006,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Wrist
 ;;^UTILITY(U,$J,358.3,7006,1,4,0)
 ;;=4^M05.731
 ;;^UTILITY(U,$J,358.3,7006,2)
 ;;=^5010007
 ;;^UTILITY(U,$J,358.3,7007,0)
 ;;=M05.732^^30^402^138
 ;;^UTILITY(U,$J,358.3,7007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7007,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Wrist
 ;;^UTILITY(U,$J,358.3,7007,1,4,0)
 ;;=4^M05.732
 ;;^UTILITY(U,$J,358.3,7007,2)
 ;;=^5010008
 ;;^UTILITY(U,$J,358.3,7008,0)
 ;;=M05.741^^30^402^141
 ;;^UTILITY(U,$J,358.3,7008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7008,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Hand
