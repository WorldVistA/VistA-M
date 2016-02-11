IBDEI1IN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25337,1,3,0)
 ;;=3^Pathological Fx,Unspec Site,Subsq Encntr for Fx w/ Sequela
 ;;^UTILITY(U,$J,358.3,25337,1,4,0)
 ;;=4^M84.40XS
 ;;^UTILITY(U,$J,358.3,25337,2)
 ;;=^5013799
 ;;^UTILITY(U,$J,358.3,25338,0)
 ;;=M85.80^^124^1244^3
 ;;^UTILITY(U,$J,358.3,25338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25338,1,3,0)
 ;;=3^Bone Density/Structure Disorders,Unspec Site
 ;;^UTILITY(U,$J,358.3,25338,1,4,0)
 ;;=4^M85.80
 ;;^UTILITY(U,$J,358.3,25338,2)
 ;;=^5014473
 ;;^UTILITY(U,$J,358.3,25339,0)
 ;;=G40.909^^124^1245^5
 ;;^UTILITY(U,$J,358.3,25339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25339,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,25339,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,25339,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,25340,0)
 ;;=G40.919^^124^1245^4
 ;;^UTILITY(U,$J,358.3,25340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25340,1,3,0)
 ;;=3^Epilepsy,Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,25340,1,4,0)
 ;;=4^G40.919
 ;;^UTILITY(U,$J,358.3,25340,2)
 ;;=^5003867
 ;;^UTILITY(U,$J,358.3,25341,0)
 ;;=G62.9^^124^1245^8
 ;;^UTILITY(U,$J,358.3,25341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25341,1,3,0)
 ;;=3^Polyneuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,25341,1,4,0)
 ;;=4^G62.9
 ;;^UTILITY(U,$J,358.3,25341,2)
 ;;=^5004079
 ;;^UTILITY(U,$J,358.3,25342,0)
 ;;=G60.9^^124^1245^6
 ;;^UTILITY(U,$J,358.3,25342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25342,1,3,0)
 ;;=3^Hereditary/Idiopathic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,25342,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,25342,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,25343,0)
 ;;=I63.50^^124^1245^1
 ;;^UTILITY(U,$J,358.3,25343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25343,1,3,0)
 ;;=3^Cerebral Infarction d/t Occlusion/Stenosis of Cerebral Artery
 ;;^UTILITY(U,$J,358.3,25343,1,4,0)
 ;;=4^I63.50
 ;;^UTILITY(U,$J,358.3,25343,2)
 ;;=^5007343
 ;;^UTILITY(U,$J,358.3,25344,0)
 ;;=G45.9^^124^1245^12
 ;;^UTILITY(U,$J,358.3,25344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25344,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attack,Unspec
 ;;^UTILITY(U,$J,358.3,25344,1,4,0)
 ;;=4^G45.9
 ;;^UTILITY(U,$J,358.3,25344,2)
 ;;=^5003959
 ;;^UTILITY(U,$J,358.3,25345,0)
 ;;=R55.^^124^1245^11
 ;;^UTILITY(U,$J,358.3,25345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25345,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,25345,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,25345,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,25346,0)
 ;;=R56.00^^124^1245^10
 ;;^UTILITY(U,$J,358.3,25346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25346,1,3,0)
 ;;=3^Simple Febrile Convulsions
 ;;^UTILITY(U,$J,358.3,25346,1,4,0)
 ;;=4^R56.00
 ;;^UTILITY(U,$J,358.3,25346,2)
 ;;=^5019522
 ;;^UTILITY(U,$J,358.3,25347,0)
 ;;=R56.1^^124^1245^9
 ;;^UTILITY(U,$J,358.3,25347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25347,1,3,0)
 ;;=3^Post Traumatic Seizures
 ;;^UTILITY(U,$J,358.3,25347,1,4,0)
 ;;=4^R56.1
 ;;^UTILITY(U,$J,358.3,25347,2)
 ;;=^5019523
 ;;^UTILITY(U,$J,358.3,25348,0)
 ;;=R56.9^^124^1245^2
 ;;^UTILITY(U,$J,358.3,25348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25348,1,3,0)
 ;;=3^Convulsions,Unspec
 ;;^UTILITY(U,$J,358.3,25348,1,4,0)
 ;;=4^R56.9
 ;;^UTILITY(U,$J,358.3,25348,2)
 ;;=^5019524
 ;;^UTILITY(U,$J,358.3,25349,0)
 ;;=R42.^^124^1245^3
 ;;^UTILITY(U,$J,358.3,25349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25349,1,3,0)
 ;;=3^Dizziness and Giddiness
 ;;^UTILITY(U,$J,358.3,25349,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,25349,2)
 ;;=^5019450
