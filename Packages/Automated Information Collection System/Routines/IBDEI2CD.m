IBDEI2CD ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39329,1,4,0)
 ;;=4^M54.5
 ;;^UTILITY(U,$J,358.3,39329,2)
 ;;=^5012311
 ;;^UTILITY(U,$J,358.3,39330,0)
 ;;=M54.6^^183^2018^32
 ;;^UTILITY(U,$J,358.3,39330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39330,1,3,0)
 ;;=3^Pain in thoracic spine
 ;;^UTILITY(U,$J,358.3,39330,1,4,0)
 ;;=4^M54.6
 ;;^UTILITY(U,$J,358.3,39330,2)
 ;;=^272507
 ;;^UTILITY(U,$J,358.3,39331,0)
 ;;=M96.1^^183^2018^33
 ;;^UTILITY(U,$J,358.3,39331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39331,1,3,0)
 ;;=3^Postlaminectomy syndrome NEC
 ;;^UTILITY(U,$J,358.3,39331,1,4,0)
 ;;=4^M96.1
 ;;^UTILITY(U,$J,358.3,39331,2)
 ;;=^5015374
 ;;^UTILITY(U,$J,358.3,39332,0)
 ;;=M54.16^^183^2018^34
 ;;^UTILITY(U,$J,358.3,39332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39332,1,3,0)
 ;;=3^Radiculopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,39332,1,4,0)
 ;;=4^M54.16
 ;;^UTILITY(U,$J,358.3,39332,2)
 ;;=^5012301
 ;;^UTILITY(U,$J,358.3,39333,0)
 ;;=M54.17^^183^2018^35
 ;;^UTILITY(U,$J,358.3,39333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39333,1,3,0)
 ;;=3^Radiculopathy, lumbosacral region
 ;;^UTILITY(U,$J,358.3,39333,1,4,0)
 ;;=4^M54.17
 ;;^UTILITY(U,$J,358.3,39333,2)
 ;;=^5012302
 ;;^UTILITY(U,$J,358.3,39334,0)
 ;;=M54.14^^183^2018^36
 ;;^UTILITY(U,$J,358.3,39334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39334,1,3,0)
 ;;=3^Radiculopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,39334,1,4,0)
 ;;=4^M54.14
 ;;^UTILITY(U,$J,358.3,39334,2)
 ;;=^5012299
 ;;^UTILITY(U,$J,358.3,39335,0)
 ;;=M54.15^^183^2018^37
 ;;^UTILITY(U,$J,358.3,39335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39335,1,3,0)
 ;;=3^Radiculopathy, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,39335,1,4,0)
 ;;=4^M54.15
 ;;^UTILITY(U,$J,358.3,39335,2)
 ;;=^5012300
 ;;^UTILITY(U,$J,358.3,39336,0)
 ;;=M46.1^^183^2018^38
 ;;^UTILITY(U,$J,358.3,39336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39336,1,3,0)
 ;;=3^Sacroiliitis NEC
 ;;^UTILITY(U,$J,358.3,39336,1,4,0)
 ;;=4^M46.1
 ;;^UTILITY(U,$J,358.3,39336,2)
 ;;=^5011980
 ;;^UTILITY(U,$J,358.3,39337,0)
 ;;=M46.02^^183^2018^39
 ;;^UTILITY(U,$J,358.3,39337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39337,1,3,0)
 ;;=3^Spinal enthesopathy, cervical region
 ;;^UTILITY(U,$J,358.3,39337,1,4,0)
 ;;=4^M46.02
 ;;^UTILITY(U,$J,358.3,39337,2)
 ;;=^5011972
 ;;^UTILITY(U,$J,358.3,39338,0)
 ;;=M46.06^^183^2018^41
 ;;^UTILITY(U,$J,358.3,39338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39338,1,3,0)
 ;;=3^Spinal enthesopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,39338,1,4,0)
 ;;=4^M46.06
 ;;^UTILITY(U,$J,358.3,39338,2)
 ;;=^5011976
 ;;^UTILITY(U,$J,358.3,39339,0)
 ;;=M46.01^^183^2018^43
 ;;^UTILITY(U,$J,358.3,39339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39339,1,3,0)
 ;;=3^Spinal enthesopathy, occipito-atlanto-axial region
 ;;^UTILITY(U,$J,358.3,39339,1,4,0)
 ;;=4^M46.01
 ;;^UTILITY(U,$J,358.3,39339,2)
 ;;=^5011971
 ;;^UTILITY(U,$J,358.3,39340,0)
 ;;=M46.07^^183^2018^42
 ;;^UTILITY(U,$J,358.3,39340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39340,1,3,0)
 ;;=3^Spinal enthesopathy, lumbosacral region
 ;;^UTILITY(U,$J,358.3,39340,1,4,0)
 ;;=4^M46.07
 ;;^UTILITY(U,$J,358.3,39340,2)
 ;;=^5011977
 ;;^UTILITY(U,$J,358.3,39341,0)
 ;;=M46.05^^183^2018^45
 ;;^UTILITY(U,$J,358.3,39341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39341,1,3,0)
 ;;=3^Spinal enthesopathy, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,39341,1,4,0)
 ;;=4^M46.05
 ;;^UTILITY(U,$J,358.3,39341,2)
 ;;=^5011975
 ;;^UTILITY(U,$J,358.3,39342,0)
 ;;=M46.03^^183^2018^40
 ;;^UTILITY(U,$J,358.3,39342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39342,1,3,0)
 ;;=3^Spinal enthesopathy, cervicothoracic region
