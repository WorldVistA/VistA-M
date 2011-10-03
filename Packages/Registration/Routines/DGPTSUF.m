DGPTSUF ;ALB/LD - Utilities for Facility Suffix (#45.68) file; 27 May 1995
 ;;5.3;Registration;**58**;Aug 13, 1993
 ;
 ;--EDEFF called from option 'Add/Edit Suffix Effective Date' (located
 ;  within the Utility submenu of the PTF main menu) to edit and display
 ;  the Effective Date multiple in Facility Suffix (#45.68) file.
 ;
 ;--NUMACT called from PTF routines to get the number of active
 ;  suffixes for a station type.
 ;
 ;
EDEFF ;--edit effective date multiple in Facility Suffix (#45.68) file
 ;
 N DGSUF
 ;--lookup to get suffix ien and name
 S DIC="^DIC(45.68,",DIC(0)="QEAM",X="?" D ^DIC
 I Y=-1!($G(DTOUT))!($G(DUOUT)) G EDEFFQ
 S DGDA=+Y,DGSUF=$P($G(Y),U,2)
 ;--display suffix, effective date, and active flag before editing
 D EFFDISP
 D EDIT
 ;--display suffix, effective date, and active flag after editing
 D EFFDISP
EDEFFQ K DA,DGDA,DIC,DTOUT,DUOUT,X,Y
 Q
EDIT ;--edit effective date; display error msg and loop back if last
 ;  effective date is deleted
 N DA,DIE,DR
 S DA=DGDA,DIE="^DIC(45.68,",DR="10"
 Q:'$G(DA)
 L +^DIC(45.68,DGDA):5 I '$T W !!,*7,"  << RECORD IN USE. TRY AGAIN LATER >>",! G EDEFFQ
 D ^DIE
 L -^DIC(45.68,DGDA)
 Q
EFFDISP ;--display suffix, effective date, and active flag to screen
 N DGI,DGJ
 S (DGI,DGJ)=0
 W !!,"Current Status of Facility Suffix:"
 W !!?5,"Facility Suffix",?25,"Effective Date",?45,"Active?"
 W !?5,"---------------",?25,"--------------",?45,"-------",!
 W ?11,DGSUF
 ;--get effective date and active flag from multiple
 F  S DGI=$O(^DIC(45.68,+DGDA,"E","B",DGI)) Q:'DGI  D
 .F  S DGJ=$O(^DIC(45.68,+DGDA,"E","B",DGI,DGJ)) Q:'DGJ  D
 ..W ?28,$$CJ^XLFSTR($$FMTE^XLFDT($P($G(^DIC(45.68,+DGDA,"E",DGJ,0)),U),"2D"),8),?47,$$RJ^XLFSTR($S($P($G(^DIC(45.68,+DGDA,"E",DGJ,0)),U,2)=1:"YES",1:"NO"),3),!
 Q
 ;
NUMACT(STATYP) ; Number of active suffixes for station type
 ;
 ;          DGEFFDT -- Suffix Effective Date
 ;         DGEFFIEN -- Suffix Effective Date IEN
 ;
 ; NOTES:     IN:  STATYP  --  Station Type IEN
 ;           OUT:  Number of active suffixes for station type
 ;
 N DGEFFDT,DGEFFIEN,DGI
 S DGANUM=0
 F DGI=0:0 S DGI=$O(^DIC(45.81,+$G(STATYP),"S","B",DGI)) Q:'DGI  D
 .S DGEFFDT="",DGEFFDT=+$O(^DIC(45.68,DGI,"E","AEFF",DGEFFDT))
 .S DGEFFIEN=0,DGEFFIEN=$O(^DIC(45.68,DGI,"E","AEFF",DGEFFDT,DGEFFIEN))
 .I $P($G(^DIC(45.68,DGI,"E",+DGEFFIEN,0)),U,2)=1 D
 ..S DGANUM=DGANUM+1
 ..S DGSUFNAM(DGANUM)=$P($G(^DIC(45.68,DGI,0)),U)
 Q
