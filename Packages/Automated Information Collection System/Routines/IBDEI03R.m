IBDEI03R ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1330,1,3,0)
 ;;=3^Ototoxic hearing loss, right ear
 ;;^UTILITY(U,$J,358.3,1330,1,4,0)
 ;;=4^H91.01
 ;;^UTILITY(U,$J,358.3,1330,2)
 ;;=^5006928
 ;;^UTILITY(U,$J,358.3,1331,0)
 ;;=H91.13^^8^132^16
 ;;^UTILITY(U,$J,358.3,1331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1331,1,3,0)
 ;;=3^Presbycusis, bilateral
 ;;^UTILITY(U,$J,358.3,1331,1,4,0)
 ;;=4^H91.13
 ;;^UTILITY(U,$J,358.3,1331,2)
 ;;=^5006935
 ;;^UTILITY(U,$J,358.3,1332,0)
 ;;=H91.12^^8^132^17
 ;;^UTILITY(U,$J,358.3,1332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1332,1,3,0)
 ;;=3^Presbycusis, left ear
 ;;^UTILITY(U,$J,358.3,1332,1,4,0)
 ;;=4^H91.12
 ;;^UTILITY(U,$J,358.3,1332,2)
 ;;=^5006934
 ;;^UTILITY(U,$J,358.3,1333,0)
 ;;=H91.11^^8^132^18
 ;;^UTILITY(U,$J,358.3,1333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1333,1,3,0)
 ;;=3^Presbycusis, right ear
 ;;^UTILITY(U,$J,358.3,1333,1,4,0)
 ;;=4^H91.11
 ;;^UTILITY(U,$J,358.3,1333,2)
 ;;=^5006933
 ;;^UTILITY(U,$J,358.3,1334,0)
 ;;=H90.3^^8^132^19
 ;;^UTILITY(U,$J,358.3,1334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1334,1,3,0)
 ;;=3^Sensorineural hearing loss, bilateral
 ;;^UTILITY(U,$J,358.3,1334,1,4,0)
 ;;=4^H90.3
 ;;^UTILITY(U,$J,358.3,1334,2)
 ;;=^335328
 ;;^UTILITY(U,$J,358.3,1335,0)
 ;;=H90.42^^8^132^20
 ;;^UTILITY(U,$J,358.3,1335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1335,1,3,0)
 ;;=3^Snsrnrl hear loss, uni, left ear, w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,1335,1,4,0)
 ;;=4^H90.42
 ;;^UTILITY(U,$J,358.3,1335,2)
 ;;=^5006922
 ;;^UTILITY(U,$J,358.3,1336,0)
 ;;=H90.41^^8^132^21
 ;;^UTILITY(U,$J,358.3,1336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1336,1,3,0)
 ;;=3^Snsrnrl hear loss, uni, right ear, w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,1336,1,4,0)
 ;;=4^H90.41
 ;;^UTILITY(U,$J,358.3,1336,2)
 ;;=^5006921
 ;;^UTILITY(U,$J,358.3,1337,0)
 ;;=H91.23^^8^132^22
 ;;^UTILITY(U,$J,358.3,1337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1337,1,3,0)
 ;;=3^Sudden idiopathic hearing loss, bilateral
 ;;^UTILITY(U,$J,358.3,1337,1,4,0)
 ;;=4^H91.23
 ;;^UTILITY(U,$J,358.3,1337,2)
 ;;=^5006939
 ;;^UTILITY(U,$J,358.3,1338,0)
 ;;=H91.22^^8^132^23
 ;;^UTILITY(U,$J,358.3,1338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1338,1,3,0)
 ;;=3^Sudden idiopathic hearing loss, left ear
 ;;^UTILITY(U,$J,358.3,1338,1,4,0)
 ;;=4^H91.22
 ;;^UTILITY(U,$J,358.3,1338,2)
 ;;=^5006938
 ;;^UTILITY(U,$J,358.3,1339,0)
 ;;=H91.21^^8^132^24
 ;;^UTILITY(U,$J,358.3,1339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1339,1,3,0)
 ;;=3^Sudden idiopathic hearing loss, right ear
 ;;^UTILITY(U,$J,358.3,1339,1,4,0)
 ;;=4^H91.21
 ;;^UTILITY(U,$J,358.3,1339,2)
 ;;=^5006937
 ;;^UTILITY(U,$J,358.3,1340,0)
 ;;=H91.93^^8^132^8
 ;;^UTILITY(U,$J,358.3,1340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1340,1,3,0)
 ;;=3^Hearing Loss,Bilateral,Unspec
 ;;^UTILITY(U,$J,358.3,1340,1,4,0)
 ;;=4^H91.93
 ;;^UTILITY(U,$J,358.3,1340,2)
 ;;=^5006944
 ;;^UTILITY(U,$J,358.3,1341,0)
 ;;=H91.91^^8^132^12
 ;;^UTILITY(U,$J,358.3,1341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1341,1,3,0)
 ;;=3^Hearing Loss,Right Ear,Unspec
 ;;^UTILITY(U,$J,358.3,1341,1,4,0)
 ;;=4^H91.91
 ;;^UTILITY(U,$J,358.3,1341,2)
 ;;=^5133553
 ;;^UTILITY(U,$J,358.3,1342,0)
 ;;=H91.92^^8^132^10
 ;;^UTILITY(U,$J,358.3,1342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1342,1,3,0)
 ;;=3^Hearing Loss,Left Ear,Unspec
 ;;^UTILITY(U,$J,358.3,1342,1,4,0)
 ;;=4^H91.92
 ;;^UTILITY(U,$J,358.3,1342,2)
 ;;=^5133554
 ;;^UTILITY(U,$J,358.3,1343,0)
 ;;=H83.3X1^^8^133^3
 ;;^UTILITY(U,$J,358.3,1343,1,0)
 ;;=^358.31IA^4^2
