IBDEI1VD ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31289,0)
 ;;=97537^^136^1394^13^^^^1
 ;;^UTILITY(U,$J,358.3,31289,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31289,1,2,0)
 ;;=2^97537
 ;;^UTILITY(U,$J,358.3,31289,1,3,0)
 ;;=3^COMMUNITY/WORK REINTEGRATION EA 15MIN
 ;;^UTILITY(U,$J,358.3,31290,0)
 ;;=97545^^136^1394^48^^^^1
 ;;^UTILITY(U,$J,358.3,31290,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31290,1,2,0)
 ;;=2^97545
 ;;^UTILITY(U,$J,358.3,31290,1,3,0)
 ;;=3^WORK HARDENING CONDITIONING,2 HRS
 ;;^UTILITY(U,$J,358.3,31291,0)
 ;;=97546^^136^1394^49^^^^1
 ;;^UTILITY(U,$J,358.3,31291,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31291,1,2,0)
 ;;=2^97546
 ;;^UTILITY(U,$J,358.3,31291,1,3,0)
 ;;=3^WORK HARDENING CONDITIONING,EA ADD HR
 ;;^UTILITY(U,$J,358.3,31292,0)
 ;;=90899^^136^1394^32^^^^1
 ;;^UTILITY(U,$J,358.3,31292,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31292,1,2,0)
 ;;=2^90899
 ;;^UTILITY(U,$J,358.3,31292,1,3,0)
 ;;=3^OTHER PSYCH SERVICE/PROCEDURE
 ;;^UTILITY(U,$J,358.3,31293,0)
 ;;=H0004^^136^1394^20^^^^1
 ;;^UTILITY(U,$J,358.3,31293,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31293,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,31293,1,3,0)
 ;;=3^INDIV COUNSELING & THERAPY,EA 15MIN
 ;;^UTILITY(U,$J,358.3,31294,0)
 ;;=H0005^^136^1394^3^^^^1
 ;;^UTILITY(U,$J,358.3,31294,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31294,1,2,0)
 ;;=2^H0005
 ;;^UTILITY(U,$J,358.3,31294,1,3,0)
 ;;=3^ADDICTIONS GRP COUNSEL BY CLINICIAN
 ;;^UTILITY(U,$J,358.3,31295,0)
 ;;=H0031^^136^1394^24^^^^1
 ;;^UTILITY(U,$J,358.3,31295,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31295,1,2,0)
 ;;=2^H0031
 ;;^UTILITY(U,$J,358.3,31295,1,3,0)
 ;;=3^MH ASSESS BY NON-PHYS
 ;;^UTILITY(U,$J,358.3,31296,0)
 ;;=H0034^^136^1394^23^^^^1
 ;;^UTILITY(U,$J,358.3,31296,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31296,1,2,0)
 ;;=2^H0034
 ;;^UTILITY(U,$J,358.3,31296,1,3,0)
 ;;=3^MED TRAINING/SUPPORT,EA 15 MIN
 ;;^UTILITY(U,$J,358.3,31297,0)
 ;;=H0046^^136^1394^39^^^^1
 ;;^UTILITY(U,$J,358.3,31297,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31297,1,2,0)
 ;;=2^H0046
 ;;^UTILITY(U,$J,358.3,31297,1,3,0)
 ;;=3^PTSD GRP/MH SVCE NOS
 ;;^UTILITY(U,$J,358.3,31298,0)
 ;;=H0048^^136^1394^47^^^^1
 ;;^UTILITY(U,$J,358.3,31298,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31298,1,2,0)
 ;;=2^H0048
 ;;^UTILITY(U,$J,358.3,31298,1,3,0)
 ;;=3^URINE COLLECTION AND HANDLING
 ;;^UTILITY(U,$J,358.3,31299,0)
 ;;=H0025^^136^1394^2^^^^1
 ;;^UTILITY(U,$J,358.3,31299,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31299,1,2,0)
 ;;=2^H0025
 ;;^UTILITY(U,$J,358.3,31299,1,3,0)
 ;;=3^ADDICTION HLTH PREVENTION EDUC SERVICE
 ;;^UTILITY(U,$J,358.3,31300,0)
 ;;=H0015^^136^1394^4^^^^1
 ;;^UTILITY(U,$J,358.3,31300,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31300,1,2,0)
 ;;=2^H0015
 ;;^UTILITY(U,$J,358.3,31300,1,3,0)
 ;;=3^ALCOH AND/OR DRUG SVCS;INTEN OPT TX,PER DAY
 ;;^UTILITY(U,$J,358.3,31301,0)
 ;;=G0176^^136^1394^1^^^^1
 ;;^UTILITY(U,$J,358.3,31301,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31301,1,2,0)
 ;;=2^G0176
 ;;^UTILITY(U,$J,358.3,31301,1,3,0)
 ;;=3^ACTIVITY TX R/T CARE & TX OF DISABILING MH PROBLEMS,45+ MIN
 ;;^UTILITY(U,$J,358.3,31302,0)
 ;;=G0177^^136^1394^25^^^^1
 ;;^UTILITY(U,$J,358.3,31302,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31302,1,2,0)
 ;;=2^G0177
 ;;^UTILITY(U,$J,358.3,31302,1,3,0)
 ;;=3^MH EDUC & TRAIN SVCS R/T CARE & TX OF DISABILING MH PROBLEM,45+ MIN
 ;;^UTILITY(U,$J,358.3,31303,0)
 ;;=Q3014^^136^1394^43^^^^1
 ;;^UTILITY(U,$J,358.3,31303,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31303,1,2,0)
 ;;=2^Q3014
 ;;^UTILITY(U,$J,358.3,31303,1,3,0)
 ;;=3^TELEHEALTH FACILITY FEE
