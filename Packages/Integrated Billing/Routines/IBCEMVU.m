IBCEMVU ;DAOU/ESG - STAND-ALONE VIEW MRA EOB ;18-APR-2003
 ;;2.0;INTEGRATED BILLING;**155**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; Entry point
 NEW DA,DIC,DILN,DISYS,X,Y,DTOUT,DUOUT,IBIFN,IBEOBIFN
LOOP ;
 K IBIFN
 D INIT
 W !
 S DIC="^IBM(361.1,"
 S DIC(0)="AEMQ"
 S DIC("S")="I $P(^(0),U,4)=1"      ; MRA EOB type
 S DIC("W")="D EOBLST^IBCEMU1(Y)"   ; modify generic lister
 D ^DIC
 I Y=-1!$D(DTOUT)!$D(DUOUT) G EX
 S IBIFN=+$P(Y,U,2)
 I IBIFN D VIEWEOB(IBIFN,+$P(Y,U,1))
 I $$MRACNT^IBCEMU1(IBIFN)'>1 G LOOP
 ;
 ; At this point, we know the selected bill has multiple MRA's on file.
 ; Display the multiple MRA lister and let the user choose again
ML1 ;
 D INIT
 S IBEOBIFN=$$SEL^IBCEMU1(IBIFN,1)
 I 'IBEOBIFN G LOOP
 D VIEWEOB(IBIFN,IBEOBIFN)
 G ML1
 ;
EX ; Exit point
 Q
 ;
INIT ; clear screen, intro text
 W @IOF
 W !?33,"View MRA EOB's"
 W !!?1,"This option will allow you to select and view Medicare Remittance Advice (MRA)"
 W !?1,"Explanations of Benefits (EOB).  Only Medicare EOB's are displayed here."
INITX ;
 Q
 ;
VIEWEOB(IBIFN,IBEOBIFN) ; This procedure is responsible for
 ; invoking the ListManager list for viewing an EOB.
 ;   IBIFN is the internal bill# (required)
 ;   IBEOBIFN is the ien to file 361.1 if known (optional)
 ;
 NEW COL,CTRLCOL,FINISH,IB,IBCNT,IBONE,POP,VALMBCK,VALMY,X,Y,Z
 D EN^VALM("IBCEM VIEW EOB")
VIEWX ;
 Q
 ;
SCR(IBIFN) ; ?MRA action from the IB Bill Enter/Edit screens
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,CNT,IBFASTXT,IBEOBIFN
 I '$D(IOUON)!'$D(IORVON) D ENS^%ZISS
 D SCHD
 S CNT=$$MRACNT^IBCEMU1(IBIFN)
 I 'CNT D  G SCRX
 . W !!!?8,"There are no MRA EOB's on file for this bill."
 . D EOP
 . Q
 ;
 I CNT=1 D VIEWEOB(IBIFN) G SCRX     ; only one MRA
 ;
SCLOOP ; Multiple MRA's on file.  Call the MRA/EOB lister.
 ;
 D SCHD
 S IBEOBIFN=$$SEL^IBCEMU1(IBIFN,1)
 I 'IBEOBIFN G SCRX
 D VIEWEOB(IBIFN,IBEOBIFN)
 G SCLOOP
 ;
SCRX ;
 Q
 ;
SCHD ; screen header info
 W @IOF
 W !!?24,"View Medicare Remittance Advice"
 W !?28,"Explanation of Benefits"
SCHDX ;
 Q
 ;
EOP ; End of page
 W !! S DIR("A")="   Press RETURN to continue",DIR(0)="E" D ^DIR K DIR
EOPX ;
 Q
 ;
