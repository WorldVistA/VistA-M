IBDEI0HX ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8031,1,4,0)
 ;;=4^H57.13
 ;;^UTILITY(U,$J,358.3,8031,2)
 ;;=^5006384
 ;;^UTILITY(U,$J,358.3,8032,0)
 ;;=H57.12^^55^534^99
 ;;^UTILITY(U,$J,358.3,8032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8032,1,3,0)
 ;;=3^Ocular pain, left eye
 ;;^UTILITY(U,$J,358.3,8032,1,4,0)
 ;;=4^H57.12
 ;;^UTILITY(U,$J,358.3,8032,2)
 ;;=^5006383
 ;;^UTILITY(U,$J,358.3,8033,0)
 ;;=H57.11^^55^534^100
 ;;^UTILITY(U,$J,358.3,8033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8033,1,3,0)
 ;;=3^Ocular pain, right eye
 ;;^UTILITY(U,$J,358.3,8033,1,4,0)
 ;;=4^H57.11
 ;;^UTILITY(U,$J,358.3,8033,2)
 ;;=^5006382
 ;;^UTILITY(U,$J,358.3,8034,0)
 ;;=H60.393^^55^534^86
 ;;^UTILITY(U,$J,358.3,8034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8034,1,3,0)
 ;;=3^Infective otitis externa, bilateral NEC
 ;;^UTILITY(U,$J,358.3,8034,1,4,0)
 ;;=4^H60.393
 ;;^UTILITY(U,$J,358.3,8034,2)
 ;;=^5006461
 ;;^UTILITY(U,$J,358.3,8035,0)
 ;;=H60.392^^55^534^87
 ;;^UTILITY(U,$J,358.3,8035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8035,1,3,0)
 ;;=3^Infective otitis externa, left ear NEC
 ;;^UTILITY(U,$J,358.3,8035,1,4,0)
 ;;=4^H60.392
 ;;^UTILITY(U,$J,358.3,8035,2)
 ;;=^5006460
 ;;^UTILITY(U,$J,358.3,8036,0)
 ;;=H60.391^^55^534^88
 ;;^UTILITY(U,$J,358.3,8036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8036,1,3,0)
 ;;=3^Infective otitis externa, right ear NEC
 ;;^UTILITY(U,$J,358.3,8036,1,4,0)
 ;;=4^H60.391
 ;;^UTILITY(U,$J,358.3,8036,2)
 ;;=^5006459
 ;;^UTILITY(U,$J,358.3,8037,0)
 ;;=H61.21^^55^534^85
 ;;^UTILITY(U,$J,358.3,8037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8037,1,3,0)
 ;;=3^Impacted cerumen, right ear
 ;;^UTILITY(U,$J,358.3,8037,1,4,0)
 ;;=4^H61.21
 ;;^UTILITY(U,$J,358.3,8037,2)
 ;;=^5006531
 ;;^UTILITY(U,$J,358.3,8038,0)
 ;;=H61.22^^55^534^84
 ;;^UTILITY(U,$J,358.3,8038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8038,1,3,0)
 ;;=3^Impacted cerumen, left ear
 ;;^UTILITY(U,$J,358.3,8038,1,4,0)
 ;;=4^H61.22
 ;;^UTILITY(U,$J,358.3,8038,2)
 ;;=^5006532
 ;;^UTILITY(U,$J,358.3,8039,0)
 ;;=H61.23^^55^534^83
 ;;^UTILITY(U,$J,358.3,8039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8039,1,3,0)
 ;;=3^Impacted cerumen, bilateral
 ;;^UTILITY(U,$J,358.3,8039,1,4,0)
 ;;=4^H61.23
 ;;^UTILITY(U,$J,358.3,8039,2)
 ;;=^5006533
 ;;^UTILITY(U,$J,358.3,8040,0)
 ;;=H61.93^^55^534^58
 ;;^UTILITY(U,$J,358.3,8040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8040,1,3,0)
 ;;=3^Disorder of Bilateral External Ears,Unspec
 ;;^UTILITY(U,$J,358.3,8040,1,4,0)
 ;;=4^H61.93
 ;;^UTILITY(U,$J,358.3,8040,2)
 ;;=^5006560
 ;;^UTILITY(U,$J,358.3,8041,0)
 ;;=H61.91^^55^534^60
 ;;^UTILITY(U,$J,358.3,8041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8041,1,3,0)
 ;;=3^Disorder of right external ear, unspecified
 ;;^UTILITY(U,$J,358.3,8041,1,4,0)
 ;;=4^H61.91
 ;;^UTILITY(U,$J,358.3,8041,2)
 ;;=^5006558
 ;;^UTILITY(U,$J,358.3,8042,0)
 ;;=H61.92^^55^534^59
 ;;^UTILITY(U,$J,358.3,8042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8042,1,3,0)
 ;;=3^Disorder of left external ear, unspecified
 ;;^UTILITY(U,$J,358.3,8042,1,4,0)
 ;;=4^H61.92
 ;;^UTILITY(U,$J,358.3,8042,2)
 ;;=^5006559
 ;;^UTILITY(U,$J,358.3,8043,0)
 ;;=H65.03^^55^534^9
 ;;^UTILITY(U,$J,358.3,8043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8043,1,3,0)
 ;;=3^Acute serous otitis media, bilateral
 ;;^UTILITY(U,$J,358.3,8043,1,4,0)
 ;;=4^H65.03
 ;;^UTILITY(U,$J,358.3,8043,2)
 ;;=^5006572
 ;;^UTILITY(U,$J,358.3,8044,0)
 ;;=H65.02^^55^534^10
 ;;^UTILITY(U,$J,358.3,8044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8044,1,3,0)
 ;;=3^Acute serous otitis media, left ear
 ;;^UTILITY(U,$J,358.3,8044,1,4,0)
 ;;=4^H65.02
