IBDEI0R0 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12364,1,4,0)
 ;;=4^B18.2
 ;;^UTILITY(U,$J,358.3,12364,2)
 ;;=^5000548
 ;;^UTILITY(U,$J,358.3,12365,0)
 ;;=D64.9^^71^709^5
 ;;^UTILITY(U,$J,358.3,12365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12365,1,3,0)
 ;;=3^Anemia, unspecified
 ;;^UTILITY(U,$J,358.3,12365,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,12365,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,12366,0)
 ;;=F41.9^^71^709^6
 ;;^UTILITY(U,$J,358.3,12366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12366,1,3,0)
 ;;=3^Anxiety disorder, unspecified
 ;;^UTILITY(U,$J,358.3,12366,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,12366,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,12367,0)
 ;;=F10.10^^71^709^3
 ;;^UTILITY(U,$J,358.3,12367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12367,1,3,0)
 ;;=3^Alcohol abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,12367,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,12367,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,12368,0)
 ;;=F17.200^^71^709^28
 ;;^UTILITY(U,$J,358.3,12368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12368,1,3,0)
 ;;=3^Nicotine dependence, unspecified, uncomplicated
 ;;^UTILITY(U,$J,358.3,12368,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,12368,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,12369,0)
 ;;=F17.210^^71^709^26
 ;;^UTILITY(U,$J,358.3,12369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12369,1,3,0)
 ;;=3^Nicotine dependence, cigarettes, uncomplicated
 ;;^UTILITY(U,$J,358.3,12369,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,12369,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,12370,0)
 ;;=F17.220^^71^709^25
 ;;^UTILITY(U,$J,358.3,12370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12370,1,3,0)
 ;;=3^Nicotine dependence, chewing tobacco, uncomplicated
 ;;^UTILITY(U,$J,358.3,12370,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,12370,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,12371,0)
 ;;=F17.290^^71^709^27
 ;;^UTILITY(U,$J,358.3,12371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12371,1,3,0)
 ;;=3^Nicotine dependence, other tobacco product, uncomplicated
 ;;^UTILITY(U,$J,358.3,12371,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,12371,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,12372,0)
 ;;=F32.9^^71^709^23
 ;;^UTILITY(U,$J,358.3,12372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12372,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,12372,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,12372,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,12373,0)
 ;;=G43.909^^71^709^24
 ;;^UTILITY(U,$J,358.3,12373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12373,1,3,0)
 ;;=3^Migraine, unsp, not intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,12373,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,12373,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,12374,0)
 ;;=H93.11^^71^709^41
 ;;^UTILITY(U,$J,358.3,12374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12374,1,3,0)
 ;;=3^Tinnitus, right ear
 ;;^UTILITY(U,$J,358.3,12374,1,4,0)
 ;;=4^H93.11
 ;;^UTILITY(U,$J,358.3,12374,2)
 ;;=^5006964
 ;;^UTILITY(U,$J,358.3,12375,0)
 ;;=H93.12^^71^709^40
 ;;^UTILITY(U,$J,358.3,12375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12375,1,3,0)
 ;;=3^Tinnitus, left ear
 ;;^UTILITY(U,$J,358.3,12375,1,4,0)
 ;;=4^H93.12
 ;;^UTILITY(U,$J,358.3,12375,2)
 ;;=^5006965
 ;;^UTILITY(U,$J,358.3,12376,0)
 ;;=H93.13^^71^709^39
 ;;^UTILITY(U,$J,358.3,12376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12376,1,3,0)
 ;;=3^Tinnitus, bilateral
 ;;^UTILITY(U,$J,358.3,12376,1,4,0)
 ;;=4^H93.13
 ;;^UTILITY(U,$J,358.3,12376,2)
 ;;=^5006966
 ;;^UTILITY(U,$J,358.3,12377,0)
 ;;=H91.91^^71^709^21
 ;;^UTILITY(U,$J,358.3,12377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12377,1,3,0)
 ;;=3^Hearing Loss,Right Ear,Unspec
