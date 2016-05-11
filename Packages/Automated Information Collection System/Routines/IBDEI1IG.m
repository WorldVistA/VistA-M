IBDEI1IG ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25625,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25625,1,4,0)
 ;;=4^F18.159
 ;;^UTILITY(U,$J,358.3,25625,2)
 ;;=^5003387
 ;;^UTILITY(U,$J,358.3,25626,0)
 ;;=F18.259^^95^1175^12
 ;;^UTILITY(U,$J,358.3,25626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25626,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25626,1,4,0)
 ;;=4^F18.259
 ;;^UTILITY(U,$J,358.3,25626,2)
 ;;=^5003400
 ;;^UTILITY(U,$J,358.3,25627,0)
 ;;=F18.959^^95^1175^13
 ;;^UTILITY(U,$J,358.3,25627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25627,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25627,1,4,0)
 ;;=4^F18.959
 ;;^UTILITY(U,$J,358.3,25627,2)
 ;;=^5003412
 ;;^UTILITY(U,$J,358.3,25628,0)
 ;;=F18.99^^95^1175^20
 ;;^UTILITY(U,$J,358.3,25628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25628,1,3,0)
 ;;=3^Inhalant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25628,1,4,0)
 ;;=4^F18.99
 ;;^UTILITY(U,$J,358.3,25628,2)
 ;;=^5133360
 ;;^UTILITY(U,$J,358.3,25629,0)
 ;;=F70.^^95^1176^1
 ;;^UTILITY(U,$J,358.3,25629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25629,1,3,0)
 ;;=3^Intellectual Disabilities,Mild
 ;;^UTILITY(U,$J,358.3,25629,1,4,0)
 ;;=4^F70.
 ;;^UTILITY(U,$J,358.3,25629,2)
 ;;=^5003668
 ;;^UTILITY(U,$J,358.3,25630,0)
 ;;=F71.^^95^1176^2
 ;;^UTILITY(U,$J,358.3,25630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25630,1,3,0)
 ;;=3^Intellectual Disabilities,Moderate
 ;;^UTILITY(U,$J,358.3,25630,1,4,0)
 ;;=4^F71.
 ;;^UTILITY(U,$J,358.3,25630,2)
 ;;=^5003669
 ;;^UTILITY(U,$J,358.3,25631,0)
 ;;=F72.^^95^1176^3
 ;;^UTILITY(U,$J,358.3,25631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25631,1,3,0)
 ;;=3^Intellectual Disabilities,Severe
 ;;^UTILITY(U,$J,358.3,25631,1,4,0)
 ;;=4^F72.
 ;;^UTILITY(U,$J,358.3,25631,2)
 ;;=^5003670
 ;;^UTILITY(U,$J,358.3,25632,0)
 ;;=F73.^^95^1176^4
 ;;^UTILITY(U,$J,358.3,25632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25632,1,3,0)
 ;;=3^Intellectual Disabilities,Profound
 ;;^UTILITY(U,$J,358.3,25632,1,4,0)
 ;;=4^F73.
 ;;^UTILITY(U,$J,358.3,25632,2)
 ;;=^5003671
 ;;^UTILITY(U,$J,358.3,25633,0)
 ;;=F78.^^95^1176^5
 ;;^UTILITY(U,$J,358.3,25633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25633,1,3,0)
 ;;=3^Intellectual Disabilities,Oth Specified
 ;;^UTILITY(U,$J,358.3,25633,1,4,0)
 ;;=4^F78.
 ;;^UTILITY(U,$J,358.3,25633,2)
 ;;=^5003672
 ;;^UTILITY(U,$J,358.3,25634,0)
 ;;=F79.^^95^1176^6
 ;;^UTILITY(U,$J,358.3,25634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25634,1,3,0)
 ;;=3^Intellectual Disabilities,Unspec
 ;;^UTILITY(U,$J,358.3,25634,1,4,0)
 ;;=4^F79.
 ;;^UTILITY(U,$J,358.3,25634,2)
 ;;=^5003673
 ;;^UTILITY(U,$J,358.3,25635,0)
 ;;=Z00.6^^95^1177^1
 ;;^UTILITY(U,$J,358.3,25635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25635,1,3,0)
 ;;=3^Exam of Participant of Control in Clinical Research Program
 ;;^UTILITY(U,$J,358.3,25635,1,4,0)
 ;;=4^Z00.6
 ;;^UTILITY(U,$J,358.3,25635,2)
 ;;=^5062608
 ;;^UTILITY(U,$J,358.3,25636,0)
 ;;=F45.22^^95^1178^1
 ;;^UTILITY(U,$J,358.3,25636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25636,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,25636,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,25636,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,25637,0)
 ;;=F45.20^^95^1178^7
 ;;^UTILITY(U,$J,358.3,25637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25637,1,3,0)
 ;;=3^Hypochondiacal Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25637,1,4,0)
 ;;=4^F45.20
 ;;^UTILITY(U,$J,358.3,25637,2)
 ;;=^5003586
