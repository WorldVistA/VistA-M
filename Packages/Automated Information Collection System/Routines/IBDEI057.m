IBDEI057 ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12564,1,4,0)
 ;;=4^F50.00
 ;;^UTILITY(U,$J,358.3,12564,2)
 ;;=^5003597
 ;;^UTILITY(U,$J,358.3,12565,0)
 ;;=F90.9^^54^611^4
 ;;^UTILITY(U,$J,358.3,12565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12565,1,3,0)
 ;;=3^Attention-deficit hyperact dsordr, unspec type
 ;;^UTILITY(U,$J,358.3,12565,1,4,0)
 ;;=4^F90.9
 ;;^UTILITY(U,$J,358.3,12565,2)
 ;;=^5003696
 ;;^UTILITY(U,$J,358.3,12566,0)
 ;;=F50.2^^54^611^5
 ;;^UTILITY(U,$J,358.3,12566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12566,1,3,0)
 ;;=3^Bulimia nervosa
 ;;^UTILITY(U,$J,358.3,12566,1,4,0)
 ;;=4^F50.2
 ;;^UTILITY(U,$J,358.3,12566,2)
 ;;=^5003600
 ;;^UTILITY(U,$J,358.3,12567,0)
 ;;=F44.9^^54^611^6
 ;;^UTILITY(U,$J,358.3,12567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12567,1,3,0)
 ;;=3^Dissociative & conversion disorder, unspec
 ;;^UTILITY(U,$J,358.3,12567,1,4,0)
 ;;=4^F44.9
 ;;^UTILITY(U,$J,358.3,12567,2)
 ;;=^5003584
 ;;^UTILITY(U,$J,358.3,12568,0)
 ;;=F50.9^^54^611^7
 ;;^UTILITY(U,$J,358.3,12568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12568,1,3,0)
 ;;=3^Eating disorder, unspec
 ;;^UTILITY(U,$J,358.3,12568,1,4,0)
 ;;=4^F50.9
 ;;^UTILITY(U,$J,358.3,12568,2)
 ;;=^5003602
 ;;^UTILITY(U,$J,358.3,12569,0)
 ;;=F64.1^^54^611^9
 ;;^UTILITY(U,$J,358.3,12569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12569,1,3,0)
 ;;=3^Gender ident disorder in adlscnc & adlthd
 ;;^UTILITY(U,$J,358.3,12569,1,4,0)
 ;;=4^F64.1
 ;;^UTILITY(U,$J,358.3,12569,2)
 ;;=^5003647
 ;;^UTILITY(U,$J,358.3,12570,0)
 ;;=F06.30^^54^611^11
 ;;^UTILITY(U,$J,358.3,12570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12570,1,3,0)
 ;;=3^Mood disorder d/t known physiol cond, unsp
 ;;^UTILITY(U,$J,358.3,12570,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,12570,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,12571,0)
 ;;=F23.^^54^611^15
 ;;^UTILITY(U,$J,358.3,12571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12571,1,3,0)
 ;;=3^Psychotic disorder, brief
 ;;^UTILITY(U,$J,358.3,12571,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,12571,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,12572,0)
 ;;=F06.2^^54^611^14
 ;;^UTILITY(U,$J,358.3,12572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12572,1,3,0)
 ;;=3^Psychotic disorder w/ delusns d/t known physiol cond
 ;;^UTILITY(U,$J,358.3,12572,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,12572,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,12573,0)
 ;;=F29.^^54^611^13
 ;;^UTILITY(U,$J,358.3,12573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12573,1,3,0)
 ;;=3^Psychosis not d/t a subst or known physiol cond, unsp
 ;;^UTILITY(U,$J,358.3,12573,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,12573,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,12574,0)
 ;;=F45.9^^54^611^16
 ;;^UTILITY(U,$J,358.3,12574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12574,1,3,0)
 ;;=3^Somatoform disorder, unspec
 ;;^UTILITY(U,$J,358.3,12574,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,12574,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,12575,0)
 ;;=Z00.00^^54^611^10
 ;;^UTILITY(U,$J,358.3,12575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12575,1,3,0)
 ;;=3^General Adult Med Exam w/o Abnl Fndgs
 ;;^UTILITY(U,$J,358.3,12575,1,4,0)
 ;;=4^Z00.00
 ;;^UTILITY(U,$J,358.3,12575,2)
 ;;=^5062599
 ;;^UTILITY(U,$J,358.3,12576,0)
 ;;=Z51.5^^54^611^12
 ;;^UTILITY(U,$J,358.3,12576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12576,1,3,0)
 ;;=3^Palliative care 
 ;;^UTILITY(U,$J,358.3,12576,1,4,0)
 ;;=4^Z51.5
 ;;^UTILITY(U,$J,358.3,12576,2)
 ;;=^5063063
 ;;^UTILITY(U,$J,358.3,12577,0)
 ;;=Z09.^^54^611^8
 ;;^UTILITY(U,$J,358.3,12577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12577,1,3,0)
 ;;=3^Follow-up Exam,Compltd TX,Oth Than Cancer
 ;;^UTILITY(U,$J,358.3,12577,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,12577,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,12578,0)
 ;;=Z63.32^^54^612^2
 ;;^UTILITY(U,$J,358.3,12578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12578,1,3,0)
 ;;=3^Absence of family member, oth
 ;;^UTILITY(U,$J,358.3,12578,1,4,0)
 ;;=4^Z63.32
 ;;^UTILITY(U,$J,358.3,12578,2)
 ;;=^5063167
 ;;^UTILITY(U,$J,358.3,12579,0)
 ;;=Z71.41^^54^612^3
 ;;^UTILITY(U,$J,358.3,12579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12579,1,3,0)
 ;;=3^Alcohol abuse counslng & surveil of alcoholic
 ;;^UTILITY(U,$J,358.3,12579,1,4,0)
 ;;=4^Z71.41
 ;;^UTILITY(U,$J,358.3,12579,2)
 ;;=^5063246
 ;;^UTILITY(U,$J,358.3,12580,0)
 ;;=Z71.89^^54^612^4
 ;;^UTILITY(U,$J,358.3,12580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12580,1,3,0)
 ;;=3^Counseling, oth, spec
 ;;^UTILITY(U,$J,358.3,12580,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,12580,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,12581,0)
 ;;=Z71.9^^54^612^5
 ;;^UTILITY(U,$J,358.3,12581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12581,1,3,0)
 ;;=3^Counseling, unspec
 ;;^UTILITY(U,$J,358.3,12581,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,12581,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,12582,0)
 ;;=Z63.4^^54^612^8
 ;;^UTILITY(U,$J,358.3,12582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12582,1,3,0)
 ;;=3^Disappearance & death of family member
 ;;^UTILITY(U,$J,358.3,12582,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,12582,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,12583,0)
 ;;=Z73.82^^54^612^9
 ;;^UTILITY(U,$J,358.3,12583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12583,1,3,0)
 ;;=3^Dual sensory impairment
 ;;^UTILITY(U,$J,358.3,12583,1,4,0)
 ;;=4^Z73.82
 ;;^UTILITY(U,$J,358.3,12583,2)
 ;;=^5063279
 ;;^UTILITY(U,$J,358.3,12584,0)
 ;;=Z04.41^^54^612^10
 ;;^UTILITY(U,$J,358.3,12584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12584,1,3,0)
 ;;=3^Encntr for exam & obs folwng alleged adlt rape
 ;;^UTILITY(U,$J,358.3,12584,1,4,0)
 ;;=4^Z04.41
 ;;^UTILITY(U,$J,358.3,12584,2)
 ;;=^5062660
 ;;^UTILITY(U,$J,358.3,12585,0)
 ;;=Z76.0^^54^612^11
 ;;^UTILITY(U,$J,358.3,12585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12585,1,3,0)
 ;;=3^Encntr for issue of repeat prescription
 ;;^UTILITY(U,$J,358.3,12585,1,4,0)
 ;;=4^Z76.0
 ;;^UTILITY(U,$J,358.3,12585,2)
 ;;=^5063297
 ;;^UTILITY(U,$J,358.3,12586,0)
 ;;=Z69.12^^54^612^13
 ;;^UTILITY(U,$J,358.3,12586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12586,1,3,0)
 ;;=3^Encntr for mntl hlth serv for perp of spous or prtnr abuse
 ;;^UTILITY(U,$J,358.3,12586,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,12586,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,12587,0)
 ;;=Z69.010^^54^612^14
 ;;^UTILITY(U,$J,358.3,12587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12587,1,3,0)
 ;;=3^Encntr for mntl hlth serv for vctm of prntl child abuse
 ;;^UTILITY(U,$J,358.3,12587,1,4,0)
 ;;=4^Z69.010
 ;;^UTILITY(U,$J,358.3,12587,2)
 ;;=^5063228
 ;;^UTILITY(U,$J,358.3,12588,0)
 ;;=Z69.11^^54^612^15
 ;;^UTILITY(U,$J,358.3,12588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12588,1,3,0)
 ;;=3^Encntr for mntl hlth serv for vctm of spous or prtnr abuse
 ;;^UTILITY(U,$J,358.3,12588,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,12588,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,12589,0)
 ;;=Z65.5^^54^612^16
 ;;^UTILITY(U,$J,358.3,12589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12589,1,3,0)
 ;;=3^Expsr to disaster, war & oth hostilities
 ;;^UTILITY(U,$J,358.3,12589,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,12589,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,12590,0)
 ;;=Z59.0^^54^612^18
 ;;^UTILITY(U,$J,358.3,12590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12590,1,3,0)
 ;;=3^Homelessness
 ;;^UTILITY(U,$J,358.3,12590,1,4,0)
 ;;=4^Z59.0
 ;;^UTILITY(U,$J,358.3,12590,2)
 ;;=^5063129
 ;;^UTILITY(U,$J,358.3,12591,0)
 ;;=Z59.5^^54^612^17
 ;;^UTILITY(U,$J,358.3,12591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12591,1,3,0)
 ;;=3^Extreme poverty
 ;;^UTILITY(U,$J,358.3,12591,1,4,0)
 ;;=4^Z59.5
 ;;^UTILITY(U,$J,358.3,12591,2)
 ;;=^5063134
 ;;^UTILITY(U,$J,358.3,12592,0)
 ;;=Z71.7^^54^612^19
 ;;^UTILITY(U,$J,358.3,12592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12592,1,3,0)
 ;;=3^Human immunodeficiency virus [HIV] counseling
 ;;^UTILITY(U,$J,358.3,12592,1,4,0)
 ;;=4^Z71.7
 ;;^UTILITY(U,$J,358.3,12592,2)
 ;;=^5063251
 ;;^UTILITY(U,$J,358.3,12593,0)
 ;;=Z73.4^^54^612^20
 ;;^UTILITY(U,$J,358.3,12593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12593,1,3,0)
 ;;=3^Inadqute social skills, not elswhr classified
 ;;^UTILITY(U,$J,358.3,12593,1,4,0)
 ;;=4^Z73.4
 ;;^UTILITY(U,$J,358.3,12593,2)
 ;;=^5063272
 ;;^UTILITY(U,$J,358.3,12594,0)
 ;;=Z79.2^^54^612^22
 ;;^UTILITY(U,$J,358.3,12594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12594,1,3,0)
 ;;=3^Long term (current) use of antibiotics
 ;;^UTILITY(U,$J,358.3,12594,1,4,0)
 ;;=4^Z79.2
 ;;^UTILITY(U,$J,358.3,12594,2)
 ;;=^321546
 ;;^UTILITY(U,$J,358.3,12595,0)
 ;;=Z79.01^^54^612^23
 ;;^UTILITY(U,$J,358.3,12595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12595,1,3,0)
 ;;=3^Long term (current) use of anticoagulants
 ;;^UTILITY(U,$J,358.3,12595,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,12595,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,12596,0)
 ;;=Z79.02^^54^612^24
 ;;^UTILITY(U,$J,358.3,12596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12596,1,3,0)
 ;;=3^Long term (current) use of antithrombtc/antipltlts
 ;;^UTILITY(U,$J,358.3,12596,1,4,0)
 ;;=4^Z79.02
 ;;^UTILITY(U,$J,358.3,12596,2)
 ;;=^5063331
 ;;^UTILITY(U,$J,358.3,12597,0)
 ;;=Z79.82^^54^612^25
 ;;^UTILITY(U,$J,358.3,12597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12597,1,3,0)
 ;;=3^Long term (current) use of aspirin
 ;;^UTILITY(U,$J,358.3,12597,1,4,0)
 ;;=4^Z79.82
 ;;^UTILITY(U,$J,358.3,12597,2)
 ;;=^5063340
 ;;^UTILITY(U,$J,358.3,12598,0)
 ;;=Z79.899^^54^612^21
 ;;^UTILITY(U,$J,358.3,12598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12598,1,3,0)
 ;;=3^Long term (current) drug therapy, oth
 ;;^UTILITY(U,$J,358.3,12598,1,4,0)
 ;;=4^Z79.899
 ;;^UTILITY(U,$J,358.3,12598,2)
 ;;=^5063343
 ;;^UTILITY(U,$J,358.3,12599,0)
 ;;=Z79.51^^54^612^26
 ;;^UTILITY(U,$J,358.3,12599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12599,1,3,0)
 ;;=3^Long term (current) use of inhaled steroids
 ;;^UTILITY(U,$J,358.3,12599,1,4,0)
 ;;=4^Z79.51
 ;;^UTILITY(U,$J,358.3,12599,2)
 ;;=^5063335
 ;;^UTILITY(U,$J,358.3,12600,0)
 ;;=Z79.4^^54^612^27
 ;;^UTILITY(U,$J,358.3,12600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12600,1,3,0)
 ;;=3^Long term (current) use of insulin
 ;;^UTILITY(U,$J,358.3,12600,1,4,0)
 ;;=4^Z79.4
 ;;^UTILITY(U,$J,358.3,12600,2)
 ;;=^5063334
 ;;^UTILITY(U,$J,358.3,12601,0)
 ;;=Z79.1^^54^612^28
 ;;^UTILITY(U,$J,358.3,12601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12601,1,3,0)
 ;;=3^Long term (current) use of non-stroidl non-inflam (NSAID)
 ;;^UTILITY(U,$J,358.3,12601,1,4,0)
 ;;=4^Z79.1
 ;;^UTILITY(U,$J,358.3,12601,2)
 ;;=^5063332
 ;;^UTILITY(U,$J,358.3,12602,0)
 ;;=Z79.891^^54^612^29
 ;;^UTILITY(U,$J,358.3,12602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12602,1,3,0)
 ;;=3^Long term (current) use of opiate analgesic
 ;;^UTILITY(U,$J,358.3,12602,1,4,0)
 ;;=4^Z79.891
 ;;^UTILITY(U,$J,358.3,12602,2)
 ;;=^5063342
 ;;^UTILITY(U,$J,358.3,12603,0)
 ;;=Z79.52^^54^612^31
 ;;^UTILITY(U,$J,358.3,12603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12603,1,3,0)
 ;;=3^Long term (current) use of systemic steroids
 ;;^UTILITY(U,$J,358.3,12603,1,4,0)
 ;;=4^Z79.52
 ;;^UTILITY(U,$J,358.3,12603,2)
 ;;=^5063336
 ;;^UTILITY(U,$J,358.3,12604,0)
 ;;=Z91.19^^54^612^41
 ;;^UTILITY(U,$J,358.3,12604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12604,1,3,0)
 ;;=3^Pt's noncmplnc w oth med'l trmnt & regimen
 ;;^UTILITY(U,$J,358.3,12604,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,12604,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,12605,0)
 ;;=Z73.89^^54^612^33
 ;;^UTILITY(U,$J,358.3,12605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12605,1,3,0)
 ;;=3^Prblms related to life mngmt difficulty, oth
 ;;^UTILITY(U,$J,358.3,12605,1,4,0)
 ;;=4^Z73.89
 ;;^UTILITY(U,$J,358.3,12605,2)
 ;;=^5063280
 ;;^UTILITY(U,$J,358.3,12606,0)
 ;;=Z55.9^^54^612^32
 ;;^UTILITY(U,$J,358.3,12606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12606,1,3,0)
 ;;=3^Prblms related to educ & literacy, unspec
 ;;^UTILITY(U,$J,358.3,12606,1,4,0)
 ;;=4^Z55.9
 ;;^UTILITY(U,$J,358.3,12606,2)
 ;;=^5063106
 ;;^UTILITY(U,$J,358.3,12607,0)
 ;;=Z63.8^^54^612^34
 ;;^UTILITY(U,$J,358.3,12607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12607,1,3,0)
 ;;=3^Prblms related to prim support grp, oth, unspec
 ;;^UTILITY(U,$J,358.3,12607,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,12607,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,12608,0)
 ;;=Z63.9^^54^612^35
 ;;^UTILITY(U,$J,358.3,12608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12608,1,3,0)
 ;;=3^Prblms related to prim support grp, unspec
 ;;^UTILITY(U,$J,358.3,12608,1,4,0)
 ;;=4^Z63.9
 ;;^UTILITY(U,$J,358.3,12608,2)
 ;;=^5063175
 ;;^UTILITY(U,$J,358.3,12609,0)
 ;;=Z65.8^^54^612^36
 ;;^UTILITY(U,$J,358.3,12609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12609,1,3,0)
 ;;=3^Prblms related to psychosocial circumst, oth
 ;;^UTILITY(U,$J,358.3,12609,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,12609,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,12610,0)
 ;;=Z65.9^^54^612^37
 ;;^UTILITY(U,$J,358.3,12610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12610,1,3,0)
 ;;=3^Prblms related to unspec psychosocial circumst
 ;;^UTILITY(U,$J,358.3,12610,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,12610,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,12611,0)
 ;;=Z72.0^^54^612^46
 ;;^UTILITY(U,$J,358.3,12611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12611,1,3,0)
 ;;=3^Tobacco use, NOS
 ;;^UTILITY(U,$J,358.3,12611,1,4,0)
 ;;=4^Z72.0
 ;;^UTILITY(U,$J,358.3,12611,2)
 ;;=^5063255
 ;;^UTILITY(U,$J,358.3,12612,0)
 ;;=Z73.5^^54^612^44
 ;;^UTILITY(U,$J,358.3,12612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12612,1,3,0)
 ;;=3^Social role conflict, NEC
 ;;^UTILITY(U,$J,358.3,12612,1,4,0)
 ;;=4^Z73.5
 ;;^UTILITY(U,$J,358.3,12612,2)
 ;;=^5063273
 ;;^UTILITY(U,$J,358.3,12613,0)
 ;;=Z91.130^^54^612^42
 ;;^UTILITY(U,$J,358.3,12613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12613,1,3,0)
 ;;=3^Pt's unintent undrdose of meds regimen d/t age-rel dblity
 ;;^UTILITY(U,$J,358.3,12613,1,4,0)
 ;;=4^Z91.130
 ;;^UTILITY(U,$J,358.3,12613,2)
 ;;=^5063614
 ;;^UTILITY(U,$J,358.3,12614,0)
 ;;=Z91.138^^54^612^43
 ;;^UTILITY(U,$J,358.3,12614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12614,1,3,0)
 ;;=3^Pt's unintent undrdose of meds regimen for oth reason
 ;;^UTILITY(U,$J,358.3,12614,1,4,0)
 ;;=4^Z91.138
 ;;^UTILITY(U,$J,358.3,12614,2)
 ;;=^5063615
 ;;^UTILITY(U,$J,358.3,12615,0)
 ;;=Z95.3^^54^612^38
 ;;^UTILITY(U,$J,358.3,12615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12615,1,3,0)
 ;;=3^Presence of Xenogenic Heart Valve
 ;;^UTILITY(U,$J,358.3,12615,1,4,0)
 ;;=4^Z95.3
 ;;^UTILITY(U,$J,358.3,12615,2)
 ;;=^5063671
 ;;^UTILITY(U,$J,358.3,12616,0)
 ;;=Z63.31^^54^612^1
 ;;^UTILITY(U,$J,358.3,12616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12616,1,3,0)
 ;;=3^Absence of family member d/t military deployment
 ;;^UTILITY(U,$J,358.3,12616,1,4,0)
 ;;=4^Z63.31
 ;;^UTILITY(U,$J,358.3,12616,2)
 ;;=^5063166
 ;;^UTILITY(U,$J,358.3,12617,0)
 ;;=Z71.3^^54^612^6
 ;;^UTILITY(U,$J,358.3,12617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12617,1,3,0)
 ;;=3^Counseling,Dietary
 ;;^UTILITY(U,$J,358.3,12617,1,4,0)
 ;;=4^Z71.3
 ;;^UTILITY(U,$J,358.3,12617,2)
 ;;=^5063245
 ;;^UTILITY(U,$J,358.3,12618,0)
 ;;=Z71.6^^54^612^7
 ;;^UTILITY(U,$J,358.3,12618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12618,1,3,0)
 ;;=3^Counseling,Tobacco Abuse
 ;;^UTILITY(U,$J,358.3,12618,1,4,0)
 ;;=4^Z71.6
 ;;^UTILITY(U,$J,358.3,12618,2)
 ;;=^5063250
 ;;^UTILITY(U,$J,358.3,12619,0)
 ;;=Z69.011^^54^612^12
 ;;^UTILITY(U,$J,358.3,12619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12619,1,3,0)
 ;;=3^Encntr for mntl hlth serv for perp of prntl child abuse
 ;;^UTILITY(U,$J,358.3,12619,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,12619,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,12620,0)
 ;;=Z91.120^^54^612^39
 ;;^UTILITY(U,$J,358.3,12620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12620,1,3,0)
 ;;=3^Pt's intent underdose of meds d/t financial hardship
 ;;^UTILITY(U,$J,358.3,12620,1,4,0)
 ;;=4^Z91.120
 ;;^UTILITY(U,$J,358.3,12620,2)
 ;;=^5063612
 ;;^UTILITY(U,$J,358.3,12621,0)
 ;;=Z91.128^^54^612^40
 ;;^UTILITY(U,$J,358.3,12621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12621,1,3,0)
 ;;=3^Pt's intent underdose of meds d/t oth reasons
 ;;^UTILITY(U,$J,358.3,12621,1,4,0)
 ;;=4^Z91.128
 ;;^UTILITY(U,$J,358.3,12621,2)
 ;;=^5063613
 ;;^UTILITY(U,$J,358.3,12622,0)
 ;;=Z63.71^^54^612^45
 ;;^UTILITY(U,$J,358.3,12622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12622,1,3,0)
 ;;=3^Stress on family d/t rtrn of family member from deployment
 ;;^UTILITY(U,$J,358.3,12622,1,4,0)
 ;;=4^Z63.71
 ;;^UTILITY(U,$J,358.3,12622,2)
 ;;=^5063171
 ;;^UTILITY(U,$J,358.3,12623,0)
 ;;=Z79.84^^54^612^30
 ;;^UTILITY(U,$J,358.3,12623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12623,1,3,0)
 ;;=3^Long term (current) use of oral hypoglycemic drugs
 ;;^UTILITY(U,$J,358.3,12623,1,4,0)
 ;;=4^Z79.84
 ;;^UTILITY(U,$J,358.3,12623,2)
 ;;=^5140432
 ;;^UTILITY(U,$J,358.3,12624,0)
 ;;=Z03.89^^54^613^1
 ;;^UTILITY(U,$J,358.3,12624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12624,1,3,0)
 ;;=3^Observation for Suspected Diseases & Condition Ruled Out
 ;;^UTILITY(U,$J,358.3,12624,1,4,0)
 ;;=4^Z03.89
 ;;^UTILITY(U,$J,358.3,12624,2)
 ;;=^5062656
 ;;^UTILITY(U,$J,358.3,12625,0)
 ;;=E11.9^^54^614^13
 ;;^UTILITY(U,$J,358.3,12625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12625,1,3,0)
 ;;=3^Type 2 DM w/o Complications
 ;;^UTILITY(U,$J,358.3,12625,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,12625,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,12626,0)
 ;;=E11.65^^54^614^9
 ;;^UTILITY(U,$J,358.3,12626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12626,1,3,0)
 ;;=3^Type 2 DM w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,12626,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,12626,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,12627,0)
 ;;=E10.9^^54^614^6
 ;;^UTILITY(U,$J,358.3,12627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12627,1,3,0)
 ;;=3^Type 1 DM w/o Complications
 ;;^UTILITY(U,$J,358.3,12627,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,12627,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,12628,0)
 ;;=E10.65^^54^614^4
 ;;^UTILITY(U,$J,358.3,12628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12628,1,3,0)
 ;;=3^Type 1 DM w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,12628,1,4,0)
 ;;=4^E10.65
 ;;^UTILITY(U,$J,358.3,12628,2)
 ;;=^5002623
 ;;^UTILITY(U,$J,358.3,12629,0)
 ;;=E11.42^^54^614^7
 ;;^UTILITY(U,$J,358.3,12629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12629,1,3,0)
 ;;=3^Type 2 DM w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,12629,1,4,0)
 ;;=4^E11.42
 ;;^UTILITY(U,$J,358.3,12629,2)
 ;;=^5002646
 ;;^UTILITY(U,$J,358.3,12630,0)
 ;;=E10.42^^54^614^2
 ;;^UTILITY(U,$J,358.3,12630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12630,1,3,0)
 ;;=3^Type 1 DM w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,12630,1,4,0)
 ;;=4^E10.42
 ;;^UTILITY(U,$J,358.3,12630,2)
 ;;=^5002606
 ;;^UTILITY(U,$J,358.3,12631,0)
 ;;=E13.42^^54^614^1
 ;;^UTILITY(U,$J,358.3,12631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12631,1,3,0)
 ;;=3^Secondary Type DM w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,12631,1,4,0)
 ;;=4^E13.42
