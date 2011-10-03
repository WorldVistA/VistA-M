DGPMEVT ;ALB/RMO - MAS MOVEMENT EVENT DRIVER; 26 DEC 89 ; 2/2/04 3:18pm
 ;;5.3;Registration;**61,574**;Aug 13, 1993
 ;
 ;Required Variables:
 ;         DFN      = Patient's IFN
 ;         DGPMDA   = Movement's IFN
 ;         DGPMP    = 0 Node of Primary Movement PRIOR to Add/Edit/Delete
 ;         DGPMA    = 0 Node of Primary Movement AFTER Add/Edit/Delete
 ;       DGQUIET    = If $G(DGQUIET) then the read/writes should not
 ;                     occur (optional)
 ;
 K DTOUT,DIROUT
 ; **************************************************************
 ;-- establish visit & set pt movement ptr
 I $P($G(^DIC(150.9,1,0)),U,2)["1" D VISIT
 ; **************************************************************
 N OROLD D INP^VADPT S X=$O(^ORD(101,"B","DGPM MOVEMENT EVENTS",0))_";ORD(101,"
 I $P(X,";",1)="" D ERR K VAIN Q
 D EN1^XQOR K VAIN,X
 Q
 ;
ERR ;
 W !,"Serious error ! DGPM MOVEMENT EVENTS protocol not found"
 W !,"in Protocol file #101.  No events fired !"
 W !
 Q
 ;
VISIT ;-- create visit file entry for new admissions
 ;
 ;-- Loop through ^UTILITY for admissions, if no prior movement
 ;   then new admission. This will capture admissions for ASIH.
 N DGX,DGY
 S DGX=""
 F  S DGX=$O(^UTILITY("DGPM",$J,1,DGX)) Q:'DGX  D
 . I $G(^UTILITY("DGPM",$J,1,DGX,"A"))]"",$G(^("P"))="" S DGY=^("A") D
 .. S DGY=$$NEW(DGX,DGY)
 .. S ^UTILITY("DGPM",$J,1,DGX,"A")=DGY
 .. S:DGPMDA=DGX DGPMA=DGY
 K VSIT
 Q
 ;
NEW(DGPM,DGPMA) ; --- add a new entry, new admit
 ;  INPUT : DGPM - IEN of admission movement
 ;         DGPMA - Oth node of admission movement
 K VSIT
 ;
 ;-- define admission
 ;
 ;--location
 I $D(^DIC(42,+$P(DGPMA,"^",6),44)) S VSIT("LOC")=+^(44)
 I $D(VSIT("LOC")),'$D(^SC(+VSIT("LOC"),0)) K VSIT("LOC")
 ;
 ;--eligibility
 S VSIT("ELG")=$S(+$P(DGPMA,U,20):+$P(DGPMA,U,20),1:+$G(^DPT($P(DGPMA,U,3),.36)))
 G:'VSIT("ELG") NEWQ
 ;
 ;-- get vt ien
 S VSIT=+DGPMA,VSIT(0)="F",VSIT("SVC")="H"
 D ^VSIT
 ;
 ;-- add the vt entry to the admission
 I +$G(VSIT("IEN")) D
 . S DIE="^DGPM(",DA=+DGPM,DR=".27////"_+VSIT("IEN") D ^DIE
 . K DIC,DIE,DA,DR
 . S $P(DGPMA,"^",27)=+VSIT("IEN")
 ;
NEWQ ;
 K VSIT
 Q DGPMA
 ;
