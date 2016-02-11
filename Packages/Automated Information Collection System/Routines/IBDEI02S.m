IBDEI02S ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,540,2)
 ;;=^5002612
 ;;^UTILITY(U,$J,358.3,541,0)
 ;;=E10.610^^6^69^12
 ;;^UTILITY(U,$J,358.3,541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,541,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neuropathic Arthropathy
 ;;^UTILITY(U,$J,358.3,541,1,4,0)
 ;;=4^E10.610
 ;;^UTILITY(U,$J,358.3,541,2)
 ;;=^5002613
 ;;^UTILITY(U,$J,358.3,542,0)
 ;;=E10.618^^6^69^3
 ;;^UTILITY(U,$J,358.3,542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,542,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Arthropathy
 ;;^UTILITY(U,$J,358.3,542,1,4,0)
 ;;=4^E10.618
 ;;^UTILITY(U,$J,358.3,542,2)
 ;;=^5002614
 ;;^UTILITY(U,$J,358.3,543,0)
 ;;=E10.620^^6^69^7
 ;;^UTILITY(U,$J,358.3,543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,543,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Dermatitis
 ;;^UTILITY(U,$J,358.3,543,1,4,0)
 ;;=4^E10.620
 ;;^UTILITY(U,$J,358.3,543,2)
 ;;=^5002615
 ;;^UTILITY(U,$J,358.3,544,0)
 ;;=E10.621^^6^69^19
 ;;^UTILITY(U,$J,358.3,544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,544,1,3,0)
 ;;=3^Diabetes Type 1 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,544,1,4,0)
 ;;=4^E10.621
 ;;^UTILITY(U,$J,358.3,544,2)
 ;;=^5002616
 ;;^UTILITY(U,$J,358.3,545,0)
 ;;=E10.622^^6^69^33
 ;;^UTILITY(U,$J,358.3,545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,545,1,3,0)
 ;;=3^Diabetes Type 1 w/ Skin Ulcer
 ;;^UTILITY(U,$J,358.3,545,1,4,0)
 ;;=4^E10.622
 ;;^UTILITY(U,$J,358.3,545,2)
 ;;=^5002617
 ;;^UTILITY(U,$J,358.3,546,0)
 ;;=E10.628^^6^69^32
 ;;^UTILITY(U,$J,358.3,546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,546,1,3,0)
 ;;=3^Diabetes Type 1 w/ Skin Complications
 ;;^UTILITY(U,$J,358.3,546,1,4,0)
 ;;=4^E10.628
 ;;^UTILITY(U,$J,358.3,546,2)
 ;;=^5002618
 ;;^UTILITY(U,$J,358.3,547,0)
 ;;=E10.630^^6^69^27
 ;;^UTILITY(U,$J,358.3,547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,547,1,3,0)
 ;;=3^Diabetes Type 1 w/ Peridontal Disease
 ;;^UTILITY(U,$J,358.3,547,1,4,0)
 ;;=4^E10.630
 ;;^UTILITY(U,$J,358.3,547,2)
 ;;=^5002619
 ;;^UTILITY(U,$J,358.3,548,0)
 ;;=E10.638^^6^69^25
 ;;^UTILITY(U,$J,358.3,548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,548,1,3,0)
 ;;=3^Diabetes Type 1 w/ Oral Complications
 ;;^UTILITY(U,$J,358.3,548,1,4,0)
 ;;=4^E10.638
 ;;^UTILITY(U,$J,358.3,548,2)
 ;;=^5002620
 ;;^UTILITY(U,$J,358.3,549,0)
 ;;=E10.69^^6^69^26
 ;;^UTILITY(U,$J,358.3,549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,549,1,3,0)
 ;;=3^Diabetes Type 1 w/ Other Specified Complication
 ;;^UTILITY(U,$J,358.3,549,1,4,0)
 ;;=4^E10.69
 ;;^UTILITY(U,$J,358.3,549,2)
 ;;=^5002624
 ;;^UTILITY(U,$J,358.3,550,0)
 ;;=E10.8^^6^69^34
 ;;^UTILITY(U,$J,358.3,550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,550,1,3,0)
 ;;=3^Diabetes Type 1 w/ Unspec Complications
 ;;^UTILITY(U,$J,358.3,550,1,4,0)
 ;;=4^E10.8
 ;;^UTILITY(U,$J,358.3,550,2)
 ;;=^5002625
 ;;^UTILITY(U,$J,358.3,551,0)
 ;;=E11.9^^6^69^70
 ;;^UTILITY(U,$J,358.3,551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,551,1,3,0)
 ;;=3^Diabetes Type 2 w/o Complications
 ;;^UTILITY(U,$J,358.3,551,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,551,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,552,0)
 ;;=E11.65^^6^69^55
 ;;^UTILITY(U,$J,358.3,552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,552,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,552,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,552,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,553,0)
 ;;=E11.21^^6^69^45
 ;;^UTILITY(U,$J,358.3,553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,553,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,553,1,4,0)
 ;;=4^E11.21
 ;;^UTILITY(U,$J,358.3,553,2)
 ;;=^5002629
 ;;^UTILITY(U,$J,358.3,554,0)
 ;;=E11.22^^6^69^41
