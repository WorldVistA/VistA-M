IBDEI0ON ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11073,1,3,0)
 ;;=3^Tic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,11073,1,4,0)
 ;;=4^F95.8
 ;;^UTILITY(U,$J,358.3,11073,2)
 ;;=^5003709
 ;;^UTILITY(U,$J,358.3,11074,0)
 ;;=F95.9^^42^505^33
 ;;^UTILITY(U,$J,358.3,11074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11074,1,3,0)
 ;;=3^Tic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,11074,1,4,0)
 ;;=4^F95.9
 ;;^UTILITY(U,$J,358.3,11074,2)
 ;;=^5003710
 ;;^UTILITY(U,$J,358.3,11075,0)
 ;;=F95.2^^42^505^34
 ;;^UTILITY(U,$J,358.3,11075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11075,1,3,0)
 ;;=3^Tourette's Disorder
 ;;^UTILITY(U,$J,358.3,11075,1,4,0)
 ;;=4^F95.2
 ;;^UTILITY(U,$J,358.3,11075,2)
 ;;=^331942
 ;;^UTILITY(U,$J,358.3,11076,0)
 ;;=F98.5^^42^505^1
 ;;^UTILITY(U,$J,358.3,11076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11076,1,3,0)
 ;;=3^Adult-Onset Fluency Disorder
 ;;^UTILITY(U,$J,358.3,11076,1,4,0)
 ;;=4^F98.5
 ;;^UTILITY(U,$J,358.3,11076,2)
 ;;=^5003717
 ;;^UTILITY(U,$J,358.3,11077,0)
 ;;=F90.2^^42^505^2
 ;;^UTILITY(U,$J,358.3,11077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11077,1,3,0)
 ;;=3^Attention Deficit Disorder,Combined Presentation
 ;;^UTILITY(U,$J,358.3,11077,1,4,0)
 ;;=4^F90.2
 ;;^UTILITY(U,$J,358.3,11077,2)
 ;;=^5003694
 ;;^UTILITY(U,$J,358.3,11078,0)
 ;;=F90.1^^42^505^3
 ;;^UTILITY(U,$J,358.3,11078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11078,1,3,0)
 ;;=3^Attention Deficit Disorder,Hyperactive/Impulsive Presentation
 ;;^UTILITY(U,$J,358.3,11078,1,4,0)
 ;;=4^F90.1
 ;;^UTILITY(U,$J,358.3,11078,2)
 ;;=^5003693
 ;;^UTILITY(U,$J,358.3,11079,0)
 ;;=F90.0^^42^505^4
 ;;^UTILITY(U,$J,358.3,11079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11079,1,3,0)
 ;;=3^Attention Deficit Disorder,Predominantly Inattentive Presentation
 ;;^UTILITY(U,$J,358.3,11079,1,4,0)
 ;;=4^F90.0
 ;;^UTILITY(U,$J,358.3,11079,2)
 ;;=^5003692
 ;;^UTILITY(U,$J,358.3,11080,0)
 ;;=F06.1^^42^505^8
 ;;^UTILITY(U,$J,358.3,11080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11080,1,3,0)
 ;;=3^Catatonia Associated w/ Another Mental Disorder
 ;;^UTILITY(U,$J,358.3,11080,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,11080,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,11081,0)
 ;;=F80.81^^42^505^9
 ;;^UTILITY(U,$J,358.3,11081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11081,1,3,0)
 ;;=3^Child-Onset Fluency Disorder (Stuttering)
 ;;^UTILITY(U,$J,358.3,11081,1,4,0)
 ;;=4^F80.81
 ;;^UTILITY(U,$J,358.3,11081,2)
 ;;=^5003676
 ;;^UTILITY(U,$J,358.3,11082,0)
 ;;=F70.^^42^505^13
 ;;^UTILITY(U,$J,358.3,11082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11082,1,3,0)
 ;;=3^Intellectual Disability,Mild
 ;;^UTILITY(U,$J,358.3,11082,1,4,0)
 ;;=4^F70.
 ;;^UTILITY(U,$J,358.3,11082,2)
 ;;=^5003668
 ;;^UTILITY(U,$J,358.3,11083,0)
 ;;=F71.^^42^505^14
 ;;^UTILITY(U,$J,358.3,11083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11083,1,3,0)
 ;;=3^Intellectual Disability,Moderate
 ;;^UTILITY(U,$J,358.3,11083,1,4,0)
 ;;=4^F71.
 ;;^UTILITY(U,$J,358.3,11083,2)
 ;;=^5003669
 ;;^UTILITY(U,$J,358.3,11084,0)
 ;;=F73.^^42^505^15
 ;;^UTILITY(U,$J,358.3,11084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11084,1,3,0)
 ;;=3^Intellectual Disability,Profound
 ;;^UTILITY(U,$J,358.3,11084,1,4,0)
 ;;=4^F73.
 ;;^UTILITY(U,$J,358.3,11084,2)
 ;;=^5003671
 ;;^UTILITY(U,$J,358.3,11085,0)
 ;;=F72.^^42^505^16
 ;;^UTILITY(U,$J,358.3,11085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11085,1,3,0)
 ;;=3^Intellectual Disability,Severe
