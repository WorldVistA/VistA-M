IBDEI33Y ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,49637,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Resp Sys Complicating Resp Procedure
 ;;^UTILITY(U,$J,358.3,49637,1,4,0)
 ;;=4^J95.61
 ;;^UTILITY(U,$J,358.3,49637,2)
 ;;=^5008332
 ;;^UTILITY(U,$J,358.3,49638,0)
 ;;=J95.62^^191^2474^39
 ;;^UTILITY(U,$J,358.3,49638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49638,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Resp Sys Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,49638,1,4,0)
 ;;=4^J95.62
 ;;^UTILITY(U,$J,358.3,49638,2)
 ;;=^5008333
 ;;^UTILITY(U,$J,358.3,49639,0)
 ;;=J95.71^^191^2474^4
 ;;^UTILITY(U,$J,358.3,49639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49639,1,3,0)
 ;;=3^Accidental Pnctr/Lac of Resp Sys During Resp Procedure
 ;;^UTILITY(U,$J,358.3,49639,1,4,0)
 ;;=4^J95.71
 ;;^UTILITY(U,$J,358.3,49639,2)
 ;;=^5008334
 ;;^UTILITY(U,$J,358.3,49640,0)
 ;;=J95.72^^191^2474^5
 ;;^UTILITY(U,$J,358.3,49640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49640,1,3,0)
 ;;=3^Accidental Pnctr/Lac of Resp Sys During Oth Procedure
 ;;^UTILITY(U,$J,358.3,49640,1,4,0)
 ;;=4^J95.72
 ;;^UTILITY(U,$J,358.3,49640,2)
 ;;=^5008335
 ;;^UTILITY(U,$J,358.3,49641,0)
 ;;=J95.811^^191^2474^43
 ;;^UTILITY(U,$J,358.3,49641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49641,1,3,0)
 ;;=3^Pneumothorax,Postprocedural
 ;;^UTILITY(U,$J,358.3,49641,1,4,0)
 ;;=4^J95.811
 ;;^UTILITY(U,$J,358.3,49641,2)
 ;;=^5008336
 ;;^UTILITY(U,$J,358.3,49642,0)
 ;;=J95.812^^191^2474^13
 ;;^UTILITY(U,$J,358.3,49642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49642,1,3,0)
 ;;=3^Air Leak,Postprocedural
 ;;^UTILITY(U,$J,358.3,49642,1,4,0)
 ;;=4^J95.812
 ;;^UTILITY(U,$J,358.3,49642,2)
 ;;=^5008337
 ;;^UTILITY(U,$J,358.3,49643,0)
 ;;=J95.821^^191^2474^6
 ;;^UTILITY(U,$J,358.3,49643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49643,1,3,0)
 ;;=3^Acute Postprocedural Respiratory Failure
 ;;^UTILITY(U,$J,358.3,49643,1,4,0)
 ;;=4^J95.821
 ;;^UTILITY(U,$J,358.3,49643,2)
 ;;=^5008338
 ;;^UTILITY(U,$J,358.3,49644,0)
 ;;=J95.822^^191^2474^12
 ;;^UTILITY(U,$J,358.3,49644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49644,1,3,0)
 ;;=3^Acute and Chronic Postprocedural Respiratory Failure
 ;;^UTILITY(U,$J,358.3,49644,1,4,0)
 ;;=4^J95.822
 ;;^UTILITY(U,$J,358.3,49644,2)
 ;;=^5008339
 ;;^UTILITY(U,$J,358.3,49645,0)
 ;;=J95.830^^191^2474^45
 ;;^UTILITY(U,$J,358.3,49645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49645,1,3,0)
 ;;=3^Postproc Hemor of Resp Sys Following Resp Sys Procedure
 ;;^UTILITY(U,$J,358.3,49645,1,4,0)
 ;;=4^J95.830
 ;;^UTILITY(U,$J,358.3,49645,2)
 ;;=^5008340
 ;;^UTILITY(U,$J,358.3,49646,0)
 ;;=J95.831^^191^2474^44
 ;;^UTILITY(U,$J,358.3,49646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49646,1,3,0)
 ;;=3^Postproc Hemor of Resp Sys Following Oth Procedure
 ;;^UTILITY(U,$J,358.3,49646,1,4,0)
 ;;=4^J95.831
 ;;^UTILITY(U,$J,358.3,49646,2)
 ;;=^5008341
 ;;^UTILITY(U,$J,358.3,49647,0)
 ;;=J95.850^^191^2474^40
 ;;^UTILITY(U,$J,358.3,49647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49647,1,3,0)
 ;;=3^Mechanical Complication of Respirator
 ;;^UTILITY(U,$J,358.3,49647,1,4,0)
 ;;=4^J95.850
 ;;^UTILITY(U,$J,358.3,49647,2)
 ;;=^5008343
 ;;^UTILITY(U,$J,358.3,49648,0)
 ;;=J95.851^^191^2474^60
 ;;^UTILITY(U,$J,358.3,49648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49648,1,3,0)
 ;;=3^Ventilator Associated Pneumonia
 ;;^UTILITY(U,$J,358.3,49648,1,4,0)
 ;;=4^J95.851
 ;;^UTILITY(U,$J,358.3,49648,2)
 ;;=^336692
