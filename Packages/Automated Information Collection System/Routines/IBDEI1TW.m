IBDEI1TW ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32626,1,4,0)
 ;;=4^S56.512A
 ;;^UTILITY(U,$J,358.3,32626,2)
 ;;=^5031841
 ;;^UTILITY(U,$J,358.3,32627,0)
 ;;=S13.8XXA^^190^1956^10
 ;;^UTILITY(U,$J,358.3,32627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32627,1,3,0)
 ;;=3^Sprain of Neck Joints/Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,32627,1,4,0)
 ;;=4^S13.8XXA
 ;;^UTILITY(U,$J,358.3,32627,2)
 ;;=^5022034
 ;;^UTILITY(U,$J,358.3,32628,0)
 ;;=S13.8XXD^^190^1956^11
 ;;^UTILITY(U,$J,358.3,32628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32628,1,3,0)
 ;;=3^Sprain of Neck Joints/Ligaments,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32628,1,4,0)
 ;;=4^S13.8XXD
 ;;^UTILITY(U,$J,358.3,32628,2)
 ;;=^5022035
 ;;^UTILITY(U,$J,358.3,32629,0)
 ;;=S16.1XXA^^190^1956^37
 ;;^UTILITY(U,$J,358.3,32629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32629,1,3,0)
 ;;=3^Strain of Neck Muscle/Fasc/Tendon,Init Encntr
 ;;^UTILITY(U,$J,358.3,32629,1,4,0)
 ;;=4^S16.1XXA
 ;;^UTILITY(U,$J,358.3,32629,2)
 ;;=^5022358
 ;;^UTILITY(U,$J,358.3,32630,0)
 ;;=S16.1XXD^^190^1956^38
 ;;^UTILITY(U,$J,358.3,32630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32630,1,3,0)
 ;;=3^Strain of Neck Muscle/Fasc/Tendon,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32630,1,4,0)
 ;;=4^S16.1XXD
 ;;^UTILITY(U,$J,358.3,32630,2)
 ;;=^5022359
 ;;^UTILITY(U,$J,358.3,32631,0)
 ;;=S33.5XXA^^190^1956^8
 ;;^UTILITY(U,$J,358.3,32631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32631,1,3,0)
 ;;=3^Sprain of Lumbar Spine Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,32631,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,32631,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,32632,0)
 ;;=S33.5XXD^^190^1956^9
 ;;^UTILITY(U,$J,358.3,32632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32632,1,3,0)
 ;;=3^Sprain of Lumbar Spine Ligaments,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32632,1,4,0)
 ;;=4^S33.5XXD
 ;;^UTILITY(U,$J,358.3,32632,2)
 ;;=^5025173
 ;;^UTILITY(U,$J,358.3,32633,0)
 ;;=F10.20^^190^1957^4
 ;;^UTILITY(U,$J,358.3,32633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32633,1,3,0)
 ;;=3^Alcohol Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,32633,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,32633,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,32634,0)
 ;;=F11.29^^190^1957^46
 ;;^UTILITY(U,$J,358.3,32634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32634,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,32634,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,32634,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,32635,0)
 ;;=F11.288^^190^1957^45
 ;;^UTILITY(U,$J,358.3,32635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32635,1,3,0)
 ;;=3^Opioid Dependence w/ Other Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,32635,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,32635,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,32636,0)
 ;;=F11.282^^190^1957^44
 ;;^UTILITY(U,$J,358.3,32636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32636,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,32636,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,32636,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,32637,0)
 ;;=F11.281^^190^1957^43
 ;;^UTILITY(U,$J,358.3,32637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32637,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,32637,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,32637,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,32638,0)
 ;;=F11.259^^190^1957^42
 ;;^UTILITY(U,$J,358.3,32638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32638,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,32638,1,4,0)
 ;;=4^F11.259
