IBDEI0RA ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27413,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,27413,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,27413,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,27414,0)
 ;;=G47.26^^102^1337^10
 ;;^UTILITY(U,$J,358.3,27414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27414,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Shift Work Type
 ;;^UTILITY(U,$J,358.3,27414,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,27414,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,27415,0)
 ;;=G47.20^^102^1337^11
 ;;^UTILITY(U,$J,358.3,27415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27415,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Unspec Type
 ;;^UTILITY(U,$J,358.3,27415,1,4,0)
 ;;=4^G47.20
 ;;^UTILITY(U,$J,358.3,27415,2)
 ;;=^5003974
 ;;^UTILITY(U,$J,358.3,27416,0)
 ;;=F51.3^^102^1337^22
 ;;^UTILITY(U,$J,358.3,27416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27416,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal D/O;Sleepwalking Type
 ;;^UTILITY(U,$J,358.3,27416,1,4,0)
 ;;=4^F51.3
 ;;^UTILITY(U,$J,358.3,27416,2)
 ;;=^5003613
 ;;^UTILITY(U,$J,358.3,27417,0)
 ;;=F51.4^^102^1337^23
 ;;^UTILITY(U,$J,358.3,27417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27417,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal D/O;Sleep Terror Type
 ;;^UTILITY(U,$J,358.3,27417,1,4,0)
 ;;=4^F51.4
 ;;^UTILITY(U,$J,358.3,27417,2)
 ;;=^5003614
 ;;^UTILITY(U,$J,358.3,27418,0)
 ;;=F51.5^^102^1337^21
 ;;^UTILITY(U,$J,358.3,27418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27418,1,3,0)
 ;;=3^Nightmare Disorder
 ;;^UTILITY(U,$J,358.3,27418,1,4,0)
 ;;=4^F51.5
 ;;^UTILITY(U,$J,358.3,27418,2)
 ;;=^5003615
 ;;^UTILITY(U,$J,358.3,27419,0)
 ;;=G47.52^^102^1337^25
 ;;^UTILITY(U,$J,358.3,27419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27419,1,3,0)
 ;;=3^Rapid Eye Movement Sleep Behavior Disorder
 ;;^UTILITY(U,$J,358.3,27419,1,4,0)
 ;;=4^G47.52
 ;;^UTILITY(U,$J,358.3,27419,2)
 ;;=^332778
 ;;^UTILITY(U,$J,358.3,27420,0)
 ;;=G25.81^^102^1337^26
 ;;^UTILITY(U,$J,358.3,27420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27420,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,27420,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,27420,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,27421,0)
 ;;=G47.19^^102^1337^13
 ;;^UTILITY(U,$J,358.3,27421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27421,1,3,0)
 ;;=3^Hypersomnolence Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,27421,1,4,0)
 ;;=4^G47.19
 ;;^UTILITY(U,$J,358.3,27421,2)
 ;;=^5003973
 ;;^UTILITY(U,$J,358.3,27422,0)
 ;;=G47.8^^102^1337^30
 ;;^UTILITY(U,$J,358.3,27422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27422,1,3,0)
 ;;=3^Sleep-Wake Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,27422,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,27422,2)
 ;;=^5003989
 ;;^UTILITY(U,$J,358.3,27423,0)
 ;;=G47.411^^102^1337^19
 ;;^UTILITY(U,$J,358.3,27423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27423,1,3,0)
 ;;=3^Narcolepsy w/ Cataplexy w/o Hypocretin Deficiency
 ;;^UTILITY(U,$J,358.3,27423,1,4,0)
 ;;=4^G47.411
 ;;^UTILITY(U,$J,358.3,27423,2)
 ;;=^5003981
 ;;^UTILITY(U,$J,358.3,27424,0)
 ;;=G47.37^^102^1337^3
 ;;^UTILITY(U,$J,358.3,27424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27424,1,3,0)
 ;;=3^Central Sleep Apnea,Comorbid w/ Opioid Use
 ;;^UTILITY(U,$J,358.3,27424,1,4,0)
 ;;=4^G47.37
 ;;^UTILITY(U,$J,358.3,27424,2)
 ;;=^332767
 ;;^UTILITY(U,$J,358.3,27425,0)
 ;;=F51.11^^102^1337^12
 ;;^UTILITY(U,$J,358.3,27425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27425,1,3,0)
 ;;=3^Hypersomnolence Disorder
 ;;^UTILITY(U,$J,358.3,27425,1,4,0)
 ;;=4^F51.11
 ;;^UTILITY(U,$J,358.3,27425,2)
 ;;=^5003609
 ;;^UTILITY(U,$J,358.3,27426,0)
 ;;=F51.01^^102^1337^15
 ;;^UTILITY(U,$J,358.3,27426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27426,1,3,0)
 ;;=3^Insomnia Disorder
 ;;^UTILITY(U,$J,358.3,27426,1,4,0)
 ;;=4^F51.01
 ;;^UTILITY(U,$J,358.3,27426,2)
 ;;=^5003603
 ;;^UTILITY(U,$J,358.3,27427,0)
 ;;=G47.36^^102^1337^27
 ;;^UTILITY(U,$J,358.3,27427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27427,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Comorbid Sleep-Related Hypoventilation
 ;;^UTILITY(U,$J,358.3,27427,1,4,0)
 ;;=4^G47.36
 ;;^UTILITY(U,$J,358.3,27427,2)
 ;;=^5003979
 ;;^UTILITY(U,$J,358.3,27428,0)
 ;;=G47.35^^102^1337^28
 ;;^UTILITY(U,$J,358.3,27428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27428,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Congenital Central Alveolar Hypoventilation
 ;;^UTILITY(U,$J,358.3,27428,1,4,0)
 ;;=4^G47.35
 ;;^UTILITY(U,$J,358.3,27428,2)
 ;;=^332765
 ;;^UTILITY(U,$J,358.3,27429,0)
 ;;=G47.34^^102^1337^29
 ;;^UTILITY(U,$J,358.3,27429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27429,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Idiopathic
 ;;^UTILITY(U,$J,358.3,27429,1,4,0)
 ;;=4^G47.34
 ;;^UTILITY(U,$J,358.3,27429,2)
 ;;=^5003978
 ;;^UTILITY(U,$J,358.3,27430,0)
 ;;=G47.9^^102^1337^31
 ;;^UTILITY(U,$J,358.3,27430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27430,1,3,0)
 ;;=3^Sleep-Wake Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,27430,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,27430,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,27431,0)
 ;;=G47.419^^102^1337^1
 ;;^UTILITY(U,$J,358.3,27431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27431,1,3,0)
 ;;=3^Autosomal Dominant Cerebella Ataxia,Deafness,and Narcolepsy
 ;;^UTILITY(U,$J,358.3,27431,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,27431,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,27432,0)
 ;;=G47.419^^102^1337^2
 ;;^UTILITY(U,$J,358.3,27432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27432,1,3,0)
 ;;=3^Autosomal Dominant Narcolepsy,Obesity,and Type 2 Diabetes
 ;;^UTILITY(U,$J,358.3,27432,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,27432,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,27433,0)
 ;;=R06.3^^102^1337^5
 ;;^UTILITY(U,$J,358.3,27433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27433,1,3,0)
 ;;=3^Cheyne-Stokes Breathing
 ;;^UTILITY(U,$J,358.3,27433,1,4,0)
 ;;=4^R06.3
 ;;^UTILITY(U,$J,358.3,27433,2)
 ;;=^5019185
 ;;^UTILITY(U,$J,358.3,27434,0)
 ;;=G47.429^^102^1337^18
 ;;^UTILITY(U,$J,358.3,27434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27434,1,3,0)
 ;;=3^Narcolepsy Secondary to Another Medical Condition
 ;;^UTILITY(U,$J,358.3,27434,1,4,0)
 ;;=4^G47.429
 ;;^UTILITY(U,$J,358.3,27434,2)
 ;;=^5003984
 ;;^UTILITY(U,$J,358.3,27435,0)
 ;;=F10.10^^102^1338^32
 ;;^UTILITY(U,$J,358.3,27435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27435,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,27435,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,27435,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,27436,0)
 ;;=F10.20^^102^1338^33
 ;;^UTILITY(U,$J,358.3,27436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27436,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,27436,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,27436,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,27437,0)
 ;;=F10.239^^102^1338^37
 ;;^UTILITY(U,$J,358.3,27437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27437,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,27437,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,27437,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,27438,0)
 ;;=F10.180^^102^1338^1
 ;;^UTILITY(U,$J,358.3,27438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27438,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27438,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,27438,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,27439,0)
 ;;=F10.280^^102^1338^2
 ;;^UTILITY(U,$J,358.3,27439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27439,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27439,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,27439,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,27440,0)
 ;;=F10.980^^102^1338^3
