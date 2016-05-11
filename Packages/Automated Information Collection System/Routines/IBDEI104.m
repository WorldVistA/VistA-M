IBDEI104 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16985,1,3,0)
 ;;=3^Speech/Lang Deficits following Cerebvasc Infarc
 ;;^UTILITY(U,$J,358.3,16985,1,4,0)
 ;;=4^I69.328
 ;;^UTILITY(U,$J,358.3,16985,2)
 ;;=^5007495
 ;;^UTILITY(U,$J,358.3,16986,0)
 ;;=F20.2^^70^802^3
 ;;^UTILITY(U,$J,358.3,16986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16986,1,3,0)
 ;;=3^Schizophrenia, catatonic
 ;;^UTILITY(U,$J,358.3,16986,1,4,0)
 ;;=4^F20.2
 ;;^UTILITY(U,$J,358.3,16986,2)
 ;;=^5003471
 ;;^UTILITY(U,$J,358.3,16987,0)
 ;;=F20.1^^70^802^4
 ;;^UTILITY(U,$J,358.3,16987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16987,1,3,0)
 ;;=3^Schizophrenia, disorganized
 ;;^UTILITY(U,$J,358.3,16987,1,4,0)
 ;;=4^F20.1
 ;;^UTILITY(U,$J,358.3,16987,2)
 ;;=^5003470
 ;;^UTILITY(U,$J,358.3,16988,0)
 ;;=F20.0^^70^802^5
 ;;^UTILITY(U,$J,358.3,16988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16988,1,3,0)
 ;;=3^Schizophrenia, paranoid
 ;;^UTILITY(U,$J,358.3,16988,1,4,0)
 ;;=4^F20.0
 ;;^UTILITY(U,$J,358.3,16988,2)
 ;;=^5003469
 ;;^UTILITY(U,$J,358.3,16989,0)
 ;;=F20.5^^70^802^6
 ;;^UTILITY(U,$J,358.3,16989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16989,1,3,0)
 ;;=3^Schizophrenia, residual
 ;;^UTILITY(U,$J,358.3,16989,1,4,0)
 ;;=4^F20.5
 ;;^UTILITY(U,$J,358.3,16989,2)
 ;;=^5003473
 ;;^UTILITY(U,$J,358.3,16990,0)
 ;;=F25.9^^70^802^1
 ;;^UTILITY(U,$J,358.3,16990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16990,1,3,0)
 ;;=3^Schizoaffective disorder, unspec
 ;;^UTILITY(U,$J,358.3,16990,1,4,0)
 ;;=4^F25.9
 ;;^UTILITY(U,$J,358.3,16990,2)
 ;;=^331857
 ;;^UTILITY(U,$J,358.3,16991,0)
 ;;=F20.9^^70^802^7
 ;;^UTILITY(U,$J,358.3,16991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16991,1,3,0)
 ;;=3^Schizophrenia, unspec
 ;;^UTILITY(U,$J,358.3,16991,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,16991,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,16992,0)
 ;;=F20.81^^70^802^8
 ;;^UTILITY(U,$J,358.3,16992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16992,1,3,0)
 ;;=3^Schizophreniform disorder
 ;;^UTILITY(U,$J,358.3,16992,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,16992,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,16993,0)
 ;;=F60.1^^70^802^2
 ;;^UTILITY(U,$J,358.3,16993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16993,1,3,0)
 ;;=3^Schizoid personality disorder
 ;;^UTILITY(U,$J,358.3,16993,1,4,0)
 ;;=4^F60.1
 ;;^UTILITY(U,$J,358.3,16993,2)
 ;;=^108271
 ;;^UTILITY(U,$J,358.3,16994,0)
 ;;=Z11.1^^70^803^3
 ;;^UTILITY(U,$J,358.3,16994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16994,1,3,0)
 ;;=3^Screening for Resp Tuberculosis
 ;;^UTILITY(U,$J,358.3,16994,1,4,0)
 ;;=4^Z11.1
 ;;^UTILITY(U,$J,358.3,16994,2)
 ;;=^5062670
 ;;^UTILITY(U,$J,358.3,16995,0)
 ;;=Z13.89^^70^803^2
 ;;^UTILITY(U,$J,358.3,16995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16995,1,3,0)
 ;;=3^Screening for Other Disorders
 ;;^UTILITY(U,$J,358.3,16995,1,4,0)
 ;;=4^Z13.89
 ;;^UTILITY(U,$J,358.3,16995,2)
 ;;=^5062720
 ;;^UTILITY(U,$J,358.3,16996,0)
 ;;=Z12.9^^70^803^1
 ;;^UTILITY(U,$J,358.3,16996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16996,1,3,0)
 ;;=3^Screening for Malig Neop,Site Unspec
 ;;^UTILITY(U,$J,358.3,16996,1,4,0)
 ;;=4^Z12.9
 ;;^UTILITY(U,$J,358.3,16996,2)
 ;;=^5062698
 ;;^UTILITY(U,$J,358.3,16997,0)
 ;;=F10.10^^70^804^1
 ;;^UTILITY(U,$J,358.3,16997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16997,1,3,0)
 ;;=3^Alcohol abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,16997,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,16997,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,16998,0)
 ;;=F10.20^^70^804^3
 ;;^UTILITY(U,$J,358.3,16998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16998,1,3,0)
 ;;=3^Alcohol dependence, uncomplicated
