IBDEI0Y0 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15147,1,3,0)
 ;;=3^Constipation,Slow transit
 ;;^UTILITY(U,$J,358.3,15147,1,4,0)
 ;;=4^K59.01
 ;;^UTILITY(U,$J,358.3,15147,2)
 ;;=^323538
 ;;^UTILITY(U,$J,358.3,15148,0)
 ;;=K59.1^^85^841^21
 ;;^UTILITY(U,$J,358.3,15148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15148,1,3,0)
 ;;=3^Diarrhea,Functional
 ;;^UTILITY(U,$J,358.3,15148,1,4,0)
 ;;=4^K59.1
 ;;^UTILITY(U,$J,358.3,15148,2)
 ;;=^270281
 ;;^UTILITY(U,$J,358.3,15149,0)
 ;;=I69.991^^85^841^24
 ;;^UTILITY(U,$J,358.3,15149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15149,1,3,0)
 ;;=3^Dysphagia,Following cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,15149,1,4,0)
 ;;=4^I69.991
 ;;^UTILITY(U,$J,358.3,15149,2)
 ;;=^5007569
 ;;^UTILITY(U,$J,358.3,15150,0)
 ;;=R15.9^^85^841^29
 ;;^UTILITY(U,$J,358.3,15150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15150,1,3,0)
 ;;=3^Fecal incontinence,Full
 ;;^UTILITY(U,$J,358.3,15150,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,15150,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,15151,0)
 ;;=R15.0^^85^841^30
 ;;^UTILITY(U,$J,358.3,15151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15151,1,3,0)
 ;;=3^Fecal incontinence,Incomplete defecation
 ;;^UTILITY(U,$J,358.3,15151,1,4,0)
 ;;=4^R15.0
 ;;^UTILITY(U,$J,358.3,15151,2)
 ;;=^5019244
 ;;^UTILITY(U,$J,358.3,15152,0)
 ;;=R15.1^^85^841^31
 ;;^UTILITY(U,$J,358.3,15152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15152,1,3,0)
 ;;=3^Fecal incontinence,Soiling
 ;;^UTILITY(U,$J,358.3,15152,1,4,0)
 ;;=4^R15.1
 ;;^UTILITY(U,$J,358.3,15152,2)
 ;;=^5019245
 ;;^UTILITY(U,$J,358.3,15153,0)
 ;;=R15.2^^85^841^32
 ;;^UTILITY(U,$J,358.3,15153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15153,1,3,0)
 ;;=3^Fecal incontinence,Urgency
 ;;^UTILITY(U,$J,358.3,15153,1,4,0)
 ;;=4^R15.2
 ;;^UTILITY(U,$J,358.3,15153,2)
 ;;=^5019246
 ;;^UTILITY(U,$J,358.3,15154,0)
 ;;=K30.^^85^841^35
 ;;^UTILITY(U,$J,358.3,15154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15154,1,3,0)
 ;;=3^Functional dyspepsia
 ;;^UTILITY(U,$J,358.3,15154,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,15154,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,15155,0)
 ;;=R19.8^^85^841^38
 ;;^UTILITY(U,$J,358.3,15155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15155,1,3,0)
 ;;=3^Globus sensation
 ;;^UTILITY(U,$J,358.3,15155,1,4,0)
 ;;=4^R19.8
 ;;^UTILITY(U,$J,358.3,15155,2)
 ;;=^5019277
 ;;^UTILITY(U,$J,358.3,15156,0)
 ;;=K90.41^^85^841^39
 ;;^UTILITY(U,$J,358.3,15156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15156,1,3,0)
 ;;=3^Gluten sensitivity (non-celiac)
 ;;^UTILITY(U,$J,358.3,15156,1,4,0)
 ;;=4^K90.41
 ;;^UTILITY(U,$J,358.3,15156,2)
 ;;=^8130335
 ;;^UTILITY(U,$J,358.3,15157,0)
 ;;=K58.1^^85^841^47
 ;;^UTILITY(U,$J,358.3,15157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15157,1,3,0)
 ;;=3^Irritable bowel syndrome w/ Constipation
 ;;^UTILITY(U,$J,358.3,15157,1,4,0)
 ;;=4^K58.1
 ;;^UTILITY(U,$J,358.3,15157,2)
 ;;=^5138741
 ;;^UTILITY(U,$J,358.3,15158,0)
 ;;=K58.0^^85^841^48
 ;;^UTILITY(U,$J,358.3,15158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15158,1,3,0)
 ;;=3^Irritable bowel syndrome w/ Diarrhea
 ;;^UTILITY(U,$J,358.3,15158,1,4,0)
 ;;=4^K58.0
 ;;^UTILITY(U,$J,358.3,15158,2)
 ;;=^5008739
 ;;^UTILITY(U,$J,358.3,15159,0)
 ;;=K58.2^^85^841^49
 ;;^UTILITY(U,$J,358.3,15159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15159,1,3,0)
 ;;=3^Irritable bowel syndrome w/ Mixed
 ;;^UTILITY(U,$J,358.3,15159,1,4,0)
 ;;=4^K58.2
