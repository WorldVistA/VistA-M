IBDEI05Y ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2254,1,4,0)
 ;;=4^S81.802A
 ;;^UTILITY(U,$J,358.3,2254,2)
 ;;=^5040068
 ;;^UTILITY(U,$J,358.3,2255,0)
 ;;=B18.2^^4^63^13
 ;;^UTILITY(U,$J,358.3,2255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2255,1,3,0)
 ;;=3^Chronic viral hepatitis C
 ;;^UTILITY(U,$J,358.3,2255,1,4,0)
 ;;=4^B18.2
 ;;^UTILITY(U,$J,358.3,2255,2)
 ;;=^5000548
 ;;^UTILITY(U,$J,358.3,2256,0)
 ;;=D64.9^^4^63^5
 ;;^UTILITY(U,$J,358.3,2256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2256,1,3,0)
 ;;=3^Anemia, unspecified
 ;;^UTILITY(U,$J,358.3,2256,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,2256,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,2257,0)
 ;;=F41.9^^4^63^6
 ;;^UTILITY(U,$J,358.3,2257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2257,1,3,0)
 ;;=3^Anxiety disorder, unspecified
 ;;^UTILITY(U,$J,358.3,2257,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,2257,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,2258,0)
 ;;=F10.10^^4^63^3
 ;;^UTILITY(U,$J,358.3,2258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2258,1,3,0)
 ;;=3^Alcohol abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,2258,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,2258,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,2259,0)
 ;;=F17.200^^4^63^28
 ;;^UTILITY(U,$J,358.3,2259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2259,1,3,0)
 ;;=3^Nicotine dependence, unspecified, uncomplicated
 ;;^UTILITY(U,$J,358.3,2259,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,2259,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,2260,0)
 ;;=F17.210^^4^63^26
 ;;^UTILITY(U,$J,358.3,2260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2260,1,3,0)
 ;;=3^Nicotine dependence, cigarettes, uncomplicated
 ;;^UTILITY(U,$J,358.3,2260,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,2260,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,2261,0)
 ;;=F17.220^^4^63^25
 ;;^UTILITY(U,$J,358.3,2261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2261,1,3,0)
 ;;=3^Nicotine dependence, chewing tobacco, uncomplicated
 ;;^UTILITY(U,$J,358.3,2261,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,2261,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,2262,0)
 ;;=F17.290^^4^63^27
 ;;^UTILITY(U,$J,358.3,2262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2262,1,3,0)
 ;;=3^Nicotine dependence, other tobacco product, uncomplicated
 ;;^UTILITY(U,$J,358.3,2262,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,2262,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,2263,0)
 ;;=F32.9^^4^63^23
 ;;^UTILITY(U,$J,358.3,2263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2263,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,2263,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,2263,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,2264,0)
 ;;=G43.909^^4^63^24
 ;;^UTILITY(U,$J,358.3,2264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2264,1,3,0)
 ;;=3^Migraine, unsp, not intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,2264,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,2264,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,2265,0)
 ;;=H93.11^^4^63^41
 ;;^UTILITY(U,$J,358.3,2265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2265,1,3,0)
 ;;=3^Tinnitus, right ear
 ;;^UTILITY(U,$J,358.3,2265,1,4,0)
 ;;=4^H93.11
 ;;^UTILITY(U,$J,358.3,2265,2)
 ;;=^5006964
 ;;^UTILITY(U,$J,358.3,2266,0)
 ;;=H93.12^^4^63^40
 ;;^UTILITY(U,$J,358.3,2266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2266,1,3,0)
 ;;=3^Tinnitus, left ear
 ;;^UTILITY(U,$J,358.3,2266,1,4,0)
 ;;=4^H93.12
 ;;^UTILITY(U,$J,358.3,2266,2)
 ;;=^5006965
 ;;^UTILITY(U,$J,358.3,2267,0)
 ;;=H93.13^^4^63^39
 ;;^UTILITY(U,$J,358.3,2267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2267,1,3,0)
 ;;=3^Tinnitus, bilateral
 ;;^UTILITY(U,$J,358.3,2267,1,4,0)
 ;;=4^H93.13
