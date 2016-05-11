IBDEI0GE ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7579,0)
 ;;=F11.129^^30^410^33
 ;;^UTILITY(U,$J,358.3,7579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7579,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,7579,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,7579,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,7580,0)
 ;;=F10.21^^30^410^3
 ;;^UTILITY(U,$J,358.3,7580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7580,1,3,0)
 ;;=3^Alcohol Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,7580,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,7580,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,7581,0)
 ;;=F12.10^^30^410^5
 ;;^UTILITY(U,$J,358.3,7581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7581,1,3,0)
 ;;=3^Cannabis Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7581,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,7581,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,7582,0)
 ;;=F12.20^^30^410^7
 ;;^UTILITY(U,$J,358.3,7582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7582,1,3,0)
 ;;=3^Cannabis Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7582,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,7582,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,7583,0)
 ;;=F12.21^^30^410^6
 ;;^UTILITY(U,$J,358.3,7583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7583,1,3,0)
 ;;=3^Cannabis Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,7583,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,7583,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,7584,0)
 ;;=F12.90^^30^410^8
 ;;^UTILITY(U,$J,358.3,7584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7584,1,3,0)
 ;;=3^Cannabis Use,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7584,1,4,0)
 ;;=4^F12.90
 ;;^UTILITY(U,$J,358.3,7584,2)
 ;;=^5003178
 ;;^UTILITY(U,$J,358.3,7585,0)
 ;;=F10.121^^30^410^49
 ;;^UTILITY(U,$J,358.3,7585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7585,1,3,0)
 ;;=3^Alcohol Abuse w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,7585,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,7585,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,7586,0)
 ;;=I83.019^^30^411^3
 ;;^UTILITY(U,$J,358.3,7586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7586,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer,Unspec
 ;;^UTILITY(U,$J,358.3,7586,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,7586,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,7587,0)
 ;;=I83.219^^30^411^4
 ;;^UTILITY(U,$J,358.3,7587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7587,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer & Inflam,Unspec
 ;;^UTILITY(U,$J,358.3,7587,1,4,0)
 ;;=4^I83.219
 ;;^UTILITY(U,$J,358.3,7587,2)
 ;;=^5008003
 ;;^UTILITY(U,$J,358.3,7588,0)
 ;;=I83.029^^30^411^1
 ;;^UTILITY(U,$J,358.3,7588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7588,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer,Unspec
 ;;^UTILITY(U,$J,358.3,7588,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,7588,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,7589,0)
 ;;=I83.229^^30^411^2
 ;;^UTILITY(U,$J,358.3,7589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7589,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer & Inflam,Unspec
 ;;^UTILITY(U,$J,358.3,7589,1,4,0)
 ;;=4^I83.229
 ;;^UTILITY(U,$J,358.3,7589,2)
 ;;=^5008010
 ;;^UTILITY(U,$J,358.3,7590,0)
 ;;=B00.81^^30^412^25
 ;;^UTILITY(U,$J,358.3,7590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7590,1,3,0)
 ;;=3^Herpesviral Hepatitis
 ;;^UTILITY(U,$J,358.3,7590,1,4,0)
 ;;=4^B00.81
 ;;^UTILITY(U,$J,358.3,7590,2)
 ;;=^5000478
 ;;^UTILITY(U,$J,358.3,7591,0)
 ;;=D25.9^^30^412^31
 ;;^UTILITY(U,$J,358.3,7591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7591,1,3,0)
 ;;=3^Leiomyoma of Uterus,Unspec
 ;;^UTILITY(U,$J,358.3,7591,1,4,0)
 ;;=4^D25.9
 ;;^UTILITY(U,$J,358.3,7591,2)
 ;;=^5002081
