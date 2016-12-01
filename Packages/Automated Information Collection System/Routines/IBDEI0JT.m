IBDEI0JT ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25088,1,3,0)
 ;;=3^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,25088,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,25088,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,25089,0)
 ;;=F60.89^^66^1009^10
 ;;^UTILITY(U,$J,358.3,25089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25089,1,3,0)
 ;;=3^Personality Disorder,Other
 ;;^UTILITY(U,$J,358.3,25089,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,25089,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,25090,0)
 ;;=F60.9^^66^1009^11
 ;;^UTILITY(U,$J,358.3,25090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25090,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25090,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,25090,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,25091,0)
 ;;=F07.0^^66^1009^9
 ;;^UTILITY(U,$J,358.3,25091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25091,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,25091,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,25091,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,25092,0)
 ;;=Z65.4^^66^1010^5
 ;;^UTILITY(U,$J,358.3,25092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25092,1,3,0)
 ;;=3^Victim of Crime
 ;;^UTILITY(U,$J,358.3,25092,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,25092,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,25093,0)
 ;;=Z65.0^^66^1010^1
 ;;^UTILITY(U,$J,358.3,25093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25093,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,25093,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,25093,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,25094,0)
 ;;=Z65.2^^66^1010^4
 ;;^UTILITY(U,$J,358.3,25094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25094,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,25094,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,25094,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,25095,0)
 ;;=Z65.3^^66^1010^3
 ;;^UTILITY(U,$J,358.3,25095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25095,1,3,0)
 ;;=3^Problems Related to Other Legal Circumstances
 ;;^UTILITY(U,$J,358.3,25095,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,25095,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,25096,0)
 ;;=Z65.1^^66^1010^2
 ;;^UTILITY(U,$J,358.3,25096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25096,1,3,0)
 ;;=3^Imprisonment or Other Incarceration
 ;;^UTILITY(U,$J,358.3,25096,1,4,0)
 ;;=4^Z65.1
 ;;^UTILITY(U,$J,358.3,25096,2)
 ;;=^5063180
 ;;^UTILITY(U,$J,358.3,25097,0)
 ;;=Z65.8^^66^1011^7
 ;;^UTILITY(U,$J,358.3,25097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25097,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,25097,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,25097,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,25098,0)
 ;;=Z64.0^^66^1011^6
 ;;^UTILITY(U,$J,358.3,25098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25098,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,25098,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,25098,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,25099,0)
 ;;=Z64.1^^66^1011^4
 ;;^UTILITY(U,$J,358.3,25099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25099,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,25099,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,25099,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,25100,0)
 ;;=Z64.4^^66^1011^1
 ;;^UTILITY(U,$J,358.3,25100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25100,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,25100,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,25100,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,25101,0)
 ;;=Z65.5^^66^1011^2
 ;;^UTILITY(U,$J,358.3,25101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25101,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,25101,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,25101,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,25102,0)
 ;;=Z65.8^^66^1011^5
 ;;^UTILITY(U,$J,358.3,25102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25102,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances,Other
 ;;^UTILITY(U,$J,358.3,25102,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,25102,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,25103,0)
 ;;=Z65.9^^66^1011^3
 ;;^UTILITY(U,$J,358.3,25103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25103,1,3,0)
 ;;=3^Problem Related to Psychosocial Circumstances,Unspec
 ;;^UTILITY(U,$J,358.3,25103,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,25103,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,25104,0)
 ;;=Z65.4^^66^1011^8
 ;;^UTILITY(U,$J,358.3,25104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25104,1,3,0)
 ;;=3^Victim of Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,25104,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,25104,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,25105,0)
 ;;=Z62.820^^66^1012^4
 ;;^UTILITY(U,$J,358.3,25105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25105,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,25105,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,25105,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,25106,0)
 ;;=Z62.891^^66^1012^6
 ;;^UTILITY(U,$J,358.3,25106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25106,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,25106,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,25106,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,25107,0)
 ;;=Z62.898^^66^1012^1
 ;;^UTILITY(U,$J,358.3,25107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25107,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
 ;;^UTILITY(U,$J,358.3,25107,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,25107,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,25108,0)
 ;;=Z63.0^^66^1012^5
 ;;^UTILITY(U,$J,358.3,25108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25108,1,3,0)
 ;;=3^Relationship Distress w/ Spouse/Partner
 ;;^UTILITY(U,$J,358.3,25108,1,4,0)
 ;;=4^Z63.0
 ;;^UTILITY(U,$J,358.3,25108,2)
 ;;=^5063164
 ;;^UTILITY(U,$J,358.3,25109,0)
 ;;=Z63.5^^66^1012^2
 ;;^UTILITY(U,$J,358.3,25109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25109,1,3,0)
 ;;=3^Disruption of Family by Separation or Divorce
 ;;^UTILITY(U,$J,358.3,25109,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,25109,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,25110,0)
 ;;=Z63.8^^66^1012^3
 ;;^UTILITY(U,$J,358.3,25110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25110,1,3,0)
 ;;=3^High Expressed Emotion Level w/in Family
 ;;^UTILITY(U,$J,358.3,25110,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,25110,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,25111,0)
 ;;=Z63.4^^66^1012^7
 ;;^UTILITY(U,$J,358.3,25111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25111,1,3,0)
 ;;=3^Uncomplicated Bereavement
 ;;^UTILITY(U,$J,358.3,25111,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,25111,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,25112,0)
 ;;=Z62.29^^66^1012^8
 ;;^UTILITY(U,$J,358.3,25112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25112,1,3,0)
 ;;=3^Upbringing Away from Parents
 ;;^UTILITY(U,$J,358.3,25112,1,4,0)
 ;;=4^Z62.29
 ;;^UTILITY(U,$J,358.3,25112,2)
 ;;=^5063150
 ;;^UTILITY(U,$J,358.3,25113,0)
 ;;=F20.9^^66^1013^11
 ;;^UTILITY(U,$J,358.3,25113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25113,1,3,0)
 ;;=3^Schizophrenia
 ;;^UTILITY(U,$J,358.3,25113,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,25113,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,25114,0)
 ;;=F20.81^^66^1013^14
 ;;^UTILITY(U,$J,358.3,25114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25114,1,3,0)
 ;;=3^Schizophreniform Disorder
 ;;^UTILITY(U,$J,358.3,25114,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,25114,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,25115,0)
 ;;=F22.^^66^1013^5
 ;;^UTILITY(U,$J,358.3,25115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25115,1,3,0)
 ;;=3^Delusional Disorder
 ;;^UTILITY(U,$J,358.3,25115,1,4,0)
 ;;=4^F22.
 ;;^UTILITY(U,$J,358.3,25115,2)
 ;;=^5003478
 ;;^UTILITY(U,$J,358.3,25116,0)
 ;;=F23.^^66^1013^1
 ;;^UTILITY(U,$J,358.3,25116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25116,1,3,0)
 ;;=3^Brief Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,25116,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,25116,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,25117,0)
 ;;=F25.0^^66^1013^9
 ;;^UTILITY(U,$J,358.3,25117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25117,1,3,0)
 ;;=3^Schizoaffective Disorder,Bipolar Type
 ;;^UTILITY(U,$J,358.3,25117,1,4,0)
 ;;=4^F25.0
 ;;^UTILITY(U,$J,358.3,25117,2)
 ;;=^5003480
 ;;^UTILITY(U,$J,358.3,25118,0)
 ;;=F25.1^^66^1013^10
 ;;^UTILITY(U,$J,358.3,25118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25118,1,3,0)
 ;;=3^Schizoaffective Disorder,Depressive Type
 ;;^UTILITY(U,$J,358.3,25118,1,4,0)
 ;;=4^F25.1
 ;;^UTILITY(U,$J,358.3,25118,2)
 ;;=^5003481
 ;;^UTILITY(U,$J,358.3,25119,0)
 ;;=F28.^^66^1013^12
 ;;^UTILITY(U,$J,358.3,25119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25119,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,25119,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,25119,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,25120,0)
 ;;=F29.^^66^1013^13
 ;;^UTILITY(U,$J,358.3,25120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25120,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25120,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,25120,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,25121,0)
 ;;=F06.1^^66^1013^2
 ;;^UTILITY(U,$J,358.3,25121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25121,1,3,0)
 ;;=3^Catatonia Associated w/ Another Mental Disorder
 ;;^UTILITY(U,$J,358.3,25121,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,25121,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,25122,0)
 ;;=F06.1^^66^1013^4
 ;;^UTILITY(U,$J,358.3,25122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25122,1,3,0)
 ;;=3^Catatonic Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,25122,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,25122,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,25123,0)
 ;;=F06.1^^66^1013^3
 ;;^UTILITY(U,$J,358.3,25123,1,0)
 ;;=^358.31IA^4^2
