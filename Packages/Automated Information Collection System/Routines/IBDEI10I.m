IBDEI10I ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36735,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,36735,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,36735,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,36736,0)
 ;;=F07.0^^135^1813^9
 ;;^UTILITY(U,$J,358.3,36736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36736,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,36736,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,36736,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,36737,0)
 ;;=Z65.4^^135^1814^5
 ;;^UTILITY(U,$J,358.3,36737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36737,1,3,0)
 ;;=3^Victim of Crime
 ;;^UTILITY(U,$J,358.3,36737,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,36737,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,36738,0)
 ;;=Z65.0^^135^1814^1
 ;;^UTILITY(U,$J,358.3,36738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36738,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,36738,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,36738,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,36739,0)
 ;;=Z65.2^^135^1814^4
 ;;^UTILITY(U,$J,358.3,36739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36739,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,36739,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,36739,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,36740,0)
 ;;=Z65.3^^135^1814^3
 ;;^UTILITY(U,$J,358.3,36740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36740,1,3,0)
 ;;=3^Problems Related to Other Legal Circumstances
 ;;^UTILITY(U,$J,358.3,36740,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,36740,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,36741,0)
 ;;=Z65.1^^135^1814^2
 ;;^UTILITY(U,$J,358.3,36741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36741,1,3,0)
 ;;=3^Imprisonment or Other Incarceration
 ;;^UTILITY(U,$J,358.3,36741,1,4,0)
 ;;=4^Z65.1
 ;;^UTILITY(U,$J,358.3,36741,2)
 ;;=^5063180
 ;;^UTILITY(U,$J,358.3,36742,0)
 ;;=Z65.8^^135^1815^7
 ;;^UTILITY(U,$J,358.3,36742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36742,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,36742,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,36742,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,36743,0)
 ;;=Z64.0^^135^1815^6
 ;;^UTILITY(U,$J,358.3,36743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36743,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,36743,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,36743,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,36744,0)
 ;;=Z64.1^^135^1815^4
 ;;^UTILITY(U,$J,358.3,36744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36744,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,36744,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,36744,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,36745,0)
 ;;=Z64.4^^135^1815^1
 ;;^UTILITY(U,$J,358.3,36745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36745,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,36745,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,36745,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,36746,0)
 ;;=Z65.5^^135^1815^2
 ;;^UTILITY(U,$J,358.3,36746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36746,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,36746,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,36746,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,36747,0)
 ;;=Z65.8^^135^1815^5
 ;;^UTILITY(U,$J,358.3,36747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36747,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances,Other
 ;;^UTILITY(U,$J,358.3,36747,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,36747,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,36748,0)
 ;;=Z65.9^^135^1815^3
 ;;^UTILITY(U,$J,358.3,36748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36748,1,3,0)
 ;;=3^Problem Related to Psychosocial Circumstances,Unspec
 ;;^UTILITY(U,$J,358.3,36748,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,36748,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,36749,0)
 ;;=Z65.4^^135^1815^8
 ;;^UTILITY(U,$J,358.3,36749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36749,1,3,0)
 ;;=3^Victim of Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,36749,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,36749,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,36750,0)
 ;;=Z62.820^^135^1816^4
 ;;^UTILITY(U,$J,358.3,36750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36750,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,36750,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,36750,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,36751,0)
 ;;=Z62.891^^135^1816^6
 ;;^UTILITY(U,$J,358.3,36751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36751,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,36751,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,36751,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,36752,0)
 ;;=Z62.898^^135^1816^1
 ;;^UTILITY(U,$J,358.3,36752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36752,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
 ;;^UTILITY(U,$J,358.3,36752,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,36752,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,36753,0)
 ;;=Z63.0^^135^1816^5
 ;;^UTILITY(U,$J,358.3,36753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36753,1,3,0)
 ;;=3^Relationship Distress w/ Spouse/Partner
 ;;^UTILITY(U,$J,358.3,36753,1,4,0)
 ;;=4^Z63.0
 ;;^UTILITY(U,$J,358.3,36753,2)
 ;;=^5063164
 ;;^UTILITY(U,$J,358.3,36754,0)
 ;;=Z63.5^^135^1816^2
 ;;^UTILITY(U,$J,358.3,36754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36754,1,3,0)
 ;;=3^Disruption of Family by Separation or Divorce
 ;;^UTILITY(U,$J,358.3,36754,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,36754,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,36755,0)
 ;;=Z63.8^^135^1816^3
 ;;^UTILITY(U,$J,358.3,36755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36755,1,3,0)
 ;;=3^High Expressed Emotion Level w/in Family
 ;;^UTILITY(U,$J,358.3,36755,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,36755,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,36756,0)
 ;;=Z63.4^^135^1816^7
 ;;^UTILITY(U,$J,358.3,36756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36756,1,3,0)
 ;;=3^Uncomplicated Bereavement
 ;;^UTILITY(U,$J,358.3,36756,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,36756,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,36757,0)
 ;;=Z62.29^^135^1816^8
 ;;^UTILITY(U,$J,358.3,36757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36757,1,3,0)
 ;;=3^Upbringing Away from Parents
 ;;^UTILITY(U,$J,358.3,36757,1,4,0)
 ;;=4^Z62.29
 ;;^UTILITY(U,$J,358.3,36757,2)
 ;;=^5063150
 ;;^UTILITY(U,$J,358.3,36758,0)
 ;;=F20.9^^135^1817^11
 ;;^UTILITY(U,$J,358.3,36758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36758,1,3,0)
 ;;=3^Schizophrenia
 ;;^UTILITY(U,$J,358.3,36758,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,36758,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,36759,0)
 ;;=F20.81^^135^1817^14
 ;;^UTILITY(U,$J,358.3,36759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36759,1,3,0)
 ;;=3^Schizophreniform Disorder
 ;;^UTILITY(U,$J,358.3,36759,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,36759,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,36760,0)
 ;;=F22.^^135^1817^5
 ;;^UTILITY(U,$J,358.3,36760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36760,1,3,0)
 ;;=3^Delusional Disorder
 ;;^UTILITY(U,$J,358.3,36760,1,4,0)
 ;;=4^F22.
 ;;^UTILITY(U,$J,358.3,36760,2)
 ;;=^5003478
 ;;^UTILITY(U,$J,358.3,36761,0)
 ;;=F23.^^135^1817^1
 ;;^UTILITY(U,$J,358.3,36761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36761,1,3,0)
 ;;=3^Brief Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,36761,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,36761,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,36762,0)
 ;;=F25.0^^135^1817^9
 ;;^UTILITY(U,$J,358.3,36762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36762,1,3,0)
 ;;=3^Schizoaffective Disorder,Bipolar Type
 ;;^UTILITY(U,$J,358.3,36762,1,4,0)
 ;;=4^F25.0
