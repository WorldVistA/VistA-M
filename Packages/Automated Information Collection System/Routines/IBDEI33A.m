IBDEI33A ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,49330,0)
 ;;=J95.4^^187^2444^32
 ;;^UTILITY(U,$J,358.3,49330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49330,1,3,0)
 ;;=3^Chemical Pneumonitis d/t Anesthesia
 ;;^UTILITY(U,$J,358.3,49330,1,4,0)
 ;;=4^J95.4
 ;;^UTILITY(U,$J,358.3,49330,2)
 ;;=^5008330
 ;;^UTILITY(U,$J,358.3,49331,0)
 ;;=J95.5^^187^2444^53
 ;;^UTILITY(U,$J,358.3,49331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49331,1,3,0)
 ;;=3^Subglottic Stenosis,Postprocedural
 ;;^UTILITY(U,$J,358.3,49331,1,4,0)
 ;;=4^J95.5
 ;;^UTILITY(U,$J,358.3,49331,2)
 ;;=^5008331
 ;;^UTILITY(U,$J,358.3,49332,0)
 ;;=J95.61^^187^2444^38
 ;;^UTILITY(U,$J,358.3,49332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49332,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Resp Sys Complicating Resp Procedure
 ;;^UTILITY(U,$J,358.3,49332,1,4,0)
 ;;=4^J95.61
 ;;^UTILITY(U,$J,358.3,49332,2)
 ;;=^5008332
 ;;^UTILITY(U,$J,358.3,49333,0)
 ;;=J95.62^^187^2444^39
 ;;^UTILITY(U,$J,358.3,49333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49333,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Resp Sys Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,49333,1,4,0)
 ;;=4^J95.62
 ;;^UTILITY(U,$J,358.3,49333,2)
 ;;=^5008333
 ;;^UTILITY(U,$J,358.3,49334,0)
 ;;=J95.71^^187^2444^4
 ;;^UTILITY(U,$J,358.3,49334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49334,1,3,0)
 ;;=3^Accidental Pnctr/Lac of Resp Sys During Resp Procedure
 ;;^UTILITY(U,$J,358.3,49334,1,4,0)
 ;;=4^J95.71
 ;;^UTILITY(U,$J,358.3,49334,2)
 ;;=^5008334
 ;;^UTILITY(U,$J,358.3,49335,0)
 ;;=J95.72^^187^2444^5
 ;;^UTILITY(U,$J,358.3,49335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49335,1,3,0)
 ;;=3^Accidental Pnctr/Lac of Resp Sys During Oth Procedure
 ;;^UTILITY(U,$J,358.3,49335,1,4,0)
 ;;=4^J95.72
 ;;^UTILITY(U,$J,358.3,49335,2)
 ;;=^5008335
 ;;^UTILITY(U,$J,358.3,49336,0)
 ;;=J95.811^^187^2444^43
 ;;^UTILITY(U,$J,358.3,49336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49336,1,3,0)
 ;;=3^Pneumothorax,Postprocedural
 ;;^UTILITY(U,$J,358.3,49336,1,4,0)
 ;;=4^J95.811
 ;;^UTILITY(U,$J,358.3,49336,2)
 ;;=^5008336
 ;;^UTILITY(U,$J,358.3,49337,0)
 ;;=J95.812^^187^2444^13
 ;;^UTILITY(U,$J,358.3,49337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49337,1,3,0)
 ;;=3^Air Leak,Postprocedural
 ;;^UTILITY(U,$J,358.3,49337,1,4,0)
 ;;=4^J95.812
 ;;^UTILITY(U,$J,358.3,49337,2)
 ;;=^5008337
 ;;^UTILITY(U,$J,358.3,49338,0)
 ;;=J95.821^^187^2444^6
 ;;^UTILITY(U,$J,358.3,49338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49338,1,3,0)
 ;;=3^Acute Postprocedural Respiratory Failure
 ;;^UTILITY(U,$J,358.3,49338,1,4,0)
 ;;=4^J95.821
 ;;^UTILITY(U,$J,358.3,49338,2)
 ;;=^5008338
 ;;^UTILITY(U,$J,358.3,49339,0)
 ;;=J95.822^^187^2444^12
 ;;^UTILITY(U,$J,358.3,49339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49339,1,3,0)
 ;;=3^Acute and Chronic Postprocedural Respiratory Failure
 ;;^UTILITY(U,$J,358.3,49339,1,4,0)
 ;;=4^J95.822
 ;;^UTILITY(U,$J,358.3,49339,2)
 ;;=^5008339
 ;;^UTILITY(U,$J,358.3,49340,0)
 ;;=J95.830^^187^2444^45
 ;;^UTILITY(U,$J,358.3,49340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49340,1,3,0)
 ;;=3^Postproc Hemor of Resp Sys Following Resp Sys Procedure
 ;;^UTILITY(U,$J,358.3,49340,1,4,0)
 ;;=4^J95.830
 ;;^UTILITY(U,$J,358.3,49340,2)
 ;;=^5008340
 ;;^UTILITY(U,$J,358.3,49341,0)
 ;;=J95.831^^187^2444^44
 ;;^UTILITY(U,$J,358.3,49341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49341,1,3,0)
 ;;=3^Postproc Hemor of Resp Sys Following Oth Procedure
