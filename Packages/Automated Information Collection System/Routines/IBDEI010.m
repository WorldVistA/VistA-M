IBDEI010 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,482,1,4,0)
 ;;=4^G47.429
 ;;^UTILITY(U,$J,358.3,482,2)
 ;;=^5003984
 ;;^UTILITY(U,$J,358.3,483,0)
 ;;=F10.10^^3^46^32
 ;;^UTILITY(U,$J,358.3,483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,483,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,483,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,483,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,484,0)
 ;;=F10.20^^3^46^33
 ;;^UTILITY(U,$J,358.3,484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,484,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,484,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,484,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,485,0)
 ;;=F10.239^^3^46^37
 ;;^UTILITY(U,$J,358.3,485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,485,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,485,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,485,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,486,0)
 ;;=F10.180^^3^46^1
 ;;^UTILITY(U,$J,358.3,486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,486,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,486,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,486,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,487,0)
 ;;=F10.280^^3^46^2
 ;;^UTILITY(U,$J,358.3,487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,487,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,487,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,487,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,488,0)
 ;;=F10.980^^3^46^3
 ;;^UTILITY(U,$J,358.3,488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,488,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,488,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,488,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,489,0)
 ;;=F10.94^^3^46^9
 ;;^UTILITY(U,$J,358.3,489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,489,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,489,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,489,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,490,0)
 ;;=F10.26^^3^46^10
 ;;^UTILITY(U,$J,358.3,490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,490,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,490,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,490,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,491,0)
 ;;=F10.96^^3^46^11
 ;;^UTILITY(U,$J,358.3,491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,491,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,491,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,491,2)
 ;;=^5003108
 ;;^UTILITY(U,$J,358.3,492,0)
 ;;=F10.27^^3^46^12
 ;;^UTILITY(U,$J,358.3,492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,492,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type,w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,492,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,492,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,493,0)
 ;;=F10.97^^3^46^13
 ;;^UTILITY(U,$J,358.3,493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,493,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,493,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,493,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,494,0)
 ;;=F10.288^^3^46^14
 ;;^UTILITY(U,$J,358.3,494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,494,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,494,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,494,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,495,0)
 ;;=F10.988^^3^46^15
 ;;^UTILITY(U,$J,358.3,495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,495,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,495,1,4,0)
 ;;=4^F10.988
 ;;^UTILITY(U,$J,358.3,495,2)
 ;;=^5003113
 ;;^UTILITY(U,$J,358.3,496,0)
 ;;=F10.159^^3^46^16
 ;;^UTILITY(U,$J,358.3,496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,496,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,496,1,4,0)
 ;;=4^F10.159
 ;;^UTILITY(U,$J,358.3,496,2)
 ;;=^5003075
 ;;^UTILITY(U,$J,358.3,497,0)
 ;;=F10.259^^3^46^17
 ;;^UTILITY(U,$J,358.3,497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,497,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,497,1,4,0)
 ;;=4^F10.259
 ;;^UTILITY(U,$J,358.3,497,2)
 ;;=^5003093
 ;;^UTILITY(U,$J,358.3,498,0)
 ;;=F10.959^^3^46^18
 ;;^UTILITY(U,$J,358.3,498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,498,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,498,1,4,0)
 ;;=4^F10.959
 ;;^UTILITY(U,$J,358.3,498,2)
 ;;=^5003107
 ;;^UTILITY(U,$J,358.3,499,0)
 ;;=F10.181^^3^46^19
 ;;^UTILITY(U,$J,358.3,499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,499,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,499,1,4,0)
 ;;=4^F10.181
 ;;^UTILITY(U,$J,358.3,499,2)
 ;;=^5003077
 ;;^UTILITY(U,$J,358.3,500,0)
 ;;=F10.282^^3^46^23
 ;;^UTILITY(U,$J,358.3,500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,500,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,500,1,4,0)
 ;;=4^F10.282
 ;;^UTILITY(U,$J,358.3,500,2)
 ;;=^5003098
 ;;^UTILITY(U,$J,358.3,501,0)
 ;;=F10.982^^3^46^24
 ;;^UTILITY(U,$J,358.3,501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,501,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,501,1,4,0)
 ;;=4^F10.982
 ;;^UTILITY(U,$J,358.3,501,2)
 ;;=^5003112
 ;;^UTILITY(U,$J,358.3,502,0)
 ;;=F10.281^^3^46^20
 ;;^UTILITY(U,$J,358.3,502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,502,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,502,1,4,0)
 ;;=4^F10.281
 ;;^UTILITY(U,$J,358.3,502,2)
 ;;=^5003097
 ;;^UTILITY(U,$J,358.3,503,0)
 ;;=F10.981^^3^46^21
 ;;^UTILITY(U,$J,358.3,503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,503,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,503,1,4,0)
 ;;=4^F10.981
 ;;^UTILITY(U,$J,358.3,503,2)
 ;;=^5003111
 ;;^UTILITY(U,$J,358.3,504,0)
 ;;=F10.182^^3^46^22
 ;;^UTILITY(U,$J,358.3,504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,504,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,504,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,504,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,505,0)
 ;;=F10.121^^3^46^25
 ;;^UTILITY(U,$J,358.3,505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,505,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,505,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,505,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,506,0)
 ;;=F10.221^^3^46^26
 ;;^UTILITY(U,$J,358.3,506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,506,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,506,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,506,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,507,0)
 ;;=F10.921^^3^46^27
 ;;^UTILITY(U,$J,358.3,507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,507,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,507,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,507,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,508,0)
 ;;=F10.129^^3^46^28
 ;;^UTILITY(U,$J,358.3,508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,508,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,508,1,4,0)
 ;;=4^F10.129
 ;;^UTILITY(U,$J,358.3,508,2)
 ;;=^5003071
 ;;^UTILITY(U,$J,358.3,509,0)
 ;;=F10.229^^3^46^29
 ;;^UTILITY(U,$J,358.3,509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,509,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,509,1,4,0)
 ;;=4^F10.229
