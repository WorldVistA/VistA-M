IBDEI0IF ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8552,2)
 ;;=^5006459
 ;;^UTILITY(U,$J,358.3,8553,0)
 ;;=H60.392^^39^462^33
 ;;^UTILITY(U,$J,358.3,8553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8553,1,3,0)
 ;;=3^Infective otitis externa, left ear NEC
 ;;^UTILITY(U,$J,358.3,8553,1,4,0)
 ;;=4^H60.392
 ;;^UTILITY(U,$J,358.3,8553,2)
 ;;=^5006460
 ;;^UTILITY(U,$J,358.3,8554,0)
 ;;=H60.393^^39^462^32
 ;;^UTILITY(U,$J,358.3,8554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8554,1,3,0)
 ;;=3^Infective otitis externa, bilateral NEC
 ;;^UTILITY(U,$J,358.3,8554,1,4,0)
 ;;=4^H60.393
 ;;^UTILITY(U,$J,358.3,8554,2)
 ;;=^5006461
 ;;^UTILITY(U,$J,358.3,8555,0)
 ;;=H62.41^^39^462^46
 ;;^UTILITY(U,$J,358.3,8555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8555,1,3,0)
 ;;=3^Otitis externa in oth diseases classd elswhr, right ear
 ;;^UTILITY(U,$J,358.3,8555,1,4,0)
 ;;=4^H62.41
 ;;^UTILITY(U,$J,358.3,8555,2)
 ;;=^5006562
 ;;^UTILITY(U,$J,358.3,8556,0)
 ;;=H62.42^^39^462^47
 ;;^UTILITY(U,$J,358.3,8556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8556,1,3,0)
 ;;=3^Otitis externa in oth diseases classd elswhr, left ear
 ;;^UTILITY(U,$J,358.3,8556,1,4,0)
 ;;=4^H62.42
 ;;^UTILITY(U,$J,358.3,8556,2)
 ;;=^5006563
 ;;^UTILITY(U,$J,358.3,8557,0)
 ;;=H62.43^^39^462^48
 ;;^UTILITY(U,$J,358.3,8557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8557,1,3,0)
 ;;=3^Otitis externa in oth diseases classd elswhr, bilateral
 ;;^UTILITY(U,$J,358.3,8557,1,4,0)
 ;;=4^H62.43
 ;;^UTILITY(U,$J,358.3,8557,2)
 ;;=^5006564
 ;;^UTILITY(U,$J,358.3,8558,0)
 ;;=B36.9^^39^462^58
 ;;^UTILITY(U,$J,358.3,8558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8558,1,3,0)
 ;;=3^Superficial mycosis, unspecified
 ;;^UTILITY(U,$J,358.3,8558,1,4,0)
 ;;=4^B36.9
 ;;^UTILITY(U,$J,358.3,8558,2)
 ;;=^5000611
 ;;^UTILITY(U,$J,358.3,8559,0)
 ;;=H60.21^^39^462^39
 ;;^UTILITY(U,$J,358.3,8559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8559,1,3,0)
 ;;=3^Malignant otitis externa, right ear
 ;;^UTILITY(U,$J,358.3,8559,1,4,0)
 ;;=4^H60.21
 ;;^UTILITY(U,$J,358.3,8559,2)
 ;;=^5006444
 ;;^UTILITY(U,$J,358.3,8560,0)
 ;;=H60.22^^39^462^38
 ;;^UTILITY(U,$J,358.3,8560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8560,1,3,0)
 ;;=3^Malignant otitis externa, left ear
 ;;^UTILITY(U,$J,358.3,8560,1,4,0)
 ;;=4^H60.22
 ;;^UTILITY(U,$J,358.3,8560,2)
 ;;=^5006445
 ;;^UTILITY(U,$J,358.3,8561,0)
 ;;=H60.23^^39^462^37
 ;;^UTILITY(U,$J,358.3,8561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8561,1,3,0)
 ;;=3^Malignant otitis externa, bilateral
 ;;^UTILITY(U,$J,358.3,8561,1,4,0)
 ;;=4^H60.23
 ;;^UTILITY(U,$J,358.3,8561,2)
 ;;=^5006446
 ;;^UTILITY(U,$J,358.3,8562,0)
 ;;=H60.511^^39^462^2
 ;;^UTILITY(U,$J,358.3,8562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8562,1,3,0)
 ;;=3^Acute actinic otitis externa, right ear
 ;;^UTILITY(U,$J,358.3,8562,1,4,0)
 ;;=4^H60.511
 ;;^UTILITY(U,$J,358.3,8562,2)
 ;;=^5006470
 ;;^UTILITY(U,$J,358.3,8563,0)
 ;;=H60.512^^39^462^1
 ;;^UTILITY(U,$J,358.3,8563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8563,1,3,0)
 ;;=3^Acute actinic otitis externa, left ear
 ;;^UTILITY(U,$J,358.3,8563,1,4,0)
 ;;=4^H60.512
 ;;^UTILITY(U,$J,358.3,8563,2)
 ;;=^5006471
 ;;^UTILITY(U,$J,358.3,8564,0)
 ;;=H61.23^^39^462^29
 ;;^UTILITY(U,$J,358.3,8564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8564,1,3,0)
 ;;=3^Impacted cerumen, bilateral
 ;;^UTILITY(U,$J,358.3,8564,1,4,0)
 ;;=4^H61.23
 ;;^UTILITY(U,$J,358.3,8564,2)
 ;;=^5006533
 ;;^UTILITY(U,$J,358.3,8565,0)
 ;;=H61.21^^39^462^31
 ;;^UTILITY(U,$J,358.3,8565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8565,1,3,0)
 ;;=3^Impacted cerumen, right ear
 ;;^UTILITY(U,$J,358.3,8565,1,4,0)
 ;;=4^H61.21
