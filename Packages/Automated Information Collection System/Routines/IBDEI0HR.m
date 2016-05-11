IBDEI0HR ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8209,1,4,0)
 ;;=4^B18.2
 ;;^UTILITY(U,$J,358.3,8209,2)
 ;;=^5000548
 ;;^UTILITY(U,$J,358.3,8210,0)
 ;;=D64.9^^33^432^5
 ;;^UTILITY(U,$J,358.3,8210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8210,1,3,0)
 ;;=3^Anemia, unspecified
 ;;^UTILITY(U,$J,358.3,8210,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,8210,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,8211,0)
 ;;=F41.9^^33^432^6
 ;;^UTILITY(U,$J,358.3,8211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8211,1,3,0)
 ;;=3^Anxiety disorder, unspecified
 ;;^UTILITY(U,$J,358.3,8211,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,8211,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,8212,0)
 ;;=F10.10^^33^432^3
 ;;^UTILITY(U,$J,358.3,8212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8212,1,3,0)
 ;;=3^Alcohol abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,8212,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,8212,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,8213,0)
 ;;=F17.200^^33^432^28
 ;;^UTILITY(U,$J,358.3,8213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8213,1,3,0)
 ;;=3^Nicotine dependence, unspecified, uncomplicated
 ;;^UTILITY(U,$J,358.3,8213,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,8213,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,8214,0)
 ;;=F17.210^^33^432^26
 ;;^UTILITY(U,$J,358.3,8214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8214,1,3,0)
 ;;=3^Nicotine dependence, cigarettes, uncomplicated
 ;;^UTILITY(U,$J,358.3,8214,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,8214,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,8215,0)
 ;;=F17.220^^33^432^25
 ;;^UTILITY(U,$J,358.3,8215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8215,1,3,0)
 ;;=3^Nicotine dependence, chewing tobacco, uncomplicated
 ;;^UTILITY(U,$J,358.3,8215,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,8215,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,8216,0)
 ;;=F17.290^^33^432^27
 ;;^UTILITY(U,$J,358.3,8216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8216,1,3,0)
 ;;=3^Nicotine dependence, other tobacco product, uncomplicated
 ;;^UTILITY(U,$J,358.3,8216,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,8216,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,8217,0)
 ;;=F32.9^^33^432^23
 ;;^UTILITY(U,$J,358.3,8217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8217,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,8217,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,8217,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,8218,0)
 ;;=G43.909^^33^432^24
 ;;^UTILITY(U,$J,358.3,8218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8218,1,3,0)
 ;;=3^Migraine, unsp, not intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,8218,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,8218,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,8219,0)
 ;;=H93.11^^33^432^41
 ;;^UTILITY(U,$J,358.3,8219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8219,1,3,0)
 ;;=3^Tinnitus, right ear
 ;;^UTILITY(U,$J,358.3,8219,1,4,0)
 ;;=4^H93.11
 ;;^UTILITY(U,$J,358.3,8219,2)
 ;;=^5006964
 ;;^UTILITY(U,$J,358.3,8220,0)
 ;;=H93.12^^33^432^40
 ;;^UTILITY(U,$J,358.3,8220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8220,1,3,0)
 ;;=3^Tinnitus, left ear
 ;;^UTILITY(U,$J,358.3,8220,1,4,0)
 ;;=4^H93.12
 ;;^UTILITY(U,$J,358.3,8220,2)
 ;;=^5006965
 ;;^UTILITY(U,$J,358.3,8221,0)
 ;;=H93.13^^33^432^39
 ;;^UTILITY(U,$J,358.3,8221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8221,1,3,0)
 ;;=3^Tinnitus, bilateral
 ;;^UTILITY(U,$J,358.3,8221,1,4,0)
 ;;=4^H93.13
 ;;^UTILITY(U,$J,358.3,8221,2)
 ;;=^5006966
 ;;^UTILITY(U,$J,358.3,8222,0)
 ;;=H91.91^^33^432^21
 ;;^UTILITY(U,$J,358.3,8222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8222,1,3,0)
 ;;=3^Hearing Loss,Right Ear,Unspec
