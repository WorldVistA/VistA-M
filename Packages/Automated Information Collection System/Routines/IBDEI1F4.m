IBDEI1F4 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23673,1,3,0)
 ;;=3^Viral agents as cause of disease, oth, classd elswhr
 ;;^UTILITY(U,$J,358.3,23673,1,4,0)
 ;;=4^B97.89
 ;;^UTILITY(U,$J,358.3,23673,2)
 ;;=^5000879
 ;;^UTILITY(U,$J,358.3,23674,0)
 ;;=I83.029^^113^1145^1
 ;;^UTILITY(U,$J,358.3,23674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23674,1,3,0)
 ;;=3^Varicose Veins Left Lower Extremity w/ Ulcer,Site Unspec
 ;;^UTILITY(U,$J,358.3,23674,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,23674,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,23675,0)
 ;;=I83.019^^113^1145^2
 ;;^UTILITY(U,$J,358.3,23675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23675,1,3,0)
 ;;=3^Varicose Veins Right Lower Extremity w/ Ulcer,Site Unspec
 ;;^UTILITY(U,$J,358.3,23675,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,23675,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,23676,0)
 ;;=R63.5^^113^1145^9
 ;;^UTILITY(U,$J,358.3,23676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23676,1,3,0)
 ;;=3^Weight Gain,Abnormal
 ;;^UTILITY(U,$J,358.3,23676,1,4,0)
 ;;=4^R63.5
 ;;^UTILITY(U,$J,358.3,23676,2)
 ;;=^5019543
 ;;^UTILITY(U,$J,358.3,23677,0)
 ;;=F50.02^^113^1146^1
 ;;^UTILITY(U,$J,358.3,23677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23677,1,3,0)
 ;;=3^Anorexia nervosa, binge eating/purging type
 ;;^UTILITY(U,$J,358.3,23677,1,4,0)
 ;;=4^F50.02
 ;;^UTILITY(U,$J,358.3,23677,2)
 ;;=^5003599
 ;;^UTILITY(U,$J,358.3,23678,0)
 ;;=F50.01^^113^1146^2
 ;;^UTILITY(U,$J,358.3,23678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23678,1,3,0)
 ;;=3^Anorexia nervosa, restricting type
 ;;^UTILITY(U,$J,358.3,23678,1,4,0)
 ;;=4^F50.01
 ;;^UTILITY(U,$J,358.3,23678,2)
 ;;=^5003598
 ;;^UTILITY(U,$J,358.3,23679,0)
 ;;=F50.00^^113^1146^3
 ;;^UTILITY(U,$J,358.3,23679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23679,1,3,0)
 ;;=3^Anorexia nervosa, unspec
 ;;^UTILITY(U,$J,358.3,23679,1,4,0)
 ;;=4^F50.00
 ;;^UTILITY(U,$J,358.3,23679,2)
 ;;=^5003597
 ;;^UTILITY(U,$J,358.3,23680,0)
 ;;=F90.9^^113^1146^4
 ;;^UTILITY(U,$J,358.3,23680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23680,1,3,0)
 ;;=3^Attention-deficit hyperact dsordr, unspec type
 ;;^UTILITY(U,$J,358.3,23680,1,4,0)
 ;;=4^F90.9
 ;;^UTILITY(U,$J,358.3,23680,2)
 ;;=^5003696
 ;;^UTILITY(U,$J,358.3,23681,0)
 ;;=F50.2^^113^1146^5
 ;;^UTILITY(U,$J,358.3,23681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23681,1,3,0)
 ;;=3^Bulimia nervosa
 ;;^UTILITY(U,$J,358.3,23681,1,4,0)
 ;;=4^F50.2
 ;;^UTILITY(U,$J,358.3,23681,2)
 ;;=^5003600
 ;;^UTILITY(U,$J,358.3,23682,0)
 ;;=F44.9^^113^1146^6
 ;;^UTILITY(U,$J,358.3,23682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23682,1,3,0)
 ;;=3^Dissociative & conversion disorder, unspec
 ;;^UTILITY(U,$J,358.3,23682,1,4,0)
 ;;=4^F44.9
 ;;^UTILITY(U,$J,358.3,23682,2)
 ;;=^5003584
 ;;^UTILITY(U,$J,358.3,23683,0)
 ;;=F50.8^^113^1146^7
 ;;^UTILITY(U,$J,358.3,23683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23683,1,3,0)
 ;;=3^Eating disorder, oth
 ;;^UTILITY(U,$J,358.3,23683,1,4,0)
 ;;=4^F50.8
 ;;^UTILITY(U,$J,358.3,23683,2)
 ;;=^5003601
 ;;^UTILITY(U,$J,358.3,23684,0)
 ;;=F50.9^^113^1146^8
 ;;^UTILITY(U,$J,358.3,23684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23684,1,3,0)
 ;;=3^Eating disorder, unspec
 ;;^UTILITY(U,$J,358.3,23684,1,4,0)
 ;;=4^F50.9
 ;;^UTILITY(U,$J,358.3,23684,2)
 ;;=^5003602
 ;;^UTILITY(U,$J,358.3,23685,0)
 ;;=F64.1^^113^1146^10
 ;;^UTILITY(U,$J,358.3,23685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23685,1,3,0)
 ;;=3^Gender ident disorder in adlscnc & adlthd
 ;;^UTILITY(U,$J,358.3,23685,1,4,0)
 ;;=4^F64.1
 ;;^UTILITY(U,$J,358.3,23685,2)
 ;;=^5003647
