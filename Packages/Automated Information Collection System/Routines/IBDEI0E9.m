IBDEI0E9 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6222,1,3,0)
 ;;=3^Intraoperative Complication of the Circulatory System NEC
 ;;^UTILITY(U,$J,358.3,6222,1,4,0)
 ;;=4^I97.88
 ;;^UTILITY(U,$J,358.3,6222,2)
 ;;=^5008111
 ;;^UTILITY(U,$J,358.3,6223,0)
 ;;=K91.81^^40^386^16
 ;;^UTILITY(U,$J,358.3,6223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6223,1,3,0)
 ;;=3^Intraoperative Complication of the Digestive System NEC
 ;;^UTILITY(U,$J,358.3,6223,1,4,0)
 ;;=4^K91.81
 ;;^UTILITY(U,$J,358.3,6223,2)
 ;;=^5008907
 ;;^UTILITY(U,$J,358.3,6224,0)
 ;;=H95.88^^40^386^17
 ;;^UTILITY(U,$J,358.3,6224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6224,1,3,0)
 ;;=3^Intraoperative Complication of the Ear/Mastoid NEC
 ;;^UTILITY(U,$J,358.3,6224,1,4,0)
 ;;=4^H95.88
 ;;^UTILITY(U,$J,358.3,6224,2)
 ;;=^5007036
 ;;^UTILITY(U,$J,358.3,6225,0)
 ;;=N99.81^^40^386^18
 ;;^UTILITY(U,$J,358.3,6225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6225,1,3,0)
 ;;=3^Intraoperative Complication of the GU System NEC
 ;;^UTILITY(U,$J,358.3,6225,1,4,0)
 ;;=4^N99.81
 ;;^UTILITY(U,$J,358.3,6225,2)
 ;;=^5015967
 ;;^UTILITY(U,$J,358.3,6226,0)
 ;;=M96.89^^40^386^19
 ;;^UTILITY(U,$J,358.3,6226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6226,1,3,0)
 ;;=3^Intraoperative Complication of the Musculoskeletal System NEC
 ;;^UTILITY(U,$J,358.3,6226,1,4,0)
 ;;=4^M96.89
 ;;^UTILITY(U,$J,358.3,6226,2)
 ;;=^5015399
 ;;^UTILITY(U,$J,358.3,6227,0)
 ;;=G97.81^^40^386^20
 ;;^UTILITY(U,$J,358.3,6227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6227,1,3,0)
 ;;=3^Intraoperative Complication of the Nervous System
 ;;^UTILITY(U,$J,358.3,6227,1,4,0)
 ;;=4^G97.81
 ;;^UTILITY(U,$J,358.3,6227,2)
 ;;=^5004211
 ;;^UTILITY(U,$J,358.3,6228,0)
 ;;=J95.88^^40^386^21
 ;;^UTILITY(U,$J,358.3,6228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6228,1,3,0)
 ;;=3^Intraoperative Complication of the Respiratory System NEC
 ;;^UTILITY(U,$J,358.3,6228,1,4,0)
 ;;=4^J95.88
 ;;^UTILITY(U,$J,358.3,6228,2)
 ;;=^5008345
 ;;^UTILITY(U,$J,358.3,6229,0)
 ;;=L76.81^^40^386^22
 ;;^UTILITY(U,$J,358.3,6229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6229,1,3,0)
 ;;=3^Intraoperative Complication of the Skin NEC
 ;;^UTILITY(U,$J,358.3,6229,1,4,0)
 ;;=4^L76.81
 ;;^UTILITY(U,$J,358.3,6229,2)
 ;;=^5009308
 ;;^UTILITY(U,$J,358.3,6230,0)
 ;;=D78.81^^40^386^23
 ;;^UTILITY(U,$J,358.3,6230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6230,1,3,0)
 ;;=3^Intraoperative Complication of the Spleen
 ;;^UTILITY(U,$J,358.3,6230,1,4,0)
 ;;=4^D78.81
 ;;^UTILITY(U,$J,358.3,6230,2)
 ;;=^5002403
 ;;^UTILITY(U,$J,358.3,6231,0)
 ;;=H59.229^^40^386^3
 ;;^UTILITY(U,$J,358.3,6231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6231,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Eye/Adnexa,Unspec,During Surgery
 ;;^UTILITY(U,$J,358.3,6231,1,4,0)
 ;;=4^H59.229
 ;;^UTILITY(U,$J,358.3,6231,2)
 ;;=^5006416
 ;;^UTILITY(U,$J,358.3,6232,0)
 ;;=D78.12^^40^386^11
 ;;^UTILITY(U,$J,358.3,6232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6232,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Spleen During Surgery
 ;;^UTILITY(U,$J,358.3,6232,1,4,0)
 ;;=4^D78.12
 ;;^UTILITY(U,$J,358.3,6232,2)
 ;;=^5002400
 ;;^UTILITY(U,$J,358.3,6233,0)
 ;;=I97.811^^40^386^14
 ;;^UTILITY(U,$J,358.3,6233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6233,1,3,0)
 ;;=3^Intraoperative Cerebrovascular Infarction During Surgery
 ;;^UTILITY(U,$J,358.3,6233,1,4,0)
 ;;=4^I97.811
 ;;^UTILITY(U,$J,358.3,6233,2)
 ;;=^5008108
 ;;^UTILITY(U,$J,358.3,6234,0)
 ;;=S31.154A^^40^387^3
 ;;^UTILITY(U,$J,358.3,6234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6234,1,3,0)
 ;;=3^Open Bite of LLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
