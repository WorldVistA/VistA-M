IBDEI0GE ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7100,1,3,0)
 ;;=3^Lower Back Muscle/Fascia/Tendon Strain,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7100,1,4,0)
 ;;=4^S39.012D
 ;;^UTILITY(U,$J,358.3,7100,2)
 ;;=^5026103
 ;;^UTILITY(U,$J,358.3,7101,0)
 ;;=S44.8X2D^^58^466^16
 ;;^UTILITY(U,$J,358.3,7101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7101,1,3,0)
 ;;=3^Shoulder/Upper Arm Nerve Inj,Left Arm,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7101,1,4,0)
 ;;=4^S44.8X2D
 ;;^UTILITY(U,$J,358.3,7101,2)
 ;;=^5027994
 ;;^UTILITY(U,$J,358.3,7102,0)
 ;;=S46.091S^^58^466^15
 ;;^UTILITY(U,$J,358.3,7102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7102,1,3,0)
 ;;=3^Rotator Cuff Muscle/Tendon Inj,Right Shoulder,Sequela
 ;;^UTILITY(U,$J,358.3,7102,1,4,0)
 ;;=4^S46.091S
 ;;^UTILITY(U,$J,358.3,7102,2)
 ;;=^5028166
 ;;^UTILITY(U,$J,358.3,7103,0)
 ;;=S76.312A^^58^466^7
 ;;^UTILITY(U,$J,358.3,7103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7103,1,3,0)
 ;;=3^Muscle/Fascia/Tendon Strain,Left Thigh,Init Encntr
 ;;^UTILITY(U,$J,358.3,7103,1,4,0)
 ;;=4^S76.312A
 ;;^UTILITY(U,$J,358.3,7103,2)
 ;;=^5039609
 ;;^UTILITY(U,$J,358.3,7104,0)
 ;;=S83.91XA^^58^466^13
 ;;^UTILITY(U,$J,358.3,7104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7104,1,3,0)
 ;;=3^Right Knee Sprain,Init Encntr
 ;;^UTILITY(U,$J,358.3,7104,1,4,0)
 ;;=4^S83.91XA
 ;;^UTILITY(U,$J,358.3,7104,2)
 ;;=^5043172
 ;;^UTILITY(U,$J,358.3,7105,0)
 ;;=S88.112S^^58^466^1
 ;;^UTILITY(U,$J,358.3,7105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7105,1,3,0)
 ;;=3^Complete Traumatic Amputation,Between Left Knee and Ankle,Sequela
 ;;^UTILITY(U,$J,358.3,7105,1,4,0)
 ;;=4^S88.112S
 ;;^UTILITY(U,$J,358.3,7105,2)
 ;;=^5043606
 ;;^UTILITY(U,$J,358.3,7106,0)
 ;;=S44.8X1D^^58^466^17
 ;;^UTILITY(U,$J,358.3,7106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7106,1,3,0)
 ;;=3^Shoulder/Upper Arm Nerve Inj,Right Arm,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7106,1,4,0)
 ;;=4^S44.8X1D
 ;;^UTILITY(U,$J,358.3,7106,2)
 ;;=^5027991
 ;;^UTILITY(U,$J,358.3,7107,0)
 ;;=S46.092S^^58^466^14
 ;;^UTILITY(U,$J,358.3,7107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7107,1,3,0)
 ;;=3^Rotator Cuff Muscle/Tendon Inj,Left Shoulder,Sequela
 ;;^UTILITY(U,$J,358.3,7107,1,4,0)
 ;;=4^S46.092S
 ;;^UTILITY(U,$J,358.3,7107,2)
 ;;=^5134838
 ;;^UTILITY(U,$J,358.3,7108,0)
 ;;=S76.311A^^58^466^8
 ;;^UTILITY(U,$J,358.3,7108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7108,1,3,0)
 ;;=3^Muscle/Fascia/Tendon Strain,Left Thigh,Init Encntr
 ;;^UTILITY(U,$J,358.3,7108,1,4,0)
 ;;=4^S76.311A
 ;;^UTILITY(U,$J,358.3,7108,2)
 ;;=^5039606
 ;;^UTILITY(U,$J,358.3,7109,0)
 ;;=S83.92XA^^58^466^4
 ;;^UTILITY(U,$J,358.3,7109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7109,1,3,0)
 ;;=3^Left Knee Sprain,Init Encntr
 ;;^UTILITY(U,$J,358.3,7109,1,4,0)
 ;;=4^S83.92XA
 ;;^UTILITY(U,$J,358.3,7109,2)
 ;;=^5043175
 ;;^UTILITY(U,$J,358.3,7110,0)
 ;;=S88.111S^^58^466^2
 ;;^UTILITY(U,$J,358.3,7110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7110,1,3,0)
 ;;=3^Complete Traumatic Amputation,Between Right Knee and Ankle,Sequela
 ;;^UTILITY(U,$J,358.3,7110,1,4,0)
 ;;=4^S88.111S
 ;;^UTILITY(U,$J,358.3,7110,2)
 ;;=^5043603
 ;;^UTILITY(U,$J,358.3,7111,0)
 ;;=C79.51^^58^467^5
 ;;^UTILITY(U,$J,358.3,7111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7111,1,3,0)
 ;;=3^Secondary Malig Neop of Bone
 ;;^UTILITY(U,$J,358.3,7111,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,7111,2)
 ;;=^5001350
