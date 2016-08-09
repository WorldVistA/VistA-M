IBDEI0QG ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26600,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Congenital Central Alveolar Hypoventilation
 ;;^UTILITY(U,$J,358.3,26600,1,4,0)
 ;;=4^G47.35
 ;;^UTILITY(U,$J,358.3,26600,2)
 ;;=^332765
 ;;^UTILITY(U,$J,358.3,26601,0)
 ;;=G47.34^^100^1285^29
 ;;^UTILITY(U,$J,358.3,26601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26601,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Idiopathic
 ;;^UTILITY(U,$J,358.3,26601,1,4,0)
 ;;=4^G47.34
 ;;^UTILITY(U,$J,358.3,26601,2)
 ;;=^5003978
 ;;^UTILITY(U,$J,358.3,26602,0)
 ;;=G47.9^^100^1285^31
 ;;^UTILITY(U,$J,358.3,26602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26602,1,3,0)
 ;;=3^Sleep-Wake Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26602,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,26602,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,26603,0)
 ;;=G47.419^^100^1285^1
 ;;^UTILITY(U,$J,358.3,26603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26603,1,3,0)
 ;;=3^Autosomal Dominant Cerebella Ataxia,Deafness,and Narcolepsy
 ;;^UTILITY(U,$J,358.3,26603,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,26603,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,26604,0)
 ;;=G47.419^^100^1285^2
 ;;^UTILITY(U,$J,358.3,26604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26604,1,3,0)
 ;;=3^Autosomal Dominant Narcolepsy,Obesity,and Type 2 Diabetes
 ;;^UTILITY(U,$J,358.3,26604,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,26604,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,26605,0)
 ;;=R06.3^^100^1285^5
 ;;^UTILITY(U,$J,358.3,26605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26605,1,3,0)
 ;;=3^Cheyne-Stokes Breathing
 ;;^UTILITY(U,$J,358.3,26605,1,4,0)
 ;;=4^R06.3
 ;;^UTILITY(U,$J,358.3,26605,2)
 ;;=^5019185
 ;;^UTILITY(U,$J,358.3,26606,0)
 ;;=G47.429^^100^1285^18
 ;;^UTILITY(U,$J,358.3,26606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26606,1,3,0)
 ;;=3^Narcolepsy Secondary to Another Medical Condition
 ;;^UTILITY(U,$J,358.3,26606,1,4,0)
 ;;=4^G47.429
 ;;^UTILITY(U,$J,358.3,26606,2)
 ;;=^5003984
 ;;^UTILITY(U,$J,358.3,26607,0)
 ;;=F10.10^^100^1286^32
 ;;^UTILITY(U,$J,358.3,26607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26607,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,26607,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,26607,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,26608,0)
 ;;=F10.20^^100^1286^33
 ;;^UTILITY(U,$J,358.3,26608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26608,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,26608,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,26608,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,26609,0)
 ;;=F10.239^^100^1286^37
 ;;^UTILITY(U,$J,358.3,26609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26609,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,26609,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,26609,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,26610,0)
 ;;=F10.180^^100^1286^1
 ;;^UTILITY(U,$J,358.3,26610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26610,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26610,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,26610,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,26611,0)
 ;;=F10.280^^100^1286^2
 ;;^UTILITY(U,$J,358.3,26611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26611,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26611,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,26611,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,26612,0)
 ;;=F10.980^^100^1286^3
 ;;^UTILITY(U,$J,358.3,26612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26612,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26612,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,26612,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,26613,0)
 ;;=F10.94^^100^1286^9
 ;;^UTILITY(U,$J,358.3,26613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26613,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26613,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,26613,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,26614,0)
 ;;=F10.26^^100^1286^10
 ;;^UTILITY(U,$J,358.3,26614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26614,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26614,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,26614,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,26615,0)
 ;;=F10.96^^100^1286^11
 ;;^UTILITY(U,$J,358.3,26615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26615,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26615,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,26615,2)
 ;;=^5003108
 ;;^UTILITY(U,$J,358.3,26616,0)
 ;;=F10.27^^100^1286^12
 ;;^UTILITY(U,$J,358.3,26616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26616,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type,w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26616,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,26616,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,26617,0)
 ;;=F10.97^^100^1286^13
 ;;^UTILITY(U,$J,358.3,26617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26617,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26617,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,26617,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,26618,0)
 ;;=F10.288^^100^1286^14
 ;;^UTILITY(U,$J,358.3,26618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26618,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26618,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,26618,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,26619,0)
 ;;=F10.988^^100^1286^15
 ;;^UTILITY(U,$J,358.3,26619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26619,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26619,1,4,0)
 ;;=4^F10.988
 ;;^UTILITY(U,$J,358.3,26619,2)
 ;;=^5003113
 ;;^UTILITY(U,$J,358.3,26620,0)
 ;;=F10.159^^100^1286^16
 ;;^UTILITY(U,$J,358.3,26620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26620,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26620,1,4,0)
 ;;=4^F10.159
 ;;^UTILITY(U,$J,358.3,26620,2)
 ;;=^5003075
 ;;^UTILITY(U,$J,358.3,26621,0)
 ;;=F10.259^^100^1286^17
 ;;^UTILITY(U,$J,358.3,26621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26621,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26621,1,4,0)
 ;;=4^F10.259
 ;;^UTILITY(U,$J,358.3,26621,2)
 ;;=^5003093
 ;;^UTILITY(U,$J,358.3,26622,0)
 ;;=F10.959^^100^1286^18
 ;;^UTILITY(U,$J,358.3,26622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26622,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26622,1,4,0)
 ;;=4^F10.959
 ;;^UTILITY(U,$J,358.3,26622,2)
 ;;=^5003107
 ;;^UTILITY(U,$J,358.3,26623,0)
 ;;=F10.181^^100^1286^19
 ;;^UTILITY(U,$J,358.3,26623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26623,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26623,1,4,0)
 ;;=4^F10.181
 ;;^UTILITY(U,$J,358.3,26623,2)
 ;;=^5003077
 ;;^UTILITY(U,$J,358.3,26624,0)
 ;;=F10.282^^100^1286^23
 ;;^UTILITY(U,$J,358.3,26624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26624,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26624,1,4,0)
 ;;=4^F10.282
 ;;^UTILITY(U,$J,358.3,26624,2)
 ;;=^5003098
 ;;^UTILITY(U,$J,358.3,26625,0)
 ;;=F10.982^^100^1286^24
 ;;^UTILITY(U,$J,358.3,26625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26625,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26625,1,4,0)
 ;;=4^F10.982
 ;;^UTILITY(U,$J,358.3,26625,2)
 ;;=^5003112
 ;;^UTILITY(U,$J,358.3,26626,0)
 ;;=F10.281^^100^1286^20
 ;;^UTILITY(U,$J,358.3,26626,1,0)
 ;;=^358.31IA^4^2
