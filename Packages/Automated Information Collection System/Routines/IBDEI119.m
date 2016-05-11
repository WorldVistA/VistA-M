IBDEI119 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17530,1,3,0)
 ;;=3^Varicose Veins Left Lower Extremity w/ Ulcer,Site Unspec
 ;;^UTILITY(U,$J,358.3,17530,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,17530,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,17531,0)
 ;;=I83.019^^73^847^2
 ;;^UTILITY(U,$J,358.3,17531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17531,1,3,0)
 ;;=3^Varicose Veins Right Lower Extremity w/ Ulcer,Site Unspec
 ;;^UTILITY(U,$J,358.3,17531,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,17531,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,17532,0)
 ;;=R63.5^^73^847^9
 ;;^UTILITY(U,$J,358.3,17532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17532,1,3,0)
 ;;=3^Weight Gain,Abnormal
 ;;^UTILITY(U,$J,358.3,17532,1,4,0)
 ;;=4^R63.5
 ;;^UTILITY(U,$J,358.3,17532,2)
 ;;=^5019543
 ;;^UTILITY(U,$J,358.3,17533,0)
 ;;=F50.02^^73^848^1
 ;;^UTILITY(U,$J,358.3,17533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17533,1,3,0)
 ;;=3^Anorexia nervosa, binge eating/purging type
 ;;^UTILITY(U,$J,358.3,17533,1,4,0)
 ;;=4^F50.02
 ;;^UTILITY(U,$J,358.3,17533,2)
 ;;=^5003599
 ;;^UTILITY(U,$J,358.3,17534,0)
 ;;=F50.01^^73^848^2
 ;;^UTILITY(U,$J,358.3,17534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17534,1,3,0)
 ;;=3^Anorexia nervosa, restricting type
 ;;^UTILITY(U,$J,358.3,17534,1,4,0)
 ;;=4^F50.01
 ;;^UTILITY(U,$J,358.3,17534,2)
 ;;=^5003598
 ;;^UTILITY(U,$J,358.3,17535,0)
 ;;=F50.00^^73^848^3
 ;;^UTILITY(U,$J,358.3,17535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17535,1,3,0)
 ;;=3^Anorexia nervosa, unspec
 ;;^UTILITY(U,$J,358.3,17535,1,4,0)
 ;;=4^F50.00
 ;;^UTILITY(U,$J,358.3,17535,2)
 ;;=^5003597
 ;;^UTILITY(U,$J,358.3,17536,0)
 ;;=F90.9^^73^848^4
 ;;^UTILITY(U,$J,358.3,17536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17536,1,3,0)
 ;;=3^Attention-deficit hyperact dsordr, unspec type
 ;;^UTILITY(U,$J,358.3,17536,1,4,0)
 ;;=4^F90.9
 ;;^UTILITY(U,$J,358.3,17536,2)
 ;;=^5003696
 ;;^UTILITY(U,$J,358.3,17537,0)
 ;;=F50.2^^73^848^5
 ;;^UTILITY(U,$J,358.3,17537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17537,1,3,0)
 ;;=3^Bulimia nervosa
 ;;^UTILITY(U,$J,358.3,17537,1,4,0)
 ;;=4^F50.2
 ;;^UTILITY(U,$J,358.3,17537,2)
 ;;=^5003600
 ;;^UTILITY(U,$J,358.3,17538,0)
 ;;=F44.9^^73^848^6
 ;;^UTILITY(U,$J,358.3,17538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17538,1,3,0)
 ;;=3^Dissociative & conversion disorder, unspec
 ;;^UTILITY(U,$J,358.3,17538,1,4,0)
 ;;=4^F44.9
 ;;^UTILITY(U,$J,358.3,17538,2)
 ;;=^5003584
 ;;^UTILITY(U,$J,358.3,17539,0)
 ;;=F50.8^^73^848^7
 ;;^UTILITY(U,$J,358.3,17539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17539,1,3,0)
 ;;=3^Eating disorder, oth
 ;;^UTILITY(U,$J,358.3,17539,1,4,0)
 ;;=4^F50.8
 ;;^UTILITY(U,$J,358.3,17539,2)
 ;;=^5003601
 ;;^UTILITY(U,$J,358.3,17540,0)
 ;;=F50.9^^73^848^8
 ;;^UTILITY(U,$J,358.3,17540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17540,1,3,0)
 ;;=3^Eating disorder, unspec
 ;;^UTILITY(U,$J,358.3,17540,1,4,0)
 ;;=4^F50.9
 ;;^UTILITY(U,$J,358.3,17540,2)
 ;;=^5003602
 ;;^UTILITY(U,$J,358.3,17541,0)
 ;;=F64.1^^73^848^10
 ;;^UTILITY(U,$J,358.3,17541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17541,1,3,0)
 ;;=3^Gender ident disorder in adlscnc & adlthd
 ;;^UTILITY(U,$J,358.3,17541,1,4,0)
 ;;=4^F64.1
 ;;^UTILITY(U,$J,358.3,17541,2)
 ;;=^5003647
 ;;^UTILITY(U,$J,358.3,17542,0)
 ;;=F06.30^^73^848^12
 ;;^UTILITY(U,$J,358.3,17542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17542,1,3,0)
 ;;=3^Mood disorder d/t known physiol cond, unsp
 ;;^UTILITY(U,$J,358.3,17542,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,17542,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,17543,0)
 ;;=F23.^^73^848^16
