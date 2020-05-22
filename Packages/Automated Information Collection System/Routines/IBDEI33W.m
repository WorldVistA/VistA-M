IBDEI33W ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,49613,1,4,0)
 ;;=4^J45.21
 ;;^UTILITY(U,$J,358.3,49613,2)
 ;;=^5008243
 ;;^UTILITY(U,$J,358.3,49614,0)
 ;;=J45.22^^191^2474^17
 ;;^UTILITY(U,$J,358.3,49614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49614,1,3,0)
 ;;=3^Asthma,Mild Intermittent w/ Status Asthmaticus
 ;;^UTILITY(U,$J,358.3,49614,1,4,0)
 ;;=4^J45.22
 ;;^UTILITY(U,$J,358.3,49614,2)
 ;;=^5008244
 ;;^UTILITY(U,$J,358.3,49615,0)
 ;;=J45.30^^191^2474^21
 ;;^UTILITY(U,$J,358.3,49615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49615,1,3,0)
 ;;=3^Asthma,Mild Persistent,Uncomplicated
 ;;^UTILITY(U,$J,358.3,49615,1,4,0)
 ;;=4^J45.30
 ;;^UTILITY(U,$J,358.3,49615,2)
 ;;=^5008245
 ;;^UTILITY(U,$J,358.3,49616,0)
 ;;=J45.31^^191^2474^19
 ;;^UTILITY(U,$J,358.3,49616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49616,1,3,0)
 ;;=3^Asthma,Mild Persistent w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,49616,1,4,0)
 ;;=4^J45.31
 ;;^UTILITY(U,$J,358.3,49616,2)
 ;;=^5008246
 ;;^UTILITY(U,$J,358.3,49617,0)
 ;;=J45.32^^191^2474^20
 ;;^UTILITY(U,$J,358.3,49617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49617,1,3,0)
 ;;=3^Asthma,Mild Persistent w/ Status Asthmaticus
 ;;^UTILITY(U,$J,358.3,49617,1,4,0)
 ;;=4^J45.32
 ;;^UTILITY(U,$J,358.3,49617,2)
 ;;=^5008247
 ;;^UTILITY(U,$J,358.3,49618,0)
 ;;=J45.40^^191^2474^24
 ;;^UTILITY(U,$J,358.3,49618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49618,1,3,0)
 ;;=3^Asthma,Moderate Persistent,Uncomplicated
 ;;^UTILITY(U,$J,358.3,49618,1,4,0)
 ;;=4^J45.40
 ;;^UTILITY(U,$J,358.3,49618,2)
 ;;=^5008248
 ;;^UTILITY(U,$J,358.3,49619,0)
 ;;=J45.41^^191^2474^22
 ;;^UTILITY(U,$J,358.3,49619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49619,1,3,0)
 ;;=3^Asthma,Moderate Persistent w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,49619,1,4,0)
 ;;=4^J45.41
 ;;^UTILITY(U,$J,358.3,49619,2)
 ;;=^5008249
 ;;^UTILITY(U,$J,358.3,49620,0)
 ;;=J45.42^^191^2474^23
 ;;^UTILITY(U,$J,358.3,49620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49620,1,3,0)
 ;;=3^Asthma,Moderate Persistent w/ Status Asthmaticus
 ;;^UTILITY(U,$J,358.3,49620,1,4,0)
 ;;=4^J45.42
 ;;^UTILITY(U,$J,358.3,49620,2)
 ;;=^5008250
 ;;^UTILITY(U,$J,358.3,49621,0)
 ;;=J45.50^^191^2474^27
 ;;^UTILITY(U,$J,358.3,49621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49621,1,3,0)
 ;;=3^Asthma,Severe Persistent,Uncomplicated
 ;;^UTILITY(U,$J,358.3,49621,1,4,0)
 ;;=4^J45.50
 ;;^UTILITY(U,$J,358.3,49621,2)
 ;;=^5008251
 ;;^UTILITY(U,$J,358.3,49622,0)
 ;;=J45.51^^191^2474^25
 ;;^UTILITY(U,$J,358.3,49622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49622,1,3,0)
 ;;=3^Asthma,Severe Persistent w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,49622,1,4,0)
 ;;=4^J45.51
 ;;^UTILITY(U,$J,358.3,49622,2)
 ;;=^5008252
 ;;^UTILITY(U,$J,358.3,49623,0)
 ;;=J45.52^^191^2474^26
 ;;^UTILITY(U,$J,358.3,49623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49623,1,3,0)
 ;;=3^Asthma,Severe Persistent w/ Status Asthmaticus
 ;;^UTILITY(U,$J,358.3,49623,1,4,0)
 ;;=4^J45.52
 ;;^UTILITY(U,$J,358.3,49623,2)
 ;;=^5008253
 ;;^UTILITY(U,$J,358.3,49624,0)
 ;;=J45.901^^191^2474^14
 ;;^UTILITY(U,$J,358.3,49624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49624,1,3,0)
 ;;=3^Asthma w/ Acute Exacerbation,Unspec
 ;;^UTILITY(U,$J,358.3,49624,1,4,0)
 ;;=4^J45.901
 ;;^UTILITY(U,$J,358.3,49624,2)
 ;;=^5008254
 ;;^UTILITY(U,$J,358.3,49625,0)
 ;;=J45.902^^191^2474^15
 ;;^UTILITY(U,$J,358.3,49625,1,0)
 ;;=^358.31IA^4^2
