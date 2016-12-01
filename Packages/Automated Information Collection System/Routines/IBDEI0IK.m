IBDEI0IK ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23549,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Irregular Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,23549,1,4,0)
 ;;=4^G47.23
 ;;^UTILITY(U,$J,358.3,23549,2)
 ;;=^5003975
 ;;^UTILITY(U,$J,358.3,23550,0)
 ;;=G47.24^^61^917^9
 ;;^UTILITY(U,$J,358.3,23550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23550,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,23550,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,23550,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,23551,0)
 ;;=G47.26^^61^917^10
 ;;^UTILITY(U,$J,358.3,23551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23551,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Shift Work Type
 ;;^UTILITY(U,$J,358.3,23551,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,23551,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,23552,0)
 ;;=G47.20^^61^917^11
 ;;^UTILITY(U,$J,358.3,23552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23552,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Unspec Type
 ;;^UTILITY(U,$J,358.3,23552,1,4,0)
 ;;=4^G47.20
 ;;^UTILITY(U,$J,358.3,23552,2)
 ;;=^5003974
 ;;^UTILITY(U,$J,358.3,23553,0)
 ;;=F51.3^^61^917^22
 ;;^UTILITY(U,$J,358.3,23553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23553,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal D/O;Sleepwalking Type
 ;;^UTILITY(U,$J,358.3,23553,1,4,0)
 ;;=4^F51.3
 ;;^UTILITY(U,$J,358.3,23553,2)
 ;;=^5003613
 ;;^UTILITY(U,$J,358.3,23554,0)
 ;;=F51.4^^61^917^23
 ;;^UTILITY(U,$J,358.3,23554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23554,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal D/O;Sleep Terror Type
 ;;^UTILITY(U,$J,358.3,23554,1,4,0)
 ;;=4^F51.4
 ;;^UTILITY(U,$J,358.3,23554,2)
 ;;=^5003614
 ;;^UTILITY(U,$J,358.3,23555,0)
 ;;=F51.5^^61^917^21
 ;;^UTILITY(U,$J,358.3,23555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23555,1,3,0)
 ;;=3^Nightmare Disorder
 ;;^UTILITY(U,$J,358.3,23555,1,4,0)
 ;;=4^F51.5
 ;;^UTILITY(U,$J,358.3,23555,2)
 ;;=^5003615
 ;;^UTILITY(U,$J,358.3,23556,0)
 ;;=G47.52^^61^917^25
 ;;^UTILITY(U,$J,358.3,23556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23556,1,3,0)
 ;;=3^Rapid Eye Movement Sleep Behavior Disorder
 ;;^UTILITY(U,$J,358.3,23556,1,4,0)
 ;;=4^G47.52
 ;;^UTILITY(U,$J,358.3,23556,2)
 ;;=^332778
 ;;^UTILITY(U,$J,358.3,23557,0)
 ;;=G25.81^^61^917^26
 ;;^UTILITY(U,$J,358.3,23557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23557,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,23557,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,23557,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,23558,0)
 ;;=G47.19^^61^917^13
 ;;^UTILITY(U,$J,358.3,23558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23558,1,3,0)
 ;;=3^Hypersomnolence Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,23558,1,4,0)
 ;;=4^G47.19
 ;;^UTILITY(U,$J,358.3,23558,2)
 ;;=^5003973
 ;;^UTILITY(U,$J,358.3,23559,0)
 ;;=G47.8^^61^917^30
 ;;^UTILITY(U,$J,358.3,23559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23559,1,3,0)
 ;;=3^Sleep-Wake Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,23559,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,23559,2)
 ;;=^5003989
 ;;^UTILITY(U,$J,358.3,23560,0)
 ;;=G47.411^^61^917^19
 ;;^UTILITY(U,$J,358.3,23560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23560,1,3,0)
 ;;=3^Narcolepsy w/ Cataplexy w/o Hypocretin Deficiency
 ;;^UTILITY(U,$J,358.3,23560,1,4,0)
 ;;=4^G47.411
 ;;^UTILITY(U,$J,358.3,23560,2)
 ;;=^5003981
 ;;^UTILITY(U,$J,358.3,23561,0)
 ;;=G47.37^^61^917^3
 ;;^UTILITY(U,$J,358.3,23561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23561,1,3,0)
 ;;=3^Central Sleep Apnea,Comorbid w/ Opioid Use
 ;;^UTILITY(U,$J,358.3,23561,1,4,0)
 ;;=4^G47.37
 ;;^UTILITY(U,$J,358.3,23561,2)
 ;;=^332767
 ;;^UTILITY(U,$J,358.3,23562,0)
 ;;=F51.11^^61^917^12
 ;;^UTILITY(U,$J,358.3,23562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23562,1,3,0)
 ;;=3^Hypersomnolence Disorder
 ;;^UTILITY(U,$J,358.3,23562,1,4,0)
 ;;=4^F51.11
 ;;^UTILITY(U,$J,358.3,23562,2)
 ;;=^5003609
 ;;^UTILITY(U,$J,358.3,23563,0)
 ;;=F51.01^^61^917^15
 ;;^UTILITY(U,$J,358.3,23563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23563,1,3,0)
 ;;=3^Insomnia Disorder
 ;;^UTILITY(U,$J,358.3,23563,1,4,0)
 ;;=4^F51.01
 ;;^UTILITY(U,$J,358.3,23563,2)
 ;;=^5003603
 ;;^UTILITY(U,$J,358.3,23564,0)
 ;;=G47.36^^61^917^27
 ;;^UTILITY(U,$J,358.3,23564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23564,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Comorbid Sleep-Related Hypoventilation
 ;;^UTILITY(U,$J,358.3,23564,1,4,0)
 ;;=4^G47.36
 ;;^UTILITY(U,$J,358.3,23564,2)
 ;;=^5003979
 ;;^UTILITY(U,$J,358.3,23565,0)
 ;;=G47.35^^61^917^28
 ;;^UTILITY(U,$J,358.3,23565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23565,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Congenital Central Alveolar Hypoventilation
 ;;^UTILITY(U,$J,358.3,23565,1,4,0)
 ;;=4^G47.35
 ;;^UTILITY(U,$J,358.3,23565,2)
 ;;=^332765
 ;;^UTILITY(U,$J,358.3,23566,0)
 ;;=G47.34^^61^917^29
 ;;^UTILITY(U,$J,358.3,23566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23566,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Idiopathic
 ;;^UTILITY(U,$J,358.3,23566,1,4,0)
 ;;=4^G47.34
 ;;^UTILITY(U,$J,358.3,23566,2)
 ;;=^5003978
 ;;^UTILITY(U,$J,358.3,23567,0)
 ;;=G47.9^^61^917^31
 ;;^UTILITY(U,$J,358.3,23567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23567,1,3,0)
 ;;=3^Sleep-Wake Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,23567,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,23567,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,23568,0)
 ;;=G47.419^^61^917^1
 ;;^UTILITY(U,$J,358.3,23568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23568,1,3,0)
 ;;=3^Autosomal Dominant Cerebella Ataxia,Deafness,and Narcolepsy
 ;;^UTILITY(U,$J,358.3,23568,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,23568,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,23569,0)
 ;;=G47.419^^61^917^2
 ;;^UTILITY(U,$J,358.3,23569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23569,1,3,0)
 ;;=3^Autosomal Dominant Narcolepsy,Obesity,and Type 2 Diabetes
 ;;^UTILITY(U,$J,358.3,23569,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,23569,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,23570,0)
 ;;=R06.3^^61^917^5
 ;;^UTILITY(U,$J,358.3,23570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23570,1,3,0)
 ;;=3^Cheyne-Stokes Breathing
 ;;^UTILITY(U,$J,358.3,23570,1,4,0)
 ;;=4^R06.3
 ;;^UTILITY(U,$J,358.3,23570,2)
 ;;=^5019185
 ;;^UTILITY(U,$J,358.3,23571,0)
 ;;=G47.429^^61^917^18
 ;;^UTILITY(U,$J,358.3,23571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23571,1,3,0)
 ;;=3^Narcolepsy Secondary to Another Medical Condition
 ;;^UTILITY(U,$J,358.3,23571,1,4,0)
 ;;=4^G47.429
 ;;^UTILITY(U,$J,358.3,23571,2)
 ;;=^5003984
 ;;^UTILITY(U,$J,358.3,23572,0)
 ;;=F10.10^^61^918^33
 ;;^UTILITY(U,$J,358.3,23572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23572,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,23572,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,23572,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,23573,0)
 ;;=F10.20^^61^918^34
 ;;^UTILITY(U,$J,358.3,23573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23573,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,23573,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,23573,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,23574,0)
 ;;=F10.239^^61^918^38
 ;;^UTILITY(U,$J,358.3,23574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23574,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,23574,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,23574,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,23575,0)
 ;;=F10.180^^61^918^2
 ;;^UTILITY(U,$J,358.3,23575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23575,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23575,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,23575,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,23576,0)
 ;;=F10.280^^61^918^3
 ;;^UTILITY(U,$J,358.3,23576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23576,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23576,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,23576,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,23577,0)
 ;;=F10.980^^61^918^4
 ;;^UTILITY(U,$J,358.3,23577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23577,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23577,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,23577,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,23578,0)
 ;;=F10.94^^61^918^10
 ;;^UTILITY(U,$J,358.3,23578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23578,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23578,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,23578,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,23579,0)
 ;;=F10.26^^61^918^11
 ;;^UTILITY(U,$J,358.3,23579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23579,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23579,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,23579,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,23580,0)
 ;;=F10.96^^61^918^12
 ;;^UTILITY(U,$J,358.3,23580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23580,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23580,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,23580,2)
 ;;=^5003108
 ;;^UTILITY(U,$J,358.3,23581,0)
 ;;=F10.27^^61^918^13
 ;;^UTILITY(U,$J,358.3,23581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23581,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type,w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23581,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,23581,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,23582,0)
 ;;=F10.97^^61^918^14
 ;;^UTILITY(U,$J,358.3,23582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23582,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23582,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,23582,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,23583,0)
 ;;=F10.288^^61^918^15
