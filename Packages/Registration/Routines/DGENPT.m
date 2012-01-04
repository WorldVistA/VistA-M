DGENPT ;ALB/CJM,LBD - Patient Protocols; 13 JUN 1997 ; 3/29/11 11:59am
 ;;5.3;Registration;**121,147,838**;08/13/93;Build 5
 ;
PF ;Entry point for DGENPT PREFERRED FACILITY protocol
 ; Input  -- DFN      Patient IEN
 ; Output -- VALMBCK  R   =Refresh screen
 S VALMBCK=""
 D FULL^VALM1
 D PREFER(DFN)
 D HDR^DGENL
 D MESSAGE^DGENL(DFN)
 S VALMBCK="R"
 Q
 ;
PREFER(DFN) ;
 ;Description: Enter/Edit patient's preferred facility.
 ;Input: DFN - patient ien
 ;Output: none
 ;
 Q:'$G(DFN)
 Q:'$D(^DPT(DFN,0))
 ;
 N PREFAC,RESPONSE,PFSRC
 ;If SOURCE DESIGNATION field (#27.03) = 'E' or 'PA' then PREFERRED
 ;FACILITY cannot be edited. Display message and quit. (DG*5.3*838)
 S PFSRC=$P($G(^DPT(DFN,"ENR")),"^",3)
 I PFSRC="E"!(PFSRC="PA") D  Q
 .W !!,"Preferred Facility can only be edited/modified by an ESR user."
 .W !,"Please contact HEC to request changes/edits."
 .N DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" W ! D ^DIR
 ;
 S PREFAC=$$PREF^DGENPTA(DFN)
 S:'PREFAC PREFAC=$P($$SITE^VASITE(),"^")
 W !
PRMPT I $$PROMPT^DGENU(2,27.02,PREFAC,.RESPONSE)
 I $G(RESPONSE)'="",$$STOREPRE^DGENPTA1(DFN,RESPONSE) Q
 I $P($G(^DPT(DFN,"ENR")),"^",2)="" W !,"Entry of a Preferred Facility is required!" G PRMPT
 I $G(X)="@" D
 .W !,"The Preferred Facility cannot be deleted!"
 .N DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" W ! D ^DIR
 Q
