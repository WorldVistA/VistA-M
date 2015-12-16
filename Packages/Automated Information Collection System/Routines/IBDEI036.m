IBDEI036 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,941,1,4,0)
 ;;=4^H81.01
 ;;^UTILITY(U,$J,358.3,941,2)
 ;;=^5006860
 ;;^UTILITY(U,$J,358.3,942,0)
 ;;=H81.02^^3^35^92
 ;;^UTILITY(U,$J,358.3,942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,942,1,3,0)
 ;;=3^Meniere's disease, left ear
 ;;^UTILITY(U,$J,358.3,942,1,4,0)
 ;;=4^H81.02
 ;;^UTILITY(U,$J,358.3,942,2)
 ;;=^5006861
 ;;^UTILITY(U,$J,358.3,943,0)
 ;;=H81.03^^3^35^91
 ;;^UTILITY(U,$J,358.3,943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,943,1,3,0)
 ;;=3^Meniere's disease, bilateral
 ;;^UTILITY(U,$J,358.3,943,1,4,0)
 ;;=4^H81.03
 ;;^UTILITY(U,$J,358.3,943,2)
 ;;=^5006862
 ;;^UTILITY(U,$J,358.3,944,0)
 ;;=H81.12^^3^35^26
 ;;^UTILITY(U,$J,358.3,944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,944,1,3,0)
 ;;=3^Benign paroxysmal vertigo, left ear
 ;;^UTILITY(U,$J,358.3,944,1,4,0)
 ;;=4^H81.12
 ;;^UTILITY(U,$J,358.3,944,2)
 ;;=^5006866
 ;;^UTILITY(U,$J,358.3,945,0)
 ;;=H81.11^^3^35^27
 ;;^UTILITY(U,$J,358.3,945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,945,1,3,0)
 ;;=3^Benign paroxysmal vertigo, right ear
 ;;^UTILITY(U,$J,358.3,945,1,4,0)
 ;;=4^H81.11
 ;;^UTILITY(U,$J,358.3,945,2)
 ;;=^5006865
 ;;^UTILITY(U,$J,358.3,946,0)
 ;;=H81.13^^3^35^25
 ;;^UTILITY(U,$J,358.3,946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,946,1,3,0)
 ;;=3^Benign paroxysmal vertigo, bilateral
 ;;^UTILITY(U,$J,358.3,946,1,4,0)
 ;;=4^H81.13
 ;;^UTILITY(U,$J,358.3,946,2)
 ;;=^5006867
 ;;^UTILITY(U,$J,358.3,947,0)
 ;;=H93.13^^3^35^117
 ;;^UTILITY(U,$J,358.3,947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,947,1,3,0)
 ;;=3^Tinnitus, bilateral
 ;;^UTILITY(U,$J,358.3,947,1,4,0)
 ;;=4^H93.13
 ;;^UTILITY(U,$J,358.3,947,2)
 ;;=^5006966
 ;;^UTILITY(U,$J,358.3,948,0)
 ;;=H93.12^^3^35^118
 ;;^UTILITY(U,$J,358.3,948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,948,1,3,0)
 ;;=3^Tinnitus, left ear
 ;;^UTILITY(U,$J,358.3,948,1,4,0)
 ;;=4^H93.12
 ;;^UTILITY(U,$J,358.3,948,2)
 ;;=^5006965
 ;;^UTILITY(U,$J,358.3,949,0)
 ;;=H93.11^^3^35^119
 ;;^UTILITY(U,$J,358.3,949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,949,1,3,0)
 ;;=3^Tinnitus, right ear
 ;;^UTILITY(U,$J,358.3,949,1,4,0)
 ;;=4^H93.11
 ;;^UTILITY(U,$J,358.3,949,2)
 ;;=^5006964
 ;;^UTILITY(U,$J,358.3,950,0)
 ;;=H92.01^^3^35^104
 ;;^UTILITY(U,$J,358.3,950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,950,1,3,0)
 ;;=3^Otalgia, right ear
 ;;^UTILITY(U,$J,358.3,950,1,4,0)
 ;;=4^H92.01
 ;;^UTILITY(U,$J,358.3,950,2)
 ;;=^5006945
 ;;^UTILITY(U,$J,358.3,951,0)
 ;;=H92.02^^3^35^103
 ;;^UTILITY(U,$J,358.3,951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,951,1,3,0)
 ;;=3^Otalgia, left ear
 ;;^UTILITY(U,$J,358.3,951,1,4,0)
 ;;=4^H92.02
 ;;^UTILITY(U,$J,358.3,951,2)
 ;;=^5006946
 ;;^UTILITY(U,$J,358.3,952,0)
 ;;=H92.03^^3^35^102
 ;;^UTILITY(U,$J,358.3,952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,952,1,3,0)
 ;;=3^Otalgia, bilateral
 ;;^UTILITY(U,$J,358.3,952,1,4,0)
 ;;=4^H92.03
 ;;^UTILITY(U,$J,358.3,952,2)
 ;;=^5006947
 ;;^UTILITY(U,$J,358.3,953,0)
 ;;=H91.92^^3^35^77
 ;;^UTILITY(U,$J,358.3,953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,953,1,3,0)
 ;;=3^Hearing Loss,Left Ear,Unspec
 ;;^UTILITY(U,$J,358.3,953,1,4,0)
 ;;=4^H91.92
 ;;^UTILITY(U,$J,358.3,953,2)
 ;;=^5133554
 ;;^UTILITY(U,$J,358.3,954,0)
 ;;=H91.93^^3^35^76
 ;;^UTILITY(U,$J,358.3,954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,954,1,3,0)
 ;;=3^Hearing Loss,Bilateral,Unspec
 ;;^UTILITY(U,$J,358.3,954,1,4,0)
 ;;=4^H91.93
 ;;^UTILITY(U,$J,358.3,954,2)
 ;;=^5006944
 ;;^UTILITY(U,$J,358.3,955,0)
 ;;=H91.91^^3^35^78
 ;;^UTILITY(U,$J,358.3,955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,955,1,3,0)
 ;;=3^Hearing Loss,Right Ear,Unspec
