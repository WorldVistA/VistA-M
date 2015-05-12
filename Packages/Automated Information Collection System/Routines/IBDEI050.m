IBDEI050 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.99)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.99)
 ;;=^IBE(358.99,
 ;;^UTILITY(U,$J,358.99,0)
 ;;=IMP/EXP AICS DATA ELEMENTS^358.99^3^3
 ;;^UTILITY(U,$J,358.99,1,0)
 ;;=ICD-9 DIAGNOSIS CODE^7^^^____.__^7^10^^^^^ICD-9
 ;;^UTILITY(U,$J,358.99,1,1)
 ;;=D INPUTICD^IBDFN8(.X)
 ;;^UTILITY(U,$J,358.99,1,10)
 ;;=a^XF^^NNNN.NN
 ;;^UTILITY(U,$J,358.99,2,0)
 ;;=SHORT NARRATIVE (60 CHAR)^60^^^___________________________________________________________^60^10^^^^^NARR
 ;;^UTILITY(U,$J,358.99,2,10)
 ;;=a^^^###########################################################
 ;;^UTILITY(U,$J,358.99,3,0)
 ;;=ICD-10 DIAGNOSIS CODE^8^^^___.____^8^10^^^^^ICD10
 ;;^UTILITY(U,$J,358.99,3,1)
 ;;=D INPICD10^IBDFN8(.X)
 ;;^UTILITY(U,$J,358.99,3,10)
 ;;=a^XF^^ANX.XXXX
