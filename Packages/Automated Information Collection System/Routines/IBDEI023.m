IBDEI023 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,428,1,4,0)
 ;;=4^D58.2
 ;;^UTILITY(U,$J,358.3,428,2)
 ;;=^87629
 ;;^UTILITY(U,$J,358.3,429,0)
 ;;=C83.10^^2^21^45
 ;;^UTILITY(U,$J,358.3,429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,429,1,3,0)
 ;;=3^Mantle cell lymphoma, unspecified site
 ;;^UTILITY(U,$J,358.3,429,1,4,0)
 ;;=4^C83.10
 ;;^UTILITY(U,$J,358.3,429,2)
 ;;=^5001561
 ;;^UTILITY(U,$J,358.3,430,0)
 ;;=C83.19^^2^21^44
 ;;^UTILITY(U,$J,358.3,430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,430,1,3,0)
 ;;=3^Mantle cell lymphoma, extranodal and solid organ sites
 ;;^UTILITY(U,$J,358.3,430,1,4,0)
 ;;=4^C83.19
 ;;^UTILITY(U,$J,358.3,430,2)
 ;;=^5001570
 ;;^UTILITY(U,$J,358.3,431,0)
 ;;=C83.50^^2^21^38
 ;;^UTILITY(U,$J,358.3,431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,431,1,3,0)
 ;;=3^Lymphoblastic (diffuse) lymphoma, unspecified site
 ;;^UTILITY(U,$J,358.3,431,1,4,0)
 ;;=4^C83.50
 ;;^UTILITY(U,$J,358.3,431,2)
 ;;=^5001581
 ;;^UTILITY(U,$J,358.3,432,0)
 ;;=C83.59^^2^21^39
 ;;^UTILITY(U,$J,358.3,432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,432,1,3,0)
 ;;=3^Lymphoblastic lymphoma, extrnod and solid organ sites
 ;;^UTILITY(U,$J,358.3,432,1,4,0)
 ;;=4^C83.59
 ;;^UTILITY(U,$J,358.3,432,2)
 ;;=^5001590
 ;;^UTILITY(U,$J,358.3,433,0)
 ;;=C83.70^^2^21^12
 ;;^UTILITY(U,$J,358.3,433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,433,1,3,0)
 ;;=3^Burkitt lymphoma, unspecified site
 ;;^UTILITY(U,$J,358.3,433,1,4,0)
 ;;=4^C83.70
 ;;^UTILITY(U,$J,358.3,433,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,434,0)
 ;;=C83.79^^2^21^11
 ;;^UTILITY(U,$J,358.3,434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,434,1,3,0)
 ;;=3^Burkitt lymphoma, extranodal and solid organ sites
 ;;^UTILITY(U,$J,358.3,434,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,434,2)
 ;;=^5001600
 ;;^UTILITY(U,$J,358.3,435,0)
 ;;=C81.00^^2^21^54
 ;;^UTILITY(U,$J,358.3,435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,435,1,3,0)
 ;;=3^Nodular lymphocyte predominant Hodgkin lymphoma, unsp site
 ;;^UTILITY(U,$J,358.3,435,1,4,0)
 ;;=4^C81.00
 ;;^UTILITY(U,$J,358.3,435,2)
 ;;=^5001391
 ;;^UTILITY(U,$J,358.3,436,0)
 ;;=C83.39^^2^21^19
 ;;^UTILITY(U,$J,358.3,436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,436,1,3,0)
 ;;=3^Diffuse large B-cell lymphoma, extrnod and solid organ sites
 ;;^UTILITY(U,$J,358.3,436,1,4,0)
 ;;=4^C83.39
 ;;^UTILITY(U,$J,358.3,436,2)
 ;;=^5001580
 ;;^UTILITY(U,$J,358.3,437,0)
 ;;=C81.09^^2^21^55
 ;;^UTILITY(U,$J,358.3,437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,437,1,3,0)
 ;;=3^Nodular lymphocyte predominant Hodgkin lymphoma, extrnod & solid org site
 ;;^UTILITY(U,$J,358.3,437,1,4,0)
 ;;=4^C81.09
 ;;^UTILITY(U,$J,358.3,437,2)
 ;;=^5001400
 ;;^UTILITY(U,$J,358.3,438,0)
 ;;=C81.10^^2^21^56
 ;;^UTILITY(U,$J,358.3,438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,438,1,3,0)
 ;;=3^Nodular sclerosis classical Hodgkin lymphoma, unsp site
 ;;^UTILITY(U,$J,358.3,438,1,4,0)
 ;;=4^C81.10
 ;;^UTILITY(U,$J,358.3,438,2)
 ;;=^5001401
 ;;^UTILITY(U,$J,358.3,439,0)
 ;;=C81.19^^2^21^57
 ;;^UTILITY(U,$J,358.3,439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,439,1,3,0)
 ;;=3^Nodular sclerosis classical Hodgkin lymphoma,extrnod and solid organ sites
 ;;^UTILITY(U,$J,358.3,439,1,4,0)
 ;;=4^C81.19
 ;;^UTILITY(U,$J,358.3,439,2)
 ;;=^5001410
 ;;^UTILITY(U,$J,358.3,440,0)
 ;;=C81.20^^2^21^47
 ;;^UTILITY(U,$J,358.3,440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,440,1,3,0)
 ;;=3^Mixed cellularity classical Hodgkin lymphoma, unsp site
 ;;^UTILITY(U,$J,358.3,440,1,4,0)
 ;;=4^C81.20
 ;;^UTILITY(U,$J,358.3,440,2)
 ;;=^5001411
 ;;^UTILITY(U,$J,358.3,441,0)
 ;;=C81.29^^2^21^46
