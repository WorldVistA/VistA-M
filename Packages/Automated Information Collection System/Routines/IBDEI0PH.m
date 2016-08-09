IBDEI0PH ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25638,1,3,0)
 ;;=3^Antisocial Personality Disorder
 ;;^UTILITY(U,$J,358.3,25638,1,4,0)
 ;;=4^F60.2
 ;;^UTILITY(U,$J,358.3,25638,2)
 ;;=^9066
 ;;^UTILITY(U,$J,358.3,25639,0)
 ;;=F60.81^^97^1213^6
 ;;^UTILITY(U,$J,358.3,25639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25639,1,3,0)
 ;;=3^Narcissistic Personality Disorder
 ;;^UTILITY(U,$J,358.3,25639,1,4,0)
 ;;=4^F60.81
 ;;^UTILITY(U,$J,358.3,25639,2)
 ;;=^331919
 ;;^UTILITY(U,$J,358.3,25640,0)
 ;;=F60.6^^97^1213^2
 ;;^UTILITY(U,$J,358.3,25640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25640,1,3,0)
 ;;=3^Avoidant Personality Disorder
 ;;^UTILITY(U,$J,358.3,25640,1,4,0)
 ;;=4^F60.6
 ;;^UTILITY(U,$J,358.3,25640,2)
 ;;=^331920
 ;;^UTILITY(U,$J,358.3,25641,0)
 ;;=F60.3^^97^1213^3
 ;;^UTILITY(U,$J,358.3,25641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25641,1,3,0)
 ;;=3^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,25641,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,25641,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,25642,0)
 ;;=F60.89^^97^1213^10
 ;;^UTILITY(U,$J,358.3,25642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25642,1,3,0)
 ;;=3^Personality Disorder,Other
 ;;^UTILITY(U,$J,358.3,25642,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,25642,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,25643,0)
 ;;=F60.9^^97^1213^11
 ;;^UTILITY(U,$J,358.3,25643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25643,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25643,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,25643,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,25644,0)
 ;;=F07.0^^97^1213^9
 ;;^UTILITY(U,$J,358.3,25644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25644,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,25644,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,25644,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,25645,0)
 ;;=Z65.4^^97^1214^5
 ;;^UTILITY(U,$J,358.3,25645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25645,1,3,0)
 ;;=3^Victim of Crime
 ;;^UTILITY(U,$J,358.3,25645,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,25645,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,25646,0)
 ;;=Z65.0^^97^1214^1
 ;;^UTILITY(U,$J,358.3,25646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25646,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,25646,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,25646,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,25647,0)
 ;;=Z65.2^^97^1214^4
 ;;^UTILITY(U,$J,358.3,25647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25647,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,25647,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,25647,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,25648,0)
 ;;=Z65.3^^97^1214^3
 ;;^UTILITY(U,$J,358.3,25648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25648,1,3,0)
 ;;=3^Problems Related to Other Legal Circumstances
 ;;^UTILITY(U,$J,358.3,25648,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,25648,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,25649,0)
 ;;=Z65.1^^97^1214^2
 ;;^UTILITY(U,$J,358.3,25649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25649,1,3,0)
 ;;=3^Imprisonment or Other Incarceration
 ;;^UTILITY(U,$J,358.3,25649,1,4,0)
 ;;=4^Z65.1
 ;;^UTILITY(U,$J,358.3,25649,2)
 ;;=^5063180
 ;;^UTILITY(U,$J,358.3,25650,0)
 ;;=Z65.8^^97^1215^7
 ;;^UTILITY(U,$J,358.3,25650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25650,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,25650,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,25650,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,25651,0)
 ;;=Z64.0^^97^1215^6
 ;;^UTILITY(U,$J,358.3,25651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25651,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,25651,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,25651,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,25652,0)
 ;;=Z64.1^^97^1215^4
 ;;^UTILITY(U,$J,358.3,25652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25652,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,25652,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,25652,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,25653,0)
 ;;=Z64.4^^97^1215^1
 ;;^UTILITY(U,$J,358.3,25653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25653,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,25653,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,25653,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,25654,0)
 ;;=Z65.5^^97^1215^2
 ;;^UTILITY(U,$J,358.3,25654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25654,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,25654,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,25654,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,25655,0)
 ;;=Z65.8^^97^1215^5
 ;;^UTILITY(U,$J,358.3,25655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25655,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances,Other
 ;;^UTILITY(U,$J,358.3,25655,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,25655,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,25656,0)
 ;;=Z65.9^^97^1215^3
 ;;^UTILITY(U,$J,358.3,25656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25656,1,3,0)
 ;;=3^Problem Related to Psychosocial Circumstances,Unspec
 ;;^UTILITY(U,$J,358.3,25656,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,25656,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,25657,0)
 ;;=Z65.4^^97^1215^8
 ;;^UTILITY(U,$J,358.3,25657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25657,1,3,0)
 ;;=3^Victim of Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,25657,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,25657,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,25658,0)
 ;;=Z62.820^^97^1216^4
 ;;^UTILITY(U,$J,358.3,25658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25658,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,25658,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,25658,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,25659,0)
 ;;=Z62.891^^97^1216^6
 ;;^UTILITY(U,$J,358.3,25659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25659,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,25659,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,25659,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,25660,0)
 ;;=Z62.898^^97^1216^1
 ;;^UTILITY(U,$J,358.3,25660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25660,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
 ;;^UTILITY(U,$J,358.3,25660,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,25660,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,25661,0)
 ;;=Z63.0^^97^1216^5
 ;;^UTILITY(U,$J,358.3,25661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25661,1,3,0)
 ;;=3^Relationship Distress w/ Spouse/Partner
 ;;^UTILITY(U,$J,358.3,25661,1,4,0)
 ;;=4^Z63.0
 ;;^UTILITY(U,$J,358.3,25661,2)
 ;;=^5063164
 ;;^UTILITY(U,$J,358.3,25662,0)
 ;;=Z63.5^^97^1216^2
 ;;^UTILITY(U,$J,358.3,25662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25662,1,3,0)
 ;;=3^Disruption of Family by Separation or Divorce
 ;;^UTILITY(U,$J,358.3,25662,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,25662,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,25663,0)
 ;;=Z63.8^^97^1216^3
 ;;^UTILITY(U,$J,358.3,25663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25663,1,3,0)
 ;;=3^High Expressed Emotion Level w/in Family
 ;;^UTILITY(U,$J,358.3,25663,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,25663,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,25664,0)
 ;;=Z63.4^^97^1216^7
 ;;^UTILITY(U,$J,358.3,25664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25664,1,3,0)
 ;;=3^Uncomplicated Bereavement
 ;;^UTILITY(U,$J,358.3,25664,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,25664,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,25665,0)
 ;;=Z62.29^^97^1216^8
 ;;^UTILITY(U,$J,358.3,25665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25665,1,3,0)
 ;;=3^Upbringing Away from Parents
 ;;^UTILITY(U,$J,358.3,25665,1,4,0)
 ;;=4^Z62.29
