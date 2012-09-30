MAGGSIA1 ;WOIFO/GEK/SG/NST - RPC Call to Add Image File entry ; 01 Nov 2010 2:08 PM
 ;;3.0;IMAGING;**7,8,85,59,93,106,117,121**;Mar 19, 2002;Build 2340;Oct 20, 2011
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
PRE(MAGERR,MAGGFDA,MAGGRP,MAGGDRV,MAGREF) ;
 ;  Check on some possible problems: required fields etc.
 ;  Object Type and (Patient, or Short Desc) Required.
 N MAGRSLT,X,Z
 ; Patch 106: PRE^MAGGSIA1 is called by Import API only so
 ; if CAPTURE APPLICATION field (#8.1) is not set we set it to "I"
 ; For VI Capture and DICOM Gateway the value of #8.1 is set
 ; in ADD^MAGGTIA 
 I '$D(MAGGFDA(2005,"+1,",8.1)) S MAGGFDA(2005,"+1,",8.1)="I"
 ;
 D CHKRSND ; Check if this is a Rescinded Import.
 S:$G(MAGGFDA(2005,"+1,",113))="" MAGGFDA(2005,"+1,",113)=1  ; Patch 117 Set STATUS (#113) to Viewable (1)
 I '$D(MAGGFDA(2005,"+1,",3)) D OBJTYPE
 I '$D(MAGGFDA(2005,"+1,",3)) S MAGERR="0^Need an Object Type " Q
 I '$D(MAGGFDA(2005,"+1,",5)),'$D(MAGGFDA(2005,"+1,",10)) D  Q
 . S MAGERR="0^Need Patient or Short Desc.  Operation CANCELED "
 ; IF no Procedure text we'll give it some so crossref will set.
 D PATCHK(.MAGRSLT) I 'MAGRSLT S MAGERR=MAGRSLT Q
 ; Patch 8 IAPI We Create IXCLS (#41 CLASS) and  IXPKG (#40 Package) if TYPE is in Data.
 ; But we are not making TYPE required yet for backward compatibility.
 I $D(MAGGFDA(2005,"+1,",42)) D
 . I $$GET1^DIQ(2005.83,MAGGFDA(2005,"+1,",42),2,"E")="INACTIVE" D  S MAGRY=MAGERR Q
 . . S MAGERR="0^Index Type: "_$$GET1^DIQ(2005.83,MAGGFDA(2005,"+1,",42),.01,"E")_"is INACTIVE"
 . I '$D(MAGGFDA(2005,"+1,",41)) D MAKECLAS^MAGGSIU1 I $L(MAGERR) S MAGRY=MAGERR Q
 . I ($D(MAGGFDA(2005,"+1,",16)))&($$ISTYPADM(MAGGFDA(2005,"+1,",42))) D  S MAGRY=MAGERR Q
 . . S MAGERR="0^Can't have an ADMIN TYPE with Clinical Image."
 . I '$D(MAGGFDA(2005,"+1,",40)) D MAKEPKG^MAGGSIU1 I $L(MAGERR) S MAGRY=MAGERR Q
 . I '$D(MAGGFDA(2005,"+1,",6)) D MAKEPROC^MAGGSIU1 I $L(MAGERR) S MAGRY=MAGERR Q
 . I '$D(MAGGFDA(2005,"+1,",45)) D MAKEORIG^MAGGSIU1 I $L(MAGERR) S MAGRY=MAGERR Q
 . Q
 ;
 I '$D(MAGGFDA(2005,"+1,",6)) D PROCTEXT
 ;
 ; If no Procedure/Exam Date/Time we'll give it DocDT, or NOW
 I '$D(MAGGFDA(2005,"+1,",15)) D
 . I $D(MAGGFDA(2005,"+1,",110)) S MAGGFDA(2005,"+1,",15)=MAGGFDA(2005,"+1,",110) Q
 . S MAGGFDA(2005,"+1,",15)=$E($$NOW^XLFDT,1,12)
 ; DateTime image saved.
 I '$D(MAGGFDA(2005,"+1,",7)) S MAGGFDA(2005,"+1,",7)=$E($$NOW^XLFDT,1,12)
 ; Short Description
 ;I '$D(MAGGFDA(2005,"+1,",10)) S MAGGFDA(2005,"+1,",10)=$$MAKENAME^MAGGSIU1(.MAGGFDA)
 I '$D(MAGGFDA(2005,"+1,",10)) S MAGGFDA(2005,"+1,",10)=$G(MAGGFDA(2005,"+1,",6))
 ; Name (.01)
 I '$D(MAGGFDA(2005,"+1,",.01)) S MAGGFDA(2005,"+1,",.01)=$$MAKENAME^MAGGSIU1(.MAGGFDA)
 I '$D(MAGGFDA(2005,"+1,",8)) S MAGGFDA(2005,"+1,",8)=$G(DUZ)
 ; Acquisition Site, Use it to tell where to save the file.
 I $D(MAGACT("ACQS")) D
 . ; Patch 8 Have to modify: Field 105 (Acquisition Site) is NOW Field .05
 . I $P(MAGACT("ACQS"),";")]"" S MAGGFDA(2005,"+1,",.05)=$P(MAGACT("ACQS"),";")
 ; Only get drive:dir if not a group
 I 'MAGGRP D  I $L(MAGERR) Q
 . ; The value of the Action Code "WRITE^value" OVERRIDES any Write Location
 . ; sent as field # 2 in the input array. (The only value we check for is "PACS" from peter's code)
 . S X=$S($D(MAGACT("WRITE")):MAGACT("WRITE"),$D(MAGGFDA(2005,"+1,",2)):MAGGFDA(2005,"+1,",2),1:"")
 . ;P85 Send ACQS as second Param. $$DRIVE will use ACQS If X = ""
 . ;
 . S Z=$$DRIVE^MAGGTU1(X,$G(MAGGFDA(2005,"+1,",.05))) ;Drv:Dir to Write
 . I 'Z S MAGERR=Z Q
 . S MAGGDRV=$P(Z,U,2)
 . S MAGGFDA(2005,"+1,",2)=+Z               ;Disk & Vol magnetic
 . ; if a big file is being made on workstation, put NetWork Location
 . ; pointer in the BIG NETWORK LOCATION field.
 . ; (BIG files default to same Network Location as FullRes (or PACS))
 . I $G(MAGACT("BIG"))=1 S MAGGFDA(2005,"+1,",102)=+Z
 . S MAGREF=+Z ; save network location ien for $$DIRHASH in ^MAGGSIA1
 . I $G(MAGACT("ABS"))="STUFFONLY" S MAGGFDA(2005,"+1,",2.1)=+Z
 ;
 I $D(MAGACT("ACQL")) S MAGGFDA(2005,"+1,",101)=MAGACT("ACQL")
 ; HERE we are putting PRE Processing for the Import API action codes.
 ; "ACQD,ACQS" If Acquisition device entry doesn't exist, create it.
 I $D(MAGACT("ACQD")) D
 . ; IF Value is a pointer to the ACQ DEVICE File Quit.  If it's invalid then UPDATE will catch it.
 . I (+MAGACT("ACQD")=MAGACT("ACQD")) S MAGGFDA(2005,"+1,",107)=MAGACT("ACQD") Q
 . I $D(^MAG(2006.04,"B",MAGACT("ACQD"))) D  Q
 . . ; IF Already exists, add it to the FDA
 . . S MAGGFDA(2005,"+1,",107)=$O(^MAG(2006.04,"B",MAGACT("ACQD"),""))
 . . ; What do we do with the Acquisition Site. IF Acq Dev already exists. ? 
 . . ; ??
 . ; IF it doesn't exist, create it, and add it's ien to the image entry 
 . N MAGDFDA,MAGDIEN,MAGDXE
 . S MAGDFDA(2006.04,"+1,",.01)=MAGACT("ACQD")
 . S MAGDFDA(2006.04,"+1,",1)=$S($D(MAGACT("ACQS")):$P(MAGACT("ACQS"),";"),1:$G(MAGGFDA(2005,"+1,",.05)))
 . S MAGDFDA(2006.04,"+1,",2)=$S($D(MAGACT("ACQL")):MAGACT("ACQL"),$D(MAGGFDA(2005,"+1,",101)):MAGGFDA(2005,"+1,",101),1:$P($G(MAGACT("ACQS")),";",2))
 . ; ACQS was a 2 ';' piece value with Acq Location (HOSPITAL LOCATION) as 2nd piece
 . ;   now it is sent as it's own value in ACQL
 . D UPDATE^DIE("","MAGDFDA","MAGDIEN","MAGDXE")
 . S MAGGFDA(2005,"+1,",107)=MAGDIEN(1)
 ;~~~ Delete this comment and the following line of code when
 ;    the IMAGE AUDIT file (#2005.1) is completely eliminated.
 ;    If the last IEN in the IMAGE AUDIT file is greater than the
 ;~~~ last IEN in the IMAGE file, update the IMAGE file header.
 I ($O(^MAG(2005,"A"),-1)<$O(^MAG(2005.1,"A"),-1)) S $P(^MAG(2005,0),U,3)=$O(^MAG(2005.1,"A"),-1)
 ;
 Q
PATCHK(MAGR) ; This uses the FDA Array and checks the Imaging Patient against the Procedure patient
 ;
 N MAGDFN,PX,PXDA,MAGY
 S PX=$G(MAGGFDA(2005,"+1,",16))
 S PXDA=$G(MAGGFDA(2005,"+1,",17))
 I 'PX S MAGR=1 Q  ; This is a category, or an Image of a group (no parent pointer)
 S MAGDFN=MAGGFDA(2005,"+1,",5)
 I (PX=8925) D  Q
 . I '$D(^TIU(8925,PXDA)) S MAGR="0^Invalid TIU Entry Number: "_PXDA Q
 . D DATA^MAGGNTI(.MAGY,PXDA)
 . I '(MAGDFN=$P(MAGY,U,4)) S MAGR="0^Procedure and Imaging patients don't match." Q
 . S MAGR=1
 Q
OBJTYPE ; This call uses the EXT and computes an Object Type
 N MTYPE
 I '$L($G(MAGACT("EXT"))) Q
 S MTYPE=$O(^MAG(2005.02,"AD",MAGACT("EXT"),""))
 ;I 'MTYPE Q
 ;TODO : Answer question, do we want to have a default Image type ?
 I 'MTYPE S MTYPE=1
 S MAGGFDA(2005,"+1,",3)=MTYPE
 Q
ISTYPADM(TYPE) ; Returns 1 if this is an Admin Type
 N CL
 I '$G(TYPE) Q 0
 S CL=$$GET1^DIQ(2005.83,TYPE,1,"E")
 Q $S($E(CL,1,5)="ADMIN":1,1:0)
PROCTEXT ;This call uses flds 16 and 17 to compute fld #6 PROCEDURE TEXT [8F]
 ; We are here because fld #6 PROCEDURE [8F] is null.
 ; If a pointer to a package is in the data, (flds 16 and 17)
 ;  get fld #6 from that , if not then treat it as an UNASSIGNED image 
 ; i.e. Category UNASSIGNED.
 N MAGYPX,PARENT,PARIEN,PXDESC
 S PARENT=$G(MAGGFDA(2005,"+1,",16))
 S PARIEN=$G(MAGGFDA(2005,"+1,",17))
 ;
 I (PARENT=8925),(PARIEN]"") D  Q
 . D DATA^MAGGNTI(.MAGYPX,PARIEN)
 . S MAGGFDA(2005,"+1,",6)=$P(MAGYPX,U,2)
 ;TODO; create calls to get default procedure desc for all specialties
 ; AND default to NONE if a TYPE and no PARENT data File (fld 16)
 ; If a Parent pointer exists, and it isn't TIU, for now set "NO Description"
 I PARENT]"" S MAGGFDA(2005,"+1,",6)="No Description" Q
 ;
 ; Do we have a pointer to a MAG DESCRIPTIVE CATEGORY
 I ($G(MAGGFDA(2005,"+1,",100))]"") D  Q
 . S MAGGFDA(2005,"+1,",6)=$P(^MAG(2005.81,MAGGFDA(2005,"+1,",100),0),U,1)
 ; 
 ; If a new child of a Group, use that Proc Desc
 I $G(MAGGFDA(2005,"+1,",14))]"" D  Q
 . S MAGGFDA(2005,"+1,",6)=$P(^MAG(2005,MAGGFDA(2005,"+1,",14),0),U,8)
 ;
 ; Parent="", and no Category pointer, then we Call it UNASSIGNED
 S MAGGFDA(2005,"+1,",100)=$O(^MAG(2005.81,"B","UNASSIGNED",""))
 S MAGGFDA(2005,"+1,",6)="UNASSIGNED"
 Q
 ; ----------   CHKRSND ----------
 ; Import API Delphi Component/OCX only allows certain fields.  To get 
 ; around that limitation, we sometimes need to get data from the 
 ; IMAGING WINDOWS SESSION File. (#2006.82)
 ;  
 ;   Here we add data to MAGGFDA from fields in Session file 
 ;   that didn't make it thought the Delphi Component/OCX
CHKRSND ;
 N IDATA,TRKID
 S TRKID=$G(MAGGFDA(2005,"+1,",108)) Q:'$L(TRKID)
 D GETIAPID^MAGGSIUI(.IDATA,TRKID)
 ; 
 ; PROCEDURE #6
 ; CREATION DATE #110
 ; LINKED IMAGE  #115.1
 ; LINKED TYPE   #115.2
 ; LINKED DATE   #115.3  (DATE TIME)
 ; 
 ;  Here we can add other fields to MAGGFDA, that aren't passed through
 ;  the delphi control, but are stored in the Session file for the Import.
 ; If not rescind action, then QUIT
 I $G(IDATA("ACTION"))'="RESCIND" Q
 ; get the LINKED IMAGE and associated fields #115*
 ; All data was already validated before added to session file.
 I $G(IDATA(6))'="" S MAGGFDA(2005,"+1,",6)=$G(IDATA(6))
 I $G(IDATA(110))'="" S MAGGFDA(2005,"+1,",110)=$G(IDATA(110))
 I $G(IDATA(115.1))'="" S MAGGFDA(2005,"+1,",115.1)=$G(IDATA(115.1))
 I $G(IDATA(115.2))'="" S MAGGFDA(2005,"+1,",115.2)=$G(IDATA(115.2))
 I $G(IDATA(115.3))'="" S MAGGFDA(2005,"+1,",115.3)=$G(IDATA(115.3))
 Q
