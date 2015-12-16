IBDEI15S ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20451,1,5,0)
 ;;=5^440.32
 ;;^UTILITY(U,$J,358.3,20451,2)
 ;;=^303288
 ;;^UTILITY(U,$J,358.3,20452,0)
 ;;=789.06^^109^1265^3
 ;;^UTILITY(U,$J,358.3,20452,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20452,1,4,0)
 ;;=4^Epigastric Pain
 ;;^UTILITY(U,$J,358.3,20452,1,5,0)
 ;;=5^789.06
 ;;^UTILITY(U,$J,358.3,20452,2)
 ;;=Epigastric Pain^303323
 ;;^UTILITY(U,$J,358.3,20453,0)
 ;;=789.07^^109^1265^4
 ;;^UTILITY(U,$J,358.3,20453,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20453,1,4,0)
 ;;=4^Generalized Abdominal Pain
 ;;^UTILITY(U,$J,358.3,20453,1,5,0)
 ;;=5^789.07
 ;;^UTILITY(U,$J,358.3,20453,2)
 ;;=Generalized Abdominal Pain^303324
 ;;^UTILITY(U,$J,358.3,20454,0)
 ;;=789.04^^109^1265^5
 ;;^UTILITY(U,$J,358.3,20454,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20454,1,4,0)
 ;;=4^LL Quad Abdominal
 ;;^UTILITY(U,$J,358.3,20454,1,5,0)
 ;;=5^789.04
 ;;^UTILITY(U,$J,358.3,20454,2)
 ;;=LL Quad Abdominal^303321
 ;;^UTILITY(U,$J,358.3,20455,0)
 ;;=789.02^^109^1265^6
 ;;^UTILITY(U,$J,358.3,20455,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20455,1,4,0)
 ;;=4^LU Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,20455,1,5,0)
 ;;=5^789.02
 ;;^UTILITY(U,$J,358.3,20455,2)
 ;;=LU Quadrant Abdominal Pain^303319
 ;;^UTILITY(U,$J,358.3,20456,0)
 ;;=789.09^^109^1265^1
 ;;^UTILITY(U,$J,358.3,20456,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20456,1,4,0)
 ;;=4^Abdominal Pain, Mult Sites
 ;;^UTILITY(U,$J,358.3,20456,1,5,0)
 ;;=5^789.09
 ;;^UTILITY(U,$J,358.3,20456,2)
 ;;=Abdominal Pain, Mult Sites^303325
 ;;^UTILITY(U,$J,358.3,20457,0)
 ;;=789.05^^109^1265^7
 ;;^UTILITY(U,$J,358.3,20457,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20457,1,4,0)
 ;;=4^Periumbilical Pain
 ;;^UTILITY(U,$J,358.3,20457,1,5,0)
 ;;=5^789.05
 ;;^UTILITY(U,$J,358.3,20457,2)
 ;;=Periumbilical Pain^303322
 ;;^UTILITY(U,$J,358.3,20458,0)
 ;;=789.03^^109^1265^8
 ;;^UTILITY(U,$J,358.3,20458,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20458,1,4,0)
 ;;=4^RL Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,20458,1,5,0)
 ;;=5^789.03
 ;;^UTILITY(U,$J,358.3,20458,2)
 ;;=RL Quadrant Abdominal Pain^303320
 ;;^UTILITY(U,$J,358.3,20459,0)
 ;;=789.01^^109^1265^9
 ;;^UTILITY(U,$J,358.3,20459,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20459,1,4,0)
 ;;=4^RU Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,20459,1,5,0)
 ;;=5^789.01
 ;;^UTILITY(U,$J,358.3,20459,2)
 ;;=RU Quadrant Abdominal Pain^303318
 ;;^UTILITY(U,$J,358.3,20460,0)
 ;;=789.00^^109^1265^2
 ;;^UTILITY(U,$J,358.3,20460,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20460,1,4,0)
 ;;=4^Abdominal Pain, Unspec
 ;;^UTILITY(U,$J,358.3,20460,1,5,0)
 ;;=5^789.00
 ;;^UTILITY(U,$J,358.3,20460,2)
 ;;=Abdominal Pain, Unspec^303317
 ;;^UTILITY(U,$J,358.3,20461,0)
 ;;=V67.09^^109^1266^4
 ;;^UTILITY(U,$J,358.3,20461,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20461,1,4,0)
 ;;=4^F/U Exam, Completed Treatment
 ;;^UTILITY(U,$J,358.3,20461,1,5,0)
 ;;=5^V67.09
 ;;^UTILITY(U,$J,358.3,20461,2)
 ;;=F/U exam, completed treatment^322080
 ;;^UTILITY(U,$J,358.3,20462,0)
 ;;=V58.73^^109^1266^1
 ;;^UTILITY(U,$J,358.3,20462,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20462,1,4,0)
 ;;=4^Aftercare After Vasc Surg
 ;;^UTILITY(U,$J,358.3,20462,1,5,0)
 ;;=5^V58.73
 ;;^UTILITY(U,$J,358.3,20462,2)
 ;;=Aftercare after Vasc Surg^295530
 ;;^UTILITY(U,$J,358.3,20463,0)
 ;;=V58.31^^109^1266^2
 ;;^UTILITY(U,$J,358.3,20463,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20463,1,4,0)
 ;;=4^Attn Rem Surg Dressing
 ;;^UTILITY(U,$J,358.3,20463,1,5,0)
 ;;=5^V58.31
 ;;^UTILITY(U,$J,358.3,20463,2)
 ;;=^334216
 ;;^UTILITY(U,$J,358.3,20464,0)
 ;;=V58.32^^109^1266^3
