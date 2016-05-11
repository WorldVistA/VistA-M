IBDEI06X ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2922,1,3,0)
 ;;=3^Cardiomyopathy,Other Hypertrophic
 ;;^UTILITY(U,$J,358.3,2922,1,4,0)
 ;;=4^I42.2
 ;;^UTILITY(U,$J,358.3,2922,2)
 ;;=^340521
 ;;^UTILITY(U,$J,358.3,2923,0)
 ;;=Z13.6^^18^210^26
 ;;^UTILITY(U,$J,358.3,2923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2923,1,3,0)
 ;;=3^Cardiovascular Disorder Screening
 ;;^UTILITY(U,$J,358.3,2923,1,4,0)
 ;;=4^Z13.6
 ;;^UTILITY(U,$J,358.3,2923,2)
 ;;=^5062707
 ;;^UTILITY(U,$J,358.3,2924,0)
 ;;=G45.1^^18^210^27
 ;;^UTILITY(U,$J,358.3,2924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2924,1,3,0)
 ;;=3^Carotid Artery Syndrome
 ;;^UTILITY(U,$J,358.3,2924,1,4,0)
 ;;=4^G45.1
 ;;^UTILITY(U,$J,358.3,2924,2)
 ;;=^5003956
 ;;^UTILITY(U,$J,358.3,2925,0)
 ;;=I65.29^^18^210^28
 ;;^UTILITY(U,$J,358.3,2925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2925,1,3,0)
 ;;=3^Carotid Artery,Occlusion & Stenosis,Unspec
 ;;^UTILITY(U,$J,358.3,2925,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,2925,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,2926,0)
 ;;=R09.89^^18^210^29
 ;;^UTILITY(U,$J,358.3,2926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2926,1,3,0)
 ;;=3^Carotid Bruit
 ;;^UTILITY(U,$J,358.3,2926,1,4,0)
 ;;=4^R09.89
 ;;^UTILITY(U,$J,358.3,2926,2)
 ;;=^5019204
 ;;^UTILITY(U,$J,358.3,2927,0)
 ;;=I63.239^^18^210^30
 ;;^UTILITY(U,$J,358.3,2927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2927,1,3,0)
 ;;=3^Cerebral Infarction d/t Occlusion/Stenosis Carotid Arteries
 ;;^UTILITY(U,$J,358.3,2927,1,4,0)
 ;;=4^I63.239
 ;;^UTILITY(U,$J,358.3,2927,2)
 ;;=^5133567
 ;;^UTILITY(U,$J,358.3,2928,0)
 ;;=I63.20^^18^210^31
 ;;^UTILITY(U,$J,358.3,2928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2928,1,3,0)
 ;;=3^Cerebral Infarction d/t Occlusion/Stenosis Percerebral Arteries
 ;;^UTILITY(U,$J,358.3,2928,1,4,0)
 ;;=4^I63.20
 ;;^UTILITY(U,$J,358.3,2928,2)
 ;;=^5007312
 ;;^UTILITY(U,$J,358.3,2929,0)
 ;;=I51.9^^18^210^32
 ;;^UTILITY(U,$J,358.3,2929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2929,1,3,0)
 ;;=3^Heart Disease,Unspec
 ;;^UTILITY(U,$J,358.3,2929,1,4,0)
 ;;=4^I51.9
 ;;^UTILITY(U,$J,358.3,2929,2)
 ;;=^5007258
 ;;^UTILITY(U,$J,358.3,2930,0)
 ;;=I50.9^^18^210^33
 ;;^UTILITY(U,$J,358.3,2930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2930,1,3,0)
 ;;=3^Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,2930,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,2930,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,2931,0)
 ;;=I62.1^^18^210^35
 ;;^UTILITY(U,$J,358.3,2931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2931,1,3,0)
 ;;=3^Hemorrhage,Nontraumatic Extradural
 ;;^UTILITY(U,$J,358.3,2931,1,4,0)
 ;;=4^I62.1
 ;;^UTILITY(U,$J,358.3,2931,2)
 ;;=^269743
 ;;^UTILITY(U,$J,358.3,2932,0)
 ;;=I61.9^^18^210^36
 ;;^UTILITY(U,$J,358.3,2932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2932,1,3,0)
 ;;=3^Hemorrhage,Nontraumatic Intracerebral,Unspec
 ;;^UTILITY(U,$J,358.3,2932,1,4,0)
 ;;=4^I61.9
 ;;^UTILITY(U,$J,358.3,2932,2)
 ;;=^5007288
 ;;^UTILITY(U,$J,358.3,2933,0)
 ;;=I62.9^^18^210^37
 ;;^UTILITY(U,$J,358.3,2933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2933,1,3,0)
 ;;=3^Hemorrhage,Nontraumatic Intracranial,Unspec
 ;;^UTILITY(U,$J,358.3,2933,1,4,0)
 ;;=4^I62.9
 ;;^UTILITY(U,$J,358.3,2933,2)
 ;;=^5007293
 ;;^UTILITY(U,$J,358.3,2934,0)
 ;;=I60.9^^18^210^38
 ;;^UTILITY(U,$J,358.3,2934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2934,1,3,0)
 ;;=3^Hemorrhage,Nontraumatic Subarachnoid,Unspec
 ;;^UTILITY(U,$J,358.3,2934,1,4,0)
 ;;=4^I60.9
 ;;^UTILITY(U,$J,358.3,2934,2)
 ;;=^5007279
 ;;^UTILITY(U,$J,358.3,2935,0)
 ;;=I62.00^^18^210^39
 ;;^UTILITY(U,$J,358.3,2935,1,0)
 ;;=^358.31IA^4^2
