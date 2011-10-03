SCENI01 ;ALB/SCK - INCOMPLETE ENCOUNTER MGMT MAIN LM DISPLAY PROTOCOLS; 07-MAY-1997 ; 07 May 99  9:45 PM
 ;;5.3;Scheduling;**66,194,323**;AUG 13, 1993
 ;
ASKDT(SDT) ; Ask for begin and end date for search
 ;  Variable Input
 ;      SDT - Returns Begin date^End date
 ;
 ;  Returns
 ;       0  -  No dates selected
 ;       1  -  Dates selected
 ;
 N X,SDT1
 S SDT1=$G(SDT)
 ;
 S X=$P($G(^DG(43,1,"SCLR")),U,12)
 S SDBDT=$$FMADD^XLFDT($$DT^XLFDT,-X)
 ;
 W !!,"Date Range for Encounters"
 S DIR(0)="DA^2961001:NOW:EXP",DIR("A")="Enter begin date for search: "
 S DIR("?")="^D HELP^%DTC"
 S DIR("B")=$$FMTE^XLFDT(SDBDT)
 D ^DIR K DIR
 I $D(DIRUT) S SDT="" G DTQ  ; SD*5.3*323 Change K SDT to S SDT=""
 K DIRUT,DIR
 S SDT=Y
 ;
 S DIR(0)="DA^2961001:NOW:EXP",DIR("A")="Enter end date for search: "
 S DIR("B")="TODAY"
 D ^DIR K DIR
 I $D(DIRUT) S SDT="" G DTQ  ; SD*5.3*323 Change K SDT to S SDT=""
 S SDT=SDT_U_Y
DTQ S X=1
 I SDT1,'$D(SDT) S SDT=SDT1,X=0
 I SDT=SDT1 S X=0
 Q X
 ;
CCLN ;  Change Clinic
 K DIRUT
 D FULL^VALM1
 S VALMBCK="R"
 W !
 S VAUTNI=2
 S DIR(0)="P^44:EMZ",DIR("A")="Select Clinic"
 S DIR("S")="I $$CLINIC^SDAMU(Y),$S(VAUTD:1,$D(VAUTD(+$P(^SC(Y,0),U,15))):1,'$P(^(0),U,15)&$D(VAUTD(+$O(^DG(40.8,0)))):1,1:0)"
 D ^DIR K DIR
 I $D(DIRUT) D  Q
 . W !,"Clinic has not been changed"
 . D PAUSE^VALM1
 K SDFN,VAUTC
 S SDENTYP="C",VAUTC=0,VAUTC(+Y)=$P(^SC(+Y,0),U)
 D HDR^SCENI0,INIT^SCENI0
 Q
 ;
CPAT ;  Change Patient
 D FULL^VALM1
 S VALMBCK="R"
 W !
 S DIR(0)="P^2:EM"
 S DIR("A")="Select Patient"
 D ^DIR  K DIR
 I $D(DIRUT) D  Q
 . W !,"Patient was not changed."
 . D PAUSE^VALM1
 K VAUTC
 S VAUTC=1,SDENTYP="P",SDFN=+Y
 D HDR^SCENI0,INIT^SCENI0
 Q
 ;
CDT ; Change Date range
 N SCOK
 D FULL^VALM1
 S VALMBCK="R"
 I '$$ASKDT(.SDDT) D  Q
 . W !,"Date range has not been changed"
 . D PAUSE^VALM1
 D HDR^SCENI0,INIT^SCENI0
 Q
 ;
CER ; Change Error Code
 D FULL^VALM1
 S VALMBCK="R"
 W !
 S DIR(0)="P^409.76:EM"
 S DIR("A")="Select New Error"
 D ^DIR  K DIR
 I $D(DIRUT) D  Q
 . W !,"Error Code has not been changed"
 . D PAUSE^VALM1
 S SDEVAL=+Y,SDENTYP="E"
 D HDR^SCENI0,INIT^SCENI0
 Q
 ;
DSPLYER ; Display transmission errors
 N SDXPTR
 ;
 S LINENBR=$$SELXENC
 I $D(SDXPTR) D
 . S VALMBCK=""
 . D EN^SCENIA0
 . S VALMBCK="R"
 . D SELECT^VALM10(LINENBR,1) ; This line will hilight the entry and not rebuild the list
 K SDXPTR,LINENBR
 Q
 ;
EXP ;  Expand enounter using the Appointment Management Expand protocol.  
 ;  This protocol uses the SDAMIDX Tmp global, so if this global already
 ;  exisits (IEMM LM being called from inside Apt. Manager) save off the
 ;  existing global before proceeding, and  restore it before returning.
 ;
 K ^TMP("SCENI TMP",$J)
 I $D(^TMP("SDAMIDX",$J)) D
 . M ^TMP("SCENI TMP",$J)=^TMP("SDAMIDX",$J)
 ;
 K ^TMP("SDAMIDX",$J)
 M ^TMP("SDAMIDX",$J)=^TMP("SCENIDX",$J)
 K ^TMP("SDAMEP",$J)
 S VALMBCK=""
 D SEL^SDAMEP G EXPQ:'$D(SDW)!(SDERR)
 N SDWIDTH,SDPT,SDSC,SDXMT,SCINF
 ;
 S SDXMT=$O(^TMP("SCENI",$J,"XMT",SDW,0))
 I $$OPENC^SCUTIE1(SDXMT,"SCINF")>-1,SCINF("AE") D  G EXPQ
 . W !!,$C(7),"This encounter is not an appointment, and cannot be expanded."
 . W !,"Press any key to continue..."
 . S DIR(0)="FAO" D ^DIR K DIR
 ;
 W ! D WAIT^DICD,EN^VALM("SDAM APPT PROFILE")
 S VALMBCK="R"
 ;
EXPQ K ^TMP("SDCOIDX",$J),^TMP("SDAMIDX",$J)
 I $D(^TMP("SCENI TMP",$J)) D
 . M ^TMP("SDAMIDX",$J)=^TMP("SCENI TMP",$J)
 . K ^TMP("SCENI TMP",$J)
 Q
 ;
SELXENC() ; Select transmitted encounter to display errors if no encounter passed in.
 N VALMI,VALMAT,VALMY
 ;
 D FULL^VALM1
 D EN^VALM2(XQORNOD(0),"S") S VALMI=0
 I '$D(VALMY) S VALMBCK="R" Q 0
 S SDN1="",SDN2=$O(VALMY(SDN1))
 S SDXPTR="",SDXPTR=$O(^TMP("SCENI",$J,"XMT",SDN2,SDXPTR))
 Q +SDN2
 ;
EXIT ;
 I $D(VALMBCK),VALMBCK="R" D REFRESH^VALM S VALMBCK=$P(VALMBCK,"R")_$P(VALMBCK,"R",2)
 K SDBT,SDEDT,SDN1,SDN2
 Q
