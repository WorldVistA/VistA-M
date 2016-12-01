IBDEI0J6 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24304,0)
 ;;=F60.6^^64^963^2
 ;;^UTILITY(U,$J,358.3,24304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24304,1,3,0)
 ;;=3^Avoidant Personality Disorder
 ;;^UTILITY(U,$J,358.3,24304,1,4,0)
 ;;=4^F60.6
 ;;^UTILITY(U,$J,358.3,24304,2)
 ;;=^331920
 ;;^UTILITY(U,$J,358.3,24305,0)
 ;;=F60.3^^64^963^3
 ;;^UTILITY(U,$J,358.3,24305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24305,1,3,0)
 ;;=3^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,24305,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,24305,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,24306,0)
 ;;=F60.89^^64^963^10
 ;;^UTILITY(U,$J,358.3,24306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24306,1,3,0)
 ;;=3^Personality Disorder,Other
 ;;^UTILITY(U,$J,358.3,24306,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,24306,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,24307,0)
 ;;=F60.9^^64^963^11
 ;;^UTILITY(U,$J,358.3,24307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24307,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24307,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,24307,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,24308,0)
 ;;=F07.0^^64^963^9
 ;;^UTILITY(U,$J,358.3,24308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24308,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,24308,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,24308,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,24309,0)
 ;;=Z65.4^^64^964^5
 ;;^UTILITY(U,$J,358.3,24309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24309,1,3,0)
 ;;=3^Victim of Crime
 ;;^UTILITY(U,$J,358.3,24309,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,24309,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,24310,0)
 ;;=Z65.0^^64^964^1
 ;;^UTILITY(U,$J,358.3,24310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24310,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,24310,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,24310,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,24311,0)
 ;;=Z65.2^^64^964^4
 ;;^UTILITY(U,$J,358.3,24311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24311,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,24311,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,24311,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,24312,0)
 ;;=Z65.3^^64^964^3
 ;;^UTILITY(U,$J,358.3,24312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24312,1,3,0)
 ;;=3^Problems Related to Other Legal Circumstances
 ;;^UTILITY(U,$J,358.3,24312,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,24312,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,24313,0)
 ;;=Z65.1^^64^964^2
 ;;^UTILITY(U,$J,358.3,24313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24313,1,3,0)
 ;;=3^Imprisonment or Other Incarceration
 ;;^UTILITY(U,$J,358.3,24313,1,4,0)
 ;;=4^Z65.1
 ;;^UTILITY(U,$J,358.3,24313,2)
 ;;=^5063180
 ;;^UTILITY(U,$J,358.3,24314,0)
 ;;=Z65.8^^64^965^7
 ;;^UTILITY(U,$J,358.3,24314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24314,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,24314,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,24314,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,24315,0)
 ;;=Z64.0^^64^965^6
 ;;^UTILITY(U,$J,358.3,24315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24315,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,24315,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,24315,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,24316,0)
 ;;=Z64.1^^64^965^4
 ;;^UTILITY(U,$J,358.3,24316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24316,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,24316,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,24316,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,24317,0)
 ;;=Z64.4^^64^965^1
 ;;^UTILITY(U,$J,358.3,24317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24317,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,24317,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,24317,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,24318,0)
 ;;=Z65.5^^64^965^2
 ;;^UTILITY(U,$J,358.3,24318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24318,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,24318,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,24318,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,24319,0)
 ;;=Z65.8^^64^965^5
 ;;^UTILITY(U,$J,358.3,24319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24319,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances,Other
 ;;^UTILITY(U,$J,358.3,24319,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,24319,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,24320,0)
 ;;=Z65.9^^64^965^3
 ;;^UTILITY(U,$J,358.3,24320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24320,1,3,0)
 ;;=3^Problem Related to Psychosocial Circumstances,Unspec
 ;;^UTILITY(U,$J,358.3,24320,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,24320,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,24321,0)
 ;;=Z65.4^^64^965^8
 ;;^UTILITY(U,$J,358.3,24321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24321,1,3,0)
 ;;=3^Victim of Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,24321,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,24321,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,24322,0)
 ;;=Z62.820^^64^966^4
 ;;^UTILITY(U,$J,358.3,24322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24322,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,24322,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,24322,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,24323,0)
 ;;=Z62.891^^64^966^6
 ;;^UTILITY(U,$J,358.3,24323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24323,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,24323,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,24323,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,24324,0)
 ;;=Z62.898^^64^966^1
 ;;^UTILITY(U,$J,358.3,24324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24324,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
 ;;^UTILITY(U,$J,358.3,24324,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,24324,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,24325,0)
 ;;=Z63.0^^64^966^5
 ;;^UTILITY(U,$J,358.3,24325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24325,1,3,0)
 ;;=3^Relationship Distress w/ Spouse/Partner
 ;;^UTILITY(U,$J,358.3,24325,1,4,0)
 ;;=4^Z63.0
 ;;^UTILITY(U,$J,358.3,24325,2)
 ;;=^5063164
 ;;^UTILITY(U,$J,358.3,24326,0)
 ;;=Z63.5^^64^966^2
 ;;^UTILITY(U,$J,358.3,24326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24326,1,3,0)
 ;;=3^Disruption of Family by Separation or Divorce
 ;;^UTILITY(U,$J,358.3,24326,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,24326,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,24327,0)
 ;;=Z63.8^^64^966^3
 ;;^UTILITY(U,$J,358.3,24327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24327,1,3,0)
 ;;=3^High Expressed Emotion Level w/in Family
 ;;^UTILITY(U,$J,358.3,24327,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,24327,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,24328,0)
 ;;=Z63.4^^64^966^7
 ;;^UTILITY(U,$J,358.3,24328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24328,1,3,0)
 ;;=3^Uncomplicated Bereavement
 ;;^UTILITY(U,$J,358.3,24328,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,24328,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,24329,0)
 ;;=Z62.29^^64^966^8
 ;;^UTILITY(U,$J,358.3,24329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24329,1,3,0)
 ;;=3^Upbringing Away from Parents
 ;;^UTILITY(U,$J,358.3,24329,1,4,0)
 ;;=4^Z62.29
 ;;^UTILITY(U,$J,358.3,24329,2)
 ;;=^5063150
 ;;^UTILITY(U,$J,358.3,24330,0)
 ;;=F20.9^^64^967^11
 ;;^UTILITY(U,$J,358.3,24330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24330,1,3,0)
 ;;=3^Schizophrenia
 ;;^UTILITY(U,$J,358.3,24330,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,24330,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,24331,0)
 ;;=F20.81^^64^967^14
 ;;^UTILITY(U,$J,358.3,24331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24331,1,3,0)
 ;;=3^Schizophreniform Disorder
 ;;^UTILITY(U,$J,358.3,24331,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,24331,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,24332,0)
 ;;=F22.^^64^967^5
 ;;^UTILITY(U,$J,358.3,24332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24332,1,3,0)
 ;;=3^Delusional Disorder
 ;;^UTILITY(U,$J,358.3,24332,1,4,0)
 ;;=4^F22.
 ;;^UTILITY(U,$J,358.3,24332,2)
 ;;=^5003478
 ;;^UTILITY(U,$J,358.3,24333,0)
 ;;=F23.^^64^967^1
 ;;^UTILITY(U,$J,358.3,24333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24333,1,3,0)
 ;;=3^Brief Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,24333,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,24333,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,24334,0)
 ;;=F25.0^^64^967^9
 ;;^UTILITY(U,$J,358.3,24334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24334,1,3,0)
 ;;=3^Schizoaffective Disorder,Bipolar Type
 ;;^UTILITY(U,$J,358.3,24334,1,4,0)
 ;;=4^F25.0
 ;;^UTILITY(U,$J,358.3,24334,2)
 ;;=^5003480
 ;;^UTILITY(U,$J,358.3,24335,0)
 ;;=F25.1^^64^967^10
 ;;^UTILITY(U,$J,358.3,24335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24335,1,3,0)
 ;;=3^Schizoaffective Disorder,Depressive Type
 ;;^UTILITY(U,$J,358.3,24335,1,4,0)
 ;;=4^F25.1
 ;;^UTILITY(U,$J,358.3,24335,2)
 ;;=^5003481
 ;;^UTILITY(U,$J,358.3,24336,0)
 ;;=F28.^^64^967^12
 ;;^UTILITY(U,$J,358.3,24336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24336,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,24336,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,24336,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,24337,0)
 ;;=F29.^^64^967^13
 ;;^UTILITY(U,$J,358.3,24337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24337,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24337,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,24337,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,24338,0)
 ;;=F06.1^^64^967^2
 ;;^UTILITY(U,$J,358.3,24338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24338,1,3,0)
 ;;=3^Catatonia Associated w/ Another Mental Disorder
 ;;^UTILITY(U,$J,358.3,24338,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,24338,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,24339,0)
 ;;=F06.1^^64^967^4
