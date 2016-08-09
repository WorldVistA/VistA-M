IBDEI0OY ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25125,1,4,0)
 ;;=4^F17.208
 ;;^UTILITY(U,$J,358.3,25125,2)
 ;;=^5003363
 ;;^UTILITY(U,$J,358.3,25126,0)
 ;;=F17.209^^95^1180^2
 ;;^UTILITY(U,$J,358.3,25126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25126,1,3,0)
 ;;=3^Nicotine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25126,1,4,0)
 ;;=4^F17.209
 ;;^UTILITY(U,$J,358.3,25126,2)
 ;;=^5003364
 ;;^UTILITY(U,$J,358.3,25127,0)
 ;;=Z72.0^^95^1180^3
 ;;^UTILITY(U,$J,358.3,25127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25127,1,3,0)
 ;;=3^Tobacco Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25127,1,4,0)
 ;;=4^Z72.0
 ;;^UTILITY(U,$J,358.3,25127,2)
 ;;=^5063255
 ;;^UTILITY(U,$J,358.3,25128,0)
 ;;=F17.200^^95^1180^5
 ;;^UTILITY(U,$J,358.3,25128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25128,1,3,0)
 ;;=3^Tobacco Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,25128,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,25128,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,25129,0)
 ;;=F43.0^^95^1181^1
 ;;^UTILITY(U,$J,358.3,25129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25129,1,3,0)
 ;;=3^Acute Stress Disorder
 ;;^UTILITY(U,$J,358.3,25129,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,25129,2)
 ;;=^5003569
 ;;^UTILITY(U,$J,358.3,25130,0)
 ;;=F43.21^^95^1181^3
 ;;^UTILITY(U,$J,358.3,25130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25130,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,25130,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,25130,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,25131,0)
 ;;=F43.22^^95^1181^2
 ;;^UTILITY(U,$J,358.3,25131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25131,1,3,0)
 ;;=3^Adjustment Disorder w/ Anxiety
 ;;^UTILITY(U,$J,358.3,25131,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,25131,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,25132,0)
 ;;=F43.23^^95^1181^5
 ;;^UTILITY(U,$J,358.3,25132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25132,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,25132,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,25132,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,25133,0)
 ;;=F43.24^^95^1181^4
 ;;^UTILITY(U,$J,358.3,25133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25133,1,3,0)
 ;;=3^Adjustment Disorder w/ Disturbance of Conduct
 ;;^UTILITY(U,$J,358.3,25133,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,25133,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,25134,0)
 ;;=F43.25^^95^1181^6
 ;;^UTILITY(U,$J,358.3,25134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25134,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Disturbance Emotions & Conduct
 ;;^UTILITY(U,$J,358.3,25134,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,25134,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,25135,0)
 ;;=F43.20^^95^1181^7
 ;;^UTILITY(U,$J,358.3,25135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25135,1,3,0)
 ;;=3^Adjustment Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25135,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,25135,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,25136,0)
 ;;=F43.9^^95^1181^12
 ;;^UTILITY(U,$J,358.3,25136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25136,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25136,1,4,0)
 ;;=4^F43.9
 ;;^UTILITY(U,$J,358.3,25136,2)
 ;;=^5003576
 ;;^UTILITY(U,$J,358.3,25137,0)
 ;;=F94.1^^95^1181^10
 ;;^UTILITY(U,$J,358.3,25137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25137,1,3,0)
 ;;=3^Reactive Attachment Disorder
 ;;^UTILITY(U,$J,358.3,25137,1,4,0)
 ;;=4^F94.1
 ;;^UTILITY(U,$J,358.3,25137,2)
 ;;=^5003705
 ;;^UTILITY(U,$J,358.3,25138,0)
 ;;=F94.2^^95^1181^8
 ;;^UTILITY(U,$J,358.3,25138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25138,1,3,0)
 ;;=3^Disinhibited Social Engagement Disorder
 ;;^UTILITY(U,$J,358.3,25138,1,4,0)
 ;;=4^F94.2
 ;;^UTILITY(U,$J,358.3,25138,2)
 ;;=^5003706
 ;;^UTILITY(U,$J,358.3,25139,0)
 ;;=F43.8^^95^1181^11
 ;;^UTILITY(U,$J,358.3,25139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25139,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,25139,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,25139,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,25140,0)
 ;;=F43.10^^95^1181^9
 ;;^UTILITY(U,$J,358.3,25140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25140,1,3,0)
 ;;=3^Post-traumatic Stress Disorder
 ;;^UTILITY(U,$J,358.3,25140,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,25140,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,25141,0)
 ;;=F18.10^^95^1182^23
 ;;^UTILITY(U,$J,358.3,25141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25141,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25141,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,25141,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,25142,0)
 ;;=F18.20^^95^1182^24
 ;;^UTILITY(U,$J,358.3,25142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25142,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,25142,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,25142,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,25143,0)
 ;;=F18.14^^95^1182^4
 ;;^UTILITY(U,$J,358.3,25143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25143,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25143,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,25143,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,25144,0)
 ;;=F18.24^^95^1182^5
 ;;^UTILITY(U,$J,358.3,25144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25144,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25144,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,25144,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,25145,0)
 ;;=F18.121^^95^1182^16
 ;;^UTILITY(U,$J,358.3,25145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25145,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25145,1,4,0)
 ;;=4^F18.121
 ;;^UTILITY(U,$J,358.3,25145,2)
 ;;=^5003382
 ;;^UTILITY(U,$J,358.3,25146,0)
 ;;=F18.221^^95^1182^17
 ;;^UTILITY(U,$J,358.3,25146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25146,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25146,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,25146,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,25147,0)
 ;;=F18.921^^95^1182^18
 ;;^UTILITY(U,$J,358.3,25147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25147,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25147,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,25147,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,25148,0)
 ;;=F18.129^^95^1182^19
 ;;^UTILITY(U,$J,358.3,25148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25148,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25148,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,25148,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,25149,0)
 ;;=F18.229^^95^1182^20
 ;;^UTILITY(U,$J,358.3,25149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25149,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25149,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,25149,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,25150,0)
 ;;=F18.929^^95^1182^21
 ;;^UTILITY(U,$J,358.3,25150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25150,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25150,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,25150,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,25151,0)
 ;;=F18.180^^95^1182^1
 ;;^UTILITY(U,$J,358.3,25151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25151,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25151,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,25151,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,25152,0)
 ;;=F18.280^^95^1182^2
 ;;^UTILITY(U,$J,358.3,25152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25152,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25152,1,4,0)
 ;;=4^F18.280
