IBDEI0OP ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24889,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,24889,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,24889,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,24890,0)
 ;;=Z65.3^^95^1169^3
 ;;^UTILITY(U,$J,358.3,24890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24890,1,3,0)
 ;;=3^Problems Related to Other Legal Circumstances
 ;;^UTILITY(U,$J,358.3,24890,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,24890,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,24891,0)
 ;;=Z65.1^^95^1169^2
 ;;^UTILITY(U,$J,358.3,24891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24891,1,3,0)
 ;;=3^Imprisonment or Other Incarceration
 ;;^UTILITY(U,$J,358.3,24891,1,4,0)
 ;;=4^Z65.1
 ;;^UTILITY(U,$J,358.3,24891,2)
 ;;=^5063180
 ;;^UTILITY(U,$J,358.3,24892,0)
 ;;=Z65.8^^95^1170^7
 ;;^UTILITY(U,$J,358.3,24892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24892,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,24892,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,24892,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,24893,0)
 ;;=Z64.0^^95^1170^6
 ;;^UTILITY(U,$J,358.3,24893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24893,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,24893,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,24893,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,24894,0)
 ;;=Z64.1^^95^1170^4
 ;;^UTILITY(U,$J,358.3,24894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24894,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,24894,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,24894,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,24895,0)
 ;;=Z64.4^^95^1170^1
 ;;^UTILITY(U,$J,358.3,24895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24895,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,24895,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,24895,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,24896,0)
 ;;=Z65.5^^95^1170^2
 ;;^UTILITY(U,$J,358.3,24896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24896,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,24896,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,24896,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,24897,0)
 ;;=Z65.8^^95^1170^5
 ;;^UTILITY(U,$J,358.3,24897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24897,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances,Other
 ;;^UTILITY(U,$J,358.3,24897,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,24897,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,24898,0)
 ;;=Z65.9^^95^1170^3
 ;;^UTILITY(U,$J,358.3,24898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24898,1,3,0)
 ;;=3^Problem Related to Psychosocial Circumstances,Unspec
 ;;^UTILITY(U,$J,358.3,24898,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,24898,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,24899,0)
 ;;=Z65.4^^95^1170^8
 ;;^UTILITY(U,$J,358.3,24899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24899,1,3,0)
 ;;=3^Victim of Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,24899,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,24899,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,24900,0)
 ;;=Z62.820^^95^1171^4
 ;;^UTILITY(U,$J,358.3,24900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24900,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,24900,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,24900,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,24901,0)
 ;;=Z62.891^^95^1171^6
 ;;^UTILITY(U,$J,358.3,24901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24901,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,24901,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,24901,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,24902,0)
 ;;=Z62.898^^95^1171^1
 ;;^UTILITY(U,$J,358.3,24902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24902,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
 ;;^UTILITY(U,$J,358.3,24902,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,24902,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,24903,0)
 ;;=Z63.0^^95^1171^5
 ;;^UTILITY(U,$J,358.3,24903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24903,1,3,0)
 ;;=3^Relationship Distress w/ Spouse/Partner
 ;;^UTILITY(U,$J,358.3,24903,1,4,0)
 ;;=4^Z63.0
 ;;^UTILITY(U,$J,358.3,24903,2)
 ;;=^5063164
 ;;^UTILITY(U,$J,358.3,24904,0)
 ;;=Z63.5^^95^1171^2
 ;;^UTILITY(U,$J,358.3,24904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24904,1,3,0)
 ;;=3^Disruption of Family by Separation or Divorce
 ;;^UTILITY(U,$J,358.3,24904,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,24904,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,24905,0)
 ;;=Z63.8^^95^1171^3
 ;;^UTILITY(U,$J,358.3,24905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24905,1,3,0)
 ;;=3^High Expressed Emotion Level w/in Family
 ;;^UTILITY(U,$J,358.3,24905,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,24905,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,24906,0)
 ;;=Z63.4^^95^1171^7
 ;;^UTILITY(U,$J,358.3,24906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24906,1,3,0)
 ;;=3^Uncomplicated Bereavement
 ;;^UTILITY(U,$J,358.3,24906,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,24906,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,24907,0)
 ;;=Z62.29^^95^1171^8
 ;;^UTILITY(U,$J,358.3,24907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24907,1,3,0)
 ;;=3^Upbringing Away from Parents
 ;;^UTILITY(U,$J,358.3,24907,1,4,0)
 ;;=4^Z62.29
 ;;^UTILITY(U,$J,358.3,24907,2)
 ;;=^5063150
 ;;^UTILITY(U,$J,358.3,24908,0)
 ;;=F20.9^^95^1172^11
 ;;^UTILITY(U,$J,358.3,24908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24908,1,3,0)
 ;;=3^Schizophrenia
 ;;^UTILITY(U,$J,358.3,24908,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,24908,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,24909,0)
 ;;=F20.81^^95^1172^14
 ;;^UTILITY(U,$J,358.3,24909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24909,1,3,0)
 ;;=3^Schizophreniform Disorder
 ;;^UTILITY(U,$J,358.3,24909,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,24909,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,24910,0)
 ;;=F22.^^95^1172^5
 ;;^UTILITY(U,$J,358.3,24910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24910,1,3,0)
 ;;=3^Delusional Disorder
 ;;^UTILITY(U,$J,358.3,24910,1,4,0)
 ;;=4^F22.
 ;;^UTILITY(U,$J,358.3,24910,2)
 ;;=^5003478
 ;;^UTILITY(U,$J,358.3,24911,0)
 ;;=F23.^^95^1172^1
 ;;^UTILITY(U,$J,358.3,24911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24911,1,3,0)
 ;;=3^Brief Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,24911,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,24911,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,24912,0)
 ;;=F25.0^^95^1172^9
 ;;^UTILITY(U,$J,358.3,24912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24912,1,3,0)
 ;;=3^Schizoaffective Disorder,Bipolar Type
 ;;^UTILITY(U,$J,358.3,24912,1,4,0)
 ;;=4^F25.0
 ;;^UTILITY(U,$J,358.3,24912,2)
 ;;=^5003480
 ;;^UTILITY(U,$J,358.3,24913,0)
 ;;=F25.1^^95^1172^10
 ;;^UTILITY(U,$J,358.3,24913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24913,1,3,0)
 ;;=3^Schizoaffective Disorder,Depressive Type
 ;;^UTILITY(U,$J,358.3,24913,1,4,0)
 ;;=4^F25.1
 ;;^UTILITY(U,$J,358.3,24913,2)
 ;;=^5003481
 ;;^UTILITY(U,$J,358.3,24914,0)
 ;;=F28.^^95^1172^12
 ;;^UTILITY(U,$J,358.3,24914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24914,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,24914,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,24914,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,24915,0)
 ;;=F29.^^95^1172^13
 ;;^UTILITY(U,$J,358.3,24915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24915,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24915,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,24915,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,24916,0)
 ;;=F06.1^^95^1172^2
 ;;^UTILITY(U,$J,358.3,24916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24916,1,3,0)
 ;;=3^Catatonia Associated w/ Another Mental Disorder
