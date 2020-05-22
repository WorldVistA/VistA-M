IBDEI1DP ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22034,2)
 ;;=^5019516
 ;;^UTILITY(U,$J,358.3,22035,0)
 ;;=R63.4^^99^1123^10
 ;;^UTILITY(U,$J,358.3,22035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22035,1,3,0)
 ;;=3^Weight loss, abnl
 ;;^UTILITY(U,$J,358.3,22035,1,4,0)
 ;;=4^R63.4
 ;;^UTILITY(U,$J,358.3,22035,2)
 ;;=^5019542
 ;;^UTILITY(U,$J,358.3,22036,0)
 ;;=B97.89^^99^1123^6
 ;;^UTILITY(U,$J,358.3,22036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22036,1,3,0)
 ;;=3^Viral agents as cause of disease, oth, classd elswhr
 ;;^UTILITY(U,$J,358.3,22036,1,4,0)
 ;;=4^B97.89
 ;;^UTILITY(U,$J,358.3,22036,2)
 ;;=^5000879
 ;;^UTILITY(U,$J,358.3,22037,0)
 ;;=I83.029^^99^1123^1
 ;;^UTILITY(U,$J,358.3,22037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22037,1,3,0)
 ;;=3^Varicose Veins Left Lower Extremity w/ Ulcer,Site Unspec
 ;;^UTILITY(U,$J,358.3,22037,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,22037,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,22038,0)
 ;;=I83.019^^99^1123^2
 ;;^UTILITY(U,$J,358.3,22038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22038,1,3,0)
 ;;=3^Varicose Veins Right Lower Extremity w/ Ulcer,Site Unspec
 ;;^UTILITY(U,$J,358.3,22038,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,22038,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,22039,0)
 ;;=R63.5^^99^1123^9
 ;;^UTILITY(U,$J,358.3,22039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22039,1,3,0)
 ;;=3^Weight Gain,Abnormal
 ;;^UTILITY(U,$J,358.3,22039,1,4,0)
 ;;=4^R63.5
 ;;^UTILITY(U,$J,358.3,22039,2)
 ;;=^5019543
 ;;^UTILITY(U,$J,358.3,22040,0)
 ;;=F50.02^^99^1124^1
 ;;^UTILITY(U,$J,358.3,22040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22040,1,3,0)
 ;;=3^Anorexia nervosa, binge eating/purging type
 ;;^UTILITY(U,$J,358.3,22040,1,4,0)
 ;;=4^F50.02
 ;;^UTILITY(U,$J,358.3,22040,2)
 ;;=^5003599
 ;;^UTILITY(U,$J,358.3,22041,0)
 ;;=F50.01^^99^1124^2
 ;;^UTILITY(U,$J,358.3,22041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22041,1,3,0)
 ;;=3^Anorexia nervosa, restricting type
 ;;^UTILITY(U,$J,358.3,22041,1,4,0)
 ;;=4^F50.01
 ;;^UTILITY(U,$J,358.3,22041,2)
 ;;=^5003598
 ;;^UTILITY(U,$J,358.3,22042,0)
 ;;=F50.00^^99^1124^3
 ;;^UTILITY(U,$J,358.3,22042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22042,1,3,0)
 ;;=3^Anorexia nervosa, unspec
 ;;^UTILITY(U,$J,358.3,22042,1,4,0)
 ;;=4^F50.00
 ;;^UTILITY(U,$J,358.3,22042,2)
 ;;=^5003597
 ;;^UTILITY(U,$J,358.3,22043,0)
 ;;=F90.9^^99^1124^4
 ;;^UTILITY(U,$J,358.3,22043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22043,1,3,0)
 ;;=3^Attention-deficit hyperact dsordr, unspec type
 ;;^UTILITY(U,$J,358.3,22043,1,4,0)
 ;;=4^F90.9
 ;;^UTILITY(U,$J,358.3,22043,2)
 ;;=^5003696
 ;;^UTILITY(U,$J,358.3,22044,0)
 ;;=F50.2^^99^1124^5
 ;;^UTILITY(U,$J,358.3,22044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22044,1,3,0)
 ;;=3^Bulimia nervosa
 ;;^UTILITY(U,$J,358.3,22044,1,4,0)
 ;;=4^F50.2
 ;;^UTILITY(U,$J,358.3,22044,2)
 ;;=^5003600
 ;;^UTILITY(U,$J,358.3,22045,0)
 ;;=F44.9^^99^1124^6
 ;;^UTILITY(U,$J,358.3,22045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22045,1,3,0)
 ;;=3^Dissociative & conversion disorder, unspec
 ;;^UTILITY(U,$J,358.3,22045,1,4,0)
 ;;=4^F44.9
 ;;^UTILITY(U,$J,358.3,22045,2)
 ;;=^5003584
 ;;^UTILITY(U,$J,358.3,22046,0)
 ;;=F50.9^^99^1124^7
 ;;^UTILITY(U,$J,358.3,22046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22046,1,3,0)
 ;;=3^Eating disorder, unspec
 ;;^UTILITY(U,$J,358.3,22046,1,4,0)
 ;;=4^F50.9
 ;;^UTILITY(U,$J,358.3,22046,2)
 ;;=^5003602
