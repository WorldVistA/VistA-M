IBDEI0S7 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13894,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13894,1,4,0)
 ;;=4^Abdominal Pain,Generalized
 ;;^UTILITY(U,$J,358.3,13894,1,5,0)
 ;;=5^789.07
 ;;^UTILITY(U,$J,358.3,13894,2)
 ;;=Generalized Abdominal Pain^303324
 ;;^UTILITY(U,$J,358.3,13895,0)
 ;;=789.04^^85^870^4
 ;;^UTILITY(U,$J,358.3,13895,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13895,1,4,0)
 ;;=4^Abdominal Pain,LL Quadrant
 ;;^UTILITY(U,$J,358.3,13895,1,5,0)
 ;;=5^789.04
 ;;^UTILITY(U,$J,358.3,13895,2)
 ;;=LL Quad Abdominal^303321
 ;;^UTILITY(U,$J,358.3,13896,0)
 ;;=789.02^^85^870^5
 ;;^UTILITY(U,$J,358.3,13896,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13896,1,4,0)
 ;;=4^Abdominal Pain,LU Quadrant
 ;;^UTILITY(U,$J,358.3,13896,1,5,0)
 ;;=5^789.02
 ;;^UTILITY(U,$J,358.3,13896,2)
 ;;=LU Quadrant Abdominal Pain^303319
 ;;^UTILITY(U,$J,358.3,13897,0)
 ;;=789.09^^85^870^1
 ;;^UTILITY(U,$J,358.3,13897,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13897,1,4,0)
 ;;=4^Abdominal Pain,Mult Sites
 ;;^UTILITY(U,$J,358.3,13897,1,5,0)
 ;;=5^789.09
 ;;^UTILITY(U,$J,358.3,13897,2)
 ;;=Abdominal Pain, Mult Sites^303325
 ;;^UTILITY(U,$J,358.3,13898,0)
 ;;=789.05^^85^870^9
 ;;^UTILITY(U,$J,358.3,13898,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13898,1,4,0)
 ;;=4^Periumbilical Pain
 ;;^UTILITY(U,$J,358.3,13898,1,5,0)
 ;;=5^789.05
 ;;^UTILITY(U,$J,358.3,13898,2)
 ;;=Periumbilical Pain^303322
 ;;^UTILITY(U,$J,358.3,13899,0)
 ;;=789.03^^85^870^6
 ;;^UTILITY(U,$J,358.3,13899,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13899,1,4,0)
 ;;=4^Abdominal Pain,RL Quadrant
 ;;^UTILITY(U,$J,358.3,13899,1,5,0)
 ;;=5^789.03
 ;;^UTILITY(U,$J,358.3,13899,2)
 ;;=RL Quadrant Abdominal Pain^303320
 ;;^UTILITY(U,$J,358.3,13900,0)
 ;;=789.01^^85^870^7
 ;;^UTILITY(U,$J,358.3,13900,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13900,1,4,0)
 ;;=4^Abdominal Pain,RU Quadrant
 ;;^UTILITY(U,$J,358.3,13900,1,5,0)
 ;;=5^789.01
 ;;^UTILITY(U,$J,358.3,13900,2)
 ;;=RU Quadrant Abdominal Pain^303318
 ;;^UTILITY(U,$J,358.3,13901,0)
 ;;=789.00^^85^870^2
 ;;^UTILITY(U,$J,358.3,13901,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13901,1,4,0)
 ;;=4^Abdominal Pain,Unspec
 ;;^UTILITY(U,$J,358.3,13901,1,5,0)
 ;;=5^789.00
 ;;^UTILITY(U,$J,358.3,13901,2)
 ;;=Abdominal Pain, Unspec^303317
 ;;^UTILITY(U,$J,358.3,13902,0)
 ;;=V67.09^^85^871^4
 ;;^UTILITY(U,$J,358.3,13902,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13902,1,4,0)
 ;;=4^F/U Exam, Completed Treatment
 ;;^UTILITY(U,$J,358.3,13902,1,5,0)
 ;;=5^V67.09
 ;;^UTILITY(U,$J,358.3,13902,2)
 ;;=F/U exam, completed treatment^322080
 ;;^UTILITY(U,$J,358.3,13903,0)
 ;;=V58.73^^85^871^1
 ;;^UTILITY(U,$J,358.3,13903,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13903,1,4,0)
 ;;=4^Aftercare After Vasc Surg
 ;;^UTILITY(U,$J,358.3,13903,1,5,0)
 ;;=5^V58.73
 ;;^UTILITY(U,$J,358.3,13903,2)
 ;;=Aftercare after Vasc Surg^295530
 ;;^UTILITY(U,$J,358.3,13904,0)
 ;;=V58.31^^85^871^2
 ;;^UTILITY(U,$J,358.3,13904,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13904,1,4,0)
 ;;=4^Attn Rem Surg Dressing
 ;;^UTILITY(U,$J,358.3,13904,1,5,0)
 ;;=5^V58.31
 ;;^UTILITY(U,$J,358.3,13904,2)
 ;;=^334216
 ;;^UTILITY(U,$J,358.3,13905,0)
 ;;=V58.32^^85^871^3
 ;;^UTILITY(U,$J,358.3,13905,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13905,1,4,0)
 ;;=4^Attn Removal Of Sutures
 ;;^UTILITY(U,$J,358.3,13905,1,5,0)
 ;;=5^V58.32
 ;;^UTILITY(U,$J,358.3,13905,2)
 ;;=^334217
 ;;^UTILITY(U,$J,358.3,13906,0)
 ;;=250.62^^85^872^31
 ;;^UTILITY(U,$J,358.3,13906,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13906,1,4,0)
 ;;=4^DMII Neuro Uncntrld
 ;;^UTILITY(U,$J,358.3,13906,1,5,0)
 ;;=5^250.62
