IBDEI1ZP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33318,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,33319,0)
 ;;=F03.90^^148^1635^17
 ;;^UTILITY(U,$J,358.3,33319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33319,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,33319,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,33319,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,33320,0)
 ;;=F06.30^^148^1636^2
 ;;^UTILITY(U,$J,358.3,33320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33320,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition,Unspec
 ;;^UTILITY(U,$J,358.3,33320,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,33320,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,33321,0)
 ;;=F06.31^^148^1636^3
 ;;^UTILITY(U,$J,358.3,33321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33321,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Depressive Features
 ;;^UTILITY(U,$J,358.3,33321,1,4,0)
 ;;=4^F06.31
 ;;^UTILITY(U,$J,358.3,33321,2)
 ;;=^5003057
 ;;^UTILITY(U,$J,358.3,33322,0)
 ;;=F06.32^^148^1636^4
 ;;^UTILITY(U,$J,358.3,33322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33322,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Major Depressive-Like Episode
 ;;^UTILITY(U,$J,358.3,33322,1,4,0)
 ;;=4^F06.32
 ;;^UTILITY(U,$J,358.3,33322,2)
 ;;=^5003058
 ;;^UTILITY(U,$J,358.3,33323,0)
 ;;=F32.9^^148^1636^14
 ;;^UTILITY(U,$J,358.3,33323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33323,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,33323,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,33323,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,33324,0)
 ;;=F32.0^^148^1636^15
 ;;^UTILITY(U,$J,358.3,33324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33324,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Mild
 ;;^UTILITY(U,$J,358.3,33324,1,4,0)
 ;;=4^F32.0
 ;;^UTILITY(U,$J,358.3,33324,2)
 ;;=^5003521
 ;;^UTILITY(U,$J,358.3,33325,0)
 ;;=F32.1^^148^1636^16
 ;;^UTILITY(U,$J,358.3,33325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33325,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Moderate
 ;;^UTILITY(U,$J,358.3,33325,1,4,0)
 ;;=4^F32.1
 ;;^UTILITY(U,$J,358.3,33325,2)
 ;;=^5003522
 ;;^UTILITY(U,$J,358.3,33326,0)
 ;;=F32.2^^148^1636^17
 ;;^UTILITY(U,$J,358.3,33326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33326,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Severe
 ;;^UTILITY(U,$J,358.3,33326,1,4,0)
 ;;=4^F32.2
 ;;^UTILITY(U,$J,358.3,33326,2)
 ;;=^5003523
 ;;^UTILITY(U,$J,358.3,33327,0)
 ;;=F32.3^^148^1636^18
 ;;^UTILITY(U,$J,358.3,33327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33327,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode w Psychotic Features
 ;;^UTILITY(U,$J,358.3,33327,1,4,0)
 ;;=4^F32.3
 ;;^UTILITY(U,$J,358.3,33327,2)
 ;;=^5003524
 ;;^UTILITY(U,$J,358.3,33328,0)
 ;;=F32.4^^148^1636^19
 ;;^UTILITY(U,$J,358.3,33328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33328,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,In Partial Remission
 ;;^UTILITY(U,$J,358.3,33328,1,4,0)
 ;;=4^F32.4
 ;;^UTILITY(U,$J,358.3,33328,2)
 ;;=^5003525
 ;;^UTILITY(U,$J,358.3,33329,0)
 ;;=F32.5^^148^1636^20
 ;;^UTILITY(U,$J,358.3,33329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33329,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,In Full Remission
 ;;^UTILITY(U,$J,358.3,33329,1,4,0)
 ;;=4^F32.5
 ;;^UTILITY(U,$J,358.3,33329,2)
 ;;=^5003526
 ;;^UTILITY(U,$J,358.3,33330,0)
 ;;=F33.9^^148^1636^13
 ;;^UTILITY(U,$J,358.3,33330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33330,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Unspec
 ;;^UTILITY(U,$J,358.3,33330,1,4,0)
 ;;=4^F33.9
