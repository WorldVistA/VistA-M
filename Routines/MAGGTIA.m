MAGGTIA ;WOIFO/GEK/RMP/NST - Imaging RPC Broker calls. Add/Modify Image entry ; 20 Dec 2010 4:07 PM
 ;;3.0;IMAGING;**8,48,106**;Mar 19, 2002;Build 2002;Feb 28, 2011
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
 ;**** CALLING ROUTINE is responsible for RENAMING THE IMAGE FILE
 ;**** on DISK TO THE NEW FILE NAME RETURNED BY THIS CALL.
 ;
ADD(MAGRY,MAGGZ) ; RPC [MAGGADDIMAGE] 
 ; Call to UPDATE^DIE to Add an Image File entry
 ; MAGGZ is an array of fields and their entries
 ;  i.e. MAGGZ(1)=".5^38"  Image File,  field .5   data is 38
 ; If Long Description is included in fields, we create a new
 ;  array to hold the text, and pass that to UPDATE^DIE
 ; If this entry is an object group
 ;  i.e. MAGGZ(n)="2005.04^344"
 ;   (the field 2005.04 is the OBJECT GROUP MULTIPLE)
 ;
 ; MAGRY - Ret variable (Single Variable)
 ;  
 ;   Changed to include hierarchical directory hash  - PMK 04/23/98
 ;   If successful   MAGRY = IEN^FILE NAME (with full path)
 ;        IEN is Internal Entry Number of ^MAG(2005
 ;   If UNsuccessful MAGRY = 0^Error desc
 ;
 ; CALLING ROUTINE is responsible for RENAMING THE IMAGE FILE on DISK
 ;   TO THE NEW FILE NAME RETURNED BY THIS CALL.
 ;----------------------------------------------------------------
 N MAGGXE,MAGGFDA,MAGGIEN,MAGGDRV,MAGGR,MAGGRC,MAGGDA,MAGGFNM
 N MAGGWP,MAGGWPC,MAGGFLD,MAGGDAT,MAGERR,MAGGEXT,MAGGJB
 N MAGADD,MAGMOD,MAGWRITE,MAGREF,MAGDHASH,MAGDCMSN,MAGDCMIN
 N MAGBIG,MAGGABS,MAGQY,MAGRET,MAGETXT
 N MAGFSPEC,MAGFNM
 N I,J,X,Y,Z,ZZ
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 ;
 S MAGADD=1 ;Flag says we are adding an entry.
 S MAGRY="0^Starting Add Image Entry"
 S MAGERR="",MAGGR=0,MAGGRC=1,MAGGWPC=0
 I ($D(MAGGZ)<10) S MAGRY="0^No input data, Operation CANCELED" Q
 ;
 S Z="" F  S Z=$O(MAGGZ(Z)) Q:Z=""  D  I $L(MAGERR) Q
 . S MAGGFLD=$P(MAGGZ(Z),U,1),MAGGDAT=$P(MAGGZ(Z),U,2,99)
 . I MAGGFLD=""!(MAGGDAT="") S MAGRY="0^Field and Value are Required" Q
 . I MAGGFLD=5 S MAGGDAT=+MAGGDAT ; MOD RED 10/5/95
 . I MAGGFLD=2005.04 S MAGGDAT=+MAGGDAT ; MOD RED 10/18/95
 . I MAGGFLD="IEN" S MAGMOD=+MAGGDAT Q
 . I MAGGFLD="EXT" S MAGGEXT=MAGGDAT Q
 . I MAGGFLD="ABS" S MAGGABS=MAGGDAT Q
 . I MAGGFLD="JB" S MAGGJB=MAGGDAT Q
 . I MAGGFLD="WRITE" S MAGWRITE=MAGGDAT Q
 . I MAGGFLD="BIG" S MAGBIG=MAGGDAT Q
 . I MAGGFLD="DICOMSN" S MAGDCMSN=MAGGDAT Q
 . I MAGGFLD="DICOMIN" S MAGDCMIN=MAGGDAT Q
 . ;
 . ; if this is a group object.
 . I MAGGFLD=2005.04 D  Q
 . . S MAGGR=1
 . . I '+MAGGDAT Q  ; making a group entry, with no group entries.
 . . S MAGGR(MAGGDAT)=""
 . . S MAGGRC=MAGGRC+1
 . . I '$D(^MAG(2005,MAGGDAT,0)) S MAGERR="0^Group Object "_MAGGDAT_" doesn't exist"
 . . S MAGGFDA(2005.04,"+"_MAGGRC_",+1,",.01)=MAGGDAT
 . ;
 . ; if we are getting a WP for Long Desc, set array to pass.
 . I MAGGFLD=11 D  ; this is a line of the WP Long Desc field.
 . . S MAGGWPC=MAGGWPC+1,MAGGWP(MAGGWPC)=MAGGDAT
 . ;
 . ;if a BAD field number
 . I '$$VFIELD^DILFD(2005,MAGGFLD) S MAGERR="0^Field Number "_MAGGFLD_" doesn't exist" Q
 . ;
 . ; Get Field Specifiers
 . D FIELD^DID(2005,MAGGFLD,"","LABEL;SPECIFIER","MAGFSPEC")
 . ; if a Date field, we'll convert it here.
 . I (MAGFSPEC("SPECIFIER")["D") D  Q:$L(MAGERR)
 . . S %DT="T",X=MAGGDAT D ^%DT
 . . I Y=-1 S MAGERR="0^Invalid Date: "_MAGGDAT_" Field: "_MAGFSPEC("LABEL") Q
 . . S MAGGDAT=Y
 . ;
 . ;  if a pointer field, we'll assure the pointed to entry exists.
 . I (MAGFSPEC("SPECIFIER")["P") D  Q:$L(MAGERR)
 . . I ($$EXTERNAL^DILFD(2005,MAGGFLD,"",MAGGDAT)="") S MAGERR="0^Invalid Value for Field "_MAGFSPEC("LABEL") Q
 . ;
 . I (MAGFSPEC("SPECIFIER")["S") D  Q:$L(MAGERR)
 . . D VAL^DIE(2005,"",MAGGFLD,"",MAGGDAT,.MAGRET,"","MAGETXT") I MAGRET="^" D  Q
 . . . S MAGERR="0^"_MAGETXT("DIERR",1,"TEXT",1)
 . . ;P48T1 This assures we are filing the Internal code for a set.
 . . S MAGGDAT=MAGRET
 . ;
 . ; made it here, so set the Node for the UPDATE^DIC Call.
 . S MAGGFDA(2005,"+1,",MAGGFLD)=MAGGDAT
 ;
 ; if there was an Error in data we'll quit now.
 I $L(MAGERR) S MAGRY=MAGERR Q
 I $D(MAGMOD) D
 . I $D(MAGGWP) S MAGGFDA(2005,"+1,",11)="MAGGWP"
 . S MAGMOD=MAGMOD_","
 . M MAGXXX(2005,MAGMOD)=MAGGFDA(2005,"+1,") K MAGGFDA
 . M MAGGFDA=MAGXXX K MAGXXX
 I $D(MAGMOD) D ADD^MAGGTIA1 Q
 ;
 ;  some possible problems, we'll check for now.
 I '$D(MAGGFDA(2005,"+1,")) S MAGRY="0^No data to file  Operation CANCELED " Q
 ;
 ; Patch 106: For VI Capture and DICOM Gateway the value of #8.1 is set
 ; here if it is not send. For Imort API see PRE^MAGGSIA1 
 I '$D(MAGGFDA(2005,"+1,",8.1)) D
 . ; PACS UID (#60); RADIOLOGY REPORT (#61); PACS PROCEDURE (#62)
 . I $D(MAGGFDA(2005,"+1,",60))!$D(MAGGFDA(2005,"+1,",61))!$D(MAGGFDA(2005,"+1,",62)) S MAGGFDA(2005,"+1,",8.1)="D" Q
 . I $D(MAGGFDA(2005,"+1,",108)) S MAGGFDA(2005,"+1,",8.1)="I" Q  ; TRACKING ID (#108)
 . S MAGGFDA(2005,"+1,",8.1)="C"
 . Q
 ;
 ;  We're making Object Type and either Patient, or short Desc Required.
 I '$D(MAGGFDA(2005,"+1,",3)) S MAGRY="0^Need an Object Type " Q
 ; Change to require patient. not patient or short desc.
 I '$D(MAGGFDA(2005,"+1,",5)) D  Q
 . S MAGRY="0^Need Patient.  Operation CANCELED "
 ; MAGQA check.
 D QACHK^MAGGTIA2(.MAGQY,MAGGFDA(2005,"+1,",5),$G(MAGGFDA(2005,"+1,",16)),$G(MAGGFDA(2005,"+1,",17)))
 I 'MAGQY S MAGRY=MAGQY Q
 ;-Checking for a missing TYPE value, and generating a value if needed
 ;- are being deferred to a later patch.
 ; Check for Image TYPE #42
 ;-I '$D(MAGGFDA(2005,"+1,",42)) D MAKETYPE^MAGGSIA1 I $L(MAGERR) S MAGRY=MAGERR Q
 ; Check for Image Class, #41
 I '$D(MAGGFDA(2005,"+1,",41)) D MAKECLAS^MAGGSIU1 I $L(MAGERR) S MAGRY=MAGERR Q
 ; IF no Procedure text we'll give it some so crossref will set.
 I '$D(MAGGFDA(2005,"+1,",6)) S MAGGFDA(2005,"+1,",6)="NO TEXT"
 ; If no Procedure/Exam Date/Time we'll give it NOW
 I '$D(MAGGFDA(2005,"+1,",15)) S MAGGFDA(2005,"+1,",15)=$$NOW^XLFDT
 ; DateTime image saved.
 I '$D(MAGGFDA(2005,"+1,",7)) S MAGGFDA(2005,"+1,",7)=$$NOW^XLFDT
 ; If no INSTITUTION pointer then default to the DUZ(2) or the Kernel Site parameter file institution
 I '$D(MAGGFDA(2005,"+1,",.05)) D
 . I $D(DUZ(2)) S MAGGFDA(2005,"+1,",.05)=DUZ(2) Q
 . ;Q:$T(KSP^XUPARAM)=""  //GEK 4/15/2004 Not needed on Gateway anymore
 . S MAGGFDA(2005,"+1,",.05)=$$KSP^XUPARAM("INST")
 . Q
 ;
 I '$D(MAGGFDA(2005,"+1,",10)) S MAGGFDA(2005,"+1,",10)=$$MAKENAME^MAGGTIA1()
 ; Only get drive:dir if not a group
 I 'MAGGR D  I $L(MAGERR) S MAGRY=MAGERR Q
 . S X=$S($D(MAGGFDA(2005,"+1,",2)):MAGGFDA(2005,"+1,",2),1:"")
 . S Z=$$DRIVE^MAGGTU1(X)                     ;Drv:Dir to Write
 . I 'Z S MAGERR=Z Q
 . S MAGGDRV=$P(Z,U,2)
 . S MAGGFDA(2005,"+1,",2)=+Z               ;Disk & Vol magnetic
 . ; if a big file is being made on workstation, put NetWork Location
 . ; pointer in the BIG NETWORK LOCATION field.
 . ; (BIG files default to same Network Location as FullRes (or PACS))
 . I ($P($G(MAGBIG),U,1))=1 D
 . . S MAGGFDA(2005,"+1,",102)=+Z
 . . S MAGGFDA(2005,"+1,",104)=$P(MAGBIG,U,2)
 . . Q
 . S MAGREF=+Z ; save network location ien for $$DIRHASH in ^MAGGTIA1
 . I $G(MAGGABS)="STUFFONLY" S MAGGFDA(2005,"+1,",2.1)=+Z
 ;
 ; If a Name (.01) wasn't sent, we'll make one
 ; We know that either Patient or Short Desc, and Object Type exist
 I '$D(MAGGFDA(2005,"+1,",.01)) S MAGGFDA(2005,"+1,",.01)=$$MAKENAME^MAGGTIA1()
 ;
 ; If a long description was sent.
 I $D(MAGGWP) S MAGGFDA(2005,"+1,",11)="MAGGWP"
 ;
 D ADD^MAGGTIA1 ; continued
 Q
