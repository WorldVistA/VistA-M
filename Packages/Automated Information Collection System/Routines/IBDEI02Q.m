IBDEI02Q ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3225,1,3,0)
 ;;=3^Noncompliance w/ Renal Dialysis
 ;;^UTILITY(U,$J,358.3,3225,1,4,0)
 ;;=4^Z91.15
 ;;^UTILITY(U,$J,358.3,3225,2)
 ;;=^5063617
 ;;^UTILITY(U,$J,358.3,3226,0)
 ;;=Z56.0^^15^137^14
 ;;^UTILITY(U,$J,358.3,3226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3226,1,3,0)
 ;;=3^Unemployment,Unspec
 ;;^UTILITY(U,$J,358.3,3226,1,4,0)
 ;;=4^Z56.0
 ;;^UTILITY(U,$J,358.3,3226,2)
 ;;=^5063107
 ;;^UTILITY(U,$J,358.3,3227,0)
 ;;=Z65.5^^15^137^4
 ;;^UTILITY(U,$J,358.3,3227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3227,1,3,0)
 ;;=3^Disaster/War/Hostility Exposure
 ;;^UTILITY(U,$J,358.3,3227,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,3227,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,3228,0)
 ;;=Z56.1^^15^137^2
 ;;^UTILITY(U,$J,358.3,3228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3228,1,3,0)
 ;;=3^Change of Job
 ;;^UTILITY(U,$J,358.3,3228,1,4,0)
 ;;=4^Z56.1
 ;;^UTILITY(U,$J,358.3,3228,2)
 ;;=^5063108
 ;;^UTILITY(U,$J,358.3,3229,0)
 ;;=Z55.9^^15^137^5
 ;;^UTILITY(U,$J,358.3,3229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3229,1,3,0)
 ;;=3^Education/Literacy Problems,Unspec
 ;;^UTILITY(U,$J,358.3,3229,1,4,0)
 ;;=4^Z55.9
 ;;^UTILITY(U,$J,358.3,3229,2)
 ;;=^5063106
 ;;^UTILITY(U,$J,358.3,3230,0)
 ;;=Z60.3^^15^137^1
 ;;^UTILITY(U,$J,358.3,3230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3230,1,3,0)
 ;;=3^Acculturation Difficulty
 ;;^UTILITY(U,$J,358.3,3230,1,4,0)
 ;;=4^Z60.3
 ;;^UTILITY(U,$J,358.3,3230,2)
 ;;=^5063141
 ;;^UTILITY(U,$J,358.3,3231,0)
 ;;=Z65.3^^15^137^8
 ;;^UTILITY(U,$J,358.3,3231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3231,1,3,0)
 ;;=3^Legal Circumstance Problems
 ;;^UTILITY(U,$J,358.3,3231,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,3231,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,3232,0)
 ;;=Z53.1^^15^137^11
 ;;^UTILITY(U,$J,358.3,3232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3232,1,3,0)
 ;;=3^Procedure/Treatment not Done d/t Pt Belief/Group Pressure
 ;;^UTILITY(U,$J,358.3,3232,1,4,0)
 ;;=4^Z53.1
 ;;^UTILITY(U,$J,358.3,3232,2)
 ;;=^5063094
 ;;^UTILITY(U,$J,358.3,3233,0)
 ;;=Z63.4^^15^137^3
 ;;^UTILITY(U,$J,358.3,3233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3233,1,3,0)
 ;;=3^Disappearance/Death of Family Member
 ;;^UTILITY(U,$J,358.3,3233,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,3233,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,3234,0)
 ;;=Z69.021^^15^137^10
 ;;^UTILITY(U,$J,358.3,3234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3234,1,3,0)
 ;;=3^Mental Hlth Svc for Perpetrator of Non-Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,3234,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,3234,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,3235,0)
 ;;=Z69.82^^15^137^9
 ;;^UTILITY(U,$J,358.3,3235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3235,1,3,0)
 ;;=3^Mental Hlth Svc for Perpetrator of Abuse
 ;;^UTILITY(U,$J,358.3,3235,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,3235,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,3236,0)
 ;;=R45.851^^15^137^13
 ;;^UTILITY(U,$J,358.3,3236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3236,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,3236,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,3236,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,3237,0)
 ;;=Z65.9^^15^137^12
 ;;^UTILITY(U,$J,358.3,3237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3237,1,3,0)
 ;;=3^Psychosocial Circumstance Problems,Unspec
 ;;^UTILITY(U,$J,358.3,3237,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,3237,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,3238,0)
 ;;=Z56.9^^15^137^6
 ;;^UTILITY(U,$J,358.3,3238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3238,1,3,0)
 ;;=3^Employment Problems,Unspec
 ;;^UTILITY(U,$J,358.3,3238,1,4,0)
 ;;=4^Z56.9
 ;;^UTILITY(U,$J,358.3,3238,2)
 ;;=^5063117
 ;;^UTILITY(U,$J,358.3,3239,0)
 ;;=R45.850^^15^137^7
 ;;^UTILITY(U,$J,358.3,3239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3239,1,3,0)
 ;;=3^Homicidal Ideations
 ;;^UTILITY(U,$J,358.3,3239,1,4,0)
 ;;=4^R45.850
 ;;^UTILITY(U,$J,358.3,3239,2)
 ;;=^5019473
 ;;^UTILITY(U,$J,358.3,3240,0)
 ;;=Z98.89^^15^138^13
 ;;^UTILITY(U,$J,358.3,3240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3240,1,3,0)
 ;;=3^Postprocedural States,Oth Spec
 ;;^UTILITY(U,$J,358.3,3240,1,4,0)
 ;;=4^Z98.89
 ;;^UTILITY(U,$J,358.3,3240,2)
 ;;=^5063754
 ;;^UTILITY(U,$J,358.3,3241,0)
 ;;=Z92.3^^15^138^9
 ;;^UTILITY(U,$J,358.3,3241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3241,1,3,0)
 ;;=3^Personal Hx of Irradiation
 ;;^UTILITY(U,$J,358.3,3241,1,4,0)
 ;;=4^Z92.3
 ;;^UTILITY(U,$J,358.3,3241,2)
 ;;=^5063637
 ;;^UTILITY(U,$J,358.3,3242,0)
 ;;=Z91.410^^15^138^7
 ;;^UTILITY(U,$J,358.3,3242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3242,1,3,0)
 ;;=3^Personal Hx of Adult Physical/Sexual Abuse
 ;;^UTILITY(U,$J,358.3,3242,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,3242,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,3243,0)
 ;;=Z91.411^^15^138^8
 ;;^UTILITY(U,$J,358.3,3243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3243,1,3,0)
 ;;=3^Personal Hx of Adult Psychological Abuse
 ;;^UTILITY(U,$J,358.3,3243,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,3243,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,3244,0)
 ;;=Z91.49^^15^138^11
 ;;^UTILITY(U,$J,358.3,3244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3244,1,3,0)
 ;;=3^Personal Hx of Psychological Trauma NEC
 ;;^UTILITY(U,$J,358.3,3244,1,4,0)
 ;;=4^Z91.49
 ;;^UTILITY(U,$J,358.3,3244,2)
 ;;=^5063623
 ;;^UTILITY(U,$J,358.3,3245,0)
 ;;=Z91.19^^15^138^5
 ;;^UTILITY(U,$J,358.3,3245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3245,1,3,0)
 ;;=3^Noncompliance w/ Medical Treatment/Regimen
 ;;^UTILITY(U,$J,358.3,3245,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,3245,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,3246,0)
 ;;=Z87.891^^15^138^10
 ;;^UTILITY(U,$J,358.3,3246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3246,1,3,0)
 ;;=3^Personal Hx of Nicotine Dependence
 ;;^UTILITY(U,$J,358.3,3246,1,4,0)
 ;;=4^Z87.891
 ;;^UTILITY(U,$J,358.3,3246,2)
 ;;=^5063518
 ;;^UTILITY(U,$J,358.3,3247,0)
 ;;=Z77.090^^15^138^1
 ;;^UTILITY(U,$J,358.3,3247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3247,1,3,0)
 ;;=3^Asbestos Contact/Exposure
 ;;^UTILITY(U,$J,358.3,3247,1,4,0)
 ;;=4^Z77.090
 ;;^UTILITY(U,$J,358.3,3247,2)
 ;;=^5063312
 ;;^UTILITY(U,$J,358.3,3248,0)
 ;;=Z91.81^^15^138^3
 ;;^UTILITY(U,$J,358.3,3248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3248,1,3,0)
 ;;=3^History of Falling
 ;;^UTILITY(U,$J,358.3,3248,1,4,0)
 ;;=4^Z91.81
 ;;^UTILITY(U,$J,358.3,3248,2)
 ;;=^5063625
 ;;^UTILITY(U,$J,358.3,3249,0)
 ;;=Z57.8^^15^138^6
 ;;^UTILITY(U,$J,358.3,3249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3249,1,3,0)
 ;;=3^Occupational Risk Factor Exposure
 ;;^UTILITY(U,$J,358.3,3249,1,4,0)
 ;;=4^Z57.8
 ;;^UTILITY(U,$J,358.3,3249,2)
 ;;=^5063127
 ;;^UTILITY(U,$J,358.3,3250,0)
 ;;=Z77.011^^15^138^4
 ;;^UTILITY(U,$J,358.3,3250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3250,1,3,0)
 ;;=3^Lead Contact/Exposure
 ;;^UTILITY(U,$J,358.3,3250,1,4,0)
 ;;=4^Z77.011
 ;;^UTILITY(U,$J,358.3,3250,2)
 ;;=^5063306
 ;;^UTILITY(U,$J,358.3,3251,0)
 ;;=Z77.9^^15^138^2
 ;;^UTILITY(U,$J,358.3,3251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3251,1,3,0)
 ;;=3^Hazardous to Health Contact/Exposures
 ;;^UTILITY(U,$J,358.3,3251,1,4,0)
 ;;=4^Z77.9
 ;;^UTILITY(U,$J,358.3,3251,2)
 ;;=^5063326
 ;;^UTILITY(U,$J,358.3,3252,0)
 ;;=Z91.89^^15^138^12
 ;;^UTILITY(U,$J,358.3,3252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3252,1,3,0)
 ;;=3^Personal Risk Factors NEC
 ;;^UTILITY(U,$J,358.3,3252,1,4,0)
 ;;=4^Z91.89
 ;;^UTILITY(U,$J,358.3,3252,2)
 ;;=^5063628
 ;;^UTILITY(U,$J,358.3,3253,0)
 ;;=Z76.3^^15^139^7
 ;;^UTILITY(U,$J,358.3,3253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3253,1,3,0)
 ;;=3^Healthy Person Accompanying Sick Person
 ;;^UTILITY(U,$J,358.3,3253,1,4,0)
 ;;=4^Z76.3
 ;;^UTILITY(U,$J,358.3,3253,2)
 ;;=^5063300
 ;;^UTILITY(U,$J,358.3,3254,0)
 ;;=Z71.0^^15^139^5
 ;;^UTILITY(U,$J,358.3,3254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3254,1,3,0)
 ;;=3^Health Service Consult on Behalf of Another Person
 ;;^UTILITY(U,$J,358.3,3254,1,4,0)
 ;;=4^Z71.0
 ;;^UTILITY(U,$J,358.3,3254,2)
 ;;=^5063242
 ;;^UTILITY(U,$J,358.3,3255,0)
 ;;=Z76.5^^15^139^8
 ;;^UTILITY(U,$J,358.3,3255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3255,1,3,0)
 ;;=3^Malingerer
 ;;^UTILITY(U,$J,358.3,3255,1,4,0)
 ;;=4^Z76.5
 ;;^UTILITY(U,$J,358.3,3255,2)
 ;;=^5063302
 ;;^UTILITY(U,$J,358.3,3256,0)
 ;;=Z71.9^^15^139^3
 ;;^UTILITY(U,$J,358.3,3256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3256,1,3,0)
 ;;=3^Counseling,Unspec
 ;;^UTILITY(U,$J,358.3,3256,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,3256,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,3257,0)
 ;;=Z71.41^^15^139^1
 ;;^UTILITY(U,$J,358.3,3257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3257,1,3,0)
 ;;=3^Alcohol Abuse Counseling/Surveillance of Alcoholic
 ;;^UTILITY(U,$J,358.3,3257,1,4,0)
 ;;=4^Z71.41
 ;;^UTILITY(U,$J,358.3,3257,2)
 ;;=^5063246
 ;;^UTILITY(U,$J,358.3,3258,0)
 ;;=Z71.89^^15^139^2
 ;;^UTILITY(U,$J,358.3,3258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3258,1,3,0)
 ;;=3^Counseling,Oth Spec
 ;;^UTILITY(U,$J,358.3,3258,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,3258,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,3259,0)
 ;;=Z71.7^^15^139^4
 ;;^UTILITY(U,$J,358.3,3259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3259,1,3,0)
 ;;=3^HIV Counseling
 ;;^UTILITY(U,$J,358.3,3259,1,4,0)
 ;;=4^Z71.7
 ;;^UTILITY(U,$J,358.3,3259,2)
 ;;=^5063251
 ;;^UTILITY(U,$J,358.3,3260,0)
 ;;=Z76.89^^15^139^6
 ;;^UTILITY(U,$J,358.3,3260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3260,1,3,0)
 ;;=3^Health Services in Oth Circumstances
 ;;^UTILITY(U,$J,358.3,3260,1,4,0)
 ;;=4^Z76.89
 ;;^UTILITY(U,$J,358.3,3260,2)
 ;;=^5063304
 ;;^UTILITY(U,$J,358.3,3261,0)
 ;;=Z72.51^^15^140^2
 ;;^UTILITY(U,$J,358.3,3261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3261,1,3,0)
 ;;=3^High Risk Heterosexual Behavior
 ;;^UTILITY(U,$J,358.3,3261,1,4,0)
 ;;=4^Z72.51
 ;;^UTILITY(U,$J,358.3,3261,2)
 ;;=^5063258
