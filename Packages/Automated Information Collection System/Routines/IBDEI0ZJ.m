IBDEI0ZJ ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35764,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,35764,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,35764,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,35765,0)
 ;;=F11.23^^130^1722^27
 ;;^UTILITY(U,$J,358.3,35765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35765,1,3,0)
 ;;=3^Opioid Withdrawal
 ;;^UTILITY(U,$J,358.3,35765,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,35765,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,35766,0)
 ;;=F11.24^^130^1722^6
 ;;^UTILITY(U,$J,358.3,35766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35766,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,35766,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,35766,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,35767,0)
 ;;=F11.188^^130^1722^1
 ;;^UTILITY(U,$J,358.3,35767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35767,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,35767,1,4,0)
 ;;=4^F11.188
 ;;^UTILITY(U,$J,358.3,35767,2)
 ;;=^5003125
 ;;^UTILITY(U,$J,358.3,35768,0)
 ;;=F11.288^^130^1722^2
 ;;^UTILITY(U,$J,358.3,35768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35768,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,35768,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,35768,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,35769,0)
 ;;=F11.988^^130^1722^3
 ;;^UTILITY(U,$J,358.3,35769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35769,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,35769,1,4,0)
 ;;=4^F11.988
 ;;^UTILITY(U,$J,358.3,35769,2)
 ;;=^5003154
 ;;^UTILITY(U,$J,358.3,35770,0)
 ;;=F11.921^^130^1722^4
 ;;^UTILITY(U,$J,358.3,35770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35770,1,3,0)
 ;;=3^Opioid Induced Delirium
 ;;^UTILITY(U,$J,358.3,35770,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,35770,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,35771,0)
 ;;=F11.94^^130^1722^7
 ;;^UTILITY(U,$J,358.3,35771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35771,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,35771,1,4,0)
 ;;=4^F11.94
 ;;^UTILITY(U,$J,358.3,35771,2)
 ;;=^5003148
 ;;^UTILITY(U,$J,358.3,35772,0)
 ;;=F11.181^^130^1722^8
 ;;^UTILITY(U,$J,358.3,35772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35772,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,35772,1,4,0)
 ;;=4^F11.181
 ;;^UTILITY(U,$J,358.3,35772,2)
 ;;=^5003123
 ;;^UTILITY(U,$J,358.3,35773,0)
 ;;=F11.281^^130^1722^9
 ;;^UTILITY(U,$J,358.3,35773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35773,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,35773,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,35773,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,35774,0)
 ;;=F11.981^^130^1722^10
 ;;^UTILITY(U,$J,358.3,35774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35774,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,35774,1,4,0)
 ;;=4^F11.981
 ;;^UTILITY(U,$J,358.3,35774,2)
 ;;=^5003152
 ;;^UTILITY(U,$J,358.3,35775,0)
 ;;=F11.282^^130^1722^12
 ;;^UTILITY(U,$J,358.3,35775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35775,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,35775,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,35775,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,35776,0)
 ;;=F11.982^^130^1722^13
 ;;^UTILITY(U,$J,358.3,35776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35776,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,35776,1,4,0)
 ;;=4^F11.982
 ;;^UTILITY(U,$J,358.3,35776,2)
 ;;=^5003153
 ;;^UTILITY(U,$J,358.3,35777,0)
 ;;=F11.121^^130^1722^14
 ;;^UTILITY(U,$J,358.3,35777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35777,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,35777,1,4,0)
 ;;=4^F11.121
 ;;^UTILITY(U,$J,358.3,35777,2)
 ;;=^5003116
 ;;^UTILITY(U,$J,358.3,35778,0)
 ;;=F11.221^^130^1722^15
 ;;^UTILITY(U,$J,358.3,35778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35778,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,35778,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,35778,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,35779,0)
 ;;=F11.921^^130^1722^16
 ;;^UTILITY(U,$J,358.3,35779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35779,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,35779,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,35779,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,35780,0)
 ;;=F11.229^^130^1722^21
 ;;^UTILITY(U,$J,358.3,35780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35780,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,35780,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,35780,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,35781,0)
 ;;=F11.929^^130^1722^22
 ;;^UTILITY(U,$J,358.3,35781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35781,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,35781,1,4,0)
 ;;=4^F11.929
 ;;^UTILITY(U,$J,358.3,35781,2)
 ;;=^5003146
 ;;^UTILITY(U,$J,358.3,35782,0)
 ;;=F11.122^^130^1722^17
 ;;^UTILITY(U,$J,358.3,35782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35782,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,35782,1,4,0)
 ;;=4^F11.122
 ;;^UTILITY(U,$J,358.3,35782,2)
 ;;=^5003117
 ;;^UTILITY(U,$J,358.3,35783,0)
 ;;=F11.222^^130^1722^18
 ;;^UTILITY(U,$J,358.3,35783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35783,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,35783,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,35783,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,35784,0)
 ;;=F11.922^^130^1722^19
 ;;^UTILITY(U,$J,358.3,35784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35784,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,35784,1,4,0)
 ;;=4^F11.922
 ;;^UTILITY(U,$J,358.3,35784,2)
 ;;=^5003145
 ;;^UTILITY(U,$J,358.3,35785,0)
 ;;=F11.99^^130^1722^23
 ;;^UTILITY(U,$J,358.3,35785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35785,1,3,0)
 ;;=3^Opioid Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,35785,1,4,0)
 ;;=4^F11.99
 ;;^UTILITY(U,$J,358.3,35785,2)
 ;;=^5133352
 ;;^UTILITY(U,$J,358.3,35786,0)
 ;;=F11.20^^130^1722^26
 ;;^UTILITY(U,$J,358.3,35786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35786,1,3,0)
 ;;=3^Opioid Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,35786,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,35786,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,35787,0)
 ;;=F11.23^^130^1722^28
 ;;^UTILITY(U,$J,358.3,35787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35787,1,3,0)
 ;;=3^Opioid Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,35787,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,35787,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,35788,0)
 ;;=F13.180^^130^1723^1
 ;;^UTILITY(U,$J,358.3,35788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35788,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,35788,1,4,0)
 ;;=4^F13.180
 ;;^UTILITY(U,$J,358.3,35788,2)
 ;;=^5003197
 ;;^UTILITY(U,$J,358.3,35789,0)
 ;;=F13.280^^130^1723^2
 ;;^UTILITY(U,$J,358.3,35789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35789,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,35789,1,4,0)
 ;;=4^F13.280
 ;;^UTILITY(U,$J,358.3,35789,2)
 ;;=^5003216
 ;;^UTILITY(U,$J,358.3,35790,0)
 ;;=F13.980^^130^1723^3
 ;;^UTILITY(U,$J,358.3,35790,1,0)
 ;;=^358.31IA^4^2
