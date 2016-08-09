IBDEI0P1 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25207,1,4,0)
 ;;=4^F80.2
 ;;^UTILITY(U,$J,358.3,25207,2)
 ;;=^331959
 ;;^UTILITY(U,$J,358.3,25208,0)
 ;;=F81.2^^95^1189^19
 ;;^UTILITY(U,$J,358.3,25208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25208,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Mathematics
 ;;^UTILITY(U,$J,358.3,25208,1,4,0)
 ;;=4^F81.2
 ;;^UTILITY(U,$J,358.3,25208,2)
 ;;=^331957
 ;;^UTILITY(U,$J,358.3,25209,0)
 ;;=F81.0^^95^1189^20
 ;;^UTILITY(U,$J,358.3,25209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25209,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Reading
 ;;^UTILITY(U,$J,358.3,25209,1,4,0)
 ;;=4^F81.0
 ;;^UTILITY(U,$J,358.3,25209,2)
 ;;=^5003679
 ;;^UTILITY(U,$J,358.3,25210,0)
 ;;=F81.81^^95^1189^21
 ;;^UTILITY(U,$J,358.3,25210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25210,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Written Expression
 ;;^UTILITY(U,$J,358.3,25210,1,4,0)
 ;;=4^F81.81
 ;;^UTILITY(U,$J,358.3,25210,2)
 ;;=^5003680
 ;;^UTILITY(U,$J,358.3,25211,0)
 ;;=F88.^^95^1189^22
 ;;^UTILITY(U,$J,358.3,25211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25211,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,25211,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,25211,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,25212,0)
 ;;=F89.^^95^1189^23
 ;;^UTILITY(U,$J,358.3,25212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25212,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25212,1,4,0)
 ;;=4^F89.
 ;;^UTILITY(U,$J,358.3,25212,2)
 ;;=^5003691
 ;;^UTILITY(U,$J,358.3,25213,0)
 ;;=F95.1^^95^1189^24
 ;;^UTILITY(U,$J,358.3,25213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25213,1,3,0)
 ;;=3^Persistent (Chronic) Motor or Vocal Tic Disorder w/ Motor Tics Only
 ;;^UTILITY(U,$J,358.3,25213,1,4,0)
 ;;=4^F95.1
 ;;^UTILITY(U,$J,358.3,25213,2)
 ;;=^331941
 ;;^UTILITY(U,$J,358.3,25214,0)
 ;;=F95.0^^95^1189^26
 ;;^UTILITY(U,$J,358.3,25214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25214,1,3,0)
 ;;=3^Provisional Tic Disorder
 ;;^UTILITY(U,$J,358.3,25214,1,4,0)
 ;;=4^F95.0
 ;;^UTILITY(U,$J,358.3,25214,2)
 ;;=^331940
 ;;^UTILITY(U,$J,358.3,25215,0)
 ;;=F80.89^^95^1189^27
 ;;^UTILITY(U,$J,358.3,25215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25215,1,3,0)
 ;;=3^Social (Pragmatic) Communication Disorder
 ;;^UTILITY(U,$J,358.3,25215,1,4,0)
 ;;=4^F80.89
 ;;^UTILITY(U,$J,358.3,25215,2)
 ;;=^5003677
 ;;^UTILITY(U,$J,358.3,25216,0)
 ;;=F80.0^^95^1189^28
 ;;^UTILITY(U,$J,358.3,25216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25216,1,3,0)
 ;;=3^Speech Sound Disorder
 ;;^UTILITY(U,$J,358.3,25216,1,4,0)
 ;;=4^F80.0
 ;;^UTILITY(U,$J,358.3,25216,2)
 ;;=^5003674
 ;;^UTILITY(U,$J,358.3,25217,0)
 ;;=F98.4^^95^1189^29
 ;;^UTILITY(U,$J,358.3,25217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25217,1,3,0)
 ;;=3^Stereotypic Movement D/O Assoc w/ Known Med/Gene Cond/Neurod D/O or Environ Factor
 ;;^UTILITY(U,$J,358.3,25217,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,25217,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,25218,0)
 ;;=F95.8^^95^1189^32
 ;;^UTILITY(U,$J,358.3,25218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25218,1,3,0)
 ;;=3^Tic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,25218,1,4,0)
 ;;=4^F95.8
 ;;^UTILITY(U,$J,358.3,25218,2)
 ;;=^5003709
 ;;^UTILITY(U,$J,358.3,25219,0)
 ;;=F95.9^^95^1189^33
 ;;^UTILITY(U,$J,358.3,25219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25219,1,3,0)
 ;;=3^Tic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25219,1,4,0)
 ;;=4^F95.9
 ;;^UTILITY(U,$J,358.3,25219,2)
 ;;=^5003710
 ;;^UTILITY(U,$J,358.3,25220,0)
 ;;=F95.2^^95^1189^34
 ;;^UTILITY(U,$J,358.3,25220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25220,1,3,0)
 ;;=3^Tourette's Disorder
 ;;^UTILITY(U,$J,358.3,25220,1,4,0)
 ;;=4^F95.2
 ;;^UTILITY(U,$J,358.3,25220,2)
 ;;=^331942
 ;;^UTILITY(U,$J,358.3,25221,0)
 ;;=F98.5^^95^1189^1
 ;;^UTILITY(U,$J,358.3,25221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25221,1,3,0)
 ;;=3^Adult-Onset Fluency Disorder
 ;;^UTILITY(U,$J,358.3,25221,1,4,0)
 ;;=4^F98.5
 ;;^UTILITY(U,$J,358.3,25221,2)
 ;;=^5003717
 ;;^UTILITY(U,$J,358.3,25222,0)
 ;;=F90.2^^95^1189^2
 ;;^UTILITY(U,$J,358.3,25222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25222,1,3,0)
 ;;=3^Attention Deficit Disorder,Combined Presentation
 ;;^UTILITY(U,$J,358.3,25222,1,4,0)
 ;;=4^F90.2
 ;;^UTILITY(U,$J,358.3,25222,2)
 ;;=^5003694
 ;;^UTILITY(U,$J,358.3,25223,0)
 ;;=F90.1^^95^1189^3
 ;;^UTILITY(U,$J,358.3,25223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25223,1,3,0)
 ;;=3^Attention Deficit Disorder,Hyperactive/Impulsive Presentation
 ;;^UTILITY(U,$J,358.3,25223,1,4,0)
 ;;=4^F90.1
 ;;^UTILITY(U,$J,358.3,25223,2)
 ;;=^5003693
 ;;^UTILITY(U,$J,358.3,25224,0)
 ;;=F90.0^^95^1189^4
 ;;^UTILITY(U,$J,358.3,25224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25224,1,3,0)
 ;;=3^Attention Deficit Disorder,Predominantly Inattentive Presentation
 ;;^UTILITY(U,$J,358.3,25224,1,4,0)
 ;;=4^F90.0
 ;;^UTILITY(U,$J,358.3,25224,2)
 ;;=^5003692
 ;;^UTILITY(U,$J,358.3,25225,0)
 ;;=F06.1^^95^1189^8
 ;;^UTILITY(U,$J,358.3,25225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25225,1,3,0)
 ;;=3^Catatonia Associated w/ Another Mental Disorder
 ;;^UTILITY(U,$J,358.3,25225,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,25225,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,25226,0)
 ;;=F80.81^^95^1189^9
 ;;^UTILITY(U,$J,358.3,25226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25226,1,3,0)
 ;;=3^Child-Onset Fluency Disorder (Stuttering)
 ;;^UTILITY(U,$J,358.3,25226,1,4,0)
 ;;=4^F80.81
 ;;^UTILITY(U,$J,358.3,25226,2)
 ;;=^5003676
 ;;^UTILITY(U,$J,358.3,25227,0)
 ;;=F70.^^95^1189^13
 ;;^UTILITY(U,$J,358.3,25227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25227,1,3,0)
 ;;=3^Intellectual Disability,Mild
 ;;^UTILITY(U,$J,358.3,25227,1,4,0)
 ;;=4^F70.
 ;;^UTILITY(U,$J,358.3,25227,2)
 ;;=^5003668
 ;;^UTILITY(U,$J,358.3,25228,0)
 ;;=F71.^^95^1189^14
 ;;^UTILITY(U,$J,358.3,25228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25228,1,3,0)
 ;;=3^Intellectual Disability,Moderate
 ;;^UTILITY(U,$J,358.3,25228,1,4,0)
 ;;=4^F71.
 ;;^UTILITY(U,$J,358.3,25228,2)
 ;;=^5003669
 ;;^UTILITY(U,$J,358.3,25229,0)
 ;;=F73.^^95^1189^15
 ;;^UTILITY(U,$J,358.3,25229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25229,1,3,0)
 ;;=3^Intellectual Disability,Profound
 ;;^UTILITY(U,$J,358.3,25229,1,4,0)
 ;;=4^F73.
 ;;^UTILITY(U,$J,358.3,25229,2)
 ;;=^5003671
 ;;^UTILITY(U,$J,358.3,25230,0)
 ;;=F72.^^95^1189^16
 ;;^UTILITY(U,$J,358.3,25230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25230,1,3,0)
 ;;=3^Intellectual Disability,Severe
 ;;^UTILITY(U,$J,358.3,25230,1,4,0)
 ;;=4^F72.
 ;;^UTILITY(U,$J,358.3,25230,2)
 ;;=^5003670
 ;;^UTILITY(U,$J,358.3,25231,0)
 ;;=F90.8^^95^1189^5
 ;;^UTILITY(U,$J,358.3,25231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25231,1,3,0)
 ;;=3^Attention Deficit/Hyperactivity Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,25231,1,4,0)
 ;;=4^F90.8
 ;;^UTILITY(U,$J,358.3,25231,2)
 ;;=^5003695
 ;;^UTILITY(U,$J,358.3,25232,0)
 ;;=F95.1^^95^1189^25
 ;;^UTILITY(U,$J,358.3,25232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25232,1,3,0)
 ;;=3^Persistent (Chronic) Motor or Vocal Tic Disorder w/ Vocal Tics Only
 ;;^UTILITY(U,$J,358.3,25232,1,4,0)
 ;;=4^F95.1
 ;;^UTILITY(U,$J,358.3,25232,2)
 ;;=^331941
 ;;^UTILITY(U,$J,358.3,25233,0)
 ;;=F98.4^^95^1189^30
 ;;^UTILITY(U,$J,358.3,25233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25233,1,3,0)
 ;;=3^Stereotypic Movement D/O w/ Self-Injurious Behavior
 ;;^UTILITY(U,$J,358.3,25233,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,25233,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,25234,0)
 ;;=F98.4^^95^1189^31
 ;;^UTILITY(U,$J,358.3,25234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25234,1,3,0)
 ;;=3^Stereotypic Movement D/O w/o Self-Injurious Behavior
 ;;^UTILITY(U,$J,358.3,25234,1,4,0)
 ;;=4^F98.4
