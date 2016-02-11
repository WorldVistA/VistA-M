IBDEI0K6 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9102,1,3,0)
 ;;=3^Elevated blood-pressure reading, w/o diagnosis of htn
 ;;^UTILITY(U,$J,358.3,9102,1,4,0)
 ;;=4^R03.0
 ;;^UTILITY(U,$J,358.3,9102,2)
 ;;=^5019171
 ;;^UTILITY(U,$J,358.3,9103,0)
 ;;=R41.81^^55^556^12
 ;;^UTILITY(U,$J,358.3,9103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9103,1,3,0)
 ;;=3^Age-related cognitive decline
 ;;^UTILITY(U,$J,358.3,9103,1,4,0)
 ;;=4^R41.81
 ;;^UTILITY(U,$J,358.3,9103,2)
 ;;=^5019440
 ;;^UTILITY(U,$J,358.3,9104,0)
 ;;=R09.01^^55^556^18
 ;;^UTILITY(U,$J,358.3,9104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9104,1,3,0)
 ;;=3^Asphyxia
 ;;^UTILITY(U,$J,358.3,9104,1,4,0)
 ;;=4^R09.01
 ;;^UTILITY(U,$J,358.3,9104,2)
 ;;=^11005
 ;;^UTILITY(U,$J,358.3,9105,0)
 ;;=R45.0^^55^556^83
 ;;^UTILITY(U,$J,358.3,9105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9105,1,3,0)
 ;;=3^Nervousness
 ;;^UTILITY(U,$J,358.3,9105,1,4,0)
 ;;=4^R45.0
 ;;^UTILITY(U,$J,358.3,9105,2)
 ;;=^5019461
 ;;^UTILITY(U,$J,358.3,9106,0)
 ;;=R64.^^55^556^21
 ;;^UTILITY(U,$J,358.3,9106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9106,1,3,0)
 ;;=3^Cachexia
 ;;^UTILITY(U,$J,358.3,9106,1,4,0)
 ;;=4^R64.
 ;;^UTILITY(U,$J,358.3,9106,2)
 ;;=^17920
 ;;^UTILITY(U,$J,358.3,9107,0)
 ;;=G47.30^^55^557^1
 ;;^UTILITY(U,$J,358.3,9107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9107,1,3,0)
 ;;=3^Sleep apnea, unspecified
 ;;^UTILITY(U,$J,358.3,9107,1,4,0)
 ;;=4^G47.30
 ;;^UTILITY(U,$J,358.3,9107,2)
 ;;=^5003977
 ;;^UTILITY(U,$J,358.3,9108,0)
 ;;=G47.9^^55^557^2
 ;;^UTILITY(U,$J,358.3,9108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9108,1,3,0)
 ;;=3^Sleep disorder, unspecified
 ;;^UTILITY(U,$J,358.3,9108,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,9108,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,9109,0)
 ;;=I82.401^^55^558^1
 ;;^UTILITY(U,$J,358.3,9109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9109,1,3,0)
 ;;=3^Acute embolism and thombos unsp deep veins of r low extrem
 ;;^UTILITY(U,$J,358.3,9109,1,4,0)
 ;;=4^I82.401
 ;;^UTILITY(U,$J,358.3,9109,2)
 ;;=^5007854
 ;;^UTILITY(U,$J,358.3,9110,0)
 ;;=I82.402^^55^558^2
 ;;^UTILITY(U,$J,358.3,9110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9110,1,3,0)
 ;;=3^Acute embolism and thombos unsp deep veins of l low extrem
 ;;^UTILITY(U,$J,358.3,9110,1,4,0)
 ;;=4^I82.402
 ;;^UTILITY(U,$J,358.3,9110,2)
 ;;=^5007855
 ;;^UTILITY(U,$J,358.3,9111,0)
 ;;=Z86.718^^55^558^3
 ;;^UTILITY(U,$J,358.3,9111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9111,1,3,0)
 ;;=3^Personal history of other venous thrombosis and embolism
 ;;^UTILITY(U,$J,358.3,9111,1,4,0)
 ;;=4^Z86.718
 ;;^UTILITY(U,$J,358.3,9111,2)
 ;;=^5063475
 ;;^UTILITY(U,$J,358.3,9112,0)
 ;;=D14.31^^55^559^2
 ;;^UTILITY(U,$J,358.3,9112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9112,1,3,0)
 ;;=3^Benign neoplasm of right bronchus and lung
 ;;^UTILITY(U,$J,358.3,9112,1,4,0)
 ;;=4^D14.31
 ;;^UTILITY(U,$J,358.3,9112,2)
 ;;=^5001983
 ;;^UTILITY(U,$J,358.3,9113,0)
 ;;=D14.32^^55^559^1
 ;;^UTILITY(U,$J,358.3,9113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9113,1,3,0)
 ;;=3^Benign neoplasm of left bronchus and lung
 ;;^UTILITY(U,$J,358.3,9113,1,4,0)
 ;;=4^D14.32
 ;;^UTILITY(U,$J,358.3,9113,2)
 ;;=^5001984
 ;;^UTILITY(U,$J,358.3,9114,0)
 ;;=J98.4^^55^559^3
 ;;^UTILITY(U,$J,358.3,9114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9114,1,3,0)
 ;;=3^Lung Disorders NEC
 ;;^UTILITY(U,$J,358.3,9114,1,4,0)
 ;;=4^J98.4
 ;;^UTILITY(U,$J,358.3,9114,2)
 ;;=^5008362
 ;;^UTILITY(U,$J,358.3,9115,0)
 ;;=I71.4^^55^560^1
 ;;^UTILITY(U,$J,358.3,9115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9115,1,3,0)
 ;;=3^Abdominal aortic aneurysm, without rupture
