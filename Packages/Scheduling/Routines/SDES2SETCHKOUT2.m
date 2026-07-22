SDES2SETCHKOUT2 ; ALB/MGD - SDES2 SET APPT CHECKOUT (CONT.) ; MAY 27 2026
 ;;5.3;Scheduling;**945**;Aug 13, 1993;Build 2
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
STATUS(DFN,SDT,SDCL,SDATA,SDDA) ; return appt status
 ;   input: DFN := ifn of pat.
 ;          SDT := appt d/t
 ;         SDCL := ifn of clinic
 ;        SDATA := 0th node of pat appt entry
 ;         SDDA := ifn for ^SC(clinic,"S",date,1,ifn) {optional}
 ;  output: [returned] := appt status ifn ^ status name ^ print status ^
 ;                        check-in d/t ^ checkout d/t ^ adm mvt ifn
 ;
 ;S = status ; C = ci/co indicator ; Y = 'C' node ; P = print status
 N S,C,Y,P,VADMVT,VAINDT,STATUS,SDSCE,SDIEN,CHKINDT,CHKOUTDT
 ;
 ; get data for evaluation
 S:'$G(SDDA) SDDA=+$$FIND^SDAM2(DFN,SDT,SDCL)
 S CHKINDT=$$GET1^DIQ(44.003,SDDA_","_SDT_","_SDCL_",",309,"I")
 S CHKOUTDT=$$GET1^DIQ(44.003,SDDA_","_SDT_","_SDCL_",",303,"I")
 ; retrieve Checkout from OUTPATIENT ENCOUNTER file if not in Hospital Location file/PURGED or edited
 S SDSCE=$$GET1^DIQ(2.98,SDT_","_DFN_",",21,"I")
 I SDSCE D  ;pointer to OE
 .I CHKOUTDT="" S CHKOUTDT=$$GET1^DIQ(409.68,SDSCE,.07,"I")
 .S SDIEN=SDSCE_"," S STATUS=$$GET1^DIQ(409.68,SDIEN,.12)
 ;
 ; set initial status value ; non-count clinic?
 S S=$S($P(SDATA,"^",2)]"":$P($P($P(^DD(2.98,3,0),"^",3),$P(SDATA,"^",2)_":",2),";"),$P($G(^SC(SDCL,0)),U,17)="Y":"NON-COUNT",1:"")
 I SDSCE&(S="NO ACTION TAKEN") S S=""
 ;
 ; inpatient?
 S VAINDT=SDT D ADM^VADPT2
 I S["INPATIENT",$S('VADMVT:1,'$P(^DG(43,1,0),U,21):0,1:$P($G(^DIC(42,+$P($G(^DGPM(VADMVT,0)),U,6),0)),U,3)="D") S S=""
 ;
 ; determine ci/co indicator
 S C=$S(CHKOUTDT:"CHECKED OUT",CHKINDT:"CHECKED IN",S]"":"",SDT>(DT+.2359):"FUTURE",1:"NO ACTION TAKEN") S:S="" S=C
 ;
 I S="NO ACTION TAKEN",$P(SDT,".")=DT,C'["CHECKED" S C="TODAY"
 ; $$REQ & $$COCMP in SDM1A not used for speed
 I S="CHECKED OUT"!(S="CHECKED IN"),SDT'<$P(^DG(43,1,"SCLR"),U,23),'$P(SDATA,U,20) S S="NO ACTION TAKEN"
 ;
 ; determine print status
 S P=$S(S=C!(C=""):S,1:"")
 I P="" D
 .I S["INPATIENT",$P($G(^SC(SDCL,0)),U,17)'="Y",$P($G(^SCE(+$P(SDATA,U,20),0)),U,7)="" S P=$P(S," ")_"/ACT REQ" Q
 .I S="NO ACTION TAKEN",C="CHECKED OUT"!(C="CHECKED IN") S P="ACT REQ/"_C D  Q
 ..I SDSCE I $P($G(^SCE(SDSCE,0)),U,7) S P="CHECKED OUT"
 .S P=$S(S="NO ACTION TAKEN":S,1:$P(S," "))_"/"_C
 I S["INPATIENT",C="" D
 .I SDT>(DT+.2359) S P=$P(S," ")_"/FUTURE" Q
 .S P=$P(S," ")_"/NO ACT TAKN"
 I S["INPATIENT" Q +$O(^SD(409.63,"AC",S,0))_";"_S_";"_P_";"_CHKINDT_";"_CHKOUTDT_";"_+VADMVT
 I S["NO-SHOW" Q +$O(^SD(409.63,"AC",S,0))_";"_S_";"_P_";"_CHKINDT_";"_CHKOUTDT_";"_+VADMVT
 I $G(SDSCE) I $D(^SCE(SDSCE,0)) D
 .I $G(STATUS)="NON-COUNT" D  Q
 ..I CHKOUTDT S P="NON-COUNT/CHECKED OUT" Q
 ..I CHKINDT S P="NON-COUNT/CHECKED IN"
 .I $G(STATUS)="CHECKED OUT" S P="CHECKED OUT" Q
 .I CHKOUTDT S P="ACT REQ/CHECKED OUT" D  Q
 ..I $G(STATUS)="ACTION REQUIRED" S S="NO ACTION TAKEN" Q
 ..I $G(STATUS)="" I $P($G(^SCE(SDSCE,0)),U,7) S P="CHECKED OUT"
 .I CHKINDT S P="ACT REQ/CHECKED IN" D
 ..I $G(STATUS)="ACTION REQUIRED" S S="NO ACTION TAKEN"
 Q +$O(^SD(409.63,"AC",S,0))_";"_S_";"_P_";"_CHKINDT_";"_CHKOUTDT_";"_+VADMVT
