IBDEI07C ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2860,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,2861,0)
 ;;=G31.2^^28^243^22
 ;;^UTILITY(U,$J,358.3,2861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2861,1,3,0)
 ;;=3^Dementia,Alcohol-Related
 ;;^UTILITY(U,$J,358.3,2861,1,4,0)
 ;;=4^G31.2
 ;;^UTILITY(U,$J,358.3,2861,2)
 ;;=^5003810
 ;;^UTILITY(U,$J,358.3,2862,0)
 ;;=A81.09^^28^243^25
 ;;^UTILITY(U,$J,358.3,2862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2862,1,3,0)
 ;;=3^Dementia,Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,2862,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,2862,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,2863,0)
 ;;=A81.00^^28^243^26
 ;;^UTILITY(U,$J,358.3,2863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2863,1,3,0)
 ;;=3^Dementia,Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,2863,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,2863,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,2864,0)
 ;;=A81.01^^28^243^27
 ;;^UTILITY(U,$J,358.3,2864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2864,1,3,0)
 ;;=3^Dementia,Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,2864,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,2864,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,2865,0)
 ;;=G31.9^^28^243^28
 ;;^UTILITY(U,$J,358.3,2865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2865,1,3,0)
 ;;=3^Dementia,Degenerative Disease Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,2865,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,2865,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,2866,0)
 ;;=G10.^^28^243^45
 ;;^UTILITY(U,$J,358.3,2866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2866,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,2866,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,2866,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,2867,0)
 ;;=G94.^^28^243^24
 ;;^UTILITY(U,$J,358.3,2867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2867,1,3,0)
 ;;=3^Dementia,Brain Disorder in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,2867,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,2867,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,2868,0)
 ;;=G31.09^^28^243^29
 ;;^UTILITY(U,$J,358.3,2868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2868,1,3,0)
 ;;=3^Dementia,Frontotemporal,Other
 ;;^UTILITY(U,$J,358.3,2868,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,2868,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,2869,0)
 ;;=G23.8^^28^243^23
 ;;^UTILITY(U,$J,358.3,2869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2869,1,3,0)
 ;;=3^Dementia,Basal Ganglia Degenerative Diseases
 ;;^UTILITY(U,$J,358.3,2869,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,2869,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,2870,0)
 ;;=G31.89^^28^243^31
 ;;^UTILITY(U,$J,358.3,2870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2870,1,3,0)
 ;;=3^Dementia,Nervous System Degenerative Diseases
 ;;^UTILITY(U,$J,358.3,2870,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,2870,2)
 ;;=^5003814
 ;;^UTILITY(U,$J,358.3,2871,0)
 ;;=F06.8^^28^243^30
 ;;^UTILITY(U,$J,358.3,2871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2871,1,3,0)
 ;;=3^Dementia,Mental Disorders d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,2871,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,2871,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,2872,0)
 ;;=F10.27^^28^243^32
 ;;^UTILITY(U,$J,358.3,2872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2872,1,3,0)
 ;;=3^Dementia,Persisting,Alcohol-Induced
 ;;^UTILITY(U,$J,358.3,2872,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,2872,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,2873,0)
 ;;=F19.97^^28^243^33
 ;;^UTILITY(U,$J,358.3,2873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2873,1,3,0)
 ;;=3^Dementia,Persisting,Psychoactive Subst Use
