DGPTAPA ;MTC/ALB - PTF Archive Utilities; 10-14-92
 ;;5.3;Registration;;Aug 13, 1993
 ;
ARC ;-- entry point to Archive PTF records
 N DGTMP,REGEN
 ;
 ;-- set re-generation flag to yes
 S REGEN=1
 ;-- get template to archive
 D SEL^VALM2 I '$D(VALMY) G ARCQ
 S DGTMP=$O(^TMP("ARCPTF",$J,"AP LIST","REC",+$O(VALMY(0)),0))
 ;
 ;-- if data is already purged then exit 
 I $P(^DGP(45.62,DGTMP,0),U,7) W !,">>> PTF Archived Data Already Purged..." H 2 G ARCQ
 ;-- find out if archive data exist
 I $$MKARC(DGTMP,.REGEN) D
 .;-- do archive to device
 . I $$WR(DGTMP,REGEN) D
 ..;-- update history file
 .. D ADDARC(DGTMP)
 ;
ARCQ Q
 ;
ADDARC(TEMP) ;-- This function will add archive date, user and status
 ;
 ;   INPUT : TEMP - IFN of the History File to update
 ;
 N SRTMP
 ;-- if no A/P template exit
 I '$D(^DGP(45.62,TEMP,0)) G ADDARCQ
 ;-- new/revise archive data A/P template archive data
 W !,">>> Adding Archive data to PTF Archive/Purge History entry."
 S DA=TEMP,DIE="^DGP(45.62,",DR=".02////^S X=DUZ;.03///NOW;.04///1"
 D ^DIE
ADDARCQ ;
 Q
 ;
ARCEX ;-- exit point from protocol
 D TMPINT^DGPTLMU2
 S VALMBCK="R"
 Q
 ;
MKARC(DGTMP,REGEN) ;-- this function will create the word process field that contains the
 ; archive data if one does not exists. If a field already exist then
 ; the data will be deleted and the new field will be created.
 ;
 ; INPUT  : DGTMP - A/P Template
 ;          REGEN - flag to indicate if re-gen of data is required
 ; OUTPUT : 1 - ok continue
 ;          0 - don't continue
 ;
 N DATE,EXIST
 S EXIST=1
 ;--if data has been purged, if so exit
 G:$P($G(^DGP(45.62,DGTMP,0)),U,7) MKARCQ
 ;--check if archive data already exists
 I $G(^DGP(45.62,DGTMP,100,0))'="" S EXIST=$$CHDATA G:EXIST<0 MKARCQ
 ;-- if regenerate delete old data, set flag
 I EXIST D
 . S DR="100///@",DA=DGTMP,DIE="^DGP(45.62," D ^DIE K DA,DR,DIE
 . S REGEN=1
 ;-- set flag NOT to regenerate
 I 'EXIST S REGEN=0
 S EXIST=1
MKARCQ Q EXIST
 ;
CHDATA() ;-- if data already exists in WP field ask if should be purged
 ; OUTPUT : 1 - ok continue
 ;          0 - don't continue
 ;         -1 - user enters a "^"
 N EXIST
 S DIR(0)="Y",DIR("A")="Archive Data already exists. Should I re-generate the Archive data",DIR("B")="NO" D ^DIR
 S EXIST=$S($D(DIRUT):-1,Y:1,1:0)
 K DIR
 Q EXIST
CHECK ;
 S Y=$$STATUS^DGPTLMU2(DGTMP)
 Q
 ;
WR(DGTMP,REGEN) ;-- this function will write the archived data out to a sequential
 ;   device.
 ;   INPUT : DGTMP - Active PTF A/P template
 ;           REGEN - regeneration flag
 ; OUTPUT : 1 - ok continue
 ;          0 - don't continue
 ;
 N RESULT
 S RESULT=1
 W !!,*7,">>> Select Device for Archiving PTF Data."
 S %ZIS="Q" D ^%ZIS I POP S RESULT=0 G WRQ
 I $D(IO("Q")) D  G WRQ
 . S ZTRTN="WRITEM^DGPTAPA",ZTDESC="PTF A/P Archive",ZTSAVE("DGTMP")="",ZTSAVE("REGEN")=""
 . D ^%ZTLOAD D HOME^%ZIS K IO("Q")
 D WRITEM
WRQ ;
 Q RESULT
 ;
WRITEM ;-- loop thru write archive data
 N I,X,DGPTF
 U IO
 ;-- check if archive data should be built
 I REGEN D BLDAD(DGTMP)
 ;-- write archived data to a device
 S I=0 F  S I=$O(^DGP(45.62,DGTMP,100,I)) Q:'I  D
 . S X=$G(^DGP(45.62,DGTMP,100,I,0))
 . W:X]"" X,!
 D ^%ZISC
WRITEMQ ;
 Q
 ;
BLDAD(DGTMP) ;-- This function will load the Archive data into the wp
 ;   field in the A/P template.
 ;
 ;   INPUT : DGTMP - A/P Template
 ;
 N SRTMP,DGPTF,DATE
 ;-- delete any data in wp field
 I $D(DGP(45.62,DGTMP,100)) D
 . S DR="100///@",DA=DGTMP,DIE="^DGP(45.62," D ^DIE K DA,DR,DIE
 ;-- load header
 S DATE="$PTF Records Selected from "_$$FTIME^VALM1($P(^DGP(45.62,DGTMP,0),U,10))_" thru "_$$FTIME^VALM1($P(^DGP(45.62,DGTMP,0),U,11))_"."
 S DR="100///^S X=DATE",DA=DGTMP,DIE="^DGP(45.62," D ^DIE K DA,DR,DIE
 ;-- add generic header to wp field
 D MKHEAD^DGPTAPA4
 ;-- archive selected records
 S SRTMP=$P(^DGP(45.62,DGTMP,0),U,8),DGPTF=""
 F  S DGPTF=$O(^DIBT(SRTMP,1,DGPTF)) Q:'DGPTF  D ARINT^DGPTAPA1
 Q
 ;
