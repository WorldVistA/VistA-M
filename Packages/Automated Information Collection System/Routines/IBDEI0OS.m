IBDEI0OS ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24971,0)
 ;;=F10.27^^95^1175^12
 ;;^UTILITY(U,$J,358.3,24971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24971,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type,w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24971,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,24971,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,24972,0)
 ;;=F10.97^^95^1175^13
 ;;^UTILITY(U,$J,358.3,24972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24972,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24972,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,24972,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,24973,0)
 ;;=F10.288^^95^1175^14
 ;;^UTILITY(U,$J,358.3,24973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24973,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24973,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,24973,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,24974,0)
 ;;=F10.988^^95^1175^15
 ;;^UTILITY(U,$J,358.3,24974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24974,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24974,1,4,0)
 ;;=4^F10.988
 ;;^UTILITY(U,$J,358.3,24974,2)
 ;;=^5003113
 ;;^UTILITY(U,$J,358.3,24975,0)
 ;;=F10.159^^95^1175^16
 ;;^UTILITY(U,$J,358.3,24975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24975,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24975,1,4,0)
 ;;=4^F10.159
 ;;^UTILITY(U,$J,358.3,24975,2)
 ;;=^5003075
 ;;^UTILITY(U,$J,358.3,24976,0)
 ;;=F10.259^^95^1175^17
 ;;^UTILITY(U,$J,358.3,24976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24976,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24976,1,4,0)
 ;;=4^F10.259
 ;;^UTILITY(U,$J,358.3,24976,2)
 ;;=^5003093
 ;;^UTILITY(U,$J,358.3,24977,0)
 ;;=F10.959^^95^1175^18
 ;;^UTILITY(U,$J,358.3,24977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24977,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24977,1,4,0)
 ;;=4^F10.959
 ;;^UTILITY(U,$J,358.3,24977,2)
 ;;=^5003107
 ;;^UTILITY(U,$J,358.3,24978,0)
 ;;=F10.181^^95^1175^19
 ;;^UTILITY(U,$J,358.3,24978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24978,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24978,1,4,0)
 ;;=4^F10.181
 ;;^UTILITY(U,$J,358.3,24978,2)
 ;;=^5003077
 ;;^UTILITY(U,$J,358.3,24979,0)
 ;;=F10.282^^95^1175^23
 ;;^UTILITY(U,$J,358.3,24979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24979,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24979,1,4,0)
 ;;=4^F10.282
 ;;^UTILITY(U,$J,358.3,24979,2)
 ;;=^5003098
 ;;^UTILITY(U,$J,358.3,24980,0)
 ;;=F10.982^^95^1175^24
 ;;^UTILITY(U,$J,358.3,24980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24980,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24980,1,4,0)
 ;;=4^F10.982
 ;;^UTILITY(U,$J,358.3,24980,2)
 ;;=^5003112
 ;;^UTILITY(U,$J,358.3,24981,0)
 ;;=F10.281^^95^1175^20
 ;;^UTILITY(U,$J,358.3,24981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24981,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24981,1,4,0)
 ;;=4^F10.281
 ;;^UTILITY(U,$J,358.3,24981,2)
 ;;=^5003097
 ;;^UTILITY(U,$J,358.3,24982,0)
 ;;=F10.981^^95^1175^21
 ;;^UTILITY(U,$J,358.3,24982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24982,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24982,1,4,0)
 ;;=4^F10.981
 ;;^UTILITY(U,$J,358.3,24982,2)
 ;;=^5003111
 ;;^UTILITY(U,$J,358.3,24983,0)
 ;;=F10.182^^95^1175^22
 ;;^UTILITY(U,$J,358.3,24983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24983,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24983,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,24983,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,24984,0)
 ;;=F10.121^^95^1175^25
 ;;^UTILITY(U,$J,358.3,24984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24984,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24984,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,24984,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,24985,0)
 ;;=F10.221^^95^1175^26
 ;;^UTILITY(U,$J,358.3,24985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24985,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24985,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,24985,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,24986,0)
 ;;=F10.921^^95^1175^27
 ;;^UTILITY(U,$J,358.3,24986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24986,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24986,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,24986,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,24987,0)
 ;;=F10.129^^95^1175^28
 ;;^UTILITY(U,$J,358.3,24987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24987,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24987,1,4,0)
 ;;=4^F10.129
 ;;^UTILITY(U,$J,358.3,24987,2)
 ;;=^5003071
 ;;^UTILITY(U,$J,358.3,24988,0)
 ;;=F10.229^^95^1175^29
 ;;^UTILITY(U,$J,358.3,24988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24988,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24988,1,4,0)
 ;;=4^F10.229
 ;;^UTILITY(U,$J,358.3,24988,2)
 ;;=^5003085
 ;;^UTILITY(U,$J,358.3,24989,0)
 ;;=F10.929^^95^1175^30
 ;;^UTILITY(U,$J,358.3,24989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24989,1,3,0)
 ;;=3^Alcohol Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24989,1,4,0)
 ;;=4^F10.929
 ;;^UTILITY(U,$J,358.3,24989,2)
 ;;=^5003103
 ;;^UTILITY(U,$J,358.3,24990,0)
 ;;=F10.99^^95^1175^31
 ;;^UTILITY(U,$J,358.3,24990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24990,1,3,0)
 ;;=3^Alcohol Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24990,1,4,0)
 ;;=4^F10.99
 ;;^UTILITY(U,$J,358.3,24990,2)
 ;;=^5133351
 ;;^UTILITY(U,$J,358.3,24991,0)
 ;;=F10.14^^95^1175^4
 ;;^UTILITY(U,$J,358.3,24991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24991,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24991,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,24991,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,24992,0)
 ;;=F10.24^^95^1175^5
 ;;^UTILITY(U,$J,358.3,24992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24992,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/ Modera/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24992,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,24992,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,24993,0)
 ;;=F10.94^^95^1175^6
 ;;^UTILITY(U,$J,358.3,24993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24993,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24993,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,24993,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,24994,0)
 ;;=F10.14^^95^1175^7
 ;;^UTILITY(U,$J,358.3,24994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24994,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24994,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,24994,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,24995,0)
 ;;=F10.24^^95^1175^8
 ;;^UTILITY(U,$J,358.3,24995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24995,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24995,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,24995,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,24996,0)
 ;;=F10.20^^95^1175^34
 ;;^UTILITY(U,$J,358.3,24996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24996,1,3,0)
 ;;=3^Alcohol Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,24996,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,24996,2)
 ;;=^5003081
