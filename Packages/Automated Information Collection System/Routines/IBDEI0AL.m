IBDEI0AL ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4431,1,4,0)
 ;;=4^T50.995A
 ;;^UTILITY(U,$J,358.3,4431,2)
 ;;=^5052178
 ;;^UTILITY(U,$J,358.3,4432,0)
 ;;=Z88.9^^30^277^6
 ;;^UTILITY(U,$J,358.3,4432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4432,1,3,0)
 ;;=3^Allergy Status to Unspec Drug/Meds/Bio Subs
 ;;^UTILITY(U,$J,358.3,4432,1,4,0)
 ;;=4^Z88.9
 ;;^UTILITY(U,$J,358.3,4432,2)
 ;;=^5063530
 ;;^UTILITY(U,$J,358.3,4433,0)
 ;;=Z91.19^^30^277^34
 ;;^UTILITY(U,$J,358.3,4433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4433,1,3,0)
 ;;=3^Noncompliance w/ Medical Treatment/Regimen
 ;;^UTILITY(U,$J,358.3,4433,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,4433,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,4434,0)
 ;;=H54.7^^30^277^37
 ;;^UTILITY(U,$J,358.3,4434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4434,1,3,0)
 ;;=3^Visual Loss,Unspec
 ;;^UTILITY(U,$J,358.3,4434,1,4,0)
 ;;=4^H54.7
 ;;^UTILITY(U,$J,358.3,4434,2)
 ;;=^5006368
 ;;^UTILITY(U,$J,358.3,4435,0)
 ;;=Z79.2^^30^277^25
 ;;^UTILITY(U,$J,358.3,4435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4435,1,3,0)
 ;;=3^Long Term (Current) Use of Antibiotics
 ;;^UTILITY(U,$J,358.3,4435,1,4,0)
 ;;=4^Z79.2
 ;;^UTILITY(U,$J,358.3,4435,2)
 ;;=^321546
 ;;^UTILITY(U,$J,358.3,4436,0)
 ;;=Z79.1^^30^277^27
 ;;^UTILITY(U,$J,358.3,4436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4436,1,3,0)
 ;;=3^Long Term (Current) Use of NSAID
 ;;^UTILITY(U,$J,358.3,4436,1,4,0)
 ;;=4^Z79.1
 ;;^UTILITY(U,$J,358.3,4436,2)
 ;;=^5063332
 ;;^UTILITY(U,$J,358.3,4437,0)
 ;;=Z79.52^^30^277^28
 ;;^UTILITY(U,$J,358.3,4437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4437,1,3,0)
 ;;=3^Long Term (Current) Use of Systemic Steroids
 ;;^UTILITY(U,$J,358.3,4437,1,4,0)
 ;;=4^Z79.52
 ;;^UTILITY(U,$J,358.3,4437,2)
 ;;=^5063336
 ;;^UTILITY(U,$J,358.3,4438,0)
 ;;=Z79.82^^30^277^26
 ;;^UTILITY(U,$J,358.3,4438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4438,1,3,0)
 ;;=3^Long Term (Current) Use of Aspirin
 ;;^UTILITY(U,$J,358.3,4438,1,4,0)
 ;;=4^Z79.82
 ;;^UTILITY(U,$J,358.3,4438,2)
 ;;=^5063340
 ;;^UTILITY(U,$J,358.3,4439,0)
 ;;=Z79.899^^30^277^24
 ;;^UTILITY(U,$J,358.3,4439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4439,1,3,0)
 ;;=3^Long Term (Current) Drug Therapy
 ;;^UTILITY(U,$J,358.3,4439,1,4,0)
 ;;=4^Z79.899
 ;;^UTILITY(U,$J,358.3,4439,2)
 ;;=^5063343
 ;;^UTILITY(U,$J,358.3,4440,0)
 ;;=Z71.0^^30^277^20
 ;;^UTILITY(U,$J,358.3,4440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4440,1,3,0)
 ;;=3^Health Services to Consult on Behalf of Another Person
 ;;^UTILITY(U,$J,358.3,4440,1,4,0)
 ;;=4^Z71.0
 ;;^UTILITY(U,$J,358.3,4440,2)
 ;;=^5063242
 ;;^UTILITY(U,$J,358.3,4441,0)
 ;;=Z71.3^^30^277^12
 ;;^UTILITY(U,$J,358.3,4441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4441,1,3,0)
 ;;=3^Dietary Counseling/Surveillance
 ;;^UTILITY(U,$J,358.3,4441,1,4,0)
 ;;=4^Z71.3
 ;;^UTILITY(U,$J,358.3,4441,2)
 ;;=^5063245
 ;;^UTILITY(U,$J,358.3,4442,0)
 ;;=Z71.41^^30^277^5
 ;;^UTILITY(U,$J,358.3,4442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4442,1,3,0)
 ;;=3^Alcohol Abuse Counseling/Surveillance of Alcoholic
 ;;^UTILITY(U,$J,358.3,4442,1,4,0)
 ;;=4^Z71.41
 ;;^UTILITY(U,$J,358.3,4442,2)
 ;;=^5063246
 ;;^UTILITY(U,$J,358.3,4443,0)
 ;;=Z09.^^30^277^17
 ;;^UTILITY(U,$J,358.3,4443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4443,1,3,0)
 ;;=3^F/U Exam After Trtmt for Cond Oth Than Malig Neop
 ;;^UTILITY(U,$J,358.3,4443,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,4443,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,4444,0)
 ;;=Z76.0^^30^277^23
 ;;^UTILITY(U,$J,358.3,4444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4444,1,3,0)
 ;;=3^Issue of Repeat Prescription
