DGYVPOST ;ALB/LD - Patch DG*5.3*64 Post-Init ; 8/8/95
 ;;5.3;Registration;**64**;Aug 13, 1993
 ;
 ;
 ;-- Populate FACILITY TREATING SPECIALTY file (#45.7) with effective
 ;-- date and active flag from pointed to Effective Date multiple 
 ;-- entries in the TREATING SPECIALTY file (#42.4).
 ;
EN ;-- Entry point
 ;
 N DGPTQ
 D XREFCHK
 I $G(DGPTQ) D DONE
 I '$G(DGPTQ) D RXREF,POPMUL,ERRPT,INACT^DGYVPST1,DONE
ENQ Q
 ;
XREFCHK ;-- Check for "ASPEC" xref in ^DD(45.7
 ;
 W !!,">>> This post-init will populate the Effective Date multiple of each record",!?4,"in the Facility Treating Specialty file (#45.7).",!!
 N I S (DGPTQ,I)=0,I=$O(^DD(45.7,0,"IX","ASPEC",45.7,I))
 I '$G(I) S DGPTQ=1
 I $G(I) I '$D(^DD(45.7,"IX",I)) S DGPTQ=1
 I $G(DGPTQ) W !,"***ERROR: Cross reference ""ASPEC"" in file #45.7 not found.",!?10,"Rerun init DGYVINIT from patch DG*5.3*64 (see patch description",!?10,"for complete instructions).",!
 Q
 ;
RXREF ;--Reindex Specialty (#1) field "ASPEC" xref in file 45.7
 ;
 N DIK
 S DIK="^DIC(45.7,",DIK(1)="1" D ENALL^DIK
 Q
 ;
POPMUL ;--Get data from file 42.4 to populate eff date mult in file 45.7
 ;
 W !!,">>> Post-Init started at: " D NOW^%DTC W $$FTIME^VALM1(%),!
 ;
 N DGPTERR,DGPTMIEN,DGPTOUT,DGPTSIEN,DIRUT,DTOUT,DUOUT
 F DGPTMIEN=0:0 S DGPTMIEN=$O(^DIC(45.7,"ASPEC",DGPTMIEN)) Q:'DGPTMIEN!($G(DGPTOUT))  D
 .F DGPTSIEN=0:0 S DGPTSIEN=$O(^DIC(45.7,"ASPEC",DGPTMIEN,DGPTSIEN)) Q:'DGPTSIEN!($G(DGPTOUT))  D
 ..N DGPTASK,DGPTEFF,DGPTCTR,DGPTI
 ..;--Subentry doesn't exist in file 42.4
 ..I '$D(^DIC(42.4,DGPTMIEN,"E",0)) S ^TMP("DGPTERR",$J,DGPTMIEN,DGPTSIEN,1)="" Q
 ..;--Get total # of subentries from file 42.4 subfile header node
 ..S DGPTCTR=$P($G(^DIC(42.4,DGPTMIEN,"E",0)),U,4) I DGPTCTR'>0 S ^TMP("DGPTERR",$J,DGPTMIEN,DGPTSIEN,2)="" Q
 ..F DGPTI=1:1:DGPTCTR Q:$G(DGPTOUT)!($G(DGPTEFF)=0)  D POPFAC
POPMULQ Q
 ;
POPFAC ;--Populate eff date mult in FTS file #45.7
 N DGPTACTF,DGPTEFDT,DGPTNODE,DA,DIC,DIE,DINUM,DR,X,Y
 ;--Get effective date and active flag from file 42.4 subentry
 S DGPTNODE=$G(^DIC(42.4,DGPTMIEN,"E",DGPTI,0)) I DGPTNODE']"" S ^TMP("DGPTERR",$J,DGPTMIEN,DGPTSIEN,3)="" G POPFACQ
 I (DGPTMIEN=70!(DGPTMIEN=71)!(DGPTMIEN=77)),('$G(DGPTASK)) D ASK
 I $D(DIRUT)!$D(DUOUT)!$D(DTOUT) S ^TMP("DGPTERR",$J,DGPTMIEN,DGPTSIEN,4)="",DGPTOUT=1 G POPFACQ
 I $G(DGPTEFF)=0 S DGPTCTR=1 ;if no to inactivate, add active eff date only
 S DGPTEFDT=$P(DGPTNODE,U),DGPTACTF=$P(DGPTNODE,U,2)
 ;--Add fields to file 45.7 subentry
 S DIC="^DIC(45.7,"_DGPTSIEN_",""E"","
 S DIC(0)="L"
 S (DA,DINUM)=DGPTI
 S X=DGPTEFDT
 ;--Extra variables needed since it's a multiple
 S DIC("P")=$P(^DD(45.7,100,0),"^",2)
 S DA(1)=DGPTSIEN
 ;--Create/edit subentry
 S DIC("DR")=".02///^S X="_DGPTACTF
 K DD,DO D FILE^DICN
 I $G(Y)=-1 S ^TMP("DGPTERR",$J,DGPTMIEN,DGPTSIEN,5)=""
 I $G(DTOUT)!($G(DUOUT)) S ^TMP("DGPTERR",$J,DGPTMIEN,DGPTSIEN,4)="",DGPTOUT=1 G POPFACQ
 ;--Write msg (once) to screen while processing
 I $G(Y)>0,($G(DGPTI)<2) W !!,"... Added ",$S('$G(DGPTEFF):"active ",1:"inactive "),"effective date and ",$S('$G(DGPTEFF):"active ",1:"inactive "),"flag to facility",!?4,"treating specialty  ",$P($G(^DIC(45.7,DGPTSIEN,0)),U)
 ;
POPFACQ Q
ASK ;
 W !! S DIR("A")="      Inactivate facility treating specialty"
 S DIR("A",1)="    Facility treating specialty, "_$P($G(^DIC(45.7,DGPTSIEN,0)),U)_","
 S DIR("A",2)="    is pointing to an inactive treating specialty in the Specialty (#42.4)"
 S DIR("A",3)="    file.  Answering 'Yes' to this prompt will make the facility treating"
 S DIR("A",4)="    specialty inactive also."
 S DIR("A",5)="                            "
 S DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR S (DGPTASK,DGPTEFF)=+Y K Y
 W !
ASKQ Q
 ;
ERRPT ;--Queue error report for printing or print direct
 Q:'$D(^TMP("DGPTERR",$J))
 ;
 W !!,">>> The following report will list all messages and/or errors which occurred",!?4,"while running this post-init.",!
 N POP,ZTDESC,ZTRTN,ZTSAVE,ZTSK
 S %ZIS="QMP" D ^%ZIS K %ZIS I POP Q
 I '$D(IO("Q")) U IO D PRTERR^DGYVPST1,^%ZISC G ERRPTQ
 ; task job
 S ZTRTN="PRTERR^DGYVPST1",ZTSAVE("^TMP(""DGPTERR"",$J,")=""
 S ZTDESC="Patch DG*5.3*64 Post-Init Error Report"
 D ^%ZTLOAD
 W !!,$S($D(ZTSK):">>> Job has been queued. The task number is "_ZTSK_".",1:">>> Unable to queue this job.")
ERRPTQ K IO("Q"),^TMP("DGPTERR",$J)
 Q
 ;
DONE W !!,">>> Post-Init completed at: " D NOW^%DTC W $$FTIME^VALM1(%),!
 Q
 ;
