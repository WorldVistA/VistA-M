IBDEI02S ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3298,1,3,0)
 ;;=3^Acquired Absence of Left Foot
 ;;^UTILITY(U,$J,358.3,3298,1,4,0)
 ;;=4^Z89.432
 ;;^UTILITY(U,$J,358.3,3298,2)
 ;;=^5063561
 ;;^UTILITY(U,$J,358.3,3299,0)
 ;;=Z89.441^^15^146^8
 ;;^UTILITY(U,$J,358.3,3299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3299,1,3,0)
 ;;=3^Acquired Absence of Right Ankle
 ;;^UTILITY(U,$J,358.3,3299,1,4,0)
 ;;=4^Z89.441
 ;;^UTILITY(U,$J,358.3,3299,2)
 ;;=^5063563
 ;;^UTILITY(U,$J,358.3,3300,0)
 ;;=Z89.442^^15^146^1
 ;;^UTILITY(U,$J,358.3,3300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3300,1,3,0)
 ;;=3^Acquired Absence of Left Ankle
 ;;^UTILITY(U,$J,358.3,3300,1,4,0)
 ;;=4^Z89.442
 ;;^UTILITY(U,$J,358.3,3300,2)
 ;;=^5063564
 ;;^UTILITY(U,$J,358.3,3301,0)
 ;;=Z89.511^^15^146^13
 ;;^UTILITY(U,$J,358.3,3301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3301,1,3,0)
 ;;=3^Acquired Absence of Right Leg Below Knee
 ;;^UTILITY(U,$J,358.3,3301,1,4,0)
 ;;=4^Z89.511
 ;;^UTILITY(U,$J,358.3,3301,2)
 ;;=^5063566
 ;;^UTILITY(U,$J,358.3,3302,0)
 ;;=Z89.512^^15^146^6
 ;;^UTILITY(U,$J,358.3,3302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3302,1,3,0)
 ;;=3^Acquired Absence of Left Leg Below Knee
 ;;^UTILITY(U,$J,358.3,3302,1,4,0)
 ;;=4^Z89.512
 ;;^UTILITY(U,$J,358.3,3302,2)
 ;;=^5063567
 ;;^UTILITY(U,$J,358.3,3303,0)
 ;;=Z89.611^^15^146^12
 ;;^UTILITY(U,$J,358.3,3303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3303,1,3,0)
 ;;=3^Acquired Absence of Right Leg Above Knee
 ;;^UTILITY(U,$J,358.3,3303,1,4,0)
 ;;=4^Z89.611
 ;;^UTILITY(U,$J,358.3,3303,2)
 ;;=^5063572
 ;;^UTILITY(U,$J,358.3,3304,0)
 ;;=Z89.612^^15^146^5
 ;;^UTILITY(U,$J,358.3,3304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3304,1,3,0)
 ;;=3^Acquired Absence of Left Leg Above Knee
 ;;^UTILITY(U,$J,358.3,3304,1,4,0)
 ;;=4^Z89.612
 ;;^UTILITY(U,$J,358.3,3304,2)
 ;;=^5063573
 ;;^UTILITY(U,$J,358.3,3305,0)
 ;;=Z89.621^^15^146^11
 ;;^UTILITY(U,$J,358.3,3305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3305,1,3,0)
 ;;=3^Acquired Absence of Right Hip Joint
 ;;^UTILITY(U,$J,358.3,3305,1,4,0)
 ;;=4^Z89.621
 ;;^UTILITY(U,$J,358.3,3305,2)
 ;;=^5063575
 ;;^UTILITY(U,$J,358.3,3306,0)
 ;;=Z89.622^^15^146^4
 ;;^UTILITY(U,$J,358.3,3306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3306,1,3,0)
 ;;=3^Acquired Absence of Left Hip Joint
 ;;^UTILITY(U,$J,358.3,3306,1,4,0)
 ;;=4^Z89.622
 ;;^UTILITY(U,$J,358.3,3306,2)
 ;;=^5063576
 ;;^UTILITY(U,$J,358.3,3307,0)
 ;;=Z75.3^^15^147^5
 ;;^UTILITY(U,$J,358.3,3307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3307,1,3,0)
 ;;=3^Unavailability/Inaccessibility of Health-Care Facilities
 ;;^UTILITY(U,$J,358.3,3307,1,4,0)
 ;;=4^Z75.3
 ;;^UTILITY(U,$J,358.3,3307,2)
 ;;=^5063292
 ;;^UTILITY(U,$J,358.3,3308,0)
 ;;=Z75.0^^15^147^3
 ;;^UTILITY(U,$J,358.3,3308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3308,1,3,0)
 ;;=3^Medical Services Not Available in Home
 ;;^UTILITY(U,$J,358.3,3308,1,4,0)
 ;;=4^Z75.0
 ;;^UTILITY(U,$J,358.3,3308,2)
 ;;=^5063289
 ;;^UTILITY(U,$J,358.3,3309,0)
 ;;=Z75.1^^15^147^4
 ;;^UTILITY(U,$J,358.3,3309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3309,1,3,0)
 ;;=3^Pt Awaiting Admission to Adequate Facility Elsewhere
 ;;^UTILITY(U,$J,358.3,3309,1,4,0)
 ;;=4^Z75.1
 ;;^UTILITY(U,$J,358.3,3309,2)
 ;;=^5063290
 ;;^UTILITY(U,$J,358.3,3310,0)
 ;;=Z75.4^^15^147^6
 ;;^UTILITY(U,$J,358.3,3310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3310,1,3,0)
 ;;=3^Unavailability/Inaccessibility of Helping Agencies
 ;;^UTILITY(U,$J,358.3,3310,1,4,0)
 ;;=4^Z75.4
 ;;^UTILITY(U,$J,358.3,3310,2)
 ;;=^5063293
 ;;^UTILITY(U,$J,358.3,3311,0)
 ;;=Z75.8^^15^147^2
 ;;^UTILITY(U,$J,358.3,3311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3311,1,3,0)
 ;;=3^Medical Facilities/Health Care Problems
 ;;^UTILITY(U,$J,358.3,3311,1,4,0)
 ;;=4^Z75.8
 ;;^UTILITY(U,$J,358.3,3311,2)
 ;;=^5063295
 ;;^UTILITY(U,$J,358.3,3312,0)
 ;;=Z71.9^^15^147^1
 ;;^UTILITY(U,$J,358.3,3312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3312,1,3,0)
 ;;=3^Counseling,Unspec
 ;;^UTILITY(U,$J,358.3,3312,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,3312,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,3313,0)
 ;;=Z51.89^^15^148^1
 ;;^UTILITY(U,$J,358.3,3313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3313,1,3,0)
 ;;=3^Aftercare,Oth Spec
 ;;^UTILITY(U,$J,358.3,3313,1,4,0)
 ;;=4^Z51.89
 ;;^UTILITY(U,$J,358.3,3313,2)
 ;;=^5063065
 ;;^UTILITY(U,$J,358.3,3314,0)
 ;;=Z51.5^^15^148^2
 ;;^UTILITY(U,$J,358.3,3314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3314,1,3,0)
 ;;=3^Palliative Care
 ;;^UTILITY(U,$J,358.3,3314,1,4,0)
 ;;=4^Z51.5
 ;;^UTILITY(U,$J,358.3,3314,2)
 ;;=^5063063
 ;;^UTILITY(U,$J,358.3,3315,0)
 ;;=D50.9^^16^149^13
 ;;^UTILITY(U,$J,358.3,3315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3315,1,3,0)
 ;;=3^Anemia,Iron Deficiency
 ;;^UTILITY(U,$J,358.3,3315,1,4,0)
 ;;=4^D50.9
 ;;^UTILITY(U,$J,358.3,3315,2)
 ;;=^5002283
 ;;^UTILITY(U,$J,358.3,3316,0)
 ;;=D64.9^^16^149^14
 ;;^UTILITY(U,$J,358.3,3316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3316,1,3,0)
 ;;=3^Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,3316,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,3316,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,3317,0)
 ;;=F41.9^^16^149^16
 ;;^UTILITY(U,$J,358.3,3317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3317,1,3,0)
 ;;=3^Anxiety Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3317,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,3317,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,3318,0)
 ;;=F10.20^^16^149^9
 ;;^UTILITY(U,$J,358.3,3318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3318,1,3,0)
 ;;=3^Alcohol Dependence Uncomplicated
 ;;^UTILITY(U,$J,358.3,3318,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,3318,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,3319,0)
 ;;=G30.9^^16^149^12
 ;;^UTILITY(U,$J,358.3,3319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3319,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3319,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,3319,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,3320,0)
 ;;=I20.9^^16^149^15
 ;;^UTILITY(U,$J,358.3,3320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3320,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,3320,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,3320,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,3321,0)
 ;;=I25.10^^16^149^19
 ;;^UTILITY(U,$J,358.3,3321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3321,1,3,0)
 ;;=3^Athscl Hrt Disease w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,3321,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,3321,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,3322,0)
 ;;=K46.9^^16^149^2
 ;;^UTILITY(U,$J,358.3,3322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3322,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst/Gangr
 ;;^UTILITY(U,$J,358.3,3322,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,3322,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,3323,0)
 ;;=I48.91^^16^149^20
 ;;^UTILITY(U,$J,358.3,3323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3323,1,3,0)
 ;;=3^Atrial Fibrillation,Unspec
 ;;^UTILITY(U,$J,358.3,3323,1,4,0)
 ;;=4^I48.91
 ;;^UTILITY(U,$J,358.3,3323,2)
 ;;=^5007229
 ;;^UTILITY(U,$J,358.3,3324,0)
 ;;=I48.92^^16^149^21
 ;;^UTILITY(U,$J,358.3,3324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3324,1,3,0)
 ;;=3^Atrial Flutter,Unspec
 ;;^UTILITY(U,$J,358.3,3324,1,4,0)
 ;;=4^I48.92
 ;;^UTILITY(U,$J,358.3,3324,2)
 ;;=^5007230
 ;;^UTILITY(U,$J,358.3,3325,0)
 ;;=I71.4^^16^149^1
 ;;^UTILITY(U,$J,358.3,3325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3325,1,3,0)
 ;;=3^AAA w/o Rupture
 ;;^UTILITY(U,$J,358.3,3325,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,3325,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,3326,0)
 ;;=J30.9^^16^149^10
 ;;^UTILITY(U,$J,358.3,3326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3326,1,3,0)
 ;;=3^Allergic Rhinitis,Unspec
 ;;^UTILITY(U,$J,358.3,3326,1,4,0)
 ;;=4^J30.9
 ;;^UTILITY(U,$J,358.3,3326,2)
 ;;=^5008205
 ;;^UTILITY(U,$J,358.3,3327,0)
 ;;=J45.909^^16^149^18
 ;;^UTILITY(U,$J,358.3,3327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3327,1,3,0)
 ;;=3^Asthma Uncomplicated,Unspec
 ;;^UTILITY(U,$J,358.3,3327,1,4,0)
 ;;=4^J45.909
 ;;^UTILITY(U,$J,358.3,3327,2)
 ;;=^5008256
 ;;^UTILITY(U,$J,358.3,3328,0)
 ;;=M12.9^^16^149^17
 ;;^UTILITY(U,$J,358.3,3328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3328,1,3,0)
 ;;=3^Arthropathy,Unspec
 ;;^UTILITY(U,$J,358.3,3328,1,4,0)
 ;;=4^M12.9
 ;;^UTILITY(U,$J,358.3,3328,2)
 ;;=^5010666
 ;;^UTILITY(U,$J,358.3,3329,0)
 ;;=T78.40XA^^16^149^11
 ;;^UTILITY(U,$J,358.3,3329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3329,1,3,0)
 ;;=3^Allergy,Unspec Initial Encounter
 ;;^UTILITY(U,$J,358.3,3329,1,4,0)
 ;;=4^T78.40XA
 ;;^UTILITY(U,$J,358.3,3329,2)
 ;;=^5054284
 ;;^UTILITY(U,$J,358.3,3330,0)
 ;;=L40.2^^16^149^6
 ;;^UTILITY(U,$J,358.3,3330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3330,1,3,0)
 ;;=3^Acrodermatitis Continua
 ;;^UTILITY(U,$J,358.3,3330,1,4,0)
 ;;=4^L40.2
 ;;^UTILITY(U,$J,358.3,3330,2)
 ;;=^5009162
 ;;^UTILITY(U,$J,358.3,3331,0)
 ;;=R10.9^^16^149^3
 ;;^UTILITY(U,$J,358.3,3331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3331,1,3,0)
 ;;=3^Abdominal Pain,Unspec
 ;;^UTILITY(U,$J,358.3,3331,1,4,0)
 ;;=4^R10.9
 ;;^UTILITY(U,$J,358.3,3331,2)
 ;;=^5019230
 ;;^UTILITY(U,$J,358.3,3332,0)
 ;;=F10.10^^16^149^8
 ;;^UTILITY(U,$J,358.3,3332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3332,1,3,0)
 ;;=3^Alcohol Abuse Uncomplicated
 ;;^UTILITY(U,$J,358.3,3332,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,3332,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,3333,0)
 ;;=F43.0^^16^149^7
 ;;^UTILITY(U,$J,358.3,3333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3333,1,3,0)
 ;;=3^Acute Stress Reaction
 ;;^UTILITY(U,$J,358.3,3333,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,3333,2)
 ;;=^5003569
 ;;^UTILITY(U,$J,358.3,3334,0)
 ;;=Z89.511^^16^149^5
 ;;^UTILITY(U,$J,358.3,3334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3334,1,3,0)
 ;;=3^Acquired Absence Right Leg Below Knee
 ;;^UTILITY(U,$J,358.3,3334,1,4,0)
 ;;=4^Z89.511
 ;;^UTILITY(U,$J,358.3,3334,2)
 ;;=^5063566
 ;;^UTILITY(U,$J,358.3,3335,0)
 ;;=Z89.512^^16^149^4
