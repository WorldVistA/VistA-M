IBDEI0LR ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10317,1,3,0)
 ;;=3^Glaucoma,Pigmentary
 ;;^UTILITY(U,$J,358.3,10317,1,4,0)
 ;;=4^365.13
 ;;^UTILITY(U,$J,358.3,10317,2)
 ;;=Pigmentary Glaucoma^51211
 ;;^UTILITY(U,$J,358.3,10318,0)
 ;;=365.20^^44^563^26
 ;;^UTILITY(U,$J,358.3,10318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10318,1,3,0)
 ;;=3^Glaucoma,Prim Angle Closure
 ;;^UTILITY(U,$J,358.3,10318,1,4,0)
 ;;=4^365.20
 ;;^UTILITY(U,$J,358.3,10318,2)
 ;;=^51195
 ;;^UTILITY(U,$J,358.3,10319,0)
 ;;=365.52^^44^563^27
 ;;^UTILITY(U,$J,358.3,10319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10319,1,3,0)
 ;;=3^Glaucoma,Pseudoexfoliation
 ;;^UTILITY(U,$J,358.3,10319,1,4,0)
 ;;=4^365.52
 ;;^UTILITY(U,$J,358.3,10319,2)
 ;;=Pseudoexfoliation Glaucoma^268771
 ;;^UTILITY(U,$J,358.3,10320,0)
 ;;=365.15^^44^563^29
 ;;^UTILITY(U,$J,358.3,10320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10320,1,3,0)
 ;;=3^Glaucoma,Residual Open Angle
 ;;^UTILITY(U,$J,358.3,10320,1,4,0)
 ;;=4^365.15
 ;;^UTILITY(U,$J,358.3,10320,2)
 ;;=Residual Open Angle Glaucoma^268751
 ;;^UTILITY(U,$J,358.3,10321,0)
 ;;=365.31^^44^563^32
 ;;^UTILITY(U,$J,358.3,10321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10321,1,3,0)
 ;;=3^Glaucoma,Steroid Induced
 ;;^UTILITY(U,$J,358.3,10321,1,4,0)
 ;;=4^365.31
 ;;^UTILITY(U,$J,358.3,10321,2)
 ;;=Steroid Induced Glaucoma^268761
 ;;^UTILITY(U,$J,358.3,10322,0)
 ;;=365.61^^44^563^11
 ;;^UTILITY(U,$J,358.3,10322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10322,1,3,0)
 ;;=3^Glaucoma W/Pupillary Block
 ;;^UTILITY(U,$J,358.3,10322,1,4,0)
 ;;=4^365.61
 ;;^UTILITY(U,$J,358.3,10322,2)
 ;;=Glaucoma W/Pupillary Block^268776
 ;;^UTILITY(U,$J,358.3,10323,0)
 ;;=365.23^^44^563^13
 ;;^UTILITY(U,$J,358.3,10323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10323,1,3,0)
 ;;=3^Glaucoma,Chr Angle Closure
 ;;^UTILITY(U,$J,358.3,10323,1,4,0)
 ;;=4^365.23
 ;;^UTILITY(U,$J,358.3,10323,2)
 ;;=^268756
 ;;^UTILITY(U,$J,358.3,10324,0)
 ;;=363.71^^44^563^43
 ;;^UTILITY(U,$J,358.3,10324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10324,1,3,0)
 ;;=3^Serous Choroidal Detachment
 ;;^UTILITY(U,$J,358.3,10324,1,4,0)
 ;;=4^363.71
 ;;^UTILITY(U,$J,358.3,10324,2)
 ;;=Choroidal Detachment^268699
 ;;^UTILITY(U,$J,358.3,10325,0)
 ;;=365.51^^44^563^24
 ;;^UTILITY(U,$J,358.3,10325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10325,1,3,0)
 ;;=3^Glaucoma,Phacolytic
 ;;^UTILITY(U,$J,358.3,10325,1,4,0)
 ;;=4^365.51
 ;;^UTILITY(U,$J,358.3,10325,2)
 ;;=Phacolytic Glaucoma^265226
 ;;^UTILITY(U,$J,358.3,10326,0)
 ;;=365.01^^44^563^21
 ;;^UTILITY(U,$J,358.3,10326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10326,1,3,0)
 ;;=3^Glaucoma,Open Angle Suspect
 ;;^UTILITY(U,$J,358.3,10326,1,4,0)
 ;;=4^365.01
 ;;^UTILITY(U,$J,358.3,10326,2)
 ;;=Open Angle Glaucoma Suspect^268747
 ;;^UTILITY(U,$J,358.3,10327,0)
 ;;=365.04^^44^563^37
 ;;^UTILITY(U,$J,358.3,10327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10327,1,3,0)
 ;;=3^Ocular Hypertension
 ;;^UTILITY(U,$J,358.3,10327,1,4,0)
 ;;=4^365.04
 ;;^UTILITY(U,$J,358.3,10327,2)
 ;;=Ocular Hypertension^85124
 ;;^UTILITY(U,$J,358.3,10328,0)
 ;;=365.03^^44^563^44
 ;;^UTILITY(U,$J,358.3,10328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10328,1,3,0)
 ;;=3^Steroid Responder
 ;;^UTILITY(U,$J,358.3,10328,1,4,0)
 ;;=4^365.03
 ;;^UTILITY(U,$J,358.3,10328,2)
 ;;=^268749
 ;;^UTILITY(U,$J,358.3,10329,0)
 ;;=366.11^^44^563^41
 ;;^UTILITY(U,$J,358.3,10329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10329,1,3,0)
 ;;=3^Pseudoexfoliation w/o Glaucoma
 ;;^UTILITY(U,$J,358.3,10329,1,4,0)
 ;;=4^366.11
 ;;^UTILITY(U,$J,358.3,10329,2)
 ;;=^265538
 ;;^UTILITY(U,$J,358.3,10330,0)
 ;;=365.02^^44^563^1
