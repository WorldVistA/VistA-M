IBDEI01K ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,230,1,4,0)
 ;;=4^F32.3
 ;;^UTILITY(U,$J,358.3,230,2)
 ;;=^5003524
 ;;^UTILITY(U,$J,358.3,231,0)
 ;;=F32.4^^3^28^16
 ;;^UTILITY(U,$J,358.3,231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,231,1,3,0)
 ;;=3^MDD,Single Episode,In Partial Remission
 ;;^UTILITY(U,$J,358.3,231,1,4,0)
 ;;=4^F32.4
 ;;^UTILITY(U,$J,358.3,231,2)
 ;;=^5003525
 ;;^UTILITY(U,$J,358.3,232,0)
 ;;=F32.5^^3^28^15
 ;;^UTILITY(U,$J,358.3,232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,232,1,3,0)
 ;;=3^MDD,Single Episode,In Full Remission
 ;;^UTILITY(U,$J,358.3,232,1,4,0)
 ;;=4^F32.5
 ;;^UTILITY(U,$J,358.3,232,2)
 ;;=^5003526
 ;;^UTILITY(U,$J,358.3,233,0)
 ;;=F33.9^^3^28^13
 ;;^UTILITY(U,$J,358.3,233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,233,1,3,0)
 ;;=3^MDD,Recurrent,Unspec
 ;;^UTILITY(U,$J,358.3,233,1,4,0)
 ;;=4^F33.9
 ;;^UTILITY(U,$J,358.3,233,2)
 ;;=^5003537
 ;;^UTILITY(U,$J,358.3,234,0)
 ;;=F33.0^^3^28^10
 ;;^UTILITY(U,$J,358.3,234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,234,1,3,0)
 ;;=3^MDD,Recurrent,Mild
 ;;^UTILITY(U,$J,358.3,234,1,4,0)
 ;;=4^F33.0
 ;;^UTILITY(U,$J,358.3,234,2)
 ;;=^5003529
 ;;^UTILITY(U,$J,358.3,235,0)
 ;;=F33.1^^3^28^11
 ;;^UTILITY(U,$J,358.3,235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,235,1,3,0)
 ;;=3^MDD,Recurrent,Moderate
 ;;^UTILITY(U,$J,358.3,235,1,4,0)
 ;;=4^F33.1
 ;;^UTILITY(U,$J,358.3,235,2)
 ;;=^5003530
 ;;^UTILITY(U,$J,358.3,236,0)
 ;;=F33.2^^3^28^12
 ;;^UTILITY(U,$J,358.3,236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,236,1,3,0)
 ;;=3^MDD,Recurrent,Severe
 ;;^UTILITY(U,$J,358.3,236,1,4,0)
 ;;=4^F33.2
 ;;^UTILITY(U,$J,358.3,236,2)
 ;;=^5003531
 ;;^UTILITY(U,$J,358.3,237,0)
 ;;=F33.3^^3^28^7
 ;;^UTILITY(U,$J,358.3,237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,237,1,3,0)
 ;;=3^MDD,Recurrent w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,237,1,4,0)
 ;;=4^F33.3
 ;;^UTILITY(U,$J,358.3,237,2)
 ;;=^5003532
 ;;^UTILITY(U,$J,358.3,238,0)
 ;;=F33.41^^3^28^9
 ;;^UTILITY(U,$J,358.3,238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,238,1,3,0)
 ;;=3^MDD,Recurrent,In Partial Remission
 ;;^UTILITY(U,$J,358.3,238,1,4,0)
 ;;=4^F33.41
 ;;^UTILITY(U,$J,358.3,238,2)
 ;;=^5003534
 ;;^UTILITY(U,$J,358.3,239,0)
 ;;=F33.42^^3^28^8
 ;;^UTILITY(U,$J,358.3,239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,239,1,3,0)
 ;;=3^MDD,Recurrent,In Full Remission
 ;;^UTILITY(U,$J,358.3,239,1,4,0)
 ;;=4^F33.42
 ;;^UTILITY(U,$J,358.3,239,2)
 ;;=^5003535
 ;;^UTILITY(U,$J,358.3,240,0)
 ;;=F34.8^^3^28^6
 ;;^UTILITY(U,$J,358.3,240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,240,1,3,0)
 ;;=3^Disruptive Mood Dysregulation Disorder
 ;;^UTILITY(U,$J,358.3,240,1,4,0)
 ;;=4^F34.8
 ;;^UTILITY(U,$J,358.3,240,2)
 ;;=^5003539
 ;;^UTILITY(U,$J,358.3,241,0)
 ;;=F32.8^^3^28^1
 ;;^UTILITY(U,$J,358.3,241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,241,1,3,0)
 ;;=3^Depressive Disorder NEC
 ;;^UTILITY(U,$J,358.3,241,1,4,0)
 ;;=4^F32.8
 ;;^UTILITY(U,$J,358.3,241,2)
 ;;=^5003527
 ;;^UTILITY(U,$J,358.3,242,0)
 ;;=F34.1^^3^28^22
 ;;^UTILITY(U,$J,358.3,242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,242,1,3,0)
 ;;=3^Persistent Depressive Disorder (Dysthymic)
 ;;^UTILITY(U,$J,358.3,242,1,4,0)
 ;;=4^F34.1
 ;;^UTILITY(U,$J,358.3,242,2)
 ;;=^331913
 ;;^UTILITY(U,$J,358.3,243,0)
 ;;=F32.9^^3^28^5
 ;;^UTILITY(U,$J,358.3,243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,243,1,3,0)
 ;;=3^Depressive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,243,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,243,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,244,0)
 ;;=N94.3^^3^28^23
 ;;^UTILITY(U,$J,358.3,244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,244,1,3,0)
 ;;=3^Premenstrual Dysphoric Disorder
