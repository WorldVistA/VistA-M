IBDEI0IG ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8565,2)
 ;;=^5006531
 ;;^UTILITY(U,$J,358.3,8566,0)
 ;;=H61.22^^39^462^30
 ;;^UTILITY(U,$J,358.3,8566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8566,1,3,0)
 ;;=3^Impacted cerumen, left ear
 ;;^UTILITY(U,$J,358.3,8566,1,4,0)
 ;;=4^H61.22
 ;;^UTILITY(U,$J,358.3,8566,2)
 ;;=^5006532
 ;;^UTILITY(U,$J,358.3,8567,0)
 ;;=H68.101^^39^462^25
 ;;^UTILITY(U,$J,358.3,8567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8567,1,3,0)
 ;;=3^Eustachian Tube Obstruction,Right Ear,Unspec
 ;;^UTILITY(U,$J,358.3,8567,1,4,0)
 ;;=4^H68.101
 ;;^UTILITY(U,$J,358.3,8567,2)
 ;;=^5006658
 ;;^UTILITY(U,$J,358.3,8568,0)
 ;;=H68.102^^39^462^24
 ;;^UTILITY(U,$J,358.3,8568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8568,1,3,0)
 ;;=3^Eustachian Tube Obstruction,Left Ear,Unspec
 ;;^UTILITY(U,$J,358.3,8568,1,4,0)
 ;;=4^H68.102
 ;;^UTILITY(U,$J,358.3,8568,2)
 ;;=^5006659
 ;;^UTILITY(U,$J,358.3,8569,0)
 ;;=H68.103^^39^462^23
 ;;^UTILITY(U,$J,358.3,8569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8569,1,3,0)
 ;;=3^Eustachian Tube Obstruction,Bilateral,Unspec
 ;;^UTILITY(U,$J,358.3,8569,1,4,0)
 ;;=4^H68.103
 ;;^UTILITY(U,$J,358.3,8569,2)
 ;;=^5006660
 ;;^UTILITY(U,$J,358.3,8570,0)
 ;;=H70.11^^39^462^16
 ;;^UTILITY(U,$J,358.3,8570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8570,1,3,0)
 ;;=3^Chronic mastoiditis, right ear
 ;;^UTILITY(U,$J,358.3,8570,1,4,0)
 ;;=4^H70.11
 ;;^UTILITY(U,$J,358.3,8570,2)
 ;;=^5006698
 ;;^UTILITY(U,$J,358.3,8571,0)
 ;;=H70.12^^39^462^15
 ;;^UTILITY(U,$J,358.3,8571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8571,1,3,0)
 ;;=3^Chronic mastoiditis, left ear
 ;;^UTILITY(U,$J,358.3,8571,1,4,0)
 ;;=4^H70.12
 ;;^UTILITY(U,$J,358.3,8571,2)
 ;;=^5006699
 ;;^UTILITY(U,$J,358.3,8572,0)
 ;;=H83.01^^39^462^36
 ;;^UTILITY(U,$J,358.3,8572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8572,1,3,0)
 ;;=3^Labyrinthitis, right ear
 ;;^UTILITY(U,$J,358.3,8572,1,4,0)
 ;;=4^H83.01
 ;;^UTILITY(U,$J,358.3,8572,2)
 ;;=^5006894
 ;;^UTILITY(U,$J,358.3,8573,0)
 ;;=H83.02^^39^462^35
 ;;^UTILITY(U,$J,358.3,8573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8573,1,3,0)
 ;;=3^Labyrinthitis, left ear
 ;;^UTILITY(U,$J,358.3,8573,1,4,0)
 ;;=4^H83.02
 ;;^UTILITY(U,$J,358.3,8573,2)
 ;;=^5006895
 ;;^UTILITY(U,$J,358.3,8574,0)
 ;;=H73.001^^39^462^4
 ;;^UTILITY(U,$J,358.3,8574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8574,1,3,0)
 ;;=3^Acute myringitis, right ear
 ;;^UTILITY(U,$J,358.3,8574,1,4,0)
 ;;=4^H73.001
 ;;^UTILITY(U,$J,358.3,8574,2)
 ;;=^5006763
 ;;^UTILITY(U,$J,358.3,8575,0)
 ;;=H73.002^^39^462^3
 ;;^UTILITY(U,$J,358.3,8575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8575,1,3,0)
 ;;=3^Acute myringitis, left ear
 ;;^UTILITY(U,$J,358.3,8575,1,4,0)
 ;;=4^H73.002
 ;;^UTILITY(U,$J,358.3,8575,2)
 ;;=^5006764
 ;;^UTILITY(U,$J,358.3,8576,0)
 ;;=H71.91^^39^462^14
 ;;^UTILITY(U,$J,358.3,8576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8576,1,3,0)
 ;;=3^Cholesteatoma, right ear,Unspec
 ;;^UTILITY(U,$J,358.3,8576,1,4,0)
 ;;=4^H71.91
 ;;^UTILITY(U,$J,358.3,8576,2)
 ;;=^5006739
 ;;^UTILITY(U,$J,358.3,8577,0)
 ;;=H71.92^^39^462^13
 ;;^UTILITY(U,$J,358.3,8577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8577,1,3,0)
 ;;=3^Cholesteatoma, left ear,Unspec
 ;;^UTILITY(U,$J,358.3,8577,1,4,0)
 ;;=4^H71.92
 ;;^UTILITY(U,$J,358.3,8577,2)
 ;;=^5006740
 ;;^UTILITY(U,$J,358.3,8578,0)
 ;;=H91.21^^39^462^57
 ;;^UTILITY(U,$J,358.3,8578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8578,1,3,0)
 ;;=3^Sudden idiopathic hearing loss, right ear
 ;;^UTILITY(U,$J,358.3,8578,1,4,0)
 ;;=4^H91.21
 ;;^UTILITY(U,$J,358.3,8578,2)
 ;;=^5006937
 ;;^UTILITY(U,$J,358.3,8579,0)
 ;;=H91.22^^39^462^56
