IBDEI0SW ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12870,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Skin During Surgery
 ;;^UTILITY(U,$J,358.3,12870,1,4,0)
 ;;=4^L76.12
 ;;^UTILITY(U,$J,358.3,12870,2)
 ;;=^5009305
 ;;^UTILITY(U,$J,358.3,12871,0)
 ;;=I97.88^^80^789^15
 ;;^UTILITY(U,$J,358.3,12871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12871,1,3,0)
 ;;=3^Intraoperative Complication of the Circulatory System NEC
 ;;^UTILITY(U,$J,358.3,12871,1,4,0)
 ;;=4^I97.88
 ;;^UTILITY(U,$J,358.3,12871,2)
 ;;=^5008111
 ;;^UTILITY(U,$J,358.3,12872,0)
 ;;=K91.81^^80^789^16
 ;;^UTILITY(U,$J,358.3,12872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12872,1,3,0)
 ;;=3^Intraoperative Complication of the Digestive System NEC
 ;;^UTILITY(U,$J,358.3,12872,1,4,0)
 ;;=4^K91.81
 ;;^UTILITY(U,$J,358.3,12872,2)
 ;;=^5008907
 ;;^UTILITY(U,$J,358.3,12873,0)
 ;;=H95.88^^80^789^17
 ;;^UTILITY(U,$J,358.3,12873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12873,1,3,0)
 ;;=3^Intraoperative Complication of the Ear/Mastoid NEC
 ;;^UTILITY(U,$J,358.3,12873,1,4,0)
 ;;=4^H95.88
 ;;^UTILITY(U,$J,358.3,12873,2)
 ;;=^5007036
 ;;^UTILITY(U,$J,358.3,12874,0)
 ;;=N99.81^^80^789^18
 ;;^UTILITY(U,$J,358.3,12874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12874,1,3,0)
 ;;=3^Intraoperative Complication of the GU System NEC
 ;;^UTILITY(U,$J,358.3,12874,1,4,0)
 ;;=4^N99.81
 ;;^UTILITY(U,$J,358.3,12874,2)
 ;;=^5015967
 ;;^UTILITY(U,$J,358.3,12875,0)
 ;;=M96.89^^80^789^19
 ;;^UTILITY(U,$J,358.3,12875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12875,1,3,0)
 ;;=3^Intraoperative Complication of the Musculoskeletal System NEC
 ;;^UTILITY(U,$J,358.3,12875,1,4,0)
 ;;=4^M96.89
 ;;^UTILITY(U,$J,358.3,12875,2)
 ;;=^5015399
 ;;^UTILITY(U,$J,358.3,12876,0)
 ;;=G97.81^^80^789^20
 ;;^UTILITY(U,$J,358.3,12876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12876,1,3,0)
 ;;=3^Intraoperative Complication of the Nervous System
 ;;^UTILITY(U,$J,358.3,12876,1,4,0)
 ;;=4^G97.81
 ;;^UTILITY(U,$J,358.3,12876,2)
 ;;=^5004211
 ;;^UTILITY(U,$J,358.3,12877,0)
 ;;=J95.88^^80^789^21
 ;;^UTILITY(U,$J,358.3,12877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12877,1,3,0)
 ;;=3^Intraoperative Complication of the Respiratory System NEC
 ;;^UTILITY(U,$J,358.3,12877,1,4,0)
 ;;=4^J95.88
 ;;^UTILITY(U,$J,358.3,12877,2)
 ;;=^5008345
 ;;^UTILITY(U,$J,358.3,12878,0)
 ;;=L76.81^^80^789^22
 ;;^UTILITY(U,$J,358.3,12878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12878,1,3,0)
 ;;=3^Intraoperative Complication of the Skin NEC
 ;;^UTILITY(U,$J,358.3,12878,1,4,0)
 ;;=4^L76.81
 ;;^UTILITY(U,$J,358.3,12878,2)
 ;;=^5009308
 ;;^UTILITY(U,$J,358.3,12879,0)
 ;;=D78.81^^80^789^23
 ;;^UTILITY(U,$J,358.3,12879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12879,1,3,0)
 ;;=3^Intraoperative Complication of the Spleen
 ;;^UTILITY(U,$J,358.3,12879,1,4,0)
 ;;=4^D78.81
 ;;^UTILITY(U,$J,358.3,12879,2)
 ;;=^5002403
 ;;^UTILITY(U,$J,358.3,12880,0)
 ;;=H59.229^^80^789^3
 ;;^UTILITY(U,$J,358.3,12880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12880,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Eye/Adnexa,Unspec,During Surgery
 ;;^UTILITY(U,$J,358.3,12880,1,4,0)
 ;;=4^H59.229
 ;;^UTILITY(U,$J,358.3,12880,2)
 ;;=^5006416
 ;;^UTILITY(U,$J,358.3,12881,0)
 ;;=D78.12^^80^789^11
 ;;^UTILITY(U,$J,358.3,12881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12881,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Spleen During Surgery
