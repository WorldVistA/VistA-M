IBDEI00X ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,885,1,3,0)
 ;;=3^Encnter for MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,885,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,885,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,886,0)
 ;;=T74.01XA^^3^21^16
 ;;^UTILITY(U,$J,358.3,886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,886,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Confirmed,Initial Encnter
 ;;^UTILITY(U,$J,358.3,886,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,886,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,887,0)
 ;;=T74.01XD^^3^21^17
 ;;^UTILITY(U,$J,358.3,887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,887,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Confirmed,Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,887,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,887,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,888,0)
 ;;=T76.01XA^^3^21^18
 ;;^UTILITY(U,$J,358.3,888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,888,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Suspected,Initial Encnter
 ;;^UTILITY(U,$J,358.3,888,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,888,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,889,0)
 ;;=T76.01XD^^3^21^19
 ;;^UTILITY(U,$J,358.3,889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,889,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Suspected,Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,889,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,889,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,890,0)
 ;;=Z91.412^^3^21^7
 ;;^UTILITY(U,$J,358.3,890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,890,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,890,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,890,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,891,0)
 ;;=T74.31XA^^3^21^20
 ;;^UTILITY(U,$J,358.3,891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,891,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Confirmed Initial Encnter
 ;;^UTILITY(U,$J,358.3,891,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,891,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,892,0)
 ;;=T74.31XD^^3^21^21
 ;;^UTILITY(U,$J,358.3,892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,892,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Confirmed Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,892,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,892,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,893,0)
 ;;=T76.31XA^^3^21^22
 ;;^UTILITY(U,$J,358.3,893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,893,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Suspected Initial Encnter
 ;;^UTILITY(U,$J,358.3,893,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,893,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,894,0)
 ;;=T76.31XD^^3^21^23
 ;;^UTILITY(U,$J,358.3,894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,894,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Suspected Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,894,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,894,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,895,0)
 ;;=Z91.411^^3^21^6
 ;;^UTILITY(U,$J,358.3,895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,895,1,3,0)
 ;;=3^Personal Hx of Spouse or Parnter Psychological Abuse
 ;;^UTILITY(U,$J,358.3,895,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,895,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,896,0)
 ;;=F06.4^^3^22^4
 ;;^UTILITY(U,$J,358.3,896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,896,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,896,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,896,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,897,0)
 ;;=F41.9^^3^22^16
 ;;^UTILITY(U,$J,358.3,897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,897,1,3,0)
 ;;=3^Unspec Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,897,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,897,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,898,0)
 ;;=F41.0^^3^22^14
 ;;^UTILITY(U,$J,358.3,898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,898,1,3,0)
 ;;=3^Panic Disorder
 ;;^UTILITY(U,$J,358.3,898,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,898,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,899,0)
 ;;=F41.1^^3^22^10
 ;;^UTILITY(U,$J,358.3,899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,899,1,3,0)
 ;;=3^Generalized Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,899,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,899,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,900,0)
 ;;=F41.9^^3^22^13
 ;;^UTILITY(U,$J,358.3,900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,900,1,3,0)
 ;;=3^Oth Spec Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,900,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,900,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,901,0)
 ;;=F40.02^^3^22^2
 ;;^UTILITY(U,$J,358.3,901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,901,1,3,0)
 ;;=3^Agoraphobia
 ;;^UTILITY(U,$J,358.3,901,1,4,0)
 ;;=4^F40.02
 ;;^UTILITY(U,$J,358.3,901,2)
 ;;=^5003543
 ;;^UTILITY(U,$J,358.3,902,0)
 ;;=F40.10^^3^22^15
 ;;^UTILITY(U,$J,358.3,902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,902,1,3,0)
 ;;=3^Social Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,902,1,4,0)
 ;;=4^F40.10
 ;;^UTILITY(U,$J,358.3,902,2)
 ;;=^5003544
 ;;^UTILITY(U,$J,358.3,903,0)
 ;;=F40.218^^3^22^3
 ;;^UTILITY(U,$J,358.3,903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,903,1,3,0)
 ;;=3^Animal Type Phobias
 ;;^UTILITY(U,$J,358.3,903,1,4,0)
 ;;=4^F40.218
 ;;^UTILITY(U,$J,358.3,903,2)
 ;;=^5003547
 ;;^UTILITY(U,$J,358.3,904,0)
 ;;=F40.228^^3^22^11
 ;;^UTILITY(U,$J,358.3,904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,904,1,3,0)
 ;;=3^Natural Environment Type Phobia
 ;;^UTILITY(U,$J,358.3,904,1,4,0)
 ;;=4^F40.228
 ;;^UTILITY(U,$J,358.3,904,2)
 ;;=^5003549
 ;;^UTILITY(U,$J,358.3,905,0)
 ;;=F40.230^^3^22^6
 ;;^UTILITY(U,$J,358.3,905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,905,1,3,0)
 ;;=3^Fear of Blood
 ;;^UTILITY(U,$J,358.3,905,1,4,0)
 ;;=4^F40.230
 ;;^UTILITY(U,$J,358.3,905,2)
 ;;=^5003550
 ;;^UTILITY(U,$J,358.3,906,0)
 ;;=F40.231^^3^22^7
 ;;^UTILITY(U,$J,358.3,906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,906,1,3,0)
 ;;=3^Fear of Injections & Transfusions
 ;;^UTILITY(U,$J,358.3,906,1,4,0)
 ;;=4^F40.231
 ;;^UTILITY(U,$J,358.3,906,2)
 ;;=^5003551
 ;;^UTILITY(U,$J,358.3,907,0)
 ;;=F40.232^^3^22^9
 ;;^UTILITY(U,$J,358.3,907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,907,1,3,0)
 ;;=3^Fear of Oth Medical Care
 ;;^UTILITY(U,$J,358.3,907,1,4,0)
 ;;=4^F40.232
 ;;^UTILITY(U,$J,358.3,907,2)
 ;;=^5003552
 ;;^UTILITY(U,$J,358.3,908,0)
 ;;=F40.233^^3^22^8
 ;;^UTILITY(U,$J,358.3,908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,908,1,3,0)
 ;;=3^Fear of Injury
 ;;^UTILITY(U,$J,358.3,908,1,4,0)
 ;;=4^F40.233
 ;;^UTILITY(U,$J,358.3,908,2)
 ;;=^5003553
 ;;^UTILITY(U,$J,358.3,909,0)
 ;;=F40.240^^3^22^5
 ;;^UTILITY(U,$J,358.3,909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,909,1,3,0)
 ;;=3^Claustrophobia
 ;;^UTILITY(U,$J,358.3,909,1,4,0)
 ;;=4^F40.240
 ;;^UTILITY(U,$J,358.3,909,2)
 ;;=^5003554
 ;;^UTILITY(U,$J,358.3,910,0)
 ;;=F40.241^^3^22^1
 ;;^UTILITY(U,$J,358.3,910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,910,1,3,0)
 ;;=3^Acrophobia
 ;;^UTILITY(U,$J,358.3,910,1,4,0)
 ;;=4^F40.241
 ;;^UTILITY(U,$J,358.3,910,2)
 ;;=^5003555
 ;;^UTILITY(U,$J,358.3,911,0)
 ;;=F40.248^^3^22^12
 ;;^UTILITY(U,$J,358.3,911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,911,1,3,0)
 ;;=3^Oth Situational Type Phobia
 ;;^UTILITY(U,$J,358.3,911,1,4,0)
 ;;=4^F40.248
 ;;^UTILITY(U,$J,358.3,911,2)
 ;;=^5003558
 ;;^UTILITY(U,$J,358.3,912,0)
 ;;=F06.33^^3^23^1
 ;;^UTILITY(U,$J,358.3,912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,912,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Medical Condition w/ Manic Features
 ;;^UTILITY(U,$J,358.3,912,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,912,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,913,0)
 ;;=F06.34^^3^23^2
 ;;^UTILITY(U,$J,358.3,913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,913,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Medical Condition w/ Mixed Features
 ;;^UTILITY(U,$J,358.3,913,1,4,0)
 ;;=4^F06.34
 ;;^UTILITY(U,$J,358.3,913,2)
 ;;=^5003060
 ;;^UTILITY(U,$J,358.3,914,0)
 ;;=F31.11^^3^23^4
 ;;^UTILITY(U,$J,358.3,914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,914,1,3,0)
 ;;=3^Bipolor I Disorder,Current/Recent Episode Manic,Mild
 ;;^UTILITY(U,$J,358.3,914,1,4,0)
 ;;=4^F31.11
 ;;^UTILITY(U,$J,358.3,914,2)
 ;;=^5003496
 ;;^UTILITY(U,$J,358.3,915,0)
 ;;=F31.12^^3^23^5
 ;;^UTILITY(U,$J,358.3,915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,915,1,3,0)
 ;;=3^Bipolor I Disorder,Current/Recent Episode Manic,Moderate
 ;;^UTILITY(U,$J,358.3,915,1,4,0)
 ;;=4^F31.12
 ;;^UTILITY(U,$J,358.3,915,2)
 ;;=^5003497
 ;;^UTILITY(U,$J,358.3,916,0)
 ;;=F31.13^^3^23^6
 ;;^UTILITY(U,$J,358.3,916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,916,1,3,0)
 ;;=3^Bipolor I Disorder,Current/Recent Episode Manic,Severe
 ;;^UTILITY(U,$J,358.3,916,1,4,0)
 ;;=4^F31.13
 ;;^UTILITY(U,$J,358.3,916,2)
 ;;=^5003498
 ;;^UTILITY(U,$J,358.3,917,0)
 ;;=F31.2^^3^23^7
 ;;^UTILITY(U,$J,358.3,917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,917,1,3,0)
 ;;=3^Bipolor I Disorder,Current/Recent Episode Manic,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,917,1,4,0)
 ;;=4^F31.2
 ;;^UTILITY(U,$J,358.3,917,2)
 ;;=^5003499
 ;;^UTILITY(U,$J,358.3,918,0)
 ;;=F31.73^^3^23^8
 ;;^UTILITY(U,$J,358.3,918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,918,1,3,0)
 ;;=3^Bipolor I Disorder,Current/Recent Episode Manic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,918,1,4,0)
 ;;=4^F31.73
 ;;^UTILITY(U,$J,358.3,918,2)
 ;;=^5003513
 ;;^UTILITY(U,$J,358.3,919,0)
 ;;=F31.74^^3^23^9
 ;;^UTILITY(U,$J,358.3,919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,919,1,3,0)
 ;;=3^Bipolor I Disorder,Current/Recent Episode Manic,In Full Remission
 ;;^UTILITY(U,$J,358.3,919,1,4,0)
 ;;=4^F31.74
 ;;^UTILITY(U,$J,358.3,919,2)
 ;;=^5003514
 ;;^UTILITY(U,$J,358.3,920,0)
 ;;=F31.30^^3^23^10
 ;;^UTILITY(U,$J,358.3,920,1,0)
 ;;=^358.31IA^4^2
