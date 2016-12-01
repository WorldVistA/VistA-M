IBDEI0OL ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31186,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Unspec Type
 ;;^UTILITY(U,$J,358.3,31186,1,4,0)
 ;;=4^G47.20
 ;;^UTILITY(U,$J,358.3,31186,2)
 ;;=^5003974
 ;;^UTILITY(U,$J,358.3,31187,0)
 ;;=F51.3^^91^1356^22
 ;;^UTILITY(U,$J,358.3,31187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31187,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal D/O;Sleepwalking Type
 ;;^UTILITY(U,$J,358.3,31187,1,4,0)
 ;;=4^F51.3
 ;;^UTILITY(U,$J,358.3,31187,2)
 ;;=^5003613
 ;;^UTILITY(U,$J,358.3,31188,0)
 ;;=F51.4^^91^1356^23
 ;;^UTILITY(U,$J,358.3,31188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31188,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal D/O;Sleep Terror Type
 ;;^UTILITY(U,$J,358.3,31188,1,4,0)
 ;;=4^F51.4
 ;;^UTILITY(U,$J,358.3,31188,2)
 ;;=^5003614
 ;;^UTILITY(U,$J,358.3,31189,0)
 ;;=F51.5^^91^1356^21
 ;;^UTILITY(U,$J,358.3,31189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31189,1,3,0)
 ;;=3^Nightmare Disorder
 ;;^UTILITY(U,$J,358.3,31189,1,4,0)
 ;;=4^F51.5
 ;;^UTILITY(U,$J,358.3,31189,2)
 ;;=^5003615
 ;;^UTILITY(U,$J,358.3,31190,0)
 ;;=G47.52^^91^1356^25
 ;;^UTILITY(U,$J,358.3,31190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31190,1,3,0)
 ;;=3^Rapid Eye Movement Sleep Behavior Disorder
 ;;^UTILITY(U,$J,358.3,31190,1,4,0)
 ;;=4^G47.52
 ;;^UTILITY(U,$J,358.3,31190,2)
 ;;=^332778
 ;;^UTILITY(U,$J,358.3,31191,0)
 ;;=G25.81^^91^1356^26
 ;;^UTILITY(U,$J,358.3,31191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31191,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,31191,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,31191,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,31192,0)
 ;;=G47.19^^91^1356^13
 ;;^UTILITY(U,$J,358.3,31192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31192,1,3,0)
 ;;=3^Hypersomnolence Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,31192,1,4,0)
 ;;=4^G47.19
 ;;^UTILITY(U,$J,358.3,31192,2)
 ;;=^5003973
 ;;^UTILITY(U,$J,358.3,31193,0)
 ;;=G47.8^^91^1356^30
 ;;^UTILITY(U,$J,358.3,31193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31193,1,3,0)
 ;;=3^Sleep-Wake Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,31193,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,31193,2)
 ;;=^5003989
 ;;^UTILITY(U,$J,358.3,31194,0)
 ;;=G47.411^^91^1356^19
 ;;^UTILITY(U,$J,358.3,31194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31194,1,3,0)
 ;;=3^Narcolepsy w/ Cataplexy w/o Hypocretin Deficiency
 ;;^UTILITY(U,$J,358.3,31194,1,4,0)
 ;;=4^G47.411
 ;;^UTILITY(U,$J,358.3,31194,2)
 ;;=^5003981
 ;;^UTILITY(U,$J,358.3,31195,0)
 ;;=G47.37^^91^1356^3
 ;;^UTILITY(U,$J,358.3,31195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31195,1,3,0)
 ;;=3^Central Sleep Apnea,Comorbid w/ Opioid Use
 ;;^UTILITY(U,$J,358.3,31195,1,4,0)
 ;;=4^G47.37
 ;;^UTILITY(U,$J,358.3,31195,2)
 ;;=^332767
 ;;^UTILITY(U,$J,358.3,31196,0)
 ;;=F51.11^^91^1356^12
 ;;^UTILITY(U,$J,358.3,31196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31196,1,3,0)
 ;;=3^Hypersomnolence Disorder
 ;;^UTILITY(U,$J,358.3,31196,1,4,0)
 ;;=4^F51.11
 ;;^UTILITY(U,$J,358.3,31196,2)
 ;;=^5003609
 ;;^UTILITY(U,$J,358.3,31197,0)
 ;;=F51.01^^91^1356^15
 ;;^UTILITY(U,$J,358.3,31197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31197,1,3,0)
 ;;=3^Insomnia Disorder
 ;;^UTILITY(U,$J,358.3,31197,1,4,0)
 ;;=4^F51.01
 ;;^UTILITY(U,$J,358.3,31197,2)
 ;;=^5003603
 ;;^UTILITY(U,$J,358.3,31198,0)
 ;;=G47.36^^91^1356^27
 ;;^UTILITY(U,$J,358.3,31198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31198,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Comorbid Sleep-Related Hypoventilation
 ;;^UTILITY(U,$J,358.3,31198,1,4,0)
 ;;=4^G47.36
 ;;^UTILITY(U,$J,358.3,31198,2)
 ;;=^5003979
 ;;^UTILITY(U,$J,358.3,31199,0)
 ;;=G47.35^^91^1356^28
 ;;^UTILITY(U,$J,358.3,31199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31199,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Congenital Central Alveolar Hypoventilation
 ;;^UTILITY(U,$J,358.3,31199,1,4,0)
 ;;=4^G47.35
 ;;^UTILITY(U,$J,358.3,31199,2)
 ;;=^332765
 ;;^UTILITY(U,$J,358.3,31200,0)
 ;;=G47.34^^91^1356^29
 ;;^UTILITY(U,$J,358.3,31200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31200,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Idiopathic
 ;;^UTILITY(U,$J,358.3,31200,1,4,0)
 ;;=4^G47.34
 ;;^UTILITY(U,$J,358.3,31200,2)
 ;;=^5003978
 ;;^UTILITY(U,$J,358.3,31201,0)
 ;;=G47.9^^91^1356^31
 ;;^UTILITY(U,$J,358.3,31201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31201,1,3,0)
 ;;=3^Sleep-Wake Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31201,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,31201,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,31202,0)
 ;;=G47.419^^91^1356^1
 ;;^UTILITY(U,$J,358.3,31202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31202,1,3,0)
 ;;=3^Autosomal Dominant Cerebella Ataxia,Deafness,and Narcolepsy
 ;;^UTILITY(U,$J,358.3,31202,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,31202,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,31203,0)
 ;;=G47.419^^91^1356^2
 ;;^UTILITY(U,$J,358.3,31203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31203,1,3,0)
 ;;=3^Autosomal Dominant Narcolepsy,Obesity,and Type 2 Diabetes
 ;;^UTILITY(U,$J,358.3,31203,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,31203,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,31204,0)
 ;;=R06.3^^91^1356^5
 ;;^UTILITY(U,$J,358.3,31204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31204,1,3,0)
 ;;=3^Cheyne-Stokes Breathing
 ;;^UTILITY(U,$J,358.3,31204,1,4,0)
 ;;=4^R06.3
 ;;^UTILITY(U,$J,358.3,31204,2)
 ;;=^5019185
 ;;^UTILITY(U,$J,358.3,31205,0)
 ;;=G47.429^^91^1356^18
 ;;^UTILITY(U,$J,358.3,31205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31205,1,3,0)
 ;;=3^Narcolepsy Secondary to Another Medical Condition
 ;;^UTILITY(U,$J,358.3,31205,1,4,0)
 ;;=4^G47.429
 ;;^UTILITY(U,$J,358.3,31205,2)
 ;;=^5003984
 ;;^UTILITY(U,$J,358.3,31206,0)
 ;;=F10.10^^91^1357^33
 ;;^UTILITY(U,$J,358.3,31206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31206,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,31206,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,31206,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,31207,0)
 ;;=F10.20^^91^1357^34
 ;;^UTILITY(U,$J,358.3,31207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31207,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,31207,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,31207,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,31208,0)
 ;;=F10.239^^91^1357^38
 ;;^UTILITY(U,$J,358.3,31208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31208,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,31208,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,31208,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,31209,0)
 ;;=F10.180^^91^1357^2
 ;;^UTILITY(U,$J,358.3,31209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31209,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31209,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,31209,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,31210,0)
 ;;=F10.280^^91^1357^3
 ;;^UTILITY(U,$J,358.3,31210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31210,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31210,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,31210,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,31211,0)
 ;;=F10.980^^91^1357^4
 ;;^UTILITY(U,$J,358.3,31211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31211,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31211,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,31211,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,31212,0)
 ;;=F10.94^^91^1357^10
 ;;^UTILITY(U,$J,358.3,31212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31212,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31212,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,31212,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,31213,0)
 ;;=F10.26^^91^1357^11
 ;;^UTILITY(U,$J,358.3,31213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31213,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31213,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,31213,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,31214,0)
 ;;=F10.96^^91^1357^12
 ;;^UTILITY(U,$J,358.3,31214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31214,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31214,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,31214,2)
 ;;=^5003108
 ;;^UTILITY(U,$J,358.3,31215,0)
 ;;=F10.27^^91^1357^13
 ;;^UTILITY(U,$J,358.3,31215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31215,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type,w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31215,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,31215,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,31216,0)
 ;;=F10.97^^91^1357^14
 ;;^UTILITY(U,$J,358.3,31216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31216,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31216,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,31216,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,31217,0)
 ;;=F10.288^^91^1357^15
 ;;^UTILITY(U,$J,358.3,31217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31217,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31217,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,31217,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,31218,0)
 ;;=F10.988^^91^1357^16
 ;;^UTILITY(U,$J,358.3,31218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31218,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31218,1,4,0)
 ;;=4^F10.988
 ;;^UTILITY(U,$J,358.3,31218,2)
 ;;=^5003113
 ;;^UTILITY(U,$J,358.3,31219,0)
 ;;=F10.159^^91^1357^17
 ;;^UTILITY(U,$J,358.3,31219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31219,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31219,1,4,0)
 ;;=4^F10.159
