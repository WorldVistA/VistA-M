IBDEI0UN ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40270,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,40270,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,40271,0)
 ;;=F06.8^^114^1704^3
 ;;^UTILITY(U,$J,358.3,40271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40271,1,3,0)
 ;;=3^Mental Disorders,Oth Specified,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,40271,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,40271,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,40272,0)
 ;;=F09.^^114^1704^4
 ;;^UTILITY(U,$J,358.3,40272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40272,1,3,0)
 ;;=3^Mental Disorders,Unspec,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,40272,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,40272,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,40273,0)
 ;;=F99.^^114^1704^2
 ;;^UTILITY(U,$J,358.3,40273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40273,1,3,0)
 ;;=3^Mental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,40273,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,40273,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,40274,0)
 ;;=F84.0^^114^1705^7
 ;;^UTILITY(U,$J,358.3,40274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40274,1,3,0)
 ;;=3^Autism Spectrum Disorder Assoc w/ a Known Med/Genetic Cond or Environ Factor
 ;;^UTILITY(U,$J,358.3,40274,1,4,0)
 ;;=4^F84.0
 ;;^UTILITY(U,$J,358.3,40274,2)
 ;;=^5003684
 ;;^UTILITY(U,$J,358.3,40275,0)
 ;;=F80.9^^114^1705^10
 ;;^UTILITY(U,$J,358.3,40275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40275,1,3,0)
 ;;=3^Communication Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,40275,1,4,0)
 ;;=4^F80.9
 ;;^UTILITY(U,$J,358.3,40275,2)
 ;;=^5003678
 ;;^UTILITY(U,$J,358.3,40276,0)
 ;;=F82.^^114^1705^11
 ;;^UTILITY(U,$J,358.3,40276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40276,1,3,0)
 ;;=3^Developmental Coordination Disorder
 ;;^UTILITY(U,$J,358.3,40276,1,4,0)
 ;;=4^F82.
 ;;^UTILITY(U,$J,358.3,40276,2)
 ;;=^5003683
 ;;^UTILITY(U,$J,358.3,40277,0)
 ;;=F88.^^114^1705^12
 ;;^UTILITY(U,$J,358.3,40277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40277,1,3,0)
 ;;=3^Global Developmental Delay
 ;;^UTILITY(U,$J,358.3,40277,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,40277,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,40278,0)
 ;;=F80.2^^114^1705^18
 ;;^UTILITY(U,$J,358.3,40278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40278,1,3,0)
 ;;=3^Language Disorder
 ;;^UTILITY(U,$J,358.3,40278,1,4,0)
 ;;=4^F80.2
 ;;^UTILITY(U,$J,358.3,40278,2)
 ;;=^331959
 ;;^UTILITY(U,$J,358.3,40279,0)
 ;;=F81.2^^114^1705^19
 ;;^UTILITY(U,$J,358.3,40279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40279,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Mathematics
 ;;^UTILITY(U,$J,358.3,40279,1,4,0)
 ;;=4^F81.2
 ;;^UTILITY(U,$J,358.3,40279,2)
 ;;=^331957
 ;;^UTILITY(U,$J,358.3,40280,0)
 ;;=F81.0^^114^1705^20
 ;;^UTILITY(U,$J,358.3,40280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40280,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Reading
 ;;^UTILITY(U,$J,358.3,40280,1,4,0)
 ;;=4^F81.0
 ;;^UTILITY(U,$J,358.3,40280,2)
 ;;=^5003679
 ;;^UTILITY(U,$J,358.3,40281,0)
 ;;=F81.81^^114^1705^21
 ;;^UTILITY(U,$J,358.3,40281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40281,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Written Expression
 ;;^UTILITY(U,$J,358.3,40281,1,4,0)
 ;;=4^F81.81
 ;;^UTILITY(U,$J,358.3,40281,2)
 ;;=^5003680
 ;;^UTILITY(U,$J,358.3,40282,0)
 ;;=F88.^^114^1705^22
 ;;^UTILITY(U,$J,358.3,40282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40282,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,40282,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,40282,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,40283,0)
 ;;=F89.^^114^1705^23
 ;;^UTILITY(U,$J,358.3,40283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40283,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,40283,1,4,0)
 ;;=4^F89.
 ;;^UTILITY(U,$J,358.3,40283,2)
 ;;=^5003691
 ;;^UTILITY(U,$J,358.3,40284,0)
 ;;=F95.1^^114^1705^24
 ;;^UTILITY(U,$J,358.3,40284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40284,1,3,0)
 ;;=3^Persistent (Chronic) Motor or Vocal Tic Disorder w/ Motor Tics Only
 ;;^UTILITY(U,$J,358.3,40284,1,4,0)
 ;;=4^F95.1
 ;;^UTILITY(U,$J,358.3,40284,2)
 ;;=^331941
 ;;^UTILITY(U,$J,358.3,40285,0)
 ;;=F95.0^^114^1705^26
 ;;^UTILITY(U,$J,358.3,40285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40285,1,3,0)
 ;;=3^Provisional Tic Disorder
 ;;^UTILITY(U,$J,358.3,40285,1,4,0)
 ;;=4^F95.0
 ;;^UTILITY(U,$J,358.3,40285,2)
 ;;=^331940
 ;;^UTILITY(U,$J,358.3,40286,0)
 ;;=F80.89^^114^1705^27
 ;;^UTILITY(U,$J,358.3,40286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40286,1,3,0)
 ;;=3^Social (Pragmatic) Communication Disorder
 ;;^UTILITY(U,$J,358.3,40286,1,4,0)
 ;;=4^F80.89
 ;;^UTILITY(U,$J,358.3,40286,2)
 ;;=^5003677
 ;;^UTILITY(U,$J,358.3,40287,0)
 ;;=F80.0^^114^1705^28
 ;;^UTILITY(U,$J,358.3,40287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40287,1,3,0)
 ;;=3^Speech Sound Disorder
 ;;^UTILITY(U,$J,358.3,40287,1,4,0)
 ;;=4^F80.0
 ;;^UTILITY(U,$J,358.3,40287,2)
 ;;=^5003674
 ;;^UTILITY(U,$J,358.3,40288,0)
 ;;=F98.4^^114^1705^29
 ;;^UTILITY(U,$J,358.3,40288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40288,1,3,0)
 ;;=3^Stereotypic Movement D/O Assoc w/ Known Med/Gene Cond/Neurod D/O or Environ Factor
 ;;^UTILITY(U,$J,358.3,40288,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,40288,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,40289,0)
 ;;=F95.8^^114^1705^32
 ;;^UTILITY(U,$J,358.3,40289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40289,1,3,0)
 ;;=3^Tic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,40289,1,4,0)
 ;;=4^F95.8
 ;;^UTILITY(U,$J,358.3,40289,2)
 ;;=^5003709
 ;;^UTILITY(U,$J,358.3,40290,0)
 ;;=F95.9^^114^1705^33
 ;;^UTILITY(U,$J,358.3,40290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40290,1,3,0)
 ;;=3^Tic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,40290,1,4,0)
 ;;=4^F95.9
 ;;^UTILITY(U,$J,358.3,40290,2)
 ;;=^5003710
 ;;^UTILITY(U,$J,358.3,40291,0)
 ;;=F95.2^^114^1705^34
 ;;^UTILITY(U,$J,358.3,40291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40291,1,3,0)
 ;;=3^Tourette's Disorder
 ;;^UTILITY(U,$J,358.3,40291,1,4,0)
 ;;=4^F95.2
 ;;^UTILITY(U,$J,358.3,40291,2)
 ;;=^331942
 ;;^UTILITY(U,$J,358.3,40292,0)
 ;;=F98.5^^114^1705^1
 ;;^UTILITY(U,$J,358.3,40292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40292,1,3,0)
 ;;=3^Adult-Onset Fluency Disorder
 ;;^UTILITY(U,$J,358.3,40292,1,4,0)
 ;;=4^F98.5
 ;;^UTILITY(U,$J,358.3,40292,2)
 ;;=^5003717
 ;;^UTILITY(U,$J,358.3,40293,0)
 ;;=F90.2^^114^1705^2
 ;;^UTILITY(U,$J,358.3,40293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40293,1,3,0)
 ;;=3^Attention Deficit Disorder,Combined Presentation
 ;;^UTILITY(U,$J,358.3,40293,1,4,0)
 ;;=4^F90.2
 ;;^UTILITY(U,$J,358.3,40293,2)
 ;;=^5003694
 ;;^UTILITY(U,$J,358.3,40294,0)
 ;;=F90.1^^114^1705^3
 ;;^UTILITY(U,$J,358.3,40294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40294,1,3,0)
 ;;=3^Attention Deficit Disorder,Hyperactive/Impulsive Presentation
 ;;^UTILITY(U,$J,358.3,40294,1,4,0)
 ;;=4^F90.1
 ;;^UTILITY(U,$J,358.3,40294,2)
 ;;=^5003693
 ;;^UTILITY(U,$J,358.3,40295,0)
 ;;=F90.0^^114^1705^4
 ;;^UTILITY(U,$J,358.3,40295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40295,1,3,0)
 ;;=3^Attention Deficit Disorder,Predominantly Inattentive Presentation
 ;;^UTILITY(U,$J,358.3,40295,1,4,0)
 ;;=4^F90.0
 ;;^UTILITY(U,$J,358.3,40295,2)
 ;;=^5003692
 ;;^UTILITY(U,$J,358.3,40296,0)
 ;;=F06.1^^114^1705^8
 ;;^UTILITY(U,$J,358.3,40296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40296,1,3,0)
 ;;=3^Catatonia Associated w/ Another Mental Disorder
 ;;^UTILITY(U,$J,358.3,40296,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,40296,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,40297,0)
 ;;=F80.81^^114^1705^9
 ;;^UTILITY(U,$J,358.3,40297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40297,1,3,0)
 ;;=3^Child-Onset Fluency Disorder (Stuttering)
 ;;^UTILITY(U,$J,358.3,40297,1,4,0)
 ;;=4^F80.81
 ;;^UTILITY(U,$J,358.3,40297,2)
 ;;=^5003676
 ;;^UTILITY(U,$J,358.3,40298,0)
 ;;=F70.^^114^1705^13
 ;;^UTILITY(U,$J,358.3,40298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40298,1,3,0)
 ;;=3^Intellectual Disability,Mild
 ;;^UTILITY(U,$J,358.3,40298,1,4,0)
 ;;=4^F70.
 ;;^UTILITY(U,$J,358.3,40298,2)
 ;;=^5003668
 ;;^UTILITY(U,$J,358.3,40299,0)
 ;;=F71.^^114^1705^14
 ;;^UTILITY(U,$J,358.3,40299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40299,1,3,0)
 ;;=3^Intellectual Disability,Moderate
 ;;^UTILITY(U,$J,358.3,40299,1,4,0)
 ;;=4^F71.
 ;;^UTILITY(U,$J,358.3,40299,2)
 ;;=^5003669
 ;;^UTILITY(U,$J,358.3,40300,0)
 ;;=F73.^^114^1705^15
 ;;^UTILITY(U,$J,358.3,40300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40300,1,3,0)
 ;;=3^Intellectual Disability,Profound
 ;;^UTILITY(U,$J,358.3,40300,1,4,0)
 ;;=4^F73.
 ;;^UTILITY(U,$J,358.3,40300,2)
 ;;=^5003671
 ;;^UTILITY(U,$J,358.3,40301,0)
 ;;=F72.^^114^1705^16
 ;;^UTILITY(U,$J,358.3,40301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40301,1,3,0)
 ;;=3^Intellectual Disability,Severe
 ;;^UTILITY(U,$J,358.3,40301,1,4,0)
 ;;=4^F72.
 ;;^UTILITY(U,$J,358.3,40301,2)
 ;;=^5003670
 ;;^UTILITY(U,$J,358.3,40302,0)
 ;;=F90.8^^114^1705^5
 ;;^UTILITY(U,$J,358.3,40302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40302,1,3,0)
 ;;=3^Attention Deficit/Hyperactivity Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,40302,1,4,0)
 ;;=4^F90.8
 ;;^UTILITY(U,$J,358.3,40302,2)
 ;;=^5003695
 ;;^UTILITY(U,$J,358.3,40303,0)
 ;;=F95.1^^114^1705^25
 ;;^UTILITY(U,$J,358.3,40303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40303,1,3,0)
 ;;=3^Persistent (Chronic) Motor or Vocal Tic Disorder w/ Vocal Tics Only
 ;;^UTILITY(U,$J,358.3,40303,1,4,0)
 ;;=4^F95.1
 ;;^UTILITY(U,$J,358.3,40303,2)
 ;;=^331941
 ;;^UTILITY(U,$J,358.3,40304,0)
 ;;=F98.4^^114^1705^30
 ;;^UTILITY(U,$J,358.3,40304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40304,1,3,0)
 ;;=3^Stereotypic Movement D/O w/ Self-Injurious Behavior
 ;;^UTILITY(U,$J,358.3,40304,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,40304,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,40305,0)
 ;;=F98.4^^114^1705^31
