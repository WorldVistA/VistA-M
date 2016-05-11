IBDEI1FT ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24419,1,4,0)
 ;;=4^F18.159
 ;;^UTILITY(U,$J,358.3,24419,2)
 ;;=^5003387
 ;;^UTILITY(U,$J,358.3,24420,0)
 ;;=F18.259^^90^1071^12
 ;;^UTILITY(U,$J,358.3,24420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24420,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24420,1,4,0)
 ;;=4^F18.259
 ;;^UTILITY(U,$J,358.3,24420,2)
 ;;=^5003400
 ;;^UTILITY(U,$J,358.3,24421,0)
 ;;=F18.959^^90^1071^13
 ;;^UTILITY(U,$J,358.3,24421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24421,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24421,1,4,0)
 ;;=4^F18.959
 ;;^UTILITY(U,$J,358.3,24421,2)
 ;;=^5003412
 ;;^UTILITY(U,$J,358.3,24422,0)
 ;;=F18.99^^90^1071^20
 ;;^UTILITY(U,$J,358.3,24422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24422,1,3,0)
 ;;=3^Inhalant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24422,1,4,0)
 ;;=4^F18.99
 ;;^UTILITY(U,$J,358.3,24422,2)
 ;;=^5133360
 ;;^UTILITY(U,$J,358.3,24423,0)
 ;;=F70.^^90^1072^1
 ;;^UTILITY(U,$J,358.3,24423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24423,1,3,0)
 ;;=3^Intellectual Disabilities,Mild
 ;;^UTILITY(U,$J,358.3,24423,1,4,0)
 ;;=4^F70.
 ;;^UTILITY(U,$J,358.3,24423,2)
 ;;=^5003668
 ;;^UTILITY(U,$J,358.3,24424,0)
 ;;=F71.^^90^1072^2
 ;;^UTILITY(U,$J,358.3,24424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24424,1,3,0)
 ;;=3^Intellectual Disabilities,Moderate
 ;;^UTILITY(U,$J,358.3,24424,1,4,0)
 ;;=4^F71.
 ;;^UTILITY(U,$J,358.3,24424,2)
 ;;=^5003669
 ;;^UTILITY(U,$J,358.3,24425,0)
 ;;=F72.^^90^1072^3
 ;;^UTILITY(U,$J,358.3,24425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24425,1,3,0)
 ;;=3^Intellectual Disabilities,Severe
 ;;^UTILITY(U,$J,358.3,24425,1,4,0)
 ;;=4^F72.
 ;;^UTILITY(U,$J,358.3,24425,2)
 ;;=^5003670
 ;;^UTILITY(U,$J,358.3,24426,0)
 ;;=F73.^^90^1072^4
 ;;^UTILITY(U,$J,358.3,24426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24426,1,3,0)
 ;;=3^Intellectual Disabilities,Profound
 ;;^UTILITY(U,$J,358.3,24426,1,4,0)
 ;;=4^F73.
 ;;^UTILITY(U,$J,358.3,24426,2)
 ;;=^5003671
 ;;^UTILITY(U,$J,358.3,24427,0)
 ;;=F78.^^90^1072^5
 ;;^UTILITY(U,$J,358.3,24427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24427,1,3,0)
 ;;=3^Intellectual Disabilities,Oth Specified
 ;;^UTILITY(U,$J,358.3,24427,1,4,0)
 ;;=4^F78.
 ;;^UTILITY(U,$J,358.3,24427,2)
 ;;=^5003672
 ;;^UTILITY(U,$J,358.3,24428,0)
 ;;=F79.^^90^1072^6
 ;;^UTILITY(U,$J,358.3,24428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24428,1,3,0)
 ;;=3^Intellectual Disabilities,Unspec
 ;;^UTILITY(U,$J,358.3,24428,1,4,0)
 ;;=4^F79.
 ;;^UTILITY(U,$J,358.3,24428,2)
 ;;=^5003673
 ;;^UTILITY(U,$J,358.3,24429,0)
 ;;=Z00.6^^90^1073^1
 ;;^UTILITY(U,$J,358.3,24429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24429,1,3,0)
 ;;=3^Exam of Participant of Control in Clinical Research Program
 ;;^UTILITY(U,$J,358.3,24429,1,4,0)
 ;;=4^Z00.6
 ;;^UTILITY(U,$J,358.3,24429,2)
 ;;=^5062608
 ;;^UTILITY(U,$J,358.3,24430,0)
 ;;=F45.22^^90^1074^1
 ;;^UTILITY(U,$J,358.3,24430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24430,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,24430,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,24430,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,24431,0)
 ;;=F45.20^^90^1074^7
 ;;^UTILITY(U,$J,358.3,24431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24431,1,3,0)
 ;;=3^Hypochondiacal Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24431,1,4,0)
 ;;=4^F45.20
 ;;^UTILITY(U,$J,358.3,24431,2)
 ;;=^5003586
 ;;^UTILITY(U,$J,358.3,24432,0)
 ;;=F45.21^^90^1074^9
 ;;^UTILITY(U,$J,358.3,24432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24432,1,3,0)
 ;;=3^Hypochondriasis
