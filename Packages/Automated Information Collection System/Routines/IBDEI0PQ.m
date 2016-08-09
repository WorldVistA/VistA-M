IBDEI0PQ ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25875,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,25875,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,25876,0)
 ;;=F13.20^^97^1224^33
 ;;^UTILITY(U,$J,358.3,25876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25876,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,25876,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,25876,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,25877,0)
 ;;=F13.232^^97^1224^34
 ;;^UTILITY(U,$J,358.3,25877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25877,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,25877,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,25877,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,25878,0)
 ;;=F13.239^^97^1224^35
 ;;^UTILITY(U,$J,358.3,25878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25878,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,25878,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,25878,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,25879,0)
 ;;=F13.231^^97^1224^36
 ;;^UTILITY(U,$J,358.3,25879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25879,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,25879,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,25879,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,25880,0)
 ;;=F13.99^^97^1224^30
 ;;^UTILITY(U,$J,358.3,25880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25880,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,25880,1,4,0)
 ;;=4^F13.99
 ;;^UTILITY(U,$J,358.3,25880,2)
 ;;=^5133353
 ;;^UTILITY(U,$J,358.3,25881,0)
 ;;=F17.200^^97^1225^4
 ;;^UTILITY(U,$J,358.3,25881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25881,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,25881,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,25881,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,25882,0)
 ;;=F17.203^^97^1225^6
 ;;^UTILITY(U,$J,358.3,25882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25882,1,3,0)
 ;;=3^Tobacco Withdrawal
 ;;^UTILITY(U,$J,358.3,25882,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,25882,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,25883,0)
 ;;=F17.208^^97^1225^1
 ;;^UTILITY(U,$J,358.3,25883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25883,1,3,0)
 ;;=3^Nicotine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25883,1,4,0)
 ;;=4^F17.208
 ;;^UTILITY(U,$J,358.3,25883,2)
 ;;=^5003363
 ;;^UTILITY(U,$J,358.3,25884,0)
 ;;=F17.209^^97^1225^2
 ;;^UTILITY(U,$J,358.3,25884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25884,1,3,0)
 ;;=3^Nicotine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25884,1,4,0)
 ;;=4^F17.209
 ;;^UTILITY(U,$J,358.3,25884,2)
 ;;=^5003364
 ;;^UTILITY(U,$J,358.3,25885,0)
 ;;=Z72.0^^97^1225^3
 ;;^UTILITY(U,$J,358.3,25885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25885,1,3,0)
 ;;=3^Tobacco Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25885,1,4,0)
 ;;=4^Z72.0
 ;;^UTILITY(U,$J,358.3,25885,2)
 ;;=^5063255
 ;;^UTILITY(U,$J,358.3,25886,0)
 ;;=F17.200^^97^1225^5
 ;;^UTILITY(U,$J,358.3,25886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25886,1,3,0)
 ;;=3^Tobacco Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,25886,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,25886,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,25887,0)
 ;;=F43.0^^97^1226^1
 ;;^UTILITY(U,$J,358.3,25887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25887,1,3,0)
 ;;=3^Acute Stress Disorder
 ;;^UTILITY(U,$J,358.3,25887,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,25887,2)
 ;;=^5003569
 ;;^UTILITY(U,$J,358.3,25888,0)
 ;;=F43.21^^97^1226^3
 ;;^UTILITY(U,$J,358.3,25888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25888,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,25888,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,25888,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,25889,0)
 ;;=F43.22^^97^1226^2
 ;;^UTILITY(U,$J,358.3,25889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25889,1,3,0)
 ;;=3^Adjustment Disorder w/ Anxiety
 ;;^UTILITY(U,$J,358.3,25889,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,25889,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,25890,0)
 ;;=F43.23^^97^1226^5
 ;;^UTILITY(U,$J,358.3,25890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25890,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,25890,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,25890,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,25891,0)
 ;;=F43.24^^97^1226^4
 ;;^UTILITY(U,$J,358.3,25891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25891,1,3,0)
 ;;=3^Adjustment Disorder w/ Disturbance of Conduct
 ;;^UTILITY(U,$J,358.3,25891,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,25891,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,25892,0)
 ;;=F43.25^^97^1226^6
 ;;^UTILITY(U,$J,358.3,25892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25892,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Disturbance Emotions & Conduct
 ;;^UTILITY(U,$J,358.3,25892,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,25892,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,25893,0)
 ;;=F43.20^^97^1226^7
 ;;^UTILITY(U,$J,358.3,25893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25893,1,3,0)
 ;;=3^Adjustment Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25893,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,25893,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,25894,0)
 ;;=F43.9^^97^1226^12
 ;;^UTILITY(U,$J,358.3,25894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25894,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25894,1,4,0)
 ;;=4^F43.9
 ;;^UTILITY(U,$J,358.3,25894,2)
 ;;=^5003576
 ;;^UTILITY(U,$J,358.3,25895,0)
 ;;=F94.1^^97^1226^10
 ;;^UTILITY(U,$J,358.3,25895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25895,1,3,0)
 ;;=3^Reactive Attachment Disorder
 ;;^UTILITY(U,$J,358.3,25895,1,4,0)
 ;;=4^F94.1
 ;;^UTILITY(U,$J,358.3,25895,2)
 ;;=^5003705
 ;;^UTILITY(U,$J,358.3,25896,0)
 ;;=F94.2^^97^1226^8
 ;;^UTILITY(U,$J,358.3,25896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25896,1,3,0)
 ;;=3^Disinhibited Social Engagement Disorder
 ;;^UTILITY(U,$J,358.3,25896,1,4,0)
 ;;=4^F94.2
 ;;^UTILITY(U,$J,358.3,25896,2)
 ;;=^5003706
 ;;^UTILITY(U,$J,358.3,25897,0)
 ;;=F43.8^^97^1226^11
 ;;^UTILITY(U,$J,358.3,25897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25897,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,25897,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,25897,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,25898,0)
 ;;=F43.10^^97^1226^9
 ;;^UTILITY(U,$J,358.3,25898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25898,1,3,0)
 ;;=3^Post-traumatic Stress Disorder
 ;;^UTILITY(U,$J,358.3,25898,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,25898,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,25899,0)
 ;;=F18.10^^97^1227^23
 ;;^UTILITY(U,$J,358.3,25899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25899,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25899,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,25899,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,25900,0)
 ;;=F18.20^^97^1227^24
 ;;^UTILITY(U,$J,358.3,25900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25900,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,25900,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,25900,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,25901,0)
 ;;=F18.14^^97^1227^4
 ;;^UTILITY(U,$J,358.3,25901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25901,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25901,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,25901,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,25902,0)
 ;;=F18.24^^97^1227^5
 ;;^UTILITY(U,$J,358.3,25902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25902,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25902,1,4,0)
 ;;=4^F18.24
