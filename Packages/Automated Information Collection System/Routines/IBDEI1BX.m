IBDEI1BX ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21239,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,21239,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,21240,0)
 ;;=F95.8^^95^1057^32
 ;;^UTILITY(U,$J,358.3,21240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21240,1,3,0)
 ;;=3^Tic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,21240,1,4,0)
 ;;=4^F95.8
 ;;^UTILITY(U,$J,358.3,21240,2)
 ;;=^5003709
 ;;^UTILITY(U,$J,358.3,21241,0)
 ;;=F95.9^^95^1057^33
 ;;^UTILITY(U,$J,358.3,21241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21241,1,3,0)
 ;;=3^Tic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,21241,1,4,0)
 ;;=4^F95.9
 ;;^UTILITY(U,$J,358.3,21241,2)
 ;;=^5003710
 ;;^UTILITY(U,$J,358.3,21242,0)
 ;;=F95.2^^95^1057^34
 ;;^UTILITY(U,$J,358.3,21242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21242,1,3,0)
 ;;=3^Tourette's Disorder
 ;;^UTILITY(U,$J,358.3,21242,1,4,0)
 ;;=4^F95.2
 ;;^UTILITY(U,$J,358.3,21242,2)
 ;;=^331942
 ;;^UTILITY(U,$J,358.3,21243,0)
 ;;=F98.5^^95^1057^1
 ;;^UTILITY(U,$J,358.3,21243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21243,1,3,0)
 ;;=3^Adult-Onset Fluency Disorder
 ;;^UTILITY(U,$J,358.3,21243,1,4,0)
 ;;=4^F98.5
 ;;^UTILITY(U,$J,358.3,21243,2)
 ;;=^5003717
 ;;^UTILITY(U,$J,358.3,21244,0)
 ;;=F90.2^^95^1057^2
 ;;^UTILITY(U,$J,358.3,21244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21244,1,3,0)
 ;;=3^Attention Deficit Disorder,Combined Presentation
 ;;^UTILITY(U,$J,358.3,21244,1,4,0)
 ;;=4^F90.2
 ;;^UTILITY(U,$J,358.3,21244,2)
 ;;=^5003694
 ;;^UTILITY(U,$J,358.3,21245,0)
 ;;=F90.1^^95^1057^3
 ;;^UTILITY(U,$J,358.3,21245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21245,1,3,0)
 ;;=3^Attention Deficit Disorder,Hyperactive/Impulsive Presentation
 ;;^UTILITY(U,$J,358.3,21245,1,4,0)
 ;;=4^F90.1
 ;;^UTILITY(U,$J,358.3,21245,2)
 ;;=^5003693
 ;;^UTILITY(U,$J,358.3,21246,0)
 ;;=F90.0^^95^1057^4
 ;;^UTILITY(U,$J,358.3,21246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21246,1,3,0)
 ;;=3^Attention Deficit Disorder,Predominantly Inattentive Presentation
 ;;^UTILITY(U,$J,358.3,21246,1,4,0)
 ;;=4^F90.0
 ;;^UTILITY(U,$J,358.3,21246,2)
 ;;=^5003692
 ;;^UTILITY(U,$J,358.3,21247,0)
 ;;=F06.1^^95^1057^8
 ;;^UTILITY(U,$J,358.3,21247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21247,1,3,0)
 ;;=3^Catatonia Associated w/ Another Mental Disorder
 ;;^UTILITY(U,$J,358.3,21247,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,21247,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,21248,0)
 ;;=F80.81^^95^1057^9
 ;;^UTILITY(U,$J,358.3,21248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21248,1,3,0)
 ;;=3^Child-Onset Fluency Disorder (Stuttering)
 ;;^UTILITY(U,$J,358.3,21248,1,4,0)
 ;;=4^F80.81
 ;;^UTILITY(U,$J,358.3,21248,2)
 ;;=^5003676
 ;;^UTILITY(U,$J,358.3,21249,0)
 ;;=F70.^^95^1057^13
 ;;^UTILITY(U,$J,358.3,21249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21249,1,3,0)
 ;;=3^Intellectual Disability,Mild
 ;;^UTILITY(U,$J,358.3,21249,1,4,0)
 ;;=4^F70.
 ;;^UTILITY(U,$J,358.3,21249,2)
 ;;=^5003668
 ;;^UTILITY(U,$J,358.3,21250,0)
 ;;=F71.^^95^1057^14
 ;;^UTILITY(U,$J,358.3,21250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21250,1,3,0)
 ;;=3^Intellectual Disability,Moderate
 ;;^UTILITY(U,$J,358.3,21250,1,4,0)
 ;;=4^F71.
 ;;^UTILITY(U,$J,358.3,21250,2)
 ;;=^5003669
 ;;^UTILITY(U,$J,358.3,21251,0)
 ;;=F73.^^95^1057^15
 ;;^UTILITY(U,$J,358.3,21251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21251,1,3,0)
 ;;=3^Intellectual Disability,Profound
 ;;^UTILITY(U,$J,358.3,21251,1,4,0)
 ;;=4^F73.
