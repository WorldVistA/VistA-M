IBDEI0DD ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13363,1,3,0)
 ;;=3^Phencyclidine Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,13363,1,4,0)
 ;;=4^F16.921
 ;;^UTILITY(U,$J,358.3,13363,2)
 ;;=^5003351
 ;;^UTILITY(U,$J,358.3,13364,0)
 ;;=F11.10^^58^698^24
 ;;^UTILITY(U,$J,358.3,13364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13364,1,3,0)
 ;;=3^Opioid Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,13364,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,13364,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,13365,0)
 ;;=F11.129^^58^698^20
 ;;^UTILITY(U,$J,358.3,13365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13365,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbances w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,13365,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,13365,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,13366,0)
 ;;=F11.14^^58^698^5
 ;;^UTILITY(U,$J,358.3,13366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13366,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,13366,1,4,0)
 ;;=4^F11.14
 ;;^UTILITY(U,$J,358.3,13366,2)
 ;;=^5003119
 ;;^UTILITY(U,$J,358.3,13367,0)
 ;;=F11.182^^58^698^11
 ;;^UTILITY(U,$J,358.3,13367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13367,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,13367,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,13367,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,13368,0)
 ;;=F11.20^^58^698^25
 ;;^UTILITY(U,$J,358.3,13368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13368,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,13368,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,13368,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,13369,0)
 ;;=F11.23^^58^698^27
 ;;^UTILITY(U,$J,358.3,13369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13369,1,3,0)
 ;;=3^Opioid Withdrawal
 ;;^UTILITY(U,$J,358.3,13369,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,13369,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,13370,0)
 ;;=F11.24^^58^698^6
 ;;^UTILITY(U,$J,358.3,13370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13370,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,13370,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,13370,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,13371,0)
 ;;=F11.188^^58^698^1
 ;;^UTILITY(U,$J,358.3,13371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13371,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,13371,1,4,0)
 ;;=4^F11.188
 ;;^UTILITY(U,$J,358.3,13371,2)
 ;;=^5003125
 ;;^UTILITY(U,$J,358.3,13372,0)
 ;;=F11.288^^58^698^2
 ;;^UTILITY(U,$J,358.3,13372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13372,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,13372,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,13372,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,13373,0)
 ;;=F11.988^^58^698^3
 ;;^UTILITY(U,$J,358.3,13373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13373,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,13373,1,4,0)
 ;;=4^F11.988
 ;;^UTILITY(U,$J,358.3,13373,2)
 ;;=^5003154
 ;;^UTILITY(U,$J,358.3,13374,0)
 ;;=F11.921^^58^698^4
 ;;^UTILITY(U,$J,358.3,13374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13374,1,3,0)
 ;;=3^Opioid Induced Delirium
 ;;^UTILITY(U,$J,358.3,13374,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,13374,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,13375,0)
 ;;=F11.94^^58^698^7
 ;;^UTILITY(U,$J,358.3,13375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13375,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,13375,1,4,0)
 ;;=4^F11.94
 ;;^UTILITY(U,$J,358.3,13375,2)
 ;;=^5003148
 ;;^UTILITY(U,$J,358.3,13376,0)
 ;;=F11.181^^58^698^8
 ;;^UTILITY(U,$J,358.3,13376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13376,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,13376,1,4,0)
 ;;=4^F11.181
 ;;^UTILITY(U,$J,358.3,13376,2)
 ;;=^5003123
 ;;^UTILITY(U,$J,358.3,13377,0)
 ;;=F11.281^^58^698^9
 ;;^UTILITY(U,$J,358.3,13377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13377,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,13377,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,13377,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,13378,0)
 ;;=F11.981^^58^698^10
 ;;^UTILITY(U,$J,358.3,13378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13378,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,13378,1,4,0)
 ;;=4^F11.981
 ;;^UTILITY(U,$J,358.3,13378,2)
 ;;=^5003152
 ;;^UTILITY(U,$J,358.3,13379,0)
 ;;=F11.282^^58^698^12
 ;;^UTILITY(U,$J,358.3,13379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13379,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,13379,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,13379,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,13380,0)
 ;;=F11.982^^58^698^13
 ;;^UTILITY(U,$J,358.3,13380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13380,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,13380,1,4,0)
 ;;=4^F11.982
 ;;^UTILITY(U,$J,358.3,13380,2)
 ;;=^5003153
 ;;^UTILITY(U,$J,358.3,13381,0)
 ;;=F11.121^^58^698^14
 ;;^UTILITY(U,$J,358.3,13381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13381,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,13381,1,4,0)
 ;;=4^F11.121
 ;;^UTILITY(U,$J,358.3,13381,2)
 ;;=^5003116
 ;;^UTILITY(U,$J,358.3,13382,0)
 ;;=F11.221^^58^698^15
 ;;^UTILITY(U,$J,358.3,13382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13382,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,13382,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,13382,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,13383,0)
 ;;=F11.921^^58^698^16
 ;;^UTILITY(U,$J,358.3,13383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13383,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,13383,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,13383,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,13384,0)
 ;;=F11.229^^58^698^21
 ;;^UTILITY(U,$J,358.3,13384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13384,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,13384,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,13384,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,13385,0)
 ;;=F11.929^^58^698^22
 ;;^UTILITY(U,$J,358.3,13385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13385,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,13385,1,4,0)
 ;;=4^F11.929
 ;;^UTILITY(U,$J,358.3,13385,2)
 ;;=^5003146
 ;;^UTILITY(U,$J,358.3,13386,0)
 ;;=F11.122^^58^698^17
 ;;^UTILITY(U,$J,358.3,13386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13386,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,13386,1,4,0)
 ;;=4^F11.122
 ;;^UTILITY(U,$J,358.3,13386,2)
 ;;=^5003117
 ;;^UTILITY(U,$J,358.3,13387,0)
 ;;=F11.222^^58^698^18
 ;;^UTILITY(U,$J,358.3,13387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13387,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,13387,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,13387,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,13388,0)
 ;;=F11.922^^58^698^19
 ;;^UTILITY(U,$J,358.3,13388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13388,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,13388,1,4,0)
 ;;=4^F11.922
 ;;^UTILITY(U,$J,358.3,13388,2)
 ;;=^5003145
 ;;^UTILITY(U,$J,358.3,13389,0)
 ;;=F11.99^^58^698^23
 ;;^UTILITY(U,$J,358.3,13389,1,0)
 ;;=^358.31IA^4^2
