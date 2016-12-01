IBDEI0ZC ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,46341,1,4,0)
 ;;=4^Z74.9
 ;;^UTILITY(U,$J,358.3,46341,2)
 ;;=^5063288
 ;;^UTILITY(U,$J,358.3,46342,0)
 ;;=Z63.4^^136^1946^127
 ;;^UTILITY(U,$J,358.3,46342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46342,1,3,0)
 ;;=3^Problems Related to Bereavement
 ;;^UTILITY(U,$J,358.3,46342,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,46342,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,46343,0)
 ;;=Z63.6^^136^1946^129
 ;;^UTILITY(U,$J,358.3,46343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46343,1,3,0)
 ;;=3^Problems Related to Dependent Relative Needing Care at Home
 ;;^UTILITY(U,$J,358.3,46343,1,4,0)
 ;;=4^Z63.6
 ;;^UTILITY(U,$J,358.3,46343,2)
 ;;=^5063170
 ;;^UTILITY(U,$J,358.3,46344,0)
 ;;=Z59.2^^136^1946^131
 ;;^UTILITY(U,$J,358.3,46344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46344,1,3,0)
 ;;=3^Problems Related to Discord w/ Neighbors/Lodgers/Landlord
 ;;^UTILITY(U,$J,358.3,46344,1,4,0)
 ;;=4^Z59.2
 ;;^UTILITY(U,$J,358.3,46344,2)
 ;;=^5063131
 ;;^UTILITY(U,$J,358.3,46345,0)
 ;;=Z63.5^^136^1946^155
 ;;^UTILITY(U,$J,358.3,46345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46345,1,3,0)
 ;;=3^Problems Related to Separation/Divorce
 ;;^UTILITY(U,$J,358.3,46345,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,46345,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,46346,0)
 ;;=Z55.9^^136^1946^132
 ;;^UTILITY(U,$J,358.3,46346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46346,1,3,0)
 ;;=3^Problems Related to Education/Literacy,Unspec
 ;;^UTILITY(U,$J,358.3,46346,1,4,0)
 ;;=4^Z55.9
 ;;^UTILITY(U,$J,358.3,46346,2)
 ;;=^5063106
 ;;^UTILITY(U,$J,358.3,46347,0)
 ;;=Z56.9^^136^1946^133
 ;;^UTILITY(U,$J,358.3,46347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46347,1,3,0)
 ;;=3^Problems Related to Employment,Unspec
 ;;^UTILITY(U,$J,358.3,46347,1,4,0)
 ;;=4^Z56.9
 ;;^UTILITY(U,$J,358.3,46347,2)
 ;;=^5063117
 ;;^UTILITY(U,$J,358.3,46348,0)
 ;;=Z65.5^^136^1946^130
 ;;^UTILITY(U,$J,358.3,46348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46348,1,3,0)
 ;;=3^Problems Related to Disaster/War/Other Hostilities
 ;;^UTILITY(U,$J,358.3,46348,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,46348,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,46349,0)
 ;;=Z59.5^^136^1946^134
 ;;^UTILITY(U,$J,358.3,46349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46349,1,3,0)
 ;;=3^Problems Related to Extreme Poverty
 ;;^UTILITY(U,$J,358.3,46349,1,4,0)
 ;;=4^Z59.5
 ;;^UTILITY(U,$J,358.3,46349,2)
 ;;=^5063134
 ;;^UTILITY(U,$J,358.3,46350,0)
 ;;=Z59.0^^136^1946^136
 ;;^UTILITY(U,$J,358.3,46350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46350,1,3,0)
 ;;=3^Problems Related to Homelessness
 ;;^UTILITY(U,$J,358.3,46350,1,4,0)
 ;;=4^Z59.0
 ;;^UTILITY(U,$J,358.3,46350,2)
 ;;=^5063129
 ;;^UTILITY(U,$J,358.3,46351,0)
 ;;=Z59.9^^136^1946^137
 ;;^UTILITY(U,$J,358.3,46351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46351,1,3,0)
 ;;=3^Problems Related to Housing/Economic Circumstances
 ;;^UTILITY(U,$J,358.3,46351,1,4,0)
 ;;=4^Z59.9
 ;;^UTILITY(U,$J,358.3,46351,2)
 ;;=^5063138
 ;;^UTILITY(U,$J,358.3,46352,0)
 ;;=Z59.1^^136^1946^138
 ;;^UTILITY(U,$J,358.3,46352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46352,1,3,0)
 ;;=3^Problems Related to Inadequate Housing
 ;;^UTILITY(U,$J,358.3,46352,1,4,0)
 ;;=4^Z59.1
 ;;^UTILITY(U,$J,358.3,46352,2)
 ;;=^5063130
 ;;^UTILITY(U,$J,358.3,46353,0)
 ;;=Z59.7^^136^1946^139
 ;;^UTILITY(U,$J,358.3,46353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46353,1,3,0)
 ;;=3^Problems Related to Insufficient Social Insurance/Welfare Support
 ;;^UTILITY(U,$J,358.3,46353,1,4,0)
 ;;=4^Z59.7
 ;;^UTILITY(U,$J,358.3,46353,2)
 ;;=^5063136
 ;;^UTILITY(U,$J,358.3,46354,0)
 ;;=Z59.4^^136^1946^140
 ;;^UTILITY(U,$J,358.3,46354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46354,1,3,0)
 ;;=3^Problems Related to Lack of Food/Drinking Water
 ;;^UTILITY(U,$J,358.3,46354,1,4,0)
 ;;=4^Z59.4
 ;;^UTILITY(U,$J,358.3,46354,2)
 ;;=^5063133
 ;;^UTILITY(U,$J,358.3,46355,0)
 ;;=Z73.9^^136^1946^141
 ;;^UTILITY(U,$J,358.3,46355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46355,1,3,0)
 ;;=3^Problems Related to Life Management Difficulty
 ;;^UTILITY(U,$J,358.3,46355,1,4,0)
 ;;=4^Z73.9
 ;;^UTILITY(U,$J,358.3,46355,2)
 ;;=^5063281
 ;;^UTILITY(U,$J,358.3,46356,0)
 ;;=Z72.9^^136^1946^142
 ;;^UTILITY(U,$J,358.3,46356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46356,1,3,0)
 ;;=3^Problems Related to Lifestyle
 ;;^UTILITY(U,$J,358.3,46356,1,4,0)
 ;;=4^Z72.9
 ;;^UTILITY(U,$J,358.3,46356,2)
 ;;=^5063267
 ;;^UTILITY(U,$J,358.3,46357,0)
 ;;=Z73.6^^136^1946^124
 ;;^UTILITY(U,$J,358.3,46357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46357,1,3,0)
 ;;=3^Problems Related to Activity Limitations d/t Disability
 ;;^UTILITY(U,$J,358.3,46357,1,4,0)
 ;;=4^Z73.6
 ;;^UTILITY(U,$J,358.3,46357,2)
 ;;=^5063274
 ;;^UTILITY(U,$J,358.3,46358,0)
 ;;=Z60.2^^136^1946^143
 ;;^UTILITY(U,$J,358.3,46358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46358,1,3,0)
 ;;=3^Problems Related to Living Alone
 ;;^UTILITY(U,$J,358.3,46358,1,4,0)
 ;;=4^Z60.2
 ;;^UTILITY(U,$J,358.3,46358,2)
 ;;=^5063140
 ;;^UTILITY(U,$J,358.3,46359,0)
 ;;=Z59.3^^136^1946^144
 ;;^UTILITY(U,$J,358.3,46359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46359,1,3,0)
 ;;=3^Problems Related to Living in Residential Institution
 ;;^UTILITY(U,$J,358.3,46359,1,4,0)
 ;;=4^Z59.3
 ;;^UTILITY(U,$J,358.3,46359,2)
 ;;=^5063132
 ;;^UTILITY(U,$J,358.3,46360,0)
 ;;=Z59.6^^136^1946^145
 ;;^UTILITY(U,$J,358.3,46360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46360,1,3,0)
 ;;=3^Problems Related to Low Income
 ;;^UTILITY(U,$J,358.3,46360,1,4,0)
 ;;=4^Z59.6
 ;;^UTILITY(U,$J,358.3,46360,2)
 ;;=^5063135
 ;;^UTILITY(U,$J,358.3,46361,0)
 ;;=Z75.9^^136^1946^146
 ;;^UTILITY(U,$J,358.3,46361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46361,1,3,0)
 ;;=3^Problems Related to Med Facilities/Health Care
 ;;^UTILITY(U,$J,358.3,46361,1,4,0)
 ;;=4^Z75.9
 ;;^UTILITY(U,$J,358.3,46361,2)
 ;;=^5063296
 ;;^UTILITY(U,$J,358.3,46362,0)
 ;;=Z75.0^^136^1946^147
 ;;^UTILITY(U,$J,358.3,46362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46362,1,3,0)
 ;;=3^Problems Related to Med Services not Available in Home
 ;;^UTILITY(U,$J,358.3,46362,1,4,0)
 ;;=4^Z75.0
 ;;^UTILITY(U,$J,358.3,46362,2)
 ;;=^5063289
 ;;^UTILITY(U,$J,358.3,46363,0)
 ;;=Z74.2^^136^1946^149
 ;;^UTILITY(U,$J,358.3,46363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46363,1,3,0)
 ;;=3^Problems Related to Need for Assistance at Home
 ;;^UTILITY(U,$J,358.3,46363,1,4,0)
 ;;=4^Z74.2
 ;;^UTILITY(U,$J,358.3,46363,2)
 ;;=^5063285
 ;;^UTILITY(U,$J,358.3,46364,0)
 ;;=Z74.1^^136^1946^150
 ;;^UTILITY(U,$J,358.3,46364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46364,1,3,0)
 ;;=3^Problems Related to Need for Assistance w/ Personal Care
 ;;^UTILITY(U,$J,358.3,46364,1,4,0)
 ;;=4^Z74.1
 ;;^UTILITY(U,$J,358.3,46364,2)
 ;;=^5063284
 ;;^UTILITY(U,$J,358.3,46365,0)
 ;;=Z74.3^^136^1946^151
 ;;^UTILITY(U,$J,358.3,46365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46365,1,3,0)
 ;;=3^Problems Related to Need for Continuous Supervision
 ;;^UTILITY(U,$J,358.3,46365,1,4,0)
 ;;=4^Z74.3
 ;;^UTILITY(U,$J,358.3,46365,2)
 ;;=^5063286
 ;;^UTILITY(U,$J,358.3,46366,0)
 ;;=Z75.1^^136^1946^126
 ;;^UTILITY(U,$J,358.3,46366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46366,1,3,0)
 ;;=3^Problems Related to Awaiting Facility Admission
 ;;^UTILITY(U,$J,358.3,46366,1,4,0)
 ;;=4^Z75.1
 ;;^UTILITY(U,$J,358.3,46366,2)
 ;;=^5063290
 ;;^UTILITY(U,$J,358.3,46367,0)
 ;;=Z63.9^^136^1946^152
 ;;^UTILITY(U,$J,358.3,46367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46367,1,3,0)
 ;;=3^Problems Related to Primary Support Group
 ;;^UTILITY(U,$J,358.3,46367,1,4,0)
 ;;=4^Z63.9
 ;;^UTILITY(U,$J,358.3,46367,2)
 ;;=^5063175
 ;;^UTILITY(U,$J,358.3,46368,0)
 ;;=Z74.09^^136^1946^154
 ;;^UTILITY(U,$J,358.3,46368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46368,1,3,0)
 ;;=3^Problems Related to Reduced Mobility
 ;;^UTILITY(U,$J,358.3,46368,1,4,0)
 ;;=4^Z74.09
 ;;^UTILITY(U,$J,358.3,46368,2)
 ;;=^5063283
 ;;^UTILITY(U,$J,358.3,46369,0)
 ;;=Z60.9^^136^1946^156
 ;;^UTILITY(U,$J,358.3,46369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46369,1,3,0)
 ;;=3^Problems Related to Social Environment
 ;;^UTILITY(U,$J,358.3,46369,1,4,0)
 ;;=4^Z60.9
 ;;^UTILITY(U,$J,358.3,46369,2)
 ;;=^5063145
 ;;^UTILITY(U,$J,358.3,46370,0)
 ;;=Z60.4^^136^1946^157
 ;;^UTILITY(U,$J,358.3,46370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46370,1,3,0)
 ;;=3^Problems Related to Social Exclusion/Rejection
 ;;^UTILITY(U,$J,358.3,46370,1,4,0)
 ;;=4^Z60.4
 ;;^UTILITY(U,$J,358.3,46370,2)
 ;;=^5063142
 ;;^UTILITY(U,$J,358.3,46371,0)
 ;;=Z60.5^^136^1946^125
 ;;^UTILITY(U,$J,358.3,46371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46371,1,3,0)
 ;;=3^Problems Related to Adverse Discrimination/Persecution
 ;;^UTILITY(U,$J,358.3,46371,1,4,0)
 ;;=4^Z60.5
 ;;^UTILITY(U,$J,358.3,46371,2)
 ;;=^5063143
 ;;^UTILITY(U,$J,358.3,46372,0)
 ;;=Z75.3^^136^1946^158
 ;;^UTILITY(U,$J,358.3,46372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46372,1,3,0)
 ;;=3^Problems Related to Unavailability/Inaccessibility of Health-Care Facilities
 ;;^UTILITY(U,$J,358.3,46372,1,4,0)
 ;;=4^Z75.3
 ;;^UTILITY(U,$J,358.3,46372,2)
 ;;=^5063292
 ;;^UTILITY(U,$J,358.3,46373,0)
 ;;=Z75.4^^136^1946^159
 ;;^UTILITY(U,$J,358.3,46373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46373,1,3,0)
 ;;=3^Problems Related to Unavailability/Inaccessibility of Helping Agencies
 ;;^UTILITY(U,$J,358.3,46373,1,4,0)
 ;;=4^Z75.4
 ;;^UTILITY(U,$J,358.3,46373,2)
 ;;=^5063293
 ;;^UTILITY(U,$J,358.3,46374,0)
 ;;=Z65.9^^136^1946^153
 ;;^UTILITY(U,$J,358.3,46374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46374,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,46374,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,46374,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,46375,0)
 ;;=Z75.2^^136^1946^160
 ;;^UTILITY(U,$J,358.3,46375,1,0)
 ;;=^358.31IA^4^2
