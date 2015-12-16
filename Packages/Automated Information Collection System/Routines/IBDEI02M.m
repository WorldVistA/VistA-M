IBDEI02M ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,673,1,4,0)
 ;;=4^N17.8
 ;;^UTILITY(U,$J,358.3,673,2)
 ;;=^5015601
 ;;^UTILITY(U,$J,358.3,674,0)
 ;;=N17.9^^3^28^4
 ;;^UTILITY(U,$J,358.3,674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,674,1,3,0)
 ;;=3^Acute kidney failure, unspecified
 ;;^UTILITY(U,$J,358.3,674,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,674,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,675,0)
 ;;=I09.9^^3^29^23
 ;;^UTILITY(U,$J,358.3,675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,675,1,3,0)
 ;;=3^Rheumatic heart disease, unspecified
 ;;^UTILITY(U,$J,358.3,675,1,4,0)
 ;;=4^I09.9
 ;;^UTILITY(U,$J,358.3,675,2)
 ;;=^5007061
 ;;^UTILITY(U,$J,358.3,676,0)
 ;;=I10.^^3^29^15
 ;;^UTILITY(U,$J,358.3,676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,676,1,3,0)
 ;;=3^Essential (primary) hypertension
 ;;^UTILITY(U,$J,358.3,676,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,676,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,677,0)
 ;;=I21.3^^3^29^25
 ;;^UTILITY(U,$J,358.3,677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,677,1,3,0)
 ;;=3^ST elevation (STEMI) myocardial infarction of unsp site
 ;;^UTILITY(U,$J,358.3,677,1,4,0)
 ;;=4^I21.3
 ;;^UTILITY(U,$J,358.3,677,2)
 ;;=^5007087
 ;;^UTILITY(U,$J,358.3,678,0)
 ;;=I25.2^^3^29^20
 ;;^UTILITY(U,$J,358.3,678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,678,1,3,0)
 ;;=3^Old myocardial infarction
 ;;^UTILITY(U,$J,358.3,678,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,678,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,679,0)
 ;;=I20.9^^3^29^4
 ;;^UTILITY(U,$J,358.3,679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,679,1,3,0)
 ;;=3^Angina pectoris, unspecified
 ;;^UTILITY(U,$J,358.3,679,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,679,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,680,0)
 ;;=I25.10^^3^29^6
 ;;^UTILITY(U,$J,358.3,680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,680,1,3,0)
 ;;=3^Athscl heart disease of native coronary artery w/o ang pctrs
 ;;^UTILITY(U,$J,358.3,680,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,680,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,681,0)
 ;;=I25.5^^3^29^17
 ;;^UTILITY(U,$J,358.3,681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,681,1,3,0)
 ;;=3^Ischemic cardiomyopathy
 ;;^UTILITY(U,$J,358.3,681,1,4,0)
 ;;=4^I25.5
 ;;^UTILITY(U,$J,358.3,681,2)
 ;;=^5007115
 ;;^UTILITY(U,$J,358.3,682,0)
 ;;=I25.89^^3^29^12
 ;;^UTILITY(U,$J,358.3,682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,682,1,3,0)
 ;;=3^Chronic Ischemic Heart Disease NEC
 ;;^UTILITY(U,$J,358.3,682,1,4,0)
 ;;=4^I25.89
 ;;^UTILITY(U,$J,358.3,682,2)
 ;;=^269679
 ;;^UTILITY(U,$J,358.3,683,0)
 ;;=I25.9^^3^29^13
 ;;^UTILITY(U,$J,358.3,683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,683,1,3,0)
 ;;=3^Chronic ischemic heart disease, unspecified
 ;;^UTILITY(U,$J,358.3,683,1,4,0)
 ;;=4^I25.9
 ;;^UTILITY(U,$J,358.3,683,2)
 ;;=^5007144
 ;;^UTILITY(U,$J,358.3,684,0)
 ;;=I34.0^^3^29^19
 ;;^UTILITY(U,$J,358.3,684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,684,1,3,0)
 ;;=3^Nonrheumatic mitral (valve) insufficiency
 ;;^UTILITY(U,$J,358.3,684,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,684,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,685,0)
 ;;=I35.0^^3^29^18
 ;;^UTILITY(U,$J,358.3,685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,685,1,3,0)
 ;;=3^Nonrheumatic aortic (valve) stenosis
 ;;^UTILITY(U,$J,358.3,685,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,685,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,686,0)
 ;;=I38.^^3^29^14
 ;;^UTILITY(U,$J,358.3,686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,686,1,3,0)
 ;;=3^Endocarditis, valve unspecified
 ;;^UTILITY(U,$J,358.3,686,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,686,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,687,0)
 ;;=I42.9^^3^29^10
