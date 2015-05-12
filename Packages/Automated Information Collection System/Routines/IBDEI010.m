IBDEI010 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,990,1,4,0)
 ;;=4^F50.01
 ;;^UTILITY(U,$J,358.3,990,2)
 ;;=^5003598
 ;;^UTILITY(U,$J,358.3,991,0)
 ;;=F50.9^^3^28^7
 ;;^UTILITY(U,$J,358.3,991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,991,1,3,0)
 ;;=3^Unspec Feeding/Eating Disorder
 ;;^UTILITY(U,$J,358.3,991,1,4,0)
 ;;=4^F50.9
 ;;^UTILITY(U,$J,358.3,991,2)
 ;;=^5003602
 ;;^UTILITY(U,$J,358.3,992,0)
 ;;=F50.8^^3^28^6
 ;;^UTILITY(U,$J,358.3,992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,992,1,3,0)
 ;;=3^Other Spec Feeding/Eating Disorder
 ;;^UTILITY(U,$J,358.3,992,1,4,0)
 ;;=4^F50.8
 ;;^UTILITY(U,$J,358.3,992,2)
 ;;=^5003601
 ;;^UTILITY(U,$J,358.3,993,0)
 ;;=F50.8^^3^28^3
 ;;^UTILITY(U,$J,358.3,993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,993,1,3,0)
 ;;=3^Avoidant/Restrictive Food Intake Disorder
 ;;^UTILITY(U,$J,358.3,993,1,4,0)
 ;;=4^F50.8
 ;;^UTILITY(U,$J,358.3,993,2)
 ;;=^5003601
 ;;^UTILITY(U,$J,358.3,994,0)
 ;;=F50.8^^3^28^4
 ;;^UTILITY(U,$J,358.3,994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,994,1,3,0)
 ;;=3^Binge-Eating Disorder
 ;;^UTILITY(U,$J,358.3,994,1,4,0)
 ;;=4^F50.8
 ;;^UTILITY(U,$J,358.3,994,2)
 ;;=^5003601
 ;;^UTILITY(U,$J,358.3,995,0)
 ;;=F50.2^^3^28^5
 ;;^UTILITY(U,$J,358.3,995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,995,1,3,0)
 ;;=3^Bulimia Nervosa
 ;;^UTILITY(U,$J,358.3,995,1,4,0)
 ;;=4^F50.2
 ;;^UTILITY(U,$J,358.3,995,2)
 ;;=^5003600
 ;;^UTILITY(U,$J,358.3,996,0)
 ;;=Z55.9^^3^29^1
 ;;^UTILITY(U,$J,358.3,996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,996,1,3,0)
 ;;=3^Acedemic/Educational Problem
 ;;^UTILITY(U,$J,358.3,996,1,4,0)
 ;;=4^Z55.9
 ;;^UTILITY(U,$J,358.3,996,2)
 ;;=^5063106
 ;;^UTILITY(U,$J,358.3,997,0)
 ;;=Z56.81^^3^29^2
 ;;^UTILITY(U,$J,358.3,997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,997,1,3,0)
 ;;=3^Sexual Harassment on the Job
 ;;^UTILITY(U,$J,358.3,997,1,4,0)
 ;;=4^Z56.81
 ;;^UTILITY(U,$J,358.3,997,2)
 ;;=^5063114
 ;;^UTILITY(U,$J,358.3,998,0)
 ;;=Z56.9^^3^29^3
 ;;^UTILITY(U,$J,358.3,998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,998,1,3,0)
 ;;=3^Other Problem Related to Employment
 ;;^UTILITY(U,$J,358.3,998,1,4,0)
 ;;=4^Z56.9
 ;;^UTILITY(U,$J,358.3,998,2)
 ;;=^5063117
 ;;^UTILITY(U,$J,358.3,999,0)
 ;;=Z56.82^^3^29^4
 ;;^UTILITY(U,$J,358.3,999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,999,1,3,0)
 ;;=3^Problem Related to Current Military Deployment Status
 ;;^UTILITY(U,$J,358.3,999,1,4,0)
 ;;=4^Z56.82
 ;;^UTILITY(U,$J,358.3,999,2)
 ;;=^5063115
 ;;^UTILITY(U,$J,358.3,1000,0)
 ;;=F64.1^^3^30^1
 ;;^UTILITY(U,$J,358.3,1000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1000,1,3,0)
 ;;=3^Gender Dysphoria in Adolescents & Adults
 ;;^UTILITY(U,$J,358.3,1000,1,4,0)
 ;;=4^F64.1
 ;;^UTILITY(U,$J,358.3,1000,2)
 ;;=^5003647
 ;;^UTILITY(U,$J,358.3,1001,0)
 ;;=F64.8^^3^30^2
 ;;^UTILITY(U,$J,358.3,1001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1001,1,3,0)
 ;;=3^Other Spec Gender Dysphoria
 ;;^UTILITY(U,$J,358.3,1001,1,4,0)
 ;;=4^F64.8
 ;;^UTILITY(U,$J,358.3,1001,2)
 ;;=^5003649
 ;;^UTILITY(U,$J,358.3,1002,0)
 ;;=F64.9^^3^30^3
 ;;^UTILITY(U,$J,358.3,1002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1002,1,3,0)
 ;;=3^Unspec Gender Dysphoria
 ;;^UTILITY(U,$J,358.3,1002,1,4,0)
 ;;=4^F64.9
 ;;^UTILITY(U,$J,358.3,1002,2)
 ;;=^5003650
 ;;^UTILITY(U,$J,358.3,1003,0)
 ;;=Z59.2^^3^31^1
 ;;^UTILITY(U,$J,358.3,1003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1003,1,3,0)
 ;;=3^Discord w/ Neighbors,Lodgers or Landlord
 ;;^UTILITY(U,$J,358.3,1003,1,4,0)
 ;;=4^Z59.2
 ;;^UTILITY(U,$J,358.3,1003,2)
 ;;=^5063131
 ;;^UTILITY(U,$J,358.3,1004,0)
 ;;=Z59.0^^3^31^3
 ;;^UTILITY(U,$J,358.3,1004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1004,1,3,0)
 ;;=3^Homelessness
 ;;^UTILITY(U,$J,358.3,1004,1,4,0)
 ;;=4^Z59.0
 ;;^UTILITY(U,$J,358.3,1004,2)
 ;;=^5063129
 ;;^UTILITY(U,$J,358.3,1005,0)
 ;;=Z59.1^^3^31^4
 ;;^UTILITY(U,$J,358.3,1005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1005,1,3,0)
 ;;=3^Inadequate Housing
 ;;^UTILITY(U,$J,358.3,1005,1,4,0)
 ;;=4^Z59.1
 ;;^UTILITY(U,$J,358.3,1005,2)
 ;;=^5063130
 ;;^UTILITY(U,$J,358.3,1006,0)
 ;;=Z59.3^^3^31^8
 ;;^UTILITY(U,$J,358.3,1006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1006,1,3,0)
 ;;=3^Problems Related to Living in Residential Institution
 ;;^UTILITY(U,$J,358.3,1006,1,4,0)
 ;;=4^Z59.3
 ;;^UTILITY(U,$J,358.3,1006,2)
 ;;=^5063132
 ;;^UTILITY(U,$J,358.3,1007,0)
 ;;=Z59.4^^3^31^6
 ;;^UTILITY(U,$J,358.3,1007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1007,1,3,0)
 ;;=3^Lack of Adequate Food or Safe Drinking Water
 ;;^UTILITY(U,$J,358.3,1007,1,4,0)
 ;;=4^Z59.4
 ;;^UTILITY(U,$J,358.3,1007,2)
 ;;=^5063133
 ;;^UTILITY(U,$J,358.3,1008,0)
 ;;=Z59.5^^3^31^2
 ;;^UTILITY(U,$J,358.3,1008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1008,1,3,0)
 ;;=3^Extreme Poverty
 ;;^UTILITY(U,$J,358.3,1008,1,4,0)
 ;;=4^Z59.5
 ;;^UTILITY(U,$J,358.3,1008,2)
 ;;=^5063134
 ;;^UTILITY(U,$J,358.3,1009,0)
 ;;=Z59.6^^3^31^7
 ;;^UTILITY(U,$J,358.3,1009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1009,1,3,0)
 ;;=3^Low Income
 ;;^UTILITY(U,$J,358.3,1009,1,4,0)
 ;;=4^Z59.6
 ;;^UTILITY(U,$J,358.3,1009,2)
 ;;=^5063135
 ;;^UTILITY(U,$J,358.3,1010,0)
 ;;=Z59.7^^3^31^5
 ;;^UTILITY(U,$J,358.3,1010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1010,1,3,0)
 ;;=3^Insufficient Social Insurance/Welfare Support
 ;;^UTILITY(U,$J,358.3,1010,1,4,0)
 ;;=4^Z59.7
 ;;^UTILITY(U,$J,358.3,1010,2)
 ;;=^5063136
 ;;^UTILITY(U,$J,358.3,1011,0)
 ;;=Z59.9^^3^31^9
 ;;^UTILITY(U,$J,358.3,1011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1011,1,3,0)
 ;;=3^Unspec Housing or Economic Problem
 ;;^UTILITY(U,$J,358.3,1011,1,4,0)
 ;;=4^Z59.9
 ;;^UTILITY(U,$J,358.3,1011,2)
 ;;=^5063138
 ;;^UTILITY(U,$J,358.3,1012,0)
 ;;=G21.19^^3^32^5
 ;;^UTILITY(U,$J,358.3,1012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1012,1,3,0)
 ;;=3^Other Medication-Induced Parkinsonism
 ;;^UTILITY(U,$J,358.3,1012,1,4,0)
 ;;=4^G21.19
 ;;^UTILITY(U,$J,358.3,1012,2)
 ;;=^5003773
 ;;^UTILITY(U,$J,358.3,1013,0)
 ;;=G21.11^^3^32^3
 ;;^UTILITY(U,$J,358.3,1013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1013,1,3,0)
 ;;=3^Neuroleptic-Induced Parkinsonism
 ;;^UTILITY(U,$J,358.3,1013,1,4,0)
 ;;=4^G21.11
 ;;^UTILITY(U,$J,358.3,1013,2)
 ;;=^5003772
 ;;^UTILITY(U,$J,358.3,1014,0)
 ;;=G24.02^^3^32^1
 ;;^UTILITY(U,$J,358.3,1014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1014,1,3,0)
 ;;=3^Medication-Induced Acute Dystonia
 ;;^UTILITY(U,$J,358.3,1014,1,4,0)
 ;;=4^G24.02
 ;;^UTILITY(U,$J,358.3,1014,2)
 ;;=^5003785
 ;;^UTILITY(U,$J,358.3,1015,0)
 ;;=G24.01^^3^32^7
 ;;^UTILITY(U,$J,358.3,1015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1015,1,3,0)
 ;;=3^Tardive Dyskinesia
 ;;^UTILITY(U,$J,358.3,1015,1,4,0)
 ;;=4^G24.01
 ;;^UTILITY(U,$J,358.3,1015,2)
 ;;=^5003784
 ;;^UTILITY(U,$J,358.3,1016,0)
 ;;=G24.09^^3^32^8
 ;;^UTILITY(U,$J,358.3,1016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1016,1,3,0)
 ;;=3^Tardive Dystonia
 ;;^UTILITY(U,$J,358.3,1016,1,4,0)
 ;;=4^G24.09
 ;;^UTILITY(U,$J,358.3,1016,2)
 ;;=^5003786
 ;;^UTILITY(U,$J,358.3,1017,0)
 ;;=G25.1^^3^32^2
 ;;^UTILITY(U,$J,358.3,1017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1017,1,3,0)
 ;;=3^Medication-Induced Postural Tremor
 ;;^UTILITY(U,$J,358.3,1017,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,1017,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,1018,0)
 ;;=G25.71^^3^32^6
 ;;^UTILITY(U,$J,358.3,1018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1018,1,3,0)
 ;;=3^Tardive Akathisia/Medication-Induced Acute Akatisia
 ;;^UTILITY(U,$J,358.3,1018,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,1018,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,1019,0)
 ;;=G25.79^^3^32^4
 ;;^UTILITY(U,$J,358.3,1019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1019,1,3,0)
 ;;=3^Other Medication-Induced Movement Disorder
 ;;^UTILITY(U,$J,358.3,1019,1,4,0)
 ;;=4^G25.79
 ;;^UTILITY(U,$J,358.3,1019,2)
 ;;=^5003800
 ;;^UTILITY(U,$J,358.3,1020,0)
 ;;=F42.^^3^33^4
 ;;^UTILITY(U,$J,358.3,1020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1020,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder
 ;;^UTILITY(U,$J,358.3,1020,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,1020,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,1021,0)
 ;;=F42.^^3^33^3
 ;;^UTILITY(U,$J,358.3,1021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1021,1,3,0)
 ;;=3^Hoarding Disorder
 ;;^UTILITY(U,$J,358.3,1021,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,1021,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,1022,0)
 ;;=F42.^^3^33^5
 ;;^UTILITY(U,$J,358.3,1022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1022,1,3,0)
 ;;=3^Other Spec Obsessive-Compulsive & Related Disorder
 ;;^UTILITY(U,$J,358.3,1022,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,1022,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,1023,0)
 ;;=F42.^^3^33^7
 ;;^UTILITY(U,$J,358.3,1023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1023,1,3,0)
 ;;=3^Unspec Obsessive-Compulsive & Related Disorder
 ;;^UTILITY(U,$J,358.3,1023,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,1023,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,1024,0)
 ;;=F45.22^^3^33^1
 ;;^UTILITY(U,$J,358.3,1024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1024,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,1024,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,1024,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,1025,0)
 ;;=F63.3^^3^33^6
 ;;^UTILITY(U,$J,358.3,1025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1025,1,3,0)
 ;;=3^Trichotillomania
 ;;^UTILITY(U,$J,358.3,1025,1,4,0)
 ;;=4^F63.3
 ;;^UTILITY(U,$J,358.3,1025,2)
 ;;=^5003643
 ;;^UTILITY(U,$J,358.3,1026,0)
 ;;=L98.1^^3^33^2
 ;;^UTILITY(U,$J,358.3,1026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1026,1,3,0)
 ;;=3^Excoriation (Skin-Picking) Disorder
 ;;^UTILITY(U,$J,358.3,1026,1,4,0)
 ;;=4^L98.1
 ;;^UTILITY(U,$J,358.3,1026,2)
 ;;=^186781
 ;;^UTILITY(U,$J,358.3,1027,0)
 ;;=F06.2^^3^34^4
 ;;^UTILITY(U,$J,358.3,1027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1027,1,3,0)
 ;;=3^Psychotic Disorder w/ Delusions d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,1027,1,4,0)
 ;;=4^F06.2
