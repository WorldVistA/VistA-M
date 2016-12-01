IBDEI00O ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,311,1,3,0)
 ;;=3^Anorexia Nervosa,Binge-Eating/Purging Type
 ;;^UTILITY(U,$J,358.3,311,1,4,0)
 ;;=4^F50.02
 ;;^UTILITY(U,$J,358.3,311,2)
 ;;=^5003599
 ;;^UTILITY(U,$J,358.3,312,0)
 ;;=F50.01^^3^29^2
 ;;^UTILITY(U,$J,358.3,312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,312,1,3,0)
 ;;=3^Anorexia Nervosa,Restricting Type
 ;;^UTILITY(U,$J,358.3,312,1,4,0)
 ;;=4^F50.01
 ;;^UTILITY(U,$J,358.3,312,2)
 ;;=^5003598
 ;;^UTILITY(U,$J,358.3,313,0)
 ;;=F50.9^^3^29^7
 ;;^UTILITY(U,$J,358.3,313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,313,1,3,0)
 ;;=3^Feeding/Eating Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,313,1,4,0)
 ;;=4^F50.9
 ;;^UTILITY(U,$J,358.3,313,2)
 ;;=^5003602
 ;;^UTILITY(U,$J,358.3,314,0)
 ;;=F50.8^^3^29^6
 ;;^UTILITY(U,$J,358.3,314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,314,1,3,0)
 ;;=3^Feeding/Eating Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,314,1,4,0)
 ;;=4^F50.8
 ;;^UTILITY(U,$J,358.3,314,2)
 ;;=^5003601
 ;;^UTILITY(U,$J,358.3,315,0)
 ;;=F50.8^^3^29^3
 ;;^UTILITY(U,$J,358.3,315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,315,1,3,0)
 ;;=3^Avoidant/Restrictive Food Intake Disorder
 ;;^UTILITY(U,$J,358.3,315,1,4,0)
 ;;=4^F50.8
 ;;^UTILITY(U,$J,358.3,315,2)
 ;;=^5003601
 ;;^UTILITY(U,$J,358.3,316,0)
 ;;=F50.8^^3^29^4
 ;;^UTILITY(U,$J,358.3,316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,316,1,3,0)
 ;;=3^Binge-Eating Disorder
 ;;^UTILITY(U,$J,358.3,316,1,4,0)
 ;;=4^F50.8
 ;;^UTILITY(U,$J,358.3,316,2)
 ;;=^5003601
 ;;^UTILITY(U,$J,358.3,317,0)
 ;;=F50.2^^3^29^5
 ;;^UTILITY(U,$J,358.3,317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,317,1,3,0)
 ;;=3^Bulimia Nervosa
 ;;^UTILITY(U,$J,358.3,317,1,4,0)
 ;;=4^F50.2
 ;;^UTILITY(U,$J,358.3,317,2)
 ;;=^5003600
 ;;^UTILITY(U,$J,358.3,318,0)
 ;;=F50.8^^3^29^8
 ;;^UTILITY(U,$J,358.3,318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,318,1,3,0)
 ;;=3^Pica in Adults
 ;;^UTILITY(U,$J,358.3,318,1,4,0)
 ;;=4^F50.8
 ;;^UTILITY(U,$J,358.3,318,2)
 ;;=^5003601
 ;;^UTILITY(U,$J,358.3,319,0)
 ;;=F98.21^^3^29^9
 ;;^UTILITY(U,$J,358.3,319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,319,1,3,0)
 ;;=3^Rumination Disorder
 ;;^UTILITY(U,$J,358.3,319,1,4,0)
 ;;=4^F98.21
 ;;^UTILITY(U,$J,358.3,319,2)
 ;;=^5003713
 ;;^UTILITY(U,$J,358.3,320,0)
 ;;=Z55.9^^3^30^1
 ;;^UTILITY(U,$J,358.3,320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,320,1,3,0)
 ;;=3^Academic/Educational Problem
 ;;^UTILITY(U,$J,358.3,320,1,4,0)
 ;;=4^Z55.9
 ;;^UTILITY(U,$J,358.3,320,2)
 ;;=^5063106
 ;;^UTILITY(U,$J,358.3,321,0)
 ;;=Z56.82^^3^30^5
 ;;^UTILITY(U,$J,358.3,321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,321,1,3,0)
 ;;=3^Problems Related to Current Military Deployment Status
 ;;^UTILITY(U,$J,358.3,321,1,4,0)
 ;;=4^Z56.82
 ;;^UTILITY(U,$J,358.3,321,2)
 ;;=^5063115
 ;;^UTILITY(U,$J,358.3,322,0)
 ;;=Z56.0^^3^30^10
 ;;^UTILITY(U,$J,358.3,322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,322,1,3,0)
 ;;=3^Unemployment,Unspec
 ;;^UTILITY(U,$J,358.3,322,1,4,0)
 ;;=4^Z56.0
 ;;^UTILITY(U,$J,358.3,322,2)
 ;;=^5063107
 ;;^UTILITY(U,$J,358.3,323,0)
 ;;=Z56.1^^3^30^2
 ;;^UTILITY(U,$J,358.3,323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,323,1,3,0)
 ;;=3^Change of Job
 ;;^UTILITY(U,$J,358.3,323,1,4,0)
 ;;=4^Z56.1
 ;;^UTILITY(U,$J,358.3,323,2)
 ;;=^5063108
 ;;^UTILITY(U,$J,358.3,324,0)
 ;;=Z56.2^^3^30^8
 ;;^UTILITY(U,$J,358.3,324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,324,1,3,0)
 ;;=3^Threat of Job Loss
 ;;^UTILITY(U,$J,358.3,324,1,4,0)
 ;;=4^Z56.2
 ;;^UTILITY(U,$J,358.3,324,2)
 ;;=^5063109
 ;;^UTILITY(U,$J,358.3,325,0)
 ;;=Z56.3^^3^30^7
 ;;^UTILITY(U,$J,358.3,325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,325,1,3,0)
 ;;=3^Stressful Work Schedule
 ;;^UTILITY(U,$J,358.3,325,1,4,0)
 ;;=4^Z56.3
 ;;^UTILITY(U,$J,358.3,325,2)
 ;;=^5063110
 ;;^UTILITY(U,$J,358.3,326,0)
 ;;=Z56.4^^3^30^3
 ;;^UTILITY(U,$J,358.3,326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,326,1,3,0)
 ;;=3^Discord w/ Boss and Workmates
 ;;^UTILITY(U,$J,358.3,326,1,4,0)
 ;;=4^Z56.4
 ;;^UTILITY(U,$J,358.3,326,2)
 ;;=^5063111
 ;;^UTILITY(U,$J,358.3,327,0)
 ;;=Z56.5^^3^30^9
 ;;^UTILITY(U,$J,358.3,327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,327,1,3,0)
 ;;=3^Uncongenial Work Environment
 ;;^UTILITY(U,$J,358.3,327,1,4,0)
 ;;=4^Z56.5
 ;;^UTILITY(U,$J,358.3,327,2)
 ;;=^5063112
 ;;^UTILITY(U,$J,358.3,328,0)
 ;;=Z56.6^^3^30^4
 ;;^UTILITY(U,$J,358.3,328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,328,1,3,0)
 ;;=3^Physical & Mental Strain Related to Work,Other
 ;;^UTILITY(U,$J,358.3,328,1,4,0)
 ;;=4^Z56.6
 ;;^UTILITY(U,$J,358.3,328,2)
 ;;=^5063113
 ;;^UTILITY(U,$J,358.3,329,0)
 ;;=Z56.89^^3^30^6
 ;;^UTILITY(U,$J,358.3,329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,329,1,3,0)
 ;;=3^Problems Related to Employment,Other
 ;;^UTILITY(U,$J,358.3,329,1,4,0)
 ;;=4^Z56.89
 ;;^UTILITY(U,$J,358.3,329,2)
 ;;=^5063116
 ;;^UTILITY(U,$J,358.3,330,0)
 ;;=F64.1^^3^31^1
 ;;^UTILITY(U,$J,358.3,330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,330,1,3,0)
 ;;=3^Gender Dysphoria in Adolescents & Adults
 ;;^UTILITY(U,$J,358.3,330,1,4,0)
 ;;=4^F64.1
 ;;^UTILITY(U,$J,358.3,330,2)
 ;;=^5003647
 ;;^UTILITY(U,$J,358.3,331,0)
 ;;=F64.8^^3^31^2
 ;;^UTILITY(U,$J,358.3,331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,331,1,3,0)
 ;;=3^Gender Dysphoria,Other Specified
 ;;^UTILITY(U,$J,358.3,331,1,4,0)
 ;;=4^F64.8
 ;;^UTILITY(U,$J,358.3,331,2)
 ;;=^5003649
 ;;^UTILITY(U,$J,358.3,332,0)
 ;;=F64.9^^3^31^3
 ;;^UTILITY(U,$J,358.3,332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,332,1,3,0)
 ;;=3^Gender Dysphoria,Unspec
 ;;^UTILITY(U,$J,358.3,332,1,4,0)
 ;;=4^F64.9
 ;;^UTILITY(U,$J,358.3,332,2)
 ;;=^5003650
 ;;^UTILITY(U,$J,358.3,333,0)
 ;;=Z59.2^^3^32^1
 ;;^UTILITY(U,$J,358.3,333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,333,1,3,0)
 ;;=3^Discord w/ Neighbor,Lodger or Landlord
 ;;^UTILITY(U,$J,358.3,333,1,4,0)
 ;;=4^Z59.2
 ;;^UTILITY(U,$J,358.3,333,2)
 ;;=^5063131
 ;;^UTILITY(U,$J,358.3,334,0)
 ;;=Z59.0^^3^32^3
 ;;^UTILITY(U,$J,358.3,334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,334,1,3,0)
 ;;=3^Homelessness
 ;;^UTILITY(U,$J,358.3,334,1,4,0)
 ;;=4^Z59.0
 ;;^UTILITY(U,$J,358.3,334,2)
 ;;=^5063129
 ;;^UTILITY(U,$J,358.3,335,0)
 ;;=Z59.1^^3^32^5
 ;;^UTILITY(U,$J,358.3,335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,335,1,3,0)
 ;;=3^Inadequate Housing
 ;;^UTILITY(U,$J,358.3,335,1,4,0)
 ;;=4^Z59.1
 ;;^UTILITY(U,$J,358.3,335,2)
 ;;=^5063130
 ;;^UTILITY(U,$J,358.3,336,0)
 ;;=Z59.3^^3^32^9
 ;;^UTILITY(U,$J,358.3,336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,336,1,3,0)
 ;;=3^Problems Related to Living in Residential Institution
 ;;^UTILITY(U,$J,358.3,336,1,4,0)
 ;;=4^Z59.3
 ;;^UTILITY(U,$J,358.3,336,2)
 ;;=^5063132
 ;;^UTILITY(U,$J,358.3,337,0)
 ;;=Z59.4^^3^32^7
 ;;^UTILITY(U,$J,358.3,337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,337,1,3,0)
 ;;=3^Lack of Adequate Food or Safe Drinking Water
 ;;^UTILITY(U,$J,358.3,337,1,4,0)
 ;;=4^Z59.4
 ;;^UTILITY(U,$J,358.3,337,2)
 ;;=^5063133
 ;;^UTILITY(U,$J,358.3,338,0)
 ;;=Z59.5^^3^32^2
 ;;^UTILITY(U,$J,358.3,338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,338,1,3,0)
 ;;=3^Extreme Poverty
 ;;^UTILITY(U,$J,358.3,338,1,4,0)
 ;;=4^Z59.5
 ;;^UTILITY(U,$J,358.3,338,2)
 ;;=^5063134
 ;;^UTILITY(U,$J,358.3,339,0)
 ;;=Z59.6^^3^32^8
 ;;^UTILITY(U,$J,358.3,339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,339,1,3,0)
 ;;=3^Low Income
 ;;^UTILITY(U,$J,358.3,339,1,4,0)
 ;;=4^Z59.6
 ;;^UTILITY(U,$J,358.3,339,2)
 ;;=^5063135
 ;;^UTILITY(U,$J,358.3,340,0)
 ;;=Z59.7^^3^32^6
 ;;^UTILITY(U,$J,358.3,340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,340,1,3,0)
 ;;=3^Insufficient Social Insurance/Welfare Support
 ;;^UTILITY(U,$J,358.3,340,1,4,0)
 ;;=4^Z59.7
 ;;^UTILITY(U,$J,358.3,340,2)
 ;;=^5063136
 ;;^UTILITY(U,$J,358.3,341,0)
 ;;=Z59.9^^3^32^4
 ;;^UTILITY(U,$J,358.3,341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,341,1,3,0)
 ;;=3^Housing/Economic Problems,Unspec
 ;;^UTILITY(U,$J,358.3,341,1,4,0)
 ;;=4^Z59.9
 ;;^UTILITY(U,$J,358.3,341,2)
 ;;=^5063138
 ;;^UTILITY(U,$J,358.3,342,0)
 ;;=G21.19^^3^33^10
 ;;^UTILITY(U,$J,358.3,342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,342,1,3,0)
 ;;=3^Medication-Induced Parkinsonism,Other
 ;;^UTILITY(U,$J,358.3,342,1,4,0)
 ;;=4^G21.19
 ;;^UTILITY(U,$J,358.3,342,2)
 ;;=^5003773
 ;;^UTILITY(U,$J,358.3,343,0)
 ;;=G21.11^^3^33^13
 ;;^UTILITY(U,$J,358.3,343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,343,1,3,0)
 ;;=3^Neuroleptic-Induced Parkinsonism
 ;;^UTILITY(U,$J,358.3,343,1,4,0)
 ;;=4^G21.11
 ;;^UTILITY(U,$J,358.3,343,2)
 ;;=^5003772
 ;;^UTILITY(U,$J,358.3,344,0)
 ;;=G24.01^^3^33^15
 ;;^UTILITY(U,$J,358.3,344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,344,1,3,0)
 ;;=3^Tardive Dyskinesia
 ;;^UTILITY(U,$J,358.3,344,1,4,0)
 ;;=4^G24.01
 ;;^UTILITY(U,$J,358.3,344,2)
 ;;=^5003784
 ;;^UTILITY(U,$J,358.3,345,0)
 ;;=G24.09^^3^33^16
 ;;^UTILITY(U,$J,358.3,345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,345,1,3,0)
 ;;=3^Tardive Dystonia
 ;;^UTILITY(U,$J,358.3,345,1,4,0)
 ;;=4^G24.09
 ;;^UTILITY(U,$J,358.3,345,2)
 ;;=^5003786
 ;;^UTILITY(U,$J,358.3,346,0)
 ;;=G25.1^^3^33^11
 ;;^UTILITY(U,$J,358.3,346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,346,1,3,0)
 ;;=3^Medication-Induced Postural Tremor
 ;;^UTILITY(U,$J,358.3,346,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,346,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,347,0)
 ;;=G25.71^^3^33^14
 ;;^UTILITY(U,$J,358.3,347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,347,1,3,0)
 ;;=3^Tardive Akathisia
 ;;^UTILITY(U,$J,358.3,347,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,347,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,348,0)
 ;;=G25.79^^3^33^9
 ;;^UTILITY(U,$J,358.3,348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,348,1,3,0)
 ;;=3^Medication-Induced Movement Disorder,Other
 ;;^UTILITY(U,$J,358.3,348,1,4,0)
 ;;=4^G25.79
 ;;^UTILITY(U,$J,358.3,348,2)
 ;;=^5003800
 ;;^UTILITY(U,$J,358.3,349,0)
 ;;=T43.205A^^3^33^4
 ;;^UTILITY(U,$J,358.3,349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,349,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Init Encntr
