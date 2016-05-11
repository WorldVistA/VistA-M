IBDEI0IL ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8633,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8633,1,2,0)
 ;;=2^Low Vision Aid Fitting, Single Element
 ;;^UTILITY(U,$J,358.3,8633,1,3,0)
 ;;=3^92354
 ;;^UTILITY(U,$J,358.3,8634,0)
 ;;=92355^^40^466^11^^^^1
 ;;^UTILITY(U,$J,358.3,8634,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8634,1,2,0)
 ;;=2^Low Vision Aid Fitting, Telescopic/Compound Lens
 ;;^UTILITY(U,$J,358.3,8634,1,3,0)
 ;;=3^92355
 ;;^UTILITY(U,$J,358.3,8635,0)
 ;;=92370^^40^466^13^^^^1
 ;;^UTILITY(U,$J,358.3,8635,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8635,1,2,0)
 ;;=2^Repair/Refit Glasses
 ;;^UTILITY(U,$J,358.3,8635,1,3,0)
 ;;=3^92370
 ;;^UTILITY(U,$J,358.3,8636,0)
 ;;=92371^^40^466^14^^^^1
 ;;^UTILITY(U,$J,358.3,8636,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8636,1,2,0)
 ;;=2^Repair/Refit Glasses for Aphakia
 ;;^UTILITY(U,$J,358.3,8636,1,3,0)
 ;;=3^92371
 ;;^UTILITY(U,$J,358.3,8637,0)
 ;;=92071^^40^466^2^^^^1
 ;;^UTILITY(U,$J,358.3,8637,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8637,1,2,0)
 ;;=2^Contact Lens Tx for Ocular Disease
 ;;^UTILITY(U,$J,358.3,8637,1,3,0)
 ;;=3^92071
 ;;^UTILITY(U,$J,358.3,8638,0)
 ;;=92072^^40^466^1^^^^1
 ;;^UTILITY(U,$J,358.3,8638,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8638,1,2,0)
 ;;=2^Contact Lens Mgmt Keratoconus,Init
 ;;^UTILITY(U,$J,358.3,8638,1,3,0)
 ;;=3^92072
 ;;^UTILITY(U,$J,358.3,8639,0)
 ;;=99024^^40^466^12^^^^1
 ;;^UTILITY(U,$J,358.3,8639,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8639,1,2,0)
 ;;=2^Postop Follow-Up Visit
 ;;^UTILITY(U,$J,358.3,8639,1,3,0)
 ;;=3^99024
 ;;^UTILITY(U,$J,358.3,8640,0)
 ;;=65430^^40^467^6^^^^1
 ;;^UTILITY(U,$J,358.3,8640,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8640,1,2,0)
 ;;=2^Corneal Scrape* (dx culture)
 ;;^UTILITY(U,$J,358.3,8640,1,3,0)
 ;;=3^65430
 ;;^UTILITY(U,$J,358.3,8641,0)
 ;;=92285^^40^467^10^^^^1
 ;;^UTILITY(U,$J,358.3,8641,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8641,1,2,0)
 ;;=2^External Eye Photography
 ;;^UTILITY(U,$J,358.3,8641,1,3,0)
 ;;=3^92285
 ;;^UTILITY(U,$J,358.3,8642,0)
 ;;=92225^^40^467^9^^^^1
 ;;^UTILITY(U,$J,358.3,8642,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8642,1,2,0)
 ;;=2^Extended Ophthalmoscopy,Initial
 ;;^UTILITY(U,$J,358.3,8642,1,3,0)
 ;;=3^92225
 ;;^UTILITY(U,$J,358.3,8643,0)
 ;;=92235^^40^467^11^^^^1
 ;;^UTILITY(U,$J,358.3,8643,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8643,1,2,0)
 ;;=2^Fluorescein Angio
 ;;^UTILITY(U,$J,358.3,8643,1,3,0)
 ;;=3^92235
 ;;^UTILITY(U,$J,358.3,8644,0)
 ;;=92250^^40^467^12^^^^1
 ;;^UTILITY(U,$J,358.3,8644,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8644,1,2,0)
 ;;=2^Fundus Photography
 ;;^UTILITY(U,$J,358.3,8644,1,3,0)
 ;;=3^92250
 ;;^UTILITY(U,$J,358.3,8645,0)
 ;;=92020^^40^467^14^^^^1
 ;;^UTILITY(U,$J,358.3,8645,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8645,1,2,0)
 ;;=2^Gonioscopy
 ;;^UTILITY(U,$J,358.3,8645,1,3,0)
 ;;=3^92020
 ;;^UTILITY(U,$J,358.3,8646,0)
 ;;=92081^^40^467^23^^^^1
 ;;^UTILITY(U,$J,358.3,8646,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8646,1,2,0)
 ;;=2^Visual Field - Screening
 ;;^UTILITY(U,$J,358.3,8646,1,3,0)
 ;;=3^92081
 ;;^UTILITY(U,$J,358.3,8647,0)
 ;;=92082^^40^467^22^^^^1
 ;;^UTILITY(U,$J,358.3,8647,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8647,1,2,0)
 ;;=2^Visual Field - Intermediate
 ;;^UTILITY(U,$J,358.3,8647,1,3,0)
 ;;=3^92082
 ;;^UTILITY(U,$J,358.3,8648,0)
 ;;=92083^^40^467^24^^^^1
 ;;^UTILITY(U,$J,358.3,8648,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8648,1,2,0)
 ;;=2^Visual Field - Threshold
 ;;^UTILITY(U,$J,358.3,8648,1,3,0)
 ;;=3^92083
 ;;^UTILITY(U,$J,358.3,8649,0)
 ;;=92100^^40^467^21^^^^1
