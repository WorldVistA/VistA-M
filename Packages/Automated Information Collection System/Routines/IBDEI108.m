IBDEI108 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17038,1,3,0)
 ;;=3^Ulcer,Gastric w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,17038,1,4,0)
 ;;=4^K25.9
 ;;^UTILITY(U,$J,358.3,17038,2)
 ;;=^5008522
 ;;^UTILITY(U,$J,358.3,17039,0)
 ;;=K27.9^^70^806^13
 ;;^UTILITY(U,$J,358.3,17039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17039,1,3,0)
 ;;=3^Ulcer,Peptic w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,17039,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,17039,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,17040,0)
 ;;=N34.1^^70^806^15
 ;;^UTILITY(U,$J,358.3,17040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17040,1,3,0)
 ;;=3^Urethritis, nonspec
 ;;^UTILITY(U,$J,358.3,17040,1,4,0)
 ;;=4^N34.1
 ;;^UTILITY(U,$J,358.3,17040,2)
 ;;=^5015655
 ;;^UTILITY(U,$J,358.3,17041,0)
 ;;=R33.9^^70^806^17
 ;;^UTILITY(U,$J,358.3,17041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17041,1,3,0)
 ;;=3^Urinary Retention,Unspec
 ;;^UTILITY(U,$J,358.3,17041,1,4,0)
 ;;=4^R33.9
 ;;^UTILITY(U,$J,358.3,17041,2)
 ;;=^5019332
 ;;^UTILITY(U,$J,358.3,17042,0)
 ;;=N34.2^^70^806^16
 ;;^UTILITY(U,$J,358.3,17042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17042,1,3,0)
 ;;=3^Urethritis, other
 ;;^UTILITY(U,$J,358.3,17042,1,4,0)
 ;;=4^N34.2
 ;;^UTILITY(U,$J,358.3,17042,2)
 ;;=^88231
 ;;^UTILITY(U,$J,358.3,17043,0)
 ;;=R32.^^70^806^18
 ;;^UTILITY(U,$J,358.3,17043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17043,1,3,0)
 ;;=3^Urinary incontinence, unspec
 ;;^UTILITY(U,$J,358.3,17043,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,17043,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,17044,0)
 ;;=K08.8^^70^806^2
 ;;^UTILITY(U,$J,358.3,17044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17044,1,3,0)
 ;;=3^Teeth/Supporting Structure DO (Toothache)
 ;;^UTILITY(U,$J,358.3,17044,1,4,0)
 ;;=4^K08.8
 ;;^UTILITY(U,$J,358.3,17044,2)
 ;;=^5008467
 ;;^UTILITY(U,$J,358.3,17045,0)
 ;;=N39.0^^70^806^19
 ;;^UTILITY(U,$J,358.3,17045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17045,1,3,0)
 ;;=3^Urinary tract infect, site not specified
 ;;^UTILITY(U,$J,358.3,17045,1,4,0)
 ;;=4^N39.0
 ;;^UTILITY(U,$J,358.3,17045,2)
 ;;=^124436
 ;;^UTILITY(U,$J,358.3,17046,0)
 ;;=B35.6^^70^806^6
 ;;^UTILITY(U,$J,358.3,17046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17046,1,3,0)
 ;;=3^Tinea Cruris
 ;;^UTILITY(U,$J,358.3,17046,1,4,0)
 ;;=4^B35.6
 ;;^UTILITY(U,$J,358.3,17046,2)
 ;;=^119711
 ;;^UTILITY(U,$J,358.3,17047,0)
 ;;=R00.0^^70^806^1
 ;;^UTILITY(U,$J,358.3,17047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17047,1,3,0)
 ;;=3^Tachycardia,Unspec
 ;;^UTILITY(U,$J,358.3,17047,1,4,0)
 ;;=4^R00.0
 ;;^UTILITY(U,$J,358.3,17047,2)
 ;;=^5019163
 ;;^UTILITY(U,$J,358.3,17048,0)
 ;;=I83.91^^70^807^5
 ;;^UTILITY(U,$J,358.3,17048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17048,1,3,0)
 ;;=3^Varicose veins, asympt, of rt lwr extr
 ;;^UTILITY(U,$J,358.3,17048,1,4,0)
 ;;=4^I83.91
 ;;^UTILITY(U,$J,358.3,17048,2)
 ;;=^5008020
 ;;^UTILITY(U,$J,358.3,17049,0)
 ;;=I83.92^^70^807^4
 ;;^UTILITY(U,$J,358.3,17049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17049,1,3,0)
 ;;=3^Varicose veins, asympt, of lft lwr extr
 ;;^UTILITY(U,$J,358.3,17049,1,4,0)
 ;;=4^I83.92
 ;;^UTILITY(U,$J,358.3,17049,2)
 ;;=^5008021
 ;;^UTILITY(U,$J,358.3,17050,0)
 ;;=I83.93^^70^807^3
 ;;^UTILITY(U,$J,358.3,17050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17050,1,3,0)
 ;;=3^Varicose veins, asympt, of biltrl lwr extre
 ;;^UTILITY(U,$J,358.3,17050,1,4,0)
 ;;=4^I83.93
 ;;^UTILITY(U,$J,358.3,17050,2)
 ;;=^5008022
 ;;^UTILITY(U,$J,358.3,17051,0)
 ;;=H54.7^^70^807^7
 ;;^UTILITY(U,$J,358.3,17051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17051,1,3,0)
 ;;=3^Visual loss, unspec
