IBDEI00S ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,461,1,3,0)
 ;;=3^Insomnia,Other Specified
 ;;^UTILITY(U,$J,358.3,461,1,4,0)
 ;;=4^G47.09
 ;;^UTILITY(U,$J,358.3,461,2)
 ;;=^5003970
 ;;^UTILITY(U,$J,358.3,462,0)
 ;;=G47.00^^3^45^17
 ;;^UTILITY(U,$J,358.3,462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,462,1,3,0)
 ;;=3^Insomnia,Unspec
 ;;^UTILITY(U,$J,358.3,462,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,462,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,463,0)
 ;;=G47.10^^3^45^14
 ;;^UTILITY(U,$J,358.3,463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,463,1,3,0)
 ;;=3^Hypersomnolence Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,463,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,463,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,464,0)
 ;;=G47.419^^3^45^20
 ;;^UTILITY(U,$J,358.3,464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,464,1,3,0)
 ;;=3^Narcolepsy w/o Cataplexy w/ Hypocretin Deficiency
 ;;^UTILITY(U,$J,358.3,464,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,464,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,465,0)
 ;;=G47.33^^3^45^24
 ;;^UTILITY(U,$J,358.3,465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,465,1,3,0)
 ;;=3^Obstructive Sleep Apnea Hypopnea
 ;;^UTILITY(U,$J,358.3,465,1,4,0)
 ;;=4^G47.33
 ;;^UTILITY(U,$J,358.3,465,2)
 ;;=^332763
 ;;^UTILITY(U,$J,358.3,466,0)
 ;;=G47.31^^3^45^4
 ;;^UTILITY(U,$J,358.3,466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,466,1,3,0)
 ;;=3^Central Sleep Apnea,Idiopathic
 ;;^UTILITY(U,$J,358.3,466,1,4,0)
 ;;=4^G47.31
 ;;^UTILITY(U,$J,358.3,466,2)
 ;;=^332761
 ;;^UTILITY(U,$J,358.3,467,0)
 ;;=G47.21^^3^45^7
 ;;^UTILITY(U,$J,358.3,467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,467,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Delayed Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,467,1,4,0)
 ;;=4^G47.21
 ;;^UTILITY(U,$J,358.3,467,2)
 ;;=^332769
 ;;^UTILITY(U,$J,358.3,468,0)
 ;;=G47.22^^3^45^6
 ;;^UTILITY(U,$J,358.3,468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,468,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Advanced Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,468,1,4,0)
 ;;=4^G47.22
 ;;^UTILITY(U,$J,358.3,468,2)
 ;;=^332770
 ;;^UTILITY(U,$J,358.3,469,0)
 ;;=G47.23^^3^45^8
 ;;^UTILITY(U,$J,358.3,469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,469,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Irregular Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,469,1,4,0)
 ;;=4^G47.23
 ;;^UTILITY(U,$J,358.3,469,2)
 ;;=^5003975
 ;;^UTILITY(U,$J,358.3,470,0)
 ;;=G47.24^^3^45^9
 ;;^UTILITY(U,$J,358.3,470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,470,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,470,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,470,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,471,0)
 ;;=G47.26^^3^45^10
 ;;^UTILITY(U,$J,358.3,471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,471,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Shift Work Type
 ;;^UTILITY(U,$J,358.3,471,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,471,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,472,0)
 ;;=G47.20^^3^45^11
 ;;^UTILITY(U,$J,358.3,472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,472,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Unspec Type
 ;;^UTILITY(U,$J,358.3,472,1,4,0)
 ;;=4^G47.20
 ;;^UTILITY(U,$J,358.3,472,2)
 ;;=^5003974
 ;;^UTILITY(U,$J,358.3,473,0)
 ;;=F51.3^^3^45^22
 ;;^UTILITY(U,$J,358.3,473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,473,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal D/O;Sleepwalking Type
 ;;^UTILITY(U,$J,358.3,473,1,4,0)
 ;;=4^F51.3
 ;;^UTILITY(U,$J,358.3,473,2)
 ;;=^5003613
 ;;^UTILITY(U,$J,358.3,474,0)
 ;;=F51.4^^3^45^23
 ;;^UTILITY(U,$J,358.3,474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,474,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal D/O;Sleep Terror Type
 ;;^UTILITY(U,$J,358.3,474,1,4,0)
 ;;=4^F51.4
 ;;^UTILITY(U,$J,358.3,474,2)
 ;;=^5003614
 ;;^UTILITY(U,$J,358.3,475,0)
 ;;=F51.5^^3^45^21
 ;;^UTILITY(U,$J,358.3,475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,475,1,3,0)
 ;;=3^Nightmare Disorder
 ;;^UTILITY(U,$J,358.3,475,1,4,0)
 ;;=4^F51.5
 ;;^UTILITY(U,$J,358.3,475,2)
 ;;=^5003615
 ;;^UTILITY(U,$J,358.3,476,0)
 ;;=G47.52^^3^45^25
 ;;^UTILITY(U,$J,358.3,476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,476,1,3,0)
 ;;=3^Rapid Eye Movement Sleep Behavior Disorder
 ;;^UTILITY(U,$J,358.3,476,1,4,0)
 ;;=4^G47.52
 ;;^UTILITY(U,$J,358.3,476,2)
 ;;=^332778
 ;;^UTILITY(U,$J,358.3,477,0)
 ;;=G25.81^^3^45^26
 ;;^UTILITY(U,$J,358.3,477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,477,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,477,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,477,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,478,0)
 ;;=G47.19^^3^45^13
 ;;^UTILITY(U,$J,358.3,478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,478,1,3,0)
 ;;=3^Hypersomnolence Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,478,1,4,0)
 ;;=4^G47.19
 ;;^UTILITY(U,$J,358.3,478,2)
 ;;=^5003973
 ;;^UTILITY(U,$J,358.3,479,0)
 ;;=G47.8^^3^45^30
 ;;^UTILITY(U,$J,358.3,479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,479,1,3,0)
 ;;=3^Sleep-Wake Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,479,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,479,2)
 ;;=^5003989
 ;;^UTILITY(U,$J,358.3,480,0)
 ;;=G47.411^^3^45^19
 ;;^UTILITY(U,$J,358.3,480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,480,1,3,0)
 ;;=3^Narcolepsy w/ Cataplexy w/o Hypocretin Deficiency
 ;;^UTILITY(U,$J,358.3,480,1,4,0)
 ;;=4^G47.411
 ;;^UTILITY(U,$J,358.3,480,2)
 ;;=^5003981
 ;;^UTILITY(U,$J,358.3,481,0)
 ;;=G47.37^^3^45^3
 ;;^UTILITY(U,$J,358.3,481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,481,1,3,0)
 ;;=3^Central Sleep Apnea,Comorbid w/ Opioid Use
 ;;^UTILITY(U,$J,358.3,481,1,4,0)
 ;;=4^G47.37
 ;;^UTILITY(U,$J,358.3,481,2)
 ;;=^332767
 ;;^UTILITY(U,$J,358.3,482,0)
 ;;=F51.11^^3^45^12
 ;;^UTILITY(U,$J,358.3,482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,482,1,3,0)
 ;;=3^Hypersomnolence Disorder
 ;;^UTILITY(U,$J,358.3,482,1,4,0)
 ;;=4^F51.11
 ;;^UTILITY(U,$J,358.3,482,2)
 ;;=^5003609
 ;;^UTILITY(U,$J,358.3,483,0)
 ;;=F51.01^^3^45^15
 ;;^UTILITY(U,$J,358.3,483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,483,1,3,0)
 ;;=3^Insomnia Disorder
 ;;^UTILITY(U,$J,358.3,483,1,4,0)
 ;;=4^F51.01
 ;;^UTILITY(U,$J,358.3,483,2)
 ;;=^5003603
 ;;^UTILITY(U,$J,358.3,484,0)
 ;;=G47.36^^3^45^27
 ;;^UTILITY(U,$J,358.3,484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,484,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Comorbid Sleep-Related Hypoventilation
 ;;^UTILITY(U,$J,358.3,484,1,4,0)
 ;;=4^G47.36
 ;;^UTILITY(U,$J,358.3,484,2)
 ;;=^5003979
 ;;^UTILITY(U,$J,358.3,485,0)
 ;;=G47.35^^3^45^28
 ;;^UTILITY(U,$J,358.3,485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,485,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Congenital Central Alveolar Hypoventilation
 ;;^UTILITY(U,$J,358.3,485,1,4,0)
 ;;=4^G47.35
 ;;^UTILITY(U,$J,358.3,485,2)
 ;;=^332765
 ;;^UTILITY(U,$J,358.3,486,0)
 ;;=G47.34^^3^45^29
 ;;^UTILITY(U,$J,358.3,486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,486,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Idiopathic
 ;;^UTILITY(U,$J,358.3,486,1,4,0)
 ;;=4^G47.34
 ;;^UTILITY(U,$J,358.3,486,2)
 ;;=^5003978
 ;;^UTILITY(U,$J,358.3,487,0)
 ;;=G47.9^^3^45^31
 ;;^UTILITY(U,$J,358.3,487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,487,1,3,0)
 ;;=3^Sleep-Wake Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,487,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,487,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,488,0)
 ;;=G47.419^^3^45^1
 ;;^UTILITY(U,$J,358.3,488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,488,1,3,0)
 ;;=3^Autosomal Dominant Cerebella Ataxia,Deafness,and Narcolepsy
 ;;^UTILITY(U,$J,358.3,488,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,488,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,489,0)
 ;;=G47.419^^3^45^2
 ;;^UTILITY(U,$J,358.3,489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,489,1,3,0)
 ;;=3^Autosomal Dominant Narcolepsy,Obesity,and Type 2 Diabetes
 ;;^UTILITY(U,$J,358.3,489,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,489,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,490,0)
 ;;=R06.3^^3^45^5
 ;;^UTILITY(U,$J,358.3,490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,490,1,3,0)
 ;;=3^Cheyne-Stokes Breathing
 ;;^UTILITY(U,$J,358.3,490,1,4,0)
 ;;=4^R06.3
 ;;^UTILITY(U,$J,358.3,490,2)
 ;;=^5019185
 ;;^UTILITY(U,$J,358.3,491,0)
 ;;=G47.429^^3^45^18
 ;;^UTILITY(U,$J,358.3,491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,491,1,3,0)
 ;;=3^Narcolepsy Secondary to Another Medical Condition
 ;;^UTILITY(U,$J,358.3,491,1,4,0)
 ;;=4^G47.429
 ;;^UTILITY(U,$J,358.3,491,2)
 ;;=^5003984
 ;;^UTILITY(U,$J,358.3,492,0)
 ;;=F10.10^^3^46^33
 ;;^UTILITY(U,$J,358.3,492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,492,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,492,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,492,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,493,0)
 ;;=F10.20^^3^46^34
 ;;^UTILITY(U,$J,358.3,493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,493,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,493,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,493,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,494,0)
 ;;=F10.239^^3^46^38
 ;;^UTILITY(U,$J,358.3,494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,494,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,494,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,494,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,495,0)
 ;;=F10.180^^3^46^2
 ;;^UTILITY(U,$J,358.3,495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,495,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,495,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,495,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,496,0)
 ;;=F10.280^^3^46^3
 ;;^UTILITY(U,$J,358.3,496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,496,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,496,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,496,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,497,0)
 ;;=F10.980^^3^46^4
