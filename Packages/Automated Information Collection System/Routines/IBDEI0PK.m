IBDEI0PK ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25721,0)
 ;;=F10.20^^97^1220^33
 ;;^UTILITY(U,$J,358.3,25721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25721,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,25721,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,25721,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,25722,0)
 ;;=F10.239^^97^1220^37
 ;;^UTILITY(U,$J,358.3,25722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25722,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,25722,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,25722,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,25723,0)
 ;;=F10.180^^97^1220^1
 ;;^UTILITY(U,$J,358.3,25723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25723,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25723,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,25723,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,25724,0)
 ;;=F10.280^^97^1220^2
 ;;^UTILITY(U,$J,358.3,25724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25724,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25724,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,25724,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,25725,0)
 ;;=F10.980^^97^1220^3
 ;;^UTILITY(U,$J,358.3,25725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25725,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25725,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,25725,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,25726,0)
 ;;=F10.94^^97^1220^9
 ;;^UTILITY(U,$J,358.3,25726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25726,1,3,0)
 ;;=3^Alcohol Induced Depressive D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25726,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,25726,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,25727,0)
 ;;=F10.26^^97^1220^10
 ;;^UTILITY(U,$J,358.3,25727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25727,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25727,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,25727,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,25728,0)
 ;;=F10.96^^97^1220^11
 ;;^UTILITY(U,$J,358.3,25728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25728,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25728,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,25728,2)
 ;;=^5003108
 ;;^UTILITY(U,$J,358.3,25729,0)
 ;;=F10.27^^97^1220^12
 ;;^UTILITY(U,$J,358.3,25729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25729,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type,w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25729,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,25729,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,25730,0)
 ;;=F10.97^^97^1220^13
 ;;^UTILITY(U,$J,358.3,25730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25730,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25730,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,25730,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,25731,0)
 ;;=F10.288^^97^1220^14
 ;;^UTILITY(U,$J,358.3,25731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25731,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25731,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,25731,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,25732,0)
 ;;=F10.988^^97^1220^15
 ;;^UTILITY(U,$J,358.3,25732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25732,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25732,1,4,0)
 ;;=4^F10.988
 ;;^UTILITY(U,$J,358.3,25732,2)
 ;;=^5003113
 ;;^UTILITY(U,$J,358.3,25733,0)
 ;;=F10.159^^97^1220^16
 ;;^UTILITY(U,$J,358.3,25733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25733,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25733,1,4,0)
 ;;=4^F10.159
 ;;^UTILITY(U,$J,358.3,25733,2)
 ;;=^5003075
 ;;^UTILITY(U,$J,358.3,25734,0)
 ;;=F10.259^^97^1220^17
 ;;^UTILITY(U,$J,358.3,25734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25734,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25734,1,4,0)
 ;;=4^F10.259
 ;;^UTILITY(U,$J,358.3,25734,2)
 ;;=^5003093
 ;;^UTILITY(U,$J,358.3,25735,0)
 ;;=F10.959^^97^1220^18
 ;;^UTILITY(U,$J,358.3,25735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25735,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25735,1,4,0)
 ;;=4^F10.959
 ;;^UTILITY(U,$J,358.3,25735,2)
 ;;=^5003107
 ;;^UTILITY(U,$J,358.3,25736,0)
 ;;=F10.181^^97^1220^19
 ;;^UTILITY(U,$J,358.3,25736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25736,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25736,1,4,0)
 ;;=4^F10.181
 ;;^UTILITY(U,$J,358.3,25736,2)
 ;;=^5003077
 ;;^UTILITY(U,$J,358.3,25737,0)
 ;;=F10.282^^97^1220^23
 ;;^UTILITY(U,$J,358.3,25737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25737,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25737,1,4,0)
 ;;=4^F10.282
 ;;^UTILITY(U,$J,358.3,25737,2)
 ;;=^5003098
 ;;^UTILITY(U,$J,358.3,25738,0)
 ;;=F10.982^^97^1220^24
 ;;^UTILITY(U,$J,358.3,25738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25738,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25738,1,4,0)
 ;;=4^F10.982
 ;;^UTILITY(U,$J,358.3,25738,2)
 ;;=^5003112
 ;;^UTILITY(U,$J,358.3,25739,0)
 ;;=F10.281^^97^1220^20
 ;;^UTILITY(U,$J,358.3,25739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25739,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25739,1,4,0)
 ;;=4^F10.281
 ;;^UTILITY(U,$J,358.3,25739,2)
 ;;=^5003097
 ;;^UTILITY(U,$J,358.3,25740,0)
 ;;=F10.981^^97^1220^21
 ;;^UTILITY(U,$J,358.3,25740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25740,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25740,1,4,0)
 ;;=4^F10.981
 ;;^UTILITY(U,$J,358.3,25740,2)
 ;;=^5003111
 ;;^UTILITY(U,$J,358.3,25741,0)
 ;;=F10.182^^97^1220^22
 ;;^UTILITY(U,$J,358.3,25741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25741,1,3,0)
 ;;=3^Alcohol Induced Sleep D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25741,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,25741,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,25742,0)
 ;;=F10.121^^97^1220^25
 ;;^UTILITY(U,$J,358.3,25742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25742,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25742,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,25742,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,25743,0)
 ;;=F10.221^^97^1220^26
 ;;^UTILITY(U,$J,358.3,25743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25743,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25743,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,25743,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,25744,0)
 ;;=F10.921^^97^1220^27
 ;;^UTILITY(U,$J,358.3,25744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25744,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25744,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,25744,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,25745,0)
 ;;=F10.129^^97^1220^28
 ;;^UTILITY(U,$J,358.3,25745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25745,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25745,1,4,0)
 ;;=4^F10.129
 ;;^UTILITY(U,$J,358.3,25745,2)
 ;;=^5003071
 ;;^UTILITY(U,$J,358.3,25746,0)
 ;;=F10.229^^97^1220^29
 ;;^UTILITY(U,$J,358.3,25746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25746,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25746,1,4,0)
 ;;=4^F10.229
