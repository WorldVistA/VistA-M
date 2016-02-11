IBDEI0KC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9188,1,3,0)
 ;;=3^Vertebro-Basilar Artery Syndrome
 ;;^UTILITY(U,$J,358.3,9188,1,4,0)
 ;;=4^G45.0
 ;;^UTILITY(U,$J,358.3,9188,2)
 ;;=^5003955
 ;;^UTILITY(U,$J,358.3,9189,0)
 ;;=G45.1^^58^573^4
 ;;^UTILITY(U,$J,358.3,9189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9189,1,3,0)
 ;;=3^Carotid Artery Syndrome
 ;;^UTILITY(U,$J,358.3,9189,1,4,0)
 ;;=4^G45.1
 ;;^UTILITY(U,$J,358.3,9189,2)
 ;;=^5003956
 ;;^UTILITY(U,$J,358.3,9190,0)
 ;;=G45.3^^58^573^1
 ;;^UTILITY(U,$J,358.3,9190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9190,1,3,0)
 ;;=3^Amaurosis Fugax
 ;;^UTILITY(U,$J,358.3,9190,1,4,0)
 ;;=4^G45.3
 ;;^UTILITY(U,$J,358.3,9190,2)
 ;;=^304129
 ;;^UTILITY(U,$J,358.3,9191,0)
 ;;=G45.4^^58^573^13
 ;;^UTILITY(U,$J,358.3,9191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9191,1,3,0)
 ;;=3^Transient Global Amnesia
 ;;^UTILITY(U,$J,358.3,9191,1,4,0)
 ;;=4^G45.4
 ;;^UTILITY(U,$J,358.3,9191,2)
 ;;=^293883
 ;;^UTILITY(U,$J,358.3,9192,0)
 ;;=G45.8^^58^573^11
 ;;^UTILITY(U,$J,358.3,9192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9192,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attacks,Other
 ;;^UTILITY(U,$J,358.3,9192,1,4,0)
 ;;=4^G45.8
 ;;^UTILITY(U,$J,358.3,9192,2)
 ;;=^5003958
 ;;^UTILITY(U,$J,358.3,9193,0)
 ;;=G45.9^^58^573^12
 ;;^UTILITY(U,$J,358.3,9193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9193,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attacks,Unspec
 ;;^UTILITY(U,$J,358.3,9193,1,4,0)
 ;;=4^G45.9
 ;;^UTILITY(U,$J,358.3,9193,2)
 ;;=^5003959
 ;;^UTILITY(U,$J,358.3,9194,0)
 ;;=G46.0^^58^573^8
 ;;^UTILITY(U,$J,358.3,9194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9194,1,3,0)
 ;;=3^Middle Cerebral Artery Syndrome
 ;;^UTILITY(U,$J,358.3,9194,1,4,0)
 ;;=4^G46.0
 ;;^UTILITY(U,$J,358.3,9194,2)
 ;;=^5003960
 ;;^UTILITY(U,$J,358.3,9195,0)
 ;;=G46.1^^58^573^2
 ;;^UTILITY(U,$J,358.3,9195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9195,1,3,0)
 ;;=3^Anterior Cerebral Artery Syndrome
 ;;^UTILITY(U,$J,358.3,9195,1,4,0)
 ;;=4^G46.1
 ;;^UTILITY(U,$J,358.3,9195,2)
 ;;=^5003961
 ;;^UTILITY(U,$J,358.3,9196,0)
 ;;=G46.2^^58^573^10
 ;;^UTILITY(U,$J,358.3,9196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9196,1,3,0)
 ;;=3^Posterior Cerebral Artery Syndrome
 ;;^UTILITY(U,$J,358.3,9196,1,4,0)
 ;;=4^G46.2
 ;;^UTILITY(U,$J,358.3,9196,2)
 ;;=^5003962
 ;;^UTILITY(U,$J,358.3,9197,0)
 ;;=G46.3^^58^573^3
 ;;^UTILITY(U,$J,358.3,9197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9197,1,3,0)
 ;;=3^Brain Stem Stroke Syndrome
 ;;^UTILITY(U,$J,358.3,9197,1,4,0)
 ;;=4^G46.3
 ;;^UTILITY(U,$J,358.3,9197,2)
 ;;=^5003963
 ;;^UTILITY(U,$J,358.3,9198,0)
 ;;=G46.7^^58^573^7
 ;;^UTILITY(U,$J,358.3,9198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9198,1,3,0)
 ;;=3^Lacunar Syndromes,Other
 ;;^UTILITY(U,$J,358.3,9198,1,4,0)
 ;;=4^G46.7
 ;;^UTILITY(U,$J,358.3,9198,2)
 ;;=^5003967
 ;;^UTILITY(U,$J,358.3,9199,0)
 ;;=G46.8^^58^573^14
 ;;^UTILITY(U,$J,358.3,9199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9199,1,3,0)
 ;;=3^Vascular Syndromes of Brain in CVD,Other
 ;;^UTILITY(U,$J,358.3,9199,1,4,0)
 ;;=4^G46.8
 ;;^UTILITY(U,$J,358.3,9199,2)
 ;;=^5003968
 ;;^UTILITY(U,$J,358.3,9200,0)
 ;;=I67.2^^58^573^5
 ;;^UTILITY(U,$J,358.3,9200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9200,1,3,0)
 ;;=3^Cerebral Atherosclerosis
 ;;^UTILITY(U,$J,358.3,9200,1,4,0)
 ;;=4^I67.2
 ;;^UTILITY(U,$J,358.3,9200,2)
 ;;=^21571
 ;;^UTILITY(U,$J,358.3,9201,0)
 ;;=I69.898^^58^573^6
 ;;^UTILITY(U,$J,358.3,9201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9201,1,3,0)
 ;;=3^Cerebrovascular Disease Sequelae,Other
