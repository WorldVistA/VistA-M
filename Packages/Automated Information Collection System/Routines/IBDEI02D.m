IBDEI02D ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,614,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,614,1,4,0)
 ;;=4^F18.988
 ;;^UTILITY(U,$J,358.3,614,2)
 ;;=^5003415
 ;;^UTILITY(U,$J,358.3,615,0)
 ;;=F18.159^^3^59^11
 ;;^UTILITY(U,$J,358.3,615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,615,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,615,1,4,0)
 ;;=4^F18.159
 ;;^UTILITY(U,$J,358.3,615,2)
 ;;=^5003387
 ;;^UTILITY(U,$J,358.3,616,0)
 ;;=F18.259^^3^59^12
 ;;^UTILITY(U,$J,358.3,616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,616,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,616,1,4,0)
 ;;=4^F18.259
 ;;^UTILITY(U,$J,358.3,616,2)
 ;;=^5003400
 ;;^UTILITY(U,$J,358.3,617,0)
 ;;=F18.959^^3^59^13
 ;;^UTILITY(U,$J,358.3,617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,617,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,617,1,4,0)
 ;;=4^F18.959
 ;;^UTILITY(U,$J,358.3,617,2)
 ;;=^5003412
 ;;^UTILITY(U,$J,358.3,618,0)
 ;;=F18.99^^3^59^20
 ;;^UTILITY(U,$J,358.3,618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,618,1,3,0)
 ;;=3^Inhalant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,618,1,4,0)
 ;;=4^F18.99
 ;;^UTILITY(U,$J,358.3,618,2)
 ;;=^5133360
 ;;^UTILITY(U,$J,358.3,619,0)
 ;;=F70.^^3^60^1
 ;;^UTILITY(U,$J,358.3,619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,619,1,3,0)
 ;;=3^Intellectual Disabilities,Mild
 ;;^UTILITY(U,$J,358.3,619,1,4,0)
 ;;=4^F70.
 ;;^UTILITY(U,$J,358.3,619,2)
 ;;=^5003668
 ;;^UTILITY(U,$J,358.3,620,0)
 ;;=F71.^^3^60^2
 ;;^UTILITY(U,$J,358.3,620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,620,1,3,0)
 ;;=3^Intellectual Disabilities,Moderate
 ;;^UTILITY(U,$J,358.3,620,1,4,0)
 ;;=4^F71.
 ;;^UTILITY(U,$J,358.3,620,2)
 ;;=^5003669
 ;;^UTILITY(U,$J,358.3,621,0)
 ;;=F72.^^3^60^3
 ;;^UTILITY(U,$J,358.3,621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,621,1,3,0)
 ;;=3^Intellectual Disabilities,Severe
 ;;^UTILITY(U,$J,358.3,621,1,4,0)
 ;;=4^F72.
 ;;^UTILITY(U,$J,358.3,621,2)
 ;;=^5003670
 ;;^UTILITY(U,$J,358.3,622,0)
 ;;=F73.^^3^60^4
 ;;^UTILITY(U,$J,358.3,622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,622,1,3,0)
 ;;=3^Intellectual Disabilities,Profound
 ;;^UTILITY(U,$J,358.3,622,1,4,0)
 ;;=4^F73.
 ;;^UTILITY(U,$J,358.3,622,2)
 ;;=^5003671
 ;;^UTILITY(U,$J,358.3,623,0)
 ;;=F78.^^3^60^5
 ;;^UTILITY(U,$J,358.3,623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,623,1,3,0)
 ;;=3^Intellectual Disabilities,Oth Specified
 ;;^UTILITY(U,$J,358.3,623,1,4,0)
 ;;=4^F78.
 ;;^UTILITY(U,$J,358.3,623,2)
 ;;=^5003672
 ;;^UTILITY(U,$J,358.3,624,0)
 ;;=F79.^^3^60^6
 ;;^UTILITY(U,$J,358.3,624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,624,1,3,0)
 ;;=3^Intellectual Disabilities,Unspec
 ;;^UTILITY(U,$J,358.3,624,1,4,0)
 ;;=4^F79.
 ;;^UTILITY(U,$J,358.3,624,2)
 ;;=^5003673
 ;;^UTILITY(U,$J,358.3,625,0)
 ;;=Z00.6^^3^61^1
 ;;^UTILITY(U,$J,358.3,625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,625,1,3,0)
 ;;=3^Exam of Participant of Control in Clinical Research Program
 ;;^UTILITY(U,$J,358.3,625,1,4,0)
 ;;=4^Z00.6
 ;;^UTILITY(U,$J,358.3,625,2)
 ;;=^5062608
 ;;^UTILITY(U,$J,358.3,626,0)
 ;;=F45.22^^3^62^1
 ;;^UTILITY(U,$J,358.3,626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,626,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,626,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,626,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,627,0)
 ;;=F45.20^^3^62^7
 ;;^UTILITY(U,$J,358.3,627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,627,1,3,0)
 ;;=3^Hypochondiacal Disorder,Unspec
