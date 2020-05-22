IBDEI01H ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3117,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,3118,0)
 ;;=F45.9^^28^231^30
 ;;^UTILITY(U,$J,358.3,3118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3118,1,3,0)
 ;;=3^Somatoform Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3118,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,3118,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,3119,0)
 ;;=F48.2^^28^231^24
 ;;^UTILITY(U,$J,358.3,3119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3119,1,3,0)
 ;;=3^Pseudobulbar Affect
 ;;^UTILITY(U,$J,358.3,3119,1,4,0)
 ;;=4^F48.2
 ;;^UTILITY(U,$J,358.3,3119,2)
 ;;=^5003594
 ;;^UTILITY(U,$J,358.3,3120,0)
 ;;=G47.00^^28^231^13
 ;;^UTILITY(U,$J,358.3,3120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3120,1,3,0)
 ;;=3^Insomnia,Unspec
 ;;^UTILITY(U,$J,358.3,3120,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,3120,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,3121,0)
 ;;=F40.11^^28^231^28
 ;;^UTILITY(U,$J,358.3,3121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3121,1,3,0)
 ;;=3^Social Phobia,Generalized
 ;;^UTILITY(U,$J,358.3,3121,1,4,0)
 ;;=4^F40.11
 ;;^UTILITY(U,$J,358.3,3121,2)
 ;;=^5003545
 ;;^UTILITY(U,$J,358.3,3122,0)
 ;;=F06.31^^28^231^16
 ;;^UTILITY(U,$J,358.3,3122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3122,1,3,0)
 ;;=3^Mood Disorder d/t Physiological Cond w/ Depressive Features
 ;;^UTILITY(U,$J,358.3,3122,1,4,0)
 ;;=4^F06.31
 ;;^UTILITY(U,$J,358.3,3122,2)
 ;;=^5003057
 ;;^UTILITY(U,$J,358.3,3123,0)
 ;;=F20.0^^28^231^22
 ;;^UTILITY(U,$J,358.3,3123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3123,1,3,0)
 ;;=3^Paranoid Schizophrenia
 ;;^UTILITY(U,$J,358.3,3123,1,4,0)
 ;;=4^F20.0
 ;;^UTILITY(U,$J,358.3,3123,2)
 ;;=^5003469
 ;;^UTILITY(U,$J,358.3,3124,0)
 ;;=F42.2^^28^231^15
 ;;^UTILITY(U,$J,358.3,3124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3124,1,3,0)
 ;;=3^Mixed Obsessional Thoughts & Acts
 ;;^UTILITY(U,$J,358.3,3124,1,4,0)
 ;;=4^F42.2
 ;;^UTILITY(U,$J,358.3,3124,2)
 ;;=^5138444
 ;;^UTILITY(U,$J,358.3,3125,0)
 ;;=F42.3^^28^231^12
 ;;^UTILITY(U,$J,358.3,3125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3125,1,3,0)
 ;;=3^Hoarding Disorder
 ;;^UTILITY(U,$J,358.3,3125,1,4,0)
 ;;=4^F42.3
 ;;^UTILITY(U,$J,358.3,3125,2)
 ;;=^5138445
 ;;^UTILITY(U,$J,358.3,3126,0)
 ;;=F42.4^^28^231^9
 ;;^UTILITY(U,$J,358.3,3126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3126,1,3,0)
 ;;=3^Excoriation Disorder
 ;;^UTILITY(U,$J,358.3,3126,1,4,0)
 ;;=4^F42.4
 ;;^UTILITY(U,$J,358.3,3126,2)
 ;;=^5138446
 ;;^UTILITY(U,$J,358.3,3127,0)
 ;;=F42.8^^28^231^17
 ;;^UTILITY(U,$J,358.3,3127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3127,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder,Other
 ;;^UTILITY(U,$J,358.3,3127,1,4,0)
 ;;=4^F42.8
 ;;^UTILITY(U,$J,358.3,3127,2)
 ;;=^5138447
 ;;^UTILITY(U,$J,358.3,3128,0)
 ;;=F42.9^^28^231^18
 ;;^UTILITY(U,$J,358.3,3128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3128,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3128,1,4,0)
 ;;=4^F42.9
 ;;^UTILITY(U,$J,358.3,3128,2)
 ;;=^5138448
 ;;^UTILITY(U,$J,358.3,3129,0)
 ;;=M02.30^^28^232^144
 ;;^UTILITY(U,$J,358.3,3129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3129,1,3,0)
 ;;=3^Reiter's Disease,Unspec Site
 ;;^UTILITY(U,$J,358.3,3129,1,4,0)
 ;;=4^M02.30
 ;;^UTILITY(U,$J,358.3,3129,2)
 ;;=^5009790
 ;;^UTILITY(U,$J,358.3,3130,0)
 ;;=M10.9^^28^232^40
 ;;^UTILITY(U,$J,358.3,3130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3130,1,3,0)
 ;;=3^Gout,Unspec
 ;;^UTILITY(U,$J,358.3,3130,1,4,0)
 ;;=4^M10.9
 ;;^UTILITY(U,$J,358.3,3130,2)
 ;;=^5010404
 ;;^UTILITY(U,$J,358.3,3131,0)
 ;;=G90.59^^28^232^34
 ;;^UTILITY(U,$J,358.3,3131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3131,1,3,0)
 ;;=3^Complex Regional Pain Syndrome I,Unspec
 ;;^UTILITY(U,$J,358.3,3131,1,4,0)
 ;;=4^G90.59
 ;;^UTILITY(U,$J,358.3,3131,2)
 ;;=^5004171
 ;;^UTILITY(U,$J,358.3,3132,0)
 ;;=G56.01^^28^232^12
 ;;^UTILITY(U,$J,358.3,3132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3132,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Right Upper Limb
 ;;^UTILITY(U,$J,358.3,3132,1,4,0)
 ;;=4^G56.01
 ;;^UTILITY(U,$J,358.3,3132,2)
 ;;=^5004018
 ;;^UTILITY(U,$J,358.3,3133,0)
 ;;=G56.02^^28^232^11
 ;;^UTILITY(U,$J,358.3,3133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3133,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,3133,1,4,0)
 ;;=4^G56.02
 ;;^UTILITY(U,$J,358.3,3133,2)
 ;;=^5004019
 ;;^UTILITY(U,$J,358.3,3134,0)
 ;;=G56.21^^28^232^56
 ;;^UTILITY(U,$J,358.3,3134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3134,1,3,0)
 ;;=3^Lesion of Ulnar Nerve,Right Upper Limb
 ;;^UTILITY(U,$J,358.3,3134,1,4,0)
 ;;=4^G56.21
 ;;^UTILITY(U,$J,358.3,3134,2)
 ;;=^5004024
 ;;^UTILITY(U,$J,358.3,3135,0)
 ;;=G56.22^^28^232^55
 ;;^UTILITY(U,$J,358.3,3135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3135,1,3,0)
 ;;=3^Lesion of Ulnar Nerve,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,3135,1,4,0)
 ;;=4^G56.22
 ;;^UTILITY(U,$J,358.3,3135,2)
 ;;=^5004025
 ;;^UTILITY(U,$J,358.3,3136,0)
 ;;=L40.52^^28^232^140
 ;;^UTILITY(U,$J,358.3,3136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3136,1,3,0)
 ;;=3^Psoriatic Arthritis Mutilans
 ;;^UTILITY(U,$J,358.3,3136,1,4,0)
 ;;=4^L40.52
 ;;^UTILITY(U,$J,358.3,3136,2)
 ;;=^5009167
 ;;^UTILITY(U,$J,358.3,3137,0)
 ;;=L40.53^^28^232^141
 ;;^UTILITY(U,$J,358.3,3137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3137,1,3,0)
 ;;=3^Psoriatic Spondylitis
 ;;^UTILITY(U,$J,358.3,3137,1,4,0)
 ;;=4^L40.53
 ;;^UTILITY(U,$J,358.3,3137,2)
 ;;=^5009168
 ;;^UTILITY(U,$J,358.3,3138,0)
 ;;=M32.9^^28^232^182
 ;;^UTILITY(U,$J,358.3,3138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3138,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Unspec
 ;;^UTILITY(U,$J,358.3,3138,1,4,0)
 ;;=4^M32.9
 ;;^UTILITY(U,$J,358.3,3138,2)
 ;;=^5011761
 ;;^UTILITY(U,$J,358.3,3139,0)
 ;;=M32.0^^28^232^178
 ;;^UTILITY(U,$J,358.3,3139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3139,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Drug-Induced
 ;;^UTILITY(U,$J,358.3,3139,1,4,0)
 ;;=4^M32.0
 ;;^UTILITY(U,$J,358.3,3139,2)
 ;;=^5011752
 ;;^UTILITY(U,$J,358.3,3140,0)
 ;;=M32.13^^28^232^180
 ;;^UTILITY(U,$J,358.3,3140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3140,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Lung Involvement
 ;;^UTILITY(U,$J,358.3,3140,1,4,0)
 ;;=4^M32.13
 ;;^UTILITY(U,$J,358.3,3140,2)
 ;;=^5011756
 ;;^UTILITY(U,$J,358.3,3141,0)
 ;;=M32.14^^28^232^179
 ;;^UTILITY(U,$J,358.3,3141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3141,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Glomerular Disease
 ;;^UTILITY(U,$J,358.3,3141,1,4,0)
 ;;=4^M32.14
 ;;^UTILITY(U,$J,358.3,3141,2)
 ;;=^5011757
 ;;^UTILITY(U,$J,358.3,3142,0)
 ;;=M32.12^^28^232^181
 ;;^UTILITY(U,$J,358.3,3142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3142,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Pericarditis
 ;;^UTILITY(U,$J,358.3,3142,1,4,0)
 ;;=4^M32.12
 ;;^UTILITY(U,$J,358.3,3142,2)
 ;;=^5011755
 ;;^UTILITY(U,$J,358.3,3143,0)
 ;;=M05.59^^28^232^162
 ;;^UTILITY(U,$J,358.3,3143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3143,1,3,0)
 ;;=3^Rheumatoid Polyneuropathy w/ Rheumatoid Arthritis of Mult Sites
 ;;^UTILITY(U,$J,358.3,3143,1,4,0)
 ;;=4^M05.59
 ;;^UTILITY(U,$J,358.3,3143,2)
 ;;=^5009976
 ;;^UTILITY(U,$J,358.3,3144,0)
 ;;=M05.711^^28^232^156
 ;;^UTILITY(U,$J,358.3,3144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3144,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,3144,1,4,0)
 ;;=4^M05.711
 ;;^UTILITY(U,$J,358.3,3144,2)
 ;;=^5010001
 ;;^UTILITY(U,$J,358.3,3145,0)
 ;;=M05.712^^28^232^149
 ;;^UTILITY(U,$J,358.3,3145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3145,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,3145,1,4,0)
 ;;=4^M05.712
 ;;^UTILITY(U,$J,358.3,3145,2)
 ;;=^5010002
 ;;^UTILITY(U,$J,358.3,3146,0)
 ;;=M05.731^^28^232^157
 ;;^UTILITY(U,$J,358.3,3146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3146,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Wrist
 ;;^UTILITY(U,$J,358.3,3146,1,4,0)
 ;;=4^M05.731
 ;;^UTILITY(U,$J,358.3,3146,2)
 ;;=^5010007
 ;;^UTILITY(U,$J,358.3,3147,0)
 ;;=M05.732^^28^232^150
 ;;^UTILITY(U,$J,358.3,3147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3147,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Wrist
 ;;^UTILITY(U,$J,358.3,3147,1,4,0)
 ;;=4^M05.732
 ;;^UTILITY(U,$J,358.3,3147,2)
 ;;=^5010008
 ;;^UTILITY(U,$J,358.3,3148,0)
 ;;=M05.741^^28^232^153
 ;;^UTILITY(U,$J,358.3,3148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3148,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,3148,1,4,0)
 ;;=4^M05.741
 ;;^UTILITY(U,$J,358.3,3148,2)
 ;;=^5010010
 ;;^UTILITY(U,$J,358.3,3149,0)
 ;;=M05.742^^28^232^146
 ;;^UTILITY(U,$J,358.3,3149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3149,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,3149,1,4,0)
 ;;=4^M05.742
 ;;^UTILITY(U,$J,358.3,3149,2)
 ;;=^5010011
 ;;^UTILITY(U,$J,358.3,3150,0)
 ;;=M05.751^^28^232^154
 ;;^UTILITY(U,$J,358.3,3150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3150,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Hip
 ;;^UTILITY(U,$J,358.3,3150,1,4,0)
 ;;=4^M05.751
 ;;^UTILITY(U,$J,358.3,3150,2)
 ;;=^5010013
 ;;^UTILITY(U,$J,358.3,3151,0)
 ;;=M05.752^^28^232^147
 ;;^UTILITY(U,$J,358.3,3151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3151,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Hip
 ;;^UTILITY(U,$J,358.3,3151,1,4,0)
 ;;=4^M05.752
 ;;^UTILITY(U,$J,358.3,3151,2)
 ;;=^5010014
 ;;^UTILITY(U,$J,358.3,3152,0)
 ;;=M05.761^^28^232^155
 ;;^UTILITY(U,$J,358.3,3152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3152,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Knee
 ;;^UTILITY(U,$J,358.3,3152,1,4,0)
 ;;=4^M05.761
 ;;^UTILITY(U,$J,358.3,3152,2)
 ;;=^5010016
 ;;^UTILITY(U,$J,358.3,3153,0)
 ;;=M05.762^^28^232^148
 ;;^UTILITY(U,$J,358.3,3153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3153,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Knee
 ;;^UTILITY(U,$J,358.3,3153,1,4,0)
 ;;=4^M05.762
 ;;^UTILITY(U,$J,358.3,3153,2)
 ;;=^5010017
 ;;^UTILITY(U,$J,358.3,3154,0)
 ;;=M05.771^^28^232^152
 ;;^UTILITY(U,$J,358.3,3154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3154,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Ankle
 ;;^UTILITY(U,$J,358.3,3154,1,4,0)
 ;;=4^M05.771
 ;;^UTILITY(U,$J,358.3,3154,2)
 ;;=^5010019
 ;;^UTILITY(U,$J,358.3,3155,0)
 ;;=M05.772^^28^232^145
 ;;^UTILITY(U,$J,358.3,3155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3155,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Ankle
 ;;^UTILITY(U,$J,358.3,3155,1,4,0)
 ;;=4^M05.772
 ;;^UTILITY(U,$J,358.3,3155,2)
 ;;=^5010020
 ;;^UTILITY(U,$J,358.3,3156,0)
 ;;=M05.79^^28^232^151
 ;;^UTILITY(U,$J,358.3,3156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3156,1,3,0)
 ;;=3^Rheumatoid Arthritis of Multiple Sites
 ;;^UTILITY(U,$J,358.3,3156,1,4,0)
 ;;=4^M05.79
 ;;^UTILITY(U,$J,358.3,3156,2)
 ;;=^5010022
 ;;^UTILITY(U,$J,358.3,3157,0)
 ;;=M06.00^^28^232^158
 ;;^UTILITY(U,$J,358.3,3157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3157,1,3,0)
 ;;=3^Rheumatoid Arthritis w/o Rhematoid Factor,Unspec Site
 ;;^UTILITY(U,$J,358.3,3157,1,4,0)
 ;;=4^M06.00
 ;;^UTILITY(U,$J,358.3,3157,2)
 ;;=^5010047
 ;;^UTILITY(U,$J,358.3,3158,0)
 ;;=M06.30^^28^232^161
 ;;^UTILITY(U,$J,358.3,3158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3158,1,3,0)
 ;;=3^Rheumatoid Nodule,Unspec Site
 ;;^UTILITY(U,$J,358.3,3158,1,4,0)
 ;;=4^M06.30
 ;;^UTILITY(U,$J,358.3,3158,2)
 ;;=^5010096
 ;;^UTILITY(U,$J,358.3,3159,0)
 ;;=M06.4^^28^232^48
 ;;^UTILITY(U,$J,358.3,3159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3159,1,3,0)
 ;;=3^Inflammatory Polyarthropathy
 ;;^UTILITY(U,$J,358.3,3159,1,4,0)
 ;;=4^M06.4
 ;;^UTILITY(U,$J,358.3,3159,2)
 ;;=^5010120
 ;;^UTILITY(U,$J,358.3,3160,0)
 ;;=M06.39^^28^232^160
 ;;^UTILITY(U,$J,358.3,3160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3160,1,3,0)
 ;;=3^Rheumatoid Nodule,Mult Sites
 ;;^UTILITY(U,$J,358.3,3160,1,4,0)
 ;;=4^M06.39
 ;;^UTILITY(U,$J,358.3,3160,2)
 ;;=^5010119
 ;;^UTILITY(U,$J,358.3,3161,0)
 ;;=M15.0^^28^232^124
 ;;^UTILITY(U,$J,358.3,3161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3161,1,3,0)
 ;;=3^Primary Generalized Osteoarthritis
 ;;^UTILITY(U,$J,358.3,3161,1,4,0)
 ;;=4^M15.0
 ;;^UTILITY(U,$J,358.3,3161,2)
 ;;=^5010762
 ;;^UTILITY(U,$J,358.3,3162,0)
 ;;=M06.9^^28^232^159
 ;;^UTILITY(U,$J,358.3,3162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3162,1,3,0)
 ;;=3^Rheumatoid Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,3162,1,4,0)
 ;;=4^M06.9
 ;;^UTILITY(U,$J,358.3,3162,2)
 ;;=^5010145
 ;;^UTILITY(U,$J,358.3,3163,0)
 ;;=M16.0^^28^232^127
 ;;^UTILITY(U,$J,358.3,3163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3163,1,3,0)
 ;;=3^Primary Osteoarthritis of Hip,Bilateral
 ;;^UTILITY(U,$J,358.3,3163,1,4,0)
 ;;=4^M16.0
 ;;^UTILITY(U,$J,358.3,3163,2)
 ;;=^5010769
 ;;^UTILITY(U,$J,358.3,3164,0)
 ;;=M16.11^^28^232^136
 ;;^UTILITY(U,$J,358.3,3164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3164,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hip
 ;;^UTILITY(U,$J,358.3,3164,1,4,0)
 ;;=4^M16.11
 ;;^UTILITY(U,$J,358.3,3164,2)
 ;;=^5010771
 ;;^UTILITY(U,$J,358.3,3165,0)
 ;;=M16.12^^28^232^130
 ;;^UTILITY(U,$J,358.3,3165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3165,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hip
 ;;^UTILITY(U,$J,358.3,3165,1,4,0)
 ;;=4^M16.12
 ;;^UTILITY(U,$J,358.3,3165,2)
 ;;=^5010772
 ;;^UTILITY(U,$J,358.3,3166,0)
 ;;=M17.0^^28^232^126
 ;;^UTILITY(U,$J,358.3,3166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3166,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral Knees
 ;;^UTILITY(U,$J,358.3,3166,1,4,0)
 ;;=4^M17.0
 ;;^UTILITY(U,$J,358.3,3166,2)
 ;;=^5010784
 ;;^UTILITY(U,$J,358.3,3167,0)
 ;;=M17.11^^28^232^137
 ;;^UTILITY(U,$J,358.3,3167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3167,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Knee
 ;;^UTILITY(U,$J,358.3,3167,1,4,0)
 ;;=4^M17.11
 ;;^UTILITY(U,$J,358.3,3167,2)
 ;;=^5010786
 ;;^UTILITY(U,$J,358.3,3168,0)
 ;;=M17.12^^28^232^131
 ;;^UTILITY(U,$J,358.3,3168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3168,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Knee
 ;;^UTILITY(U,$J,358.3,3168,1,4,0)
 ;;=4^M17.12
 ;;^UTILITY(U,$J,358.3,3168,2)
 ;;=^5010787
 ;;^UTILITY(U,$J,358.3,3169,0)
 ;;=M18.0^^28^232^125
 ;;^UTILITY(U,$J,358.3,3169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3169,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral 1st Carpometacarp Jts
 ;;^UTILITY(U,$J,358.3,3169,1,4,0)
 ;;=4^M18.0
 ;;^UTILITY(U,$J,358.3,3169,2)
 ;;=^5010795
 ;;^UTILITY(U,$J,358.3,3170,0)
 ;;=M18.11^^28^232^135
 ;;^UTILITY(U,$J,358.3,3170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3170,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,3170,1,4,0)
 ;;=4^M18.11
 ;;^UTILITY(U,$J,358.3,3170,2)
 ;;=^5010797
 ;;^UTILITY(U,$J,358.3,3171,0)
 ;;=M18.12^^28^232^129
 ;;^UTILITY(U,$J,358.3,3171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3171,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,3171,1,4,0)
 ;;=4^M18.12
 ;;^UTILITY(U,$J,358.3,3171,2)
 ;;=^5010798
 ;;^UTILITY(U,$J,358.3,3172,0)
 ;;=M19.011^^28^232^138
 ;;^UTILITY(U,$J,358.3,3172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3172,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,3172,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,3172,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,3173,0)
 ;;=M19.012^^28^232^132
 ;;^UTILITY(U,$J,358.3,3173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3173,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,3173,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,3173,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,3174,0)
 ;;=M19.031^^28^232^139
 ;;^UTILITY(U,$J,358.3,3174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3174,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Wrist
 ;;^UTILITY(U,$J,358.3,3174,1,4,0)
 ;;=4^M19.031
 ;;^UTILITY(U,$J,358.3,3174,2)
 ;;=^5010814
 ;;^UTILITY(U,$J,358.3,3175,0)
 ;;=M19.032^^28^232^133
 ;;^UTILITY(U,$J,358.3,3175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3175,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Wrist
 ;;^UTILITY(U,$J,358.3,3175,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,3175,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,3176,0)
 ;;=M19.041^^28^232^134
 ;;^UTILITY(U,$J,358.3,3176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3176,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,3176,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,3176,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,3177,0)
 ;;=M19.042^^28^232^128
 ;;^UTILITY(U,$J,358.3,3177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3177,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,3177,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,3177,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,3178,0)
 ;;=M19.90^^28^232^71
 ;;^UTILITY(U,$J,358.3,3178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3178,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,3178,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,3178,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,3179,0)
 ;;=M25.40^^28^232^37
 ;;^UTILITY(U,$J,358.3,3179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3179,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,3179,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,3179,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,3180,0)
 ;;=M45.0^^28^232^6
 ;;^UTILITY(U,$J,358.3,3180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3180,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,3180,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,3180,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,3181,0)
 ;;=M45.2^^28^232^3
 ;;^UTILITY(U,$J,358.3,3181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3181,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,3181,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,3181,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,3182,0)
 ;;=M45.4^^28^232^7
 ;;^UTILITY(U,$J,358.3,3182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3182,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,3182,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,3182,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,3183,0)
 ;;=M45.7^^28^232^4
 ;;^UTILITY(U,$J,358.3,3183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3183,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,3183,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,3183,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,3184,0)
 ;;=M45.8^^28^232^5
 ;;^UTILITY(U,$J,358.3,3184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3184,1,3,0)
 ;;=3^Ankylosing Spondylitis of Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,3184,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,3184,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,3185,0)
 ;;=M47.22^^28^232^175
 ;;^UTILITY(U,$J,358.3,3185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3185,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,3185,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,3185,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,3186,0)
 ;;=M47.24^^28^232^177
 ;;^UTILITY(U,$J,358.3,3186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3186,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Thoracic Region NEC
