IBDEI05Z ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2267,2)
 ;;=^5006966
 ;;^UTILITY(U,$J,358.3,2268,0)
 ;;=H91.91^^4^63^21
 ;;^UTILITY(U,$J,358.3,2268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2268,1,3,0)
 ;;=3^Hearing Loss,Right Ear,Unspec
 ;;^UTILITY(U,$J,358.3,2268,1,4,0)
 ;;=4^H91.91
 ;;^UTILITY(U,$J,358.3,2268,2)
 ;;=^5133553
 ;;^UTILITY(U,$J,358.3,2269,0)
 ;;=H91.92^^4^63^20
 ;;^UTILITY(U,$J,358.3,2269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2269,1,3,0)
 ;;=3^Hearing Loss,Left Ear,Unspec
 ;;^UTILITY(U,$J,358.3,2269,1,4,0)
 ;;=4^H91.92
 ;;^UTILITY(U,$J,358.3,2269,2)
 ;;=^5133554
 ;;^UTILITY(U,$J,358.3,2270,0)
 ;;=H91.93^^4^63^19
 ;;^UTILITY(U,$J,358.3,2270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2270,1,3,0)
 ;;=3^Hearing Loss,Bilateral,Unspec
 ;;^UTILITY(U,$J,358.3,2270,1,4,0)
 ;;=4^H91.93
 ;;^UTILITY(U,$J,358.3,2270,2)
 ;;=^5006944
 ;;^UTILITY(U,$J,358.3,2271,0)
 ;;=I10.^^4^63^17
 ;;^UTILITY(U,$J,358.3,2271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2271,1,3,0)
 ;;=3^Essential (primary) hypertension
 ;;^UTILITY(U,$J,358.3,2271,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,2271,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,2272,0)
 ;;=J06.9^^4^63^2
 ;;^UTILITY(U,$J,358.3,2272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2272,1,3,0)
 ;;=3^Acute upper respiratory infection, unspecified
 ;;^UTILITY(U,$J,358.3,2272,1,4,0)
 ;;=4^J06.9
 ;;^UTILITY(U,$J,358.3,2272,2)
 ;;=^5008143
 ;;^UTILITY(U,$J,358.3,2273,0)
 ;;=J32.4^^4^63^12
 ;;^UTILITY(U,$J,358.3,2273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2273,1,3,0)
 ;;=3^Chronic pansinusitis
 ;;^UTILITY(U,$J,358.3,2273,1,4,0)
 ;;=4^J32.4
 ;;^UTILITY(U,$J,358.3,2273,2)
 ;;=^5008206
 ;;^UTILITY(U,$J,358.3,2274,0)
 ;;=J32.8^^4^63^11
 ;;^UTILITY(U,$J,358.3,2274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2274,1,3,0)
 ;;=3^Chronic Sinusitis NEC
 ;;^UTILITY(U,$J,358.3,2274,1,4,0)
 ;;=4^J32.8
 ;;^UTILITY(U,$J,358.3,2274,2)
 ;;=^269890
 ;;^UTILITY(U,$J,358.3,2275,0)
 ;;=J30.9^^4^63^4
 ;;^UTILITY(U,$J,358.3,2275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2275,1,3,0)
 ;;=3^Allergic rhinitis, unspecified
 ;;^UTILITY(U,$J,358.3,2275,1,4,0)
 ;;=4^J30.9
 ;;^UTILITY(U,$J,358.3,2275,2)
 ;;=^5008205
 ;;^UTILITY(U,$J,358.3,2276,0)
 ;;=J40.^^4^63^8
 ;;^UTILITY(U,$J,358.3,2276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2276,1,3,0)
 ;;=3^Bronchitis, not specified as acute or chronic
 ;;^UTILITY(U,$J,358.3,2276,1,4,0)
 ;;=4^J40.
 ;;^UTILITY(U,$J,358.3,2276,2)
 ;;=^17164
 ;;^UTILITY(U,$J,358.3,2277,0)
 ;;=J45.909^^4^63^7
 ;;^UTILITY(U,$J,358.3,2277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2277,1,3,0)
 ;;=3^Asthma,Uncomplicated,Unspec
 ;;^UTILITY(U,$J,358.3,2277,1,4,0)
 ;;=4^J45.909
 ;;^UTILITY(U,$J,358.3,2277,2)
 ;;=^5008256
 ;;^UTILITY(U,$J,358.3,2278,0)
 ;;=K52.9^^4^63^29
 ;;^UTILITY(U,$J,358.3,2278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2278,1,3,0)
 ;;=3^Noninfective gastroenteritis and colitis, unspecified
 ;;^UTILITY(U,$J,358.3,2278,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,2278,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,2279,0)
 ;;=M25.511^^4^63^38
 ;;^UTILITY(U,$J,358.3,2279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2279,1,3,0)
 ;;=3^Pain in right shoulder
 ;;^UTILITY(U,$J,358.3,2279,1,4,0)
 ;;=4^M25.511
 ;;^UTILITY(U,$J,358.3,2279,2)
 ;;=^5011602
 ;;^UTILITY(U,$J,358.3,2280,0)
 ;;=M25.512^^4^63^35
 ;;^UTILITY(U,$J,358.3,2280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2280,1,3,0)
 ;;=3^Pain in left shoulder
 ;;^UTILITY(U,$J,358.3,2280,1,4,0)
 ;;=4^M25.512
 ;;^UTILITY(U,$J,358.3,2280,2)
 ;;=^5011603
 ;;^UTILITY(U,$J,358.3,2281,0)
 ;;=M25.551^^4^63^36
 ;;^UTILITY(U,$J,358.3,2281,1,0)
 ;;=^358.31IA^4^2
