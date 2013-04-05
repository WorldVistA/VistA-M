IBDEI02Q ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3163,2)
 ;;=Tachycardia^117041
 ;;^UTILITY(U,$J,358.3,3164,0)
 ;;=785.1^^40^248^70
 ;;^UTILITY(U,$J,358.3,3164,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3164,1,4,0)
 ;;=4^785.1
 ;;^UTILITY(U,$J,358.3,3164,1,5,0)
 ;;=5^Palpitations
 ;;^UTILITY(U,$J,358.3,3164,2)
 ;;=Palpitations^89281
 ;;^UTILITY(U,$J,358.3,3165,0)
 ;;=424.1^^40^248^11
 ;;^UTILITY(U,$J,358.3,3165,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3165,1,4,0)
 ;;=4^424.1
 ;;^UTILITY(U,$J,358.3,3165,1,5,0)
 ;;=5^Aortic Stenosis
 ;;^UTILITY(U,$J,358.3,3165,2)
 ;;=Aortic Stenosis^9330
 ;;^UTILITY(U,$J,358.3,3166,0)
 ;;=424.0^^40^248^62
 ;;^UTILITY(U,$J,358.3,3166,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3166,1,4,0)
 ;;=4^424.0
 ;;^UTILITY(U,$J,358.3,3166,1,5,0)
 ;;=5^Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,3166,2)
 ;;=^78367
 ;;^UTILITY(U,$J,358.3,3167,0)
 ;;=394.0^^40^248^61
 ;;^UTILITY(U,$J,358.3,3167,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3167,1,4,0)
 ;;=4^394.0
 ;;^UTILITY(U,$J,358.3,3167,1,5,0)
 ;;=5^Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,3167,2)
 ;;=Mitral Stenosis^78404
 ;;^UTILITY(U,$J,358.3,3168,0)
 ;;=394.9^^40^248^40
 ;;^UTILITY(U,$J,358.3,3168,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3168,1,4,0)
 ;;=4^394.9
 ;;^UTILITY(U,$J,358.3,3168,1,5,0)
 ;;=5^Heart Dis Mitral Valve
 ;;^UTILITY(U,$J,358.3,3168,2)
 ;;=^269571
 ;;^UTILITY(U,$J,358.3,3169,0)
 ;;=397.1^^40^248^41
 ;;^UTILITY(U,$J,358.3,3169,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3169,1,4,0)
 ;;=4^397.1
 ;;^UTILITY(U,$J,358.3,3169,1,5,0)
 ;;=5^Heart Dis Pulmon Valve
 ;;^UTILITY(U,$J,358.3,3169,2)
 ;;=^269587
 ;;^UTILITY(U,$J,358.3,3170,0)
 ;;=397.0^^40^248^42
 ;;^UTILITY(U,$J,358.3,3170,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3170,1,4,0)
 ;;=4^397.0
 ;;^UTILITY(U,$J,358.3,3170,1,5,0)
 ;;=5^Heart Dis Tricuspid Valve
 ;;^UTILITY(U,$J,358.3,3170,2)
 ;;=^35528
 ;;^UTILITY(U,$J,358.3,3171,0)
 ;;=424.90^^40^248^82
 ;;^UTILITY(U,$J,358.3,3171,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3171,1,4,0)
 ;;=4^424.90
 ;;^UTILITY(U,$J,358.3,3171,1,5,0)
 ;;=5^Valvular Heart Disease
 ;;^UTILITY(U,$J,358.3,3171,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,3172,0)
 ;;=V43.3^^40^248^76
 ;;^UTILITY(U,$J,358.3,3172,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3172,1,4,0)
 ;;=4^V43.3
 ;;^UTILITY(U,$J,358.3,3172,1,5,0)
 ;;=5^S/P Heart Valve Replacement
 ;;^UTILITY(U,$J,358.3,3172,2)
 ;;=^295440
 ;;^UTILITY(U,$J,358.3,3173,0)
 ;;=401.1^^40^248^57
 ;;^UTILITY(U,$J,358.3,3173,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3173,1,4,0)
 ;;=4^401.1
 ;;^UTILITY(U,$J,358.3,3173,1,5,0)
 ;;=5^Hypertension, Benign
 ;;^UTILITY(U,$J,358.3,3173,2)
 ;;=^269591
 ;;^UTILITY(U,$J,358.3,3174,0)
 ;;=796.2^^40^248^32
 ;;^UTILITY(U,$J,358.3,3174,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3174,1,4,0)
 ;;=4^796.2
 ;;^UTILITY(U,$J,358.3,3174,1,5,0)
 ;;=5^Elev BP w/o dx hypertension
 ;;^UTILITY(U,$J,358.3,3174,2)
 ;;=^273464
 ;;^UTILITY(U,$J,358.3,3175,0)
 ;;=402.10^^40^248^33
 ;;^UTILITY(U,$J,358.3,3175,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3175,1,4,0)
 ;;=4^402.10
 ;;^UTILITY(U,$J,358.3,3175,1,5,0)
 ;;=5^HTN w/ Heart Involvement
 ;;^UTILITY(U,$J,358.3,3175,2)
 ;;=^269598
 ;;^UTILITY(U,$J,358.3,3176,0)
 ;;=402.11^^40^248^34
 ;;^UTILITY(U,$J,358.3,3176,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3176,1,4,0)
 ;;=4^402.11
 ;;^UTILITY(U,$J,358.3,3176,1,5,0)
 ;;=5^HTN with CHF
 ;;^UTILITY(U,$J,358.3,3176,2)
 ;;=HTN with CHF^269599
 ;;^UTILITY(U,$J,358.3,3177,0)
 ;;=403.11^^40^248^39
 ;;^UTILITY(U,$J,358.3,3177,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3177,1,4,0)
 ;;=4^403.11
 ;;^UTILITY(U,$J,358.3,3177,1,5,0)
 ;;=5^HTN with Renal Failure
 ;;^UTILITY(U,$J,358.3,3177,2)
 ;;=^269608
 ;;^UTILITY(U,$J,358.3,3178,0)
 ;;=404.10^^40^248^37
 ;;^UTILITY(U,$J,358.3,3178,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3178,1,4,0)
 ;;=4^404.10
 ;;^UTILITY(U,$J,358.3,3178,1,5,0)
 ;;=5^HTN with Heart & Renal Involvement
 ;;^UTILITY(U,$J,358.3,3178,2)
 ;;=^269618
 ;;^UTILITY(U,$J,358.3,3179,0)
 ;;=404.11^^40^248^35
 ;;^UTILITY(U,$J,358.3,3179,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3179,1,4,0)
 ;;=4^404.11
 ;;^UTILITY(U,$J,358.3,3179,1,5,0)
 ;;=5^HTN with CHF & Renal Involvement
 ;;^UTILITY(U,$J,358.3,3179,2)
 ;;=^269619
 ;;^UTILITY(U,$J,358.3,3180,0)
 ;;=404.12^^40^248^38
 ;;^UTILITY(U,$J,358.3,3180,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3180,1,4,0)
 ;;=4^404.12
 ;;^UTILITY(U,$J,358.3,3180,1,5,0)
 ;;=5^HTN with Heart Involvement & Renal Failure
 ;;^UTILITY(U,$J,358.3,3180,2)
 ;;=^269620
 ;;^UTILITY(U,$J,358.3,3181,0)
 ;;=404.13^^40^248^36
 ;;^UTILITY(U,$J,358.3,3181,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3181,1,4,0)
 ;;=4^404.13
 ;;^UTILITY(U,$J,358.3,3181,1,5,0)
 ;;=5^HTN with CHF & Renal failure
 ;;^UTILITY(U,$J,358.3,3181,2)
 ;;=^269621
 ;;^UTILITY(U,$J,358.3,3182,0)
 ;;=401.9^^40^248^58
 ;;^UTILITY(U,$J,358.3,3182,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3182,1,4,0)
 ;;=4^401.9
 ;;^UTILITY(U,$J,358.3,3182,1,5,0)
 ;;=5^Hypertension, Essential
 ;;^UTILITY(U,$J,358.3,3182,2)
 ;;=^186630
 ;;^UTILITY(U,$J,358.3,3183,0)
 ;;=272.0^^40^248^56
 ;;^UTILITY(U,$J,358.3,3183,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3183,1,4,0)
 ;;=4^272.0
 ;;^UTILITY(U,$J,358.3,3183,1,5,0)
 ;;=5^Hypercholesterolemia, Pure
 ;;^UTILITY(U,$J,358.3,3183,2)
 ;;=^59973
 ;;^UTILITY(U,$J,358.3,3184,0)
 ;;=272.1^^40^248^59
 ;;^UTILITY(U,$J,358.3,3184,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3184,1,4,0)
 ;;=4^272.1
 ;;^UTILITY(U,$J,358.3,3184,1,5,0)
 ;;=5^Hypertriglyceridemia
 ;;^UTILITY(U,$J,358.3,3184,2)
 ;;=Hypertriglyceridemia^101303
 ;;^UTILITY(U,$J,358.3,3185,0)
 ;;=272.2^^40^248^63
 ;;^UTILITY(U,$J,358.3,3185,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3185,1,4,0)
 ;;=4^272.2
 ;;^UTILITY(U,$J,358.3,3185,1,5,0)
 ;;=5^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,3185,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,3186,0)
 ;;=396.0^^40^248^13
 ;;^UTILITY(U,$J,358.3,3186,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3186,1,4,0)
 ;;=4^396.0
 ;;^UTILITY(U,$J,358.3,3186,1,5,0)
 ;;=5^Aortic and Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,3186,2)
 ;;=Aortic and Mitral Stenosis^269580
 ;;^UTILITY(U,$J,358.3,3187,0)
 ;;=414.02^^40^248^19
 ;;^UTILITY(U,$J,358.3,3187,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3187,1,4,0)
 ;;=4^414.02
 ;;^UTILITY(U,$J,358.3,3187,1,5,0)
 ;;=5^CAD, Occlusion of Venous Graft
 ;;^UTILITY(U,$J,358.3,3187,2)
 ;;=CAD, Occlusion of Venous Graft^303282
 ;;^UTILITY(U,$J,358.3,3188,0)
 ;;=459.10^^40^248^74
 ;;^UTILITY(U,$J,358.3,3188,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3188,1,4,0)
 ;;=4^459.10
 ;;^UTILITY(U,$J,358.3,3188,1,5,0)
 ;;=5^Post Phlebotic Syndrome
 ;;^UTILITY(U,$J,358.3,3188,2)
 ;;=Post Phlebotic Syndrome^328597
 ;;^UTILITY(U,$J,358.3,3189,0)
 ;;=428.20^^40^248^52
 ;;^UTILITY(U,$J,358.3,3189,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3189,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,3189,1,5,0)
 ;;=5^Heart Failure, Systolic, Unspec
 ;;^UTILITY(U,$J,358.3,3189,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,3190,0)
 ;;=428.21^^40^248^44
 ;;^UTILITY(U,$J,358.3,3190,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3190,1,4,0)
 ;;=4^428.21
 ;;^UTILITY(U,$J,358.3,3190,1,5,0)
 ;;=5^Heart Failure, Acute Systolic
 ;;^UTILITY(U,$J,358.3,3190,2)
 ;;=Heart Failure, Acute Systolic^328494
 ;;^UTILITY(U,$J,358.3,3191,0)
 ;;=428.22^^40^248^46
 ;;^UTILITY(U,$J,358.3,3191,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3191,1,4,0)
 ;;=4^428.22
 ;;^UTILITY(U,$J,358.3,3191,1,5,0)
 ;;=5^Heart Failure, Chronic Systolic
 ;;^UTILITY(U,$J,358.3,3191,2)
 ;;=Heart Failure, Chronic Systolic^328495
 ;;^UTILITY(U,$J,358.3,3192,0)
 ;;=428.23^^40^248^51
 ;;^UTILITY(U,$J,358.3,3192,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3192,1,4,0)
 ;;=4^428.23
 ;;^UTILITY(U,$J,358.3,3192,1,5,0)
 ;;=5^Heart Failure, Systolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,3192,2)
 ;;=Heart Failure, Systolic, Acute on Chronic^328496
 ;;^UTILITY(U,$J,358.3,3193,0)
 ;;=428.30^^40^248^47
 ;;^UTILITY(U,$J,358.3,3193,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3193,1,4,0)
 ;;=4^428.30
 ;;^UTILITY(U,$J,358.3,3193,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,3193,2)
 ;;=Heart Failure, Diastolic^328595
 ;;^UTILITY(U,$J,358.3,3194,0)
 ;;=428.31^^40^248^43
 ;;^UTILITY(U,$J,358.3,3194,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3194,1,4,0)
 ;;=4^428.31
 ;;^UTILITY(U,$J,358.3,3194,1,5,0)
 ;;=5^Heart Failure, Acute Diastolic
 ;;^UTILITY(U,$J,358.3,3194,2)
 ;;=Heart Failure, Acute Diastolic^328497
 ;;^UTILITY(U,$J,358.3,3195,0)
 ;;=428.32^^40^248^45
 ;;^UTILITY(U,$J,358.3,3195,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3195,1,4,0)
 ;;=4^428.32
 ;;^UTILITY(U,$J,358.3,3195,1,5,0)
 ;;=5^Heart Failure, Chronic Diastolic
 ;;^UTILITY(U,$J,358.3,3195,2)
 ;;=Heart Failure, Chronic Diastolic^328498
 ;;^UTILITY(U,$J,358.3,3196,0)
 ;;=428.33^^40^248^49
 ;;^UTILITY(U,$J,358.3,3196,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3196,1,4,0)
 ;;=4^428.33
 ;;^UTILITY(U,$J,358.3,3196,1,5,0)
 ;;=5^Heart Failure, Diastolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,3196,2)
 ;;=Heart Failure, Diastolic, Acute on Chronic^328499
 ;;^UTILITY(U,$J,358.3,3197,0)
 ;;=428.40^^40^248^48
 ;;^UTILITY(U,$J,358.3,3197,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3197,1,4,0)
 ;;=4^428.40
 ;;^UTILITY(U,$J,358.3,3197,1,5,0)
 ;;=5^Heart Failure, Diastolic& Systolic
 ;;^UTILITY(U,$J,358.3,3197,2)
 ;;=Heart Failure, Systolic and Diastolic^328596
 ;;^UTILITY(U,$J,358.3,3198,0)
 ;;=428.41^^40^248^50
 ;;^UTILITY(U,$J,358.3,3198,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3198,1,4,0)
 ;;=4^428.41
 ;;^UTILITY(U,$J,358.3,3198,1,5,0)
 ;;=5^Heart Failure, Systolic & Diastolic, Acute
 ;;^UTILITY(U,$J,358.3,3198,2)
 ;;=Heart Failure, Systolic & Diastolic, Acute^328500
 ;;^UTILITY(U,$J,358.3,3199,0)
 ;;=428.42^^40^248^54
 ;;^UTILITY(U,$J,358.3,3199,1,0)
 ;;=^358.31IA^5^2
