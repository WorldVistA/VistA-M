IBDEI044 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1226,1,3,0)
 ;;=3^Varicose Veins,Asymptomatic,Left Lower Extremity
 ;;^UTILITY(U,$J,358.3,1226,1,4,0)
 ;;=4^I83.92
 ;;^UTILITY(U,$J,358.3,1226,2)
 ;;=^5008021
 ;;^UTILITY(U,$J,358.3,1227,0)
 ;;=I83.93^^12^135^3
 ;;^UTILITY(U,$J,358.3,1227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1227,1,3,0)
 ;;=3^Varicose Veins,Asymptomatic,Bilateral Lower Extremities
 ;;^UTILITY(U,$J,358.3,1227,1,4,0)
 ;;=4^I83.93
 ;;^UTILITY(U,$J,358.3,1227,2)
 ;;=^5008022
 ;;^UTILITY(U,$J,358.3,1228,0)
 ;;=R53.1^^12^135^9
 ;;^UTILITY(U,$J,358.3,1228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1228,1,3,0)
 ;;=3^Weakness
 ;;^UTILITY(U,$J,358.3,1228,1,4,0)
 ;;=4^R53.1
 ;;^UTILITY(U,$J,358.3,1228,2)
 ;;=^5019516
 ;;^UTILITY(U,$J,358.3,1229,0)
 ;;=R63.4^^12^135^10
 ;;^UTILITY(U,$J,358.3,1229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1229,1,3,0)
 ;;=3^Weight Loss,Abnormal
 ;;^UTILITY(U,$J,358.3,1229,1,4,0)
 ;;=4^R63.4
 ;;^UTILITY(U,$J,358.3,1229,2)
 ;;=^5019542
 ;;^UTILITY(U,$J,358.3,1230,0)
 ;;=B02.9^^12^135^11
 ;;^UTILITY(U,$J,358.3,1230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1230,1,3,0)
 ;;=3^Zoster w/o Complications
 ;;^UTILITY(U,$J,358.3,1230,1,4,0)
 ;;=4^B02.9
 ;;^UTILITY(U,$J,358.3,1230,2)
 ;;=^5000501
 ;;^UTILITY(U,$J,358.3,1231,0)
 ;;=I49.3^^12^135^6
 ;;^UTILITY(U,$J,358.3,1231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1231,1,3,0)
 ;;=3^Vetricular Premature Depolarization
 ;;^UTILITY(U,$J,358.3,1231,1,4,0)
 ;;=4^I49.3
 ;;^UTILITY(U,$J,358.3,1231,2)
 ;;=^5007233
 ;;^UTILITY(U,$J,358.3,1232,0)
 ;;=I83.019^^12^135^2
 ;;^UTILITY(U,$J,358.3,1232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1232,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer Unspec Site
 ;;^UTILITY(U,$J,358.3,1232,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,1232,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,1233,0)
 ;;=I83.029^^12^135^1
 ;;^UTILITY(U,$J,358.3,1233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1233,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer Unspec Site
 ;;^UTILITY(U,$J,358.3,1233,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,1233,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,1234,0)
 ;;=Z01.818^^12^136^3
 ;;^UTILITY(U,$J,358.3,1234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1234,1,3,0)
 ;;=3^Preporcedural Exam NEC
 ;;^UTILITY(U,$J,358.3,1234,1,4,0)
 ;;=4^Z01.818
 ;;^UTILITY(U,$J,358.3,1234,2)
 ;;=^5062628
 ;;^UTILITY(U,$J,358.3,1235,0)
 ;;=Z01.810^^12^136^4
 ;;^UTILITY(U,$J,358.3,1235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1235,1,3,0)
 ;;=3^Preprocedural Cardiovascular Exam
 ;;^UTILITY(U,$J,358.3,1235,1,4,0)
 ;;=4^Z01.810
 ;;^UTILITY(U,$J,358.3,1235,2)
 ;;=^5062625
 ;;^UTILITY(U,$J,358.3,1236,0)
 ;;=Z48.89^^12^136^7
 ;;^UTILITY(U,$J,358.3,1236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1236,1,3,0)
 ;;=3^Surgical Aftercare,Oth Specified
 ;;^UTILITY(U,$J,358.3,1236,1,4,0)
 ;;=4^Z48.89
 ;;^UTILITY(U,$J,358.3,1236,2)
 ;;=^5063055
 ;;^UTILITY(U,$J,358.3,1237,0)
 ;;=Z51.89^^12^136^1
 ;;^UTILITY(U,$J,358.3,1237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1237,1,3,0)
 ;;=3^Aftercare,Oth Specified
 ;;^UTILITY(U,$J,358.3,1237,1,4,0)
 ;;=4^Z51.89
 ;;^UTILITY(U,$J,358.3,1237,2)
 ;;=^5063065
 ;;^UTILITY(U,$J,358.3,1238,0)
 ;;=Z71.9^^12^136^2
 ;;^UTILITY(U,$J,358.3,1238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1238,1,3,0)
 ;;=3^Counseling,Unspec
 ;;^UTILITY(U,$J,358.3,1238,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,1238,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,1239,0)
 ;;=Z01.89^^12^136^6
 ;;^UTILITY(U,$J,358.3,1239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1239,1,3,0)
 ;;=3^Special Exam,Oth Specified
