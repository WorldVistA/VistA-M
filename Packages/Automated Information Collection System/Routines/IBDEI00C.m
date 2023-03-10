IBDEI00C ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,146,1,4,0)
 ;;=4^Z71.7
 ;;^UTILITY(U,$J,358.3,146,2)
 ;;=^5063251
 ;;^UTILITY(U,$J,358.3,147,0)
 ;;=Z72.4^^3^15^2
 ;;^UTILITY(U,$J,358.3,147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,147,1,3,0)
 ;;=3^Diet and Eating Habit Counseling
 ;;^UTILITY(U,$J,358.3,147,1,4,0)
 ;;=4^Z72.4
 ;;^UTILITY(U,$J,358.3,147,2)
 ;;=^5063257
 ;;^UTILITY(U,$J,358.3,148,0)
 ;;=Z72.3^^3^15^6
 ;;^UTILITY(U,$J,358.3,148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,148,1,3,0)
 ;;=3^Lack of Physical Exercise
 ;;^UTILITY(U,$J,358.3,148,1,4,0)
 ;;=4^Z72.3
 ;;^UTILITY(U,$J,358.3,148,2)
 ;;=^5063256
 ;;^UTILITY(U,$J,358.3,149,0)
 ;;=Z72.51^^3^15^5
 ;;^UTILITY(U,$J,358.3,149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,149,1,3,0)
 ;;=3^High Risk Heterosexual Behavior Counseling
 ;;^UTILITY(U,$J,358.3,149,1,4,0)
 ;;=4^Z72.51
 ;;^UTILITY(U,$J,358.3,149,2)
 ;;=^5063258
 ;;^UTILITY(U,$J,358.3,150,0)
 ;;=Z72.9^^3^15^7
 ;;^UTILITY(U,$J,358.3,150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,150,1,3,0)
 ;;=3^Lifestyle Counseling
 ;;^UTILITY(U,$J,358.3,150,1,4,0)
 ;;=4^Z72.9
 ;;^UTILITY(U,$J,358.3,150,2)
 ;;=^5063267
 ;;^UTILITY(U,$J,358.3,151,0)
 ;;=Z71.82^^3^15^3
 ;;^UTILITY(U,$J,358.3,151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,151,1,3,0)
 ;;=3^Exercise Counseling
 ;;^UTILITY(U,$J,358.3,151,1,4,0)
 ;;=4^Z71.82
 ;;^UTILITY(U,$J,358.3,151,2)
 ;;=^303466
 ;;^UTILITY(U,$J,358.3,152,0)
 ;;=Z00.00^^3^16^8
 ;;^UTILITY(U,$J,358.3,152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,152,1,3,0)
 ;;=3^General Medical Exam w/ Normal Findings
 ;;^UTILITY(U,$J,358.3,152,1,4,0)
 ;;=4^Z00.00
 ;;^UTILITY(U,$J,358.3,152,2)
 ;;=^5062599
 ;;^UTILITY(U,$J,358.3,153,0)
 ;;=Z00.8^^3^16^6
 ;;^UTILITY(U,$J,358.3,153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,153,1,3,0)
 ;;=3^General Exam,Other
 ;;^UTILITY(U,$J,358.3,153,1,4,0)
 ;;=4^Z00.8
 ;;^UTILITY(U,$J,358.3,153,2)
 ;;=^5062611
 ;;^UTILITY(U,$J,358.3,154,0)
 ;;=Z02.89^^3^16^1
 ;;^UTILITY(U,$J,358.3,154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,154,1,3,0)
 ;;=3^Administrative Examination
 ;;^UTILITY(U,$J,358.3,154,1,4,0)
 ;;=4^Z02.89
 ;;^UTILITY(U,$J,358.3,154,2)
 ;;=^5062645
 ;;^UTILITY(U,$J,358.3,155,0)
 ;;=Z02.1^^3^16^12
 ;;^UTILITY(U,$J,358.3,155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,155,1,3,0)
 ;;=3^Pre-Employment Examination
 ;;^UTILITY(U,$J,358.3,155,1,4,0)
 ;;=4^Z02.1
 ;;^UTILITY(U,$J,358.3,155,2)
 ;;=^5062634
 ;;^UTILITY(U,$J,358.3,156,0)
 ;;=Z02.3^^3^16^13
 ;;^UTILITY(U,$J,358.3,156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,156,1,3,0)
 ;;=3^Recruitment to Armed Forces Examination
 ;;^UTILITY(U,$J,358.3,156,1,4,0)
 ;;=4^Z02.3
 ;;^UTILITY(U,$J,358.3,156,2)
 ;;=^5062636
 ;;^UTILITY(U,$J,358.3,157,0)
 ;;=Z00.5^^3^16^11
 ;;^UTILITY(U,$J,358.3,157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,157,1,3,0)
 ;;=3^Potential Organ/Tissue Donor Examination
 ;;^UTILITY(U,$J,358.3,157,1,4,0)
 ;;=4^Z00.5
 ;;^UTILITY(U,$J,358.3,157,2)
 ;;=^5062607
 ;;^UTILITY(U,$J,358.3,158,0)
 ;;=Z01.419^^3^16^10
 ;;^UTILITY(U,$J,358.3,158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,158,1,3,0)
 ;;=3^Gyn Exam w/ Normal Findings
 ;;^UTILITY(U,$J,358.3,158,1,4,0)
 ;;=4^Z01.419
 ;;^UTILITY(U,$J,358.3,158,2)
 ;;=^5062623
 ;;^UTILITY(U,$J,358.3,159,0)
 ;;=Z01.411^^3^16^9
 ;;^UTILITY(U,$J,358.3,159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,159,1,3,0)
 ;;=3^Gyn Exam w/ Abnormal Findings
 ;;^UTILITY(U,$J,358.3,159,1,4,0)
 ;;=4^Z01.411
 ;;^UTILITY(U,$J,358.3,159,2)
 ;;=^5062622
 ;;^UTILITY(U,$J,358.3,160,0)
 ;;=Z00.01^^3^16^7
 ;;^UTILITY(U,$J,358.3,160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,160,1,3,0)
 ;;=3^General Medical Exam w/ Abnormal Findings
 ;;^UTILITY(U,$J,358.3,160,1,4,0)
 ;;=4^Z00.01
 ;;^UTILITY(U,$J,358.3,160,2)
 ;;=^5062600
 ;;^UTILITY(U,$J,358.3,161,0)
 ;;=Z02.0^^3^16^2
 ;;^UTILITY(U,$J,358.3,161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,161,1,3,0)
 ;;=3^Exam for Admission to Educational Institution
 ;;^UTILITY(U,$J,358.3,161,1,4,0)
 ;;=4^Z02.0
 ;;^UTILITY(U,$J,358.3,161,2)
 ;;=^5062633
 ;;^UTILITY(U,$J,358.3,162,0)
 ;;=Z02.2^^3^16^3
 ;;^UTILITY(U,$J,358.3,162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,162,1,3,0)
 ;;=3^Exam for Admission to Residential Institution
 ;;^UTILITY(U,$J,358.3,162,1,4,0)
 ;;=4^Z02.2
 ;;^UTILITY(U,$J,358.3,162,2)
 ;;=^5062635
 ;;^UTILITY(U,$J,358.3,163,0)
 ;;=Z01.020^^3^16^4
 ;;^UTILITY(U,$J,358.3,163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,163,1,3,0)
 ;;=3^Exam of Eye/Vision Following Failed Vision Scrn w/o Abn Findings
 ;;^UTILITY(U,$J,358.3,163,1,4,0)
 ;;=4^Z01.020
 ;;^UTILITY(U,$J,358.3,163,2)
 ;;=^5158318
 ;;^UTILITY(U,$J,358.3,164,0)
 ;;=Z01.021^^3^16^5
 ;;^UTILITY(U,$J,358.3,164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,164,1,3,0)
 ;;=3^Exam of Eye/Vision Following Failed Vision Scrn w/ Abn Findings
 ;;^UTILITY(U,$J,358.3,164,1,4,0)
 ;;=4^Z01.021
 ;;^UTILITY(U,$J,358.3,164,2)
 ;;=^5158319
 ;;^UTILITY(U,$J,358.3,165,0)
 ;;=Z85.43^^3^17^60
 ;;^UTILITY(U,$J,358.3,165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,165,1,3,0)
 ;;=3^Personal Hx of Malig Neop Ovary
 ;;^UTILITY(U,$J,358.3,165,1,4,0)
 ;;=4^Z85.43
 ;;^UTILITY(U,$J,358.3,165,2)
 ;;=^5063420
 ;;^UTILITY(U,$J,358.3,166,0)
 ;;=Z85.46^^3^17^61
 ;;^UTILITY(U,$J,358.3,166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,166,1,3,0)
 ;;=3^Personal Hx of Malig Neop Prostate
 ;;^UTILITY(U,$J,358.3,166,1,4,0)
 ;;=4^Z85.46
 ;;^UTILITY(U,$J,358.3,166,2)
 ;;=^5063423
 ;;^UTILITY(U,$J,358.3,167,0)
 ;;=Z85.6^^3^17^58
 ;;^UTILITY(U,$J,358.3,167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,167,1,3,0)
 ;;=3^Personal Hx of Leukemia
 ;;^UTILITY(U,$J,358.3,167,1,4,0)
 ;;=4^Z85.6
 ;;^UTILITY(U,$J,358.3,167,2)
 ;;=^5063434
 ;;^UTILITY(U,$J,358.3,168,0)
 ;;=Z85.71^^3^17^50
 ;;^UTILITY(U,$J,358.3,168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,168,1,3,0)
 ;;=3^Personal Hx of Hodgkin Lymphoma
 ;;^UTILITY(U,$J,358.3,168,1,4,0)
 ;;=4^Z85.71
 ;;^UTILITY(U,$J,358.3,168,2)
 ;;=^5063435
 ;;^UTILITY(U,$J,358.3,169,0)
 ;;=Z85.820^^3^17^59
 ;;^UTILITY(U,$J,358.3,169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,169,1,3,0)
 ;;=3^Personal Hx of Malig Melanoma of SKin
 ;;^UTILITY(U,$J,358.3,169,1,4,0)
 ;;=4^Z85.820
 ;;^UTILITY(U,$J,358.3,169,2)
 ;;=^5063441
 ;;^UTILITY(U,$J,358.3,170,0)
 ;;=Z85.828^^3^17^62
 ;;^UTILITY(U,$J,358.3,170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,170,1,3,0)
 ;;=3^Personal Hx of Malig Neop Skin
 ;;^UTILITY(U,$J,358.3,170,1,4,0)
 ;;=4^Z85.828
 ;;^UTILITY(U,$J,358.3,170,2)
 ;;=^5063443
 ;;^UTILITY(U,$J,358.3,171,0)
 ;;=Z65.8^^3^17^68
 ;;^UTILITY(U,$J,358.3,171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,171,1,3,0)
 ;;=3^Personal Hx of Psychosocial Circumstance Problems
 ;;^UTILITY(U,$J,358.3,171,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,171,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,172,0)
 ;;=Z86.718^^3^17^71
 ;;^UTILITY(U,$J,358.3,172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,172,1,3,0)
 ;;=3^Personal Hx of Venous Thrombosis & Embolism
 ;;^UTILITY(U,$J,358.3,172,1,4,0)
 ;;=4^Z86.718
 ;;^UTILITY(U,$J,358.3,172,2)
 ;;=^5063475
 ;;^UTILITY(U,$J,358.3,173,0)
 ;;=Z86.73^^3^17^70
 ;;^UTILITY(U,$J,358.3,173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,173,1,3,0)
 ;;=3^Personal Hx of TIA
 ;;^UTILITY(U,$J,358.3,173,1,4,0)
 ;;=4^Z86.73
 ;;^UTILITY(U,$J,358.3,173,2)
 ;;=^5063477
 ;;^UTILITY(U,$J,358.3,174,0)
 ;;=Z86.79^^3^17^46
 ;;^UTILITY(U,$J,358.3,174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,174,1,3,0)
 ;;=3^Personal Hx of Circulatory System Diseases
 ;;^UTILITY(U,$J,358.3,174,1,4,0)
 ;;=4^Z86.79
 ;;^UTILITY(U,$J,358.3,174,2)
 ;;=^5063479
 ;;^UTILITY(U,$J,358.3,175,0)
 ;;=Z87.11^^3^17^67
 ;;^UTILITY(U,$J,358.3,175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,175,1,3,0)
 ;;=3^Personal Hx of Peptic Ulcer Disease
 ;;^UTILITY(U,$J,358.3,175,1,4,0)
 ;;=4^Z87.11
 ;;^UTILITY(U,$J,358.3,175,2)
 ;;=^5063482
 ;;^UTILITY(U,$J,358.3,176,0)
 ;;=Z86.010^^3^17^47
 ;;^UTILITY(U,$J,358.3,176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,176,1,3,0)
 ;;=3^Personal Hx of Colonic Polyps
 ;;^UTILITY(U,$J,358.3,176,1,4,0)
 ;;=4^Z86.010
 ;;^UTILITY(U,$J,358.3,176,2)
 ;;=^5063456
 ;;^UTILITY(U,$J,358.3,177,0)
 ;;=Z87.39^^3^17^64
 ;;^UTILITY(U,$J,358.3,177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,177,1,3,0)
 ;;=3^Personal Hx of Musculoskeletal System Diseases
 ;;^UTILITY(U,$J,358.3,177,1,4,0)
 ;;=4^Z87.39
 ;;^UTILITY(U,$J,358.3,177,2)
 ;;=^5063488
 ;;^UTILITY(U,$J,358.3,178,0)
 ;;=Z92.3^^3^17^56
 ;;^UTILITY(U,$J,358.3,178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,178,1,3,0)
 ;;=3^Personal Hx of Irradiation
 ;;^UTILITY(U,$J,358.3,178,1,4,0)
 ;;=4^Z92.3
 ;;^UTILITY(U,$J,358.3,178,2)
 ;;=^5063637
 ;;^UTILITY(U,$J,358.3,179,0)
 ;;=Z87.820^^3^17^69
 ;;^UTILITY(U,$J,358.3,179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,179,1,3,0)
 ;;=3^Personal Hx of TBI
 ;;^UTILITY(U,$J,358.3,179,1,4,0)
 ;;=4^Z87.820
 ;;^UTILITY(U,$J,358.3,179,2)
 ;;=^5063514
 ;;^UTILITY(U,$J,358.3,180,0)
 ;;=Z87.891^^3^17^65
 ;;^UTILITY(U,$J,358.3,180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,180,1,3,0)
 ;;=3^Personal Hx of Nicotine Dependence
 ;;^UTILITY(U,$J,358.3,180,1,4,0)
 ;;=4^Z87.891
 ;;^UTILITY(U,$J,358.3,180,2)
 ;;=^5063518
 ;;^UTILITY(U,$J,358.3,181,0)
 ;;=Z77.090^^3^17^48
 ;;^UTILITY(U,$J,358.3,181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,181,1,3,0)
 ;;=3^Personal Hx of Contact With & Exposure to Asbestos
 ;;^UTILITY(U,$J,358.3,181,1,4,0)
 ;;=4^Z77.090
 ;;^UTILITY(U,$J,358.3,181,2)
 ;;=^5063312
 ;;^UTILITY(U,$J,358.3,182,0)
 ;;=Z57.8^^3^17^66
 ;;^UTILITY(U,$J,358.3,182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,182,1,3,0)
 ;;=3^Personal Hx of Occupational Exposure to Other Risk Factors
 ;;^UTILITY(U,$J,358.3,182,1,4,0)
 ;;=4^Z57.8
 ;;^UTILITY(U,$J,358.3,182,2)
 ;;=^5063127
 ;;^UTILITY(U,$J,358.3,183,0)
 ;;=Z91.81^^3^17^49
 ;;^UTILITY(U,$J,358.3,183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,183,1,3,0)
 ;;=3^Personal Hx of Falling
 ;;^UTILITY(U,$J,358.3,183,1,4,0)
 ;;=4^Z91.81
 ;;^UTILITY(U,$J,358.3,183,2)
 ;;=^5063625
 ;;^UTILITY(U,$J,358.3,184,0)
 ;;=Z80.0^^3^17^25
 ;;^UTILITY(U,$J,358.3,184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,184,1,3,0)
 ;;=3^Family Hx of Malig Neop Digestive Organs
 ;;^UTILITY(U,$J,358.3,184,1,4,0)
 ;;=4^Z80.0
 ;;^UTILITY(U,$J,358.3,184,2)
 ;;=^5063344
 ;;^UTILITY(U,$J,358.3,185,0)
 ;;=Z80.1^^3^17^32
 ;;^UTILITY(U,$J,358.3,185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,185,1,3,0)
 ;;=3^Family Hx of Malig Neop Trachea,Bronchus & Lung
 ;;^UTILITY(U,$J,358.3,185,1,4,0)
 ;;=4^Z80.1
 ;;^UTILITY(U,$J,358.3,185,2)
 ;;=^5063345
 ;;^UTILITY(U,$J,358.3,186,0)
 ;;=Z80.3^^3^17^24
 ;;^UTILITY(U,$J,358.3,186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,186,1,3,0)
 ;;=3^Family Hx of Malig Neop Breast
 ;;^UTILITY(U,$J,358.3,186,1,4,0)
 ;;=4^Z80.3
 ;;^UTILITY(U,$J,358.3,186,2)
 ;;=^5063347
 ;;^UTILITY(U,$J,358.3,187,0)
 ;;=Z80.41^^3^17^29
 ;;^UTILITY(U,$J,358.3,187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,187,1,3,0)
 ;;=3^Family Hx of Malig Neop Ovary
 ;;^UTILITY(U,$J,358.3,187,1,4,0)
 ;;=4^Z80.41
 ;;^UTILITY(U,$J,358.3,187,2)
 ;;=^5063348
 ;;^UTILITY(U,$J,358.3,188,0)
 ;;=Z80.42^^3^17^30
 ;;^UTILITY(U,$J,358.3,188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,188,1,3,0)
 ;;=3^Family Hx of Malig Neop Prostate
 ;;^UTILITY(U,$J,358.3,188,1,4,0)
 ;;=4^Z80.42
 ;;^UTILITY(U,$J,358.3,188,2)
 ;;=^5063349
 ;;^UTILITY(U,$J,358.3,189,0)
 ;;=Z80.43^^3^17^31
 ;;^UTILITY(U,$J,358.3,189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,189,1,3,0)
 ;;=3^Family Hx of Malig Neop Testis
 ;;^UTILITY(U,$J,358.3,189,1,4,0)
 ;;=4^Z80.43
 ;;^UTILITY(U,$J,358.3,189,2)
 ;;=^5063350
 ;;^UTILITY(U,$J,358.3,190,0)
 ;;=Z80.6^^3^17^22
 ;;^UTILITY(U,$J,358.3,190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,190,1,3,0)
 ;;=3^Family Hx of Leukemia
 ;;^UTILITY(U,$J,358.3,190,1,4,0)
 ;;=4^Z80.6
 ;;^UTILITY(U,$J,358.3,190,2)
 ;;=^5063354
 ;;^UTILITY(U,$J,358.3,191,0)
 ;;=Z80.8^^3^17^34
 ;;^UTILITY(U,$J,358.3,191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,191,1,3,0)
 ;;=3^Family Hx of Malig Neop of Organs/Systems
 ;;^UTILITY(U,$J,358.3,191,1,4,0)
 ;;=4^Z80.8
 ;;^UTILITY(U,$J,358.3,191,2)
 ;;=^5063356
 ;;^UTILITY(U,$J,358.3,192,0)
 ;;=Z81.8^^3^17^36
 ;;^UTILITY(U,$J,358.3,192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,192,1,3,0)
 ;;=3^Family Hx of Mental & Behavioral Disorders
 ;;^UTILITY(U,$J,358.3,192,1,4,0)
 ;;=4^Z81.8
 ;;^UTILITY(U,$J,358.3,192,2)
 ;;=^5063363
 ;;^UTILITY(U,$J,358.3,193,0)
 ;;=Z82.3^^3^17^43
 ;;^UTILITY(U,$J,358.3,193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,193,1,3,0)
 ;;=3^Family Hx of Stroke
 ;;^UTILITY(U,$J,358.3,193,1,4,0)
 ;;=4^Z82.3
 ;;^UTILITY(U,$J,358.3,193,2)
 ;;=^5063367
 ;;^UTILITY(U,$J,358.3,194,0)
 ;;=Z83.2^^3^17^4
 ;;^UTILITY(U,$J,358.3,194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,194,1,3,0)
 ;;=3^Family Hx of Blood/Blood-Forming Organ Diseases
 ;;^UTILITY(U,$J,358.3,194,1,4,0)
 ;;=4^Z83.2
 ;;^UTILITY(U,$J,358.3,194,2)
 ;;=^5063378
 ;;^UTILITY(U,$J,358.3,195,0)
 ;;=Z82.49^^3^17^20
 ;;^UTILITY(U,$J,358.3,195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,195,1,3,0)
 ;;=3^Family Hx of Ischemic Heart Disease
 ;;^UTILITY(U,$J,358.3,195,1,4,0)
 ;;=4^Z82.49
 ;;^UTILITY(U,$J,358.3,195,2)
 ;;=^5063369
 ;;^UTILITY(U,$J,358.3,196,0)
 ;;=Z82.5^^3^17^3
 ;;^UTILITY(U,$J,358.3,196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,196,1,3,0)
 ;;=3^Family Hx of Asthma
 ;;^UTILITY(U,$J,358.3,196,1,4,0)
 ;;=4^Z82.5
 ;;^UTILITY(U,$J,358.3,196,2)
 ;;=^5063370
 ;;^UTILITY(U,$J,358.3,197,0)
 ;;=Z82.61^^3^17^2
 ;;^UTILITY(U,$J,358.3,197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,197,1,3,0)
 ;;=3^Family Hx of Arthritis
 ;;^UTILITY(U,$J,358.3,197,1,4,0)
 ;;=4^Z82.61
 ;;^UTILITY(U,$J,358.3,197,2)
 ;;=^5063371
 ;;^UTILITY(U,$J,358.3,198,0)
 ;;=Z82.69^^3^17^38
 ;;^UTILITY(U,$J,358.3,198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,198,1,3,0)
 ;;=3^Family Hx of Musculoskeletal System Diseases
 ;;^UTILITY(U,$J,358.3,198,1,4,0)
 ;;=4^Z82.69
 ;;^UTILITY(U,$J,358.3,198,2)
 ;;=^5063373
 ;;^UTILITY(U,$J,358.3,199,0)
 ;;=Z83.3^^3^17^8
 ;;^UTILITY(U,$J,358.3,199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,199,1,3,0)
 ;;=3^Family Hx of Diabetes Mellitus
 ;;^UTILITY(U,$J,358.3,199,1,4,0)
 ;;=4^Z83.3
 ;;^UTILITY(U,$J,358.3,199,2)
 ;;=^5063379
 ;;^UTILITY(U,$J,358.3,200,0)
 ;;=Z82.71^^3^17^40
 ;;^UTILITY(U,$J,358.3,200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,200,1,3,0)
 ;;=3^Family Hx of Polycystic Kidney
 ;;^UTILITY(U,$J,358.3,200,1,4,0)
 ;;=4^Z82.71
 ;;^UTILITY(U,$J,358.3,200,2)
 ;;=^321531
 ;;^UTILITY(U,$J,358.3,201,0)
 ;;=Z82.2^^3^17^7
 ;;^UTILITY(U,$J,358.3,201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,201,1,3,0)
 ;;=3^Family Hx of Deafness & Hearing Loss
 ;;^UTILITY(U,$J,358.3,201,1,4,0)
 ;;=4^Z82.2
 ;;^UTILITY(U,$J,358.3,201,2)
 ;;=^5063366
 ;;^UTILITY(U,$J,358.3,202,0)
 ;;=Z84.0^^3^17^42
 ;;^UTILITY(U,$J,358.3,202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,202,1,3,0)
 ;;=3^Family Hx of Skin & Subcutaneous Tissue Diseases
 ;;^UTILITY(U,$J,358.3,202,1,4,0)
 ;;=4^Z84.0
 ;;^UTILITY(U,$J,358.3,202,2)
 ;;=^5063388
 ;;^UTILITY(U,$J,358.3,203,0)
 ;;=Z82.79^^3^17^6
 ;;^UTILITY(U,$J,358.3,203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,203,1,3,0)
 ;;=3^Family Hx of Congenital Malformations
 ;;^UTILITY(U,$J,358.3,203,1,4,0)
 ;;=4^Z82.79
 ;;^UTILITY(U,$J,358.3,203,2)
 ;;=^5063374
 ;;^UTILITY(U,$J,358.3,204,0)
 ;;=Z80.49^^3^17^26
 ;;^UTILITY(U,$J,358.3,204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,204,1,3,0)
 ;;=3^Family Hx of Malig Neop Genital Organs
 ;;^UTILITY(U,$J,358.3,204,1,4,0)
 ;;=4^Z80.49
 ;;^UTILITY(U,$J,358.3,204,2)
 ;;=^5063351
 ;;^UTILITY(U,$J,358.3,205,0)
 ;;=Z80.51^^3^17^27
 ;;^UTILITY(U,$J,358.3,205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,205,1,3,0)
 ;;=3^Family Hx of Malig Neop Kidney
 ;;^UTILITY(U,$J,358.3,205,1,4,0)
 ;;=4^Z80.51
 ;;^UTILITY(U,$J,358.3,205,2)
 ;;=^321159
 ;;^UTILITY(U,$J,358.3,206,0)
 ;;=Z80.52^^3^17^23
 ;;^UTILITY(U,$J,358.3,206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,206,1,3,0)
 ;;=3^Family Hx of Malig Neop Bladder
 ;;^UTILITY(U,$J,358.3,206,1,4,0)
 ;;=4^Z80.52
 ;;^UTILITY(U,$J,358.3,206,2)
 ;;=^5063352
 ;;^UTILITY(U,$J,358.3,207,0)
 ;;=Z80.59^^3^17^33
 ;;^UTILITY(U,$J,358.3,207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,207,1,3,0)
 ;;=3^Family Hx of Malig Neop Urinary Tract Organ
 ;;^UTILITY(U,$J,358.3,207,1,4,0)
 ;;=4^Z80.59
 ;;^UTILITY(U,$J,358.3,207,2)
 ;;=^5063353
 ;;^UTILITY(U,$J,358.3,208,0)
 ;;=Z80.7^^3^17^28
 ;;^UTILITY(U,$J,358.3,208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,208,1,3,0)
 ;;=3^Family Hx of Malig Neop Lymphoid,Hematopoietic & Related Tissues
 ;;^UTILITY(U,$J,358.3,208,1,4,0)
 ;;=4^Z80.7
 ;;^UTILITY(U,$J,358.3,208,2)
 ;;=^5063355
 ;;^UTILITY(U,$J,358.3,209,0)
 ;;=Z80.9^^3^17^35
 ;;^UTILITY(U,$J,358.3,209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,209,1,3,0)
 ;;=3^Family Hx of Malig Neop,Unspec
 ;;^UTILITY(U,$J,358.3,209,1,4,0)
 ;;=4^Z80.9
 ;;^UTILITY(U,$J,358.3,209,2)
 ;;=^5063357
 ;;^UTILITY(U,$J,358.3,210,0)
 ;;=Z82.0^^3^17^13
 ;;^UTILITY(U,$J,358.3,210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,210,1,3,0)
 ;;=3^Family Hx of Epilepsy
 ;;^UTILITY(U,$J,358.3,210,1,4,0)
 ;;=4^Z82.0
 ;;^UTILITY(U,$J,358.3,210,2)
 ;;=^5063364
 ;;^UTILITY(U,$J,358.3,211,0)
 ;;=Z82.41^^3^17^44
 ;;^UTILITY(U,$J,358.3,211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,211,1,3,0)
 ;;=3^Family Hx of Sudden Cardiac Death
 ;;^UTILITY(U,$J,358.3,211,1,4,0)
 ;;=4^Z82.41
 ;;^UTILITY(U,$J,358.3,211,2)
 ;;=^5063368
 ;;^UTILITY(U,$J,358.3,212,0)
 ;;=Z83.6^^3^17^41
 ;;^UTILITY(U,$J,358.3,212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,212,1,3,0)
 ;;=3^Family Hx of Respiratory System Diseases
 ;;^UTILITY(U,$J,358.3,212,1,4,0)
 ;;=4^Z83.6
 ;;^UTILITY(U,$J,358.3,212,2)
 ;;=^5063385
 ;;^UTILITY(U,$J,358.3,213,0)
 ;;=Z82.62^^3^17^39
 ;;^UTILITY(U,$J,358.3,213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,213,1,3,0)
 ;;=3^Family Hx of Osteoporosis
 ;;^UTILITY(U,$J,358.3,213,1,4,0)
 ;;=4^Z82.62
 ;;^UTILITY(U,$J,358.3,213,2)
 ;;=^5063372
 ;;^UTILITY(U,$J,358.3,214,0)
 ;;=Z83.41^^3^17^37
 ;;^UTILITY(U,$J,358.3,214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,214,1,3,0)
 ;;=3^Family Hx of Multiple Endocrine Neoplasia Syndrome
 ;;^UTILITY(U,$J,358.3,214,1,4,0)
 ;;=4^Z83.41
 ;;^UTILITY(U,$J,358.3,214,2)
 ;;=^5063380
 ;;^UTILITY(U,$J,358.3,215,0)
 ;;=Z83.49^^3^17^12
 ;;^UTILITY(U,$J,358.3,215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,215,1,3,0)
 ;;=3^Family Hx of Endo,Nutritional & Metabolic Diseases
 ;;^UTILITY(U,$J,358.3,215,1,4,0)
 ;;=4^Z83.49
 ;;^UTILITY(U,$J,358.3,215,2)
 ;;=^5063381
 ;;^UTILITY(U,$J,358.3,216,0)
 ;;=Z81.0^^3^17^19
 ;;^UTILITY(U,$J,358.3,216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,216,1,3,0)
 ;;=3^Family Hx of Intellectual Disabilities
 ;;^UTILITY(U,$J,358.3,216,1,4,0)
 ;;=4^Z81.0
 ;;^UTILITY(U,$J,358.3,216,2)
 ;;=^5063358
 ;;^UTILITY(U,$J,358.3,217,0)
 ;;=Z84.1^^3^17^21
 ;;^UTILITY(U,$J,358.3,217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,217,1,3,0)
 ;;=3^Family Hx of Kidney & Ureter Disorders
