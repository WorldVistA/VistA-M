IBDEI0GJ ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7673,1,4,0)
 ;;=4^380.10
 ;;^UTILITY(U,$J,358.3,7673,1,5,0)
 ;;=5^Otitis Externa,Infect
 ;;^UTILITY(U,$J,358.3,7673,2)
 ;;=^62807
 ;;^UTILITY(U,$J,358.3,7674,0)
 ;;=381.01^^35^475^31
 ;;^UTILITY(U,$J,358.3,7674,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7674,1,4,0)
 ;;=4^381.01
 ;;^UTILITY(U,$J,358.3,7674,1,5,0)
 ;;=5^Otitis Media, Serous Acute
 ;;^UTILITY(U,$J,358.3,7674,2)
 ;;=^269369
 ;;^UTILITY(U,$J,358.3,7675,0)
 ;;=382.9^^35^475^28
 ;;^UTILITY(U,$J,358.3,7675,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7675,1,4,0)
 ;;=4^382.9
 ;;^UTILITY(U,$J,358.3,7675,1,5,0)
 ;;=5^Otitis Med, Other Acute
 ;;^UTILITY(U,$J,358.3,7675,2)
 ;;=^123967
 ;;^UTILITY(U,$J,358.3,7676,0)
 ;;=382.01^^35^475^30
 ;;^UTILITY(U,$J,358.3,7676,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7676,1,4,0)
 ;;=4^382.01
 ;;^UTILITY(U,$J,358.3,7676,1,5,0)
 ;;=5^Otitis Media W/Tympanic Membrane Rupture
 ;;^UTILITY(U,$J,358.3,7676,2)
 ;;=^269396
 ;;^UTILITY(U,$J,358.3,7677,0)
 ;;=381.10^^35^475^29
 ;;^UTILITY(U,$J,358.3,7677,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7677,1,4,0)
 ;;=4^381.10
 ;;^UTILITY(U,$J,358.3,7677,1,5,0)
 ;;=5^Otitis Med, Serous Chronic
 ;;^UTILITY(U,$J,358.3,7677,2)
 ;;=Otitis Med,serous chroinic^269376
 ;;^UTILITY(U,$J,358.3,7678,0)
 ;;=379.91^^35^475^32
 ;;^UTILITY(U,$J,358.3,7678,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7678,1,4,0)
 ;;=4^379.91
 ;;^UTILITY(U,$J,358.3,7678,1,5,0)
 ;;=5^Pain In Or Around Eye
 ;;^UTILITY(U,$J,358.3,7678,2)
 ;;=^89093
 ;;^UTILITY(U,$J,358.3,7679,0)
 ;;=462.^^35^475^33
 ;;^UTILITY(U,$J,358.3,7679,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7679,1,4,0)
 ;;=4^462.
 ;;^UTILITY(U,$J,358.3,7679,1,5,0)
 ;;=5^Pharyngitis, Acute
 ;;^UTILITY(U,$J,358.3,7679,2)
 ;;=Pharyngitis, Acute^2653
 ;;^UTILITY(U,$J,358.3,7680,0)
 ;;=460.^^35^475^21
 ;;^UTILITY(U,$J,358.3,7680,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7680,1,4,0)
 ;;=4^460.
 ;;^UTILITY(U,$J,358.3,7680,1,5,0)
 ;;=5^Nasopharyngitis, Acute
 ;;^UTILITY(U,$J,358.3,7680,2)
 ;;=^26543
 ;;^UTILITY(U,$J,358.3,7681,0)
 ;;=477.9^^35^475^3
 ;;^UTILITY(U,$J,358.3,7681,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7681,1,4,0)
 ;;=4^477.9
 ;;^UTILITY(U,$J,358.3,7681,1,5,0)
 ;;=5^Allergic Rhinitis
 ;;^UTILITY(U,$J,358.3,7681,2)
 ;;=^4955
 ;;^UTILITY(U,$J,358.3,7682,0)
 ;;=473.9^^35^475^37
 ;;^UTILITY(U,$J,358.3,7682,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7682,1,4,0)
 ;;=4^473.9
 ;;^UTILITY(U,$J,358.3,7682,1,5,0)
 ;;=5^Sinusitis, Chronic
 ;;^UTILITY(U,$J,358.3,7682,2)
 ;;=^123985
 ;;^UTILITY(U,$J,358.3,7683,0)
 ;;=461.1^^35^475^38
 ;;^UTILITY(U,$J,358.3,7683,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7683,1,4,0)
 ;;=4^461.1
 ;;^UTILITY(U,$J,358.3,7683,1,5,0)
 ;;=5^Sinusitis, Frontal Acute
 ;;^UTILITY(U,$J,358.3,7683,2)
 ;;=^269856
 ;;^UTILITY(U,$J,358.3,7684,0)
 ;;=473.1^^35^475^39
 ;;^UTILITY(U,$J,358.3,7684,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7684,1,4,0)
 ;;=4^473.1
 ;;^UTILITY(U,$J,358.3,7684,1,5,0)
 ;;=5^Sinusitis, Frontal Chronic
 ;;^UTILITY(U,$J,358.3,7684,2)
 ;;=^24380
 ;;^UTILITY(U,$J,358.3,7685,0)
 ;;=461.0^^35^475^40
 ;;^UTILITY(U,$J,358.3,7685,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7685,1,4,0)
 ;;=4^461.0
 ;;^UTILITY(U,$J,358.3,7685,1,5,0)
 ;;=5^Sinusitis, Maxillary Acute
 ;;^UTILITY(U,$J,358.3,7685,2)
 ;;=^269853
 ;;^UTILITY(U,$J,358.3,7686,0)
 ;;=473.0^^35^475^41
 ;;^UTILITY(U,$J,358.3,7686,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7686,1,4,0)
 ;;=4^473.0
 ;;^UTILITY(U,$J,358.3,7686,1,5,0)
 ;;=5^Sinusitis, Maxillary Chronic
 ;;^UTILITY(U,$J,358.3,7686,2)
 ;;=^24407
 ;;^UTILITY(U,$J,358.3,7687,0)
 ;;=388.31^^35^475^43
