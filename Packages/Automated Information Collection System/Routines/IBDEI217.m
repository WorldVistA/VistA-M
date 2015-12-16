IBDEI217 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35505,1,3,0)
 ;;=3^Dysphagia, unspecified
 ;;^UTILITY(U,$J,358.3,35505,1,4,0)
 ;;=4^R13.10
 ;;^UTILITY(U,$J,358.3,35505,2)
 ;;=^335307
 ;;^UTILITY(U,$J,358.3,35506,0)
 ;;=R19.11^^188^2045^2
 ;;^UTILITY(U,$J,358.3,35506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35506,1,3,0)
 ;;=3^Absent bowel sounds
 ;;^UTILITY(U,$J,358.3,35506,1,4,0)
 ;;=4^R19.11
 ;;^UTILITY(U,$J,358.3,35506,2)
 ;;=^5019262
 ;;^UTILITY(U,$J,358.3,35507,0)
 ;;=R19.7^^188^2045^15
 ;;^UTILITY(U,$J,358.3,35507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35507,1,3,0)
 ;;=3^Diarrhea, unspecified
 ;;^UTILITY(U,$J,358.3,35507,1,4,0)
 ;;=4^R19.7
 ;;^UTILITY(U,$J,358.3,35507,2)
 ;;=^5019276
 ;;^UTILITY(U,$J,358.3,35508,0)
 ;;=G47.30^^188^2045^38
 ;;^UTILITY(U,$J,358.3,35508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35508,1,3,0)
 ;;=3^Sleep apnea, unspecified
 ;;^UTILITY(U,$J,358.3,35508,1,4,0)
 ;;=4^G47.30
 ;;^UTILITY(U,$J,358.3,35508,2)
 ;;=^5003977
 ;;^UTILITY(U,$J,358.3,35509,0)
 ;;=G47.31^^188^2045^36
 ;;^UTILITY(U,$J,358.3,35509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35509,1,3,0)
 ;;=3^Primary central sleep apnea
 ;;^UTILITY(U,$J,358.3,35509,1,4,0)
 ;;=4^G47.31
 ;;^UTILITY(U,$J,358.3,35509,2)
 ;;=^332761
 ;;^UTILITY(U,$J,358.3,35510,0)
 ;;=G47.33^^188^2045^33
 ;;^UTILITY(U,$J,358.3,35510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35510,1,3,0)
 ;;=3^Obstructive sleep apnea (adult) (pediatric)
 ;;^UTILITY(U,$J,358.3,35510,1,4,0)
 ;;=4^G47.33
 ;;^UTILITY(U,$J,358.3,35510,2)
 ;;=^332763
 ;;^UTILITY(U,$J,358.3,35511,0)
 ;;=R10.84^^188^2045^21
 ;;^UTILITY(U,$J,358.3,35511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35511,1,3,0)
 ;;=3^Generalized abdominal pain
 ;;^UTILITY(U,$J,358.3,35511,1,4,0)
 ;;=4^R10.84
 ;;^UTILITY(U,$J,358.3,35511,2)
 ;;=^5019229
 ;;^UTILITY(U,$J,358.3,35512,0)
 ;;=Z48.01^^188^2046^1
 ;;^UTILITY(U,$J,358.3,35512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35512,1,3,0)
 ;;=3^Change or removal of surgical wound dressing
 ;;^UTILITY(U,$J,358.3,35512,1,4,0)
 ;;=4^Z48.01
 ;;^UTILITY(U,$J,358.3,35512,2)
 ;;=^5063034
 ;;^UTILITY(U,$J,358.3,35513,0)
 ;;=Z48.02^^188^2046^3
 ;;^UTILITY(U,$J,358.3,35513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35513,1,3,0)
 ;;=3^Removal of sutures
 ;;^UTILITY(U,$J,358.3,35513,1,4,0)
 ;;=4^Z48.02
 ;;^UTILITY(U,$J,358.3,35513,2)
 ;;=^5063035
 ;;^UTILITY(U,$J,358.3,35514,0)
 ;;=Z09.^^188^2046^2
 ;;^UTILITY(U,$J,358.3,35514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35514,1,3,0)
 ;;=3^F/U exam aft trtmt for cond oth than malig neoplm
 ;;^UTILITY(U,$J,358.3,35514,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,35514,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,35515,0)
 ;;=K91.3^^188^2047^6
 ;;^UTILITY(U,$J,358.3,35515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35515,1,3,0)
 ;;=3^Postprocedural intestinal obstruction
 ;;^UTILITY(U,$J,358.3,35515,1,4,0)
 ;;=4^K91.3
 ;;^UTILITY(U,$J,358.3,35515,2)
 ;;=^5008902
 ;;^UTILITY(U,$J,358.3,35516,0)
 ;;=J95.830^^188^2047^5
 ;;^UTILITY(U,$J,358.3,35516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35516,1,3,0)
 ;;=3^Postproc hemor/hemtom of a resp sys org fol a resp sys proc
 ;;^UTILITY(U,$J,358.3,35516,1,4,0)
 ;;=4^J95.830
 ;;^UTILITY(U,$J,358.3,35516,2)
 ;;=^5008340
 ;;^UTILITY(U,$J,358.3,35517,0)
 ;;=T88.8XXA^^188^2047^2
 ;;^UTILITY(U,$J,358.3,35517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35517,1,3,0)
 ;;=3^Complications of surgical and medical care, NEC, init
 ;;^UTILITY(U,$J,358.3,35517,1,4,0)
 ;;=4^T88.8XXA
 ;;^UTILITY(U,$J,358.3,35517,2)
 ;;=^5055814
 ;;^UTILITY(U,$J,358.3,35518,0)
 ;;=T81.31XA^^188^2047^3
