IBDEI1MQ ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29300,1,2,0)
 ;;=2^Carotid Intima Atheroma Eval,Bil
 ;;^UTILITY(U,$J,358.3,29300,1,4,0)
 ;;=4^93895
 ;;^UTILITY(U,$J,358.3,29301,0)
 ;;=93990^^184^1861^1^^^^1
 ;;^UTILITY(U,$J,358.3,29301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29301,1,2,0)
 ;;=2^Duplex Scan of Hemodialysis Access
 ;;^UTILITY(U,$J,358.3,29301,1,4,0)
 ;;=4^93990
 ;;^UTILITY(U,$J,358.3,29302,0)
 ;;=93965^^184^1862^3^^^^1
 ;;^UTILITY(U,$J,358.3,29302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29302,1,2,0)
 ;;=2^Noninvasive Bilateral Study,Complete
 ;;^UTILITY(U,$J,358.3,29302,1,4,0)
 ;;=4^93965
 ;;^UTILITY(U,$J,358.3,29303,0)
 ;;=93970^^184^1862^1^^^^1
 ;;^UTILITY(U,$J,358.3,29303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29303,1,2,0)
 ;;=2^Duplex Scan,Bilateral,Complete
 ;;^UTILITY(U,$J,358.3,29303,1,4,0)
 ;;=4^93970
 ;;^UTILITY(U,$J,358.3,29304,0)
 ;;=93971^^184^1862^2^^^^1
 ;;^UTILITY(U,$J,358.3,29304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29304,1,2,0)
 ;;=2^Duplex Scan,Unilateral or Limited
 ;;^UTILITY(U,$J,358.3,29304,1,4,0)
 ;;=4^93971
 ;;^UTILITY(U,$J,358.3,29305,0)
 ;;=93975^^184^1863^2^^^^1
 ;;^UTILITY(U,$J,358.3,29305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29305,1,2,0)
 ;;=2^Vascular Abdom/Pelvis,Complete
 ;;^UTILITY(U,$J,358.3,29305,1,4,0)
 ;;=4^93975
 ;;^UTILITY(U,$J,358.3,29306,0)
 ;;=93976^^184^1863^3^^^^1
 ;;^UTILITY(U,$J,358.3,29306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29306,1,2,0)
 ;;=2^Vascular Abdom/Pelvis,Limited
 ;;^UTILITY(U,$J,358.3,29306,1,4,0)
 ;;=4^93976
 ;;^UTILITY(U,$J,358.3,29307,0)
 ;;=93978^^184^1863^4^^^^1
 ;;^UTILITY(U,$J,358.3,29307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29307,1,2,0)
 ;;=2^Vascular Aorta/Inferior VC/Iliac,Complete
 ;;^UTILITY(U,$J,358.3,29307,1,4,0)
 ;;=4^93978
 ;;^UTILITY(U,$J,358.3,29308,0)
 ;;=93979^^184^1863^5^^^^1
 ;;^UTILITY(U,$J,358.3,29308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29308,1,2,0)
 ;;=2^Vascular Aorta/Inferior VC/Iliac,Limited
 ;;^UTILITY(U,$J,358.3,29308,1,4,0)
 ;;=4^93979
 ;;^UTILITY(U,$J,358.3,29309,0)
 ;;=93980^^184^1863^6^^^^1
 ;;^UTILITY(U,$J,358.3,29309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29309,1,2,0)
 ;;=2^Vascular Penile,Complete
 ;;^UTILITY(U,$J,358.3,29309,1,4,0)
 ;;=4^93980
 ;;^UTILITY(U,$J,358.3,29310,0)
 ;;=93981^^184^1863^7^^^^1
 ;;^UTILITY(U,$J,358.3,29310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29310,1,2,0)
 ;;=2^Vascular Penile,Limited
 ;;^UTILITY(U,$J,358.3,29310,1,4,0)
 ;;=4^93981
 ;;^UTILITY(U,$J,358.3,29311,0)
 ;;=93982^^184^1863^1^^^^1
 ;;^UTILITY(U,$J,358.3,29311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29311,1,2,0)
 ;;=2^Aneurysm Pressure Sensor Study,Complete
 ;;^UTILITY(U,$J,358.3,29311,1,4,0)
 ;;=4^93982
 ;;^UTILITY(U,$J,358.3,29312,0)
 ;;=93923^^184^1864^6^^^^1
 ;;^UTILITY(U,$J,358.3,29312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29312,1,2,0)
 ;;=2^Noninvasive Bil Upper/Lower Extrem,Complete
 ;;^UTILITY(U,$J,358.3,29312,1,4,0)
 ;;=4^93923
 ;;^UTILITY(U,$J,358.3,29313,0)
 ;;=93924^^184^1864^5^^^^1
 ;;^UTILITY(U,$J,358.3,29313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29313,1,2,0)
 ;;=2^Noninvasive Bil Lower Extrem,Complete
 ;;^UTILITY(U,$J,358.3,29313,1,4,0)
 ;;=4^93924
 ;;^UTILITY(U,$J,358.3,29314,0)
 ;;=93925^^184^1864^1^^^^1
 ;;^UTILITY(U,$J,358.3,29314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29314,1,2,0)
 ;;=2^Duplex Scan Bilat Lower Extrem,Complete
 ;;^UTILITY(U,$J,358.3,29314,1,4,0)
 ;;=4^93925
 ;;^UTILITY(U,$J,358.3,29315,0)
 ;;=93926^^184^1864^3^^^^1
 ;;^UTILITY(U,$J,358.3,29315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29315,1,2,0)
 ;;=2^Duplex Scan Unilat Lower Extrem,Limited
