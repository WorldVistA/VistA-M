IBDEI0F0 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6915,1,3,0)
 ;;=3^Alcoholic Fatty Liver
 ;;^UTILITY(U,$J,358.3,6915,1,4,0)
 ;;=4^K70.0
 ;;^UTILITY(U,$J,358.3,6915,2)
 ;;=^5008784
 ;;^UTILITY(U,$J,358.3,6916,0)
 ;;=K70.11^^30^399^7
 ;;^UTILITY(U,$J,358.3,6916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6916,1,3,0)
 ;;=3^Alcoholic Hepatitis w/ Ascites
 ;;^UTILITY(U,$J,358.3,6916,1,4,0)
 ;;=4^K70.11
 ;;^UTILITY(U,$J,358.3,6916,2)
 ;;=^5008786
 ;;^UTILITY(U,$J,358.3,6917,0)
 ;;=K70.10^^30^399^8
 ;;^UTILITY(U,$J,358.3,6917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6917,1,3,0)
 ;;=3^Alcoholic Hepatitis w/o Ascites
 ;;^UTILITY(U,$J,358.3,6917,1,4,0)
 ;;=4^K70.10
 ;;^UTILITY(U,$J,358.3,6917,2)
 ;;=^5008785
 ;;^UTILITY(U,$J,358.3,6918,0)
 ;;=K70.2^^30^399^4
 ;;^UTILITY(U,$J,358.3,6918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6918,1,3,0)
 ;;=3^Alcoholic Fibrosis & Sclerosis of Liver
 ;;^UTILITY(U,$J,358.3,6918,1,4,0)
 ;;=4^K70.2
 ;;^UTILITY(U,$J,358.3,6918,2)
 ;;=^5008787
 ;;^UTILITY(U,$J,358.3,6919,0)
 ;;=K70.30^^30^399^2
 ;;^UTILITY(U,$J,358.3,6919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6919,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/o Ascites
 ;;^UTILITY(U,$J,358.3,6919,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,6919,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,6920,0)
 ;;=K70.31^^30^399^1
 ;;^UTILITY(U,$J,358.3,6920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6920,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/ Ascites
 ;;^UTILITY(U,$J,358.3,6920,1,4,0)
 ;;=4^K70.31
 ;;^UTILITY(U,$J,358.3,6920,2)
 ;;=^5008789
 ;;^UTILITY(U,$J,358.3,6921,0)
 ;;=K70.9^^30^399^9
 ;;^UTILITY(U,$J,358.3,6921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6921,1,3,0)
 ;;=3^Alcoholic Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,6921,1,4,0)
 ;;=4^K70.9
 ;;^UTILITY(U,$J,358.3,6921,2)
 ;;=^5008792
 ;;^UTILITY(U,$J,358.3,6922,0)
 ;;=K70.40^^30^399^6
 ;;^UTILITY(U,$J,358.3,6922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6922,1,3,0)
 ;;=3^Alcoholic Hepatic Failure w/o Coma
 ;;^UTILITY(U,$J,358.3,6922,1,4,0)
 ;;=4^K70.40
 ;;^UTILITY(U,$J,358.3,6922,2)
 ;;=^5008790
 ;;^UTILITY(U,$J,358.3,6923,0)
 ;;=K70.41^^30^399^5
 ;;^UTILITY(U,$J,358.3,6923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6923,1,3,0)
 ;;=3^Alcoholic Hepatic Failure w/ Coma
 ;;^UTILITY(U,$J,358.3,6923,1,4,0)
 ;;=4^K70.41
 ;;^UTILITY(U,$J,358.3,6923,2)
 ;;=^5008791
 ;;^UTILITY(U,$J,358.3,6924,0)
 ;;=K73.0^^30^399^15
 ;;^UTILITY(U,$J,358.3,6924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6924,1,3,0)
 ;;=3^Hepatitis, Chronic Persistent NEC
 ;;^UTILITY(U,$J,358.3,6924,1,4,0)
 ;;=4^K73.0
 ;;^UTILITY(U,$J,358.3,6924,2)
 ;;=^5008811
 ;;^UTILITY(U,$J,358.3,6925,0)
 ;;=K74.0^^30^399^14
 ;;^UTILITY(U,$J,358.3,6925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6925,1,3,0)
 ;;=3^Hepatic Fibrosis
 ;;^UTILITY(U,$J,358.3,6925,1,4,0)
 ;;=4^K74.0
 ;;^UTILITY(U,$J,358.3,6925,2)
 ;;=^5008816
 ;;^UTILITY(U,$J,358.3,6926,0)
 ;;=K74.69^^30^399^10
 ;;^UTILITY(U,$J,358.3,6926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6926,1,3,0)
 ;;=3^Cirrhosis of Liver,Oth
 ;;^UTILITY(U,$J,358.3,6926,1,4,0)
 ;;=4^K74.69
 ;;^UTILITY(U,$J,358.3,6926,2)
 ;;=^5008823
 ;;^UTILITY(U,$J,358.3,6927,0)
 ;;=K74.60^^30^399^11
 ;;^UTILITY(U,$J,358.3,6927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6927,1,3,0)
 ;;=3^Cirrhosis of Liver,Unspec
 ;;^UTILITY(U,$J,358.3,6927,1,4,0)
 ;;=4^K74.60
 ;;^UTILITY(U,$J,358.3,6927,2)
 ;;=^5008822
 ;;^UTILITY(U,$J,358.3,6928,0)
 ;;=K76.0^^30^399^12
 ;;^UTILITY(U,$J,358.3,6928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6928,1,3,0)
 ;;=3^Fatty Liver NEC
