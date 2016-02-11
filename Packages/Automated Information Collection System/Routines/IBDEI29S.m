IBDEI29S ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38119,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,38119,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,38120,0)
 ;;=F32.0^^177^1919^15
 ;;^UTILITY(U,$J,358.3,38120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38120,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Mild
 ;;^UTILITY(U,$J,358.3,38120,1,4,0)
 ;;=4^F32.0
 ;;^UTILITY(U,$J,358.3,38120,2)
 ;;=^5003521
 ;;^UTILITY(U,$J,358.3,38121,0)
 ;;=F32.1^^177^1919^16
 ;;^UTILITY(U,$J,358.3,38121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38121,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Moderate
 ;;^UTILITY(U,$J,358.3,38121,1,4,0)
 ;;=4^F32.1
 ;;^UTILITY(U,$J,358.3,38121,2)
 ;;=^5003522
 ;;^UTILITY(U,$J,358.3,38122,0)
 ;;=F32.2^^177^1919^17
 ;;^UTILITY(U,$J,358.3,38122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38122,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Severe
 ;;^UTILITY(U,$J,358.3,38122,1,4,0)
 ;;=4^F32.2
 ;;^UTILITY(U,$J,358.3,38122,2)
 ;;=^5003523
 ;;^UTILITY(U,$J,358.3,38123,0)
 ;;=F32.3^^177^1919^18
 ;;^UTILITY(U,$J,358.3,38123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38123,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode w Psychotic Features
 ;;^UTILITY(U,$J,358.3,38123,1,4,0)
 ;;=4^F32.3
 ;;^UTILITY(U,$J,358.3,38123,2)
 ;;=^5003524
 ;;^UTILITY(U,$J,358.3,38124,0)
 ;;=F32.4^^177^1919^19
 ;;^UTILITY(U,$J,358.3,38124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38124,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,In Partial Remission
 ;;^UTILITY(U,$J,358.3,38124,1,4,0)
 ;;=4^F32.4
 ;;^UTILITY(U,$J,358.3,38124,2)
 ;;=^5003525
 ;;^UTILITY(U,$J,358.3,38125,0)
 ;;=F32.5^^177^1919^20
 ;;^UTILITY(U,$J,358.3,38125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38125,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,In Full Remission
 ;;^UTILITY(U,$J,358.3,38125,1,4,0)
 ;;=4^F32.5
 ;;^UTILITY(U,$J,358.3,38125,2)
 ;;=^5003526
 ;;^UTILITY(U,$J,358.3,38126,0)
 ;;=F33.9^^177^1919^13
 ;;^UTILITY(U,$J,358.3,38126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38126,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Unspec
 ;;^UTILITY(U,$J,358.3,38126,1,4,0)
 ;;=4^F33.9
 ;;^UTILITY(U,$J,358.3,38126,2)
 ;;=^5003537
 ;;^UTILITY(U,$J,358.3,38127,0)
 ;;=F33.0^^177^1919^10
 ;;^UTILITY(U,$J,358.3,38127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38127,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Mild
 ;;^UTILITY(U,$J,358.3,38127,1,4,0)
 ;;=4^F33.0
 ;;^UTILITY(U,$J,358.3,38127,2)
 ;;=^5003529
 ;;^UTILITY(U,$J,358.3,38128,0)
 ;;=F33.1^^177^1919^11
 ;;^UTILITY(U,$J,358.3,38128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38128,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Moderate
 ;;^UTILITY(U,$J,358.3,38128,1,4,0)
 ;;=4^F33.1
 ;;^UTILITY(U,$J,358.3,38128,2)
 ;;=^5003530
 ;;^UTILITY(U,$J,358.3,38129,0)
 ;;=F33.2^^177^1919^12
 ;;^UTILITY(U,$J,358.3,38129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38129,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Severe
 ;;^UTILITY(U,$J,358.3,38129,1,4,0)
 ;;=4^F33.2
 ;;^UTILITY(U,$J,358.3,38129,2)
 ;;=^5003531
 ;;^UTILITY(U,$J,358.3,38130,0)
 ;;=F33.3^^177^1919^7
 ;;^UTILITY(U,$J,358.3,38130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38130,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,38130,1,4,0)
 ;;=4^F33.3
 ;;^UTILITY(U,$J,358.3,38130,2)
 ;;=^5003532
 ;;^UTILITY(U,$J,358.3,38131,0)
 ;;=F33.41^^177^1919^8
 ;;^UTILITY(U,$J,358.3,38131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38131,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,In Partial Remission
 ;;^UTILITY(U,$J,358.3,38131,1,4,0)
 ;;=4^F33.41
