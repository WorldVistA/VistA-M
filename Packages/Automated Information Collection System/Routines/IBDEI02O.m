IBDEI02O ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3151,1,4,0)
 ;;=4^Z75.5
 ;;^UTILITY(U,$J,358.3,3151,2)
 ;;=^5063294
 ;;^UTILITY(U,$J,358.3,3152,0)
 ;;=Z56.0^^13^128^10
 ;;^UTILITY(U,$J,358.3,3152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3152,1,3,0)
 ;;=3^Unemployment,Unspec
 ;;^UTILITY(U,$J,358.3,3152,1,4,0)
 ;;=4^Z56.0
 ;;^UTILITY(U,$J,358.3,3152,2)
 ;;=^5063107
 ;;^UTILITY(U,$J,358.3,3153,0)
 ;;=Z65.5^^13^128^1
 ;;^UTILITY(U,$J,358.3,3153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3153,1,3,0)
 ;;=3^Exposure to Disaster/War/Oth Hostilities
 ;;^UTILITY(U,$J,358.3,3153,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,3153,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,3154,0)
 ;;=Z65.3^^13^128^6
 ;;^UTILITY(U,$J,358.3,3154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3154,1,3,0)
 ;;=3^Legal Circumstance Problems
 ;;^UTILITY(U,$J,358.3,3154,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,3154,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,3155,0)
 ;;=Z65.8^^13^128^9
 ;;^UTILITY(U,$J,358.3,3155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3155,1,3,0)
 ;;=3^Psychosocial Circumstance Problems
 ;;^UTILITY(U,$J,358.3,3155,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,3155,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,3156,0)
 ;;=Z75.0^^13^128^7
 ;;^UTILITY(U,$J,358.3,3156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3156,1,3,0)
 ;;=3^Medical Services Not Available in Home
 ;;^UTILITY(U,$J,358.3,3156,1,4,0)
 ;;=4^Z75.0
 ;;^UTILITY(U,$J,358.3,3156,2)
 ;;=^5063289
 ;;^UTILITY(U,$J,358.3,3157,0)
 ;;=R94.8^^14^129^4
 ;;^UTILITY(U,$J,358.3,3157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3157,1,3,0)
 ;;=3^Abnormal Results of Function Studies or Organs/Systems
 ;;^UTILITY(U,$J,358.3,3157,1,4,0)
 ;;=4^R94.8
 ;;^UTILITY(U,$J,358.3,3157,2)
 ;;=^5019745
 ;;^UTILITY(U,$J,358.3,3158,0)
 ;;=E10.9^^14^129^7
 ;;^UTILITY(U,$J,358.3,3158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3158,1,3,0)
 ;;=3^Diabetes Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,3158,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,3158,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,3159,0)
 ;;=E11.9^^14^129^8
 ;;^UTILITY(U,$J,358.3,3159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3159,1,3,0)
 ;;=3^Diabetes Type 2 w/o Complications
 ;;^UTILITY(U,$J,358.3,3159,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,3159,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,3160,0)
 ;;=I10.^^14^129^10
 ;;^UTILITY(U,$J,358.3,3160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3160,1,3,0)
 ;;=3^Hypertension,Essential
 ;;^UTILITY(U,$J,358.3,3160,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,3160,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,3161,0)
 ;;=R73.09^^14^129^3
 ;;^UTILITY(U,$J,358.3,3161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3161,1,3,0)
 ;;=3^Abnormal Glucose
 ;;^UTILITY(U,$J,358.3,3161,1,4,0)
 ;;=4^R73.09
 ;;^UTILITY(U,$J,358.3,3161,2)
 ;;=^5019563
 ;;^UTILITY(U,$J,358.3,3162,0)
 ;;=R79.89^^14^129^1
 ;;^UTILITY(U,$J,358.3,3162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3162,1,3,0)
 ;;=3^Abnormal Finding of Blood Chemistry
 ;;^UTILITY(U,$J,358.3,3162,1,4,0)
 ;;=4^R79.89
 ;;^UTILITY(U,$J,358.3,3162,2)
 ;;=^5019593
 ;;^UTILITY(U,$J,358.3,3163,0)
 ;;=R93.8^^14^129^2
 ;;^UTILITY(U,$J,358.3,3163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3163,1,3,0)
 ;;=3^Abnormal Findings on Diagnostic Imaging
 ;;^UTILITY(U,$J,358.3,3163,1,4,0)
 ;;=4^R93.8
 ;;^UTILITY(U,$J,358.3,3163,2)
 ;;=^5019721
 ;;^UTILITY(U,$J,358.3,3164,0)
 ;;=R68.89^^14^129^9
 ;;^UTILITY(U,$J,358.3,3164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3164,1,3,0)
 ;;=3^General Symptoms and Signs
 ;;^UTILITY(U,$J,358.3,3164,1,4,0)
 ;;=4^R68.89
 ;;^UTILITY(U,$J,358.3,3164,2)
 ;;=^5019557
 ;;^UTILITY(U,$J,358.3,3165,0)
 ;;=Z98.89^^14^129^13
 ;;^UTILITY(U,$J,358.3,3165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3165,1,3,0)
 ;;=3^Postprocedural States
 ;;^UTILITY(U,$J,358.3,3165,1,4,0)
 ;;=4^Z98.89
 ;;^UTILITY(U,$J,358.3,3165,2)
 ;;=^5063754
 ;;^UTILITY(U,$J,358.3,3166,0)
 ;;=Z79.01^^14^129^12
 ;;^UTILITY(U,$J,358.3,3166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3166,1,3,0)
 ;;=3^Long Term (Current) Use of Anticoagulants
 ;;^UTILITY(U,$J,358.3,3166,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,3166,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,3167,0)
 ;;=Z51.81^^14^129^16
 ;;^UTILITY(U,$J,358.3,3167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3167,1,3,0)
 ;;=3^Therapeutic Drug Level Monitoring
 ;;^UTILITY(U,$J,358.3,3167,1,4,0)
 ;;=4^Z51.81
 ;;^UTILITY(U,$J,358.3,3167,2)
 ;;=^5063064
 ;;^UTILITY(U,$J,358.3,3168,0)
 ;;=Z63.4^^14^129^5
 ;;^UTILITY(U,$J,358.3,3168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3168,1,3,0)
 ;;=3^Bereavement
 ;;^UTILITY(U,$J,358.3,3168,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,3168,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,3169,0)
 ;;=Z71.89^^14^129^6
 ;;^UTILITY(U,$J,358.3,3169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3169,1,3,0)
 ;;=3^Counseling,Specified
 ;;^UTILITY(U,$J,358.3,3169,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,3169,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,3170,0)
 ;;=Z76.0^^14^129^11
 ;;^UTILITY(U,$J,358.3,3170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3170,1,3,0)
 ;;=3^Issue of Repeat Prescription
 ;;^UTILITY(U,$J,358.3,3170,1,4,0)
 ;;=4^Z76.0
 ;;^UTILITY(U,$J,358.3,3170,2)
 ;;=^5063297
 ;;^UTILITY(U,$J,358.3,3171,0)
 ;;=Z01.818^^14^129^14
 ;;^UTILITY(U,$J,358.3,3171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3171,1,3,0)
 ;;=3^Preprocedural Examination
 ;;^UTILITY(U,$J,358.3,3171,1,4,0)
 ;;=4^Z01.818
 ;;^UTILITY(U,$J,358.3,3171,2)
 ;;=^5062628
 ;;^UTILITY(U,$J,358.3,3172,0)
 ;;=Z01.812^^14^129^15
 ;;^UTILITY(U,$J,358.3,3172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3172,1,3,0)
 ;;=3^Preprocedural Lab Examination/Results
 ;;^UTILITY(U,$J,358.3,3172,1,4,0)
 ;;=4^Z01.812
 ;;^UTILITY(U,$J,358.3,3172,2)
 ;;=^5062627
 ;;^UTILITY(U,$J,358.3,3173,0)
 ;;=Z02.71^^15^130^2
 ;;^UTILITY(U,$J,358.3,3173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3173,1,3,0)
 ;;=3^Disability Determination Exam
 ;;^UTILITY(U,$J,358.3,3173,1,4,0)
 ;;=4^Z02.71
 ;;^UTILITY(U,$J,358.3,3173,2)
 ;;=^5062640
 ;;^UTILITY(U,$J,358.3,3174,0)
 ;;=Z02.79^^15^130^4
 ;;^UTILITY(U,$J,358.3,3174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3174,1,3,0)
 ;;=3^Issue of Medical Certificate
 ;;^UTILITY(U,$J,358.3,3174,1,4,0)
 ;;=4^Z02.79
 ;;^UTILITY(U,$J,358.3,3174,2)
 ;;=^5062641
 ;;^UTILITY(U,$J,358.3,3175,0)
 ;;=Z04.9^^15^130^3
 ;;^UTILITY(U,$J,358.3,3175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3175,1,3,0)
 ;;=3^Exam & Observation for Unspec Reason
 ;;^UTILITY(U,$J,358.3,3175,1,4,0)
 ;;=4^Z04.9
 ;;^UTILITY(U,$J,358.3,3175,2)
 ;;=^5062666
 ;;^UTILITY(U,$J,358.3,3176,0)
 ;;=Z02.9^^15^130^1
 ;;^UTILITY(U,$J,358.3,3176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3176,1,3,0)
 ;;=3^Adminstrative Exams,Unspec
 ;;^UTILITY(U,$J,358.3,3176,1,4,0)
 ;;=4^Z02.9
 ;;^UTILITY(U,$J,358.3,3176,2)
 ;;=^5062646
 ;;^UTILITY(U,$J,358.3,3177,0)
 ;;=Z76.82^^15^131^2
 ;;^UTILITY(U,$J,358.3,3177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3177,1,3,0)
 ;;=3^Awaiting Organ Transplant Status
 ;;^UTILITY(U,$J,358.3,3177,1,4,0)
 ;;=4^Z76.82
 ;;^UTILITY(U,$J,358.3,3177,2)
 ;;=^331582
 ;;^UTILITY(U,$J,358.3,3178,0)
 ;;=Z78.0^^15^131^1
 ;;^UTILITY(U,$J,358.3,3178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3178,1,3,0)
 ;;=3^Asymptomatic Menopausal State
 ;;^UTILITY(U,$J,358.3,3178,1,4,0)
 ;;=4^Z78.0
 ;;^UTILITY(U,$J,358.3,3178,2)
 ;;=^5063327
 ;;^UTILITY(U,$J,358.3,3179,0)
 ;;=Z74.01^^15^131^3
 ;;^UTILITY(U,$J,358.3,3179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3179,1,3,0)
 ;;=3^Bed Confinement Status
 ;;^UTILITY(U,$J,358.3,3179,1,4,0)
 ;;=4^Z74.01
 ;;^UTILITY(U,$J,358.3,3179,2)
 ;;=^5063282
 ;;^UTILITY(U,$J,358.3,3180,0)
 ;;=Z73.82^^15^131^5
 ;;^UTILITY(U,$J,358.3,3180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3180,1,3,0)
 ;;=3^Dual Sensory Impairment
 ;;^UTILITY(U,$J,358.3,3180,1,4,0)
 ;;=4^Z73.82
 ;;^UTILITY(U,$J,358.3,3180,2)
 ;;=^5063279
 ;;^UTILITY(U,$J,358.3,3181,0)
 ;;=Z66.^^15^131^4
 ;;^UTILITY(U,$J,358.3,3181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3181,1,3,0)
 ;;=3^Do Not Resuscitate
 ;;^UTILITY(U,$J,358.3,3181,1,4,0)
 ;;=4^Z66.
 ;;^UTILITY(U,$J,358.3,3181,2)
 ;;=^5063187
 ;;^UTILITY(U,$J,358.3,3182,0)
 ;;=Z78.1^^15^131^7
 ;;^UTILITY(U,$J,358.3,3182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3182,1,3,0)
 ;;=3^Physical Restraint Status
 ;;^UTILITY(U,$J,358.3,3182,1,4,0)
 ;;=4^Z78.1
 ;;^UTILITY(U,$J,358.3,3182,2)
 ;;=^5063328
 ;;^UTILITY(U,$J,358.3,3183,0)
 ;;=Z87.898^^15^131^6
 ;;^UTILITY(U,$J,358.3,3183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3183,1,3,0)
 ;;=3^Personal Hx of Oth Spec Conditions
 ;;^UTILITY(U,$J,358.3,3183,1,4,0)
 ;;=4^Z87.898
 ;;^UTILITY(U,$J,358.3,3183,2)
 ;;=^5063520
 ;;^UTILITY(U,$J,358.3,3184,0)
 ;;=Z63.32^^15^132^1
 ;;^UTILITY(U,$J,358.3,3184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3184,1,3,0)
 ;;=3^Absence of Family Member
 ;;^UTILITY(U,$J,358.3,3184,1,4,0)
 ;;=4^Z63.32
 ;;^UTILITY(U,$J,358.3,3184,2)
 ;;=^5063167
 ;;^UTILITY(U,$J,358.3,3185,0)
 ;;=Z63.8^^15^132^10
 ;;^UTILITY(U,$J,358.3,3185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3185,1,3,0)
 ;;=3^Primary Support Group Problems
 ;;^UTILITY(U,$J,358.3,3185,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,3185,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,3186,0)
 ;;=Z63.5^^15^132^5
 ;;^UTILITY(U,$J,358.3,3186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3186,1,3,0)
 ;;=3^Disruption of Family by Separation/Divorce
 ;;^UTILITY(U,$J,358.3,3186,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,3186,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,3187,0)
 ;;=Z71.89^^15^132^3
 ;;^UTILITY(U,$J,358.3,3187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3187,1,3,0)
 ;;=3^Counseling,Oth Spec
 ;;^UTILITY(U,$J,358.3,3187,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,3187,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,3188,0)
 ;;=Z69.11^^15^132^9
 ;;^UTILITY(U,$J,358.3,3188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3188,1,3,0)
 ;;=3^Mental Hlth Svc for Victim of Spousal/Partner Abuse
