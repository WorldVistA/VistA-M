IBDEI0JV ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25158,1,3,0)
 ;;=3^Insomnia Disorder
 ;;^UTILITY(U,$J,358.3,25158,1,4,0)
 ;;=4^F51.01
 ;;^UTILITY(U,$J,358.3,25158,2)
 ;;=^5003603
 ;;^UTILITY(U,$J,358.3,25159,0)
 ;;=G47.36^^66^1015^27
 ;;^UTILITY(U,$J,358.3,25159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25159,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Comorbid Sleep-Related Hypoventilation
 ;;^UTILITY(U,$J,358.3,25159,1,4,0)
 ;;=4^G47.36
 ;;^UTILITY(U,$J,358.3,25159,2)
 ;;=^5003979
 ;;^UTILITY(U,$J,358.3,25160,0)
 ;;=G47.35^^66^1015^28
 ;;^UTILITY(U,$J,358.3,25160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25160,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Congenital Central Alveolar Hypoventilation
 ;;^UTILITY(U,$J,358.3,25160,1,4,0)
 ;;=4^G47.35
 ;;^UTILITY(U,$J,358.3,25160,2)
 ;;=^332765
 ;;^UTILITY(U,$J,358.3,25161,0)
 ;;=G47.34^^66^1015^29
 ;;^UTILITY(U,$J,358.3,25161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25161,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Idiopathic
 ;;^UTILITY(U,$J,358.3,25161,1,4,0)
 ;;=4^G47.34
 ;;^UTILITY(U,$J,358.3,25161,2)
 ;;=^5003978
 ;;^UTILITY(U,$J,358.3,25162,0)
 ;;=G47.9^^66^1015^31
 ;;^UTILITY(U,$J,358.3,25162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25162,1,3,0)
 ;;=3^Sleep-Wake Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25162,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,25162,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,25163,0)
 ;;=G47.419^^66^1015^1
 ;;^UTILITY(U,$J,358.3,25163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25163,1,3,0)
 ;;=3^Autosomal Dominant Cerebella Ataxia,Deafness,and Narcolepsy
 ;;^UTILITY(U,$J,358.3,25163,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,25163,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,25164,0)
 ;;=G47.419^^66^1015^2
 ;;^UTILITY(U,$J,358.3,25164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25164,1,3,0)
 ;;=3^Autosomal Dominant Narcolepsy,Obesity,and Type 2 Diabetes
 ;;^UTILITY(U,$J,358.3,25164,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,25164,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,25165,0)
 ;;=R06.3^^66^1015^5
 ;;^UTILITY(U,$J,358.3,25165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25165,1,3,0)
 ;;=3^Cheyne-Stokes Breathing
 ;;^UTILITY(U,$J,358.3,25165,1,4,0)
 ;;=4^R06.3
 ;;^UTILITY(U,$J,358.3,25165,2)
 ;;=^5019185
 ;;^UTILITY(U,$J,358.3,25166,0)
 ;;=G47.429^^66^1015^18
 ;;^UTILITY(U,$J,358.3,25166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25166,1,3,0)
 ;;=3^Narcolepsy Secondary to Another Medical Condition
 ;;^UTILITY(U,$J,358.3,25166,1,4,0)
 ;;=4^G47.429
 ;;^UTILITY(U,$J,358.3,25166,2)
 ;;=^5003984
 ;;^UTILITY(U,$J,358.3,25167,0)
 ;;=F10.10^^66^1016^33
 ;;^UTILITY(U,$J,358.3,25167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25167,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25167,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,25167,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,25168,0)
 ;;=F10.20^^66^1016^34
 ;;^UTILITY(U,$J,358.3,25168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25168,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,25168,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,25168,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,25169,0)
 ;;=F10.239^^66^1016^38
 ;;^UTILITY(U,$J,358.3,25169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25169,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,25169,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,25169,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,25170,0)
 ;;=F10.180^^66^1016^2
 ;;^UTILITY(U,$J,358.3,25170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25170,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25170,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,25170,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,25171,0)
 ;;=F10.280^^66^1016^3
 ;;^UTILITY(U,$J,358.3,25171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25171,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25171,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,25171,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,25172,0)
 ;;=F10.980^^66^1016^4
 ;;^UTILITY(U,$J,358.3,25172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25172,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25172,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,25172,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,25173,0)
 ;;=F10.94^^66^1016^10
 ;;^UTILITY(U,$J,358.3,25173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25173,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25173,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,25173,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,25174,0)
 ;;=F10.26^^66^1016^11
 ;;^UTILITY(U,$J,358.3,25174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25174,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25174,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,25174,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,25175,0)
 ;;=F10.96^^66^1016^12
 ;;^UTILITY(U,$J,358.3,25175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25175,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25175,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,25175,2)
 ;;=^5003108
 ;;^UTILITY(U,$J,358.3,25176,0)
 ;;=F10.27^^66^1016^13
 ;;^UTILITY(U,$J,358.3,25176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25176,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type,w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25176,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,25176,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,25177,0)
 ;;=F10.97^^66^1016^14
 ;;^UTILITY(U,$J,358.3,25177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25177,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25177,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,25177,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,25178,0)
 ;;=F10.288^^66^1016^15
 ;;^UTILITY(U,$J,358.3,25178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25178,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25178,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,25178,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,25179,0)
 ;;=F10.988^^66^1016^16
 ;;^UTILITY(U,$J,358.3,25179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25179,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25179,1,4,0)
 ;;=4^F10.988
 ;;^UTILITY(U,$J,358.3,25179,2)
 ;;=^5003113
 ;;^UTILITY(U,$J,358.3,25180,0)
 ;;=F10.159^^66^1016^17
 ;;^UTILITY(U,$J,358.3,25180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25180,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25180,1,4,0)
 ;;=4^F10.159
 ;;^UTILITY(U,$J,358.3,25180,2)
 ;;=^5003075
 ;;^UTILITY(U,$J,358.3,25181,0)
 ;;=F10.259^^66^1016^18
 ;;^UTILITY(U,$J,358.3,25181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25181,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25181,1,4,0)
 ;;=4^F10.259
 ;;^UTILITY(U,$J,358.3,25181,2)
 ;;=^5003093
 ;;^UTILITY(U,$J,358.3,25182,0)
 ;;=F10.959^^66^1016^19
 ;;^UTILITY(U,$J,358.3,25182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25182,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25182,1,4,0)
 ;;=4^F10.959
 ;;^UTILITY(U,$J,358.3,25182,2)
 ;;=^5003107
 ;;^UTILITY(U,$J,358.3,25183,0)
 ;;=F10.181^^66^1016^20
 ;;^UTILITY(U,$J,358.3,25183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25183,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25183,1,4,0)
 ;;=4^F10.181
 ;;^UTILITY(U,$J,358.3,25183,2)
 ;;=^5003077
 ;;^UTILITY(U,$J,358.3,25184,0)
 ;;=F10.282^^66^1016^24
 ;;^UTILITY(U,$J,358.3,25184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25184,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25184,1,4,0)
 ;;=4^F10.282
 ;;^UTILITY(U,$J,358.3,25184,2)
 ;;=^5003098
 ;;^UTILITY(U,$J,358.3,25185,0)
 ;;=F10.982^^66^1016^25
 ;;^UTILITY(U,$J,358.3,25185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25185,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25185,1,4,0)
 ;;=4^F10.982
 ;;^UTILITY(U,$J,358.3,25185,2)
 ;;=^5003112
 ;;^UTILITY(U,$J,358.3,25186,0)
 ;;=F10.281^^66^1016^21
 ;;^UTILITY(U,$J,358.3,25186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25186,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25186,1,4,0)
 ;;=4^F10.281
 ;;^UTILITY(U,$J,358.3,25186,2)
 ;;=^5003097
 ;;^UTILITY(U,$J,358.3,25187,0)
 ;;=F10.981^^66^1016^22
 ;;^UTILITY(U,$J,358.3,25187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25187,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25187,1,4,0)
 ;;=4^F10.981
 ;;^UTILITY(U,$J,358.3,25187,2)
 ;;=^5003111
 ;;^UTILITY(U,$J,358.3,25188,0)
 ;;=F10.182^^66^1016^23
 ;;^UTILITY(U,$J,358.3,25188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25188,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25188,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,25188,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,25189,0)
 ;;=F10.121^^66^1016^26
 ;;^UTILITY(U,$J,358.3,25189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25189,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25189,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,25189,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,25190,0)
 ;;=F10.221^^66^1016^27
 ;;^UTILITY(U,$J,358.3,25190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25190,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25190,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,25190,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,25191,0)
 ;;=F10.921^^66^1016^28
 ;;^UTILITY(U,$J,358.3,25191,1,0)
 ;;=^358.31IA^4^2
