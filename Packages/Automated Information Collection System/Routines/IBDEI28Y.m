IBDEI28Y ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38115,1,4,0)
 ;;=4^T50.905S
 ;;^UTILITY(U,$J,358.3,38115,2)
 ;;=^5052162
 ;;^UTILITY(U,$J,358.3,38116,0)
 ;;=F42.^^145^1840^7
 ;;^UTILITY(U,$J,358.3,38116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38116,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder
 ;;^UTILITY(U,$J,358.3,38116,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,38116,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,38117,0)
 ;;=F45.22^^145^1840^1
 ;;^UTILITY(U,$J,358.3,38117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38117,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,38117,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,38117,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,38118,0)
 ;;=F63.3^^145^1840^8
 ;;^UTILITY(U,$J,358.3,38118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38118,1,3,0)
 ;;=3^Trichotillomania
 ;;^UTILITY(U,$J,358.3,38118,1,4,0)
 ;;=4^F63.3
 ;;^UTILITY(U,$J,358.3,38118,2)
 ;;=^5003643
 ;;^UTILITY(U,$J,358.3,38119,0)
 ;;=L98.1^^145^1840^2
 ;;^UTILITY(U,$J,358.3,38119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38119,1,3,0)
 ;;=3^Excoriation (Skin-Picking) Disorder
 ;;^UTILITY(U,$J,358.3,38119,1,4,0)
 ;;=4^L98.1
 ;;^UTILITY(U,$J,358.3,38119,2)
 ;;=^186781
 ;;^UTILITY(U,$J,358.3,38120,0)
 ;;=F68.10^^145^1840^3
 ;;^UTILITY(U,$J,358.3,38120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38120,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,38120,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,38120,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,38121,0)
 ;;=F63.9^^145^1840^5
 ;;^UTILITY(U,$J,358.3,38121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38121,1,3,0)
 ;;=3^Impulse Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,38121,1,4,0)
 ;;=4^F63.9
 ;;^UTILITY(U,$J,358.3,38121,2)
 ;;=^5003646
 ;;^UTILITY(U,$J,358.3,38122,0)
 ;;=F42.^^145^1840^4
 ;;^UTILITY(U,$J,358.3,38122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38122,1,3,0)
 ;;=3^Hoarding Disorder
 ;;^UTILITY(U,$J,358.3,38122,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,38122,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,38123,0)
 ;;=F06.8^^145^1840^6
 ;;^UTILITY(U,$J,358.3,38123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38123,1,3,0)
 ;;=3^Obsessive-Compulsive & Related Disorder d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,38123,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,38123,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,38124,0)
 ;;=F06.2^^145^1841^5
 ;;^UTILITY(U,$J,358.3,38124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38124,1,3,0)
 ;;=3^Psychotic Disorder w/ Delusions d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,38124,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,38124,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,38125,0)
 ;;=F06.0^^145^1841^6
 ;;^UTILITY(U,$J,358.3,38125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38125,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucinations d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,38125,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,38125,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,38126,0)
 ;;=F06.4^^145^1841^1
 ;;^UTILITY(U,$J,358.3,38126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38126,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,38126,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,38126,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,38127,0)
 ;;=F06.1^^145^1841^2
 ;;^UTILITY(U,$J,358.3,38127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38127,1,3,0)
 ;;=3^Catatonia Associated w/ Schizophrenia
 ;;^UTILITY(U,$J,358.3,38127,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,38127,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,38128,0)
 ;;=R41.9^^145^1841^3
 ;;^UTILITY(U,$J,358.3,38128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38128,1,3,0)
 ;;=3^Neurocognitive Disorder,Unspec
