IBDEI189 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20517,1,3,0)
 ;;=3^Acute Viral Hepatitis C w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,20517,1,4,0)
 ;;=4^B17.10
 ;;^UTILITY(U,$J,358.3,20517,2)
 ;;=^5000542
 ;;^UTILITY(U,$J,358.3,20518,0)
 ;;=B17.11^^97^963^3
 ;;^UTILITY(U,$J,358.3,20518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20518,1,3,0)
 ;;=3^Acute Viral Hepatitis C w/ Hepatic Coma
 ;;^UTILITY(U,$J,358.3,20518,1,4,0)
 ;;=4^B17.11
 ;;^UTILITY(U,$J,358.3,20518,2)
 ;;=^331777
 ;;^UTILITY(U,$J,358.3,20519,0)
 ;;=K70.30^^97^963^6
 ;;^UTILITY(U,$J,358.3,20519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20519,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/o Ascites
 ;;^UTILITY(U,$J,358.3,20519,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,20519,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,20520,0)
 ;;=K70.31^^97^963^5
 ;;^UTILITY(U,$J,358.3,20520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20520,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/ Ascites
 ;;^UTILITY(U,$J,358.3,20520,1,4,0)
 ;;=4^K70.31
 ;;^UTILITY(U,$J,358.3,20520,2)
 ;;=^5008789
 ;;^UTILITY(U,$J,358.3,20521,0)
 ;;=K21.0^^97^963^13
 ;;^UTILITY(U,$J,358.3,20521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20521,1,3,0)
 ;;=3^GERD w/ Esophagitis
 ;;^UTILITY(U,$J,358.3,20521,1,4,0)
 ;;=4^K21.0
 ;;^UTILITY(U,$J,358.3,20521,2)
 ;;=^5008504
 ;;^UTILITY(U,$J,358.3,20522,0)
 ;;=K58.0^^97^963^16
 ;;^UTILITY(U,$J,358.3,20522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20522,1,3,0)
 ;;=3^IBS w/ Diarrhea
 ;;^UTILITY(U,$J,358.3,20522,1,4,0)
 ;;=4^K58.0
 ;;^UTILITY(U,$J,358.3,20522,2)
 ;;=^5008739
 ;;^UTILITY(U,$J,358.3,20523,0)
 ;;=C61.^^97^964^21
 ;;^UTILITY(U,$J,358.3,20523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20523,1,3,0)
 ;;=3^Malig Neop of Prostate
 ;;^UTILITY(U,$J,358.3,20523,1,4,0)
 ;;=4^C61.
 ;;^UTILITY(U,$J,358.3,20523,2)
 ;;=^267239
 ;;^UTILITY(U,$J,358.3,20524,0)
 ;;=N20.0^^97^964^2
 ;;^UTILITY(U,$J,358.3,20524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20524,1,3,0)
 ;;=3^Calculus of Kidney
 ;;^UTILITY(U,$J,358.3,20524,1,4,0)
 ;;=4^N20.0
 ;;^UTILITY(U,$J,358.3,20524,2)
 ;;=^67056
 ;;^UTILITY(U,$J,358.3,20525,0)
 ;;=N39.0^^97^964^28
 ;;^UTILITY(U,$J,358.3,20525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20525,1,3,0)
 ;;=3^UTI,Site Unspec
 ;;^UTILITY(U,$J,358.3,20525,1,4,0)
 ;;=4^N39.0
 ;;^UTILITY(U,$J,358.3,20525,2)
 ;;=^124436
 ;;^UTILITY(U,$J,358.3,20526,0)
 ;;=N40.0^^97^964^12
 ;;^UTILITY(U,$J,358.3,20526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20526,1,3,0)
 ;;=3^Enlarged Prostate w/o Lower Urinary Tract Symptoms
 ;;^UTILITY(U,$J,358.3,20526,1,4,0)
 ;;=4^N40.0
 ;;^UTILITY(U,$J,358.3,20526,2)
 ;;=^5015689
 ;;^UTILITY(U,$J,358.3,20527,0)
 ;;=N40.1^^97^964^11
 ;;^UTILITY(U,$J,358.3,20527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20527,1,3,0)
 ;;=3^Enlarged Prostate w/ Lower Urinary Tract Symptoms
 ;;^UTILITY(U,$J,358.3,20527,1,4,0)
 ;;=4^N40.1
 ;;^UTILITY(U,$J,358.3,20527,2)
 ;;=^5015690
 ;;^UTILITY(U,$J,358.3,20528,0)
 ;;=N40.2^^97^964^24
 ;;^UTILITY(U,$J,358.3,20528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20528,1,3,0)
 ;;=3^Nodular Prostate w/o Lower Urinary Tract Symptoms
 ;;^UTILITY(U,$J,358.3,20528,1,4,0)
 ;;=4^N40.2
 ;;^UTILITY(U,$J,358.3,20528,2)
 ;;=^5015691
 ;;^UTILITY(U,$J,358.3,20529,0)
 ;;=N40.3^^97^964^23
 ;;^UTILITY(U,$J,358.3,20529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20529,1,3,0)
 ;;=3^Nodular Prostate w/ Lower Urinary Tract Symptoms
 ;;^UTILITY(U,$J,358.3,20529,1,4,0)
 ;;=4^N40.3
 ;;^UTILITY(U,$J,358.3,20529,2)
 ;;=^5015692
 ;;^UTILITY(U,$J,358.3,20530,0)
 ;;=N42.83^^97^964^26
