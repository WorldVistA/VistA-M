MAGGSIU5 ;WOIFO/GEK - Utilities for Image Import API ; 22 Feb 2011 12:28 PM
 ;;3.0;IMAGING;**121**;Mar 19, 2002;Build 2340;Oct 20, 2011
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
 ; ----- RSND1 ----- Rescind One Image
 ;  This routine is called by other Imaging routines to Rescind One Image.
 ;
 ; Input Parameters
 ; ================
 ; MAGIEN = IEN of Image entry in IMAGE (#2005) File
 ; TIUDA  = IEN of TIU note in TIU DOCUMENT file (#8925) 
 ; DELREAS = Free text of Deleted Reason
 ; 
 ;  MAGIEN and TIUDA are required. 
 ;  We verify that the Image entry MAGIEN, points to TIUDA.
 ;  We also call the Integrity Check for the image, and we do not 
 ;  process a Rescind Action if the IQ Check fails.
 ;           
 ; Return Values
 ; =============
 ; Results are passed back in the MAGRY Array
 ; if error found during execution
 ;   MAGRY(0) = 0^Error message"
 ;   MAGRY(1..N) = messages describing the Error.
 ;   
 ; if success, the result array is same as Import API
 ;   MAGRY(0) = 1^Success
 ;   MAGRY(1) = TRKID   -  Tracking ID
 ;   MAGRY(2) = QUE     -  Queue Number from IMPORT QUEUE File(#2006.034)
 ;   
 ;   Tracking ID is a field in each of the following files: 
 ;      IMAGE File (#2005) (Field #108) (index "ATRKID")
 ;      IMAGING WINDOWS SESSION File (#2006.82) (Field #8) (index "E")
 ;      ACQUISITION SESSION FILE File(#2006.041)(Field #.02) (index "C")
 ;
 ; 
RSND1(MAGRY,MAGIEN,TIUDA,DELREAS) ; Main entry point to rescind an Image
 N QARR,TRKID,CALLBACK
 N RSLT,REASON,REASDA,MAGTDAT
 N I,QCT,N0,N2,N40,N100,MAGLT
 N IMGSPLCS,MAGRQA
 N MAGTMP
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^"_$T(+0)
 ;
 S MAGIEN=$G(MAGIEN),TIUDA=$G(TIUDA)
 ;  Quit if MAGIEN is deleted.
 I $$ISDEL^MAGGI11(MAGIEN) D  Q
 . S MAGRY(0)="0^Image: "_MAGIEN_" is Deleted"
 . Q
 ;   Check for TIUDA, and TIUDA, is same as Image Entry.
 I 'TIUDA S MAGRY(0)="0^A TIU Note is required" Q
 ;   If Group Image, use Group (MAGTMP) for next check.
 ;   because the group image won't point to TIU, only Group Parent.
 S MAGTMP=MAGIEN
 I $P(^MAG(2005,MAGIEN,0),"^",10) S MAGTMP=$P(^MAG(2005,MAGIEN,0),"^",10)
 I $$GET1^DIQ(2005,MAGTMP_",",17,"I")'=TIUDA D  Q
 . S MAGRY(0)="0^Mismatch between the TIU Note parameter and TIU Note linked to Image"
 . S MAGRY(1)="TIU Note: "_TIUDA_"   Image: "_MAGIEN
 . Q
 ;   Run the Integrity Checker, quit if it finds problem
 D CHK^MAGGSQI(.MAGRQA,MAGIEN) I 'MAGRQA(0) D  Q
 . S MAGRY(0)=MAGRQA(0)
 . Q
 ;   Quit if Image is already Rescinded, 
 ;   (checking Field # 115.2 LINKED TYPE) 
 S MAGLT=$$GET1^DIQ(2005,MAGIEN_",",115.2,"I") I MAGLT=1 D  Q
 . S MAGRY(0)="0^Image is already Rescinded."
 . S MAGRY(1)="RESCIND Action is Canceled."
 . Q
 ;
 S MAGRY(0)="0^Processing Rescind request..."
 ;
 S CALLBACK="STATCB^MAGGSIU4"
 S REASON=$G(DELREAS,"Rescinded TIU Note")
 S REASDA=$$FIND1^DIC(2005.88,"","X",REASON)
 ;  Get data for TIU Note.
 D DATA^MAGGNTI(.MAGTDAT,TIUDA)
 ; 
 ;   IMGSPLCS : Image paths and Image places.
 ;   Get string of Full File Path's | File Places.  
 ;   This is needed after success, to Delete the Files from Image Network.
 ;   i.e.  Image Full Path^Abs full Path^Big full Path|Image Place^Abs Place^Big Place
 S IMGSPLCS=$$IMGPLC(MAGIEN)
 S I=0,QCT=0
 ;   
 S N0=$G(^MAG(2005,MAGIEN,0))
 S N2=$G(^MAG(2005,MAGIEN,2))
 S N40=$G(^MAG(2005,MAGIEN,40))
 S N100=$G(^MAG(2005,MAGIEN,100))
 ; 
 ; We Delete the image entry first, then set the Import Queue.
 S RSLT=$$DELETE^MAGGSIU4(MAGIEN,REASON)
 ; Quit if we can't delete.
 I $P(RSLT,"^",1)=0 D  Q  ;
 . S MAGRY(0)=RSLT
 . Q
 ;
 S TRKID=$$TRKID^MAGGSIU4()  ; Get unique Import API tracking ID
 I TRKID=0 S MAGRY(0)="0^Error generating a Tracking ID" Q
 ;
 ; Set up Import queue data
 ;--
 ;   ACTION is the new Import Data Code.  We'll send 'RESCIND' to the
 ;   Active X control for special processing.
 S QCT=QCT+1,QARR(QCT)="ACTION^RESCIND"
 S QCT=QCT+1,QARR(QCT)="PXIEN^"_TIUDA        ; IEN of TIU note
 S QCT=QCT+1,QARR(QCT)="TRKID^"_TRKID        ; Import API Track ID
 S QCT=QCT+1,QARR(QCT)="STSCB^"_CALLBACK  ; Status call back routine
 ;   The format of 'IMAGE' Data for a Rescind is different than for
 ;   a Normal Image Import.  This is by design so that the
 ;   old version of the IAPI (called by BP Patch 39 and before)
 ;   does not process this import.
 S QCT=QCT+1,QARR(QCT)="IMAGE"_"^"_MAGIEN_"^"_IMGSPLCS
 ;
 ;  Now, set the Required data (plus new data) then call MAGGSIUI the
 ;  same as always. It'll set an IMPORT QUEUE (#2006.034)
 ;  and track the data in the IMAGING WINDOWS SESSION file (#2006.82)
 ;  the same as all imports.
 ;
 S QCT=QCT+1,QARR(QCT)="PXPKG^8925"
 S QCT=QCT+1,QARR(QCT)="PXDT^"_$P(MAGTDAT,"^",3)
 S QCT=QCT+1,QARR(QCT)="IDFN^"_$P(N0,"^",7)
 S QCT=QCT+1,QARR(QCT)="ACQS^"_DUZ(2)
 S QCT=QCT+1,QARR(QCT)="ACQD^"_"IAPI" ; This is the acquisition device. Import API.
 S QCT=QCT+1,QARR(QCT)="GDESC^"_$E("RESCINDED "_$p(N2,"^",4),1,60)
 ;gek/p121t2  Force IXTYPE to be ADVANCE DIRECTIVE to fix IMED issue of 
 ;  indexing AD's as Miscelleneous Document. 
 S QCT=QCT+1,QARR(QCT)="IXTYPE^"_"ADVANCE DIRECTIVE" ;$P(N40,"^",3)  
 S QCT=QCT+1,QARR(QCT)="IXPROC^"_$P(N40,"^",4)
 S QCT=QCT+1,QARR(QCT)="IXSPEC^"_$P(N40,"^",5)
 S QCT=QCT+1,QARR(QCT)="IXORIGIN^"_$P(N40,"^",6)
 ; To this point, all data in array will be passed back from OCX.
 ; The data Below : will be validated in the call to REMOTE^MAGGSIUI, and stored in the Session
 ; File, but won't be returned in the call to ADD^MAGGSIA.   the old design of the IAPI prohibits
 ; data except for the Import Codes known by IAPI.  So in ADD^MAGGSIA1 before the call to UPDATE^DIC,
 ; the data for these fields (for Rescinded Import)  will need to be retrieved from the
 ; Session file and added to the FDA array.
 ; 
 ; PROCEDURE  #6
 ; CREATION DATE #110
 ; LINKED IMAGE  #115.1
 ; LINKED TYPE   #115.2
 ; LINKED DATE   #115.3  (DATE TIME)
 ; 
 ; make sure the procedure field is not too long.
 S QCT=QCT+1,QARR(QCT)="6^"_$E($P(N0,"^",8),1,10)
 S QCT=QCT+1,QARR(QCT)="110^"_$P(N100,"^",6)
 S QCT=QCT+1,QARR(QCT)="115.1^"_MAGIEN ;comment this out for testing.
 S QCT=QCT+1,QARR(QCT)="115.2^"_"1" ; 1 = RESCIND
 S QCT=QCT+1,QARR(QCT)="115.3^"_$$NOW^XLFDT
 ;
 K MAGRY
 D REMOTE^MAGGSIUI(.MAGRY,.QARR)
 I MAGRY(0) D
 . S MAGRY($O(MAGRY(""),-1)+1)="TrkID: "_$G(TRKID)
 . S MAGRY($O(MAGRY(""),-1)+1)="Queue: "_+MAGRY(0)
 . Q
 Q
 ; ----- ERRA ---- Error trap 
ERRA ; Error Trap for RSND1 - Array Return - MAGRY
 N ERR S ERR=$$EC^%ZOSV
 S MAGRY(0)="0^"_ERR
 S MAGRY($O(MAGRY(""),-1)+1)=ERR
 D LOGERR^MAGGTERR(ERR)
 D @^%ZOSF("ERRTN")
 Q
 ; ----- IMGPLC ---- internal call to return Image paths and places.
 ;     MAGIEN = IMAGE File (#2005) internal entry number.
IMGPLC(MAGIEN) ; return a string of FullFile^AbsFile^BigFile|FullPlace^AbsPlace^BigPlace
 ; 
 N MAGXX,MAGPLC,FPATH
 N RFILE,RPLC
 ; Here we 'New' the variables returned by MAGFILEB so they are cleared after this call.
 N MAGFILE,MAGFILE1,MAGFILE2,MAGJBOL,MAGOFFLN
 S RFILE="",RPLC=""
 ;   Get Full Path and Place
 S MAGXX=MAGIEN,MAGPLC=$$DA2PLC^MAGBAPIP(MAGIEN,"F")
 D VSTNOCP^MAGFILEB
 S FPATH=$P(MAGFILE2,"~",1) I FPATH="-1" S FPATH=""
 S RFILE=RFILE_"^"_FPATH,RPLC=RPLC_"^"_MAGPLC
 ;
 ;   Get Abs Path and Place
 S MAGXX=MAGIEN,MAGPLC=$$DA2PLC^MAGBAPIP(MAGIEN,"A")
 D ABSNOCP^MAGFILEB
 S FPATH=$P(MAGFILE2,"~",1) I FPATH="-1" S FPATH=""
 S RFILE=RFILE_"^"_FPATH,RPLC=RPLC_"^"_MAGPLC
 ;
 ;   Get Big Patch and Place
 S MAGXX=MAGIEN,MAGPLC=$$DA2PLC^MAGBAPIP(MAGIEN,"B")
 D BIGNOCP^MAGFILEB
 S FPATH=$P(MAGFILE2,"~",1) I FPATH="-1" S FPATH=""
 S RFILE=RFILE_"^"_FPATH,RPLC=RPLC_"^"_MAGPLC
 ; get rid of first '^'
 Q $E(RFILE,2,999)_"|"_$E(RPLC,2,999)
