IBDEI154 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18329,1,2,0)
 ;;=2^G0397
 ;;^UTILITY(U,$J,358.3,18329,1,3,0)
 ;;=3^Alc/Drug Abuse Assm & Intvn > 30min
 ;;^UTILITY(U,$J,358.3,18330,0)
 ;;=G0409^^90^928^14^^^^1
 ;;^UTILITY(U,$J,358.3,18330,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18330,1,2,0)
 ;;=2^G0409
 ;;^UTILITY(U,$J,358.3,18330,1,3,0)
 ;;=3^Psych Svcs by CORF R/T Pt rehab goals,ea 15min
 ;;^UTILITY(U,$J,358.3,18331,0)
 ;;=S9453^^90^928^17^^^^1
 ;;^UTILITY(U,$J,358.3,18331,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18331,1,2,0)
 ;;=2^S9453
 ;;^UTILITY(U,$J,358.3,18331,1,3,0)
 ;;=3^Smoking Cessation Class per session
 ;;^UTILITY(U,$J,358.3,18332,0)
 ;;=96105^^90^928^3^^^^1
 ;;^UTILITY(U,$J,358.3,18332,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18332,1,2,0)
 ;;=2^96105
 ;;^UTILITY(U,$J,358.3,18332,1,3,0)
 ;;=3^Aphasia Assessment by PhD,per hr
 ;;^UTILITY(U,$J,358.3,18333,0)
 ;;=T1016^^90^928^4^^^^1
 ;;^UTILITY(U,$J,358.3,18333,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18333,1,2,0)
 ;;=2^T1016
 ;;^UTILITY(U,$J,358.3,18333,1,3,0)
 ;;=3^Case Management,ea 15 min
 ;;^UTILITY(U,$J,358.3,18334,0)
 ;;=S9484^^90^928^7^^^^1
 ;;^UTILITY(U,$J,358.3,18334,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18334,1,2,0)
 ;;=2^S9484
 ;;^UTILITY(U,$J,358.3,18334,1,3,0)
 ;;=3^Crisis Intervention MH Svc,per hr
 ;;^UTILITY(U,$J,358.3,18335,0)
 ;;=96110^^90^928^8^^^^1
 ;;^UTILITY(U,$J,358.3,18335,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18335,1,2,0)
 ;;=2^96110
 ;;^UTILITY(U,$J,358.3,18335,1,3,0)
 ;;=3^Developmental Screen by PhD w/ Interpret & Rpt
 ;;^UTILITY(U,$J,358.3,18336,0)
 ;;=90882^^90^928^11^^^^1
 ;;^UTILITY(U,$J,358.3,18336,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18336,1,2,0)
 ;;=2^90882
 ;;^UTILITY(U,$J,358.3,18336,1,3,0)
 ;;=3^Envir Intervent w/ Agency/Inst
 ;;^UTILITY(U,$J,358.3,18337,0)
 ;;=90885^^90^928^13^^^^1
 ;;^UTILITY(U,$J,358.3,18337,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18337,1,2,0)
 ;;=2^90885
 ;;^UTILITY(U,$J,358.3,18337,1,3,0)
 ;;=3^Psych Eval of Hosp Records for Med Dx
 ;;^UTILITY(U,$J,358.3,18338,0)
 ;;=H2027^^90^928^15^^^^1
 ;;^UTILITY(U,$J,358.3,18338,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18338,1,2,0)
 ;;=2^H2027
 ;;^UTILITY(U,$J,358.3,18338,1,3,0)
 ;;=3^Psychoed Svc w/ Pt & Fam,ea 15 min
 ;;^UTILITY(U,$J,358.3,18339,0)
 ;;=96112^^90^928^9^^^^1
 ;;^UTILITY(U,$J,358.3,18339,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18339,1,2,0)
 ;;=2^96112
 ;;^UTILITY(U,$J,358.3,18339,1,3,0)
 ;;=3^Dvlpmntl Tst by PhD w/ Int & Rpt,1st Hr
 ;;^UTILITY(U,$J,358.3,18340,0)
 ;;=96113^^90^928^10^^^^1
 ;;^UTILITY(U,$J,358.3,18340,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18340,1,2,0)
 ;;=2^96113
 ;;^UTILITY(U,$J,358.3,18340,1,3,0)
 ;;=3^Dvlpmntl Tst by PhD w/ Int & Rpt,Ea Addl 30min
 ;;^UTILITY(U,$J,358.3,18341,0)
 ;;=97129^^90^928^19^^^^1
 ;;^UTILITY(U,$J,358.3,18341,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18341,1,2,0)
 ;;=2^97129
 ;;^UTILITY(U,$J,358.3,18341,1,3,0)
 ;;=3^Therapeutic Intvn,Cog Func,1st 15 min
 ;;^UTILITY(U,$J,358.3,18342,0)
 ;;=97130^^90^928^20^^^^1
 ;;^UTILITY(U,$J,358.3,18342,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18342,1,2,0)
 ;;=2^97130
 ;;^UTILITY(U,$J,358.3,18342,1,3,0)
 ;;=3^Therapeutic Intvn,Cog Func,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,18343,0)
 ;;=96156^^90^929^1^^^^1
 ;;^UTILITY(U,$J,358.3,18343,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18343,1,2,0)
 ;;=2^96156
 ;;^UTILITY(U,$J,358.3,18343,1,3,0)
 ;;=3^Hlth/Behav Assess/Reassess
