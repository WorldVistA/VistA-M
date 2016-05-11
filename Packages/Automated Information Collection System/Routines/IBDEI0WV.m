IBDEI0WV ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15421,0)
 ;;=G23.1^^58^662^34
 ;;^UTILITY(U,$J,358.3,15421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15421,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia Palsy
 ;;^UTILITY(U,$J,358.3,15421,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,15421,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,15422,0)
 ;;=F03.91^^58^662^15
 ;;^UTILITY(U,$J,358.3,15422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15422,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,15422,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,15422,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,15423,0)
 ;;=F03.90^^58^662^17
 ;;^UTILITY(U,$J,358.3,15423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15423,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,15423,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,15423,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,15424,0)
 ;;=F06.30^^58^663^2
 ;;^UTILITY(U,$J,358.3,15424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15424,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition,Unspec
 ;;^UTILITY(U,$J,358.3,15424,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,15424,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,15425,0)
 ;;=F06.31^^58^663^3
 ;;^UTILITY(U,$J,358.3,15425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15425,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Depressive Features
 ;;^UTILITY(U,$J,358.3,15425,1,4,0)
 ;;=4^F06.31
 ;;^UTILITY(U,$J,358.3,15425,2)
 ;;=^5003057
 ;;^UTILITY(U,$J,358.3,15426,0)
 ;;=F06.32^^58^663^4
 ;;^UTILITY(U,$J,358.3,15426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15426,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Major Depressive-Like Episode
 ;;^UTILITY(U,$J,358.3,15426,1,4,0)
 ;;=4^F06.32
 ;;^UTILITY(U,$J,358.3,15426,2)
 ;;=^5003058
 ;;^UTILITY(U,$J,358.3,15427,0)
 ;;=F32.9^^58^663^20
 ;;^UTILITY(U,$J,358.3,15427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15427,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,15427,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,15427,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,15428,0)
 ;;=F32.0^^58^663^17
 ;;^UTILITY(U,$J,358.3,15428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15428,1,3,0)
 ;;=3^MDD,Single Episode,Mild
 ;;^UTILITY(U,$J,358.3,15428,1,4,0)
 ;;=4^F32.0
 ;;^UTILITY(U,$J,358.3,15428,2)
 ;;=^5003521
 ;;^UTILITY(U,$J,358.3,15429,0)
 ;;=F32.1^^58^663^18
 ;;^UTILITY(U,$J,358.3,15429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15429,1,3,0)
 ;;=3^MDD,Single Episode,Moderate
 ;;^UTILITY(U,$J,358.3,15429,1,4,0)
 ;;=4^F32.1
 ;;^UTILITY(U,$J,358.3,15429,2)
 ;;=^5003522
 ;;^UTILITY(U,$J,358.3,15430,0)
 ;;=F32.2^^58^663^19
 ;;^UTILITY(U,$J,358.3,15430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15430,1,3,0)
 ;;=3^MDD,Single Episode,Severe
 ;;^UTILITY(U,$J,358.3,15430,1,4,0)
 ;;=4^F32.2
 ;;^UTILITY(U,$J,358.3,15430,2)
 ;;=^5003523
 ;;^UTILITY(U,$J,358.3,15431,0)
 ;;=F32.3^^58^663^14
 ;;^UTILITY(U,$J,358.3,15431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15431,1,3,0)
 ;;=3^MDD,Single Episode w Psychotic Features
 ;;^UTILITY(U,$J,358.3,15431,1,4,0)
 ;;=4^F32.3
 ;;^UTILITY(U,$J,358.3,15431,2)
 ;;=^5003524
 ;;^UTILITY(U,$J,358.3,15432,0)
 ;;=F32.4^^58^663^16
 ;;^UTILITY(U,$J,358.3,15432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15432,1,3,0)
 ;;=3^MDD,Single Episode,In Partial Remission
 ;;^UTILITY(U,$J,358.3,15432,1,4,0)
 ;;=4^F32.4
 ;;^UTILITY(U,$J,358.3,15432,2)
 ;;=^5003525
 ;;^UTILITY(U,$J,358.3,15433,0)
 ;;=F32.5^^58^663^15
 ;;^UTILITY(U,$J,358.3,15433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15433,1,3,0)
 ;;=3^MDD,Single Episode,In Full Remission
