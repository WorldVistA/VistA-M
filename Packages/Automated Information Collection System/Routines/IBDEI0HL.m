IBDEI0HL ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17678,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,17678,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,17679,0)
 ;;=F06.2^^76^911^15
 ;;^UTILITY(U,$J,358.3,17679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17679,1,3,0)
 ;;=3^Psychotic disorder w/ delusns d/t known physiol cond
 ;;^UTILITY(U,$J,358.3,17679,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,17679,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,17680,0)
 ;;=F29.^^76^911^14
 ;;^UTILITY(U,$J,358.3,17680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17680,1,3,0)
 ;;=3^Psychosis not d/t a subst or known physiol cond, unsp
 ;;^UTILITY(U,$J,358.3,17680,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,17680,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,17681,0)
 ;;=F45.9^^76^911^17
 ;;^UTILITY(U,$J,358.3,17681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17681,1,3,0)
 ;;=3^Somatoform disorder, unspec
 ;;^UTILITY(U,$J,358.3,17681,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,17681,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,17682,0)
 ;;=Z00.00^^76^911^11
 ;;^UTILITY(U,$J,358.3,17682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17682,1,3,0)
 ;;=3^General Adult Med Exam w/o Abnl Fndgs
 ;;^UTILITY(U,$J,358.3,17682,1,4,0)
 ;;=4^Z00.00
 ;;^UTILITY(U,$J,358.3,17682,2)
 ;;=^5062599
 ;;^UTILITY(U,$J,358.3,17683,0)
 ;;=Z51.5^^76^911^13
 ;;^UTILITY(U,$J,358.3,17683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17683,1,3,0)
 ;;=3^Palliative care 
 ;;^UTILITY(U,$J,358.3,17683,1,4,0)
 ;;=4^Z51.5
 ;;^UTILITY(U,$J,358.3,17683,2)
 ;;=^5063063
 ;;^UTILITY(U,$J,358.3,17684,0)
 ;;=Z09.^^76^911^9
 ;;^UTILITY(U,$J,358.3,17684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17684,1,3,0)
 ;;=3^Follow-up Exam,Compltd TX,Oth Than Cancer
 ;;^UTILITY(U,$J,358.3,17684,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,17684,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,17685,0)
 ;;=Z63.32^^76^912^2
 ;;^UTILITY(U,$J,358.3,17685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17685,1,3,0)
 ;;=3^Absence of family member, oth
 ;;^UTILITY(U,$J,358.3,17685,1,4,0)
 ;;=4^Z63.32
 ;;^UTILITY(U,$J,358.3,17685,2)
 ;;=^5063167
 ;;^UTILITY(U,$J,358.3,17686,0)
 ;;=Z71.41^^76^912^3
 ;;^UTILITY(U,$J,358.3,17686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17686,1,3,0)
 ;;=3^Alcohol abuse counslng & surveil of alcoholic
 ;;^UTILITY(U,$J,358.3,17686,1,4,0)
 ;;=4^Z71.41
 ;;^UTILITY(U,$J,358.3,17686,2)
 ;;=^5063246
 ;;^UTILITY(U,$J,358.3,17687,0)
 ;;=Z71.89^^76^912^4
 ;;^UTILITY(U,$J,358.3,17687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17687,1,3,0)
 ;;=3^Counseling, oth, spec
 ;;^UTILITY(U,$J,358.3,17687,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,17687,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,17688,0)
 ;;=Z71.9^^76^912^5
 ;;^UTILITY(U,$J,358.3,17688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17688,1,3,0)
 ;;=3^Counseling, unspec
 ;;^UTILITY(U,$J,358.3,17688,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,17688,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,17689,0)
 ;;=Z63.4^^76^912^8
 ;;^UTILITY(U,$J,358.3,17689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17689,1,3,0)
 ;;=3^Disappearance & death of family member
 ;;^UTILITY(U,$J,358.3,17689,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,17689,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,17690,0)
 ;;=Z73.82^^76^912^9
 ;;^UTILITY(U,$J,358.3,17690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17690,1,3,0)
 ;;=3^Dual sensory impairment
 ;;^UTILITY(U,$J,358.3,17690,1,4,0)
 ;;=4^Z73.82
 ;;^UTILITY(U,$J,358.3,17690,2)
 ;;=^5063279
 ;;^UTILITY(U,$J,358.3,17691,0)
 ;;=Z04.41^^76^912^10
 ;;^UTILITY(U,$J,358.3,17691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17691,1,3,0)
 ;;=3^Encntr for exam & obs folwng alleged adlt rape
 ;;^UTILITY(U,$J,358.3,17691,1,4,0)
 ;;=4^Z04.41
 ;;^UTILITY(U,$J,358.3,17691,2)
 ;;=^5062660
 ;;^UTILITY(U,$J,358.3,17692,0)
 ;;=Z76.0^^76^912^11
 ;;^UTILITY(U,$J,358.3,17692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17692,1,3,0)
 ;;=3^Encntr for issue of repeat prescription
 ;;^UTILITY(U,$J,358.3,17692,1,4,0)
 ;;=4^Z76.0
 ;;^UTILITY(U,$J,358.3,17692,2)
 ;;=^5063297
 ;;^UTILITY(U,$J,358.3,17693,0)
 ;;=Z69.12^^76^912^13
 ;;^UTILITY(U,$J,358.3,17693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17693,1,3,0)
 ;;=3^Encntr for mntl hlth serv for perp of spous or prtnr abuse
 ;;^UTILITY(U,$J,358.3,17693,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,17693,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,17694,0)
 ;;=Z69.010^^76^912^14
 ;;^UTILITY(U,$J,358.3,17694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17694,1,3,0)
 ;;=3^Encntr for mntl hlth serv for vctm of prntl child abuse
 ;;^UTILITY(U,$J,358.3,17694,1,4,0)
 ;;=4^Z69.010
 ;;^UTILITY(U,$J,358.3,17694,2)
 ;;=^5063228
 ;;^UTILITY(U,$J,358.3,17695,0)
 ;;=Z69.11^^76^912^15
 ;;^UTILITY(U,$J,358.3,17695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17695,1,3,0)
 ;;=3^Encntr for mntl hlth serv for vctm of spous or prtnr abuse
 ;;^UTILITY(U,$J,358.3,17695,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,17695,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,17696,0)
 ;;=Z65.5^^76^912^16
 ;;^UTILITY(U,$J,358.3,17696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17696,1,3,0)
 ;;=3^Expsr to disaster, war & oth hostilities
 ;;^UTILITY(U,$J,358.3,17696,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,17696,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,17697,0)
 ;;=Z59.0^^76^912^18
 ;;^UTILITY(U,$J,358.3,17697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17697,1,3,0)
 ;;=3^Homelessness
 ;;^UTILITY(U,$J,358.3,17697,1,4,0)
 ;;=4^Z59.0
 ;;^UTILITY(U,$J,358.3,17697,2)
 ;;=^5063129
 ;;^UTILITY(U,$J,358.3,17698,0)
 ;;=Z59.5^^76^912^17
 ;;^UTILITY(U,$J,358.3,17698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17698,1,3,0)
 ;;=3^Extreme poverty
 ;;^UTILITY(U,$J,358.3,17698,1,4,0)
 ;;=4^Z59.5
 ;;^UTILITY(U,$J,358.3,17698,2)
 ;;=^5063134
 ;;^UTILITY(U,$J,358.3,17699,0)
 ;;=Z71.7^^76^912^19
 ;;^UTILITY(U,$J,358.3,17699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17699,1,3,0)
 ;;=3^Human immunodeficiency virus [HIV] counseling
 ;;^UTILITY(U,$J,358.3,17699,1,4,0)
 ;;=4^Z71.7
 ;;^UTILITY(U,$J,358.3,17699,2)
 ;;=^5063251
 ;;^UTILITY(U,$J,358.3,17700,0)
 ;;=Z73.4^^76^912^20
 ;;^UTILITY(U,$J,358.3,17700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17700,1,3,0)
 ;;=3^Inadqute social skills, not elswhr classified
 ;;^UTILITY(U,$J,358.3,17700,1,4,0)
 ;;=4^Z73.4
 ;;^UTILITY(U,$J,358.3,17700,2)
 ;;=^5063272
 ;;^UTILITY(U,$J,358.3,17701,0)
 ;;=Z79.2^^76^912^22
 ;;^UTILITY(U,$J,358.3,17701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17701,1,3,0)
 ;;=3^Long term (current) use of antibiotics
 ;;^UTILITY(U,$J,358.3,17701,1,4,0)
 ;;=4^Z79.2
 ;;^UTILITY(U,$J,358.3,17701,2)
 ;;=^321546
 ;;^UTILITY(U,$J,358.3,17702,0)
 ;;=Z79.01^^76^912^23
 ;;^UTILITY(U,$J,358.3,17702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17702,1,3,0)
 ;;=3^Long term (current) use of anticoagulants
 ;;^UTILITY(U,$J,358.3,17702,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,17702,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,17703,0)
 ;;=Z79.02^^76^912^24
 ;;^UTILITY(U,$J,358.3,17703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17703,1,3,0)
 ;;=3^Long term (current) use of antithrombtc/antipltlts
 ;;^UTILITY(U,$J,358.3,17703,1,4,0)
 ;;=4^Z79.02
 ;;^UTILITY(U,$J,358.3,17703,2)
 ;;=^5063331
 ;;^UTILITY(U,$J,358.3,17704,0)
 ;;=Z79.82^^76^912^25
 ;;^UTILITY(U,$J,358.3,17704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17704,1,3,0)
 ;;=3^Long term (current) use of aspirin
 ;;^UTILITY(U,$J,358.3,17704,1,4,0)
 ;;=4^Z79.82
 ;;^UTILITY(U,$J,358.3,17704,2)
 ;;=^5063340
 ;;^UTILITY(U,$J,358.3,17705,0)
 ;;=Z79.899^^76^912^21
 ;;^UTILITY(U,$J,358.3,17705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17705,1,3,0)
 ;;=3^Long term (current) drug therapy, oth
 ;;^UTILITY(U,$J,358.3,17705,1,4,0)
 ;;=4^Z79.899
 ;;^UTILITY(U,$J,358.3,17705,2)
 ;;=^5063343
 ;;^UTILITY(U,$J,358.3,17706,0)
 ;;=Z79.51^^76^912^26
 ;;^UTILITY(U,$J,358.3,17706,1,0)
 ;;=^358.31IA^4^2
