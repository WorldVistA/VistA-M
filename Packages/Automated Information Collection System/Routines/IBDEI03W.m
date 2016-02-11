IBDEI03W ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1117,1,3,0)
 ;;=3^Osteomyelofibrosis
 ;;^UTILITY(U,$J,358.3,1117,1,4,0)
 ;;=4^D47.4
 ;;^UTILITY(U,$J,358.3,1117,2)
 ;;=^5002259
 ;;^UTILITY(U,$J,358.3,1118,0)
 ;;=I34.1^^12^130^10
 ;;^UTILITY(U,$J,358.3,1118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1118,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,1118,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,1118,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,1119,0)
 ;;=E66.9^^12^130^12
 ;;^UTILITY(U,$J,358.3,1119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1119,1,3,0)
 ;;=3^Obesity,Unspec
 ;;^UTILITY(U,$J,358.3,1119,1,4,0)
 ;;=4^E66.9
 ;;^UTILITY(U,$J,358.3,1119,2)
 ;;=^5002832
 ;;^UTILITY(U,$J,358.3,1120,0)
 ;;=E66.01^^12^130^11
 ;;^UTILITY(U,$J,358.3,1120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1120,1,3,0)
 ;;=3^Obesity,Morbid
 ;;^UTILITY(U,$J,358.3,1120,1,4,0)
 ;;=4^E66.01
 ;;^UTILITY(U,$J,358.3,1120,2)
 ;;=^5002826
 ;;^UTILITY(U,$J,358.3,1121,0)
 ;;=G60.9^^12^130^3
 ;;^UTILITY(U,$J,358.3,1121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1121,1,3,0)
 ;;=3^Neuropathy,Hereditary & Idiopathic Unspec
 ;;^UTILITY(U,$J,358.3,1121,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,1121,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,1122,0)
 ;;=H60.311^^12^130^24
 ;;^UTILITY(U,$J,358.3,1122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1122,1,3,0)
 ;;=3^Otitis Externa Diffused,Right Ear
 ;;^UTILITY(U,$J,358.3,1122,1,4,0)
 ;;=4^H60.311
 ;;^UTILITY(U,$J,358.3,1122,2)
 ;;=^5006447
 ;;^UTILITY(U,$J,358.3,1123,0)
 ;;=H60.312^^12^130^23
 ;;^UTILITY(U,$J,358.3,1123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1123,1,3,0)
 ;;=3^Otitis Externa Diffused,Left Ear
 ;;^UTILITY(U,$J,358.3,1123,1,4,0)
 ;;=4^H60.312
 ;;^UTILITY(U,$J,358.3,1123,2)
 ;;=^5006448
 ;;^UTILITY(U,$J,358.3,1124,0)
 ;;=H60.313^^12^130^22
 ;;^UTILITY(U,$J,358.3,1124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1124,1,3,0)
 ;;=3^Otitis Externa Diffused,Bilateral
 ;;^UTILITY(U,$J,358.3,1124,1,4,0)
 ;;=4^H60.313
 ;;^UTILITY(U,$J,358.3,1124,2)
 ;;=^5006449
 ;;^UTILITY(U,$J,358.3,1125,0)
 ;;=H60.321^^12^130^27
 ;;^UTILITY(U,$J,358.3,1125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1125,1,3,0)
 ;;=3^Otitis Externa Hemorrhagic,Right Ear
 ;;^UTILITY(U,$J,358.3,1125,1,4,0)
 ;;=4^H60.321
 ;;^UTILITY(U,$J,358.3,1125,2)
 ;;=^5006451
 ;;^UTILITY(U,$J,358.3,1126,0)
 ;;=H60.322^^12^130^26
 ;;^UTILITY(U,$J,358.3,1126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1126,1,3,0)
 ;;=3^Otitis Externa Hemorrhagic,Left Ear
 ;;^UTILITY(U,$J,358.3,1126,1,4,0)
 ;;=4^H60.322
 ;;^UTILITY(U,$J,358.3,1126,2)
 ;;=^5006452
 ;;^UTILITY(U,$J,358.3,1127,0)
 ;;=H60.323^^12^130^25
 ;;^UTILITY(U,$J,358.3,1127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1127,1,3,0)
 ;;=3^Otitis Externa Hemorrhagic,Bilateral
 ;;^UTILITY(U,$J,358.3,1127,1,4,0)
 ;;=4^H60.323
 ;;^UTILITY(U,$J,358.3,1127,2)
 ;;=^5006453
 ;;^UTILITY(U,$J,358.3,1128,0)
 ;;=H60.391^^12^130^30
 ;;^UTILITY(U,$J,358.3,1128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1128,1,3,0)
 ;;=3^Otitis Externa Infective,Right Ear
 ;;^UTILITY(U,$J,358.3,1128,1,4,0)
 ;;=4^H60.391
 ;;^UTILITY(U,$J,358.3,1128,2)
 ;;=^5006459
 ;;^UTILITY(U,$J,358.3,1129,0)
 ;;=H60.392^^12^130^29
 ;;^UTILITY(U,$J,358.3,1129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1129,1,3,0)
 ;;=3^Otitis Externa Infective,Left Ear
 ;;^UTILITY(U,$J,358.3,1129,1,4,0)
 ;;=4^H60.392
 ;;^UTILITY(U,$J,358.3,1129,2)
 ;;=^5006460
 ;;^UTILITY(U,$J,358.3,1130,0)
 ;;=H60.323^^12^130^28
 ;;^UTILITY(U,$J,358.3,1130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1130,1,3,0)
 ;;=3^Otitis Externa Infective,Bilateral
