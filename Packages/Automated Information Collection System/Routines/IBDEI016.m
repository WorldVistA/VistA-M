IBDEI016 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,645,0)
 ;;=F17.203^^3^51^6
 ;;^UTILITY(U,$J,358.3,645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,645,1,3,0)
 ;;=3^Tobacco Withdrawal
 ;;^UTILITY(U,$J,358.3,645,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,645,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,646,0)
 ;;=F17.208^^3^51^1
 ;;^UTILITY(U,$J,358.3,646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,646,1,3,0)
 ;;=3^Nicotine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,646,1,4,0)
 ;;=4^F17.208
 ;;^UTILITY(U,$J,358.3,646,2)
 ;;=^5003363
 ;;^UTILITY(U,$J,358.3,647,0)
 ;;=F17.209^^3^51^2
 ;;^UTILITY(U,$J,358.3,647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,647,1,3,0)
 ;;=3^Nicotine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,647,1,4,0)
 ;;=4^F17.209
 ;;^UTILITY(U,$J,358.3,647,2)
 ;;=^5003364
 ;;^UTILITY(U,$J,358.3,648,0)
 ;;=Z72.0^^3^51^3
 ;;^UTILITY(U,$J,358.3,648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,648,1,3,0)
 ;;=3^Tobacco Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,648,1,4,0)
 ;;=4^Z72.0
 ;;^UTILITY(U,$J,358.3,648,2)
 ;;=^5063255
 ;;^UTILITY(U,$J,358.3,649,0)
 ;;=F17.200^^3^51^5
 ;;^UTILITY(U,$J,358.3,649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,649,1,3,0)
 ;;=3^Tobacco Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,649,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,649,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,650,0)
 ;;=F43.0^^3^52^1
 ;;^UTILITY(U,$J,358.3,650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,650,1,3,0)
 ;;=3^Acute Stress Disorder
 ;;^UTILITY(U,$J,358.3,650,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,650,2)
 ;;=^5003569
 ;;^UTILITY(U,$J,358.3,651,0)
 ;;=F43.21^^3^52^3
 ;;^UTILITY(U,$J,358.3,651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,651,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,651,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,651,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,652,0)
 ;;=F43.22^^3^52^2
 ;;^UTILITY(U,$J,358.3,652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,652,1,3,0)
 ;;=3^Adjustment Disorder w/ Anxiety
 ;;^UTILITY(U,$J,358.3,652,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,652,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,653,0)
 ;;=F43.23^^3^52^5
 ;;^UTILITY(U,$J,358.3,653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,653,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,653,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,653,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,654,0)
 ;;=F43.24^^3^52^4
 ;;^UTILITY(U,$J,358.3,654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,654,1,3,0)
 ;;=3^Adjustment Disorder w/ Disturbance of Conduct
 ;;^UTILITY(U,$J,358.3,654,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,654,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,655,0)
 ;;=F43.25^^3^52^6
 ;;^UTILITY(U,$J,358.3,655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,655,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Disturbance Emotions & Conduct
 ;;^UTILITY(U,$J,358.3,655,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,655,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,656,0)
 ;;=F43.20^^3^52^7
 ;;^UTILITY(U,$J,358.3,656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,656,1,3,0)
 ;;=3^Adjustment Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,656,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,656,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,657,0)
 ;;=F43.9^^3^52^12
 ;;^UTILITY(U,$J,358.3,657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,657,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,657,1,4,0)
 ;;=4^F43.9
 ;;^UTILITY(U,$J,358.3,657,2)
 ;;=^5003576
 ;;^UTILITY(U,$J,358.3,658,0)
 ;;=F94.1^^3^52^10
 ;;^UTILITY(U,$J,358.3,658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,658,1,3,0)
 ;;=3^Reactive Attachment Disorder
 ;;^UTILITY(U,$J,358.3,658,1,4,0)
 ;;=4^F94.1
 ;;^UTILITY(U,$J,358.3,658,2)
 ;;=^5003705
 ;;^UTILITY(U,$J,358.3,659,0)
 ;;=F94.2^^3^52^8
 ;;^UTILITY(U,$J,358.3,659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,659,1,3,0)
 ;;=3^Disinhibited Social Engagement Disorder
 ;;^UTILITY(U,$J,358.3,659,1,4,0)
 ;;=4^F94.2
 ;;^UTILITY(U,$J,358.3,659,2)
 ;;=^5003706
 ;;^UTILITY(U,$J,358.3,660,0)
 ;;=F43.8^^3^52^11
 ;;^UTILITY(U,$J,358.3,660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,660,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,660,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,660,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,661,0)
 ;;=F43.10^^3^52^9
 ;;^UTILITY(U,$J,358.3,661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,661,1,3,0)
 ;;=3^Post-traumatic Stress Disorder
 ;;^UTILITY(U,$J,358.3,661,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,661,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,662,0)
 ;;=F18.10^^3^53^23
 ;;^UTILITY(U,$J,358.3,662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,662,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,662,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,662,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,663,0)
 ;;=F18.20^^3^53^24
 ;;^UTILITY(U,$J,358.3,663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,663,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,663,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,663,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,664,0)
 ;;=F18.14^^3^53^4
 ;;^UTILITY(U,$J,358.3,664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,664,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,664,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,664,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,665,0)
 ;;=F18.24^^3^53^5
 ;;^UTILITY(U,$J,358.3,665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,665,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,665,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,665,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,666,0)
 ;;=F18.121^^3^53^16
 ;;^UTILITY(U,$J,358.3,666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,666,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,666,1,4,0)
 ;;=4^F18.121
 ;;^UTILITY(U,$J,358.3,666,2)
 ;;=^5003382
 ;;^UTILITY(U,$J,358.3,667,0)
 ;;=F18.221^^3^53^17
 ;;^UTILITY(U,$J,358.3,667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,667,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,667,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,667,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,668,0)
 ;;=F18.921^^3^53^18
 ;;^UTILITY(U,$J,358.3,668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,668,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,668,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,668,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,669,0)
 ;;=F18.129^^3^53^19
 ;;^UTILITY(U,$J,358.3,669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,669,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,669,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,669,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,670,0)
 ;;=F18.229^^3^53^20
 ;;^UTILITY(U,$J,358.3,670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,670,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,670,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,670,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,671,0)
 ;;=F18.929^^3^53^21
 ;;^UTILITY(U,$J,358.3,671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,671,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,671,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,671,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,672,0)
 ;;=F18.180^^3^53^1
 ;;^UTILITY(U,$J,358.3,672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,672,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,672,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,672,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,673,0)
 ;;=F18.280^^3^53^2
 ;;^UTILITY(U,$J,358.3,673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,673,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
