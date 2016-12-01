IBDEI0BX ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15128,0)
 ;;=F51.01^^45^676^15
 ;;^UTILITY(U,$J,358.3,15128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15128,1,3,0)
 ;;=3^Insomnia Disorder
 ;;^UTILITY(U,$J,358.3,15128,1,4,0)
 ;;=4^F51.01
 ;;^UTILITY(U,$J,358.3,15128,2)
 ;;=^5003603
 ;;^UTILITY(U,$J,358.3,15129,0)
 ;;=G47.36^^45^676^27
 ;;^UTILITY(U,$J,358.3,15129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15129,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Comorbid Sleep-Related Hypoventilation
 ;;^UTILITY(U,$J,358.3,15129,1,4,0)
 ;;=4^G47.36
 ;;^UTILITY(U,$J,358.3,15129,2)
 ;;=^5003979
 ;;^UTILITY(U,$J,358.3,15130,0)
 ;;=G47.35^^45^676^28
 ;;^UTILITY(U,$J,358.3,15130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15130,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Congenital Central Alveolar Hypoventilation
 ;;^UTILITY(U,$J,358.3,15130,1,4,0)
 ;;=4^G47.35
 ;;^UTILITY(U,$J,358.3,15130,2)
 ;;=^332765
 ;;^UTILITY(U,$J,358.3,15131,0)
 ;;=G47.34^^45^676^29
 ;;^UTILITY(U,$J,358.3,15131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15131,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Idiopathic
 ;;^UTILITY(U,$J,358.3,15131,1,4,0)
 ;;=4^G47.34
 ;;^UTILITY(U,$J,358.3,15131,2)
 ;;=^5003978
 ;;^UTILITY(U,$J,358.3,15132,0)
 ;;=G47.9^^45^676^31
 ;;^UTILITY(U,$J,358.3,15132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15132,1,3,0)
 ;;=3^Sleep-Wake Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15132,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,15132,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,15133,0)
 ;;=G47.419^^45^676^1
 ;;^UTILITY(U,$J,358.3,15133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15133,1,3,0)
 ;;=3^Autosomal Dominant Cerebella Ataxia,Deafness,and Narcolepsy
 ;;^UTILITY(U,$J,358.3,15133,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,15133,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,15134,0)
 ;;=G47.419^^45^676^2
 ;;^UTILITY(U,$J,358.3,15134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15134,1,3,0)
 ;;=3^Autosomal Dominant Narcolepsy,Obesity,and Type 2 Diabetes
 ;;^UTILITY(U,$J,358.3,15134,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,15134,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,15135,0)
 ;;=R06.3^^45^676^5
 ;;^UTILITY(U,$J,358.3,15135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15135,1,3,0)
 ;;=3^Cheyne-Stokes Breathing
 ;;^UTILITY(U,$J,358.3,15135,1,4,0)
 ;;=4^R06.3
 ;;^UTILITY(U,$J,358.3,15135,2)
 ;;=^5019185
 ;;^UTILITY(U,$J,358.3,15136,0)
 ;;=G47.429^^45^676^18
 ;;^UTILITY(U,$J,358.3,15136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15136,1,3,0)
 ;;=3^Narcolepsy Secondary to Another Medical Condition
 ;;^UTILITY(U,$J,358.3,15136,1,4,0)
 ;;=4^G47.429
 ;;^UTILITY(U,$J,358.3,15136,2)
 ;;=^5003984
 ;;^UTILITY(U,$J,358.3,15137,0)
 ;;=F10.10^^45^677^33
 ;;^UTILITY(U,$J,358.3,15137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15137,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,15137,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,15137,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,15138,0)
 ;;=F10.20^^45^677^34
 ;;^UTILITY(U,$J,358.3,15138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15138,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,15138,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,15138,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,15139,0)
 ;;=F10.239^^45^677^38
 ;;^UTILITY(U,$J,358.3,15139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15139,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,15139,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,15139,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,15140,0)
 ;;=F10.180^^45^677^2
 ;;^UTILITY(U,$J,358.3,15140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15140,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15140,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,15140,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,15141,0)
 ;;=F10.280^^45^677^3
 ;;^UTILITY(U,$J,358.3,15141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15141,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15141,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,15141,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,15142,0)
 ;;=F10.980^^45^677^4
 ;;^UTILITY(U,$J,358.3,15142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15142,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15142,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,15142,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,15143,0)
 ;;=F10.94^^45^677^10
 ;;^UTILITY(U,$J,358.3,15143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15143,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15143,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,15143,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,15144,0)
 ;;=F10.26^^45^677^11
 ;;^UTILITY(U,$J,358.3,15144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15144,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15144,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,15144,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,15145,0)
 ;;=F10.96^^45^677^12
 ;;^UTILITY(U,$J,358.3,15145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15145,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15145,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,15145,2)
 ;;=^5003108
 ;;^UTILITY(U,$J,358.3,15146,0)
 ;;=F10.27^^45^677^13
 ;;^UTILITY(U,$J,358.3,15146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15146,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type,w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15146,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,15146,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,15147,0)
 ;;=F10.97^^45^677^14
 ;;^UTILITY(U,$J,358.3,15147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15147,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15147,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,15147,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,15148,0)
 ;;=F10.288^^45^677^15
 ;;^UTILITY(U,$J,358.3,15148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15148,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15148,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,15148,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,15149,0)
 ;;=F10.988^^45^677^16
 ;;^UTILITY(U,$J,358.3,15149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15149,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15149,1,4,0)
 ;;=4^F10.988
 ;;^UTILITY(U,$J,358.3,15149,2)
 ;;=^5003113
 ;;^UTILITY(U,$J,358.3,15150,0)
 ;;=F10.159^^45^677^17
 ;;^UTILITY(U,$J,358.3,15150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15150,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15150,1,4,0)
 ;;=4^F10.159
 ;;^UTILITY(U,$J,358.3,15150,2)
 ;;=^5003075
 ;;^UTILITY(U,$J,358.3,15151,0)
 ;;=F10.259^^45^677^18
 ;;^UTILITY(U,$J,358.3,15151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15151,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15151,1,4,0)
 ;;=4^F10.259
 ;;^UTILITY(U,$J,358.3,15151,2)
 ;;=^5003093
 ;;^UTILITY(U,$J,358.3,15152,0)
 ;;=F10.959^^45^677^19
 ;;^UTILITY(U,$J,358.3,15152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15152,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15152,1,4,0)
 ;;=4^F10.959
 ;;^UTILITY(U,$J,358.3,15152,2)
 ;;=^5003107
 ;;^UTILITY(U,$J,358.3,15153,0)
 ;;=F10.181^^45^677^20
 ;;^UTILITY(U,$J,358.3,15153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15153,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15153,1,4,0)
 ;;=4^F10.181
 ;;^UTILITY(U,$J,358.3,15153,2)
 ;;=^5003077
 ;;^UTILITY(U,$J,358.3,15154,0)
 ;;=F10.282^^45^677^24
 ;;^UTILITY(U,$J,358.3,15154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15154,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15154,1,4,0)
 ;;=4^F10.282
 ;;^UTILITY(U,$J,358.3,15154,2)
 ;;=^5003098
 ;;^UTILITY(U,$J,358.3,15155,0)
 ;;=F10.982^^45^677^25
 ;;^UTILITY(U,$J,358.3,15155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15155,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15155,1,4,0)
 ;;=4^F10.982
 ;;^UTILITY(U,$J,358.3,15155,2)
 ;;=^5003112
 ;;^UTILITY(U,$J,358.3,15156,0)
 ;;=F10.281^^45^677^21
 ;;^UTILITY(U,$J,358.3,15156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15156,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15156,1,4,0)
 ;;=4^F10.281
 ;;^UTILITY(U,$J,358.3,15156,2)
 ;;=^5003097
 ;;^UTILITY(U,$J,358.3,15157,0)
 ;;=F10.981^^45^677^22
 ;;^UTILITY(U,$J,358.3,15157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15157,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15157,1,4,0)
 ;;=4^F10.981
 ;;^UTILITY(U,$J,358.3,15157,2)
 ;;=^5003111
 ;;^UTILITY(U,$J,358.3,15158,0)
 ;;=F10.182^^45^677^23
 ;;^UTILITY(U,$J,358.3,15158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15158,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15158,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,15158,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,15159,0)
 ;;=F10.121^^45^677^26
 ;;^UTILITY(U,$J,358.3,15159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15159,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15159,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,15159,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,15160,0)
 ;;=F10.221^^45^677^27
 ;;^UTILITY(U,$J,358.3,15160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15160,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15160,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,15160,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,15161,0)
 ;;=F10.921^^45^677^28
