IBDEI0AK ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4418,1,3,0)
 ;;=3^Anemia in Chr Kidney Disease
 ;;^UTILITY(U,$J,358.3,4418,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,4418,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,4419,0)
 ;;=D63.8^^30^277^7
 ;;^UTILITY(U,$J,358.3,4419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4419,1,3,0)
 ;;=3^Anemia in Chr Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,4419,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,4419,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,4420,0)
 ;;=D64.9^^30^277^9
 ;;^UTILITY(U,$J,358.3,4420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4420,1,3,0)
 ;;=3^Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,4420,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,4420,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,4421,0)
 ;;=F52.21^^30^277^29
 ;;^UTILITY(U,$J,358.3,4421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4421,1,3,0)
 ;;=3^Male Erectile Disorder
 ;;^UTILITY(U,$J,358.3,4421,1,4,0)
 ;;=4^F52.21
 ;;^UTILITY(U,$J,358.3,4421,2)
 ;;=^5003620
 ;;^UTILITY(U,$J,358.3,4422,0)
 ;;=F17.200^^30^277^33
 ;;^UTILITY(U,$J,358.3,4422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4422,1,3,0)
 ;;=3^Nicotine Dependence,Unspec
 ;;^UTILITY(U,$J,358.3,4422,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,4422,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,4423,0)
 ;;=F17.210^^30^277^32
 ;;^UTILITY(U,$J,358.3,4423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4423,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes
 ;;^UTILITY(U,$J,358.3,4423,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,4423,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,4424,0)
 ;;=K21.9^^30^277^18
 ;;^UTILITY(U,$J,358.3,4424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4424,1,3,0)
 ;;=3^GERD w/o Esophagitis
 ;;^UTILITY(U,$J,358.3,4424,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,4424,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,4425,0)
 ;;=N18.6^^30^277^13
 ;;^UTILITY(U,$J,358.3,4425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4425,1,3,0)
 ;;=3^ESRD
 ;;^UTILITY(U,$J,358.3,4425,1,4,0)
 ;;=4^N18.6
 ;;^UTILITY(U,$J,358.3,4425,2)
 ;;=^303986
 ;;^UTILITY(U,$J,358.3,4426,0)
 ;;=N40.0^^30^277^15
 ;;^UTILITY(U,$J,358.3,4426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4426,1,3,0)
 ;;=3^Enlarged Prostate w/o Lower Urinary Tract Symptoms
 ;;^UTILITY(U,$J,358.3,4426,1,4,0)
 ;;=4^N40.0
 ;;^UTILITY(U,$J,358.3,4426,2)
 ;;=^5015689
 ;;^UTILITY(U,$J,358.3,4427,0)
 ;;=R82.5^^30^277^14
 ;;^UTILITY(U,$J,358.3,4427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4427,1,3,0)
 ;;=3^Elevated Urine Levels of Drug/Meds/Bio Subst
 ;;^UTILITY(U,$J,358.3,4427,1,4,0)
 ;;=4^R82.5
 ;;^UTILITY(U,$J,358.3,4427,2)
 ;;=^5019605
 ;;^UTILITY(U,$J,358.3,4428,0)
 ;;=R82.6^^30^277^3
 ;;^UTILITY(U,$J,358.3,4428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4428,1,3,0)
 ;;=3^Abnormal Urine Levels of Non-Medicinal Subs
 ;;^UTILITY(U,$J,358.3,4428,1,4,0)
 ;;=4^R82.6
 ;;^UTILITY(U,$J,358.3,4428,2)
 ;;=^5019606
 ;;^UTILITY(U,$J,358.3,4429,0)
 ;;=R89.2^^30^277^1
 ;;^UTILITY(U,$J,358.3,4429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4429,1,3,0)
 ;;=3^Abnormal Drug/Meds/Bio Subs Level in Org/Tiss Specimens
 ;;^UTILITY(U,$J,358.3,4429,1,4,0)
 ;;=4^R89.2
 ;;^UTILITY(U,$J,358.3,4429,2)
 ;;=^5019696
 ;;^UTILITY(U,$J,358.3,4430,0)
 ;;=R89.3^^30^277^2
 ;;^UTILITY(U,$J,358.3,4430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4430,1,3,0)
 ;;=3^Abnormal Non-Medicinal Level in Org/Tiss Specimens
 ;;^UTILITY(U,$J,358.3,4430,1,4,0)
 ;;=4^R89.3
 ;;^UTILITY(U,$J,358.3,4430,2)
 ;;=^5019697
 ;;^UTILITY(U,$J,358.3,4431,0)
 ;;=T50.995A^^30^277^4
 ;;^UTILITY(U,$J,358.3,4431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4431,1,3,0)
 ;;=3^Adverse Effect of Drug/Meds/Bio Subs,Init Encounter
