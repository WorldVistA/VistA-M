IBDEI21N ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35708,1,3,0)
 ;;=3^Postprocedural retroperitoneal abscess
 ;;^UTILITY(U,$J,358.3,35708,1,4,0)
 ;;=4^K68.11
 ;;^UTILITY(U,$J,358.3,35708,2)
 ;;=^5008782
 ;;^UTILITY(U,$J,358.3,35709,0)
 ;;=T81.89XA^^189^2061^2
 ;;^UTILITY(U,$J,358.3,35709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35709,1,3,0)
 ;;=3^Complications of procedures, NEC, init
 ;;^UTILITY(U,$J,358.3,35709,1,4,0)
 ;;=4^T81.89XA
 ;;^UTILITY(U,$J,358.3,35709,2)
 ;;=^5054662
 ;;^UTILITY(U,$J,358.3,35710,0)
 ;;=Z91.19^^189^2061^16
 ;;^UTILITY(U,$J,358.3,35710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35710,1,3,0)
 ;;=3^Patient's noncompliance w oth medical treatment and regimen
 ;;^UTILITY(U,$J,358.3,35710,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,35710,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,35711,0)
 ;;=Z48.298^^189^2061^1
 ;;^UTILITY(U,$J,358.3,35711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35711,1,3,0)
 ;;=3^Aftercare following other organ transplant
 ;;^UTILITY(U,$J,358.3,35711,1,4,0)
 ;;=4^Z48.298
 ;;^UTILITY(U,$J,358.3,35711,2)
 ;;=^5063045
 ;;^UTILITY(U,$J,358.3,35712,0)
 ;;=Z52.011^^189^2062^1
 ;;^UTILITY(U,$J,358.3,35712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35712,1,3,0)
 ;;=3^Autologous donor, stem cells
 ;;^UTILITY(U,$J,358.3,35712,1,4,0)
 ;;=4^Z52.011
 ;;^UTILITY(U,$J,358.3,35712,2)
 ;;=^5063070
 ;;^UTILITY(U,$J,358.3,35713,0)
 ;;=Z52.091^^189^2062^2
 ;;^UTILITY(U,$J,358.3,35713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35713,1,3,0)
 ;;=3^Blood donor, stem cells
 ;;^UTILITY(U,$J,358.3,35713,1,4,0)
 ;;=4^Z52.091
 ;;^UTILITY(U,$J,358.3,35713,2)
 ;;=^5063073
 ;;^UTILITY(U,$J,358.3,35714,0)
 ;;=Z52.3^^189^2062^3
 ;;^UTILITY(U,$J,358.3,35714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35714,1,3,0)
 ;;=3^Bone marrow donor
 ;;^UTILITY(U,$J,358.3,35714,1,4,0)
 ;;=4^Z52.3
 ;;^UTILITY(U,$J,358.3,35714,2)
 ;;=^5063081
 ;;^UTILITY(U,$J,358.3,35715,0)
 ;;=Z94.81^^189^2062^4
 ;;^UTILITY(U,$J,358.3,35715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35715,1,3,0)
 ;;=3^Bone marrow transplant status
 ;;^UTILITY(U,$J,358.3,35715,1,4,0)
 ;;=4^Z94.81
 ;;^UTILITY(U,$J,358.3,35715,2)
 ;;=^5063662
 ;;^UTILITY(U,$J,358.3,35716,0)
 ;;=Z94.84^^189^2062^6
 ;;^UTILITY(U,$J,358.3,35716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35716,1,3,0)
 ;;=3^Stem cells transplant status
 ;;^UTILITY(U,$J,358.3,35716,1,4,0)
 ;;=4^Z94.84
 ;;^UTILITY(U,$J,358.3,35716,2)
 ;;=^5063665
 ;;^UTILITY(U,$J,358.3,35717,0)
 ;;=Z52.89^^189^2062^5
 ;;^UTILITY(U,$J,358.3,35717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35717,1,3,0)
 ;;=3^Donor of other specified organs or tissues
 ;;^UTILITY(U,$J,358.3,35717,1,4,0)
 ;;=4^Z52.89
 ;;^UTILITY(U,$J,358.3,35717,2)
 ;;=^5063090
