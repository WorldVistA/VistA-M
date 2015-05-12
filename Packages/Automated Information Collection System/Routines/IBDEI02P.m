IBDEI02P ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3188,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,3188,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,3189,0)
 ;;=Z69.12^^15^132^7
 ;;^UTILITY(U,$J,358.3,3189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3189,1,3,0)
 ;;=3^Mental Hlth Svc for Perpetrator of Spousal/Partner Abuse
 ;;^UTILITY(U,$J,358.3,3189,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,3189,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,3190,0)
 ;;=Z69.010^^15^132^8
 ;;^UTILITY(U,$J,358.3,3190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3190,1,3,0)
 ;;=3^Mental Hlth Svc for Victim of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,3190,1,4,0)
 ;;=4^Z69.010
 ;;^UTILITY(U,$J,358.3,3190,2)
 ;;=^5063228
 ;;^UTILITY(U,$J,358.3,3191,0)
 ;;=Z69.011^^15^132^6
 ;;^UTILITY(U,$J,358.3,3191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3191,1,3,0)
 ;;=3^Mental Hlth Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,3191,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,3191,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,3192,0)
 ;;=Z62.898^^15^132^11
 ;;^UTILITY(U,$J,358.3,3192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3192,1,3,0)
 ;;=3^Problems Related to Upbringing
 ;;^UTILITY(U,$J,358.3,3192,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,3192,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,3193,0)
 ;;=Z63.79^^15^132^12
 ;;^UTILITY(U,$J,358.3,3193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3193,1,3,0)
 ;;=3^Stressful Life Events
 ;;^UTILITY(U,$J,358.3,3193,1,4,0)
 ;;=4^Z63.79
 ;;^UTILITY(U,$J,358.3,3193,2)
 ;;=^5063173
 ;;^UTILITY(U,$J,358.3,3194,0)
 ;;=Z63.72^^15^132^2
 ;;^UTILITY(U,$J,358.3,3194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3194,1,3,0)
 ;;=3^Alcoholism/Drug Addiction in Family
 ;;^UTILITY(U,$J,358.3,3194,1,4,0)
 ;;=4^Z63.72
 ;;^UTILITY(U,$J,358.3,3194,2)
 ;;=^5063172
 ;;^UTILITY(U,$J,358.3,3195,0)
 ;;=Z63.6^^15^132^4
 ;;^UTILITY(U,$J,358.3,3195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3195,1,3,0)
 ;;=3^Dependent Relative Needing Care at Home
 ;;^UTILITY(U,$J,358.3,3195,1,4,0)
 ;;=4^Z63.6
 ;;^UTILITY(U,$J,358.3,3195,2)
 ;;=^5063170
 ;;^UTILITY(U,$J,358.3,3196,0)
 ;;=Z59.0^^15^133^4
 ;;^UTILITY(U,$J,358.3,3196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3196,1,3,0)
 ;;=3^Homelessness
 ;;^UTILITY(U,$J,358.3,3196,1,4,0)
 ;;=4^Z59.0
 ;;^UTILITY(U,$J,358.3,3196,2)
 ;;=^5063129
 ;;^UTILITY(U,$J,358.3,3197,0)
 ;;=Z59.1^^15^133^6
 ;;^UTILITY(U,$J,358.3,3197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3197,1,3,0)
 ;;=3^Inadequate Housing
 ;;^UTILITY(U,$J,358.3,3197,1,4,0)
 ;;=4^Z59.1
 ;;^UTILITY(U,$J,358.3,3197,2)
 ;;=^5063130
 ;;^UTILITY(U,$J,358.3,3198,0)
 ;;=Z59.5^^15^133^2
 ;;^UTILITY(U,$J,358.3,3198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3198,1,3,0)
 ;;=3^Extreme Poverty
 ;;^UTILITY(U,$J,358.3,3198,1,4,0)
 ;;=4^Z59.5
 ;;^UTILITY(U,$J,358.3,3198,2)
 ;;=^5063134
 ;;^UTILITY(U,$J,358.3,3199,0)
 ;;=Z60.2^^15^133^8
 ;;^UTILITY(U,$J,358.3,3199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3199,1,3,0)
 ;;=3^Problems Related to Living Alone
 ;;^UTILITY(U,$J,358.3,3199,1,4,0)
 ;;=4^Z60.2
 ;;^UTILITY(U,$J,358.3,3199,2)
 ;;=^5063140
 ;;^UTILITY(U,$J,358.3,3200,0)
 ;;=Z74.2^^15^133^1
 ;;^UTILITY(U,$J,358.3,3200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3200,1,3,0)
 ;;=3^Assistance at Home Needed
 ;;^UTILITY(U,$J,358.3,3200,1,4,0)
 ;;=4^Z74.2
 ;;^UTILITY(U,$J,358.3,3200,2)
 ;;=^5063285
 ;;^UTILITY(U,$J,358.3,3201,0)
 ;;=Z75.5^^15^133^3
 ;;^UTILITY(U,$J,358.3,3201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3201,1,3,0)
 ;;=3^Holiday Relief Care
 ;;^UTILITY(U,$J,358.3,3201,1,4,0)
 ;;=4^Z75.5
 ;;^UTILITY(U,$J,358.3,3201,2)
 ;;=^5063294
 ;;^UTILITY(U,$J,358.3,3202,0)
 ;;=Z59.3^^15^133^9
 ;;^UTILITY(U,$J,358.3,3202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3202,1,3,0)
 ;;=3^Problems Related to Living in Residential Institution
 ;;^UTILITY(U,$J,358.3,3202,1,4,0)
 ;;=4^Z59.3
 ;;^UTILITY(U,$J,358.3,3202,2)
 ;;=^5063132
 ;;^UTILITY(U,$J,358.3,3203,0)
 ;;=Z63.8^^15^133^7
 ;;^UTILITY(U,$J,358.3,3203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3203,1,3,0)
 ;;=3^Primary Support Group Problems
 ;;^UTILITY(U,$J,358.3,3203,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,3203,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,3204,0)
 ;;=Z59.8^^15^133^5
 ;;^UTILITY(U,$J,358.3,3204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3204,1,3,0)
 ;;=3^Housing/Economic Circumstance Problems
 ;;^UTILITY(U,$J,358.3,3204,1,4,0)
 ;;=4^Z59.8
 ;;^UTILITY(U,$J,358.3,3204,2)
 ;;=^5063137
 ;;^UTILITY(U,$J,358.3,3205,0)
 ;;=F81.9^^15^134^2
 ;;^UTILITY(U,$J,358.3,3205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3205,1,3,0)
 ;;=3^Developmental Disorder of Scholastic Skills,Unspec
 ;;^UTILITY(U,$J,358.3,3205,1,4,0)
 ;;=4^F81.9
 ;;^UTILITY(U,$J,358.3,3205,2)
 ;;=^5003682
 ;;^UTILITY(U,$J,358.3,3206,0)
 ;;=Z86.59^^15^134^4
 ;;^UTILITY(U,$J,358.3,3206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3206,1,3,0)
 ;;=3^Personal Hx of Mental/Behavioral Disorders
 ;;^UTILITY(U,$J,358.3,3206,1,4,0)
 ;;=4^Z86.59
 ;;^UTILITY(U,$J,358.3,3206,2)
 ;;=^5063471
 ;;^UTILITY(U,$J,358.3,3207,0)
 ;;=F48.9^^15^134^3
 ;;^UTILITY(U,$J,358.3,3207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3207,1,3,0)
 ;;=3^Nonpsychotic Mental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3207,1,4,0)
 ;;=4^F48.9
 ;;^UTILITY(U,$J,358.3,3207,2)
 ;;=^5003596
 ;;^UTILITY(U,$J,358.3,3208,0)
 ;;=Z91.83^^15^134^5
 ;;^UTILITY(U,$J,358.3,3208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3208,1,3,0)
 ;;=3^Wandering in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,3208,1,4,0)
 ;;=4^Z91.83
 ;;^UTILITY(U,$J,358.3,3208,2)
 ;;=^5063627
 ;;^UTILITY(U,$J,358.3,3209,0)
 ;;=F69.^^15^134^1
 ;;^UTILITY(U,$J,358.3,3209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3209,1,3,0)
 ;;=3^Adult Personality/Behavior Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3209,1,4,0)
 ;;=4^F69.
 ;;^UTILITY(U,$J,358.3,3209,2)
 ;;=^5003667
 ;;^UTILITY(U,$J,358.3,3210,0)
 ;;=Z94.0^^15^135^6
 ;;^UTILITY(U,$J,358.3,3210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3210,1,3,0)
 ;;=3^Kidney Transplant Status
 ;;^UTILITY(U,$J,358.3,3210,1,4,0)
 ;;=4^Z94.0
 ;;^UTILITY(U,$J,358.3,3210,2)
 ;;=^5063654
 ;;^UTILITY(U,$J,358.3,3211,0)
 ;;=Z94.1^^15^135^4
 ;;^UTILITY(U,$J,358.3,3211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3211,1,3,0)
 ;;=3^Heart Transplant Status
 ;;^UTILITY(U,$J,358.3,3211,1,4,0)
 ;;=4^Z94.1
 ;;^UTILITY(U,$J,358.3,3211,2)
 ;;=^5063655
 ;;^UTILITY(U,$J,358.3,3212,0)
 ;;=Z95.3^^15^135^10
 ;;^UTILITY(U,$J,358.3,3212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3212,1,3,0)
 ;;=3^Presence of Xenogenic Heart Valve
 ;;^UTILITY(U,$J,358.3,3212,1,4,0)
 ;;=4^Z95.3
 ;;^UTILITY(U,$J,358.3,3212,2)
 ;;=^5063671
 ;;^UTILITY(U,$J,358.3,3213,0)
 ;;=Z94.5^^15^135^11
 ;;^UTILITY(U,$J,358.3,3213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3213,1,3,0)
 ;;=3^Skin Transplant Status
 ;;^UTILITY(U,$J,358.3,3213,1,4,0)
 ;;=4^Z94.5
 ;;^UTILITY(U,$J,358.3,3213,2)
 ;;=^5063659
 ;;^UTILITY(U,$J,358.3,3214,0)
 ;;=Z94.6^^15^135^2
 ;;^UTILITY(U,$J,358.3,3214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3214,1,3,0)
 ;;=3^Bone Transplant Status
 ;;^UTILITY(U,$J,358.3,3214,1,4,0)
 ;;=4^Z94.6
 ;;^UTILITY(U,$J,358.3,3214,2)
 ;;=^5063660
 ;;^UTILITY(U,$J,358.3,3215,0)
 ;;=Z94.7^^15^135^3
 ;;^UTILITY(U,$J,358.3,3215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3215,1,3,0)
 ;;=3^Corneal Transplant Status
 ;;^UTILITY(U,$J,358.3,3215,1,4,0)
 ;;=4^Z94.7
 ;;^UTILITY(U,$J,358.3,3215,2)
 ;;=^5063661
 ;;^UTILITY(U,$J,358.3,3216,0)
 ;;=Z94.2^^15^135^8
 ;;^UTILITY(U,$J,358.3,3216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3216,1,3,0)
 ;;=3^Lung Transplant Status
 ;;^UTILITY(U,$J,358.3,3216,1,4,0)
 ;;=4^Z94.2
 ;;^UTILITY(U,$J,358.3,3216,2)
 ;;=^5063656
 ;;^UTILITY(U,$J,358.3,3217,0)
 ;;=Z94.4^^15^135^7
 ;;^UTILITY(U,$J,358.3,3217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3217,1,3,0)
 ;;=3^Liver Transplant Status
 ;;^UTILITY(U,$J,358.3,3217,1,4,0)
 ;;=4^Z94.4
 ;;^UTILITY(U,$J,358.3,3217,2)
 ;;=^5063658
 ;;^UTILITY(U,$J,358.3,3218,0)
 ;;=Z94.81^^15^135^1
 ;;^UTILITY(U,$J,358.3,3218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3218,1,3,0)
 ;;=3^Bone Marrow Transplant Status
 ;;^UTILITY(U,$J,358.3,3218,1,4,0)
 ;;=4^Z94.81
 ;;^UTILITY(U,$J,358.3,3218,2)
 ;;=^5063662
 ;;^UTILITY(U,$J,358.3,3219,0)
 ;;=Z94.84^^15^135^12
 ;;^UTILITY(U,$J,358.3,3219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3219,1,3,0)
 ;;=3^Stem Cells Transplant Status
 ;;^UTILITY(U,$J,358.3,3219,1,4,0)
 ;;=4^Z94.84
 ;;^UTILITY(U,$J,358.3,3219,2)
 ;;=^5063665
 ;;^UTILITY(U,$J,358.3,3220,0)
 ;;=Z94.83^^15^135^9
 ;;^UTILITY(U,$J,358.3,3220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3220,1,3,0)
 ;;=3^Pancreas Transplant Status
 ;;^UTILITY(U,$J,358.3,3220,1,4,0)
 ;;=4^Z94.83
 ;;^UTILITY(U,$J,358.3,3220,2)
 ;;=^5063664
 ;;^UTILITY(U,$J,358.3,3221,0)
 ;;=Z94.82^^15^135^5
 ;;^UTILITY(U,$J,358.3,3221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3221,1,3,0)
 ;;=3^Intestine Transplant Status
 ;;^UTILITY(U,$J,358.3,3221,1,4,0)
 ;;=4^Z94.82
 ;;^UTILITY(U,$J,358.3,3221,2)
 ;;=^5063663
 ;;^UTILITY(U,$J,358.3,3222,0)
 ;;=Z94.9^^15^135^13
 ;;^UTILITY(U,$J,358.3,3222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3222,1,3,0)
 ;;=3^Transplanted Organ/Tissue Status,Unspec
 ;;^UTILITY(U,$J,358.3,3222,1,4,0)
 ;;=4^Z94.9
 ;;^UTILITY(U,$J,358.3,3222,2)
 ;;=^5063667
 ;;^UTILITY(U,$J,358.3,3223,0)
 ;;=Z99.2^^15^136^1
 ;;^UTILITY(U,$J,358.3,3223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3223,1,3,0)
 ;;=3^Dependence on Renal Dialysis
 ;;^UTILITY(U,$J,358.3,3223,1,4,0)
 ;;=4^Z99.2
 ;;^UTILITY(U,$J,358.3,3223,2)
 ;;=^5063758
 ;;^UTILITY(U,$J,358.3,3224,0)
 ;;=Z98.89^^15^136^3
 ;;^UTILITY(U,$J,358.3,3224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3224,1,3,0)
 ;;=3^Postprocedural States,Oth Spec
 ;;^UTILITY(U,$J,358.3,3224,1,4,0)
 ;;=4^Z98.89
 ;;^UTILITY(U,$J,358.3,3224,2)
 ;;=^5063754
 ;;^UTILITY(U,$J,358.3,3225,0)
 ;;=Z91.15^^15^136^2
 ;;^UTILITY(U,$J,358.3,3225,1,0)
 ;;=^358.31IA^4^2
