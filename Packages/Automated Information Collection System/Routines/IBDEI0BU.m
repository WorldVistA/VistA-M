IBDEI0BU ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15022,0)
 ;;=Z62.810^^45^666^8
 ;;^UTILITY(U,$J,358.3,15022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15022,1,3,0)
 ;;=3^Personal Hx of Childhood Physical Abuse
 ;;^UTILITY(U,$J,358.3,15022,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,15022,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,15023,0)
 ;;=Z91.83^^45^666^22
 ;;^UTILITY(U,$J,358.3,15023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15023,1,3,0)
 ;;=3^Wandering Associated w/ a Mental Disorder
 ;;^UTILITY(U,$J,358.3,15023,1,4,0)
 ;;=4^Z91.83
 ;;^UTILITY(U,$J,358.3,15023,2)
 ;;=^5063627
 ;;^UTILITY(U,$J,358.3,15024,0)
 ;;=Z62.810^^45^666^10
 ;;^UTILITY(U,$J,358.3,15024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15024,1,3,0)
 ;;=3^Personal Hx of Childhood Sexual Abuse
 ;;^UTILITY(U,$J,358.3,15024,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,15024,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,15025,0)
 ;;=Z91.412^^45^666^14
 ;;^UTILITY(U,$J,358.3,15025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15025,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,15025,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,15025,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,15026,0)
 ;;=Z91.411^^45^666^15
 ;;^UTILITY(U,$J,358.3,15026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15026,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,15026,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,15026,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,15027,0)
 ;;=Z91.410^^45^666^16
 ;;^UTILITY(U,$J,358.3,15027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15027,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Violence,Physical
 ;;^UTILITY(U,$J,358.3,15027,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,15027,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,15028,0)
 ;;=Z91.410^^45^666^17
 ;;^UTILITY(U,$J,358.3,15028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15028,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,15028,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,15028,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,15029,0)
 ;;=Z75.3^^45^666^20
 ;;^UTILITY(U,$J,358.3,15029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15029,1,3,0)
 ;;=3^Unavailability/Inaccessibility of Health Care Facilities
 ;;^UTILITY(U,$J,358.3,15029,1,4,0)
 ;;=4^Z75.3
 ;;^UTILITY(U,$J,358.3,15029,2)
 ;;=^5063292
 ;;^UTILITY(U,$J,358.3,15030,0)
 ;;=Z75.4^^45^666^21
 ;;^UTILITY(U,$J,358.3,15030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15030,1,3,0)
 ;;=3^Unavailability/Inaccessibility of Other Helping Agencies
 ;;^UTILITY(U,$J,358.3,15030,1,4,0)
 ;;=4^Z75.4
 ;;^UTILITY(U,$J,358.3,15030,2)
 ;;=^5063293
 ;;^UTILITY(U,$J,358.3,15031,0)
 ;;=Z70.9^^45^667^2
 ;;^UTILITY(U,$J,358.3,15031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15031,1,3,0)
 ;;=3^Sex Counseling
 ;;^UTILITY(U,$J,358.3,15031,1,4,0)
 ;;=4^Z70.9
 ;;^UTILITY(U,$J,358.3,15031,2)
 ;;=^5063241
 ;;^UTILITY(U,$J,358.3,15032,0)
 ;;=Z71.9^^45^667^1
 ;;^UTILITY(U,$J,358.3,15032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15032,1,3,0)
 ;;=3^Counseling or Consultation,Other
 ;;^UTILITY(U,$J,358.3,15032,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,15032,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,15033,0)
 ;;=Z60.0^^45^668^2
 ;;^UTILITY(U,$J,358.3,15033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15033,1,3,0)
 ;;=3^Phase of Life Problem
 ;;^UTILITY(U,$J,358.3,15033,1,4,0)
 ;;=4^Z60.0
 ;;^UTILITY(U,$J,358.3,15033,2)
 ;;=^5063139
 ;;^UTILITY(U,$J,358.3,15034,0)
 ;;=Z60.2^^45^668^3
 ;;^UTILITY(U,$J,358.3,15034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15034,1,3,0)
 ;;=3^Problem Related to Living Alone
 ;;^UTILITY(U,$J,358.3,15034,1,4,0)
 ;;=4^Z60.2
 ;;^UTILITY(U,$J,358.3,15034,2)
 ;;=^5063140
 ;;^UTILITY(U,$J,358.3,15035,0)
 ;;=Z60.3^^45^668^1
 ;;^UTILITY(U,$J,358.3,15035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15035,1,3,0)
 ;;=3^Acculturation Difficulty
 ;;^UTILITY(U,$J,358.3,15035,1,4,0)
 ;;=4^Z60.3
 ;;^UTILITY(U,$J,358.3,15035,2)
 ;;=^5063141
 ;;^UTILITY(U,$J,358.3,15036,0)
 ;;=Z60.4^^45^668^5
 ;;^UTILITY(U,$J,358.3,15036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15036,1,3,0)
 ;;=3^Social Exclusion or Rejection
 ;;^UTILITY(U,$J,358.3,15036,1,4,0)
 ;;=4^Z60.4
 ;;^UTILITY(U,$J,358.3,15036,2)
 ;;=^5063142
 ;;^UTILITY(U,$J,358.3,15037,0)
 ;;=Z60.5^^45^668^6
 ;;^UTILITY(U,$J,358.3,15037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15037,1,3,0)
 ;;=3^Target of (Perceived) Adverse Discrimination or Persecution
 ;;^UTILITY(U,$J,358.3,15037,1,4,0)
 ;;=4^Z60.5
 ;;^UTILITY(U,$J,358.3,15037,2)
 ;;=^5063143
 ;;^UTILITY(U,$J,358.3,15038,0)
 ;;=Z60.9^^45^668^4
 ;;^UTILITY(U,$J,358.3,15038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15038,1,3,0)
 ;;=3^Problem Related to Social Environment,Unspec
 ;;^UTILITY(U,$J,358.3,15038,1,4,0)
 ;;=4^Z60.9
 ;;^UTILITY(U,$J,358.3,15038,2)
 ;;=^5063145
 ;;^UTILITY(U,$J,358.3,15039,0)
 ;;=F65.4^^45^669^6
 ;;^UTILITY(U,$J,358.3,15039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15039,1,3,0)
 ;;=3^Pedophilica Disorder
 ;;^UTILITY(U,$J,358.3,15039,1,4,0)
 ;;=4^F65.4
 ;;^UTILITY(U,$J,358.3,15039,2)
 ;;=^5003655
 ;;^UTILITY(U,$J,358.3,15040,0)
 ;;=F65.2^^45^669^1
 ;;^UTILITY(U,$J,358.3,15040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15040,1,3,0)
 ;;=3^Exhibitionistic Disorder
 ;;^UTILITY(U,$J,358.3,15040,1,4,0)
 ;;=4^F65.2
 ;;^UTILITY(U,$J,358.3,15040,2)
 ;;=^5003653
 ;;^UTILITY(U,$J,358.3,15041,0)
 ;;=F65.3^^45^669^10
 ;;^UTILITY(U,$J,358.3,15041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15041,1,3,0)
 ;;=3^Voyeuristic Disorder
 ;;^UTILITY(U,$J,358.3,15041,1,4,0)
 ;;=4^F65.3
 ;;^UTILITY(U,$J,358.3,15041,2)
 ;;=^5003654
 ;;^UTILITY(U,$J,358.3,15042,0)
 ;;=F65.81^^45^669^3
 ;;^UTILITY(U,$J,358.3,15042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15042,1,3,0)
 ;;=3^Frotteuristic Disorder
 ;;^UTILITY(U,$J,358.3,15042,1,4,0)
 ;;=4^F65.81
 ;;^UTILITY(U,$J,358.3,15042,2)
 ;;=^5003659
 ;;^UTILITY(U,$J,358.3,15043,0)
 ;;=F65.51^^45^669^7
 ;;^UTILITY(U,$J,358.3,15043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15043,1,3,0)
 ;;=3^Sexual Masochism Disorder
 ;;^UTILITY(U,$J,358.3,15043,1,4,0)
 ;;=4^F65.51
 ;;^UTILITY(U,$J,358.3,15043,2)
 ;;=^5003657
 ;;^UTILITY(U,$J,358.3,15044,0)
 ;;=F65.52^^45^669^8
 ;;^UTILITY(U,$J,358.3,15044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15044,1,3,0)
 ;;=3^Sexual Sadism Disorder
 ;;^UTILITY(U,$J,358.3,15044,1,4,0)
 ;;=4^F65.52
 ;;^UTILITY(U,$J,358.3,15044,2)
 ;;=^5003658
 ;;^UTILITY(U,$J,358.3,15045,0)
 ;;=F65.0^^45^669^2
 ;;^UTILITY(U,$J,358.3,15045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15045,1,3,0)
 ;;=3^Fetishistic Disorder
 ;;^UTILITY(U,$J,358.3,15045,1,4,0)
 ;;=4^F65.0
 ;;^UTILITY(U,$J,358.3,15045,2)
 ;;=^5003651
 ;;^UTILITY(U,$J,358.3,15046,0)
 ;;=F65.1^^45^669^9
 ;;^UTILITY(U,$J,358.3,15046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15046,1,3,0)
 ;;=3^Transvestic Disorder
 ;;^UTILITY(U,$J,358.3,15046,1,4,0)
 ;;=4^F65.1
 ;;^UTILITY(U,$J,358.3,15046,2)
 ;;=^5003652
 ;;^UTILITY(U,$J,358.3,15047,0)
 ;;=F65.89^^45^669^4
 ;;^UTILITY(U,$J,358.3,15047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15047,1,3,0)
 ;;=3^Paraphilic Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,15047,1,4,0)
 ;;=4^F65.89
 ;;^UTILITY(U,$J,358.3,15047,2)
 ;;=^5003660
 ;;^UTILITY(U,$J,358.3,15048,0)
 ;;=F65.9^^45^669^5
 ;;^UTILITY(U,$J,358.3,15048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15048,1,3,0)
 ;;=3^Paraphilic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15048,1,4,0)
 ;;=4^F65.9
 ;;^UTILITY(U,$J,358.3,15048,2)
 ;;=^5003661
 ;;^UTILITY(U,$J,358.3,15049,0)
 ;;=F60.0^^45^670^8
 ;;^UTILITY(U,$J,358.3,15049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15049,1,3,0)
 ;;=3^Paranoid Personality Disorder
 ;;^UTILITY(U,$J,358.3,15049,1,4,0)
 ;;=4^F60.0
 ;;^UTILITY(U,$J,358.3,15049,2)
 ;;=^5003635
 ;;^UTILITY(U,$J,358.3,15050,0)
 ;;=F60.1^^45^670^12
 ;;^UTILITY(U,$J,358.3,15050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15050,1,3,0)
 ;;=3^Schizoid Personality Disorder
 ;;^UTILITY(U,$J,358.3,15050,1,4,0)
 ;;=4^F60.1
 ;;^UTILITY(U,$J,358.3,15050,2)
 ;;=^108271
 ;;^UTILITY(U,$J,358.3,15051,0)
 ;;=F21.^^45^670^13
 ;;^UTILITY(U,$J,358.3,15051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15051,1,3,0)
 ;;=3^Schizotypal Personality Disorder
 ;;^UTILITY(U,$J,358.3,15051,1,4,0)
 ;;=4^F21.
 ;;^UTILITY(U,$J,358.3,15051,2)
 ;;=^5003477
 ;;^UTILITY(U,$J,358.3,15052,0)
 ;;=F60.5^^45^670^7
 ;;^UTILITY(U,$J,358.3,15052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15052,1,3,0)
 ;;=3^Obsessive-Compulsive Personality Disorder
 ;;^UTILITY(U,$J,358.3,15052,1,4,0)
 ;;=4^F60.5
 ;;^UTILITY(U,$J,358.3,15052,2)
 ;;=^331918
 ;;^UTILITY(U,$J,358.3,15053,0)
 ;;=F60.4^^45^670^5
 ;;^UTILITY(U,$J,358.3,15053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15053,1,3,0)
 ;;=3^Histrionic Personality Disorder
 ;;^UTILITY(U,$J,358.3,15053,1,4,0)
 ;;=4^F60.4
 ;;^UTILITY(U,$J,358.3,15053,2)
 ;;=^5003636
 ;;^UTILITY(U,$J,358.3,15054,0)
 ;;=F60.7^^45^670^4
 ;;^UTILITY(U,$J,358.3,15054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15054,1,3,0)
 ;;=3^Dependent Personality Disorder
 ;;^UTILITY(U,$J,358.3,15054,1,4,0)
 ;;=4^F60.7
 ;;^UTILITY(U,$J,358.3,15054,2)
 ;;=^5003637
 ;;^UTILITY(U,$J,358.3,15055,0)
 ;;=F60.2^^45^670^1
 ;;^UTILITY(U,$J,358.3,15055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15055,1,3,0)
 ;;=3^Antisocial Personality Disorder
 ;;^UTILITY(U,$J,358.3,15055,1,4,0)
 ;;=4^F60.2
 ;;^UTILITY(U,$J,358.3,15055,2)
 ;;=^9066
 ;;^UTILITY(U,$J,358.3,15056,0)
 ;;=F60.81^^45^670^6
 ;;^UTILITY(U,$J,358.3,15056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15056,1,3,0)
 ;;=3^Narcissistic Personality Disorder
 ;;^UTILITY(U,$J,358.3,15056,1,4,0)
 ;;=4^F60.81
 ;;^UTILITY(U,$J,358.3,15056,2)
 ;;=^331919
 ;;^UTILITY(U,$J,358.3,15057,0)
 ;;=F60.6^^45^670^2
 ;;^UTILITY(U,$J,358.3,15057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15057,1,3,0)
 ;;=3^Avoidant Personality Disorder
 ;;^UTILITY(U,$J,358.3,15057,1,4,0)
 ;;=4^F60.6
