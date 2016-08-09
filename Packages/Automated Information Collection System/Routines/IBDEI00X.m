IBDEI00X ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,395,1,4,0)
 ;;=4^F60.0
 ;;^UTILITY(U,$J,358.3,395,2)
 ;;=^5003635
 ;;^UTILITY(U,$J,358.3,396,0)
 ;;=F60.1^^3^39^12
 ;;^UTILITY(U,$J,358.3,396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,396,1,3,0)
 ;;=3^Schizoid Personality Disorder
 ;;^UTILITY(U,$J,358.3,396,1,4,0)
 ;;=4^F60.1
 ;;^UTILITY(U,$J,358.3,396,2)
 ;;=^108271
 ;;^UTILITY(U,$J,358.3,397,0)
 ;;=F21.^^3^39^13
 ;;^UTILITY(U,$J,358.3,397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,397,1,3,0)
 ;;=3^Schizotypal Personality Disorder
 ;;^UTILITY(U,$J,358.3,397,1,4,0)
 ;;=4^F21.
 ;;^UTILITY(U,$J,358.3,397,2)
 ;;=^5003477
 ;;^UTILITY(U,$J,358.3,398,0)
 ;;=F60.5^^3^39^7
 ;;^UTILITY(U,$J,358.3,398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,398,1,3,0)
 ;;=3^Obsessive-Compulsive Personality Disorder
 ;;^UTILITY(U,$J,358.3,398,1,4,0)
 ;;=4^F60.5
 ;;^UTILITY(U,$J,358.3,398,2)
 ;;=^331918
 ;;^UTILITY(U,$J,358.3,399,0)
 ;;=F60.4^^3^39^5
 ;;^UTILITY(U,$J,358.3,399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,399,1,3,0)
 ;;=3^Histrionic Personality Disorder
 ;;^UTILITY(U,$J,358.3,399,1,4,0)
 ;;=4^F60.4
 ;;^UTILITY(U,$J,358.3,399,2)
 ;;=^5003636
 ;;^UTILITY(U,$J,358.3,400,0)
 ;;=F60.7^^3^39^4
 ;;^UTILITY(U,$J,358.3,400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,400,1,3,0)
 ;;=3^Dependent Personality Disorder
 ;;^UTILITY(U,$J,358.3,400,1,4,0)
 ;;=4^F60.7
 ;;^UTILITY(U,$J,358.3,400,2)
 ;;=^5003637
 ;;^UTILITY(U,$J,358.3,401,0)
 ;;=F60.2^^3^39^1
 ;;^UTILITY(U,$J,358.3,401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,401,1,3,0)
 ;;=3^Antisocial Personality Disorder
 ;;^UTILITY(U,$J,358.3,401,1,4,0)
 ;;=4^F60.2
 ;;^UTILITY(U,$J,358.3,401,2)
 ;;=^9066
 ;;^UTILITY(U,$J,358.3,402,0)
 ;;=F60.81^^3^39^6
 ;;^UTILITY(U,$J,358.3,402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,402,1,3,0)
 ;;=3^Narcissistic Personality Disorder
 ;;^UTILITY(U,$J,358.3,402,1,4,0)
 ;;=4^F60.81
 ;;^UTILITY(U,$J,358.3,402,2)
 ;;=^331919
 ;;^UTILITY(U,$J,358.3,403,0)
 ;;=F60.6^^3^39^2
 ;;^UTILITY(U,$J,358.3,403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,403,1,3,0)
 ;;=3^Avoidant Personality Disorder
 ;;^UTILITY(U,$J,358.3,403,1,4,0)
 ;;=4^F60.6
 ;;^UTILITY(U,$J,358.3,403,2)
 ;;=^331920
 ;;^UTILITY(U,$J,358.3,404,0)
 ;;=F60.3^^3^39^3
 ;;^UTILITY(U,$J,358.3,404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,404,1,3,0)
 ;;=3^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,404,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,404,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,405,0)
 ;;=F60.89^^3^39^10
 ;;^UTILITY(U,$J,358.3,405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,405,1,3,0)
 ;;=3^Personality Disorder,Other
 ;;^UTILITY(U,$J,358.3,405,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,405,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,406,0)
 ;;=F60.9^^3^39^11
 ;;^UTILITY(U,$J,358.3,406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,406,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,406,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,406,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,407,0)
 ;;=F07.0^^3^39^9
 ;;^UTILITY(U,$J,358.3,407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,407,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,407,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,407,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,408,0)
 ;;=Z65.4^^3^40^5
 ;;^UTILITY(U,$J,358.3,408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,408,1,3,0)
 ;;=3^Victim of Crime
 ;;^UTILITY(U,$J,358.3,408,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,408,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,409,0)
 ;;=Z65.0^^3^40^1
 ;;^UTILITY(U,$J,358.3,409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,409,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,409,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,409,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,410,0)
 ;;=Z65.2^^3^40^4
 ;;^UTILITY(U,$J,358.3,410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,410,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,410,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,410,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,411,0)
 ;;=Z65.3^^3^40^3
 ;;^UTILITY(U,$J,358.3,411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,411,1,3,0)
 ;;=3^Problems Related to Other Legal Circumstances
 ;;^UTILITY(U,$J,358.3,411,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,411,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,412,0)
 ;;=Z65.1^^3^40^2
 ;;^UTILITY(U,$J,358.3,412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,412,1,3,0)
 ;;=3^Imprisonment or Other Incarceration
 ;;^UTILITY(U,$J,358.3,412,1,4,0)
 ;;=4^Z65.1
 ;;^UTILITY(U,$J,358.3,412,2)
 ;;=^5063180
 ;;^UTILITY(U,$J,358.3,413,0)
 ;;=Z65.8^^3^41^7
 ;;^UTILITY(U,$J,358.3,413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,413,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,413,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,413,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,414,0)
 ;;=Z64.0^^3^41^6
 ;;^UTILITY(U,$J,358.3,414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,414,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,414,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,414,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,415,0)
 ;;=Z64.1^^3^41^4
 ;;^UTILITY(U,$J,358.3,415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,415,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,415,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,415,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,416,0)
 ;;=Z64.4^^3^41^1
 ;;^UTILITY(U,$J,358.3,416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,416,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,416,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,416,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,417,0)
 ;;=Z65.5^^3^41^2
 ;;^UTILITY(U,$J,358.3,417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,417,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,417,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,417,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,418,0)
 ;;=Z65.8^^3^41^5
 ;;^UTILITY(U,$J,358.3,418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,418,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances,Other
 ;;^UTILITY(U,$J,358.3,418,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,418,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,419,0)
 ;;=Z65.9^^3^41^3
 ;;^UTILITY(U,$J,358.3,419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,419,1,3,0)
 ;;=3^Problem Related to Psychosocial Circumstances,Unspec
 ;;^UTILITY(U,$J,358.3,419,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,419,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,420,0)
 ;;=Z65.4^^3^41^8
 ;;^UTILITY(U,$J,358.3,420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,420,1,3,0)
 ;;=3^Victim of Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,420,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,420,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,421,0)
 ;;=Z62.820^^3^42^4
 ;;^UTILITY(U,$J,358.3,421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,421,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,421,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,421,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,422,0)
 ;;=Z62.891^^3^42^6
 ;;^UTILITY(U,$J,358.3,422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,422,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,422,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,422,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,423,0)
 ;;=Z62.898^^3^42^1
 ;;^UTILITY(U,$J,358.3,423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,423,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
 ;;^UTILITY(U,$J,358.3,423,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,423,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,424,0)
 ;;=Z63.0^^3^42^5
 ;;^UTILITY(U,$J,358.3,424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,424,1,3,0)
 ;;=3^Relationship Distress w/ Spouse/Partner
