IBDEI114 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17463,1,4,0)
 ;;=4^F20.0
 ;;^UTILITY(U,$J,358.3,17463,2)
 ;;=^5003469
 ;;^UTILITY(U,$J,358.3,17464,0)
 ;;=F20.5^^73^842^6
 ;;^UTILITY(U,$J,358.3,17464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17464,1,3,0)
 ;;=3^Schizophrenia, residual
 ;;^UTILITY(U,$J,358.3,17464,1,4,0)
 ;;=4^F20.5
 ;;^UTILITY(U,$J,358.3,17464,2)
 ;;=^5003473
 ;;^UTILITY(U,$J,358.3,17465,0)
 ;;=F25.9^^73^842^1
 ;;^UTILITY(U,$J,358.3,17465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17465,1,3,0)
 ;;=3^Schizoaffective disorder, unspec
 ;;^UTILITY(U,$J,358.3,17465,1,4,0)
 ;;=4^F25.9
 ;;^UTILITY(U,$J,358.3,17465,2)
 ;;=^331857
 ;;^UTILITY(U,$J,358.3,17466,0)
 ;;=F20.9^^73^842^7
 ;;^UTILITY(U,$J,358.3,17466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17466,1,3,0)
 ;;=3^Schizophrenia, unspec
 ;;^UTILITY(U,$J,358.3,17466,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,17466,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,17467,0)
 ;;=F20.81^^73^842^8
 ;;^UTILITY(U,$J,358.3,17467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17467,1,3,0)
 ;;=3^Schizophreniform disorder
 ;;^UTILITY(U,$J,358.3,17467,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,17467,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,17468,0)
 ;;=F60.1^^73^842^2
 ;;^UTILITY(U,$J,358.3,17468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17468,1,3,0)
 ;;=3^Schizoid personality disorder
 ;;^UTILITY(U,$J,358.3,17468,1,4,0)
 ;;=4^F60.1
 ;;^UTILITY(U,$J,358.3,17468,2)
 ;;=^108271
 ;;^UTILITY(U,$J,358.3,17469,0)
 ;;=Z11.1^^73^843^3
 ;;^UTILITY(U,$J,358.3,17469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17469,1,3,0)
 ;;=3^Screening for Resp Tuberculosis
 ;;^UTILITY(U,$J,358.3,17469,1,4,0)
 ;;=4^Z11.1
 ;;^UTILITY(U,$J,358.3,17469,2)
 ;;=^5062670
 ;;^UTILITY(U,$J,358.3,17470,0)
 ;;=Z13.89^^73^843^2
 ;;^UTILITY(U,$J,358.3,17470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17470,1,3,0)
 ;;=3^Screening for Other Disorders
 ;;^UTILITY(U,$J,358.3,17470,1,4,0)
 ;;=4^Z13.89
 ;;^UTILITY(U,$J,358.3,17470,2)
 ;;=^5062720
 ;;^UTILITY(U,$J,358.3,17471,0)
 ;;=Z12.9^^73^843^1
 ;;^UTILITY(U,$J,358.3,17471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17471,1,3,0)
 ;;=3^Screening for Malig Neop,Site Unspec
 ;;^UTILITY(U,$J,358.3,17471,1,4,0)
 ;;=4^Z12.9
 ;;^UTILITY(U,$J,358.3,17471,2)
 ;;=^5062698
 ;;^UTILITY(U,$J,358.3,17472,0)
 ;;=F10.10^^73^844^1
 ;;^UTILITY(U,$J,358.3,17472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17472,1,3,0)
 ;;=3^Alcohol abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,17472,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,17472,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,17473,0)
 ;;=F10.20^^73^844^3
 ;;^UTILITY(U,$J,358.3,17473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17473,1,3,0)
 ;;=3^Alcohol dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,17473,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,17473,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,17474,0)
 ;;=F10.229^^73^844^2
 ;;^UTILITY(U,$J,358.3,17474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17474,1,3,0)
 ;;=3^Alcohol dependence w/ intoxctn, unspec
 ;;^UTILITY(U,$J,358.3,17474,1,4,0)
 ;;=4^F10.229
 ;;^UTILITY(U,$J,358.3,17474,2)
 ;;=^5003085
 ;;^UTILITY(U,$J,358.3,17475,0)
 ;;=F12.10^^73^844^4
 ;;^UTILITY(U,$J,358.3,17475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17475,1,3,0)
 ;;=3^Cannabis abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,17475,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,17475,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,17476,0)
 ;;=F12.20^^73^844^5
 ;;^UTILITY(U,$J,358.3,17476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17476,1,3,0)
 ;;=3^Cannabis dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,17476,1,4,0)
 ;;=4^F12.20
