IBDEI0JV ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8939,1,3,0)
 ;;=3^Pyogenic Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,8939,1,4,0)
 ;;=4^M00.9
 ;;^UTILITY(U,$J,358.3,8939,2)
 ;;=^5009693
 ;;^UTILITY(U,$J,358.3,8940,0)
 ;;=M00.00^^39^403^83
 ;;^UTILITY(U,$J,358.3,8940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8940,1,3,0)
 ;;=3^Staphylococcal Arthritis,Unspec Joint
 ;;^UTILITY(U,$J,358.3,8940,1,4,0)
 ;;=4^M00.00
 ;;^UTILITY(U,$J,358.3,8940,2)
 ;;=^5009597
 ;;^UTILITY(U,$J,358.3,8941,0)
 ;;=M00.10^^39^403^69
 ;;^UTILITY(U,$J,358.3,8941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8941,1,3,0)
 ;;=3^Pneumococcal Arthritis,Unspec Joint
 ;;^UTILITY(U,$J,358.3,8941,1,4,0)
 ;;=4^M00.10
 ;;^UTILITY(U,$J,358.3,8941,2)
 ;;=^5009621
 ;;^UTILITY(U,$J,358.3,8942,0)
 ;;=M86.20^^39^403^65
 ;;^UTILITY(U,$J,358.3,8942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8942,1,3,0)
 ;;=3^Osteomyelitis,Subacute,Unspec Site
 ;;^UTILITY(U,$J,358.3,8942,1,4,0)
 ;;=4^M86.20
 ;;^UTILITY(U,$J,358.3,8942,2)
 ;;=^5014535
 ;;^UTILITY(U,$J,358.3,8943,0)
 ;;=M86.10^^39^403^61
 ;;^UTILITY(U,$J,358.3,8943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8943,1,3,0)
 ;;=3^Osteomyelitis,Acute,Unspec Site
 ;;^UTILITY(U,$J,358.3,8943,1,4,0)
 ;;=4^M86.10
 ;;^UTILITY(U,$J,358.3,8943,2)
 ;;=^5014521
 ;;^UTILITY(U,$J,358.3,8944,0)
 ;;=M86.00^^39^403^60
 ;;^UTILITY(U,$J,358.3,8944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8944,1,3,0)
 ;;=3^Osteomyelitis,Acute Hematogenous,Unspec Site
 ;;^UTILITY(U,$J,358.3,8944,1,4,0)
 ;;=4^M86.00
 ;;^UTILITY(U,$J,358.3,8944,2)
 ;;=^5014497
 ;;^UTILITY(U,$J,358.3,8945,0)
 ;;=M86.50^^39^403^62
 ;;^UTILITY(U,$J,358.3,8945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8945,1,3,0)
 ;;=3^Osteomyelitis,Chronic Hematogenous,Unspec Site
 ;;^UTILITY(U,$J,358.3,8945,1,4,0)
 ;;=4^M86.50
 ;;^UTILITY(U,$J,358.3,8945,2)
 ;;=^5014607
 ;;^UTILITY(U,$J,358.3,8946,0)
 ;;=M86.30^^39^403^63
 ;;^UTILITY(U,$J,358.3,8946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8946,1,3,0)
 ;;=3^Osteomyelitis,Chronic Multifocal,Unspec Site
 ;;^UTILITY(U,$J,358.3,8946,1,4,0)
 ;;=4^M86.30
 ;;^UTILITY(U,$J,358.3,8946,2)
 ;;=^5014559
 ;;^UTILITY(U,$J,358.3,8947,0)
 ;;=M86.8X9^^39^403^66
 ;;^UTILITY(U,$J,358.3,8947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8947,1,3,0)
 ;;=3^Osteomyelitis,Unspec Sites
 ;;^UTILITY(U,$J,358.3,8947,1,4,0)
 ;;=4^M86.8X9
 ;;^UTILITY(U,$J,358.3,8947,2)
 ;;=^5014655
 ;;^UTILITY(U,$J,358.3,8948,0)
 ;;=M86.60^^39^403^64
 ;;^UTILITY(U,$J,358.3,8948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8948,1,3,0)
 ;;=3^Osteomyelitis,Chronic,Unspec Site
 ;;^UTILITY(U,$J,358.3,8948,1,4,0)
 ;;=4^M86.60
 ;;^UTILITY(U,$J,358.3,8948,2)
 ;;=^5014630
 ;;^UTILITY(U,$J,358.3,8949,0)
 ;;=M86.40^^39^403^59
 ;;^UTILITY(U,$J,358.3,8949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8949,1,3,0)
 ;;=3^Osteomyelitis w/ Draining Sinus,Chronic,Unspec Site
 ;;^UTILITY(U,$J,358.3,8949,1,4,0)
 ;;=4^M86.40
 ;;^UTILITY(U,$J,358.3,8949,2)
 ;;=^5014583
 ;;^UTILITY(U,$J,358.3,8950,0)
 ;;=R50.2^^39^403^26
 ;;^UTILITY(U,$J,358.3,8950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8950,1,3,0)
 ;;=3^Fever,Drug-Induced
 ;;^UTILITY(U,$J,358.3,8950,1,4,0)
 ;;=4^R50.2
 ;;^UTILITY(U,$J,358.3,8950,2)
 ;;=^5019507
 ;;^UTILITY(U,$J,358.3,8951,0)
 ;;=R50.9^^39^403^30
 ;;^UTILITY(U,$J,358.3,8951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8951,1,3,0)
 ;;=3^Fever,Unspec
