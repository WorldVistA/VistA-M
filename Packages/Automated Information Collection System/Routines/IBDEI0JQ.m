IBDEI0JQ ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8890,1,3,0)
 ;;=3^Air Leak NEC
 ;;^UTILITY(U,$J,358.3,8890,1,4,0)
 ;;=4^J93.82
 ;;^UTILITY(U,$J,358.3,8890,2)
 ;;=^5008314
 ;;^UTILITY(U,$J,358.3,8891,0)
 ;;=J93.9^^55^551^7
 ;;^UTILITY(U,$J,358.3,8891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8891,1,3,0)
 ;;=3^Pneumothorax, unspecified
 ;;^UTILITY(U,$J,358.3,8891,1,4,0)
 ;;=4^J93.9
 ;;^UTILITY(U,$J,358.3,8891,2)
 ;;=^5008315
 ;;^UTILITY(U,$J,358.3,8892,0)
 ;;=J12.9^^55^552^11
 ;;^UTILITY(U,$J,358.3,8892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8892,1,3,0)
 ;;=3^Viral pneumonia, unspecified
 ;;^UTILITY(U,$J,358.3,8892,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,8892,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,8893,0)
 ;;=J13.^^55^552^7
 ;;^UTILITY(U,$J,358.3,8893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8893,1,3,0)
 ;;=3^Pneumonia due to Streptococcus pneumoniae
 ;;^UTILITY(U,$J,358.3,8893,1,4,0)
 ;;=4^J13.
 ;;^UTILITY(U,$J,358.3,8893,2)
 ;;=^5008170
 ;;^UTILITY(U,$J,358.3,8894,0)
 ;;=J15.4^^55^552^9
 ;;^UTILITY(U,$J,358.3,8894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8894,1,3,0)
 ;;=3^Pneumonia due to other streptococci
 ;;^UTILITY(U,$J,358.3,8894,1,4,0)
 ;;=4^J15.4
 ;;^UTILITY(U,$J,358.3,8894,2)
 ;;=^5008174
 ;;^UTILITY(U,$J,358.3,8895,0)
 ;;=J15.211^^55^552^8
 ;;^UTILITY(U,$J,358.3,8895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8895,1,3,0)
 ;;=3^Pneumonia due to methicillin suscep staph
 ;;^UTILITY(U,$J,358.3,8895,1,4,0)
 ;;=4^J15.211
 ;;^UTILITY(U,$J,358.3,8895,2)
 ;;=^336833
 ;;^UTILITY(U,$J,358.3,8896,0)
 ;;=J15.212^^55^552^6
 ;;^UTILITY(U,$J,358.3,8896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8896,1,3,0)
 ;;=3^Pneumonia due to Methicillin resistant Staphylococcus aureus
 ;;^UTILITY(U,$J,358.3,8896,1,4,0)
 ;;=4^J15.212
 ;;^UTILITY(U,$J,358.3,8896,2)
 ;;=^336602
 ;;^UTILITY(U,$J,358.3,8897,0)
 ;;=J15.9^^55^552^1
 ;;^UTILITY(U,$J,358.3,8897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8897,1,3,0)
 ;;=3^Bacterial Pneumonia,Unspec
 ;;^UTILITY(U,$J,358.3,8897,1,4,0)
 ;;=4^J15.9
 ;;^UTILITY(U,$J,358.3,8897,2)
 ;;=^5008178
 ;;^UTILITY(U,$J,358.3,8898,0)
 ;;=J18.9^^55^552^10
 ;;^UTILITY(U,$J,358.3,8898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8898,1,3,0)
 ;;=3^Pneumonia, unspecified organism
 ;;^UTILITY(U,$J,358.3,8898,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,8898,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,8899,0)
 ;;=J09.X1^^55^552^2
 ;;^UTILITY(U,$J,358.3,8899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8899,1,3,0)
 ;;=3^Flu d/t ident novel influenza A virus w pneumonia
 ;;^UTILITY(U,$J,358.3,8899,1,4,0)
 ;;=4^J09.X1
 ;;^UTILITY(U,$J,358.3,8899,2)
 ;;=^5008144
 ;;^UTILITY(U,$J,358.3,8900,0)
 ;;=J09.X2^^55^552^3
 ;;^UTILITY(U,$J,358.3,8900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8900,1,3,0)
 ;;=3^Flu d/t ident novel influenza A virus w oth resp manifest
 ;;^UTILITY(U,$J,358.3,8900,1,4,0)
 ;;=4^J09.X2
 ;;^UTILITY(U,$J,358.3,8900,2)
 ;;=^5008145
 ;;^UTILITY(U,$J,358.3,8901,0)
 ;;=J09.X3^^55^552^4
 ;;^UTILITY(U,$J,358.3,8901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8901,1,3,0)
 ;;=3^Flu d/t ident novel influenza A virus w GI manifest
 ;;^UTILITY(U,$J,358.3,8901,1,4,0)
 ;;=4^J09.X3
 ;;^UTILITY(U,$J,358.3,8901,2)
 ;;=^5008146
 ;;^UTILITY(U,$J,358.3,8902,0)
 ;;=J09.X9^^55^552^5
 ;;^UTILITY(U,$J,358.3,8902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8902,1,3,0)
 ;;=3^Flu d/t ident novel influenza A virus w oth manifest
 ;;^UTILITY(U,$J,358.3,8902,1,4,0)
 ;;=4^J09.X9
 ;;^UTILITY(U,$J,358.3,8902,2)
 ;;=^5008147
 ;;^UTILITY(U,$J,358.3,8903,0)
 ;;=I26.92^^55^553^7
 ;;^UTILITY(U,$J,358.3,8903,1,0)
 ;;=^358.31IA^4^2
