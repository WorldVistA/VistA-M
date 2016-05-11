IBDEI03P ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1303,1,4,0)
 ;;=4^H60.331
 ;;^UTILITY(U,$J,358.3,1303,2)
 ;;=^5006455
 ;;^UTILITY(U,$J,358.3,1304,0)
 ;;=H72.823^^8^130^35
 ;;^UTILITY(U,$J,358.3,1304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1304,1,3,0)
 ;;=3^Total perforations of tympanic membrane, bilateral
 ;;^UTILITY(U,$J,358.3,1304,1,4,0)
 ;;=4^H72.823
 ;;^UTILITY(U,$J,358.3,1304,2)
 ;;=^5006760
 ;;^UTILITY(U,$J,358.3,1305,0)
 ;;=H72.822^^8^130^36
 ;;^UTILITY(U,$J,358.3,1305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1305,1,3,0)
 ;;=3^Total perforations of tympanic membrane, left ear
 ;;^UTILITY(U,$J,358.3,1305,1,4,0)
 ;;=4^H72.822
 ;;^UTILITY(U,$J,358.3,1305,2)
 ;;=^5006759
 ;;^UTILITY(U,$J,358.3,1306,0)
 ;;=H72.821^^8^130^37
 ;;^UTILITY(U,$J,358.3,1306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1306,1,3,0)
 ;;=3^Total perforations of tympanic membrane, right ear
 ;;^UTILITY(U,$J,358.3,1306,1,4,0)
 ;;=4^H72.821
 ;;^UTILITY(U,$J,358.3,1306,2)
 ;;=^5006758
 ;;^UTILITY(U,$J,358.3,1307,0)
 ;;=H74.03^^8^130^38
 ;;^UTILITY(U,$J,358.3,1307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1307,1,3,0)
 ;;=3^Tympanosclerosis, bilateral
 ;;^UTILITY(U,$J,358.3,1307,1,4,0)
 ;;=4^H74.03
 ;;^UTILITY(U,$J,358.3,1307,2)
 ;;=^5006798
 ;;^UTILITY(U,$J,358.3,1308,0)
 ;;=H74.02^^8^130^39
 ;;^UTILITY(U,$J,358.3,1308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1308,1,3,0)
 ;;=3^Tympanosclerosis, left ear
 ;;^UTILITY(U,$J,358.3,1308,1,4,0)
 ;;=4^H74.02
 ;;^UTILITY(U,$J,358.3,1308,2)
 ;;=^5006797
 ;;^UTILITY(U,$J,358.3,1309,0)
 ;;=H74.01^^8^130^40
 ;;^UTILITY(U,$J,358.3,1309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1309,1,3,0)
 ;;=3^Tympanosclerosis, right ear
 ;;^UTILITY(U,$J,358.3,1309,1,4,0)
 ;;=4^H74.01
 ;;^UTILITY(U,$J,358.3,1309,2)
 ;;=^5006796
 ;;^UTILITY(U,$J,358.3,1310,0)
 ;;=H69.93^^8^130^15
 ;;^UTILITY(U,$J,358.3,1310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1310,1,3,0)
 ;;=3^Eustachian Tube Disorders,Bilateral,Unspec
 ;;^UTILITY(U,$J,358.3,1310,1,4,0)
 ;;=4^H69.93
 ;;^UTILITY(U,$J,358.3,1310,2)
 ;;=^5006684
 ;;^UTILITY(U,$J,358.3,1311,0)
 ;;=H69.92^^8^130^17
 ;;^UTILITY(U,$J,358.3,1311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1311,1,3,0)
 ;;=3^Eustachian Tube Disorders,Left Ear,Unspec
 ;;^UTILITY(U,$J,358.3,1311,1,4,0)
 ;;=4^H69.92
 ;;^UTILITY(U,$J,358.3,1311,2)
 ;;=^5006683
 ;;^UTILITY(U,$J,358.3,1312,0)
 ;;=H69.91^^8^130^19
 ;;^UTILITY(U,$J,358.3,1312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1312,1,3,0)
 ;;=3^Eustachian Tube Disorders,Right Ear,Unspec
 ;;^UTILITY(U,$J,358.3,1312,1,4,0)
 ;;=4^H69.91
 ;;^UTILITY(U,$J,358.3,1312,2)
 ;;=^5006682
 ;;^UTILITY(U,$J,358.3,1313,0)
 ;;=T16.1XXA^^8^131^4
 ;;^UTILITY(U,$J,358.3,1313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1313,1,3,0)
 ;;=3^Foreign body in right ear, initial encounter
 ;;^UTILITY(U,$J,358.3,1313,1,4,0)
 ;;=4^T16.1XXA
 ;;^UTILITY(U,$J,358.3,1313,2)
 ;;=^5046417
 ;;^UTILITY(U,$J,358.3,1314,0)
 ;;=T16.1XXD^^8^131^6
 ;;^UTILITY(U,$J,358.3,1314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1314,1,3,0)
 ;;=3^Foreign body in right ear, subsequent encounter
 ;;^UTILITY(U,$J,358.3,1314,1,4,0)
 ;;=4^T16.1XXD
 ;;^UTILITY(U,$J,358.3,1314,2)
 ;;=^5046418
 ;;^UTILITY(U,$J,358.3,1315,0)
 ;;=T16.1XXS^^8^131^5
 ;;^UTILITY(U,$J,358.3,1315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1315,1,3,0)
 ;;=3^Foreign body in right ear, sequela
 ;;^UTILITY(U,$J,358.3,1315,1,4,0)
 ;;=4^T16.1XXS
 ;;^UTILITY(U,$J,358.3,1315,2)
 ;;=^5046419
 ;;^UTILITY(U,$J,358.3,1316,0)
 ;;=T16.2XXA^^8^131^1
 ;;^UTILITY(U,$J,358.3,1316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1316,1,3,0)
 ;;=3^Foreign body in left ear, initial encounter
