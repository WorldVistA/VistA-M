IBDEI024 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,215,1,4,0)
 ;;=4^F32.3
 ;;^UTILITY(U,$J,358.3,215,2)
 ;;=^5003524
 ;;^UTILITY(U,$J,358.3,216,0)
 ;;=F32.4^^3^28^19
 ;;^UTILITY(U,$J,358.3,216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,216,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,In Partial Remission
 ;;^UTILITY(U,$J,358.3,216,1,4,0)
 ;;=4^F32.4
 ;;^UTILITY(U,$J,358.3,216,2)
 ;;=^5003525
 ;;^UTILITY(U,$J,358.3,217,0)
 ;;=F32.5^^3^28^20
 ;;^UTILITY(U,$J,358.3,217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,217,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,In Full Remission
 ;;^UTILITY(U,$J,358.3,217,1,4,0)
 ;;=4^F32.5
 ;;^UTILITY(U,$J,358.3,217,2)
 ;;=^5003526
 ;;^UTILITY(U,$J,358.3,218,0)
 ;;=F33.9^^3^28^13
 ;;^UTILITY(U,$J,358.3,218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,218,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Unspec
 ;;^UTILITY(U,$J,358.3,218,1,4,0)
 ;;=4^F33.9
 ;;^UTILITY(U,$J,358.3,218,2)
 ;;=^5003537
 ;;^UTILITY(U,$J,358.3,219,0)
 ;;=F33.0^^3^28^10
 ;;^UTILITY(U,$J,358.3,219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,219,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Mild
 ;;^UTILITY(U,$J,358.3,219,1,4,0)
 ;;=4^F33.0
 ;;^UTILITY(U,$J,358.3,219,2)
 ;;=^5003529
 ;;^UTILITY(U,$J,358.3,220,0)
 ;;=F33.1^^3^28^11
 ;;^UTILITY(U,$J,358.3,220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,220,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Moderate
 ;;^UTILITY(U,$J,358.3,220,1,4,0)
 ;;=4^F33.1
 ;;^UTILITY(U,$J,358.3,220,2)
 ;;=^5003530
 ;;^UTILITY(U,$J,358.3,221,0)
 ;;=F33.2^^3^28^12
 ;;^UTILITY(U,$J,358.3,221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,221,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Severe
 ;;^UTILITY(U,$J,358.3,221,1,4,0)
 ;;=4^F33.2
 ;;^UTILITY(U,$J,358.3,221,2)
 ;;=^5003531
 ;;^UTILITY(U,$J,358.3,222,0)
 ;;=F33.3^^3^28^7
 ;;^UTILITY(U,$J,358.3,222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,222,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,222,1,4,0)
 ;;=4^F33.3
 ;;^UTILITY(U,$J,358.3,222,2)
 ;;=^5003532
 ;;^UTILITY(U,$J,358.3,223,0)
 ;;=F33.41^^3^28^8
 ;;^UTILITY(U,$J,358.3,223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,223,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,In Partial Remission
 ;;^UTILITY(U,$J,358.3,223,1,4,0)
 ;;=4^F33.41
 ;;^UTILITY(U,$J,358.3,223,2)
 ;;=^5003534
 ;;^UTILITY(U,$J,358.3,224,0)
 ;;=F33.42^^3^28^9
 ;;^UTILITY(U,$J,358.3,224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,224,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,In Full Remission
 ;;^UTILITY(U,$J,358.3,224,1,4,0)
 ;;=4^F33.42
 ;;^UTILITY(U,$J,358.3,224,2)
 ;;=^5003535
 ;;^UTILITY(U,$J,358.3,225,0)
 ;;=F34.8^^3^28^6
 ;;^UTILITY(U,$J,358.3,225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,225,1,3,0)
 ;;=3^Disruptive Mood Dysregulation Disorder
 ;;^UTILITY(U,$J,358.3,225,1,4,0)
 ;;=4^F34.8
 ;;^UTILITY(U,$J,358.3,225,2)
 ;;=^5003539
 ;;^UTILITY(U,$J,358.3,226,0)
 ;;=F32.8^^3^28^1
 ;;^UTILITY(U,$J,358.3,226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,226,1,3,0)
 ;;=3^Depressive Disorder NEC
 ;;^UTILITY(U,$J,358.3,226,1,4,0)
 ;;=4^F32.8
 ;;^UTILITY(U,$J,358.3,226,2)
 ;;=^5003527
 ;;^UTILITY(U,$J,358.3,227,0)
 ;;=F34.1^^3^28^22
 ;;^UTILITY(U,$J,358.3,227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,227,1,3,0)
 ;;=3^Persistent Depressive Disorder (Dysthymic)
 ;;^UTILITY(U,$J,358.3,227,1,4,0)
 ;;=4^F34.1
 ;;^UTILITY(U,$J,358.3,227,2)
 ;;=^331913
 ;;^UTILITY(U,$J,358.3,228,0)
 ;;=F32.9^^3^28^5
 ;;^UTILITY(U,$J,358.3,228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,228,1,3,0)
 ;;=3^Depressive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,228,1,4,0)
 ;;=4^F32.9
