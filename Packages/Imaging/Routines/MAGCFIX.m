MAGCFIX ;OIT/ZEB - CVIX Image Ingest Data Fix ; DEC 3, 2024@9:34AM
 ;;3.0;IMAGING;**376**;Dec 03, 2024;Build 5
 ;;Per VA Directive 6402, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;For IPO2 testing, start with 7/29/24
INGSTFIX(INTER,DEVNAME,STDT) ;Fix Image file (#2005) entries
 ;INTER   (default: ""): whether process is interactive
 ;DEVNAME (default: "CVIX INGEST"): name of entry to fill into ACQUISITION DEVICE field (#107); if @, field will be cleared
 ;STDT    (default: "3241113"): start date for search (internal FM format)
 S INTER=$G(INTER)
 S DEVNAME=$G(DEVNAME,"CVIX INGEST")
 S STDT=$G(STDT,"3241113")
 N DEVIEN,MAGDT,CNT,MAGIEN,MAG100,DIC,X,Y,DIE,DA,DR
 ;find or create device
 S DEVIEN=""
 S DEVIEN=$S(DEVNAME="@":"@",1:$O(^MAG(2006.04,"B",DEVNAME,DEVIEN)))
 D:DEVIEN=""
 . K DO ;FILE^DICN assumes this and we need to prevent a leak from something that didn't clean it up
 . S DIC="^MAG(2006.04,",DIC(0)="F",X=DEVNAME,DIC("DR")="1///`"_$P($$SITE^VASITE(),U,1)
 . D FILE^DICN
 . S DEVIEN=Y
 I DEVIEN=-1 D  Q
 . I INTER=1 D
 .. W !,"Unable to find/create "_DEVNAME_" device. Aborting."
 ;find effected records, set ACQUISITION DEVICE (#107), then delete TRACKING ID (#108); we're deferring setting it until P365
 I INTER=1 D
 . W !,"Searching for effected records.",!
 S CNT=0
 S MAGDT=$$FMADD^XLFDT(STDT,-1)
 F  S MAGDT=$O(^MAG(2005,"AD",MAGDT)) Q:MAGDT=""  D
 . S MAGIEN=""
 . F  S MAGIEN=$O(^MAG(2005,"AD",MAGDT,MAGIEN)) Q:MAGIEN=""  D
 .. S MAG100=^MAG(2005,MAGIEN,100)
 .. I $P(MAG100,U,4)="",$P(MAG100,U,5)]"" D
 ... S CNT=CNT+1
 ... I INTER=1 D
 .... W:CNT#10=0 "."
 ... S DIE="^MAG(2005,",DA=MAGIEN,DR="107///"_$S(DEVIEN="@":"",1:"`")_DEVIEN_";108///@"
 ... D ^DIE
 I INTER=1 D
 . W !,"Fixed "_CNT_" records."
 Q
