IBDEI2D3 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40051,1,4,0)
 ;;=4^D61.89
 ;;^UTILITY(U,$J,358.3,40051,2)
 ;;=^5002341
 ;;^UTILITY(U,$J,358.3,40052,0)
 ;;=K40.90^^156^1948^3
 ;;^UTILITY(U,$J,358.3,40052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40052,1,3,0)
 ;;=3^Unil inguinal hernia w/o obstruction or gangrene
 ;;^UTILITY(U,$J,358.3,40052,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,40052,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,40053,0)
 ;;=K42.9^^156^1948^2
 ;;^UTILITY(U,$J,358.3,40053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40053,1,3,0)
 ;;=3^Umbilical hernia w/o obstruction or gangrene
 ;;^UTILITY(U,$J,358.3,40053,1,4,0)
 ;;=4^K42.9
 ;;^UTILITY(U,$J,358.3,40053,2)
 ;;=^5008606
 ;;^UTILITY(U,$J,358.3,40054,0)
 ;;=K43.9^^156^1948^4
 ;;^UTILITY(U,$J,358.3,40054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40054,1,3,0)
 ;;=3^Ventral hernia w/o obstruction or gangrene
 ;;^UTILITY(U,$J,358.3,40054,1,4,0)
 ;;=4^K43.9
 ;;^UTILITY(U,$J,358.3,40054,2)
 ;;=^5008615
 ;;^UTILITY(U,$J,358.3,40055,0)
 ;;=K43.2^^156^1948^1
 ;;^UTILITY(U,$J,358.3,40055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40055,1,3,0)
 ;;=3^Incisional hernia w/o obstruction or gangrene
 ;;^UTILITY(U,$J,358.3,40055,1,4,0)
 ;;=4^K43.2
 ;;^UTILITY(U,$J,358.3,40055,2)
 ;;=^5008609
 ;;^UTILITY(U,$J,358.3,40056,0)
 ;;=N17.0^^156^1949^1
 ;;^UTILITY(U,$J,358.3,40056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40056,1,3,0)
 ;;=3^Acute kidney failure with tubular necrosis
 ;;^UTILITY(U,$J,358.3,40056,1,4,0)
 ;;=4^N17.0
 ;;^UTILITY(U,$J,358.3,40056,2)
 ;;=^5015598
 ;;^UTILITY(U,$J,358.3,40057,0)
 ;;=N18.9^^156^1949^2
 ;;^UTILITY(U,$J,358.3,40057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40057,1,3,0)
 ;;=3^Chronic kidney disease, unspecified
 ;;^UTILITY(U,$J,358.3,40057,1,4,0)
 ;;=4^N18.9
 ;;^UTILITY(U,$J,358.3,40057,2)
 ;;=^332812
 ;;^UTILITY(U,$J,358.3,40058,0)
 ;;=N19.^^156^1949^4
 ;;^UTILITY(U,$J,358.3,40058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40058,1,3,0)
 ;;=3^Kidney failure,Unspec
 ;;^UTILITY(U,$J,358.3,40058,1,4,0)
 ;;=4^N19.
 ;;^UTILITY(U,$J,358.3,40058,2)
 ;;=^5015607
 ;;^UTILITY(U,$J,358.3,40059,0)
 ;;=Z94.0^^156^1949^5
 ;;^UTILITY(U,$J,358.3,40059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40059,1,3,0)
 ;;=3^Kidney transplant status
 ;;^UTILITY(U,$J,358.3,40059,1,4,0)
 ;;=4^Z94.0
 ;;^UTILITY(U,$J,358.3,40059,2)
 ;;=^5063654
 ;;^UTILITY(U,$J,358.3,40060,0)
 ;;=Q61.2^^156^1949^8
 ;;^UTILITY(U,$J,358.3,40060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40060,1,3,0)
 ;;=3^Polycystic kidney, adult type
 ;;^UTILITY(U,$J,358.3,40060,1,4,0)
 ;;=4^Q61.2
 ;;^UTILITY(U,$J,358.3,40060,2)
 ;;=^5018796
 ;;^UTILITY(U,$J,358.3,40061,0)
 ;;=Q61.3^^156^1949^10
 ;;^UTILITY(U,$J,358.3,40061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40061,1,3,0)
 ;;=3^Polycystic kidney, unspecified
 ;;^UTILITY(U,$J,358.3,40061,1,4,0)
 ;;=4^Q61.3
 ;;^UTILITY(U,$J,358.3,40061,2)
 ;;=^5018797
 ;;^UTILITY(U,$J,358.3,40062,0)
 ;;=Q61.19^^156^1949^9
 ;;^UTILITY(U,$J,358.3,40062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40062,1,3,0)
 ;;=3^Polycystic kidney, infantile type, other
 ;;^UTILITY(U,$J,358.3,40062,1,4,0)
 ;;=4^Q61.19
 ;;^UTILITY(U,$J,358.3,40062,2)
 ;;=^5018795
 ;;^UTILITY(U,$J,358.3,40063,0)
 ;;=C64.1^^156^1949^7
 ;;^UTILITY(U,$J,358.3,40063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40063,1,3,0)
 ;;=3^Malignant neoplasm of right kidney, except renal pelvis
 ;;^UTILITY(U,$J,358.3,40063,1,4,0)
 ;;=4^C64.1
 ;;^UTILITY(U,$J,358.3,40063,2)
 ;;=^5001248
 ;;^UTILITY(U,$J,358.3,40064,0)
 ;;=C64.2^^156^1949^6
 ;;^UTILITY(U,$J,358.3,40064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40064,1,3,0)
 ;;=3^Malignant neoplasm of left kidney, except renal pelvis
