IBDEI11T ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16853,1,3,0)
 ;;=3^Arthritis d/t Bacteria,Unspec Joint
 ;;^UTILITY(U,$J,358.3,16853,1,4,0)
 ;;=4^M00.80
 ;;^UTILITY(U,$J,358.3,16853,2)
 ;;=^5009669
 ;;^UTILITY(U,$J,358.3,16854,0)
 ;;=M00.9^^88^881^72
 ;;^UTILITY(U,$J,358.3,16854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16854,1,3,0)
 ;;=3^Pyogenic Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,16854,1,4,0)
 ;;=4^M00.9
 ;;^UTILITY(U,$J,358.3,16854,2)
 ;;=^5009693
 ;;^UTILITY(U,$J,358.3,16855,0)
 ;;=M00.00^^88^881^78
 ;;^UTILITY(U,$J,358.3,16855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16855,1,3,0)
 ;;=3^Staphylococcal Arthritis,Unspec Joint
 ;;^UTILITY(U,$J,358.3,16855,1,4,0)
 ;;=4^M00.00
 ;;^UTILITY(U,$J,358.3,16855,2)
 ;;=^5009597
 ;;^UTILITY(U,$J,358.3,16856,0)
 ;;=M00.10^^88^881^65
 ;;^UTILITY(U,$J,358.3,16856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16856,1,3,0)
 ;;=3^Pneumococcal Arthritis,Unspec Joint
 ;;^UTILITY(U,$J,358.3,16856,1,4,0)
 ;;=4^M00.10
 ;;^UTILITY(U,$J,358.3,16856,2)
 ;;=^5009621
 ;;^UTILITY(U,$J,358.3,16857,0)
 ;;=M86.20^^88^881^62
 ;;^UTILITY(U,$J,358.3,16857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16857,1,3,0)
 ;;=3^Osteomyelitis,Subacute,Unspec Site
 ;;^UTILITY(U,$J,358.3,16857,1,4,0)
 ;;=4^M86.20
 ;;^UTILITY(U,$J,358.3,16857,2)
 ;;=^5014535
 ;;^UTILITY(U,$J,358.3,16858,0)
 ;;=M86.10^^88^881^58
 ;;^UTILITY(U,$J,358.3,16858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16858,1,3,0)
 ;;=3^Osteomyelitis,Acute,Unspec Site
 ;;^UTILITY(U,$J,358.3,16858,1,4,0)
 ;;=4^M86.10
 ;;^UTILITY(U,$J,358.3,16858,2)
 ;;=^5014521
 ;;^UTILITY(U,$J,358.3,16859,0)
 ;;=M86.00^^88^881^57
 ;;^UTILITY(U,$J,358.3,16859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16859,1,3,0)
 ;;=3^Osteomyelitis,Acute Hematogenous,Unspec Site
 ;;^UTILITY(U,$J,358.3,16859,1,4,0)
 ;;=4^M86.00
 ;;^UTILITY(U,$J,358.3,16859,2)
 ;;=^5014497
 ;;^UTILITY(U,$J,358.3,16860,0)
 ;;=M86.50^^88^881^59
 ;;^UTILITY(U,$J,358.3,16860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16860,1,3,0)
 ;;=3^Osteomyelitis,Chronic Hematogenous,Unspec Site
 ;;^UTILITY(U,$J,358.3,16860,1,4,0)
 ;;=4^M86.50
 ;;^UTILITY(U,$J,358.3,16860,2)
 ;;=^5014607
 ;;^UTILITY(U,$J,358.3,16861,0)
 ;;=M86.30^^88^881^60
 ;;^UTILITY(U,$J,358.3,16861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16861,1,3,0)
 ;;=3^Osteomyelitis,Chronic Multifocal,Unspec Site
 ;;^UTILITY(U,$J,358.3,16861,1,4,0)
 ;;=4^M86.30
 ;;^UTILITY(U,$J,358.3,16861,2)
 ;;=^5014559
 ;;^UTILITY(U,$J,358.3,16862,0)
 ;;=M86.8X9^^88^881^63
 ;;^UTILITY(U,$J,358.3,16862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16862,1,3,0)
 ;;=3^Osteomyelitis,Unspec Sites
 ;;^UTILITY(U,$J,358.3,16862,1,4,0)
 ;;=4^M86.8X9
 ;;^UTILITY(U,$J,358.3,16862,2)
 ;;=^5014655
 ;;^UTILITY(U,$J,358.3,16863,0)
 ;;=M86.60^^88^881^61
 ;;^UTILITY(U,$J,358.3,16863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16863,1,3,0)
 ;;=3^Osteomyelitis,Chronic,Unspec Site
 ;;^UTILITY(U,$J,358.3,16863,1,4,0)
 ;;=4^M86.60
 ;;^UTILITY(U,$J,358.3,16863,2)
 ;;=^5014630
 ;;^UTILITY(U,$J,358.3,16864,0)
 ;;=M86.40^^88^881^56
 ;;^UTILITY(U,$J,358.3,16864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16864,1,3,0)
 ;;=3^Osteomyelitis w/ Draining Sinus,Chronic,Unspec Site
 ;;^UTILITY(U,$J,358.3,16864,1,4,0)
 ;;=4^M86.40
 ;;^UTILITY(U,$J,358.3,16864,2)
 ;;=^5014583
 ;;^UTILITY(U,$J,358.3,16865,0)
 ;;=R50.2^^88^881^23
 ;;^UTILITY(U,$J,358.3,16865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16865,1,3,0)
 ;;=3^Fever,Drug-Induced
