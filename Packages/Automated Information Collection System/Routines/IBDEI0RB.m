IBDEI0RB ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27440,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27440,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,27440,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,27441,0)
 ;;=F10.94^^102^1338^9
 ;;^UTILITY(U,$J,358.3,27441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27441,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27441,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,27441,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,27442,0)
 ;;=F10.26^^102^1338^10
 ;;^UTILITY(U,$J,358.3,27442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27442,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27442,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,27442,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,27443,0)
 ;;=F10.96^^102^1338^11
 ;;^UTILITY(U,$J,358.3,27443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27443,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27443,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,27443,2)
 ;;=^5003108
 ;;^UTILITY(U,$J,358.3,27444,0)
 ;;=F10.27^^102^1338^12
 ;;^UTILITY(U,$J,358.3,27444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27444,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type,w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27444,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,27444,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,27445,0)
 ;;=F10.97^^102^1338^13
 ;;^UTILITY(U,$J,358.3,27445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27445,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27445,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,27445,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,27446,0)
 ;;=F10.288^^102^1338^14
 ;;^UTILITY(U,$J,358.3,27446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27446,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27446,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,27446,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,27447,0)
 ;;=F10.988^^102^1338^15
 ;;^UTILITY(U,$J,358.3,27447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27447,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27447,1,4,0)
 ;;=4^F10.988
 ;;^UTILITY(U,$J,358.3,27447,2)
 ;;=^5003113
 ;;^UTILITY(U,$J,358.3,27448,0)
 ;;=F10.159^^102^1338^16
 ;;^UTILITY(U,$J,358.3,27448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27448,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27448,1,4,0)
 ;;=4^F10.159
 ;;^UTILITY(U,$J,358.3,27448,2)
 ;;=^5003075
 ;;^UTILITY(U,$J,358.3,27449,0)
 ;;=F10.259^^102^1338^17
 ;;^UTILITY(U,$J,358.3,27449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27449,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27449,1,4,0)
 ;;=4^F10.259
 ;;^UTILITY(U,$J,358.3,27449,2)
 ;;=^5003093
 ;;^UTILITY(U,$J,358.3,27450,0)
 ;;=F10.959^^102^1338^18
 ;;^UTILITY(U,$J,358.3,27450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27450,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27450,1,4,0)
 ;;=4^F10.959
 ;;^UTILITY(U,$J,358.3,27450,2)
 ;;=^5003107
 ;;^UTILITY(U,$J,358.3,27451,0)
 ;;=F10.181^^102^1338^19
 ;;^UTILITY(U,$J,358.3,27451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27451,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27451,1,4,0)
 ;;=4^F10.181
 ;;^UTILITY(U,$J,358.3,27451,2)
 ;;=^5003077
 ;;^UTILITY(U,$J,358.3,27452,0)
 ;;=F10.282^^102^1338^23
 ;;^UTILITY(U,$J,358.3,27452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27452,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27452,1,4,0)
 ;;=4^F10.282
 ;;^UTILITY(U,$J,358.3,27452,2)
 ;;=^5003098
 ;;^UTILITY(U,$J,358.3,27453,0)
 ;;=F10.982^^102^1338^24
 ;;^UTILITY(U,$J,358.3,27453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27453,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27453,1,4,0)
 ;;=4^F10.982
 ;;^UTILITY(U,$J,358.3,27453,2)
 ;;=^5003112
 ;;^UTILITY(U,$J,358.3,27454,0)
 ;;=F10.281^^102^1338^20
 ;;^UTILITY(U,$J,358.3,27454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27454,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27454,1,4,0)
 ;;=4^F10.281
 ;;^UTILITY(U,$J,358.3,27454,2)
 ;;=^5003097
 ;;^UTILITY(U,$J,358.3,27455,0)
 ;;=F10.981^^102^1338^21
 ;;^UTILITY(U,$J,358.3,27455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27455,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27455,1,4,0)
 ;;=4^F10.981
 ;;^UTILITY(U,$J,358.3,27455,2)
 ;;=^5003111
 ;;^UTILITY(U,$J,358.3,27456,0)
 ;;=F10.182^^102^1338^22
 ;;^UTILITY(U,$J,358.3,27456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27456,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27456,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,27456,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,27457,0)
 ;;=F10.121^^102^1338^25
 ;;^UTILITY(U,$J,358.3,27457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27457,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27457,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,27457,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,27458,0)
 ;;=F10.221^^102^1338^26
 ;;^UTILITY(U,$J,358.3,27458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27458,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27458,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,27458,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,27459,0)
 ;;=F10.921^^102^1338^27
 ;;^UTILITY(U,$J,358.3,27459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27459,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27459,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,27459,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,27460,0)
 ;;=F10.129^^102^1338^28
 ;;^UTILITY(U,$J,358.3,27460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27460,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27460,1,4,0)
 ;;=4^F10.129
 ;;^UTILITY(U,$J,358.3,27460,2)
 ;;=^5003071
 ;;^UTILITY(U,$J,358.3,27461,0)
 ;;=F10.229^^102^1338^29
 ;;^UTILITY(U,$J,358.3,27461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27461,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27461,1,4,0)
 ;;=4^F10.229
 ;;^UTILITY(U,$J,358.3,27461,2)
 ;;=^5003085
 ;;^UTILITY(U,$J,358.3,27462,0)
 ;;=F10.929^^102^1338^30
 ;;^UTILITY(U,$J,358.3,27462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27462,1,3,0)
 ;;=3^Alcohol Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27462,1,4,0)
 ;;=4^F10.929
 ;;^UTILITY(U,$J,358.3,27462,2)
 ;;=^5003103
 ;;^UTILITY(U,$J,358.3,27463,0)
 ;;=F10.99^^102^1338^31
 ;;^UTILITY(U,$J,358.3,27463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27463,1,3,0)
 ;;=3^Alcohol Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,27463,1,4,0)
 ;;=4^F10.99
 ;;^UTILITY(U,$J,358.3,27463,2)
 ;;=^5133351
 ;;^UTILITY(U,$J,358.3,27464,0)
 ;;=F10.14^^102^1338^4
 ;;^UTILITY(U,$J,358.3,27464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27464,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27464,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,27464,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,27465,0)
 ;;=F10.24^^102^1338^5
 ;;^UTILITY(U,$J,358.3,27465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27465,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/ Modera/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27465,1,4,0)
 ;;=4^F10.24
