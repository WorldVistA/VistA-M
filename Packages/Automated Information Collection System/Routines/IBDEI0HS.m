IBDEI0HS ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8222,1,4,0)
 ;;=4^H91.91
 ;;^UTILITY(U,$J,358.3,8222,2)
 ;;=^5133553
 ;;^UTILITY(U,$J,358.3,8223,0)
 ;;=H91.92^^33^432^20
 ;;^UTILITY(U,$J,358.3,8223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8223,1,3,0)
 ;;=3^Hearing Loss,Left Ear,Unspec
 ;;^UTILITY(U,$J,358.3,8223,1,4,0)
 ;;=4^H91.92
 ;;^UTILITY(U,$J,358.3,8223,2)
 ;;=^5133554
 ;;^UTILITY(U,$J,358.3,8224,0)
 ;;=H91.93^^33^432^19
 ;;^UTILITY(U,$J,358.3,8224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8224,1,3,0)
 ;;=3^Hearing Loss,Bilateral,Unspec
 ;;^UTILITY(U,$J,358.3,8224,1,4,0)
 ;;=4^H91.93
 ;;^UTILITY(U,$J,358.3,8224,2)
 ;;=^5006944
 ;;^UTILITY(U,$J,358.3,8225,0)
 ;;=I10.^^33^432^17
 ;;^UTILITY(U,$J,358.3,8225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8225,1,3,0)
 ;;=3^Essential (primary) hypertension
 ;;^UTILITY(U,$J,358.3,8225,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,8225,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,8226,0)
 ;;=J06.9^^33^432^2
 ;;^UTILITY(U,$J,358.3,8226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8226,1,3,0)
 ;;=3^Acute upper respiratory infection, unspecified
 ;;^UTILITY(U,$J,358.3,8226,1,4,0)
 ;;=4^J06.9
 ;;^UTILITY(U,$J,358.3,8226,2)
 ;;=^5008143
 ;;^UTILITY(U,$J,358.3,8227,0)
 ;;=J32.4^^33^432^12
 ;;^UTILITY(U,$J,358.3,8227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8227,1,3,0)
 ;;=3^Chronic pansinusitis
 ;;^UTILITY(U,$J,358.3,8227,1,4,0)
 ;;=4^J32.4
 ;;^UTILITY(U,$J,358.3,8227,2)
 ;;=^5008206
 ;;^UTILITY(U,$J,358.3,8228,0)
 ;;=J32.8^^33^432^11
 ;;^UTILITY(U,$J,358.3,8228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8228,1,3,0)
 ;;=3^Chronic Sinusitis NEC
 ;;^UTILITY(U,$J,358.3,8228,1,4,0)
 ;;=4^J32.8
 ;;^UTILITY(U,$J,358.3,8228,2)
 ;;=^269890
 ;;^UTILITY(U,$J,358.3,8229,0)
 ;;=J30.9^^33^432^4
 ;;^UTILITY(U,$J,358.3,8229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8229,1,3,0)
 ;;=3^Allergic rhinitis, unspecified
 ;;^UTILITY(U,$J,358.3,8229,1,4,0)
 ;;=4^J30.9
 ;;^UTILITY(U,$J,358.3,8229,2)
 ;;=^5008205
 ;;^UTILITY(U,$J,358.3,8230,0)
 ;;=J40.^^33^432^8
 ;;^UTILITY(U,$J,358.3,8230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8230,1,3,0)
 ;;=3^Bronchitis, not specified as acute or chronic
 ;;^UTILITY(U,$J,358.3,8230,1,4,0)
 ;;=4^J40.
 ;;^UTILITY(U,$J,358.3,8230,2)
 ;;=^17164
 ;;^UTILITY(U,$J,358.3,8231,0)
 ;;=J45.909^^33^432^7
 ;;^UTILITY(U,$J,358.3,8231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8231,1,3,0)
 ;;=3^Asthma,Uncomplicated,Unspec
 ;;^UTILITY(U,$J,358.3,8231,1,4,0)
 ;;=4^J45.909
 ;;^UTILITY(U,$J,358.3,8231,2)
 ;;=^5008256
 ;;^UTILITY(U,$J,358.3,8232,0)
 ;;=K52.9^^33^432^29
 ;;^UTILITY(U,$J,358.3,8232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8232,1,3,0)
 ;;=3^Noninfective gastroenteritis and colitis, unspecified
 ;;^UTILITY(U,$J,358.3,8232,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,8232,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,8233,0)
 ;;=M25.511^^33^432^38
 ;;^UTILITY(U,$J,358.3,8233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8233,1,3,0)
 ;;=3^Pain in right shoulder
 ;;^UTILITY(U,$J,358.3,8233,1,4,0)
 ;;=4^M25.511
 ;;^UTILITY(U,$J,358.3,8233,2)
 ;;=^5011602
 ;;^UTILITY(U,$J,358.3,8234,0)
 ;;=M25.512^^33^432^35
 ;;^UTILITY(U,$J,358.3,8234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8234,1,3,0)
 ;;=3^Pain in left shoulder
 ;;^UTILITY(U,$J,358.3,8234,1,4,0)
 ;;=4^M25.512
 ;;^UTILITY(U,$J,358.3,8234,2)
 ;;=^5011603
 ;;^UTILITY(U,$J,358.3,8235,0)
 ;;=M25.551^^33^432^36
 ;;^UTILITY(U,$J,358.3,8235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8235,1,3,0)
 ;;=3^Pain in right hip
 ;;^UTILITY(U,$J,358.3,8235,1,4,0)
 ;;=4^M25.551
 ;;^UTILITY(U,$J,358.3,8235,2)
 ;;=^5011611
 ;;^UTILITY(U,$J,358.3,8236,0)
 ;;=M25.552^^33^432^33
