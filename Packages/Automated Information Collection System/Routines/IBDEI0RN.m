IBDEI0RN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12688,0)
 ;;=H60.391^^77^737^34
 ;;^UTILITY(U,$J,358.3,12688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12688,1,3,0)
 ;;=3^Infective otitis externa, right ear NEC
 ;;^UTILITY(U,$J,358.3,12688,1,4,0)
 ;;=4^H60.391
 ;;^UTILITY(U,$J,358.3,12688,2)
 ;;=^5006459
 ;;^UTILITY(U,$J,358.3,12689,0)
 ;;=H60.392^^77^737^33
 ;;^UTILITY(U,$J,358.3,12689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12689,1,3,0)
 ;;=3^Infective otitis externa, left ear NEC
 ;;^UTILITY(U,$J,358.3,12689,1,4,0)
 ;;=4^H60.392
 ;;^UTILITY(U,$J,358.3,12689,2)
 ;;=^5006460
 ;;^UTILITY(U,$J,358.3,12690,0)
 ;;=H60.393^^77^737^32
 ;;^UTILITY(U,$J,358.3,12690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12690,1,3,0)
 ;;=3^Infective otitis externa, bilateral NEC
 ;;^UTILITY(U,$J,358.3,12690,1,4,0)
 ;;=4^H60.393
 ;;^UTILITY(U,$J,358.3,12690,2)
 ;;=^5006461
 ;;^UTILITY(U,$J,358.3,12691,0)
 ;;=H62.41^^77^737^46
 ;;^UTILITY(U,$J,358.3,12691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12691,1,3,0)
 ;;=3^Otitis externa in oth diseases classd elswhr, right ear
 ;;^UTILITY(U,$J,358.3,12691,1,4,0)
 ;;=4^H62.41
 ;;^UTILITY(U,$J,358.3,12691,2)
 ;;=^5006562
 ;;^UTILITY(U,$J,358.3,12692,0)
 ;;=H62.42^^77^737^47
 ;;^UTILITY(U,$J,358.3,12692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12692,1,3,0)
 ;;=3^Otitis externa in oth diseases classd elswhr, left ear
 ;;^UTILITY(U,$J,358.3,12692,1,4,0)
 ;;=4^H62.42
 ;;^UTILITY(U,$J,358.3,12692,2)
 ;;=^5006563
 ;;^UTILITY(U,$J,358.3,12693,0)
 ;;=H62.43^^77^737^48
 ;;^UTILITY(U,$J,358.3,12693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12693,1,3,0)
 ;;=3^Otitis externa in oth diseases classd elswhr, bilateral
 ;;^UTILITY(U,$J,358.3,12693,1,4,0)
 ;;=4^H62.43
 ;;^UTILITY(U,$J,358.3,12693,2)
 ;;=^5006564
 ;;^UTILITY(U,$J,358.3,12694,0)
 ;;=B36.9^^77^737^58
 ;;^UTILITY(U,$J,358.3,12694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12694,1,3,0)
 ;;=3^Superficial mycosis, unspecified
 ;;^UTILITY(U,$J,358.3,12694,1,4,0)
 ;;=4^B36.9
 ;;^UTILITY(U,$J,358.3,12694,2)
 ;;=^5000611
 ;;^UTILITY(U,$J,358.3,12695,0)
 ;;=H60.21^^77^737^39
 ;;^UTILITY(U,$J,358.3,12695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12695,1,3,0)
 ;;=3^Malignant otitis externa, right ear
 ;;^UTILITY(U,$J,358.3,12695,1,4,0)
 ;;=4^H60.21
 ;;^UTILITY(U,$J,358.3,12695,2)
 ;;=^5006444
 ;;^UTILITY(U,$J,358.3,12696,0)
 ;;=H60.22^^77^737^38
 ;;^UTILITY(U,$J,358.3,12696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12696,1,3,0)
 ;;=3^Malignant otitis externa, left ear
 ;;^UTILITY(U,$J,358.3,12696,1,4,0)
 ;;=4^H60.22
 ;;^UTILITY(U,$J,358.3,12696,2)
 ;;=^5006445
 ;;^UTILITY(U,$J,358.3,12697,0)
 ;;=H60.23^^77^737^37
 ;;^UTILITY(U,$J,358.3,12697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12697,1,3,0)
 ;;=3^Malignant otitis externa, bilateral
 ;;^UTILITY(U,$J,358.3,12697,1,4,0)
 ;;=4^H60.23
 ;;^UTILITY(U,$J,358.3,12697,2)
 ;;=^5006446
 ;;^UTILITY(U,$J,358.3,12698,0)
 ;;=H60.511^^77^737^2
 ;;^UTILITY(U,$J,358.3,12698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12698,1,3,0)
 ;;=3^Acute actinic otitis externa, right ear
 ;;^UTILITY(U,$J,358.3,12698,1,4,0)
 ;;=4^H60.511
 ;;^UTILITY(U,$J,358.3,12698,2)
 ;;=^5006470
 ;;^UTILITY(U,$J,358.3,12699,0)
 ;;=H60.512^^77^737^1
 ;;^UTILITY(U,$J,358.3,12699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12699,1,3,0)
 ;;=3^Acute actinic otitis externa, left ear
 ;;^UTILITY(U,$J,358.3,12699,1,4,0)
 ;;=4^H60.512
 ;;^UTILITY(U,$J,358.3,12699,2)
 ;;=^5006471
 ;;^UTILITY(U,$J,358.3,12700,0)
 ;;=H61.23^^77^737^29
 ;;^UTILITY(U,$J,358.3,12700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12700,1,3,0)
 ;;=3^Impacted cerumen, bilateral
