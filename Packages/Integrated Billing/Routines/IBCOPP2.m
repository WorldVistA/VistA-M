IBCOPP2 ;ALB/NLR - LIST INS. PLANS BY CO. (COMPILE) ; 06-SEP-94
V ;;2.0;INTEGRATED BILLING;**28,62,93**;21-MAR-94
 ;
EN ; Queued Entry Point for Report.
 ;  Required variable input:  IBAI, IBAPL, IBAPA
 ;  ^TMP("IBINC",$J) required if all companies and plans not selected
 ;
 ; - compile report data
 S IBI=0 K ^TMP($J,"PR"),^TMP($J,"PL")
 ;
 ; - user wanted all companies and plans
 I IBAI,IBAPL D  G PRINT
 .S IBIC1="" F  S IBIC1=$O(^DIC(36,"B",IBIC1)) Q:IBIC1=""  D
 ..S IBCNS=0 F  S IBCNS=$O(^DIC(36,"B",IBIC1,IBCNS)) Q:'IBCNS  I $D(^IBA(355.3,"B",IBCNS)) S IBIC=IBIC1 D GATH
 ;
 ; - user selected companies or plans
 S IBIC="" F  S IBIC=$O(^TMP("IBINC",$J,IBIC)) Q:IBIC=""  D
 .S IBCNS=0 F  S IBCNS=$O(^TMP("IBINC",$J,IBIC,IBCNS)) Q:'IBCNS  D GATH
 ;
PRINT ; - print report
 D ^IBCOPP3
 K ^TMP($J,"PR"),^TMP("IBINC",$J)
 ;
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K IBI,IBIC,IBIC1,IBCNS,IBCPT,IBCPS,IBCST,IBCSS
 Q
 ;
 ;
GATH ; Gather all data for a company.
 S IBI=IBI+1,(IBCPT,IBCPS,IBCST,IBCSS)=0 ; initialize counters
 D COMP ; gather company info
 D PLAN ; gather plan info
 ;
 ; - set final company info
 S ^TMP($J,"PR",IBI)=$$COMPINF(IBCNS)_"^"_IBCPT_"^"_IBCST_"^"_IBCPS_"^"_IBCSS
 K ^TMP($J,"PL")
 Q
 ;
 ;
COMP ; Gather Company counts and subscription information, if necessary
 ;  Input:  IBCNS -- Pointer to the insurance company in file #36
 ;         initialized counters, plus the 'Plan' array (^TMP("IBINC",$J))
 ;  
 S DFN=0 F  S DFN=$O(^DPT("AB",IBCNS,DFN)) Q:'DFN  D
 .S IBCDFN=0 F  S IBCDFN=$O(^DPT("AB",IBCNS,DFN,IBCDFN)) Q:'IBCDFN  D
 ..;
 ..; - set company subscriber count; plan subscriber counts if necessary
 ..S IBIND=$G(^DPT(DFN,.312,+IBCDFN,0)) Q:+IBIND'=IBCNS
 ..S IBPTR=+$P(IBIND,"^",18)
 ..S IBCST=IBCST+1
 ..I 'IBAPL,'$D(^TMP("IBINC",$J,IBIC,IBCNS,IBPTR)) Q  ; not a selected plan
 ..S IBCSS=IBCSS+1,^(IBPTR)=$G(^TMP($J,"PL",IBPTR))+1
 ..Q:'IBAPA  ; policy information not selected
 ..;
 ..; - gather demographic/policy information
 ..S X=$$PT^IBEFUNC(DFN)
 ..S IBNAM=$E($S($P(X,"^")]"":$P(X,"^"),1:"<Pt. "_DFN_" Name Missing>")_$J("",25),1,25)_" ("_$E(X)_$P(X,"^",3)_")"
 ..S IBDOB=$$DAT3^IBOUTL($P($G(^DPT(DFN,0)),"^",3))
 ..S IBWI=$P(IBIND,"^",6),IBWI=$S(IBWI="v":"VET",IBWI="s":"SPO",IBWI="o":"OTH",1:"<UNK>")
 ..S VAOA("A")=$S(IBWI="SPO":6,1:5) D OAD^VADPT
 ..;
 ..; - build detail line
 ..S IBX=IBNAM_U_IBDOB_U_$E(VAOA(9),1,18)_U_$S($P(IBIND,"^",2)]"":$E($P(IBIND,"^",2),1,17),1:"<NO SUBS ID>")
 ..S IBX=IBX_U_IBWI_U_$$DAT1^IBOUTL($P(IBIND,"^",8))_U_$$DAT1^IBOUTL($P(IBIND,"^",4))
 ..S X=0,Y="" F  S Y=$O(^IBA(355.5,"APPY",DFN,IBPTR,Y)) Q:Y=""  I $O(^(Y,0))=IBCDFN S X=1 Q
 ..S ^TMP($J,"PR",IBI,IBPTR,IBNAM_"@@"_DFN_"@@"_IBCDFN)=IBX_"^"_X
 ;
 K DFN,IBCDFN,IBIND,IBPTR,IBNAM,IBDOB,IBWI,IBX,X,VAOA,VA,VAERR,Y
 Q
 ;
PLAN ; Gather Insurance Plan information, if necessary
 ;  Input:  IBCNS -- Pointer to the insurance company in file #36
 ;         initialized counters, plus the 'Plan' array (^TMP("IBINC",$J))
 ; 
 S IBPTR=0 F  S IBPTR=$O(^IBA(355.3,"B",IBCNS,IBPTR)) Q:'IBPTR  D
 .S IBCPT=IBCPT+1
 .I 'IBAPL,'$D(^TMP("IBINC",$J,IBIC,IBCNS,IBPTR)) Q  ; not a selected plan
 .S IBCPS=IBCPS+1
 .S ^TMP($J,"PR",IBI,IBPTR)=$$PLANINF(IBPTR)_"^"_+$G(^TMP($J,"PL",IBPTR))
 K IBPTR
 Q
 ;
PLANINF(PLAN) ; Return formatted Insurance Plan information.
 ;  Input:  PLAN  --  Pointer to the plan in file #355.3
 ; Output:  plan number ^ name ^ grp/ind ^ act/inact
 ;
 N ACT,NAME,NUM,TY,X
 S X=$G(^IBA(355.3,PLAN,0))
 S TY=$S($P(X,"^",2):"GRP",1:"IND")
 S NAME=$P(X,"^",3) S:NAME="" NAME="<NO GROUP NAME>"
 S NUM=$P(X,"^",4) S:NUM="" NUM="<NO GROUP NUMBER>"
 S ACT=$S($P(X,"^",11):"IN",1:"")_"ACTIVE"
 Q NUM_"^"_NAME_"^"_TY_"^"_ACT_"^"_$S($D(^IBA(355.4,"APY",PLAN))>0:"YES",1:"NO")_"^"_$S($D(^IBA(355.5,"B",PLAN))>0:"YES",1:"NO")
 ;
COMPINF(IBCNS) ; Return formatted Insurance Company information
 ;  Input:  IBCNS  --  Pointer to the insurance company in file #36
 ; Output:  company name ^ addr ^ city/st/zip ^ phone ^ precert ^ act?
 ;
 N ST,X,X0,X11,X13,Z
 S X0=$G(^DIC(36,IBCNS,0)),X11=$G(^(.11)),X13=$G(^(.13)),Z=$P(X11,"^",6)
 S ST=$S($P(X11,"^",5):$P($G(^DIC(5,$P(X11,"^",5),0)),"^",2),1:"<STATE MISSING>")
 S X="Ins. Co.: "_$E($P(X0,"^"),1,25)
 S X=X_U_$S($P(X11,"^")'="":$P(X11,"^"),1:"<Street Addr. 1 Missing>")
 S X=X_U_$P(X11,"^",4)_", "_ST_"  "_$E(Z,1,5)_$S($E(Z,6,9)]"":"-"_$E(Z,6,9),1:"")
 S X=X_U_"Phone: "_$P(X13,"^")_U_"Precert Phone: "_$P(X13,"^",3)
 Q X_U_$S($P(X0,"^",5):"IN",1:"")_"ACTIVE COMPANY"
