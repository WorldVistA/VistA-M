IBDEI0LI ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9676,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer & Inflam,Unspec
 ;;^UTILITY(U,$J,358.3,9676,1,4,0)
 ;;=4^I83.219
 ;;^UTILITY(U,$J,358.3,9676,2)
 ;;=^5008003
 ;;^UTILITY(U,$J,358.3,9677,0)
 ;;=I83.029^^39^416^1
 ;;^UTILITY(U,$J,358.3,9677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9677,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer,Unspec
 ;;^UTILITY(U,$J,358.3,9677,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,9677,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,9678,0)
 ;;=I83.229^^39^416^2
 ;;^UTILITY(U,$J,358.3,9678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9678,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer & Inflam,Unspec
 ;;^UTILITY(U,$J,358.3,9678,1,4,0)
 ;;=4^I83.229
 ;;^UTILITY(U,$J,358.3,9678,2)
 ;;=^5008010
 ;;^UTILITY(U,$J,358.3,9679,0)
 ;;=B00.81^^39^417^55
 ;;^UTILITY(U,$J,358.3,9679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9679,1,3,0)
 ;;=3^Herpesviral Hepatitis
 ;;^UTILITY(U,$J,358.3,9679,1,4,0)
 ;;=4^B00.81
 ;;^UTILITY(U,$J,358.3,9679,2)
 ;;=^5000478
 ;;^UTILITY(U,$J,358.3,9680,0)
 ;;=D25.9^^39^417^64
 ;;^UTILITY(U,$J,358.3,9680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9680,1,3,0)
 ;;=3^Leiomyoma of Uterus,Unspec
 ;;^UTILITY(U,$J,358.3,9680,1,4,0)
 ;;=4^D25.9
 ;;^UTILITY(U,$J,358.3,9680,2)
 ;;=^5002081
 ;;^UTILITY(U,$J,358.3,9681,0)
 ;;=F52.9^^39^417^103
 ;;^UTILITY(U,$J,358.3,9681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9681,1,3,0)
 ;;=3^Sexual Dysfnct Not d/t a Sub/Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,9681,1,4,0)
 ;;=4^F52.9
 ;;^UTILITY(U,$J,358.3,9681,2)
 ;;=^5003625
 ;;^UTILITY(U,$J,358.3,9682,0)
 ;;=R37.^^39^417^104
 ;;^UTILITY(U,$J,358.3,9682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9682,1,3,0)
 ;;=3^Sexual Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,9682,1,4,0)
 ;;=4^R37.
 ;;^UTILITY(U,$J,358.3,9682,2)
 ;;=^5019339
 ;;^UTILITY(U,$J,358.3,9683,0)
 ;;=N60.01^^39^417^107
 ;;^UTILITY(U,$J,358.3,9683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9683,1,3,0)
 ;;=3^Solitary Cyst of Right Breast
 ;;^UTILITY(U,$J,358.3,9683,1,4,0)
 ;;=4^N60.01
 ;;^UTILITY(U,$J,358.3,9683,2)
 ;;=^5015770
 ;;^UTILITY(U,$J,358.3,9684,0)
 ;;=N60.02^^39^417^106
 ;;^UTILITY(U,$J,358.3,9684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9684,1,3,0)
 ;;=3^Solitary Cyst of Left Breast
 ;;^UTILITY(U,$J,358.3,9684,1,4,0)
 ;;=4^N60.02
 ;;^UTILITY(U,$J,358.3,9684,2)
 ;;=^5015771
 ;;^UTILITY(U,$J,358.3,9685,0)
 ;;=N60.09^^39^417^108
 ;;^UTILITY(U,$J,358.3,9685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9685,1,3,0)
 ;;=3^Solitary Cyst of Unspec Breast
 ;;^UTILITY(U,$J,358.3,9685,1,4,0)
 ;;=4^N60.09
 ;;^UTILITY(U,$J,358.3,9685,2)
 ;;=^5015772
 ;;^UTILITY(U,$J,358.3,9686,0)
 ;;=N60.11^^39^417^27
 ;;^UTILITY(U,$J,358.3,9686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9686,1,3,0)
 ;;=3^Diffuse Cystic Mastopathy of Right Breast
 ;;^UTILITY(U,$J,358.3,9686,1,4,0)
 ;;=4^N60.11
 ;;^UTILITY(U,$J,358.3,9686,2)
 ;;=^5015773
 ;;^UTILITY(U,$J,358.3,9687,0)
 ;;=N60.12^^39^417^26
 ;;^UTILITY(U,$J,358.3,9687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9687,1,3,0)
 ;;=3^Diffuse Cystic Mastopathy of Left Breast
 ;;^UTILITY(U,$J,358.3,9687,1,4,0)
 ;;=4^N60.12
 ;;^UTILITY(U,$J,358.3,9687,2)
 ;;=^5015774
 ;;^UTILITY(U,$J,358.3,9688,0)
 ;;=N64.4^^39^417^68
 ;;^UTILITY(U,$J,358.3,9688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9688,1,3,0)
 ;;=3^Mastodynia
