IBDEI1MU ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29360,1,4,0)
 ;;=4^Epigastric Pain
 ;;^UTILITY(U,$J,358.3,29360,1,5,0)
 ;;=5^789.06
 ;;^UTILITY(U,$J,358.3,29360,2)
 ;;=Epigastric Pain^303323
 ;;^UTILITY(U,$J,358.3,29361,0)
 ;;=789.07^^186^1870^4
 ;;^UTILITY(U,$J,358.3,29361,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,29361,1,4,0)
 ;;=4^Generalized Abdominal Pain
 ;;^UTILITY(U,$J,358.3,29361,1,5,0)
 ;;=5^789.07
 ;;^UTILITY(U,$J,358.3,29361,2)
 ;;=Generalized Abdominal Pain^303324
 ;;^UTILITY(U,$J,358.3,29362,0)
 ;;=789.04^^186^1870^5
 ;;^UTILITY(U,$J,358.3,29362,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,29362,1,4,0)
 ;;=4^LL Quad Abdominal
 ;;^UTILITY(U,$J,358.3,29362,1,5,0)
 ;;=5^789.04
 ;;^UTILITY(U,$J,358.3,29362,2)
 ;;=LL Quad Abdominal^303321
 ;;^UTILITY(U,$J,358.3,29363,0)
 ;;=789.02^^186^1870^6
 ;;^UTILITY(U,$J,358.3,29363,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,29363,1,4,0)
 ;;=4^LU Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,29363,1,5,0)
 ;;=5^789.02
 ;;^UTILITY(U,$J,358.3,29363,2)
 ;;=LU Quadrant Abdominal Pain^303319
 ;;^UTILITY(U,$J,358.3,29364,0)
 ;;=789.09^^186^1870^1
 ;;^UTILITY(U,$J,358.3,29364,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,29364,1,4,0)
 ;;=4^Abdominal Pain, Mult Sites
 ;;^UTILITY(U,$J,358.3,29364,1,5,0)
 ;;=5^789.09
 ;;^UTILITY(U,$J,358.3,29364,2)
 ;;=Abdominal Pain, Mult Sites^303325
 ;;^UTILITY(U,$J,358.3,29365,0)
 ;;=789.05^^186^1870^7
 ;;^UTILITY(U,$J,358.3,29365,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,29365,1,4,0)
 ;;=4^Periumbilical Pain
 ;;^UTILITY(U,$J,358.3,29365,1,5,0)
 ;;=5^789.05
 ;;^UTILITY(U,$J,358.3,29365,2)
 ;;=Periumbilical Pain^303322
 ;;^UTILITY(U,$J,358.3,29366,0)
 ;;=789.03^^186^1870^8
 ;;^UTILITY(U,$J,358.3,29366,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,29366,1,4,0)
 ;;=4^RL Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,29366,1,5,0)
 ;;=5^789.03
 ;;^UTILITY(U,$J,358.3,29366,2)
 ;;=RL Quadrant Abdominal Pain^303320
 ;;^UTILITY(U,$J,358.3,29367,0)
 ;;=789.01^^186^1870^9
 ;;^UTILITY(U,$J,358.3,29367,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,29367,1,4,0)
 ;;=4^RU Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,29367,1,5,0)
 ;;=5^789.01
 ;;^UTILITY(U,$J,358.3,29367,2)
 ;;=RU Quadrant Abdominal Pain^303318
 ;;^UTILITY(U,$J,358.3,29368,0)
 ;;=789.00^^186^1870^2
 ;;^UTILITY(U,$J,358.3,29368,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,29368,1,4,0)
 ;;=4^Abdominal Pain, Unspec
 ;;^UTILITY(U,$J,358.3,29368,1,5,0)
 ;;=5^789.00
 ;;^UTILITY(U,$J,358.3,29368,2)
 ;;=Abdominal Pain, Unspec^303317
 ;;^UTILITY(U,$J,358.3,29369,0)
 ;;=V67.09^^186^1871^4
 ;;^UTILITY(U,$J,358.3,29369,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,29369,1,4,0)
 ;;=4^F/U Exam, Completed Treatment
 ;;^UTILITY(U,$J,358.3,29369,1,5,0)
 ;;=5^V67.09
 ;;^UTILITY(U,$J,358.3,29369,2)
 ;;=F/U exam, completed treatment^322080
 ;;^UTILITY(U,$J,358.3,29370,0)
 ;;=V58.73^^186^1871^1
 ;;^UTILITY(U,$J,358.3,29370,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,29370,1,4,0)
 ;;=4^Aftercare After Vasc Surg
 ;;^UTILITY(U,$J,358.3,29370,1,5,0)
 ;;=5^V58.73
 ;;^UTILITY(U,$J,358.3,29370,2)
 ;;=Aftercare after Vasc Surg^295530
 ;;^UTILITY(U,$J,358.3,29371,0)
 ;;=V58.31^^186^1871^2
 ;;^UTILITY(U,$J,358.3,29371,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,29371,1,4,0)
 ;;=4^Attn Rem Surg Dressing
 ;;^UTILITY(U,$J,358.3,29371,1,5,0)
 ;;=5^V58.31
 ;;^UTILITY(U,$J,358.3,29371,2)
 ;;=^334216
 ;;^UTILITY(U,$J,358.3,29372,0)
 ;;=V58.32^^186^1871^3
 ;;^UTILITY(U,$J,358.3,29372,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,29372,1,4,0)
 ;;=4^Attn Removal Of Sutures
 ;;^UTILITY(U,$J,358.3,29372,1,5,0)
 ;;=5^V58.32
