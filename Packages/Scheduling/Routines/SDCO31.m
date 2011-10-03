SDCO31 ;ALB/RMO - Provider Cont. - Check Out;19 MAR 1993 9:04 am
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;
PRHLP(SDCL) ;Provider Help for Clinic
 ; Input  -- SDCL     Hospital Location file IEN
 ; Output -- Help
 N C,I,SDNPI
 I '$O(^SC(SDCL,"PR",0)) G PRHLPQ
 W !!,"The following providers are associated with ",$$LOWER^VALM1($P($G(^SC(SDCL,0)),"^")),":"
 W !!,"Default Provider: ",$S($$PRDEF(SDCL)]"":$$PRDEF(SDCL),1:"[None]")
 W !!,"Other providers: "
 S (C,I)=0 F  S I=$O(^SC(SDCL,"PR",I)) Q:'I  I $D(^(I,0)) S SDNPI=+^(0) I '$D(^SC("ADPR",SDCL,I)) D
 .S C=C+1
 .W:C=1 !
 .D PAUSE^VALM1:'(C#15) W !,$$PR(SDNPI)
 W:'C "None"
PRHLPQ Q
 ;
PRDEF(SDCL) ;Provider Default for Clinic
 ; Input  -- SDCL     Hospital Location file IEN
 ; IF DEFINED: DFN - ptr to PATIENT File
 ; Output -- Default
 N Y,X
 I $D(^SC("ADPR",SDCL)),$D(^SC(SDCL,"PR",+$O(^(SDCL,0)),0)) S Y=$$PR(+^(0))
 S:($G(Y)="")&($G(^SC(SDCL,"PC")))&($D(DFN)) Y=$P($$NMPCPR^SCAPMCU2(DFN,DT,1),U,2)
 Q $G(Y)
 ;
PR(SDNPI) ;Provider Display Data
 ; Input  -- SDNPI    New Person IEN
 ; Output -- Provider Display Data - Provider Name
 N Y
 S Y=$S($D(^VA(200,SDNPI,0)):$P(^(0),"^"),1:"Unknown")
 Q $G(Y)
