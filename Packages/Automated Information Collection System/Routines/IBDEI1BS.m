IBDEI1BS ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21179,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21179,1,4,0)
 ;;=4^F18.97
 ;;^UTILITY(U,$J,358.3,21179,2)
 ;;=^5003413
 ;;^UTILITY(U,$J,358.3,21180,0)
 ;;=F18.188^^95^1050^12
 ;;^UTILITY(U,$J,358.3,21180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21180,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21180,1,4,0)
 ;;=4^F18.188
 ;;^UTILITY(U,$J,358.3,21180,2)
 ;;=^5003390
 ;;^UTILITY(U,$J,358.3,21181,0)
 ;;=F18.288^^95^1050^13
 ;;^UTILITY(U,$J,358.3,21181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21181,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21181,1,4,0)
 ;;=4^F18.288
 ;;^UTILITY(U,$J,358.3,21181,2)
 ;;=^5003403
 ;;^UTILITY(U,$J,358.3,21182,0)
 ;;=F18.988^^95^1050^14
 ;;^UTILITY(U,$J,358.3,21182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21182,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21182,1,4,0)
 ;;=4^F18.988
 ;;^UTILITY(U,$J,358.3,21182,2)
 ;;=^5003415
 ;;^UTILITY(U,$J,358.3,21183,0)
 ;;=F18.159^^95^1050^15
 ;;^UTILITY(U,$J,358.3,21183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21183,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21183,1,4,0)
 ;;=4^F18.159
 ;;^UTILITY(U,$J,358.3,21183,2)
 ;;=^5003387
 ;;^UTILITY(U,$J,358.3,21184,0)
 ;;=F18.259^^95^1050^16
 ;;^UTILITY(U,$J,358.3,21184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21184,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21184,1,4,0)
 ;;=4^F18.259
 ;;^UTILITY(U,$J,358.3,21184,2)
 ;;=^5003400
 ;;^UTILITY(U,$J,358.3,21185,0)
 ;;=F18.959^^95^1050^17
 ;;^UTILITY(U,$J,358.3,21185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21185,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21185,1,4,0)
 ;;=4^F18.959
 ;;^UTILITY(U,$J,358.3,21185,2)
 ;;=^5003412
 ;;^UTILITY(U,$J,358.3,21186,0)
 ;;=F18.99^^95^1050^24
 ;;^UTILITY(U,$J,358.3,21186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21186,1,3,0)
 ;;=3^Inhalant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,21186,1,4,0)
 ;;=4^F18.99
 ;;^UTILITY(U,$J,358.3,21186,2)
 ;;=^5133360
 ;;^UTILITY(U,$J,358.3,21187,0)
 ;;=F18.11^^95^1050^1
 ;;^UTILITY(U,$J,358.3,21187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21187,1,3,0)
 ;;=3^Inhalant Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,21187,1,4,0)
 ;;=4^F18.11
 ;;^UTILITY(U,$J,358.3,21187,2)
 ;;=^5151305
 ;;^UTILITY(U,$J,358.3,21188,0)
 ;;=Z00.6^^95^1051^1
 ;;^UTILITY(U,$J,358.3,21188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21188,1,3,0)
 ;;=3^Exam of Participant of Control in Clinical Research Program
 ;;^UTILITY(U,$J,358.3,21188,1,4,0)
 ;;=4^Z00.6
 ;;^UTILITY(U,$J,358.3,21188,2)
 ;;=^5062608
 ;;^UTILITY(U,$J,358.3,21189,0)
 ;;=F45.22^^95^1052^1
 ;;^UTILITY(U,$J,358.3,21189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21189,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,21189,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,21189,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,21190,0)
 ;;=F45.8^^95^1052^16
 ;;^UTILITY(U,$J,358.3,21190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21190,1,3,0)
 ;;=3^Somatoform Disorders,Other Specified
 ;;^UTILITY(U,$J,358.3,21190,1,4,0)
 ;;=4^F45.8
 ;;^UTILITY(U,$J,358.3,21190,2)
 ;;=^331915
