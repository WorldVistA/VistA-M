IBDEI0J8 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24374,1,3,0)
 ;;=3^Hypersomnolence Disorder
 ;;^UTILITY(U,$J,358.3,24374,1,4,0)
 ;;=4^F51.11
 ;;^UTILITY(U,$J,358.3,24374,2)
 ;;=^5003609
 ;;^UTILITY(U,$J,358.3,24375,0)
 ;;=F51.01^^64^969^15
 ;;^UTILITY(U,$J,358.3,24375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24375,1,3,0)
 ;;=3^Insomnia Disorder
 ;;^UTILITY(U,$J,358.3,24375,1,4,0)
 ;;=4^F51.01
 ;;^UTILITY(U,$J,358.3,24375,2)
 ;;=^5003603
 ;;^UTILITY(U,$J,358.3,24376,0)
 ;;=G47.36^^64^969^27
 ;;^UTILITY(U,$J,358.3,24376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24376,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Comorbid Sleep-Related Hypoventilation
 ;;^UTILITY(U,$J,358.3,24376,1,4,0)
 ;;=4^G47.36
 ;;^UTILITY(U,$J,358.3,24376,2)
 ;;=^5003979
 ;;^UTILITY(U,$J,358.3,24377,0)
 ;;=G47.35^^64^969^28
 ;;^UTILITY(U,$J,358.3,24377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24377,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Congenital Central Alveolar Hypoventilation
 ;;^UTILITY(U,$J,358.3,24377,1,4,0)
 ;;=4^G47.35
 ;;^UTILITY(U,$J,358.3,24377,2)
 ;;=^332765
 ;;^UTILITY(U,$J,358.3,24378,0)
 ;;=G47.34^^64^969^29
 ;;^UTILITY(U,$J,358.3,24378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24378,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Idiopathic
 ;;^UTILITY(U,$J,358.3,24378,1,4,0)
 ;;=4^G47.34
 ;;^UTILITY(U,$J,358.3,24378,2)
 ;;=^5003978
 ;;^UTILITY(U,$J,358.3,24379,0)
 ;;=G47.9^^64^969^31
 ;;^UTILITY(U,$J,358.3,24379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24379,1,3,0)
 ;;=3^Sleep-Wake Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24379,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,24379,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,24380,0)
 ;;=G47.419^^64^969^1
 ;;^UTILITY(U,$J,358.3,24380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24380,1,3,0)
 ;;=3^Autosomal Dominant Cerebella Ataxia,Deafness,and Narcolepsy
 ;;^UTILITY(U,$J,358.3,24380,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,24380,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,24381,0)
 ;;=G47.419^^64^969^2
 ;;^UTILITY(U,$J,358.3,24381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24381,1,3,0)
 ;;=3^Autosomal Dominant Narcolepsy,Obesity,and Type 2 Diabetes
 ;;^UTILITY(U,$J,358.3,24381,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,24381,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,24382,0)
 ;;=R06.3^^64^969^5
 ;;^UTILITY(U,$J,358.3,24382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24382,1,3,0)
 ;;=3^Cheyne-Stokes Breathing
 ;;^UTILITY(U,$J,358.3,24382,1,4,0)
 ;;=4^R06.3
 ;;^UTILITY(U,$J,358.3,24382,2)
 ;;=^5019185
 ;;^UTILITY(U,$J,358.3,24383,0)
 ;;=G47.429^^64^969^18
 ;;^UTILITY(U,$J,358.3,24383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24383,1,3,0)
 ;;=3^Narcolepsy Secondary to Another Medical Condition
 ;;^UTILITY(U,$J,358.3,24383,1,4,0)
 ;;=4^G47.429
 ;;^UTILITY(U,$J,358.3,24383,2)
 ;;=^5003984
 ;;^UTILITY(U,$J,358.3,24384,0)
 ;;=F10.10^^64^970^33
 ;;^UTILITY(U,$J,358.3,24384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24384,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,24384,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,24384,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,24385,0)
 ;;=F10.20^^64^970^34
 ;;^UTILITY(U,$J,358.3,24385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24385,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,24385,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,24385,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,24386,0)
 ;;=F10.239^^64^970^38
 ;;^UTILITY(U,$J,358.3,24386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24386,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,24386,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,24386,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,24387,0)
 ;;=F10.180^^64^970^2
 ;;^UTILITY(U,$J,358.3,24387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24387,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24387,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,24387,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,24388,0)
 ;;=F10.280^^64^970^3
 ;;^UTILITY(U,$J,358.3,24388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24388,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24388,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,24388,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,24389,0)
 ;;=F10.980^^64^970^4
 ;;^UTILITY(U,$J,358.3,24389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24389,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24389,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,24389,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,24390,0)
 ;;=F10.94^^64^970^10
 ;;^UTILITY(U,$J,358.3,24390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24390,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24390,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,24390,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,24391,0)
 ;;=F10.26^^64^970^11
 ;;^UTILITY(U,$J,358.3,24391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24391,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24391,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,24391,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,24392,0)
 ;;=F10.96^^64^970^12
 ;;^UTILITY(U,$J,358.3,24392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24392,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24392,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,24392,2)
 ;;=^5003108
 ;;^UTILITY(U,$J,358.3,24393,0)
 ;;=F10.27^^64^970^13
 ;;^UTILITY(U,$J,358.3,24393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24393,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type,w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24393,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,24393,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,24394,0)
 ;;=F10.97^^64^970^14
 ;;^UTILITY(U,$J,358.3,24394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24394,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24394,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,24394,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,24395,0)
 ;;=F10.288^^64^970^15
 ;;^UTILITY(U,$J,358.3,24395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24395,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24395,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,24395,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,24396,0)
 ;;=F10.988^^64^970^16
 ;;^UTILITY(U,$J,358.3,24396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24396,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24396,1,4,0)
 ;;=4^F10.988
 ;;^UTILITY(U,$J,358.3,24396,2)
 ;;=^5003113
 ;;^UTILITY(U,$J,358.3,24397,0)
 ;;=F10.159^^64^970^17
 ;;^UTILITY(U,$J,358.3,24397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24397,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24397,1,4,0)
 ;;=4^F10.159
 ;;^UTILITY(U,$J,358.3,24397,2)
 ;;=^5003075
 ;;^UTILITY(U,$J,358.3,24398,0)
 ;;=F10.259^^64^970^18
 ;;^UTILITY(U,$J,358.3,24398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24398,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24398,1,4,0)
 ;;=4^F10.259
 ;;^UTILITY(U,$J,358.3,24398,2)
 ;;=^5003093
 ;;^UTILITY(U,$J,358.3,24399,0)
 ;;=F10.959^^64^970^19
 ;;^UTILITY(U,$J,358.3,24399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24399,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24399,1,4,0)
 ;;=4^F10.959
 ;;^UTILITY(U,$J,358.3,24399,2)
 ;;=^5003107
 ;;^UTILITY(U,$J,358.3,24400,0)
 ;;=F10.181^^64^970^20
 ;;^UTILITY(U,$J,358.3,24400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24400,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24400,1,4,0)
 ;;=4^F10.181
 ;;^UTILITY(U,$J,358.3,24400,2)
 ;;=^5003077
 ;;^UTILITY(U,$J,358.3,24401,0)
 ;;=F10.282^^64^970^24
 ;;^UTILITY(U,$J,358.3,24401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24401,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24401,1,4,0)
 ;;=4^F10.282
 ;;^UTILITY(U,$J,358.3,24401,2)
 ;;=^5003098
 ;;^UTILITY(U,$J,358.3,24402,0)
 ;;=F10.982^^64^970^25
 ;;^UTILITY(U,$J,358.3,24402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24402,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24402,1,4,0)
 ;;=4^F10.982
 ;;^UTILITY(U,$J,358.3,24402,2)
 ;;=^5003112
 ;;^UTILITY(U,$J,358.3,24403,0)
 ;;=F10.281^^64^970^21
 ;;^UTILITY(U,$J,358.3,24403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24403,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24403,1,4,0)
 ;;=4^F10.281
 ;;^UTILITY(U,$J,358.3,24403,2)
 ;;=^5003097
 ;;^UTILITY(U,$J,358.3,24404,0)
 ;;=F10.981^^64^970^22
 ;;^UTILITY(U,$J,358.3,24404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24404,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24404,1,4,0)
 ;;=4^F10.981
 ;;^UTILITY(U,$J,358.3,24404,2)
 ;;=^5003111
 ;;^UTILITY(U,$J,358.3,24405,0)
 ;;=F10.182^^64^970^23
 ;;^UTILITY(U,$J,358.3,24405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24405,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24405,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,24405,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,24406,0)
 ;;=F10.121^^64^970^26
 ;;^UTILITY(U,$J,358.3,24406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24406,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24406,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,24406,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,24407,0)
 ;;=F10.221^^64^970^27
 ;;^UTILITY(U,$J,358.3,24407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24407,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mod/Severe Use Disorder
