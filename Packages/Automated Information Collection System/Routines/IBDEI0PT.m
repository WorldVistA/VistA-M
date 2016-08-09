IBDEI0PT ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25957,1,3,0)
 ;;=3^Mental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,25957,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,25957,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,25958,0)
 ;;=F06.8^^97^1233^3
 ;;^UTILITY(U,$J,358.3,25958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25958,1,3,0)
 ;;=3^Mental Disorders,Oth Specified,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,25958,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,25958,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,25959,0)
 ;;=F09.^^97^1233^4
 ;;^UTILITY(U,$J,358.3,25959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25959,1,3,0)
 ;;=3^Mental Disorders,Unspec,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,25959,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,25959,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,25960,0)
 ;;=F99.^^97^1233^2
 ;;^UTILITY(U,$J,358.3,25960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25960,1,3,0)
 ;;=3^Mental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25960,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,25960,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,25961,0)
 ;;=F84.0^^97^1234^7
 ;;^UTILITY(U,$J,358.3,25961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25961,1,3,0)
 ;;=3^Autism Spectrum Disorder Assoc w/ a Known Med/Genetic Cond or Environ Factor
 ;;^UTILITY(U,$J,358.3,25961,1,4,0)
 ;;=4^F84.0
 ;;^UTILITY(U,$J,358.3,25961,2)
 ;;=^5003684
 ;;^UTILITY(U,$J,358.3,25962,0)
 ;;=F80.9^^97^1234^10
 ;;^UTILITY(U,$J,358.3,25962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25962,1,3,0)
 ;;=3^Communication Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25962,1,4,0)
 ;;=4^F80.9
 ;;^UTILITY(U,$J,358.3,25962,2)
 ;;=^5003678
 ;;^UTILITY(U,$J,358.3,25963,0)
 ;;=F82.^^97^1234^11
 ;;^UTILITY(U,$J,358.3,25963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25963,1,3,0)
 ;;=3^Developmental Coordination Disorder
 ;;^UTILITY(U,$J,358.3,25963,1,4,0)
 ;;=4^F82.
 ;;^UTILITY(U,$J,358.3,25963,2)
 ;;=^5003683
 ;;^UTILITY(U,$J,358.3,25964,0)
 ;;=F88.^^97^1234^12
 ;;^UTILITY(U,$J,358.3,25964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25964,1,3,0)
 ;;=3^Global Developmental Delay
 ;;^UTILITY(U,$J,358.3,25964,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,25964,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,25965,0)
 ;;=F80.2^^97^1234^18
 ;;^UTILITY(U,$J,358.3,25965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25965,1,3,0)
 ;;=3^Language Disorder
 ;;^UTILITY(U,$J,358.3,25965,1,4,0)
 ;;=4^F80.2
 ;;^UTILITY(U,$J,358.3,25965,2)
 ;;=^331959
 ;;^UTILITY(U,$J,358.3,25966,0)
 ;;=F81.2^^97^1234^19
 ;;^UTILITY(U,$J,358.3,25966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25966,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Mathematics
 ;;^UTILITY(U,$J,358.3,25966,1,4,0)
 ;;=4^F81.2
 ;;^UTILITY(U,$J,358.3,25966,2)
 ;;=^331957
 ;;^UTILITY(U,$J,358.3,25967,0)
 ;;=F81.0^^97^1234^20
 ;;^UTILITY(U,$J,358.3,25967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25967,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Reading
 ;;^UTILITY(U,$J,358.3,25967,1,4,0)
 ;;=4^F81.0
 ;;^UTILITY(U,$J,358.3,25967,2)
 ;;=^5003679
 ;;^UTILITY(U,$J,358.3,25968,0)
 ;;=F81.81^^97^1234^21
 ;;^UTILITY(U,$J,358.3,25968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25968,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Written Expression
 ;;^UTILITY(U,$J,358.3,25968,1,4,0)
 ;;=4^F81.81
 ;;^UTILITY(U,$J,358.3,25968,2)
 ;;=^5003680
 ;;^UTILITY(U,$J,358.3,25969,0)
 ;;=F88.^^97^1234^22
 ;;^UTILITY(U,$J,358.3,25969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25969,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,25969,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,25969,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,25970,0)
 ;;=F89.^^97^1234^23
 ;;^UTILITY(U,$J,358.3,25970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25970,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25970,1,4,0)
 ;;=4^F89.
 ;;^UTILITY(U,$J,358.3,25970,2)
 ;;=^5003691
 ;;^UTILITY(U,$J,358.3,25971,0)
 ;;=F95.1^^97^1234^24
 ;;^UTILITY(U,$J,358.3,25971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25971,1,3,0)
 ;;=3^Persistent (Chronic) Motor or Vocal Tic Disorder w/ Motor Tics Only
 ;;^UTILITY(U,$J,358.3,25971,1,4,0)
 ;;=4^F95.1
 ;;^UTILITY(U,$J,358.3,25971,2)
 ;;=^331941
 ;;^UTILITY(U,$J,358.3,25972,0)
 ;;=F95.0^^97^1234^26
 ;;^UTILITY(U,$J,358.3,25972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25972,1,3,0)
 ;;=3^Provisional Tic Disorder
 ;;^UTILITY(U,$J,358.3,25972,1,4,0)
 ;;=4^F95.0
 ;;^UTILITY(U,$J,358.3,25972,2)
 ;;=^331940
 ;;^UTILITY(U,$J,358.3,25973,0)
 ;;=F80.89^^97^1234^27
 ;;^UTILITY(U,$J,358.3,25973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25973,1,3,0)
 ;;=3^Social (Pragmatic) Communication Disorder
 ;;^UTILITY(U,$J,358.3,25973,1,4,0)
 ;;=4^F80.89
 ;;^UTILITY(U,$J,358.3,25973,2)
 ;;=^5003677
 ;;^UTILITY(U,$J,358.3,25974,0)
 ;;=F80.0^^97^1234^28
 ;;^UTILITY(U,$J,358.3,25974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25974,1,3,0)
 ;;=3^Speech Sound Disorder
 ;;^UTILITY(U,$J,358.3,25974,1,4,0)
 ;;=4^F80.0
 ;;^UTILITY(U,$J,358.3,25974,2)
 ;;=^5003674
 ;;^UTILITY(U,$J,358.3,25975,0)
 ;;=F98.4^^97^1234^29
 ;;^UTILITY(U,$J,358.3,25975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25975,1,3,0)
 ;;=3^Stereotypic Movement D/O Assoc w/ Known Med/Gene Cond/Neurod D/O or Environ Factor
 ;;^UTILITY(U,$J,358.3,25975,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,25975,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,25976,0)
 ;;=F95.8^^97^1234^32
 ;;^UTILITY(U,$J,358.3,25976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25976,1,3,0)
 ;;=3^Tic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,25976,1,4,0)
 ;;=4^F95.8
 ;;^UTILITY(U,$J,358.3,25976,2)
 ;;=^5003709
 ;;^UTILITY(U,$J,358.3,25977,0)
 ;;=F95.9^^97^1234^33
 ;;^UTILITY(U,$J,358.3,25977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25977,1,3,0)
 ;;=3^Tic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25977,1,4,0)
 ;;=4^F95.9
 ;;^UTILITY(U,$J,358.3,25977,2)
 ;;=^5003710
 ;;^UTILITY(U,$J,358.3,25978,0)
 ;;=F95.2^^97^1234^34
 ;;^UTILITY(U,$J,358.3,25978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25978,1,3,0)
 ;;=3^Tourette's Disorder
 ;;^UTILITY(U,$J,358.3,25978,1,4,0)
 ;;=4^F95.2
 ;;^UTILITY(U,$J,358.3,25978,2)
 ;;=^331942
 ;;^UTILITY(U,$J,358.3,25979,0)
 ;;=F98.5^^97^1234^1
 ;;^UTILITY(U,$J,358.3,25979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25979,1,3,0)
 ;;=3^Adult-Onset Fluency Disorder
 ;;^UTILITY(U,$J,358.3,25979,1,4,0)
 ;;=4^F98.5
 ;;^UTILITY(U,$J,358.3,25979,2)
 ;;=^5003717
 ;;^UTILITY(U,$J,358.3,25980,0)
 ;;=F90.2^^97^1234^2
 ;;^UTILITY(U,$J,358.3,25980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25980,1,3,0)
 ;;=3^Attention Deficit Disorder,Combined Presentation
 ;;^UTILITY(U,$J,358.3,25980,1,4,0)
 ;;=4^F90.2
 ;;^UTILITY(U,$J,358.3,25980,2)
 ;;=^5003694
 ;;^UTILITY(U,$J,358.3,25981,0)
 ;;=F90.1^^97^1234^3
 ;;^UTILITY(U,$J,358.3,25981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25981,1,3,0)
 ;;=3^Attention Deficit Disorder,Hyperactive/Impulsive Presentation
 ;;^UTILITY(U,$J,358.3,25981,1,4,0)
 ;;=4^F90.1
 ;;^UTILITY(U,$J,358.3,25981,2)
 ;;=^5003693
 ;;^UTILITY(U,$J,358.3,25982,0)
 ;;=F90.0^^97^1234^4
 ;;^UTILITY(U,$J,358.3,25982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25982,1,3,0)
 ;;=3^Attention Deficit Disorder,Predominantly Inattentive Presentation
 ;;^UTILITY(U,$J,358.3,25982,1,4,0)
 ;;=4^F90.0
 ;;^UTILITY(U,$J,358.3,25982,2)
 ;;=^5003692
 ;;^UTILITY(U,$J,358.3,25983,0)
 ;;=F06.1^^97^1234^8
 ;;^UTILITY(U,$J,358.3,25983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25983,1,3,0)
 ;;=3^Catatonia Associated w/ Another Mental Disorder
 ;;^UTILITY(U,$J,358.3,25983,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,25983,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,25984,0)
 ;;=F80.81^^97^1234^9
 ;;^UTILITY(U,$J,358.3,25984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25984,1,3,0)
 ;;=3^Child-Onset Fluency Disorder (Stuttering)
