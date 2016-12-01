IBDEI0G0 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20247,1,3,0)
 ;;=3^Nicotine Dependence In Remission,Unspec
 ;;^UTILITY(U,$J,358.3,20247,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,20247,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,20248,0)
 ;;=F17.210^^55^802^27
 ;;^UTILITY(U,$J,358.3,20248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20248,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,20248,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,20248,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,20249,0)
 ;;=F17.291^^55^802^29
 ;;^UTILITY(U,$J,358.3,20249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20249,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,20249,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,20249,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,20250,0)
 ;;=F17.290^^55^802^30
 ;;^UTILITY(U,$J,358.3,20250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20250,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,20250,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,20250,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,20251,0)
 ;;=F17.221^^55^802^24
 ;;^UTILITY(U,$J,358.3,20251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20251,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,20251,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,20251,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,20252,0)
 ;;=F17.220^^55^802^25
 ;;^UTILITY(U,$J,358.3,20252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20252,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,20252,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,20252,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,20253,0)
 ;;=F17.211^^55^802^26
 ;;^UTILITY(U,$J,358.3,20253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20253,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,20253,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,20253,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,20254,0)
 ;;=F17.200^^55^802^31
 ;;^UTILITY(U,$J,358.3,20254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20254,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,20254,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,20254,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,20255,0)
 ;;=F11.120^^55^802^32
 ;;^UTILITY(U,$J,358.3,20255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20255,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,20255,1,4,0)
 ;;=4^F11.120
 ;;^UTILITY(U,$J,358.3,20255,2)
 ;;=^5003115
 ;;^UTILITY(U,$J,358.3,20256,0)
 ;;=F11.10^^55^802^34
 ;;^UTILITY(U,$J,358.3,20256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20256,1,3,0)
 ;;=3^Opioid Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,20256,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,20256,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,20257,0)
 ;;=F11.129^^55^802^33
 ;;^UTILITY(U,$J,358.3,20257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20257,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,20257,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,20257,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,20258,0)
 ;;=F10.21^^55^802^3
 ;;^UTILITY(U,$J,358.3,20258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20258,1,3,0)
 ;;=3^Alcohol Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,20258,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,20258,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,20259,0)
 ;;=F12.10^^55^802^5
 ;;^UTILITY(U,$J,358.3,20259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20259,1,3,0)
 ;;=3^Cannabis Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,20259,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,20259,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,20260,0)
 ;;=F12.20^^55^802^7
 ;;^UTILITY(U,$J,358.3,20260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20260,1,3,0)
 ;;=3^Cannabis Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,20260,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,20260,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,20261,0)
 ;;=F12.21^^55^802^6
 ;;^UTILITY(U,$J,358.3,20261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20261,1,3,0)
 ;;=3^Cannabis Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,20261,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,20261,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,20262,0)
 ;;=F12.90^^55^802^8
 ;;^UTILITY(U,$J,358.3,20262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20262,1,3,0)
 ;;=3^Cannabis Use,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,20262,1,4,0)
 ;;=4^F12.90
 ;;^UTILITY(U,$J,358.3,20262,2)
 ;;=^5003178
 ;;^UTILITY(U,$J,358.3,20263,0)
 ;;=I83.019^^55^803^3
 ;;^UTILITY(U,$J,358.3,20263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20263,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer,Unspec
 ;;^UTILITY(U,$J,358.3,20263,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,20263,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,20264,0)
 ;;=I83.219^^55^803^4
 ;;^UTILITY(U,$J,358.3,20264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20264,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer & Inflam,Unspec
 ;;^UTILITY(U,$J,358.3,20264,1,4,0)
 ;;=4^I83.219
 ;;^UTILITY(U,$J,358.3,20264,2)
 ;;=^5008003
 ;;^UTILITY(U,$J,358.3,20265,0)
 ;;=I83.029^^55^803^1
 ;;^UTILITY(U,$J,358.3,20265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20265,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer,Unspec
 ;;^UTILITY(U,$J,358.3,20265,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,20265,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,20266,0)
 ;;=I83.229^^55^803^2
 ;;^UTILITY(U,$J,358.3,20266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20266,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer & Inflam,Unspec
 ;;^UTILITY(U,$J,358.3,20266,1,4,0)
 ;;=4^I83.229
 ;;^UTILITY(U,$J,358.3,20266,2)
 ;;=^5008010
 ;;^UTILITY(U,$J,358.3,20267,0)
 ;;=B00.81^^55^804^56
 ;;^UTILITY(U,$J,358.3,20267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20267,1,3,0)
 ;;=3^Herpesviral Hepatitis
 ;;^UTILITY(U,$J,358.3,20267,1,4,0)
 ;;=4^B00.81
 ;;^UTILITY(U,$J,358.3,20267,2)
 ;;=^5000478
 ;;^UTILITY(U,$J,358.3,20268,0)
 ;;=D25.9^^55^804^65
 ;;^UTILITY(U,$J,358.3,20268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20268,1,3,0)
 ;;=3^Leiomyoma of Uterus,Unspec
 ;;^UTILITY(U,$J,358.3,20268,1,4,0)
 ;;=4^D25.9
 ;;^UTILITY(U,$J,358.3,20268,2)
 ;;=^5002081
 ;;^UTILITY(U,$J,358.3,20269,0)
 ;;=F52.9^^55^804^103
 ;;^UTILITY(U,$J,358.3,20269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20269,1,3,0)
 ;;=3^Sexual Dysfnct Not d/t a Sub/Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,20269,1,4,0)
 ;;=4^F52.9
 ;;^UTILITY(U,$J,358.3,20269,2)
 ;;=^5003625
 ;;^UTILITY(U,$J,358.3,20270,0)
 ;;=R37.^^55^804^104
 ;;^UTILITY(U,$J,358.3,20270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20270,1,3,0)
 ;;=3^Sexual Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,20270,1,4,0)
 ;;=4^R37.
 ;;^UTILITY(U,$J,358.3,20270,2)
 ;;=^5019339
 ;;^UTILITY(U,$J,358.3,20271,0)
 ;;=N60.01^^55^804^107
 ;;^UTILITY(U,$J,358.3,20271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20271,1,3,0)
 ;;=3^Solitary Cyst of Right Breast
 ;;^UTILITY(U,$J,358.3,20271,1,4,0)
 ;;=4^N60.01
 ;;^UTILITY(U,$J,358.3,20271,2)
 ;;=^5015770
 ;;^UTILITY(U,$J,358.3,20272,0)
 ;;=N60.02^^55^804^106
 ;;^UTILITY(U,$J,358.3,20272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20272,1,3,0)
 ;;=3^Solitary Cyst of Left Breast
 ;;^UTILITY(U,$J,358.3,20272,1,4,0)
 ;;=4^N60.02
 ;;^UTILITY(U,$J,358.3,20272,2)
 ;;=^5015771
 ;;^UTILITY(U,$J,358.3,20273,0)
 ;;=N60.09^^55^804^108
 ;;^UTILITY(U,$J,358.3,20273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20273,1,3,0)
 ;;=3^Solitary Cyst of Unspec Breast
 ;;^UTILITY(U,$J,358.3,20273,1,4,0)
 ;;=4^N60.09
 ;;^UTILITY(U,$J,358.3,20273,2)
 ;;=^5015772
 ;;^UTILITY(U,$J,358.3,20274,0)
 ;;=N60.11^^55^804^31
 ;;^UTILITY(U,$J,358.3,20274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20274,1,3,0)
 ;;=3^Diffuse Cystic Mastopathy of Right Breast
 ;;^UTILITY(U,$J,358.3,20274,1,4,0)
 ;;=4^N60.11
 ;;^UTILITY(U,$J,358.3,20274,2)
 ;;=^5015773
 ;;^UTILITY(U,$J,358.3,20275,0)
 ;;=N60.12^^55^804^30
 ;;^UTILITY(U,$J,358.3,20275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20275,1,3,0)
 ;;=3^Diffuse Cystic Mastopathy of Left Breast
 ;;^UTILITY(U,$J,358.3,20275,1,4,0)
 ;;=4^N60.12
 ;;^UTILITY(U,$J,358.3,20275,2)
 ;;=^5015774
 ;;^UTILITY(U,$J,358.3,20276,0)
 ;;=N64.4^^55^804^70
 ;;^UTILITY(U,$J,358.3,20276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20276,1,3,0)
 ;;=3^Mastodynia
 ;;^UTILITY(U,$J,358.3,20276,1,4,0)
 ;;=4^N64.4
 ;;^UTILITY(U,$J,358.3,20276,2)
 ;;=^5015794
 ;;^UTILITY(U,$J,358.3,20277,0)
 ;;=N63.^^55^804^67
 ;;^UTILITY(U,$J,358.3,20277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20277,1,3,0)
 ;;=3^Lump in Breast,Unspec
 ;;^UTILITY(U,$J,358.3,20277,1,4,0)
 ;;=4^N63.
 ;;^UTILITY(U,$J,358.3,20277,2)
 ;;=^5015791
 ;;^UTILITY(U,$J,358.3,20278,0)
 ;;=N64.51^^55^804^61
 ;;^UTILITY(U,$J,358.3,20278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20278,1,3,0)
 ;;=3^Induration of Breast
 ;;^UTILITY(U,$J,358.3,20278,1,4,0)
 ;;=4^N64.51
 ;;^UTILITY(U,$J,358.3,20278,2)
 ;;=^5015795
 ;;^UTILITY(U,$J,358.3,20279,0)
 ;;=N64.59^^55^804^105
 ;;^UTILITY(U,$J,358.3,20279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20279,1,3,0)
 ;;=3^Signs and Symptoms in Breast,Other
 ;;^UTILITY(U,$J,358.3,20279,1,4,0)
 ;;=4^N64.59
 ;;^UTILITY(U,$J,358.3,20279,2)
 ;;=^5015797
 ;;^UTILITY(U,$J,358.3,20280,0)
 ;;=N64.52^^55^804^73
 ;;^UTILITY(U,$J,358.3,20280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20280,1,3,0)
 ;;=3^Nipple Discharge
 ;;^UTILITY(U,$J,358.3,20280,1,4,0)
 ;;=4^N64.52
 ;;^UTILITY(U,$J,358.3,20280,2)
 ;;=^259531
 ;;^UTILITY(U,$J,358.3,20281,0)
 ;;=N64.53^^55^804^99
 ;;^UTILITY(U,$J,358.3,20281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20281,1,3,0)
 ;;=3^Retraction of Nipple
 ;;^UTILITY(U,$J,358.3,20281,1,4,0)
 ;;=4^N64.53
 ;;^UTILITY(U,$J,358.3,20281,2)
 ;;=^5015796
 ;;^UTILITY(U,$J,358.3,20282,0)
 ;;=N75.1^^55^804^8
 ;;^UTILITY(U,$J,358.3,20282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20282,1,3,0)
 ;;=3^Abscess of Bartholin's Gland
