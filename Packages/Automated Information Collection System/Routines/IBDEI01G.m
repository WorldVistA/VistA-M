IBDEI01G ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,124,1,3,0)
 ;;=3^Ototoxic hearing loss, right ear
 ;;^UTILITY(U,$J,358.3,124,1,4,0)
 ;;=4^H91.01
 ;;^UTILITY(U,$J,358.3,124,2)
 ;;=^5006928
 ;;^UTILITY(U,$J,358.3,125,0)
 ;;=H91.13^^1^7^16
 ;;^UTILITY(U,$J,358.3,125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,125,1,3,0)
 ;;=3^Presbycusis, bilateral
 ;;^UTILITY(U,$J,358.3,125,1,4,0)
 ;;=4^H91.13
 ;;^UTILITY(U,$J,358.3,125,2)
 ;;=^5006935
 ;;^UTILITY(U,$J,358.3,126,0)
 ;;=H91.12^^1^7^17
 ;;^UTILITY(U,$J,358.3,126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,126,1,3,0)
 ;;=3^Presbycusis, left ear
 ;;^UTILITY(U,$J,358.3,126,1,4,0)
 ;;=4^H91.12
 ;;^UTILITY(U,$J,358.3,126,2)
 ;;=^5006934
 ;;^UTILITY(U,$J,358.3,127,0)
 ;;=H91.11^^1^7^18
 ;;^UTILITY(U,$J,358.3,127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,127,1,3,0)
 ;;=3^Presbycusis, right ear
 ;;^UTILITY(U,$J,358.3,127,1,4,0)
 ;;=4^H91.11
 ;;^UTILITY(U,$J,358.3,127,2)
 ;;=^5006933
 ;;^UTILITY(U,$J,358.3,128,0)
 ;;=H90.3^^1^7^19
 ;;^UTILITY(U,$J,358.3,128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,128,1,3,0)
 ;;=3^Sensorineural hearing loss, bilateral
 ;;^UTILITY(U,$J,358.3,128,1,4,0)
 ;;=4^H90.3
 ;;^UTILITY(U,$J,358.3,128,2)
 ;;=^335328
 ;;^UTILITY(U,$J,358.3,129,0)
 ;;=H90.42^^1^7^20
 ;;^UTILITY(U,$J,358.3,129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,129,1,3,0)
 ;;=3^Snsrnrl hear loss, uni, left ear, w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,129,1,4,0)
 ;;=4^H90.42
 ;;^UTILITY(U,$J,358.3,129,2)
 ;;=^5006922
 ;;^UTILITY(U,$J,358.3,130,0)
 ;;=H90.41^^1^7^21
 ;;^UTILITY(U,$J,358.3,130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,130,1,3,0)
 ;;=3^Snsrnrl hear loss, uni, right ear, w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,130,1,4,0)
 ;;=4^H90.41
 ;;^UTILITY(U,$J,358.3,130,2)
 ;;=^5006921
 ;;^UTILITY(U,$J,358.3,131,0)
 ;;=H91.23^^1^7^22
 ;;^UTILITY(U,$J,358.3,131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,131,1,3,0)
 ;;=3^Sudden idiopathic hearing loss, bilateral
 ;;^UTILITY(U,$J,358.3,131,1,4,0)
 ;;=4^H91.23
 ;;^UTILITY(U,$J,358.3,131,2)
 ;;=^5006939
 ;;^UTILITY(U,$J,358.3,132,0)
 ;;=H91.22^^1^7^23
 ;;^UTILITY(U,$J,358.3,132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,132,1,3,0)
 ;;=3^Sudden idiopathic hearing loss, left ear
 ;;^UTILITY(U,$J,358.3,132,1,4,0)
 ;;=4^H91.22
 ;;^UTILITY(U,$J,358.3,132,2)
 ;;=^5006938
 ;;^UTILITY(U,$J,358.3,133,0)
 ;;=H91.21^^1^7^24
 ;;^UTILITY(U,$J,358.3,133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,133,1,3,0)
 ;;=3^Sudden idiopathic hearing loss, right ear
 ;;^UTILITY(U,$J,358.3,133,1,4,0)
 ;;=4^H91.21
 ;;^UTILITY(U,$J,358.3,133,2)
 ;;=^5006937
 ;;^UTILITY(U,$J,358.3,134,0)
 ;;=H91.93^^1^7^8
 ;;^UTILITY(U,$J,358.3,134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,134,1,3,0)
 ;;=3^Hearing Loss,Bilateral,Unspec
 ;;^UTILITY(U,$J,358.3,134,1,4,0)
 ;;=4^H91.93
 ;;^UTILITY(U,$J,358.3,134,2)
 ;;=^5006944
 ;;^UTILITY(U,$J,358.3,135,0)
 ;;=H91.91^^1^7^12
 ;;^UTILITY(U,$J,358.3,135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,135,1,3,0)
 ;;=3^Hearing Loss,Right Ear,Unspec
 ;;^UTILITY(U,$J,358.3,135,1,4,0)
 ;;=4^H91.91
 ;;^UTILITY(U,$J,358.3,135,2)
 ;;=^5133553
 ;;^UTILITY(U,$J,358.3,136,0)
 ;;=H91.92^^1^7^10
 ;;^UTILITY(U,$J,358.3,136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,136,1,3,0)
 ;;=3^Hearing Loss,Left Ear,Unspec
 ;;^UTILITY(U,$J,358.3,136,1,4,0)
 ;;=4^H91.92
 ;;^UTILITY(U,$J,358.3,136,2)
 ;;=^5133554
 ;;^UTILITY(U,$J,358.3,137,0)
 ;;=H83.3X1^^1^8^3
 ;;^UTILITY(U,$J,358.3,137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,137,1,3,0)
 ;;=3^Noise effects on right inner ear
 ;;^UTILITY(U,$J,358.3,137,1,4,0)
 ;;=4^H83.3X1
 ;;^UTILITY(U,$J,358.3,137,2)
 ;;=^5006906
