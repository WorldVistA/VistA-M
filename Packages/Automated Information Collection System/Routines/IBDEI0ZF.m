IBDEI0ZF ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35661,0)
 ;;=R06.3^^130^1718^5
 ;;^UTILITY(U,$J,358.3,35661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35661,1,3,0)
 ;;=3^Cheyne-Stokes Breathing
 ;;^UTILITY(U,$J,358.3,35661,1,4,0)
 ;;=4^R06.3
 ;;^UTILITY(U,$J,358.3,35661,2)
 ;;=^5019185
 ;;^UTILITY(U,$J,358.3,35662,0)
 ;;=G47.429^^130^1718^18
 ;;^UTILITY(U,$J,358.3,35662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35662,1,3,0)
 ;;=3^Narcolepsy Secondary to Another Medical Condition
 ;;^UTILITY(U,$J,358.3,35662,1,4,0)
 ;;=4^G47.429
 ;;^UTILITY(U,$J,358.3,35662,2)
 ;;=^5003984
 ;;^UTILITY(U,$J,358.3,35663,0)
 ;;=F10.10^^130^1719^32
 ;;^UTILITY(U,$J,358.3,35663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35663,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,35663,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,35663,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,35664,0)
 ;;=F10.20^^130^1719^33
 ;;^UTILITY(U,$J,358.3,35664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35664,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,35664,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,35664,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,35665,0)
 ;;=F10.239^^130^1719^37
 ;;^UTILITY(U,$J,358.3,35665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35665,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,35665,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,35665,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,35666,0)
 ;;=F10.180^^130^1719^1
 ;;^UTILITY(U,$J,358.3,35666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35666,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,35666,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,35666,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,35667,0)
 ;;=F10.280^^130^1719^2
 ;;^UTILITY(U,$J,358.3,35667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35667,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,35667,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,35667,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,35668,0)
 ;;=F10.980^^130^1719^3
 ;;^UTILITY(U,$J,358.3,35668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35668,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,35668,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,35668,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,35669,0)
 ;;=F10.94^^130^1719^9
 ;;^UTILITY(U,$J,358.3,35669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35669,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,35669,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,35669,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,35670,0)
 ;;=F10.26^^130^1719^10
 ;;^UTILITY(U,$J,358.3,35670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35670,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,35670,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,35670,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,35671,0)
 ;;=F10.96^^130^1719^11
 ;;^UTILITY(U,$J,358.3,35671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35671,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,35671,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,35671,2)
 ;;=^5003108
 ;;^UTILITY(U,$J,358.3,35672,0)
 ;;=F10.27^^130^1719^12
 ;;^UTILITY(U,$J,358.3,35672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35672,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type,w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,35672,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,35672,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,35673,0)
 ;;=F10.97^^130^1719^13
 ;;^UTILITY(U,$J,358.3,35673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35673,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,35673,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,35673,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,35674,0)
 ;;=F10.288^^130^1719^14
 ;;^UTILITY(U,$J,358.3,35674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35674,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,35674,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,35674,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,35675,0)
 ;;=F10.988^^130^1719^15
 ;;^UTILITY(U,$J,358.3,35675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35675,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,35675,1,4,0)
 ;;=4^F10.988
 ;;^UTILITY(U,$J,358.3,35675,2)
 ;;=^5003113
 ;;^UTILITY(U,$J,358.3,35676,0)
 ;;=F10.159^^130^1719^16
 ;;^UTILITY(U,$J,358.3,35676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35676,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,35676,1,4,0)
 ;;=4^F10.159
 ;;^UTILITY(U,$J,358.3,35676,2)
 ;;=^5003075
 ;;^UTILITY(U,$J,358.3,35677,0)
 ;;=F10.259^^130^1719^17
 ;;^UTILITY(U,$J,358.3,35677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35677,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,35677,1,4,0)
 ;;=4^F10.259
 ;;^UTILITY(U,$J,358.3,35677,2)
 ;;=^5003093
 ;;^UTILITY(U,$J,358.3,35678,0)
 ;;=F10.959^^130^1719^18
 ;;^UTILITY(U,$J,358.3,35678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35678,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,35678,1,4,0)
 ;;=4^F10.959
 ;;^UTILITY(U,$J,358.3,35678,2)
 ;;=^5003107
 ;;^UTILITY(U,$J,358.3,35679,0)
 ;;=F10.181^^130^1719^19
 ;;^UTILITY(U,$J,358.3,35679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35679,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,35679,1,4,0)
 ;;=4^F10.181
 ;;^UTILITY(U,$J,358.3,35679,2)
 ;;=^5003077
 ;;^UTILITY(U,$J,358.3,35680,0)
 ;;=F10.282^^130^1719^23
 ;;^UTILITY(U,$J,358.3,35680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35680,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,35680,1,4,0)
 ;;=4^F10.282
 ;;^UTILITY(U,$J,358.3,35680,2)
 ;;=^5003098
 ;;^UTILITY(U,$J,358.3,35681,0)
 ;;=F10.982^^130^1719^24
 ;;^UTILITY(U,$J,358.3,35681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35681,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,35681,1,4,0)
 ;;=4^F10.982
 ;;^UTILITY(U,$J,358.3,35681,2)
 ;;=^5003112
 ;;^UTILITY(U,$J,358.3,35682,0)
 ;;=F10.281^^130^1719^20
 ;;^UTILITY(U,$J,358.3,35682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35682,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,35682,1,4,0)
 ;;=4^F10.281
 ;;^UTILITY(U,$J,358.3,35682,2)
 ;;=^5003097
 ;;^UTILITY(U,$J,358.3,35683,0)
 ;;=F10.981^^130^1719^21
 ;;^UTILITY(U,$J,358.3,35683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35683,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,35683,1,4,0)
 ;;=4^F10.981
 ;;^UTILITY(U,$J,358.3,35683,2)
 ;;=^5003111
 ;;^UTILITY(U,$J,358.3,35684,0)
 ;;=F10.182^^130^1719^22
 ;;^UTILITY(U,$J,358.3,35684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35684,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,35684,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,35684,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,35685,0)
 ;;=F10.121^^130^1719^25
 ;;^UTILITY(U,$J,358.3,35685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35685,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,35685,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,35685,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,35686,0)
 ;;=F10.221^^130^1719^26
 ;;^UTILITY(U,$J,358.3,35686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35686,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,35686,1,4,0)
 ;;=4^F10.221
