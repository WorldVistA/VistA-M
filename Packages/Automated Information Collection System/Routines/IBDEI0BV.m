IBDEI0BV ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15057,2)
 ;;=^331920
 ;;^UTILITY(U,$J,358.3,15058,0)
 ;;=F60.3^^45^670^3
 ;;^UTILITY(U,$J,358.3,15058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15058,1,3,0)
 ;;=3^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,15058,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,15058,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,15059,0)
 ;;=F60.89^^45^670^10
 ;;^UTILITY(U,$J,358.3,15059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15059,1,3,0)
 ;;=3^Personality Disorder,Other
 ;;^UTILITY(U,$J,358.3,15059,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,15059,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,15060,0)
 ;;=F60.9^^45^670^11
 ;;^UTILITY(U,$J,358.3,15060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15060,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15060,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,15060,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,15061,0)
 ;;=F07.0^^45^670^9
 ;;^UTILITY(U,$J,358.3,15061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15061,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,15061,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,15061,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,15062,0)
 ;;=Z65.4^^45^671^5
 ;;^UTILITY(U,$J,358.3,15062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15062,1,3,0)
 ;;=3^Victim of Crime
 ;;^UTILITY(U,$J,358.3,15062,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,15062,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,15063,0)
 ;;=Z65.0^^45^671^1
 ;;^UTILITY(U,$J,358.3,15063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15063,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,15063,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,15063,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,15064,0)
 ;;=Z65.2^^45^671^4
 ;;^UTILITY(U,$J,358.3,15064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15064,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,15064,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,15064,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,15065,0)
 ;;=Z65.3^^45^671^3
 ;;^UTILITY(U,$J,358.3,15065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15065,1,3,0)
 ;;=3^Problems Related to Other Legal Circumstances
 ;;^UTILITY(U,$J,358.3,15065,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,15065,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,15066,0)
 ;;=Z65.1^^45^671^2
 ;;^UTILITY(U,$J,358.3,15066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15066,1,3,0)
 ;;=3^Imprisonment or Other Incarceration
 ;;^UTILITY(U,$J,358.3,15066,1,4,0)
 ;;=4^Z65.1
 ;;^UTILITY(U,$J,358.3,15066,2)
 ;;=^5063180
 ;;^UTILITY(U,$J,358.3,15067,0)
 ;;=Z65.8^^45^672^7
 ;;^UTILITY(U,$J,358.3,15067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15067,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,15067,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,15067,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,15068,0)
 ;;=Z64.0^^45^672^6
 ;;^UTILITY(U,$J,358.3,15068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15068,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,15068,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,15068,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,15069,0)
 ;;=Z64.1^^45^672^4
 ;;^UTILITY(U,$J,358.3,15069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15069,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,15069,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,15069,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,15070,0)
 ;;=Z64.4^^45^672^1
 ;;^UTILITY(U,$J,358.3,15070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15070,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,15070,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,15070,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,15071,0)
 ;;=Z65.5^^45^672^2
 ;;^UTILITY(U,$J,358.3,15071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15071,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,15071,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,15071,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,15072,0)
 ;;=Z65.8^^45^672^5
 ;;^UTILITY(U,$J,358.3,15072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15072,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances,Other
 ;;^UTILITY(U,$J,358.3,15072,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,15072,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,15073,0)
 ;;=Z65.9^^45^672^3
 ;;^UTILITY(U,$J,358.3,15073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15073,1,3,0)
 ;;=3^Problem Related to Psychosocial Circumstances,Unspec
 ;;^UTILITY(U,$J,358.3,15073,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,15073,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,15074,0)
 ;;=Z65.4^^45^672^8
 ;;^UTILITY(U,$J,358.3,15074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15074,1,3,0)
 ;;=3^Victim of Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,15074,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,15074,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,15075,0)
 ;;=Z62.820^^45^673^4
 ;;^UTILITY(U,$J,358.3,15075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15075,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,15075,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,15075,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,15076,0)
 ;;=Z62.891^^45^673^6
 ;;^UTILITY(U,$J,358.3,15076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15076,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,15076,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,15076,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,15077,0)
 ;;=Z62.898^^45^673^1
 ;;^UTILITY(U,$J,358.3,15077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15077,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
 ;;^UTILITY(U,$J,358.3,15077,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,15077,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,15078,0)
 ;;=Z63.0^^45^673^5
 ;;^UTILITY(U,$J,358.3,15078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15078,1,3,0)
 ;;=3^Relationship Distress w/ Spouse/Partner
 ;;^UTILITY(U,$J,358.3,15078,1,4,0)
 ;;=4^Z63.0
 ;;^UTILITY(U,$J,358.3,15078,2)
 ;;=^5063164
 ;;^UTILITY(U,$J,358.3,15079,0)
 ;;=Z63.5^^45^673^2
 ;;^UTILITY(U,$J,358.3,15079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15079,1,3,0)
 ;;=3^Disruption of Family by Separation or Divorce
 ;;^UTILITY(U,$J,358.3,15079,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,15079,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,15080,0)
 ;;=Z63.8^^45^673^3
 ;;^UTILITY(U,$J,358.3,15080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15080,1,3,0)
 ;;=3^High Expressed Emotion Level w/in Family
 ;;^UTILITY(U,$J,358.3,15080,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,15080,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,15081,0)
 ;;=Z63.4^^45^673^7
 ;;^UTILITY(U,$J,358.3,15081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15081,1,3,0)
 ;;=3^Uncomplicated Bereavement
 ;;^UTILITY(U,$J,358.3,15081,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,15081,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,15082,0)
 ;;=Z62.29^^45^673^8
 ;;^UTILITY(U,$J,358.3,15082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15082,1,3,0)
 ;;=3^Upbringing Away from Parents
 ;;^UTILITY(U,$J,358.3,15082,1,4,0)
 ;;=4^Z62.29
 ;;^UTILITY(U,$J,358.3,15082,2)
 ;;=^5063150
 ;;^UTILITY(U,$J,358.3,15083,0)
 ;;=F20.9^^45^674^11
 ;;^UTILITY(U,$J,358.3,15083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15083,1,3,0)
 ;;=3^Schizophrenia
 ;;^UTILITY(U,$J,358.3,15083,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,15083,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,15084,0)
 ;;=F20.81^^45^674^14
 ;;^UTILITY(U,$J,358.3,15084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15084,1,3,0)
 ;;=3^Schizophreniform Disorder
 ;;^UTILITY(U,$J,358.3,15084,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,15084,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,15085,0)
 ;;=F22.^^45^674^5
 ;;^UTILITY(U,$J,358.3,15085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15085,1,3,0)
 ;;=3^Delusional Disorder
 ;;^UTILITY(U,$J,358.3,15085,1,4,0)
 ;;=4^F22.
 ;;^UTILITY(U,$J,358.3,15085,2)
 ;;=^5003478
 ;;^UTILITY(U,$J,358.3,15086,0)
 ;;=F23.^^45^674^1
 ;;^UTILITY(U,$J,358.3,15086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15086,1,3,0)
 ;;=3^Brief Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,15086,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,15086,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,15087,0)
 ;;=F25.0^^45^674^9
 ;;^UTILITY(U,$J,358.3,15087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15087,1,3,0)
 ;;=3^Schizoaffective Disorder,Bipolar Type
 ;;^UTILITY(U,$J,358.3,15087,1,4,0)
 ;;=4^F25.0
 ;;^UTILITY(U,$J,358.3,15087,2)
 ;;=^5003480
 ;;^UTILITY(U,$J,358.3,15088,0)
 ;;=F25.1^^45^674^10
 ;;^UTILITY(U,$J,358.3,15088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15088,1,3,0)
 ;;=3^Schizoaffective Disorder,Depressive Type
 ;;^UTILITY(U,$J,358.3,15088,1,4,0)
 ;;=4^F25.1
 ;;^UTILITY(U,$J,358.3,15088,2)
 ;;=^5003481
 ;;^UTILITY(U,$J,358.3,15089,0)
 ;;=F28.^^45^674^12
 ;;^UTILITY(U,$J,358.3,15089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15089,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,15089,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,15089,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,15090,0)
 ;;=F29.^^45^674^13
 ;;^UTILITY(U,$J,358.3,15090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15090,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15090,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,15090,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,15091,0)
 ;;=F06.1^^45^674^2
 ;;^UTILITY(U,$J,358.3,15091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15091,1,3,0)
 ;;=3^Catatonia Associated w/ Another Mental Disorder
 ;;^UTILITY(U,$J,358.3,15091,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,15091,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,15092,0)
 ;;=F06.1^^45^674^4
 ;;^UTILITY(U,$J,358.3,15092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15092,1,3,0)
 ;;=3^Catatonic Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,15092,1,4,0)
 ;;=4^F06.1
