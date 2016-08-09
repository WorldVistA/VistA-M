IBDEI0FL ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15599,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,15599,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,15599,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,15600,0)
 ;;=F17.221^^61^754^24
 ;;^UTILITY(U,$J,358.3,15600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15600,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,15600,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,15600,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,15601,0)
 ;;=F17.220^^61^754^25
 ;;^UTILITY(U,$J,358.3,15601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15601,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,15601,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,15601,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,15602,0)
 ;;=F17.211^^61^754^26
 ;;^UTILITY(U,$J,358.3,15602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15602,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,15602,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,15602,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,15603,0)
 ;;=F17.200^^61^754^31
 ;;^UTILITY(U,$J,358.3,15603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15603,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,15603,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,15603,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,15604,0)
 ;;=F11.120^^61^754^32
 ;;^UTILITY(U,$J,358.3,15604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15604,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,15604,1,4,0)
 ;;=4^F11.120
 ;;^UTILITY(U,$J,358.3,15604,2)
 ;;=^5003115
 ;;^UTILITY(U,$J,358.3,15605,0)
 ;;=F11.10^^61^754^34
 ;;^UTILITY(U,$J,358.3,15605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15605,1,3,0)
 ;;=3^Opioid Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,15605,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,15605,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,15606,0)
 ;;=F11.129^^61^754^33
 ;;^UTILITY(U,$J,358.3,15606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15606,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,15606,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,15606,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,15607,0)
 ;;=F10.21^^61^754^3
 ;;^UTILITY(U,$J,358.3,15607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15607,1,3,0)
 ;;=3^Alcohol Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,15607,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,15607,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,15608,0)
 ;;=F12.10^^61^754^5
 ;;^UTILITY(U,$J,358.3,15608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15608,1,3,0)
 ;;=3^Cannabis Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,15608,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,15608,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,15609,0)
 ;;=F12.20^^61^754^7
 ;;^UTILITY(U,$J,358.3,15609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15609,1,3,0)
 ;;=3^Cannabis Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,15609,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,15609,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,15610,0)
 ;;=F12.21^^61^754^6
 ;;^UTILITY(U,$J,358.3,15610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15610,1,3,0)
 ;;=3^Cannabis Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,15610,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,15610,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,15611,0)
 ;;=F12.90^^61^754^8
 ;;^UTILITY(U,$J,358.3,15611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15611,1,3,0)
 ;;=3^Cannabis Use,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,15611,1,4,0)
 ;;=4^F12.90
 ;;^UTILITY(U,$J,358.3,15611,2)
 ;;=^5003178
 ;;^UTILITY(U,$J,358.3,15612,0)
 ;;=I83.019^^61^755^3
 ;;^UTILITY(U,$J,358.3,15612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15612,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer,Unspec
 ;;^UTILITY(U,$J,358.3,15612,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,15612,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,15613,0)
 ;;=I83.219^^61^755^4
 ;;^UTILITY(U,$J,358.3,15613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15613,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer & Inflam,Unspec
 ;;^UTILITY(U,$J,358.3,15613,1,4,0)
 ;;=4^I83.219
 ;;^UTILITY(U,$J,358.3,15613,2)
 ;;=^5008003
 ;;^UTILITY(U,$J,358.3,15614,0)
 ;;=I83.029^^61^755^1
 ;;^UTILITY(U,$J,358.3,15614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15614,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer,Unspec
 ;;^UTILITY(U,$J,358.3,15614,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,15614,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,15615,0)
 ;;=I83.229^^61^755^2
 ;;^UTILITY(U,$J,358.3,15615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15615,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer & Inflam,Unspec
 ;;^UTILITY(U,$J,358.3,15615,1,4,0)
 ;;=4^I83.229
 ;;^UTILITY(U,$J,358.3,15615,2)
 ;;=^5008010
 ;;^UTILITY(U,$J,358.3,15616,0)
 ;;=B00.81^^61^756^56
 ;;^UTILITY(U,$J,358.3,15616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15616,1,3,0)
 ;;=3^Herpesviral Hepatitis
 ;;^UTILITY(U,$J,358.3,15616,1,4,0)
 ;;=4^B00.81
 ;;^UTILITY(U,$J,358.3,15616,2)
 ;;=^5000478
 ;;^UTILITY(U,$J,358.3,15617,0)
 ;;=D25.9^^61^756^65
 ;;^UTILITY(U,$J,358.3,15617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15617,1,3,0)
 ;;=3^Leiomyoma of Uterus,Unspec
 ;;^UTILITY(U,$J,358.3,15617,1,4,0)
 ;;=4^D25.9
 ;;^UTILITY(U,$J,358.3,15617,2)
 ;;=^5002081
 ;;^UTILITY(U,$J,358.3,15618,0)
 ;;=F52.9^^61^756^103
 ;;^UTILITY(U,$J,358.3,15618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15618,1,3,0)
 ;;=3^Sexual Dysfnct Not d/t a Sub/Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,15618,1,4,0)
 ;;=4^F52.9
 ;;^UTILITY(U,$J,358.3,15618,2)
 ;;=^5003625
 ;;^UTILITY(U,$J,358.3,15619,0)
 ;;=R37.^^61^756^104
 ;;^UTILITY(U,$J,358.3,15619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15619,1,3,0)
 ;;=3^Sexual Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,15619,1,4,0)
 ;;=4^R37.
 ;;^UTILITY(U,$J,358.3,15619,2)
 ;;=^5019339
 ;;^UTILITY(U,$J,358.3,15620,0)
 ;;=N60.01^^61^756^107
 ;;^UTILITY(U,$J,358.3,15620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15620,1,3,0)
 ;;=3^Solitary Cyst of Right Breast
 ;;^UTILITY(U,$J,358.3,15620,1,4,0)
 ;;=4^N60.01
 ;;^UTILITY(U,$J,358.3,15620,2)
 ;;=^5015770
 ;;^UTILITY(U,$J,358.3,15621,0)
 ;;=N60.02^^61^756^106
 ;;^UTILITY(U,$J,358.3,15621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15621,1,3,0)
 ;;=3^Solitary Cyst of Left Breast
 ;;^UTILITY(U,$J,358.3,15621,1,4,0)
 ;;=4^N60.02
 ;;^UTILITY(U,$J,358.3,15621,2)
 ;;=^5015771
 ;;^UTILITY(U,$J,358.3,15622,0)
 ;;=N60.09^^61^756^108
 ;;^UTILITY(U,$J,358.3,15622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15622,1,3,0)
 ;;=3^Solitary Cyst of Unspec Breast
 ;;^UTILITY(U,$J,358.3,15622,1,4,0)
 ;;=4^N60.09
 ;;^UTILITY(U,$J,358.3,15622,2)
 ;;=^5015772
 ;;^UTILITY(U,$J,358.3,15623,0)
 ;;=N60.11^^61^756^31
 ;;^UTILITY(U,$J,358.3,15623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15623,1,3,0)
 ;;=3^Diffuse Cystic Mastopathy of Right Breast
 ;;^UTILITY(U,$J,358.3,15623,1,4,0)
 ;;=4^N60.11
 ;;^UTILITY(U,$J,358.3,15623,2)
 ;;=^5015773
 ;;^UTILITY(U,$J,358.3,15624,0)
 ;;=N60.12^^61^756^30
 ;;^UTILITY(U,$J,358.3,15624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15624,1,3,0)
 ;;=3^Diffuse Cystic Mastopathy of Left Breast
 ;;^UTILITY(U,$J,358.3,15624,1,4,0)
 ;;=4^N60.12
 ;;^UTILITY(U,$J,358.3,15624,2)
 ;;=^5015774
 ;;^UTILITY(U,$J,358.3,15625,0)
 ;;=N64.4^^61^756^70
 ;;^UTILITY(U,$J,358.3,15625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15625,1,3,0)
 ;;=3^Mastodynia
 ;;^UTILITY(U,$J,358.3,15625,1,4,0)
 ;;=4^N64.4
 ;;^UTILITY(U,$J,358.3,15625,2)
 ;;=^5015794
 ;;^UTILITY(U,$J,358.3,15626,0)
 ;;=N63.^^61^756^67
 ;;^UTILITY(U,$J,358.3,15626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15626,1,3,0)
 ;;=3^Lump in Breast,Unspec
 ;;^UTILITY(U,$J,358.3,15626,1,4,0)
 ;;=4^N63.
