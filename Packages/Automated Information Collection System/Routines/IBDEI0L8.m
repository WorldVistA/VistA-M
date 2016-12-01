IBDEI0L8 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26858,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,26858,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,26858,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,26859,0)
 ;;=Z65.2^^71^1130^4
 ;;^UTILITY(U,$J,358.3,26859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26859,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,26859,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,26859,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,26860,0)
 ;;=Z65.3^^71^1130^3
 ;;^UTILITY(U,$J,358.3,26860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26860,1,3,0)
 ;;=3^Problems Related to Other Legal Circumstances
 ;;^UTILITY(U,$J,358.3,26860,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,26860,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,26861,0)
 ;;=Z65.1^^71^1130^2
 ;;^UTILITY(U,$J,358.3,26861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26861,1,3,0)
 ;;=3^Imprisonment or Other Incarceration
 ;;^UTILITY(U,$J,358.3,26861,1,4,0)
 ;;=4^Z65.1
 ;;^UTILITY(U,$J,358.3,26861,2)
 ;;=^5063180
 ;;^UTILITY(U,$J,358.3,26862,0)
 ;;=Z65.8^^71^1131^7
 ;;^UTILITY(U,$J,358.3,26862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26862,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,26862,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,26862,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,26863,0)
 ;;=Z64.0^^71^1131^6
 ;;^UTILITY(U,$J,358.3,26863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26863,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,26863,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,26863,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,26864,0)
 ;;=Z64.1^^71^1131^4
 ;;^UTILITY(U,$J,358.3,26864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26864,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,26864,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,26864,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,26865,0)
 ;;=Z64.4^^71^1131^1
 ;;^UTILITY(U,$J,358.3,26865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26865,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,26865,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,26865,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,26866,0)
 ;;=Z65.5^^71^1131^2
 ;;^UTILITY(U,$J,358.3,26866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26866,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,26866,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,26866,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,26867,0)
 ;;=Z65.8^^71^1131^5
 ;;^UTILITY(U,$J,358.3,26867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26867,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances,Other
 ;;^UTILITY(U,$J,358.3,26867,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,26867,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,26868,0)
 ;;=Z65.9^^71^1131^3
 ;;^UTILITY(U,$J,358.3,26868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26868,1,3,0)
 ;;=3^Problem Related to Psychosocial Circumstances,Unspec
 ;;^UTILITY(U,$J,358.3,26868,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,26868,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,26869,0)
 ;;=Z65.4^^71^1131^8
 ;;^UTILITY(U,$J,358.3,26869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26869,1,3,0)
 ;;=3^Victim of Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,26869,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,26869,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,26870,0)
 ;;=Z62.820^^71^1132^4
 ;;^UTILITY(U,$J,358.3,26870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26870,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,26870,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,26870,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,26871,0)
 ;;=Z62.891^^71^1132^6
 ;;^UTILITY(U,$J,358.3,26871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26871,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,26871,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,26871,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,26872,0)
 ;;=Z62.898^^71^1132^1
 ;;^UTILITY(U,$J,358.3,26872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26872,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
 ;;^UTILITY(U,$J,358.3,26872,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,26872,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,26873,0)
 ;;=Z63.0^^71^1132^5
 ;;^UTILITY(U,$J,358.3,26873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26873,1,3,0)
 ;;=3^Relationship Distress w/ Spouse/Partner
 ;;^UTILITY(U,$J,358.3,26873,1,4,0)
 ;;=4^Z63.0
 ;;^UTILITY(U,$J,358.3,26873,2)
 ;;=^5063164
 ;;^UTILITY(U,$J,358.3,26874,0)
 ;;=Z63.5^^71^1132^2
 ;;^UTILITY(U,$J,358.3,26874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26874,1,3,0)
 ;;=3^Disruption of Family by Separation or Divorce
 ;;^UTILITY(U,$J,358.3,26874,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,26874,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,26875,0)
 ;;=Z63.8^^71^1132^3
 ;;^UTILITY(U,$J,358.3,26875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26875,1,3,0)
 ;;=3^High Expressed Emotion Level w/in Family
 ;;^UTILITY(U,$J,358.3,26875,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,26875,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,26876,0)
 ;;=Z63.4^^71^1132^7
 ;;^UTILITY(U,$J,358.3,26876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26876,1,3,0)
 ;;=3^Uncomplicated Bereavement
 ;;^UTILITY(U,$J,358.3,26876,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,26876,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,26877,0)
 ;;=Z62.29^^71^1132^8
 ;;^UTILITY(U,$J,358.3,26877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26877,1,3,0)
 ;;=3^Upbringing Away from Parents
 ;;^UTILITY(U,$J,358.3,26877,1,4,0)
 ;;=4^Z62.29
 ;;^UTILITY(U,$J,358.3,26877,2)
 ;;=^5063150
 ;;^UTILITY(U,$J,358.3,26878,0)
 ;;=F20.9^^71^1133^11
 ;;^UTILITY(U,$J,358.3,26878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26878,1,3,0)
 ;;=3^Schizophrenia
 ;;^UTILITY(U,$J,358.3,26878,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,26878,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,26879,0)
 ;;=F20.81^^71^1133^14
 ;;^UTILITY(U,$J,358.3,26879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26879,1,3,0)
 ;;=3^Schizophreniform Disorder
 ;;^UTILITY(U,$J,358.3,26879,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,26879,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,26880,0)
 ;;=F22.^^71^1133^5
 ;;^UTILITY(U,$J,358.3,26880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26880,1,3,0)
 ;;=3^Delusional Disorder
 ;;^UTILITY(U,$J,358.3,26880,1,4,0)
 ;;=4^F22.
 ;;^UTILITY(U,$J,358.3,26880,2)
 ;;=^5003478
 ;;^UTILITY(U,$J,358.3,26881,0)
 ;;=F23.^^71^1133^1
 ;;^UTILITY(U,$J,358.3,26881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26881,1,3,0)
 ;;=3^Brief Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,26881,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,26881,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,26882,0)
 ;;=F25.0^^71^1133^9
 ;;^UTILITY(U,$J,358.3,26882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26882,1,3,0)
 ;;=3^Schizoaffective Disorder,Bipolar Type
 ;;^UTILITY(U,$J,358.3,26882,1,4,0)
 ;;=4^F25.0
 ;;^UTILITY(U,$J,358.3,26882,2)
 ;;=^5003480
 ;;^UTILITY(U,$J,358.3,26883,0)
 ;;=F25.1^^71^1133^10
 ;;^UTILITY(U,$J,358.3,26883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26883,1,3,0)
 ;;=3^Schizoaffective Disorder,Depressive Type
 ;;^UTILITY(U,$J,358.3,26883,1,4,0)
 ;;=4^F25.1
 ;;^UTILITY(U,$J,358.3,26883,2)
 ;;=^5003481
 ;;^UTILITY(U,$J,358.3,26884,0)
 ;;=F28.^^71^1133^12
 ;;^UTILITY(U,$J,358.3,26884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26884,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,26884,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,26884,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,26885,0)
 ;;=F29.^^71^1133^13
 ;;^UTILITY(U,$J,358.3,26885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26885,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26885,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,26885,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,26886,0)
 ;;=F06.1^^71^1133^2
 ;;^UTILITY(U,$J,358.3,26886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26886,1,3,0)
 ;;=3^Catatonia Associated w/ Another Mental Disorder
 ;;^UTILITY(U,$J,358.3,26886,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,26886,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,26887,0)
 ;;=F06.1^^71^1133^4
 ;;^UTILITY(U,$J,358.3,26887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26887,1,3,0)
 ;;=3^Catatonic Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,26887,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,26887,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,26888,0)
 ;;=F06.1^^71^1133^3
 ;;^UTILITY(U,$J,358.3,26888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26888,1,3,0)
 ;;=3^Catatonia,Unspec
 ;;^UTILITY(U,$J,358.3,26888,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,26888,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,26889,0)
 ;;=R29.818^^71^1133^6
 ;;^UTILITY(U,$J,358.3,26889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26889,1,3,0)
 ;;=3^Nervous & Musculoskeletal System Symptoms,Other
 ;;^UTILITY(U,$J,358.3,26889,1,4,0)
 ;;=4^R29.818
 ;;^UTILITY(U,$J,358.3,26889,2)
 ;;=^5019318
 ;;^UTILITY(U,$J,358.3,26890,0)
 ;;=F06.2^^71^1133^7
 ;;^UTILITY(U,$J,358.3,26890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26890,1,3,0)
 ;;=3^Psychotic Disorder d/t Another Med Cond w/ Delusions
 ;;^UTILITY(U,$J,358.3,26890,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,26890,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,26891,0)
 ;;=F06.0^^71^1133^8
 ;;^UTILITY(U,$J,358.3,26891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26891,1,3,0)
 ;;=3^Psychotic Disorder d/t Another Med Cond w/ Hallucinations
 ;;^UTILITY(U,$J,358.3,26891,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,26891,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,26892,0)
 ;;=F52.32^^71^1134^1
 ;;^UTILITY(U,$J,358.3,26892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26892,1,3,0)
 ;;=3^Delayed Ejaculation
 ;;^UTILITY(U,$J,358.3,26892,1,4,0)
 ;;=4^F52.32
 ;;^UTILITY(U,$J,358.3,26892,2)
 ;;=^331927
