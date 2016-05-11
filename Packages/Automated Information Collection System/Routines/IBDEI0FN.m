IBDEI0FN ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7220,1,3,0)
 ;;=3^Female Genital Organs/Menstrual Cycle,Oth Cond
 ;;^UTILITY(U,$J,358.3,7220,1,4,0)
 ;;=4^N94.89
 ;;^UTILITY(U,$J,358.3,7220,2)
 ;;=^5015925
 ;;^UTILITY(U,$J,358.3,7221,0)
 ;;=N23.^^30^404^18
 ;;^UTILITY(U,$J,358.3,7221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7221,1,3,0)
 ;;=3^Renal Colic,Unspec
 ;;^UTILITY(U,$J,358.3,7221,1,4,0)
 ;;=4^N23.
 ;;^UTILITY(U,$J,358.3,7221,2)
 ;;=^5015615
 ;;^UTILITY(U,$J,358.3,7222,0)
 ;;=Z71.89^^30^405^1
 ;;^UTILITY(U,$J,358.3,7222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7222,1,3,0)
 ;;=3^Activity/Exercise Counseling
 ;;^UTILITY(U,$J,358.3,7222,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,7222,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,7223,0)
 ;;=Z13.89^^30^405^2
 ;;^UTILITY(U,$J,358.3,7223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7223,1,3,0)
 ;;=3^Alcohol Use Screen
 ;;^UTILITY(U,$J,358.3,7223,1,4,0)
 ;;=4^Z13.89
 ;;^UTILITY(U,$J,358.3,7223,2)
 ;;=^5062720
 ;;^UTILITY(U,$J,358.3,7224,0)
 ;;=Z12.39^^30^405^3
 ;;^UTILITY(U,$J,358.3,7224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7224,1,3,0)
 ;;=3^Breast Malignant Neoplasm Screen
 ;;^UTILITY(U,$J,358.3,7224,1,4,0)
 ;;=4^Z12.39
 ;;^UTILITY(U,$J,358.3,7224,2)
 ;;=^5062686
 ;;^UTILITY(U,$J,358.3,7225,0)
 ;;=Z12.4^^30^405^5
 ;;^UTILITY(U,$J,358.3,7225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7225,1,3,0)
 ;;=3^Cervix Malignant Neoplasm Screen
 ;;^UTILITY(U,$J,358.3,7225,1,4,0)
 ;;=4^Z12.4
 ;;^UTILITY(U,$J,358.3,7225,2)
 ;;=^5062687
 ;;^UTILITY(U,$J,358.3,7226,0)
 ;;=Z13.5^^30^405^8
 ;;^UTILITY(U,$J,358.3,7226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7226,1,3,0)
 ;;=3^Eye and Ear Disorder Screen
 ;;^UTILITY(U,$J,358.3,7226,1,4,0)
 ;;=4^Z13.5
 ;;^UTILITY(U,$J,358.3,7226,2)
 ;;=^5062706
 ;;^UTILITY(U,$J,358.3,7227,0)
 ;;=Z01.89^^30^405^6
 ;;^UTILITY(U,$J,358.3,7227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7227,1,3,0)
 ;;=3^Diabetic Foot Exam
 ;;^UTILITY(U,$J,358.3,7227,1,4,0)
 ;;=4^Z01.89
 ;;^UTILITY(U,$J,358.3,7227,2)
 ;;=^5062632
 ;;^UTILITY(U,$J,358.3,7228,0)
 ;;=Z11.59^^30^405^16
 ;;^UTILITY(U,$J,358.3,7228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7228,1,3,0)
 ;;=3^Viral Diseases Screen
 ;;^UTILITY(U,$J,358.3,7228,1,4,0)
 ;;=4^Z11.59
 ;;^UTILITY(U,$J,358.3,7228,2)
 ;;=^5062675
 ;;^UTILITY(U,$J,358.3,7229,0)
 ;;=Z13.6^^30^405^4
 ;;^UTILITY(U,$J,358.3,7229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7229,1,3,0)
 ;;=3^Cardiovascular Disorder Screen
 ;;^UTILITY(U,$J,358.3,7229,1,4,0)
 ;;=4^Z13.6
 ;;^UTILITY(U,$J,358.3,7229,2)
 ;;=^5062707
 ;;^UTILITY(U,$J,358.3,7230,0)
 ;;=Z12.12^^30^405^14
 ;;^UTILITY(U,$J,358.3,7230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7230,1,3,0)
 ;;=3^Rectum Malignant Neoplasm Screen
 ;;^UTILITY(U,$J,358.3,7230,1,4,0)
 ;;=4^Z12.12
 ;;^UTILITY(U,$J,358.3,7230,2)
 ;;=^5062682
 ;;^UTILITY(U,$J,358.3,7231,0)
 ;;=Z71.89^^30^405^12
 ;;^UTILITY(U,$J,358.3,7231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7231,1,3,0)
 ;;=3^Other Specified Counseling
 ;;^UTILITY(U,$J,358.3,7231,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,7231,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,7232,0)
 ;;=Z12.5^^30^405^13
 ;;^UTILITY(U,$J,358.3,7232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7232,1,3,0)
 ;;=3^Prostate Malignant Neoplasm Screen
 ;;^UTILITY(U,$J,358.3,7232,1,4,0)
 ;;=4^Z12.5
 ;;^UTILITY(U,$J,358.3,7232,2)
 ;;=^5062688
 ;;^UTILITY(U,$J,358.3,7233,0)
 ;;=Z00.00^^30^405^9
 ;;^UTILITY(U,$J,358.3,7233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7233,1,3,0)
 ;;=3^General Adult Medical Exam w/o Abnormal Findings
