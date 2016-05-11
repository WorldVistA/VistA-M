IBDEI0EY ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6888,1,3,0)
 ;;=3^Pyogenic Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,6888,1,4,0)
 ;;=4^M00.9
 ;;^UTILITY(U,$J,358.3,6888,2)
 ;;=^5009693
 ;;^UTILITY(U,$J,358.3,6889,0)
 ;;=M00.00^^30^398^82
 ;;^UTILITY(U,$J,358.3,6889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6889,1,3,0)
 ;;=3^Staphylococcal Arthritis,Unspec Joint
 ;;^UTILITY(U,$J,358.3,6889,1,4,0)
 ;;=4^M00.00
 ;;^UTILITY(U,$J,358.3,6889,2)
 ;;=^5009597
 ;;^UTILITY(U,$J,358.3,6890,0)
 ;;=M00.10^^30^398^69
 ;;^UTILITY(U,$J,358.3,6890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6890,1,3,0)
 ;;=3^Pneumococcal Arthritis,Unspec Joint
 ;;^UTILITY(U,$J,358.3,6890,1,4,0)
 ;;=4^M00.10
 ;;^UTILITY(U,$J,358.3,6890,2)
 ;;=^5009621
 ;;^UTILITY(U,$J,358.3,6891,0)
 ;;=M86.20^^30^398^63
 ;;^UTILITY(U,$J,358.3,6891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6891,1,3,0)
 ;;=3^Osteomyelitis,Subacute,Unspec Site
 ;;^UTILITY(U,$J,358.3,6891,1,4,0)
 ;;=4^M86.20
 ;;^UTILITY(U,$J,358.3,6891,2)
 ;;=^5014535
 ;;^UTILITY(U,$J,358.3,6892,0)
 ;;=M86.10^^30^398^59
 ;;^UTILITY(U,$J,358.3,6892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6892,1,3,0)
 ;;=3^Osteomyelitis,Acute,Unspec Site
 ;;^UTILITY(U,$J,358.3,6892,1,4,0)
 ;;=4^M86.10
 ;;^UTILITY(U,$J,358.3,6892,2)
 ;;=^5014521
 ;;^UTILITY(U,$J,358.3,6893,0)
 ;;=M86.00^^30^398^58
 ;;^UTILITY(U,$J,358.3,6893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6893,1,3,0)
 ;;=3^Osteomyelitis,Acute Hematogenous,Unspec Site
 ;;^UTILITY(U,$J,358.3,6893,1,4,0)
 ;;=4^M86.00
 ;;^UTILITY(U,$J,358.3,6893,2)
 ;;=^5014497
 ;;^UTILITY(U,$J,358.3,6894,0)
 ;;=M86.50^^30^398^60
 ;;^UTILITY(U,$J,358.3,6894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6894,1,3,0)
 ;;=3^Osteomyelitis,Chronic Hematogenous,Unspec Site
 ;;^UTILITY(U,$J,358.3,6894,1,4,0)
 ;;=4^M86.50
 ;;^UTILITY(U,$J,358.3,6894,2)
 ;;=^5014607
 ;;^UTILITY(U,$J,358.3,6895,0)
 ;;=M86.30^^30^398^61
 ;;^UTILITY(U,$J,358.3,6895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6895,1,3,0)
 ;;=3^Osteomyelitis,Chronic Multifocal,Unspec Site
 ;;^UTILITY(U,$J,358.3,6895,1,4,0)
 ;;=4^M86.30
 ;;^UTILITY(U,$J,358.3,6895,2)
 ;;=^5014559
 ;;^UTILITY(U,$J,358.3,6896,0)
 ;;=M86.8X9^^30^398^64
 ;;^UTILITY(U,$J,358.3,6896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6896,1,3,0)
 ;;=3^Osteomyelitis,Unspec Sites
 ;;^UTILITY(U,$J,358.3,6896,1,4,0)
 ;;=4^M86.8X9
 ;;^UTILITY(U,$J,358.3,6896,2)
 ;;=^5014655
 ;;^UTILITY(U,$J,358.3,6897,0)
 ;;=M86.60^^30^398^62
 ;;^UTILITY(U,$J,358.3,6897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6897,1,3,0)
 ;;=3^Osteomyelitis,Chronic,Unspec Site
 ;;^UTILITY(U,$J,358.3,6897,1,4,0)
 ;;=4^M86.60
 ;;^UTILITY(U,$J,358.3,6897,2)
 ;;=^5014630
 ;;^UTILITY(U,$J,358.3,6898,0)
 ;;=M86.40^^30^398^57
 ;;^UTILITY(U,$J,358.3,6898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6898,1,3,0)
 ;;=3^Osteomyelitis w/ Draining Sinus,Chronic,Unspec Site
 ;;^UTILITY(U,$J,358.3,6898,1,4,0)
 ;;=4^M86.40
 ;;^UTILITY(U,$J,358.3,6898,2)
 ;;=^5014583
 ;;^UTILITY(U,$J,358.3,6899,0)
 ;;=R50.2^^30^398^24
 ;;^UTILITY(U,$J,358.3,6899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6899,1,3,0)
 ;;=3^Fever,Drug-Induced
 ;;^UTILITY(U,$J,358.3,6899,1,4,0)
 ;;=4^R50.2
 ;;^UTILITY(U,$J,358.3,6899,2)
 ;;=^5019507
 ;;^UTILITY(U,$J,358.3,6900,0)
 ;;=R50.9^^30^398^28
 ;;^UTILITY(U,$J,358.3,6900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6900,1,3,0)
 ;;=3^Fever,Unspec
 ;;^UTILITY(U,$J,358.3,6900,1,4,0)
 ;;=4^R50.9
 ;;^UTILITY(U,$J,358.3,6900,2)
 ;;=^5019512
 ;;^UTILITY(U,$J,358.3,6901,0)
 ;;=R76.11^^30^398^1
 ;;^UTILITY(U,$J,358.3,6901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6901,1,3,0)
 ;;=3^Abnormal Reaction to TB Test w/o Active TB
