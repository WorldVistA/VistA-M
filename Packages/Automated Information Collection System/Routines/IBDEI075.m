IBDEI075 ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3172,1,4,0)
 ;;=4^381.01
 ;;^UTILITY(U,$J,358.3,3172,1,5,0)
 ;;=5^Otitis Media, Serous Acute
 ;;^UTILITY(U,$J,358.3,3172,2)
 ;;=^269369
 ;;^UTILITY(U,$J,358.3,3173,0)
 ;;=382.9^^33^274^31
 ;;^UTILITY(U,$J,358.3,3173,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3173,1,4,0)
 ;;=4^382.9
 ;;^UTILITY(U,$J,358.3,3173,1,5,0)
 ;;=5^Otitis Med, Other Acute
 ;;^UTILITY(U,$J,358.3,3173,2)
 ;;=^123967
 ;;^UTILITY(U,$J,358.3,3174,0)
 ;;=382.01^^33^274^33
 ;;^UTILITY(U,$J,358.3,3174,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3174,1,4,0)
 ;;=4^382.01
 ;;^UTILITY(U,$J,358.3,3174,1,5,0)
 ;;=5^Otitis Media W/Tympanic Membrane Rupture
 ;;^UTILITY(U,$J,358.3,3174,2)
 ;;=^269396
 ;;^UTILITY(U,$J,358.3,3175,0)
 ;;=381.10^^33^274^32
 ;;^UTILITY(U,$J,358.3,3175,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3175,1,4,0)
 ;;=4^381.10
 ;;^UTILITY(U,$J,358.3,3175,1,5,0)
 ;;=5^Otitis Med, Serous Chronic
 ;;^UTILITY(U,$J,358.3,3175,2)
 ;;=Otitis Med,serous chroinic^269376
 ;;^UTILITY(U,$J,358.3,3176,0)
 ;;=379.91^^33^274^35
 ;;^UTILITY(U,$J,358.3,3176,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3176,1,4,0)
 ;;=4^379.91
 ;;^UTILITY(U,$J,358.3,3176,1,5,0)
 ;;=5^Pain In Or Around Eye
 ;;^UTILITY(U,$J,358.3,3176,2)
 ;;=^89093
 ;;^UTILITY(U,$J,358.3,3177,0)
 ;;=462.^^33^274^36
 ;;^UTILITY(U,$J,358.3,3177,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3177,1,4,0)
 ;;=4^462.
 ;;^UTILITY(U,$J,358.3,3177,1,5,0)
 ;;=5^Pharyngitis, Acute
 ;;^UTILITY(U,$J,358.3,3177,2)
 ;;=Pharyngitis, Acute^2653
 ;;^UTILITY(U,$J,358.3,3178,0)
 ;;=460.^^33^274^23
 ;;^UTILITY(U,$J,358.3,3178,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3178,1,4,0)
 ;;=4^460.
 ;;^UTILITY(U,$J,358.3,3178,1,5,0)
 ;;=5^Nasopharyngitis, Acute
 ;;^UTILITY(U,$J,358.3,3178,2)
 ;;=^26543
 ;;^UTILITY(U,$J,358.3,3179,0)
 ;;=477.9^^33^274^3
 ;;^UTILITY(U,$J,358.3,3179,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3179,1,4,0)
 ;;=4^477.9
 ;;^UTILITY(U,$J,358.3,3179,1,5,0)
 ;;=5^Allergic Rhinitis
 ;;^UTILITY(U,$J,358.3,3179,2)
 ;;=^4955
 ;;^UTILITY(U,$J,358.3,3180,0)
 ;;=473.9^^33^274^38
 ;;^UTILITY(U,$J,358.3,3180,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3180,1,4,0)
 ;;=4^473.9
 ;;^UTILITY(U,$J,358.3,3180,1,5,0)
 ;;=5^Sinusitis, Chronic
 ;;^UTILITY(U,$J,358.3,3180,2)
 ;;=^123985
 ;;^UTILITY(U,$J,358.3,3181,0)
 ;;=461.1^^33^274^39
 ;;^UTILITY(U,$J,358.3,3181,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3181,1,4,0)
 ;;=4^461.1
 ;;^UTILITY(U,$J,358.3,3181,1,5,0)
 ;;=5^Sinusitis, Frontal Acute
 ;;^UTILITY(U,$J,358.3,3181,2)
 ;;=^269856
 ;;^UTILITY(U,$J,358.3,3182,0)
 ;;=473.1^^33^274^40
 ;;^UTILITY(U,$J,358.3,3182,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3182,1,4,0)
 ;;=4^473.1
 ;;^UTILITY(U,$J,358.3,3182,1,5,0)
 ;;=5^Sinusitis, Frontal Chronic
 ;;^UTILITY(U,$J,358.3,3182,2)
 ;;=^24380
 ;;^UTILITY(U,$J,358.3,3183,0)
 ;;=461.0^^33^274^41
 ;;^UTILITY(U,$J,358.3,3183,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3183,1,4,0)
 ;;=4^461.0
 ;;^UTILITY(U,$J,358.3,3183,1,5,0)
 ;;=5^Sinusitis, Maxillary Acute
 ;;^UTILITY(U,$J,358.3,3183,2)
 ;;=^269853
 ;;^UTILITY(U,$J,358.3,3184,0)
 ;;=473.0^^33^274^42
 ;;^UTILITY(U,$J,358.3,3184,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3184,1,4,0)
 ;;=4^473.0
 ;;^UTILITY(U,$J,358.3,3184,1,5,0)
 ;;=5^Sinusitis, Maxillary Chronic
 ;;^UTILITY(U,$J,358.3,3184,2)
 ;;=^24407
 ;;^UTILITY(U,$J,358.3,3185,0)
 ;;=388.31^^33^274^44
 ;;^UTILITY(U,$J,358.3,3185,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3185,1,4,0)
 ;;=4^388.31
 ;;^UTILITY(U,$J,358.3,3185,1,5,0)
 ;;=5^Tinnitus, Subjective
 ;;^UTILITY(U,$J,358.3,3185,2)
 ;;=^269527
 ;;^UTILITY(U,$J,358.3,3186,0)
 ;;=463.^^33^274^45
