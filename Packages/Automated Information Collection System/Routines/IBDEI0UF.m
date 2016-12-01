IBDEI0UF ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40004,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,40004,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,40005,0)
 ;;=G47.33^^114^1690^24
 ;;^UTILITY(U,$J,358.3,40005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40005,1,3,0)
 ;;=3^Obstructive Sleep Apnea Hypopnea
 ;;^UTILITY(U,$J,358.3,40005,1,4,0)
 ;;=4^G47.33
 ;;^UTILITY(U,$J,358.3,40005,2)
 ;;=^332763
 ;;^UTILITY(U,$J,358.3,40006,0)
 ;;=G47.31^^114^1690^4
 ;;^UTILITY(U,$J,358.3,40006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40006,1,3,0)
 ;;=3^Central Sleep Apnea,Idiopathic
 ;;^UTILITY(U,$J,358.3,40006,1,4,0)
 ;;=4^G47.31
 ;;^UTILITY(U,$J,358.3,40006,2)
 ;;=^332761
 ;;^UTILITY(U,$J,358.3,40007,0)
 ;;=G47.21^^114^1690^7
 ;;^UTILITY(U,$J,358.3,40007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40007,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Delayed Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,40007,1,4,0)
 ;;=4^G47.21
 ;;^UTILITY(U,$J,358.3,40007,2)
 ;;=^332769
 ;;^UTILITY(U,$J,358.3,40008,0)
 ;;=G47.22^^114^1690^6
 ;;^UTILITY(U,$J,358.3,40008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40008,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Advanced Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,40008,1,4,0)
 ;;=4^G47.22
 ;;^UTILITY(U,$J,358.3,40008,2)
 ;;=^332770
 ;;^UTILITY(U,$J,358.3,40009,0)
 ;;=G47.23^^114^1690^8
 ;;^UTILITY(U,$J,358.3,40009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40009,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Irregular Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,40009,1,4,0)
 ;;=4^G47.23
 ;;^UTILITY(U,$J,358.3,40009,2)
 ;;=^5003975
 ;;^UTILITY(U,$J,358.3,40010,0)
 ;;=G47.24^^114^1690^9
 ;;^UTILITY(U,$J,358.3,40010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40010,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,40010,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,40010,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,40011,0)
 ;;=G47.26^^114^1690^10
 ;;^UTILITY(U,$J,358.3,40011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40011,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Shift Work Type
 ;;^UTILITY(U,$J,358.3,40011,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,40011,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,40012,0)
 ;;=G47.20^^114^1690^11
 ;;^UTILITY(U,$J,358.3,40012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40012,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Unspec Type
 ;;^UTILITY(U,$J,358.3,40012,1,4,0)
 ;;=4^G47.20
 ;;^UTILITY(U,$J,358.3,40012,2)
 ;;=^5003974
 ;;^UTILITY(U,$J,358.3,40013,0)
 ;;=F51.3^^114^1690^22
 ;;^UTILITY(U,$J,358.3,40013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40013,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal D/O;Sleepwalking Type
 ;;^UTILITY(U,$J,358.3,40013,1,4,0)
 ;;=4^F51.3
 ;;^UTILITY(U,$J,358.3,40013,2)
 ;;=^5003613
 ;;^UTILITY(U,$J,358.3,40014,0)
 ;;=F51.4^^114^1690^23
 ;;^UTILITY(U,$J,358.3,40014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40014,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal D/O;Sleep Terror Type
 ;;^UTILITY(U,$J,358.3,40014,1,4,0)
 ;;=4^F51.4
 ;;^UTILITY(U,$J,358.3,40014,2)
 ;;=^5003614
 ;;^UTILITY(U,$J,358.3,40015,0)
 ;;=F51.5^^114^1690^21
 ;;^UTILITY(U,$J,358.3,40015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40015,1,3,0)
 ;;=3^Nightmare Disorder
 ;;^UTILITY(U,$J,358.3,40015,1,4,0)
 ;;=4^F51.5
 ;;^UTILITY(U,$J,358.3,40015,2)
 ;;=^5003615
 ;;^UTILITY(U,$J,358.3,40016,0)
 ;;=G47.52^^114^1690^25
 ;;^UTILITY(U,$J,358.3,40016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40016,1,3,0)
 ;;=3^Rapid Eye Movement Sleep Behavior Disorder
 ;;^UTILITY(U,$J,358.3,40016,1,4,0)
 ;;=4^G47.52
 ;;^UTILITY(U,$J,358.3,40016,2)
 ;;=^332778
 ;;^UTILITY(U,$J,358.3,40017,0)
 ;;=G25.81^^114^1690^26
 ;;^UTILITY(U,$J,358.3,40017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40017,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,40017,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,40017,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,40018,0)
 ;;=G47.19^^114^1690^13
 ;;^UTILITY(U,$J,358.3,40018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40018,1,3,0)
 ;;=3^Hypersomnolence Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,40018,1,4,0)
 ;;=4^G47.19
 ;;^UTILITY(U,$J,358.3,40018,2)
 ;;=^5003973
 ;;^UTILITY(U,$J,358.3,40019,0)
 ;;=G47.8^^114^1690^30
 ;;^UTILITY(U,$J,358.3,40019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40019,1,3,0)
 ;;=3^Sleep-Wake Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,40019,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,40019,2)
 ;;=^5003989
 ;;^UTILITY(U,$J,358.3,40020,0)
 ;;=G47.411^^114^1690^19
 ;;^UTILITY(U,$J,358.3,40020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40020,1,3,0)
 ;;=3^Narcolepsy w/ Cataplexy w/o Hypocretin Deficiency
 ;;^UTILITY(U,$J,358.3,40020,1,4,0)
 ;;=4^G47.411
 ;;^UTILITY(U,$J,358.3,40020,2)
 ;;=^5003981
 ;;^UTILITY(U,$J,358.3,40021,0)
 ;;=G47.37^^114^1690^3
 ;;^UTILITY(U,$J,358.3,40021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40021,1,3,0)
 ;;=3^Central Sleep Apnea,Comorbid w/ Opioid Use
 ;;^UTILITY(U,$J,358.3,40021,1,4,0)
 ;;=4^G47.37
 ;;^UTILITY(U,$J,358.3,40021,2)
 ;;=^332767
 ;;^UTILITY(U,$J,358.3,40022,0)
 ;;=F51.11^^114^1690^12
 ;;^UTILITY(U,$J,358.3,40022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40022,1,3,0)
 ;;=3^Hypersomnolence Disorder
 ;;^UTILITY(U,$J,358.3,40022,1,4,0)
 ;;=4^F51.11
 ;;^UTILITY(U,$J,358.3,40022,2)
 ;;=^5003609
 ;;^UTILITY(U,$J,358.3,40023,0)
 ;;=F51.01^^114^1690^15
 ;;^UTILITY(U,$J,358.3,40023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40023,1,3,0)
 ;;=3^Insomnia Disorder
 ;;^UTILITY(U,$J,358.3,40023,1,4,0)
 ;;=4^F51.01
 ;;^UTILITY(U,$J,358.3,40023,2)
 ;;=^5003603
 ;;^UTILITY(U,$J,358.3,40024,0)
 ;;=G47.36^^114^1690^27
 ;;^UTILITY(U,$J,358.3,40024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40024,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Comorbid Sleep-Related Hypoventilation
 ;;^UTILITY(U,$J,358.3,40024,1,4,0)
 ;;=4^G47.36
 ;;^UTILITY(U,$J,358.3,40024,2)
 ;;=^5003979
 ;;^UTILITY(U,$J,358.3,40025,0)
 ;;=G47.35^^114^1690^28
 ;;^UTILITY(U,$J,358.3,40025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40025,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Congenital Central Alveolar Hypoventilation
 ;;^UTILITY(U,$J,358.3,40025,1,4,0)
 ;;=4^G47.35
 ;;^UTILITY(U,$J,358.3,40025,2)
 ;;=^332765
 ;;^UTILITY(U,$J,358.3,40026,0)
 ;;=G47.34^^114^1690^29
 ;;^UTILITY(U,$J,358.3,40026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40026,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Idiopathic
 ;;^UTILITY(U,$J,358.3,40026,1,4,0)
 ;;=4^G47.34
 ;;^UTILITY(U,$J,358.3,40026,2)
 ;;=^5003978
 ;;^UTILITY(U,$J,358.3,40027,0)
 ;;=G47.9^^114^1690^31
 ;;^UTILITY(U,$J,358.3,40027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40027,1,3,0)
 ;;=3^Sleep-Wake Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,40027,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,40027,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,40028,0)
 ;;=G47.419^^114^1690^1
 ;;^UTILITY(U,$J,358.3,40028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40028,1,3,0)
 ;;=3^Autosomal Dominant Cerebella Ataxia,Deafness,and Narcolepsy
 ;;^UTILITY(U,$J,358.3,40028,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,40028,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,40029,0)
 ;;=G47.419^^114^1690^2
 ;;^UTILITY(U,$J,358.3,40029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40029,1,3,0)
 ;;=3^Autosomal Dominant Narcolepsy,Obesity,and Type 2 Diabetes
 ;;^UTILITY(U,$J,358.3,40029,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,40029,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,40030,0)
 ;;=R06.3^^114^1690^5
 ;;^UTILITY(U,$J,358.3,40030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40030,1,3,0)
 ;;=3^Cheyne-Stokes Breathing
 ;;^UTILITY(U,$J,358.3,40030,1,4,0)
 ;;=4^R06.3
 ;;^UTILITY(U,$J,358.3,40030,2)
 ;;=^5019185
 ;;^UTILITY(U,$J,358.3,40031,0)
 ;;=G47.429^^114^1690^18
 ;;^UTILITY(U,$J,358.3,40031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40031,1,3,0)
 ;;=3^Narcolepsy Secondary to Another Medical Condition
 ;;^UTILITY(U,$J,358.3,40031,1,4,0)
 ;;=4^G47.429
 ;;^UTILITY(U,$J,358.3,40031,2)
 ;;=^5003984
 ;;^UTILITY(U,$J,358.3,40032,0)
 ;;=F10.10^^114^1691^33
 ;;^UTILITY(U,$J,358.3,40032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40032,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,40032,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,40032,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,40033,0)
 ;;=F10.20^^114^1691^34
 ;;^UTILITY(U,$J,358.3,40033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40033,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,40033,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,40033,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,40034,0)
 ;;=F10.239^^114^1691^38
 ;;^UTILITY(U,$J,358.3,40034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40034,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,40034,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,40034,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,40035,0)
 ;;=F10.180^^114^1691^2
 ;;^UTILITY(U,$J,358.3,40035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40035,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40035,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,40035,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,40036,0)
 ;;=F10.280^^114^1691^3
 ;;^UTILITY(U,$J,358.3,40036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40036,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40036,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,40036,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,40037,0)
 ;;=F10.980^^114^1691^4
 ;;^UTILITY(U,$J,358.3,40037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40037,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40037,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,40037,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,40038,0)
 ;;=F10.94^^114^1691^10
 ;;^UTILITY(U,$J,358.3,40038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40038,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/o Use Disorder
