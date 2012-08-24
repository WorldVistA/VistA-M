IBDEI02C ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2806,1,5,0)
 ;;=5^Htn W/ Heart Involvement
 ;;^UTILITY(U,$J,358.3,2806,2)
 ;;=^269598
 ;;^UTILITY(U,$J,358.3,2807,0)
 ;;=402.11^^36^264^45
 ;;^UTILITY(U,$J,358.3,2807,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2807,1,4,0)
 ;;=4^402.11
 ;;^UTILITY(U,$J,358.3,2807,1,5,0)
 ;;=5^Htn With Chf
 ;;^UTILITY(U,$J,358.3,2807,2)
 ;;=HTN with CHF^269599
 ;;^UTILITY(U,$J,358.3,2808,0)
 ;;=403.11^^36^264^50
 ;;^UTILITY(U,$J,358.3,2808,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2808,1,4,0)
 ;;=4^403.11
 ;;^UTILITY(U,$J,358.3,2808,1,5,0)
 ;;=5^Htn With Renal Failure
 ;;^UTILITY(U,$J,358.3,2808,2)
 ;;=^269608
 ;;^UTILITY(U,$J,358.3,2809,0)
 ;;=404.10^^36^264^48
 ;;^UTILITY(U,$J,358.3,2809,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2809,1,4,0)
 ;;=4^404.10
 ;;^UTILITY(U,$J,358.3,2809,1,5,0)
 ;;=5^Htn With Heart & Renal Involvement
 ;;^UTILITY(U,$J,358.3,2809,2)
 ;;=^269618
 ;;^UTILITY(U,$J,358.3,2810,0)
 ;;=404.11^^36^264^47
 ;;^UTILITY(U,$J,358.3,2810,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2810,1,4,0)
 ;;=4^404.11
 ;;^UTILITY(U,$J,358.3,2810,1,5,0)
 ;;=5^Htn With Chf & Renal Involvement
 ;;^UTILITY(U,$J,358.3,2810,2)
 ;;=^269619
 ;;^UTILITY(U,$J,358.3,2811,0)
 ;;=404.12^^36^264^49
 ;;^UTILITY(U,$J,358.3,2811,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2811,1,4,0)
 ;;=4^404.12
 ;;^UTILITY(U,$J,358.3,2811,1,5,0)
 ;;=5^Htn With Heart Involvement & Renal Failure
 ;;^UTILITY(U,$J,358.3,2811,2)
 ;;=^269620
 ;;^UTILITY(U,$J,358.3,2812,0)
 ;;=404.13^^36^264^46
 ;;^UTILITY(U,$J,358.3,2812,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2812,1,4,0)
 ;;=4^404.13
 ;;^UTILITY(U,$J,358.3,2812,1,5,0)
 ;;=5^Htn With Chf & Renal Failure
 ;;^UTILITY(U,$J,358.3,2812,2)
 ;;=^269621
 ;;^UTILITY(U,$J,358.3,2813,0)
 ;;=401.9^^36^264^55
 ;;^UTILITY(U,$J,358.3,2813,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2813,1,4,0)
 ;;=4^401.9
 ;;^UTILITY(U,$J,358.3,2813,1,5,0)
 ;;=5^Hypertension, Essential
 ;;^UTILITY(U,$J,358.3,2813,2)
 ;;=^186630
 ;;^UTILITY(U,$J,358.3,2814,0)
 ;;=272.0^^36^264^53
 ;;^UTILITY(U,$J,358.3,2814,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2814,1,4,0)
 ;;=4^272.0
 ;;^UTILITY(U,$J,358.3,2814,1,5,0)
 ;;=5^Hypercholesterolemia, Pure
 ;;^UTILITY(U,$J,358.3,2814,2)
 ;;=^59973
 ;;^UTILITY(U,$J,358.3,2815,0)
 ;;=272.1^^36^264^56
 ;;^UTILITY(U,$J,358.3,2815,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2815,1,4,0)
 ;;=4^272.1
 ;;^UTILITY(U,$J,358.3,2815,1,5,0)
 ;;=5^Hypertriglyceridemia
 ;;^UTILITY(U,$J,358.3,2815,2)
 ;;=Hypertriglyceridemia^101303
 ;;^UTILITY(U,$J,358.3,2816,0)
 ;;=272.2^^36^264^60
 ;;^UTILITY(U,$J,358.3,2816,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2816,1,4,0)
 ;;=4^272.2
 ;;^UTILITY(U,$J,358.3,2816,1,5,0)
 ;;=5^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,2816,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,2817,0)
 ;;=454.0^^36^264^82
 ;;^UTILITY(U,$J,358.3,2817,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2817,1,4,0)
 ;;=4^454.0
 ;;^UTILITY(U,$J,358.3,2817,1,5,0)
 ;;=5^Vericose Veins
 ;;^UTILITY(U,$J,358.3,2817,2)
 ;;=Vericose Veins^125410
 ;;^UTILITY(U,$J,358.3,2818,0)
 ;;=454.2^^36^264^83
 ;;^UTILITY(U,$J,358.3,2818,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2818,1,4,0)
 ;;=4^454.2
 ;;^UTILITY(U,$J,358.3,2818,1,5,0)
 ;;=5^Vericose Veins W/Ulcer&Inflammation
 ;;^UTILITY(U,$J,358.3,2818,2)
 ;;=^269821
 ;;^UTILITY(U,$J,358.3,2819,0)
 ;;=396.0^^36^264^8
 ;;^UTILITY(U,$J,358.3,2819,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2819,1,4,0)
 ;;=4^396.0
 ;;^UTILITY(U,$J,358.3,2819,1,5,0)
 ;;=5^Aortic And Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,2819,2)
 ;;=Aortic and Mitral Stenosis^269580
 ;;^UTILITY(U,$J,358.3,2820,0)
 ;;=414.02^^36^264^17
 ;;^UTILITY(U,$J,358.3,2820,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2820,1,4,0)
 ;;=4^414.02
 ;;^UTILITY(U,$J,358.3,2820,1,5,0)
 ;;=5^Cad, Occlusion Of Venous Graft
 ;;^UTILITY(U,$J,358.3,2820,2)
 ;;=CAD, Occlusion of Venous Graft^303282
 ;;^UTILITY(U,$J,358.3,2821,0)
 ;;=459.10^^36^264^67
 ;;^UTILITY(U,$J,358.3,2821,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2821,1,4,0)
 ;;=4^459.10
 ;;^UTILITY(U,$J,358.3,2821,1,5,0)
 ;;=5^Post Phlebotic Syndrome
 ;;^UTILITY(U,$J,358.3,2821,2)
 ;;=Post Phlebotic Syndrome^328597
 ;;^UTILITY(U,$J,358.3,2822,0)
 ;;=428.20^^36^264^43
 ;;^UTILITY(U,$J,358.3,2822,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2822,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,2822,1,5,0)
 ;;=5^Heart Failure, Systolic, Unspec
 ;;^UTILITY(U,$J,358.3,2822,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,2823,0)
 ;;=428.21^^36^264^33
 ;;^UTILITY(U,$J,358.3,2823,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2823,1,4,0)
 ;;=4^428.21
 ;;^UTILITY(U,$J,358.3,2823,1,5,0)
 ;;=5^Heart Failure, Acute Systolic
 ;;^UTILITY(U,$J,358.3,2823,2)
 ;;=Heart Failure, Acute Systolic^328494
 ;;^UTILITY(U,$J,358.3,2824,0)
 ;;=428.22^^36^264^35
 ;;^UTILITY(U,$J,358.3,2824,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2824,1,4,0)
 ;;=4^428.22
 ;;^UTILITY(U,$J,358.3,2824,1,5,0)
 ;;=5^Heart Failure, Chronic Systolic
 ;;^UTILITY(U,$J,358.3,2824,2)
 ;;=Heart Failure, Chronic Systolic^328495
 ;;^UTILITY(U,$J,358.3,2825,0)
 ;;=428.23^^36^264^42
 ;;^UTILITY(U,$J,358.3,2825,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2825,1,4,0)
 ;;=4^428.23
 ;;^UTILITY(U,$J,358.3,2825,1,5,0)
 ;;=5^Heart Failure, Systolic, Acute On Chronic
 ;;^UTILITY(U,$J,358.3,2825,2)
 ;;=Heart Failure, Systolic, Acute on Chronic^328496
 ;;^UTILITY(U,$J,358.3,2826,0)
 ;;=428.30^^36^264^36
 ;;^UTILITY(U,$J,358.3,2826,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2826,1,4,0)
 ;;=4^428.30
 ;;^UTILITY(U,$J,358.3,2826,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,2826,2)
 ;;=Heart Failure, Diastolic^328595
 ;;^UTILITY(U,$J,358.3,2827,0)
 ;;=428.31^^36^264^32
 ;;^UTILITY(U,$J,358.3,2827,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2827,1,4,0)
 ;;=4^428.31
 ;;^UTILITY(U,$J,358.3,2827,1,5,0)
 ;;=5^Heart Failure, Acute Diastolic
 ;;^UTILITY(U,$J,358.3,2827,2)
 ;;=Heart Failure, Acute Diastolic^328497
 ;;^UTILITY(U,$J,358.3,2828,0)
 ;;=428.32^^36^264^34
 ;;^UTILITY(U,$J,358.3,2828,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2828,1,4,0)
 ;;=4^428.32
 ;;^UTILITY(U,$J,358.3,2828,1,5,0)
 ;;=5^Heart Failure, Chronic Diastolic
 ;;^UTILITY(U,$J,358.3,2828,2)
 ;;=Heart Failure, Chronic Diastolic^328498
 ;;^UTILITY(U,$J,358.3,2829,0)
 ;;=428.33^^36^264^38
 ;;^UTILITY(U,$J,358.3,2829,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2829,1,4,0)
 ;;=4^428.33
 ;;^UTILITY(U,$J,358.3,2829,1,5,0)
 ;;=5^Heart Failure, Diastolic, Acute On Chronic
 ;;^UTILITY(U,$J,358.3,2829,2)
 ;;=Heart Failure, Diastolic, Acute on Chronic^328499
 ;;^UTILITY(U,$J,358.3,2830,0)
 ;;=428.40^^36^264^37
 ;;^UTILITY(U,$J,358.3,2830,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2830,1,4,0)
 ;;=4^428.40
 ;;^UTILITY(U,$J,358.3,2830,1,5,0)
 ;;=5^Heart Failure, Diastolic& Systolic
 ;;^UTILITY(U,$J,358.3,2830,2)
 ;;=Heart Failure, Systolic and Diastolic^328596
 ;;^UTILITY(U,$J,358.3,2831,0)
 ;;=428.41^^36^264^39
 ;;^UTILITY(U,$J,358.3,2831,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2831,1,4,0)
 ;;=4^428.41
 ;;^UTILITY(U,$J,358.3,2831,1,5,0)
 ;;=5^Heart Failure, Systolic & Diastolic, Acute
 ;;^UTILITY(U,$J,358.3,2831,2)
 ;;=Heart Failure, Systolic & Diastolic, Acute^328500
 ;;^UTILITY(U,$J,358.3,2832,0)
 ;;=428.42^^36^264^41
 ;;^UTILITY(U,$J,358.3,2832,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2832,1,4,0)
 ;;=4^428.42
 ;;^UTILITY(U,$J,358.3,2832,1,5,0)
 ;;=5^Heart Failure, Systolic & Diastolic, Chronic
 ;;^UTILITY(U,$J,358.3,2832,2)
 ;;= Heart Failure, Systolic & Diastolic, Chronic^328501
 ;;^UTILITY(U,$J,358.3,2833,0)
 ;;=428.43^^36^264^40
 ;;^UTILITY(U,$J,358.3,2833,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2833,1,4,0)
 ;;=4^428.43
 ;;^UTILITY(U,$J,358.3,2833,1,5,0)
 ;;=5^Heart Failure, Systolic & Diastolic, Acute On Chronic
 ;;^UTILITY(U,$J,358.3,2833,2)
 ;;= Heart Failure, Systolic & Diastolic, Acute on Chronic^328502
 ;;^UTILITY(U,$J,358.3,2834,0)
 ;;=396.3^^36^264^7
 ;;^UTILITY(U,$J,358.3,2834,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2834,1,4,0)
 ;;=4^396.3
 ;;^UTILITY(U,$J,358.3,2834,1,5,0)
 ;;=5^Aortic And Mitral Insufficiency
 ;;^UTILITY(U,$J,358.3,2834,2)
 ;;=Aortic and Mitral Insufficiency^269583
 ;;^UTILITY(U,$J,358.3,2835,0)
 ;;=414.3^^36^264^16
 ;;^UTILITY(U,$J,358.3,2835,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2835,1,4,0)
 ;;=4^414.3
 ;;^UTILITY(U,$J,358.3,2835,1,5,0)
 ;;=5^CAD,due to lipid rich plaque
 ;;^UTILITY(U,$J,358.3,2835,2)
 ;;=^336601
 ;;^UTILITY(U,$J,358.3,2836,0)
 ;;=453.9^^36^264^81
 ;;^UTILITY(U,$J,358.3,2836,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2836,1,4,0)
 ;;=4^453.9
 ;;^UTILITY(U,$J,358.3,2836,1,5,0)
 ;;=5^Venous Thrombosis NOS
 ;;^UTILITY(U,$J,358.3,2836,2)
 ;;=^39455
 ;;^UTILITY(U,$J,358.3,2837,0)
 ;;=453.89^^36^264^1
 ;;^UTILITY(U,$J,358.3,2837,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2837,1,4,0)
 ;;=4^453.89
 ;;^UTILITY(U,$J,358.3,2837,1,5,0)
 ;;=5^AC Venous Embolism NEC
 ;;^UTILITY(U,$J,358.3,2837,2)
 ;;=^338259
 ;;^UTILITY(U,$J,358.3,2838,0)
 ;;=453.79^^36^264^26
 ;;^UTILITY(U,$J,358.3,2838,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2838,1,4,0)
 ;;=4^453.79
 ;;^UTILITY(U,$J,358.3,2838,1,5,0)
 ;;=5^Chr Venous Embolism NEC
 ;;^UTILITY(U,$J,358.3,2838,2)
 ;;=^338251
 ;;^UTILITY(U,$J,358.3,2839,0)
 ;;=425.11^^36^264^57
 ;;^UTILITY(U,$J,358.3,2839,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2839,1,4,0)
 ;;=4^425.11
 ;;^UTILITY(U,$J,358.3,2839,1,5,0)
 ;;=5^Hypertrophic Subaortic Stenosis
 ;;^UTILITY(U,$J,358.3,2839,2)
 ;;=^340520
 ;;^UTILITY(U,$J,358.3,2840,0)
 ;;=425.18^^36^264^62
 ;;^UTILITY(U,$J,358.3,2840,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2840,1,4,0)
 ;;=4^425.18
 ;;^UTILITY(U,$J,358.3,2840,1,5,0)
 ;;=5^Oth Hypertrophic Cardiomyopathy
 ;;^UTILITY(U,$J,358.3,2840,2)
 ;;=^340521
 ;;^UTILITY(U,$J,358.3,2841,0)
 ;;=V12.55^^36^264^52
