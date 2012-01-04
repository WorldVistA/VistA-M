MAGUXDPS ;WOIFO/MLH - Imaging utility - rebuild ADTDUZ indices ; 6 Jun 2011 5:10 PM
 ;;3.0;IMAGING;**117**;Mar 19, 2002;Build 2238;Jul 15, 2011
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
SETUP ; Foreground setup
 W !,"Imaging DATE-USER-SITE index rebuild",!!
 W "This option builds the ADTDUZ cross reference on Files 2005 and 2005.1",!
 W "to optimize the gathering of user capture statistics.",!
 L +^MAG("ADT INDEX REBUILD"):0
 E  W !,"This option is in use by another process. Try again later.",! Q
 N HIT,IEN,PARENT,SAVINFO,SAVDAT,SITE,CAPAPP
 N DIR,ZTRTN,ZTDESC,ZTDTH,ZTSAVE,ZTIO,ZTSK,Y,DIRUT
 ; Find whether this has been run to completion previously
 S HIT=0,IEN=0
 F  S IEN=$O(^MAG(2005.1,IEN)) Q:'IEN  D  Q:HIT
 . ; don't count children, just standalones and group parents
 . S PARENT=$P($G(^MAG(2005.1,IEN,0)),"^",10)
 . S SAVINFO=$G(^MAG(2005.1,IEN,2))
 . S SAVDAT=$P(SAVINFO,"^",1)\1,SAVUSER=$P(SAVINFO,"^",2),CAPAPP=$P(SAVINFO,"^",12)
 . S SITE=$P($G(^MAG(2005.1,IEN,100)),"^",3)
 . I PARENT="",SAVDAT'="",SAVUSER'="",CAPAPP'="",SITE'="" D
 . . S HIT=$S($D(^MAG(2005.1,"ADTDUZ",CAPAPP,SAVDAT,SAVUSER,SITE,IEN)):1,1:-1)
 . . Q
 . Q
 I 'HIT D  G SETUPX
 . W !,"No entries qualify for indexing.",!
 . Q
 D:HIT=-1
 . W !,"This option has not yet been run to completion."
 . Q
 D:HIT=1
 . W !,"This option has previously been run to completion.",!
 . W "Enter F or B to re-run, or up-arrow (^) to exit.",!
 . Q
 S DIR(0)="S^F:Execute in the foreground;B:Execute in the background"
 S DIR("A")="Enter F or B"
 D ^DIR G:$D(DIRUT) SETUPX
 I Y="F" D REBUILD G SETUPX
 I Y="B" D  G SETUPX
 . S ZTRTN="REBUILD^MAGUXDPS"
 . S ZTDESC="Rebuild DATE-USER-SITE indices"
 . S ZTDTH=$H
 . S ZTSAVE("SILENT")=1 ; no I/O for background process
 . S ZTIO="" ; no interactive I/O device
 . D ^%ZTLOAD,HOME^%ZIS
 . W:'$G(ZTSK) !,"TaskMan did not accept request",!
 . W:$G(ZTSK) !,"Queued as task number ",ZTSK,!
 . Q
SETUPX ;
 L -^MAG("ADT INDEX REBUILD")
 Q
REBUILD ; Foreground / background rebuild
 N FILENO,FILE,INTERVAL,I,IEN,PARENT,SAVINFO,SAVDAT,SAVUSER,CAPAPP,SITE
 L +^MAG("ADT INDEX REBUILD"):1E9 ; wait for foreground user exit
 F FILENO=2005,2005.1 D
 . S FILE=$NA(^MAG(FILENO))
 . K @FILE@("ADTDUZ")
 . S INTERVAL=$O(@FILE@(" "),-1)\500 ; interval for meter if foreground
 . ; work backwards so we can tell whether we're done by testing the
 . ;  existence of a cross reference for the 1st record on file
 . S IEN=" "
 . F I=1:1 S IEN=$O(@FILE@(IEN),-1) Q:'IEN  D
 . . ; don't count children, just standalones and group parents
 . . S PARENT=$P($G(@FILE@(IEN,0)),"^",10)
 . . S SAVINFO=$G(@FILE@(IEN,2))
 . . S SAVDAT=$P(SAVINFO,"^",1)\1,SAVUSER=$P(SAVINFO,"^",2),CAPAPP=$P(SAVINFO,"^",12)
 . . S SITE=$P($G(@FILE@(IEN,100)),"^",3)
 . . I PARENT="",SAVDAT'="",SAVUSER'="",CAPAPP'="",SITE'="" D
 . . . S @FILE@("ADTDUZ",CAPAPP,SAVDAT,SAVUSER,SITE,IEN)=""
 . . . I '$D(SILENT),I#INTERVAL=0 W "."
 . . . Q
 . . Q
 . Q
 K SILENT
 L -^MAG("ADT INDEX REBUILD")
 Q
