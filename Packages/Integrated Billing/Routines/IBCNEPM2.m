IBCNEPM2 ;DAOU/ESG - PAYER MAINTENANCE ENTRY POINT ;22-JAN-2003
 ;;2.0;INTEGRATED BILLING;**184**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
EN ; -- main entry point
 NEW X,Y,DIRUT,DIR,DTOUT,DUOUT,DIROUT
 W @IOF,!?22,"Payer Maintenance"
 W !!," This option will allow you to manage and maintain the entries"
 W !," in the Payer File for those Payers that were added to your system"
 W !," that are Nationally Active and who have potential missing links"
 W !," to active insurance companies."
 W !!," Potential missing links is defined as active insurance companies"
 W !," whose Professional and/or Institutional ID matches that of the "
 W !," Payer and whose pointer to the Payer Table is not populated.",!!!
 ;
 S DIR(0)="E" D ^DIR
 I $G(DUOUT)!$G(DTOUT) Q
 ;
 W !!?5,"Compiling the list of applicable payers ... "
 ;
 ;  call ListMan Screen
 D EN^VALM("IBCNE PAYER MAINT LIST")
 KILL ^TMP("IBCNEPM",$J)
EXIT ;
 Q
 ;
EXPND ; -- expand code for action protocol IBCNE PAYER EXPAND
 ;
 NEW LINE,X,Y,DIRUT,DIR,DTOUT,DUOUT,DIROUT,PIEN,PAYER,PAYRDATA
 NEW PROFID,INSTID
 D FULL^VALM1 W !
 ;
 I 'VALMCNT D  G EXPNDXT
 . W !!?5,"There are no entries in the list."
 . D PAUSE^VALM1
 ;
 ; Ask the user to choose the payer to expand
 S DIR("A")="Select entry to Expand, by line #"
 S DIR(0)="NO^1:"_VALMCNT D ^DIR K DIR
 I $D(DIRUT) K DIRUT G EXPNDXT
 I $G(DUOUT)!($G(DTOUT)) G EXPNDXT
 S LINE=+Y
 S PIEN=$O(^TMP("IBCNEPM",$J,"IDX",LINE,""))   ; payer ien
 I PIEN="" Q
 S PAYER=^TMP("IBCNEPM",$J,"IDX",LINE,PIEN)    ; payer name
 S PAYRDATA=$G(^IBE(365.12,PIEN,0))
 S PROFID=$P(PAYRDATA,U,5),INSTID=$P(PAYRDATA,U,6)
 D EN^IBCNEPM1(PIEN,PAYER,PROFID,INSTID)
EXPNDXT ;
 S VALMBCK="R"
 Q
 ;
