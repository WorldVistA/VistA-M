IBDEI08O ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8624,1,3,0)
 ;;=3^Open Wound,Right Lower Leg,Unspec
 ;;^UTILITY(U,$J,358.3,8624,1,4,0)
 ;;=4^S81.801A
 ;;^UTILITY(U,$J,358.3,8624,2)
 ;;=^5040065
 ;;^UTILITY(U,$J,358.3,8625,0)
 ;;=S71.102A^^42^515^22
 ;;^UTILITY(U,$J,358.3,8625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8625,1,3,0)
 ;;=3^Open Wound,Left Thigh,Unspec
 ;;^UTILITY(U,$J,358.3,8625,1,4,0)
 ;;=4^S71.102A
 ;;^UTILITY(U,$J,358.3,8625,2)
 ;;=^5037011
 ;;^UTILITY(U,$J,358.3,8626,0)
 ;;=S71.101A^^42^515^32
 ;;^UTILITY(U,$J,358.3,8626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8626,1,3,0)
 ;;=3^Open Wound,Right Thigh,Unspec
 ;;^UTILITY(U,$J,358.3,8626,1,4,0)
 ;;=4^S71.101A
 ;;^UTILITY(U,$J,358.3,8626,2)
 ;;=^5037008
 ;;^UTILITY(U,$J,358.3,8627,0)
 ;;=S41.101A^^42^515^33
 ;;^UTILITY(U,$J,358.3,8627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8627,1,3,0)
 ;;=3^Open Wound,Right Upper Arm,Unspec
 ;;^UTILITY(U,$J,358.3,8627,1,4,0)
 ;;=4^S41.101A
 ;;^UTILITY(U,$J,358.3,8627,2)
 ;;=^5026330
 ;;^UTILITY(U,$J,358.3,8628,0)
 ;;=S09.8XXA^^42^515^1
 ;;^UTILITY(U,$J,358.3,8628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8628,1,3,0)
 ;;=3^Head Injury,Oth Specified,Init Encntr
 ;;^UTILITY(U,$J,358.3,8628,1,4,0)
 ;;=4^S09.8XXA
 ;;^UTILITY(U,$J,358.3,8628,2)
 ;;=^5021329
 ;;^UTILITY(U,$J,358.3,8629,0)
 ;;=S09.90XA^^42^515^2
 ;;^UTILITY(U,$J,358.3,8629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8629,1,3,0)
 ;;=3^Head Injury,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,8629,1,4,0)
 ;;=4^S09.90XA
 ;;^UTILITY(U,$J,358.3,8629,2)
 ;;=^5021332
 ;;^UTILITY(U,$J,358.3,8630,0)
 ;;=S06.9X1A^^42^515^5
 ;;^UTILITY(U,$J,358.3,8630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8630,1,3,0)
 ;;=3^Intracranial Inj w/ LOC of 30 min or less,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,8630,1,4,0)
 ;;=4^S06.9X1A
 ;;^UTILITY(U,$J,358.3,8630,2)
 ;;=^5021209
 ;;^UTILITY(U,$J,358.3,8631,0)
 ;;=S06.9X2A^^42^515^6
 ;;^UTILITY(U,$J,358.3,8631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8631,1,3,0)
 ;;=3^Intracranial Inj w/ LOC of 31-59 mins,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,8631,1,4,0)
 ;;=4^S06.9X2A
 ;;^UTILITY(U,$J,358.3,8631,2)
 ;;=^5021212
 ;;^UTILITY(U,$J,358.3,8632,0)
 ;;=S06.9X3A^^42^515^4
 ;;^UTILITY(U,$J,358.3,8632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8632,1,3,0)
 ;;=3^Intracranial Inj w/ LOC of 1-5 hrs 59 min,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,8632,1,4,0)
 ;;=4^S06.9X3A
 ;;^UTILITY(U,$J,358.3,8632,2)
 ;;=^5021215
 ;;^UTILITY(U,$J,358.3,8633,0)
 ;;=S06.9X4A^^42^515^7
 ;;^UTILITY(U,$J,358.3,8633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8633,1,3,0)
 ;;=3^Intracranial Inj w/ LOC of 6-24 hrs,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,8633,1,4,0)
 ;;=4^S06.9X4A
 ;;^UTILITY(U,$J,358.3,8633,2)
 ;;=^5021218
 ;;^UTILITY(U,$J,358.3,8634,0)
 ;;=S06.9X5A^^42^515^8
 ;;^UTILITY(U,$J,358.3,8634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8634,1,3,0)
 ;;=3^Intracranial Inj w/ LOC of > 24 hurs w/ Ret Consc Lev,Init Encntr
 ;;^UTILITY(U,$J,358.3,8634,1,4,0)
 ;;=4^S06.9X5A
 ;;^UTILITY(U,$J,358.3,8634,2)
 ;;=^5021221
 ;;^UTILITY(U,$J,358.3,8635,0)
 ;;=S06.9X0A^^42^515^9
 ;;^UTILITY(U,$J,358.3,8635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8635,1,3,0)
 ;;=3^Intracranial Inj w/o LOC of 30 min or less,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,8635,1,4,0)
 ;;=4^S06.9X0A
 ;;^UTILITY(U,$J,358.3,8635,2)
 ;;=^5021206
 ;;^UTILITY(U,$J,358.3,8636,0)
 ;;=S61.209A^^42^515^34
 ;;^UTILITY(U,$J,358.3,8636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8636,1,3,0)
 ;;=3^Open Wound,Unspec Finger w/o Damage to Nail,Init Encntr
 ;;^UTILITY(U,$J,358.3,8636,1,4,0)
 ;;=4^S61.209A
 ;;^UTILITY(U,$J,358.3,8636,2)
 ;;=^5032768
 ;;^UTILITY(U,$J,358.3,8637,0)
 ;;=E03.5^^42^516^37
 ;;^UTILITY(U,$J,358.3,8637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8637,1,3,0)
 ;;=3^Myxedema Coma
 ;;^UTILITY(U,$J,358.3,8637,1,4,0)
 ;;=4^E03.5
 ;;^UTILITY(U,$J,358.3,8637,2)
 ;;=^5002474
 ;;^UTILITY(U,$J,358.3,8638,0)
 ;;=R40.2121^^42^516^33
 ;;^UTILITY(U,$J,358.3,8638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8638,1,3,0)
 ;;=3^Coma Scale,Eyes Open,to Pain,In the Field
 ;;^UTILITY(U,$J,358.3,8638,1,4,0)
 ;;=4^R40.2121
 ;;^UTILITY(U,$J,358.3,8638,2)
 ;;=^5019361
 ;;^UTILITY(U,$J,358.3,8639,0)
 ;;=R40.2120^^42^516^34
 ;;^UTILITY(U,$J,358.3,8639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8639,1,3,0)
 ;;=3^Coma Scale,Eyes Open,to Pain,Unspec Time
 ;;^UTILITY(U,$J,358.3,8639,1,4,0)
 ;;=4^R40.2120
 ;;^UTILITY(U,$J,358.3,8639,2)
 ;;=^5019360
 ;;^UTILITY(U,$J,358.3,8640,0)
 ;;=R40.2114^^42^516^26
 ;;^UTILITY(U,$J,358.3,8640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8640,1,3,0)
 ;;=3^Coma Scale,Eyes Open,Never,24+ hrs
 ;;^UTILITY(U,$J,358.3,8640,1,4,0)
 ;;=4^R40.2114
 ;;^UTILITY(U,$J,358.3,8640,2)
 ;;=^5019359
 ;;^UTILITY(U,$J,358.3,8641,0)
 ;;=R40.2113^^42^516^30
 ;;^UTILITY(U,$J,358.3,8641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8641,1,3,0)
 ;;=3^Coma Scale,Eyes Open,Never,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,8641,1,4,0)
 ;;=4^R40.2113
 ;;^UTILITY(U,$J,358.3,8641,2)
 ;;=^5019358
 ;;^UTILITY(U,$J,358.3,8642,0)
 ;;=R40.2112^^42^516^27
 ;;^UTILITY(U,$J,358.3,8642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8642,1,3,0)
 ;;=3^Coma Scale,Eyes Open,Never,Emerg Dept
 ;;^UTILITY(U,$J,358.3,8642,1,4,0)
 ;;=4^R40.2112
 ;;^UTILITY(U,$J,358.3,8642,2)
 ;;=^5019357
 ;;^UTILITY(U,$J,358.3,8643,0)
 ;;=R40.2111^^42^516^28
 ;;^UTILITY(U,$J,358.3,8643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8643,1,3,0)
 ;;=3^Coma Scale,Eyes Open,Never,In the Field
 ;;^UTILITY(U,$J,358.3,8643,1,4,0)
 ;;=4^R40.2111
 ;;^UTILITY(U,$J,358.3,8643,2)
 ;;=^5019356
 ;;^UTILITY(U,$J,358.3,8644,0)
 ;;=R40.2110^^42^516^29
 ;;^UTILITY(U,$J,358.3,8644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8644,1,3,0)
 ;;=3^Coma Scale,Eyes Open,Never,Unspec Time
 ;;^UTILITY(U,$J,358.3,8644,1,4,0)
 ;;=4^R40.2110
 ;;^UTILITY(U,$J,358.3,8644,2)
 ;;=^5019355
 ;;^UTILITY(U,$J,358.3,8645,0)
 ;;=R40.20^^42^516^36
 ;;^UTILITY(U,$J,358.3,8645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8645,1,3,0)
 ;;=3^Coma,Unspec
 ;;^UTILITY(U,$J,358.3,8645,1,4,0)
 ;;=4^R40.20
 ;;^UTILITY(U,$J,358.3,8645,2)
 ;;=^5019354
 ;;^UTILITY(U,$J,358.3,8646,0)
 ;;=R40.2123^^42^516^35
 ;;^UTILITY(U,$J,358.3,8646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8646,1,3,0)
 ;;=3^Coma Scale,Eyes Open,to Pain,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,8646,1,4,0)
 ;;=4^R40.2123
 ;;^UTILITY(U,$J,358.3,8646,2)
 ;;=^5019363
 ;;^UTILITY(U,$J,358.3,8647,0)
 ;;=R40.2122^^42^516^32
 ;;^UTILITY(U,$J,358.3,8647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8647,1,3,0)
 ;;=3^Coma Scale,Eyes Open,to Pain,Emger Dept
 ;;^UTILITY(U,$J,358.3,8647,1,4,0)
 ;;=4^R40.2122
 ;;^UTILITY(U,$J,358.3,8647,2)
 ;;=^5019362
 ;;^UTILITY(U,$J,358.3,8648,0)
 ;;=R40.2124^^42^516^31
 ;;^UTILITY(U,$J,358.3,8648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8648,1,3,0)
 ;;=3^Coma Scale,Eyes Open,to Pain,24+ Hrs
 ;;^UTILITY(U,$J,358.3,8648,1,4,0)
 ;;=4^R40.2124
 ;;^UTILITY(U,$J,358.3,8648,2)
 ;;=^5019364
 ;;^UTILITY(U,$J,358.3,8649,0)
 ;;=R40.2211^^42^516^17
 ;;^UTILITY(U,$J,358.3,8649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8649,1,3,0)
 ;;=3^Coma Scale,Best Verbal Response,None,in the Field
 ;;^UTILITY(U,$J,358.3,8649,1,4,0)
 ;;=4^R40.2211
 ;;^UTILITY(U,$J,358.3,8649,2)
 ;;=^5019376
 ;;^UTILITY(U,$J,358.3,8650,0)
 ;;=R40.2210^^42^516^16
 ;;^UTILITY(U,$J,358.3,8650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8650,1,3,0)
 ;;=3^Coma Scale,Best Verbal Response,None,Unspec Time
 ;;^UTILITY(U,$J,358.3,8650,1,4,0)
 ;;=4^R40.2210
 ;;^UTILITY(U,$J,358.3,8650,2)
 ;;=^5019375
 ;;^UTILITY(U,$J,358.3,8651,0)
 ;;=R40.2224^^42^516^18
 ;;^UTILITY(U,$J,358.3,8651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8651,1,3,0)
 ;;=3^Coma Scale,Best Verbal,Incomprehensible Words,24+ Hrs
