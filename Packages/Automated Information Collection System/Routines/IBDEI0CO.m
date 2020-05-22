IBDEI0CO ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31026,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Right Upper Limb
 ;;^UTILITY(U,$J,358.3,31026,1,4,0)
 ;;=4^G56.01
 ;;^UTILITY(U,$J,358.3,31026,2)
 ;;=^5004018
 ;;^UTILITY(U,$J,358.3,31027,0)
 ;;=G56.02^^92^1211^12
 ;;^UTILITY(U,$J,358.3,31027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31027,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,31027,1,4,0)
 ;;=4^G56.02
 ;;^UTILITY(U,$J,358.3,31027,2)
 ;;=^5004019
 ;;^UTILITY(U,$J,358.3,31028,0)
 ;;=G56.21^^92^1211^60
 ;;^UTILITY(U,$J,358.3,31028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31028,1,3,0)
 ;;=3^Lesion of Ulnar Nerve,Right Upper Limb
 ;;^UTILITY(U,$J,358.3,31028,1,4,0)
 ;;=4^G56.21
 ;;^UTILITY(U,$J,358.3,31028,2)
 ;;=^5004024
 ;;^UTILITY(U,$J,358.3,31029,0)
 ;;=G56.22^^92^1211^59
 ;;^UTILITY(U,$J,358.3,31029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31029,1,3,0)
 ;;=3^Lesion of Ulnar Nerve,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,31029,1,4,0)
 ;;=4^G56.22
 ;;^UTILITY(U,$J,358.3,31029,2)
 ;;=^5004025
 ;;^UTILITY(U,$J,358.3,31030,0)
 ;;=L40.52^^92^1211^143
 ;;^UTILITY(U,$J,358.3,31030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31030,1,3,0)
 ;;=3^Psoriatic Arthritis Mutilans
 ;;^UTILITY(U,$J,358.3,31030,1,4,0)
 ;;=4^L40.52
 ;;^UTILITY(U,$J,358.3,31030,2)
 ;;=^5009167
 ;;^UTILITY(U,$J,358.3,31031,0)
 ;;=L40.53^^92^1211^144
 ;;^UTILITY(U,$J,358.3,31031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31031,1,3,0)
 ;;=3^Psoriatic Spondylitis
 ;;^UTILITY(U,$J,358.3,31031,1,4,0)
 ;;=4^L40.53
 ;;^UTILITY(U,$J,358.3,31031,2)
 ;;=^5009168
 ;;^UTILITY(U,$J,358.3,31032,0)
 ;;=M32.9^^92^1211^187
 ;;^UTILITY(U,$J,358.3,31032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31032,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Unspec
 ;;^UTILITY(U,$J,358.3,31032,1,4,0)
 ;;=4^M32.9
 ;;^UTILITY(U,$J,358.3,31032,2)
 ;;=^5011761
 ;;^UTILITY(U,$J,358.3,31033,0)
 ;;=M32.0^^92^1211^183
 ;;^UTILITY(U,$J,358.3,31033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31033,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Drug-Induced
 ;;^UTILITY(U,$J,358.3,31033,1,4,0)
 ;;=4^M32.0
 ;;^UTILITY(U,$J,358.3,31033,2)
 ;;=^5011752
 ;;^UTILITY(U,$J,358.3,31034,0)
 ;;=M32.13^^92^1211^185
 ;;^UTILITY(U,$J,358.3,31034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31034,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Lung Involvement
 ;;^UTILITY(U,$J,358.3,31034,1,4,0)
 ;;=4^M32.13
 ;;^UTILITY(U,$J,358.3,31034,2)
 ;;=^5011756
 ;;^UTILITY(U,$J,358.3,31035,0)
 ;;=M32.14^^92^1211^184
 ;;^UTILITY(U,$J,358.3,31035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31035,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Glomerular Disease
 ;;^UTILITY(U,$J,358.3,31035,1,4,0)
 ;;=4^M32.14
 ;;^UTILITY(U,$J,358.3,31035,2)
 ;;=^5011757
 ;;^UTILITY(U,$J,358.3,31036,0)
 ;;=M32.12^^92^1211^186
 ;;^UTILITY(U,$J,358.3,31036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31036,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Pericarditis
 ;;^UTILITY(U,$J,358.3,31036,1,4,0)
 ;;=4^M32.12
 ;;^UTILITY(U,$J,358.3,31036,2)
 ;;=^5011755
 ;;^UTILITY(U,$J,358.3,31037,0)
 ;;=M05.59^^92^1211^165
 ;;^UTILITY(U,$J,358.3,31037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31037,1,3,0)
 ;;=3^Rheumatoid Polyneuropathy w/ Rheumatoid Arthritis of Mult Sites
 ;;^UTILITY(U,$J,358.3,31037,1,4,0)
 ;;=4^M05.59
 ;;^UTILITY(U,$J,358.3,31037,2)
 ;;=^5009976
 ;;^UTILITY(U,$J,358.3,31038,0)
 ;;=M05.711^^92^1211^159
 ;;^UTILITY(U,$J,358.3,31038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31038,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,31038,1,4,0)
 ;;=4^M05.711
 ;;^UTILITY(U,$J,358.3,31038,2)
 ;;=^5010001
 ;;^UTILITY(U,$J,358.3,31039,0)
 ;;=M05.712^^92^1211^152
 ;;^UTILITY(U,$J,358.3,31039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31039,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,31039,1,4,0)
 ;;=4^M05.712
 ;;^UTILITY(U,$J,358.3,31039,2)
 ;;=^5010002
 ;;^UTILITY(U,$J,358.3,31040,0)
 ;;=M05.731^^92^1211^160
 ;;^UTILITY(U,$J,358.3,31040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31040,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Wrist
 ;;^UTILITY(U,$J,358.3,31040,1,4,0)
 ;;=4^M05.731
 ;;^UTILITY(U,$J,358.3,31040,2)
 ;;=^5010007
 ;;^UTILITY(U,$J,358.3,31041,0)
 ;;=M05.732^^92^1211^153
 ;;^UTILITY(U,$J,358.3,31041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31041,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Wrist
 ;;^UTILITY(U,$J,358.3,31041,1,4,0)
 ;;=4^M05.732
 ;;^UTILITY(U,$J,358.3,31041,2)
 ;;=^5010008
 ;;^UTILITY(U,$J,358.3,31042,0)
 ;;=M05.741^^92^1211^156
 ;;^UTILITY(U,$J,358.3,31042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31042,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,31042,1,4,0)
 ;;=4^M05.741
 ;;^UTILITY(U,$J,358.3,31042,2)
 ;;=^5010010
 ;;^UTILITY(U,$J,358.3,31043,0)
 ;;=M05.742^^92^1211^149
 ;;^UTILITY(U,$J,358.3,31043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31043,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,31043,1,4,0)
 ;;=4^M05.742
 ;;^UTILITY(U,$J,358.3,31043,2)
 ;;=^5010011
 ;;^UTILITY(U,$J,358.3,31044,0)
 ;;=M05.751^^92^1211^157
 ;;^UTILITY(U,$J,358.3,31044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31044,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Hip
 ;;^UTILITY(U,$J,358.3,31044,1,4,0)
 ;;=4^M05.751
 ;;^UTILITY(U,$J,358.3,31044,2)
 ;;=^5010013
 ;;^UTILITY(U,$J,358.3,31045,0)
 ;;=M05.752^^92^1211^150
 ;;^UTILITY(U,$J,358.3,31045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31045,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Hip
 ;;^UTILITY(U,$J,358.3,31045,1,4,0)
 ;;=4^M05.752
 ;;^UTILITY(U,$J,358.3,31045,2)
 ;;=^5010014
 ;;^UTILITY(U,$J,358.3,31046,0)
 ;;=M05.761^^92^1211^158
 ;;^UTILITY(U,$J,358.3,31046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31046,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Knee
 ;;^UTILITY(U,$J,358.3,31046,1,4,0)
 ;;=4^M05.761
 ;;^UTILITY(U,$J,358.3,31046,2)
 ;;=^5010016
 ;;^UTILITY(U,$J,358.3,31047,0)
 ;;=M05.762^^92^1211^151
 ;;^UTILITY(U,$J,358.3,31047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31047,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Knee
 ;;^UTILITY(U,$J,358.3,31047,1,4,0)
 ;;=4^M05.762
 ;;^UTILITY(U,$J,358.3,31047,2)
 ;;=^5010017
 ;;^UTILITY(U,$J,358.3,31048,0)
 ;;=M05.771^^92^1211^155
 ;;^UTILITY(U,$J,358.3,31048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31048,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Ankle
 ;;^UTILITY(U,$J,358.3,31048,1,4,0)
 ;;=4^M05.771
 ;;^UTILITY(U,$J,358.3,31048,2)
 ;;=^5010019
 ;;^UTILITY(U,$J,358.3,31049,0)
 ;;=M05.772^^92^1211^148
 ;;^UTILITY(U,$J,358.3,31049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31049,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Ankle
 ;;^UTILITY(U,$J,358.3,31049,1,4,0)
 ;;=4^M05.772
 ;;^UTILITY(U,$J,358.3,31049,2)
 ;;=^5010020
 ;;^UTILITY(U,$J,358.3,31050,0)
 ;;=M05.79^^92^1211^154
 ;;^UTILITY(U,$J,358.3,31050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31050,1,3,0)
 ;;=3^Rheumatoid Arthritis of Multiple Sites
 ;;^UTILITY(U,$J,358.3,31050,1,4,0)
 ;;=4^M05.79
 ;;^UTILITY(U,$J,358.3,31050,2)
 ;;=^5010022
 ;;^UTILITY(U,$J,358.3,31051,0)
 ;;=M06.00^^92^1211^161
 ;;^UTILITY(U,$J,358.3,31051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31051,1,3,0)
 ;;=3^Rheumatoid Arthritis w/o Rhematoid Factor,Unspec Site
 ;;^UTILITY(U,$J,358.3,31051,1,4,0)
 ;;=4^M06.00
 ;;^UTILITY(U,$J,358.3,31051,2)
 ;;=^5010047
 ;;^UTILITY(U,$J,358.3,31052,0)
 ;;=M06.30^^92^1211^164
 ;;^UTILITY(U,$J,358.3,31052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31052,1,3,0)
 ;;=3^Rheumatoid Nodule,Unspec Site
 ;;^UTILITY(U,$J,358.3,31052,1,4,0)
 ;;=4^M06.30
 ;;^UTILITY(U,$J,358.3,31052,2)
 ;;=^5010096
 ;;^UTILITY(U,$J,358.3,31053,0)
 ;;=M06.4^^92^1211^51
 ;;^UTILITY(U,$J,358.3,31053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31053,1,3,0)
 ;;=3^Inflammatory Polyarthropathy
 ;;^UTILITY(U,$J,358.3,31053,1,4,0)
 ;;=4^M06.4
 ;;^UTILITY(U,$J,358.3,31053,2)
 ;;=^5010120
 ;;^UTILITY(U,$J,358.3,31054,0)
 ;;=M06.39^^92^1211^163
 ;;^UTILITY(U,$J,358.3,31054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31054,1,3,0)
 ;;=3^Rheumatoid Nodule,Mult Sites
 ;;^UTILITY(U,$J,358.3,31054,1,4,0)
 ;;=4^M06.39
 ;;^UTILITY(U,$J,358.3,31054,2)
 ;;=^5010119
 ;;^UTILITY(U,$J,358.3,31055,0)
 ;;=M15.0^^92^1211^127
 ;;^UTILITY(U,$J,358.3,31055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31055,1,3,0)
 ;;=3^Primary Generalized Osteoarthritis
 ;;^UTILITY(U,$J,358.3,31055,1,4,0)
 ;;=4^M15.0
 ;;^UTILITY(U,$J,358.3,31055,2)
 ;;=^5010762
 ;;^UTILITY(U,$J,358.3,31056,0)
 ;;=M06.9^^92^1211^162
 ;;^UTILITY(U,$J,358.3,31056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31056,1,3,0)
 ;;=3^Rheumatoid Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,31056,1,4,0)
 ;;=4^M06.9
 ;;^UTILITY(U,$J,358.3,31056,2)
 ;;=^5010145
 ;;^UTILITY(U,$J,358.3,31057,0)
 ;;=M16.0^^92^1211^130
 ;;^UTILITY(U,$J,358.3,31057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31057,1,3,0)
 ;;=3^Primary Osteoarthritis of Hip,Bilateral
 ;;^UTILITY(U,$J,358.3,31057,1,4,0)
 ;;=4^M16.0
 ;;^UTILITY(U,$J,358.3,31057,2)
 ;;=^5010769
 ;;^UTILITY(U,$J,358.3,31058,0)
 ;;=M16.11^^92^1211^139
 ;;^UTILITY(U,$J,358.3,31058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31058,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hip
 ;;^UTILITY(U,$J,358.3,31058,1,4,0)
 ;;=4^M16.11
 ;;^UTILITY(U,$J,358.3,31058,2)
 ;;=^5010771
 ;;^UTILITY(U,$J,358.3,31059,0)
 ;;=M16.12^^92^1211^133
 ;;^UTILITY(U,$J,358.3,31059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31059,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hip
 ;;^UTILITY(U,$J,358.3,31059,1,4,0)
 ;;=4^M16.12
 ;;^UTILITY(U,$J,358.3,31059,2)
 ;;=^5010772
 ;;^UTILITY(U,$J,358.3,31060,0)
 ;;=M17.0^^92^1211^129
 ;;^UTILITY(U,$J,358.3,31060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31060,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral Knees
 ;;^UTILITY(U,$J,358.3,31060,1,4,0)
 ;;=4^M17.0
 ;;^UTILITY(U,$J,358.3,31060,2)
 ;;=^5010784
 ;;^UTILITY(U,$J,358.3,31061,0)
 ;;=M17.11^^92^1211^140
 ;;^UTILITY(U,$J,358.3,31061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31061,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Knee
 ;;^UTILITY(U,$J,358.3,31061,1,4,0)
 ;;=4^M17.11
 ;;^UTILITY(U,$J,358.3,31061,2)
 ;;=^5010786
 ;;^UTILITY(U,$J,358.3,31062,0)
 ;;=M17.12^^92^1211^134
 ;;^UTILITY(U,$J,358.3,31062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31062,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Knee
 ;;^UTILITY(U,$J,358.3,31062,1,4,0)
 ;;=4^M17.12
 ;;^UTILITY(U,$J,358.3,31062,2)
 ;;=^5010787
 ;;^UTILITY(U,$J,358.3,31063,0)
 ;;=M18.0^^92^1211^128
 ;;^UTILITY(U,$J,358.3,31063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31063,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral 1st Carpometacarp Jts
 ;;^UTILITY(U,$J,358.3,31063,1,4,0)
 ;;=4^M18.0
 ;;^UTILITY(U,$J,358.3,31063,2)
 ;;=^5010795
 ;;^UTILITY(U,$J,358.3,31064,0)
 ;;=M18.11^^92^1211^138
 ;;^UTILITY(U,$J,358.3,31064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31064,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,31064,1,4,0)
 ;;=4^M18.11
 ;;^UTILITY(U,$J,358.3,31064,2)
 ;;=^5010797
 ;;^UTILITY(U,$J,358.3,31065,0)
 ;;=M18.12^^92^1211^132
 ;;^UTILITY(U,$J,358.3,31065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31065,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,31065,1,4,0)
 ;;=4^M18.12
 ;;^UTILITY(U,$J,358.3,31065,2)
 ;;=^5010798
 ;;^UTILITY(U,$J,358.3,31066,0)
 ;;=M19.011^^92^1211^141
 ;;^UTILITY(U,$J,358.3,31066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31066,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,31066,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,31066,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,31067,0)
 ;;=M19.012^^92^1211^135
 ;;^UTILITY(U,$J,358.3,31067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31067,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,31067,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,31067,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,31068,0)
 ;;=M19.031^^92^1211^142
 ;;^UTILITY(U,$J,358.3,31068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31068,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Wrist
 ;;^UTILITY(U,$J,358.3,31068,1,4,0)
 ;;=4^M19.031
 ;;^UTILITY(U,$J,358.3,31068,2)
 ;;=^5010814
 ;;^UTILITY(U,$J,358.3,31069,0)
 ;;=M19.032^^92^1211^136
 ;;^UTILITY(U,$J,358.3,31069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31069,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Wrist
 ;;^UTILITY(U,$J,358.3,31069,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,31069,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,31070,0)
 ;;=M19.041^^92^1211^137
 ;;^UTILITY(U,$J,358.3,31070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31070,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,31070,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,31070,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,31071,0)
 ;;=M19.042^^92^1211^131
 ;;^UTILITY(U,$J,358.3,31071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31071,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,31071,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,31071,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,31072,0)
 ;;=M19.90^^92^1211^72
 ;;^UTILITY(U,$J,358.3,31072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31072,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,31072,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,31072,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,31073,0)
 ;;=M25.40^^92^1211^38
 ;;^UTILITY(U,$J,358.3,31073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31073,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,31073,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,31073,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,31074,0)
 ;;=M45.0^^92^1211^6
 ;;^UTILITY(U,$J,358.3,31074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31074,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,31074,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,31074,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,31075,0)
 ;;=M45.2^^92^1211^3
 ;;^UTILITY(U,$J,358.3,31075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31075,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,31075,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,31075,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,31076,0)
 ;;=M45.4^^92^1211^7
 ;;^UTILITY(U,$J,358.3,31076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31076,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,31076,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,31076,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,31077,0)
 ;;=M45.7^^92^1211^4
 ;;^UTILITY(U,$J,358.3,31077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31077,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,31077,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,31077,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,31078,0)
 ;;=M45.8^^92^1211^5
 ;;^UTILITY(U,$J,358.3,31078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31078,1,3,0)
 ;;=3^Ankylosing Spondylitis of Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,31078,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,31078,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,31079,0)
 ;;=M47.22^^92^1211^180
 ;;^UTILITY(U,$J,358.3,31079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31079,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,31079,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,31079,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,31080,0)
 ;;=M47.24^^92^1211^182
 ;;^UTILITY(U,$J,358.3,31080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31080,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Thoracic Region NEC
 ;;^UTILITY(U,$J,358.3,31080,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,31080,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,31081,0)
 ;;=M47.27^^92^1211^181
 ;;^UTILITY(U,$J,358.3,31081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31081,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Lumbosacral Region NEC
 ;;^UTILITY(U,$J,358.3,31081,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,31081,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,31082,0)
 ;;=M47.812^^92^1211^177
 ;;^UTILITY(U,$J,358.3,31082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31082,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,31082,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,31082,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,31083,0)
 ;;=M47.814^^92^1211^178
 ;;^UTILITY(U,$J,358.3,31083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31083,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,31083,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,31083,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,31084,0)
 ;;=M47.817^^92^1211^179
 ;;^UTILITY(U,$J,358.3,31084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31084,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,31084,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,31084,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,31085,0)
 ;;=M48.50XA^^92^1211^22
 ;;^UTILITY(U,$J,358.3,31085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31085,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,31085,1,4,0)
 ;;=4^M48.50XA
 ;;^UTILITY(U,$J,358.3,31085,2)
 ;;=^5012159
 ;;^UTILITY(U,$J,358.3,31086,0)
 ;;=M48.50XD^^92^1211^23
 ;;^UTILITY(U,$J,358.3,31086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31086,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31086,1,4,0)
 ;;=4^M48.50XD
 ;;^UTILITY(U,$J,358.3,31086,2)
 ;;=^5012160
 ;;^UTILITY(U,$J,358.3,31087,0)
 ;;=M48.52XA^^92^1211^24
 ;;^UTILITY(U,$J,358.3,31087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31087,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,31087,1,4,0)
 ;;=4^M48.52XA
 ;;^UTILITY(U,$J,358.3,31087,2)
 ;;=^5012167
 ;;^UTILITY(U,$J,358.3,31088,0)
 ;;=M48.52XD^^92^1211^25
 ;;^UTILITY(U,$J,358.3,31088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31088,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Subs Encntr,Rt Healing
 ;;^UTILITY(U,$J,358.3,31088,1,4,0)
 ;;=4^M48.52XD
 ;;^UTILITY(U,$J,358.3,31088,2)
 ;;=^5012168
 ;;^UTILITY(U,$J,358.3,31089,0)
 ;;=M48.54XA^^92^1211^33
 ;;^UTILITY(U,$J,358.3,31089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31089,1,3,0)
 ;;=3^Collapsed Vertebra,Throacic Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,31089,1,4,0)
 ;;=4^M48.54XA
 ;;^UTILITY(U,$J,358.3,31089,2)
 ;;=^5012175
 ;;^UTILITY(U,$J,358.3,31090,0)
 ;;=M48.54XD^^92^1211^34
 ;;^UTILITY(U,$J,358.3,31090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31090,1,3,0)
 ;;=3^Collapsed Vertebra,Throacic Region,Subs Encntr
 ;;^UTILITY(U,$J,358.3,31090,1,4,0)
 ;;=4^M48.54XD
 ;;^UTILITY(U,$J,358.3,31090,2)
 ;;=^5012176
 ;;^UTILITY(U,$J,358.3,31091,0)
 ;;=M48.57XA^^92^1211^26
 ;;^UTILITY(U,$J,358.3,31091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31091,1,3,0)
 ;;=3^Collapsed Vertebra,Lumbosacral Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,31091,1,4,0)
 ;;=4^M48.57XA
 ;;^UTILITY(U,$J,358.3,31091,2)
 ;;=^5012187
 ;;^UTILITY(U,$J,358.3,31092,0)
 ;;=M48.57XD^^92^1211^27
