IBDEI024 ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4742,1,3,0)
 ;;=3^Idiopathic interstitial pneumonia, not otherwise specified
 ;;^UTILITY(U,$J,358.3,4742,1,4,0)
 ;;=4^J84.111
 ;;^UTILITY(U,$J,358.3,4742,2)
 ;;=^340610
 ;;^UTILITY(U,$J,358.3,4743,0)
 ;;=J84.112^^34^298^13
 ;;^UTILITY(U,$J,358.3,4743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4743,1,3,0)
 ;;=3^Idiopathic pulmonary fibrosis
 ;;^UTILITY(U,$J,358.3,4743,1,4,0)
 ;;=4^J84.112
 ;;^UTILITY(U,$J,358.3,4743,2)
 ;;=^340534
 ;;^UTILITY(U,$J,358.3,4744,0)
 ;;=J84.113^^34^298^12
 ;;^UTILITY(U,$J,358.3,4744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4744,1,3,0)
 ;;=3^Idiopathic non-specific interstitial pneumonitis
 ;;^UTILITY(U,$J,358.3,4744,1,4,0)
 ;;=4^J84.113
 ;;^UTILITY(U,$J,358.3,4744,2)
 ;;=^340535
 ;;^UTILITY(U,$J,358.3,4745,0)
 ;;=J84.114^^34^298^1
 ;;^UTILITY(U,$J,358.3,4745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4745,1,3,0)
 ;;=3^Acute interstitial pneumonitis
 ;;^UTILITY(U,$J,358.3,4745,1,4,0)
 ;;=4^J84.114
 ;;^UTILITY(U,$J,358.3,4745,2)
 ;;=^340536
 ;;^UTILITY(U,$J,358.3,4746,0)
 ;;=J84.115^^34^298^21
 ;;^UTILITY(U,$J,358.3,4746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4746,1,3,0)
 ;;=3^Respiratory bronchiolitis interstitial lung disease
 ;;^UTILITY(U,$J,358.3,4746,1,4,0)
 ;;=4^J84.115
 ;;^UTILITY(U,$J,358.3,4746,2)
 ;;=^340537
 ;;^UTILITY(U,$J,358.3,4747,0)
 ;;=J84.2^^34^298^15
 ;;^UTILITY(U,$J,358.3,4747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4747,1,3,0)
 ;;=3^Lymphoid interstitial pneumonia
 ;;^UTILITY(U,$J,358.3,4747,1,4,0)
 ;;=4^J84.2
 ;;^UTILITY(U,$J,358.3,4747,2)
 ;;=^5008302
 ;;^UTILITY(U,$J,358.3,4748,0)
 ;;=J84.116^^34^298^7
 ;;^UTILITY(U,$J,358.3,4748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4748,1,3,0)
 ;;=3^Cryptogenic organizing pneumonia
 ;;^UTILITY(U,$J,358.3,4748,1,4,0)
 ;;=4^J84.116
 ;;^UTILITY(U,$J,358.3,4748,2)
 ;;=^340539
 ;;^UTILITY(U,$J,358.3,4749,0)
 ;;=J84.117^^34^298^8
 ;;^UTILITY(U,$J,358.3,4749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4749,1,3,0)
 ;;=3^Desquamative interstitial pneumonia
 ;;^UTILITY(U,$J,358.3,4749,1,4,0)
 ;;=4^J84.117
 ;;^UTILITY(U,$J,358.3,4749,2)
 ;;=^340540
 ;;^UTILITY(U,$J,358.3,4750,0)
 ;;=J84.81^^34^298^14
 ;;^UTILITY(U,$J,358.3,4750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4750,1,3,0)
 ;;=3^Lymphangioleiomyomatosis
 ;;^UTILITY(U,$J,358.3,4750,1,4,0)
 ;;=4^J84.81
 ;;^UTILITY(U,$J,358.3,4750,2)
 ;;=^340541
 ;;^UTILITY(U,$J,358.3,4751,0)
 ;;=J84.82^^34^298^2
 ;;^UTILITY(U,$J,358.3,4751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4751,1,3,0)
 ;;=3^Adult pulmonary Langerhans cell histiocytosis
 ;;^UTILITY(U,$J,358.3,4751,1,4,0)
 ;;=4^J84.82
 ;;^UTILITY(U,$J,358.3,4751,2)
 ;;=^340542
 ;;^UTILITY(U,$J,358.3,4752,0)
 ;;=J84.842^^34^298^20
 ;;^UTILITY(U,$J,358.3,4752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4752,1,3,0)
 ;;=3^Pulmonary interstitial glycogenosis
 ;;^UTILITY(U,$J,358.3,4752,1,4,0)
 ;;=4^J84.842
 ;;^UTILITY(U,$J,358.3,4752,2)
 ;;=^340544
 ;;^UTILITY(U,$J,358.3,4753,0)
 ;;=J84.83^^34^298^27
 ;;^UTILITY(U,$J,358.3,4753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4753,1,3,0)
 ;;=3^Surfactant mutations of the lung
 ;;^UTILITY(U,$J,358.3,4753,1,4,0)
 ;;=4^J84.83
 ;;^UTILITY(U,$J,358.3,4753,2)
 ;;=^340545
 ;;^UTILITY(U,$J,358.3,4754,0)
 ;;=J99.^^34^298^23
 ;;^UTILITY(U,$J,358.3,4754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4754,1,3,0)
 ;;=3^Respiratory disorders in diseases classified elsewhere
 ;;^UTILITY(U,$J,358.3,4754,1,4,0)
 ;;=4^J99.
 ;;^UTILITY(U,$J,358.3,4754,2)
 ;;=^5008367
 ;;^UTILITY(U,$J,358.3,4755,0)
 ;;=K76.81^^34^298^10
 ;;^UTILITY(U,$J,358.3,4755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4755,1,3,0)
 ;;=3^Hepatopulmonary syndrome
 ;;^UTILITY(U,$J,358.3,4755,1,4,0)
 ;;=4^K76.81
 ;;^UTILITY(U,$J,358.3,4755,2)
 ;;=^340555
 ;;^UTILITY(U,$J,358.3,4756,0)
 ;;=Z77.090^^34^298^6
 ;;^UTILITY(U,$J,358.3,4756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4756,1,3,0)
 ;;=3^Contact with and (suspected) exposure to asbestos
 ;;^UTILITY(U,$J,358.3,4756,1,4,0)
 ;;=4^Z77.090
 ;;^UTILITY(U,$J,358.3,4756,2)
 ;;=^5063312
 ;;^UTILITY(U,$J,358.3,4757,0)
 ;;=F03.90^^34^299^11
 ;;^UTILITY(U,$J,358.3,4757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4757,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,4757,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,4757,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,4758,0)
 ;;=F02.80^^34^299^9
 ;;^UTILITY(U,$J,358.3,4758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4758,1,3,0)
 ;;=3^Dementia in oth diseases classd elswhr w/o behavrl disturb
 ;;^UTILITY(U,$J,358.3,4758,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,4758,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,4759,0)
 ;;=F02.81^^34^299^10
 ;;^UTILITY(U,$J,358.3,4759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4759,1,3,0)
 ;;=3^Dementia in oth diseases classd elswhr w behavioral disturb
 ;;^UTILITY(U,$J,358.3,4759,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,4759,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,4760,0)
 ;;=F20.9^^34^299^29
 ;;^UTILITY(U,$J,358.3,4760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4760,1,3,0)
 ;;=3^Schizophrenia, unspecified
 ;;^UTILITY(U,$J,358.3,4760,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,4760,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,4761,0)
 ;;=F31.9^^34^299^7
 ;;^UTILITY(U,$J,358.3,4761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4761,1,3,0)
 ;;=3^Bipolar disorder, unspecified
 ;;^UTILITY(U,$J,358.3,4761,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,4761,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,4762,0)
 ;;=F41.9^^34^299^6
 ;;^UTILITY(U,$J,358.3,4762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4762,1,3,0)
 ;;=3^Anxiety disorder, unspecified
 ;;^UTILITY(U,$J,358.3,4762,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,4762,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,4763,0)
 ;;=F34.1^^34^299^12
 ;;^UTILITY(U,$J,358.3,4763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4763,1,3,0)
 ;;=3^Dysthymic disorder
 ;;^UTILITY(U,$J,358.3,4763,1,4,0)
 ;;=4^F34.1
 ;;^UTILITY(U,$J,358.3,4763,2)
 ;;=^331913
 ;;^UTILITY(U,$J,358.3,4764,0)
 ;;=F45.0^^34^299^31
 ;;^UTILITY(U,$J,358.3,4764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4764,1,3,0)
 ;;=3^Somatization disorder
 ;;^UTILITY(U,$J,358.3,4764,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,4764,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,4765,0)
 ;;=F60.9^^34^299^26
 ;;^UTILITY(U,$J,358.3,4765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4765,1,3,0)
 ;;=3^Personality disorder, unspecified
 ;;^UTILITY(U,$J,358.3,4765,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,4765,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,4766,0)
 ;;=F52.21^^34^299^17
 ;;^UTILITY(U,$J,358.3,4766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4766,1,3,0)
 ;;=3^Male erectile disorder
 ;;^UTILITY(U,$J,358.3,4766,1,4,0)
 ;;=4^F52.21
 ;;^UTILITY(U,$J,358.3,4766,2)
 ;;=^5003620
 ;;^UTILITY(U,$J,358.3,4767,0)
 ;;=F10.20^^34^299^4
 ;;^UTILITY(U,$J,358.3,4767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4767,1,3,0)
 ;;=3^Alcohol dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,4767,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,4767,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,4768,0)
 ;;=F10.21^^34^299^3
 ;;^UTILITY(U,$J,358.3,4768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4768,1,3,0)
 ;;=3^Alcohol dependence, in remission
 ;;^UTILITY(U,$J,358.3,4768,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,4768,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,4769,0)
 ;;=F11.20^^34^299^23
 ;;^UTILITY(U,$J,358.3,4769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4769,1,3,0)
 ;;=3^Opioid dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,4769,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,4769,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,4770,0)
 ;;=F14.20^^34^299^8
 ;;^UTILITY(U,$J,358.3,4770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4770,1,3,0)
 ;;=3^Cocaine dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,4770,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,4770,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,4771,0)
 ;;=F10.10^^34^299^2
 ;;^UTILITY(U,$J,358.3,4771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4771,1,3,0)
 ;;=3^Alcohol abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,4771,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,4771,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,4772,0)
 ;;=F17.200^^34^299^19
 ;;^UTILITY(U,$J,358.3,4772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4772,1,3,0)
 ;;=3^Nicotine dependence, unspecified, uncomplicated
 ;;^UTILITY(U,$J,358.3,4772,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,4772,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,4773,0)
 ;;=F11.10^^34^299^22
 ;;^UTILITY(U,$J,358.3,4773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4773,1,3,0)
 ;;=3^Opioid abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,4773,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,4773,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,4774,0)
 ;;=F45.9^^34^299^32
 ;;^UTILITY(U,$J,358.3,4774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4774,1,3,0)
 ;;=3^Somatoform disorder, unspecified
 ;;^UTILITY(U,$J,358.3,4774,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,4774,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,4775,0)
 ;;=F43.21^^34^299^1
 ;;^UTILITY(U,$J,358.3,4775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4775,1,3,0)
 ;;=3^Adjustment disorder with depressed mood
 ;;^UTILITY(U,$J,358.3,4775,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,4775,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,4776,0)
 ;;=F43.10^^34^299^28
 ;;^UTILITY(U,$J,358.3,4776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4776,1,3,0)
 ;;=3^Post-traumatic stress disorder, unspecified
 ;;^UTILITY(U,$J,358.3,4776,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,4776,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,4777,0)
 ;;=F43.12^^34^299^27
 ;;^UTILITY(U,$J,358.3,4777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4777,1,3,0)
 ;;=3^Post-traumatic stress disorder, chronic
 ;;^UTILITY(U,$J,358.3,4777,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,4777,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,4778,0)
 ;;=F32.9^^34^299^16
 ;;^UTILITY(U,$J,358.3,4778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4778,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,4778,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,4778,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,4779,0)
 ;;=G47.62^^34^299^30
 ;;^UTILITY(U,$J,358.3,4779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4779,1,3,0)
 ;;=3^Sleep related leg cramps
 ;;^UTILITY(U,$J,358.3,4779,1,4,0)
 ;;=4^G47.62
 ;;^UTILITY(U,$J,358.3,4779,2)
 ;;=^332782
 ;;^UTILITY(U,$J,358.3,4780,0)
 ;;=G30.9^^34^299^5
 ;;^UTILITY(U,$J,358.3,4780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4780,1,3,0)
 ;;=3^Alzheimer's disease, unspecified
 ;;^UTILITY(U,$J,358.3,4780,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,4780,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,4781,0)
 ;;=G47.00^^34^299^15
 ;;^UTILITY(U,$J,358.3,4781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4781,1,3,0)
 ;;=3^Insomnia, unspecified
 ;;^UTILITY(U,$J,358.3,4781,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,4781,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,4782,0)
 ;;=Z86.59^^34^299^25
 ;;^UTILITY(U,$J,358.3,4782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4782,1,3,0)
 ;;=3^Personal history of other mental and behavioral disorders
 ;;^UTILITY(U,$J,358.3,4782,1,4,0)
 ;;=4^Z86.59
 ;;^UTILITY(U,$J,358.3,4782,2)
 ;;=^5063471
 ;;^UTILITY(U,$J,358.3,4783,0)
 ;;=Z91.19^^34^299^24
 ;;^UTILITY(U,$J,358.3,4783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4783,1,3,0)
 ;;=3^Patient's noncompliance w oth medical treatment and regimen
 ;;^UTILITY(U,$J,358.3,4783,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,4783,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,4784,0)
 ;;=F42.2^^34^299^18
 ;;^UTILITY(U,$J,358.3,4784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4784,1,3,0)
 ;;=3^Mixed Osessional Thoughts and Acts
 ;;^UTILITY(U,$J,358.3,4784,1,4,0)
 ;;=4^F42.2
 ;;^UTILITY(U,$J,358.3,4784,2)
 ;;=^5138444
 ;;^UTILITY(U,$J,358.3,4785,0)
 ;;=F42.3^^34^299^14
 ;;^UTILITY(U,$J,358.3,4785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4785,1,3,0)
 ;;=3^Hoarding Disorder
 ;;^UTILITY(U,$J,358.3,4785,1,4,0)
 ;;=4^F42.3
 ;;^UTILITY(U,$J,358.3,4785,2)
 ;;=^5138445
 ;;^UTILITY(U,$J,358.3,4786,0)
 ;;=F42.4^^34^299^13
 ;;^UTILITY(U,$J,358.3,4786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4786,1,3,0)
 ;;=3^Excoriation Disorder
 ;;^UTILITY(U,$J,358.3,4786,1,4,0)
 ;;=4^F42.4
 ;;^UTILITY(U,$J,358.3,4786,2)
 ;;=^5138446
 ;;^UTILITY(U,$J,358.3,4787,0)
 ;;=F42.8^^34^299^20
 ;;^UTILITY(U,$J,358.3,4787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4787,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder,Other
 ;;^UTILITY(U,$J,358.3,4787,1,4,0)
 ;;=4^F42.8
 ;;^UTILITY(U,$J,358.3,4787,2)
 ;;=^5138447
 ;;^UTILITY(U,$J,358.3,4788,0)
 ;;=F42.9^^34^299^21
 ;;^UTILITY(U,$J,358.3,4788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4788,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,4788,1,4,0)
 ;;=4^F42.9
 ;;^UTILITY(U,$J,358.3,4788,2)
 ;;=^5138448
 ;;^UTILITY(U,$J,358.3,4789,0)
 ;;=M02.30^^34^300^88
 ;;^UTILITY(U,$J,358.3,4789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4789,1,3,0)
 ;;=3^Reiter's disease, unspecified site
 ;;^UTILITY(U,$J,358.3,4789,1,4,0)
 ;;=4^M02.30
 ;;^UTILITY(U,$J,358.3,4789,2)
 ;;=^5009790
 ;;^UTILITY(U,$J,358.3,4790,0)
 ;;=M10.00^^34^300^39
 ;;^UTILITY(U,$J,358.3,4790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4790,1,3,0)
 ;;=3^Idiopathic gout, unspecified site
 ;;^UTILITY(U,$J,358.3,4790,1,4,0)
 ;;=4^M10.00
 ;;^UTILITY(U,$J,358.3,4790,2)
 ;;=^5010284
 ;;^UTILITY(U,$J,358.3,4791,0)
 ;;=M10.9^^34^300^34
 ;;^UTILITY(U,$J,358.3,4791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4791,1,3,0)
 ;;=3^Gout, unspecified
 ;;^UTILITY(U,$J,358.3,4791,1,4,0)
 ;;=4^M10.9
 ;;^UTILITY(U,$J,358.3,4791,2)
 ;;=^5010404
 ;;^UTILITY(U,$J,358.3,4792,0)
 ;;=G90.59^^34^300^19
 ;;^UTILITY(U,$J,358.3,4792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4792,1,3,0)
 ;;=3^Complex regional pain syndrome I of other specified site
 ;;^UTILITY(U,$J,358.3,4792,1,4,0)
 ;;=4^G90.59
 ;;^UTILITY(U,$J,358.3,4792,2)
 ;;=^5004171
 ;;^UTILITY(U,$J,358.3,4793,0)
 ;;=G56.01^^34^300^14
 ;;^UTILITY(U,$J,358.3,4793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4793,1,3,0)
 ;;=3^Carpal tunnel syndrome, right upper limb
 ;;^UTILITY(U,$J,358.3,4793,1,4,0)
 ;;=4^G56.01
 ;;^UTILITY(U,$J,358.3,4793,2)
 ;;=^5004018
 ;;^UTILITY(U,$J,358.3,4794,0)
 ;;=G56.02^^34^300^13
 ;;^UTILITY(U,$J,358.3,4794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4794,1,3,0)
 ;;=3^Carpal tunnel syndrome, left upper limb
 ;;^UTILITY(U,$J,358.3,4794,1,4,0)
 ;;=4^G56.02
 ;;^UTILITY(U,$J,358.3,4794,2)
 ;;=^5004019
 ;;^UTILITY(U,$J,358.3,4795,0)
 ;;=G56.21^^34^300^49
 ;;^UTILITY(U,$J,358.3,4795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4795,1,3,0)
 ;;=3^Lesion of ulnar nerve, right upper limb
 ;;^UTILITY(U,$J,358.3,4795,1,4,0)
 ;;=4^G56.21
 ;;^UTILITY(U,$J,358.3,4795,2)
 ;;=^5004024
 ;;^UTILITY(U,$J,358.3,4796,0)
 ;;=G56.22^^34^300^48
 ;;^UTILITY(U,$J,358.3,4796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4796,1,3,0)
 ;;=3^Lesion of ulnar nerve, left upper limb
 ;;^UTILITY(U,$J,358.3,4796,1,4,0)
 ;;=4^G56.22
 ;;^UTILITY(U,$J,358.3,4796,2)
 ;;=^5004025
 ;;^UTILITY(U,$J,358.3,4797,0)
 ;;=G60.9^^34^300^35
 ;;^UTILITY(U,$J,358.3,4797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4797,1,3,0)
 ;;=3^Hereditary and idiopathic neuropathy, unspecified
 ;;^UTILITY(U,$J,358.3,4797,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,4797,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,4798,0)
 ;;=L84.^^34^300^21
 ;;^UTILITY(U,$J,358.3,4798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4798,1,3,0)
 ;;=3^Corns and callosities
 ;;^UTILITY(U,$J,358.3,4798,1,4,0)
 ;;=4^L84.
 ;;^UTILITY(U,$J,358.3,4798,2)
 ;;=^271920
 ;;^UTILITY(U,$J,358.3,4799,0)
 ;;=M32.10^^34^300^111
 ;;^UTILITY(U,$J,358.3,4799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4799,1,3,0)
 ;;=3^Systemic lupus erythematosus, organ or system involv unsp
 ;;^UTILITY(U,$J,358.3,4799,1,4,0)
 ;;=4^M32.10
 ;;^UTILITY(U,$J,358.3,4799,2)
 ;;=^5011753
 ;;^UTILITY(U,$J,358.3,4800,0)
 ;;=M06.9^^34^300^89
 ;;^UTILITY(U,$J,358.3,4800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4800,1,3,0)
 ;;=3^Rheumatoid arthritis, unspecified
 ;;^UTILITY(U,$J,358.3,4800,1,4,0)
 ;;=4^M06.9
 ;;^UTILITY(U,$J,358.3,4800,2)
 ;;=^5010145
 ;;^UTILITY(U,$J,358.3,4801,0)
 ;;=M06.4^^34^300^40
 ;;^UTILITY(U,$J,358.3,4801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4801,1,3,0)
 ;;=3^Inflammatory polyarthropathy
 ;;^UTILITY(U,$J,358.3,4801,1,4,0)
 ;;=4^M06.4
 ;;^UTILITY(U,$J,358.3,4801,2)
 ;;=^5010120
 ;;^UTILITY(U,$J,358.3,4802,0)
 ;;=M15.0^^34^300^76
 ;;^UTILITY(U,$J,358.3,4802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4802,1,3,0)
 ;;=3^Primary generalized (osteo)arthritis
 ;;^UTILITY(U,$J,358.3,4802,1,4,0)
 ;;=4^M15.0
 ;;^UTILITY(U,$J,358.3,4802,2)
 ;;=^5010762
 ;;^UTILITY(U,$J,358.3,4803,0)
 ;;=M17.9^^34^300^57
 ;;^UTILITY(U,$J,358.3,4803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4803,1,3,0)
 ;;=3^Osteoarthritis of knee, unspecified
 ;;^UTILITY(U,$J,358.3,4803,1,4,0)
 ;;=4^M17.9
 ;;^UTILITY(U,$J,358.3,4803,2)
 ;;=^5010794
 ;;^UTILITY(U,$J,358.3,4804,0)
 ;;=M15.3^^34^300^94
 ;;^UTILITY(U,$J,358.3,4804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4804,1,3,0)
 ;;=3^Secondary multiple arthritis
 ;;^UTILITY(U,$J,358.3,4804,1,4,0)
 ;;=4^M15.3
 ;;^UTILITY(U,$J,358.3,4804,2)
 ;;=^5010765
 ;;^UTILITY(U,$J,358.3,4805,0)
 ;;=M19.011^^34^300^82
 ;;^UTILITY(U,$J,358.3,4805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4805,1,3,0)
 ;;=3^Primary osteoarthritis, right shoulder
 ;;^UTILITY(U,$J,358.3,4805,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,4805,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,4806,0)
 ;;=M19.012^^34^300^79
 ;;^UTILITY(U,$J,358.3,4806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4806,1,3,0)
 ;;=3^Primary osteoarthritis, left shoulder
 ;;^UTILITY(U,$J,358.3,4806,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,4806,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,4807,0)
 ;;=M19.041^^34^300^81
 ;;^UTILITY(U,$J,358.3,4807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4807,1,3,0)
 ;;=3^Primary osteoarthritis, right hand
 ;;^UTILITY(U,$J,358.3,4807,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,4807,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,4808,0)
 ;;=M19.042^^34^300^78
 ;;^UTILITY(U,$J,358.3,4808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4808,1,3,0)
 ;;=3^Primary osteoarthritis, left hand
 ;;^UTILITY(U,$J,358.3,4808,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,4808,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,4809,0)
 ;;=M16.9^^34^300^56
 ;;^UTILITY(U,$J,358.3,4809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4809,1,3,0)
 ;;=3^Osteoarthritis of hip, unspecified
 ;;^UTILITY(U,$J,358.3,4809,1,4,0)
 ;;=4^M16.9
 ;;^UTILITY(U,$J,358.3,4809,2)
 ;;=^5010783
 ;;^UTILITY(U,$J,358.3,4810,0)
 ;;=M19.071^^34^300^80
 ;;^UTILITY(U,$J,358.3,4810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4810,1,3,0)
 ;;=3^Primary osteoarthritis, right ankle and foot
 ;;^UTILITY(U,$J,358.3,4810,1,4,0)
 ;;=4^M19.071
 ;;^UTILITY(U,$J,358.3,4810,2)
 ;;=^5010820
 ;;^UTILITY(U,$J,358.3,4811,0)
 ;;=M19.072^^34^300^77
