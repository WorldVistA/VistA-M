IBDEI1FO ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22935,0)
 ;;=T82.828A^^105^1166^59
 ;;^UTILITY(U,$J,358.3,22935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22935,1,3,0)
 ;;=3^Fibrosis of Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,22935,1,4,0)
 ;;=4^T82.828A
 ;;^UTILITY(U,$J,358.3,22935,2)
 ;;=^5054923
 ;;^UTILITY(U,$J,358.3,22936,0)
 ;;=T82.838A^^105^1166^65
 ;;^UTILITY(U,$J,358.3,22936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22936,1,3,0)
 ;;=3^Hemorrh of Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,22936,1,4,0)
 ;;=4^T82.838A
 ;;^UTILITY(U,$J,358.3,22936,2)
 ;;=^5054929
 ;;^UTILITY(U,$J,358.3,22937,0)
 ;;=T82.848A^^105^1166^172
 ;;^UTILITY(U,$J,358.3,22937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22937,1,3,0)
 ;;=3^Pain from Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,22937,1,4,0)
 ;;=4^T82.848A
 ;;^UTILITY(U,$J,358.3,22937,2)
 ;;=^5054935
 ;;^UTILITY(U,$J,358.3,22938,0)
 ;;=T82.858A^^105^1166^225
 ;;^UTILITY(U,$J,358.3,22938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22938,1,3,0)
 ;;=3^Sten,Vasc Prosth Dvc/Implnt/Grft,Init Enc
 ;;^UTILITY(U,$J,358.3,22938,1,4,0)
 ;;=4^T82.858A
 ;;^UTILITY(U,$J,358.3,22938,2)
 ;;=^5054941
 ;;^UTILITY(U,$J,358.3,22939,0)
 ;;=T82.868A^^105^1166^231
 ;;^UTILITY(U,$J,358.3,22939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22939,1,3,0)
 ;;=3^Thromb,Vascular Prosth Dvc/Implnt/Grft,Init Enc
 ;;^UTILITY(U,$J,358.3,22939,1,4,0)
 ;;=4^T82.868A
 ;;^UTILITY(U,$J,358.3,22939,2)
 ;;=^5054947
 ;;^UTILITY(U,$J,358.3,22940,0)
 ;;=T82.898A^^105^1166^28
 ;;^UTILITY(U,$J,358.3,22940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22940,1,3,0)
 ;;=3^Complic,Vasc Prosth Dvc/Implt/Grft Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,22940,1,4,0)
 ;;=4^T82.898A
 ;;^UTILITY(U,$J,358.3,22940,2)
 ;;=^5054953
 ;;^UTILITY(U,$J,358.3,22941,0)
 ;;=T83.81XA^^105^1166^52
 ;;^UTILITY(U,$J,358.3,22941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22941,1,3,0)
 ;;=3^Embol of Genitourinary Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,22941,1,4,0)
 ;;=4^T83.81XA
 ;;^UTILITY(U,$J,358.3,22941,2)
 ;;=^5055079
 ;;^UTILITY(U,$J,358.3,22942,0)
 ;;=T83.82XA^^105^1166^58
 ;;^UTILITY(U,$J,358.3,22942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22942,1,3,0)
 ;;=3^Fibrosis of Genitourinary Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,22942,1,4,0)
 ;;=4^T83.82XA
 ;;^UTILITY(U,$J,358.3,22942,2)
 ;;=^5055082
 ;;^UTILITY(U,$J,358.3,22943,0)
 ;;=T83.83XA^^105^1166^64
 ;;^UTILITY(U,$J,358.3,22943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22943,1,3,0)
 ;;=3^Hemorrh of Genitourinary Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,22943,1,4,0)
 ;;=4^T83.83XA
 ;;^UTILITY(U,$J,358.3,22943,2)
 ;;=^5055085
 ;;^UTILITY(U,$J,358.3,22944,0)
 ;;=T83.84XA^^105^1166^171
 ;;^UTILITY(U,$J,358.3,22944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22944,1,3,0)
 ;;=3^Pain from Genitourinary Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,22944,1,4,0)
 ;;=4^T83.84XA
 ;;^UTILITY(U,$J,358.3,22944,2)
 ;;=^5055088
 ;;^UTILITY(U,$J,358.3,22945,0)
 ;;=T83.85XA^^105^1166^224
 ;;^UTILITY(U,$J,358.3,22945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22945,1,3,0)
 ;;=3^Sten,Genitour Prosth Dvc/Implnt/Grft,Init Enc
 ;;^UTILITY(U,$J,358.3,22945,1,4,0)
 ;;=4^T83.85XA
 ;;^UTILITY(U,$J,358.3,22945,2)
 ;;=^5055091
