IBDEI0R8 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27358,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,27358,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,27358,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,27359,0)
 ;;=F07.0^^102^1331^9
 ;;^UTILITY(U,$J,358.3,27359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27359,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,27359,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,27359,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,27360,0)
 ;;=Z65.4^^102^1332^5
 ;;^UTILITY(U,$J,358.3,27360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27360,1,3,0)
 ;;=3^Victim of Crime
 ;;^UTILITY(U,$J,358.3,27360,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,27360,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,27361,0)
 ;;=Z65.0^^102^1332^1
 ;;^UTILITY(U,$J,358.3,27361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27361,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,27361,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,27361,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,27362,0)
 ;;=Z65.2^^102^1332^4
 ;;^UTILITY(U,$J,358.3,27362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27362,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,27362,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,27362,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,27363,0)
 ;;=Z65.3^^102^1332^3
 ;;^UTILITY(U,$J,358.3,27363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27363,1,3,0)
 ;;=3^Problems Related to Other Legal Circumstances
 ;;^UTILITY(U,$J,358.3,27363,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,27363,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,27364,0)
 ;;=Z65.1^^102^1332^2
 ;;^UTILITY(U,$J,358.3,27364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27364,1,3,0)
 ;;=3^Imprisonment or Other Incarceration
 ;;^UTILITY(U,$J,358.3,27364,1,4,0)
 ;;=4^Z65.1
 ;;^UTILITY(U,$J,358.3,27364,2)
 ;;=^5063180
 ;;^UTILITY(U,$J,358.3,27365,0)
 ;;=Z65.8^^102^1333^7
 ;;^UTILITY(U,$J,358.3,27365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27365,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,27365,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,27365,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,27366,0)
 ;;=Z64.0^^102^1333^6
 ;;^UTILITY(U,$J,358.3,27366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27366,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,27366,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,27366,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,27367,0)
 ;;=Z64.1^^102^1333^4
 ;;^UTILITY(U,$J,358.3,27367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27367,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,27367,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,27367,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,27368,0)
 ;;=Z64.4^^102^1333^1
 ;;^UTILITY(U,$J,358.3,27368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27368,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,27368,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,27368,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,27369,0)
 ;;=Z65.5^^102^1333^2
 ;;^UTILITY(U,$J,358.3,27369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27369,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,27369,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,27369,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,27370,0)
 ;;=Z65.8^^102^1333^5
 ;;^UTILITY(U,$J,358.3,27370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27370,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances,Other
 ;;^UTILITY(U,$J,358.3,27370,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,27370,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,27371,0)
 ;;=Z65.9^^102^1333^3
 ;;^UTILITY(U,$J,358.3,27371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27371,1,3,0)
 ;;=3^Problem Related to Psychosocial Circumstances,Unspec
 ;;^UTILITY(U,$J,358.3,27371,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,27371,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,27372,0)
 ;;=Z65.4^^102^1333^8
 ;;^UTILITY(U,$J,358.3,27372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27372,1,3,0)
 ;;=3^Victim of Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,27372,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,27372,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,27373,0)
 ;;=Z62.820^^102^1334^4
 ;;^UTILITY(U,$J,358.3,27373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27373,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,27373,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,27373,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,27374,0)
 ;;=Z62.891^^102^1334^6
 ;;^UTILITY(U,$J,358.3,27374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27374,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,27374,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,27374,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,27375,0)
 ;;=Z62.898^^102^1334^1
 ;;^UTILITY(U,$J,358.3,27375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27375,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
 ;;^UTILITY(U,$J,358.3,27375,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,27375,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,27376,0)
 ;;=Z63.0^^102^1334^5
 ;;^UTILITY(U,$J,358.3,27376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27376,1,3,0)
 ;;=3^Relationship Distress w/ Spouse/Partner
 ;;^UTILITY(U,$J,358.3,27376,1,4,0)
 ;;=4^Z63.0
 ;;^UTILITY(U,$J,358.3,27376,2)
 ;;=^5063164
 ;;^UTILITY(U,$J,358.3,27377,0)
 ;;=Z63.5^^102^1334^2
 ;;^UTILITY(U,$J,358.3,27377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27377,1,3,0)
 ;;=3^Disruption of Family by Separation or Divorce
 ;;^UTILITY(U,$J,358.3,27377,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,27377,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,27378,0)
 ;;=Z63.8^^102^1334^3
 ;;^UTILITY(U,$J,358.3,27378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27378,1,3,0)
 ;;=3^High Expressed Emotion Level w/in Family
 ;;^UTILITY(U,$J,358.3,27378,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,27378,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,27379,0)
 ;;=Z63.4^^102^1334^7
 ;;^UTILITY(U,$J,358.3,27379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27379,1,3,0)
 ;;=3^Uncomplicated Bereavement
 ;;^UTILITY(U,$J,358.3,27379,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,27379,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,27380,0)
 ;;=Z62.29^^102^1334^8
 ;;^UTILITY(U,$J,358.3,27380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27380,1,3,0)
 ;;=3^Upbringing Away from Parents
 ;;^UTILITY(U,$J,358.3,27380,1,4,0)
 ;;=4^Z62.29
 ;;^UTILITY(U,$J,358.3,27380,2)
 ;;=^5063150
 ;;^UTILITY(U,$J,358.3,27381,0)
 ;;=F20.9^^102^1335^11
 ;;^UTILITY(U,$J,358.3,27381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27381,1,3,0)
 ;;=3^Schizophrenia
 ;;^UTILITY(U,$J,358.3,27381,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,27381,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,27382,0)
 ;;=F20.81^^102^1335^14
 ;;^UTILITY(U,$J,358.3,27382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27382,1,3,0)
 ;;=3^Schizophreniform Disorder
 ;;^UTILITY(U,$J,358.3,27382,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,27382,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,27383,0)
 ;;=F22.^^102^1335^5
 ;;^UTILITY(U,$J,358.3,27383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27383,1,3,0)
 ;;=3^Delusional Disorder
 ;;^UTILITY(U,$J,358.3,27383,1,4,0)
 ;;=4^F22.
 ;;^UTILITY(U,$J,358.3,27383,2)
 ;;=^5003478
 ;;^UTILITY(U,$J,358.3,27384,0)
 ;;=F23.^^102^1335^1
 ;;^UTILITY(U,$J,358.3,27384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27384,1,3,0)
 ;;=3^Brief Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,27384,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,27384,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,27385,0)
 ;;=F25.0^^102^1335^9
 ;;^UTILITY(U,$J,358.3,27385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27385,1,3,0)
 ;;=3^Schizoaffective Disorder,Bipolar Type
 ;;^UTILITY(U,$J,358.3,27385,1,4,0)
 ;;=4^F25.0
