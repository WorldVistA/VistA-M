IBDEI10L ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36817,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36817,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,36817,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,36818,0)
 ;;=F10.94^^135^1820^9
 ;;^UTILITY(U,$J,358.3,36818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36818,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36818,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,36818,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,36819,0)
 ;;=F10.26^^135^1820^10
 ;;^UTILITY(U,$J,358.3,36819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36819,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36819,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,36819,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,36820,0)
 ;;=F10.96^^135^1820^11
 ;;^UTILITY(U,$J,358.3,36820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36820,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36820,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,36820,2)
 ;;=^5003108
 ;;^UTILITY(U,$J,358.3,36821,0)
 ;;=F10.27^^135^1820^12
 ;;^UTILITY(U,$J,358.3,36821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36821,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type,w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36821,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,36821,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,36822,0)
 ;;=F10.97^^135^1820^13
 ;;^UTILITY(U,$J,358.3,36822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36822,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36822,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,36822,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,36823,0)
 ;;=F10.288^^135^1820^14
 ;;^UTILITY(U,$J,358.3,36823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36823,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36823,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,36823,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,36824,0)
 ;;=F10.988^^135^1820^15
 ;;^UTILITY(U,$J,358.3,36824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36824,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36824,1,4,0)
 ;;=4^F10.988
 ;;^UTILITY(U,$J,358.3,36824,2)
 ;;=^5003113
 ;;^UTILITY(U,$J,358.3,36825,0)
 ;;=F10.159^^135^1820^16
 ;;^UTILITY(U,$J,358.3,36825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36825,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,36825,1,4,0)
 ;;=4^F10.159
 ;;^UTILITY(U,$J,358.3,36825,2)
 ;;=^5003075
 ;;^UTILITY(U,$J,358.3,36826,0)
 ;;=F10.259^^135^1820^17
 ;;^UTILITY(U,$J,358.3,36826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36826,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36826,1,4,0)
 ;;=4^F10.259
 ;;^UTILITY(U,$J,358.3,36826,2)
 ;;=^5003093
 ;;^UTILITY(U,$J,358.3,36827,0)
 ;;=F10.959^^135^1820^18
 ;;^UTILITY(U,$J,358.3,36827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36827,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36827,1,4,0)
 ;;=4^F10.959
 ;;^UTILITY(U,$J,358.3,36827,2)
 ;;=^5003107
 ;;^UTILITY(U,$J,358.3,36828,0)
 ;;=F10.181^^135^1820^19
 ;;^UTILITY(U,$J,358.3,36828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36828,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,36828,1,4,0)
 ;;=4^F10.181
 ;;^UTILITY(U,$J,358.3,36828,2)
 ;;=^5003077
 ;;^UTILITY(U,$J,358.3,36829,0)
 ;;=F10.282^^135^1820^23
 ;;^UTILITY(U,$J,358.3,36829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36829,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36829,1,4,0)
 ;;=4^F10.282
 ;;^UTILITY(U,$J,358.3,36829,2)
 ;;=^5003098
 ;;^UTILITY(U,$J,358.3,36830,0)
 ;;=F10.982^^135^1820^24
 ;;^UTILITY(U,$J,358.3,36830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36830,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36830,1,4,0)
 ;;=4^F10.982
 ;;^UTILITY(U,$J,358.3,36830,2)
 ;;=^5003112
 ;;^UTILITY(U,$J,358.3,36831,0)
 ;;=F10.281^^135^1820^20
 ;;^UTILITY(U,$J,358.3,36831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36831,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36831,1,4,0)
 ;;=4^F10.281
 ;;^UTILITY(U,$J,358.3,36831,2)
 ;;=^5003097
 ;;^UTILITY(U,$J,358.3,36832,0)
 ;;=F10.981^^135^1820^21
 ;;^UTILITY(U,$J,358.3,36832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36832,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36832,1,4,0)
 ;;=4^F10.981
 ;;^UTILITY(U,$J,358.3,36832,2)
 ;;=^5003111
 ;;^UTILITY(U,$J,358.3,36833,0)
 ;;=F10.182^^135^1820^22
 ;;^UTILITY(U,$J,358.3,36833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36833,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,36833,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,36833,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,36834,0)
 ;;=F10.121^^135^1820^25
 ;;^UTILITY(U,$J,358.3,36834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36834,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,36834,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,36834,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,36835,0)
 ;;=F10.221^^135^1820^26
 ;;^UTILITY(U,$J,358.3,36835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36835,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36835,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,36835,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,36836,0)
 ;;=F10.921^^135^1820^27
 ;;^UTILITY(U,$J,358.3,36836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36836,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36836,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,36836,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,36837,0)
 ;;=F10.129^^135^1820^28
 ;;^UTILITY(U,$J,358.3,36837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36837,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,36837,1,4,0)
 ;;=4^F10.129
 ;;^UTILITY(U,$J,358.3,36837,2)
 ;;=^5003071
 ;;^UTILITY(U,$J,358.3,36838,0)
 ;;=F10.229^^135^1820^29
 ;;^UTILITY(U,$J,358.3,36838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36838,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36838,1,4,0)
 ;;=4^F10.229
 ;;^UTILITY(U,$J,358.3,36838,2)
 ;;=^5003085
 ;;^UTILITY(U,$J,358.3,36839,0)
 ;;=F10.929^^135^1820^30
 ;;^UTILITY(U,$J,358.3,36839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36839,1,3,0)
 ;;=3^Alcohol Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36839,1,4,0)
 ;;=4^F10.929
 ;;^UTILITY(U,$J,358.3,36839,2)
 ;;=^5003103
 ;;^UTILITY(U,$J,358.3,36840,0)
 ;;=F10.99^^135^1820^31
 ;;^UTILITY(U,$J,358.3,36840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36840,1,3,0)
 ;;=3^Alcohol Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,36840,1,4,0)
 ;;=4^F10.99
 ;;^UTILITY(U,$J,358.3,36840,2)
 ;;=^5133351
 ;;^UTILITY(U,$J,358.3,36841,0)
 ;;=F10.14^^135^1820^4
 ;;^UTILITY(U,$J,358.3,36841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36841,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,36841,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,36841,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,36842,0)
 ;;=F10.24^^135^1820^5
 ;;^UTILITY(U,$J,358.3,36842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36842,1,3,0)
 ;;=3^Alcohol Induced Bipolar & Related D/O w/ Modera/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36842,1,4,0)
 ;;=4^F10.24
