MAGGSQI ;WOIFO/GEK/SG - Image Integrity Checker ; 3/9/09 12:51pm
 ;;3.0;IMAGING;**8,93**;Dec 02, 2009;Build 163
 ;; Per VHA Directive 2004-038, this routine should not be modified.
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
RPT(MAGRY,CT,LASTIEN) ; Run the check for the last CT entries in Image file.
 N I,J,MAGX,ERRCT,ACTCT,TYPECT,MAGSTART,MAGPUR
 K ^XTMP("MAGCHK")
 S LASTIEN=$G(LASTIEN)
 ; See DOCU^MAGCRPT for documenation on this global
 D NOW^%DTC S MAGSTART=%
 S X1=%,X2=60 D C^%DTC S MAGPUR=X K X,X1,X2
 ;Set purge, create and purge date
 S $P(^XTMP("MAGCHK",$J,0),"^",1)=MAGPUR,$P(^(0),"^",2)=MAGSTART
 S $P(^XTMP("MAGCHK",$J,0),"^",5)=MAGSTART
 ;Set description
 S $P(^XTMP("MAGCHK",$J,0),"^",3)="Imaging Scan DB"
 ;Set status to active
 S $P(^XTMP("MAGCHK",$J,0),"^",4)="ACTIVE"
 S MAGRY(0)="0^Checking..."
 S I="A"
 S CT=$G(CT,5000),ERRCT=0,ACTCT=0
 F  S I=$O(^MAG(2005,I),-1) Q:CT<1  Q:'I  Q:I<LASTIEN  D
 . Q:$$ISDEL^MAGGI11(I)
 . S CT=CT-1,ACTCT=ACTCT+1
 . I '(ACTCT#1000) I IO(0)=IO U IO W "."
 . K MAGX
 . D CHK(.MAGX,I)
 . I +MAGX(0)'=1 S ERRCT=ERRCT+1 D
 . . S ^XTMP("MAGCHK",$J,+MAGX(0),I)=MAGX(0)
 . . S ^XTMP("MAGCHK",$J,"B",$P(MAGX(0),"^",2),I)=""
 . . S TYPECT($P(MAGX(0),"^",2))=$G(TYPECT($P(MAGX(0),"^",2)))+1
 I 'ERRCT S MAGRY(0)="0^All Okay"
 I ERRCT S MAGRY(0)=ERRCT_"^Errors of "_ACTCT_" Images Checked."
 S I="" F  S I=$O(TYPECT(I)) Q:I=""  D
 . S MAGRY($O(MAGRY(""),-1)+1)=TYPECT(I)_"^"_I
 ;Set status to complete
 S $P(^XTMP("MAGCHK",$J,0),"^",4)="COMPLETE"
 ;Set end time
 D NOW^%DTC
 S $P(^XTMP("MAGCHK",$J,0),"^",6)=%
 ;Set total number of entries checked
 S $P(^XTMP("MAGCHK",$J,0),"^",8)=ACTCT
 Q
CHK(MAGRY,MAGIEN) ;
 ;
 N ERR,MAGDFN,MAGPK,MAGPKDA,MAGPKIP,MAGPKDA1,Y,I,MAGISGRP,MAGRPIEN
 N MAGN2,MAGN0,MAGPDFIL,MAGRCT,MAGN100,MAGZ,VALID
 S MAGRCT=0,MAGISGRP=0
 S MAGRY(0)="0^Error during Image Integrity Check !"
 ;
 I $$ISDEL^MAGGI11(MAGIEN,.ERR)  S MAGRY(0)="1^Deleted Image"  Q
 I ERR<0  D  Q:ERR<0
 . I +ERR=-43  D  Q
 . . S ERR=0,I=$O(MAGRY(""),-1)+1
 . . S MAGRY(I)="2^Image IEN exists, and is Deleted !"
 . . Q
 . S MAGRY(0)="0^Invalid Image pointer"
 . Q
 ;
 S MAGN0=$G(^MAG(2005,MAGIEN,0))
 S MAGN2=$G(^MAG(2005,MAGIEN,2))
 S MAGN100=$G(^MAG(2005,MAGIEN,100))
 ;
 I $O(^MAG(2005,MAGIEN,1,0))!($P(MAGN0,U,6)=11) S MAGISGRP=1
 I MAGISGRP,'$O(^MAG(2005,MAGIEN,1,0)) S MAGRY(0)="0^Group of 0 images" Q
 ;
 S MAGPK=$P(MAGN2,U,6)
 S MAGPKDA=$P(MAGN2,U,7)
 S MAGPKIP=$P(MAGN2,U,8)
 S MAGPKDA1=$P(MAGN2,U,10)
 S MAGDFN=$P(MAGN0,U,7)
 ;
 ; If this image is a member of a group, compare some fields against the Group entry.
 I +$P(MAGN0,U,10) S MAGRPIEN=$P(MAGN0,U,10) D  Q
 . ;   Check the DFN's Quit if they don't match
 . I $P($G(^MAG(2005,MAGRPIEN,0)),U,7)'=MAGDFN S MAGRY(0)="0^Patient pointer mismatch between Image Group and Image" Q
 . ; if image has data in parent fields, Quit if not same as Group entry.
 . I +MAGPK,($P(MAGN2,U,6,7)'=$P($G(^MAG(2005,MAGRPIEN,2)),U,6,7)) S MAGRY(MAGRCT)="0^Pointer Mismatch in Group" Q
 . ;Have a check that assures that the Group has this image in it's multiple
 . ;   ? Do we want to do this when we have the Grp entry, for each of its members. ? 
 . S (I,VALID)=0 F  S I=$O(^MAG(2005,MAGRPIEN,1,I)) Q:'I  D  Q:VALID
 . . I +^MAG(2005,MAGRPIEN,1,I,0)=MAGIEN S VALID=1
 . I VALID S MAGRY(MAGRCT)="1^Valid Group image."
 . E  S MAGRY(MAGRCT)="0^Pointer Missing in Group entries."
 ;
 ; In current scheme of things, image points to Package or a Descriptive Categroy
 ;  So we can make the following assumption, but maybe not for long.
 I 'MAGPK,+MAGN100 S MAGRY(MAGRCT)="1^Image Category" Q
 I 'MAGPK,($P(MAGN0,U,6)=18) S MAGRY(MAGRCT)="1^Patient Photo" Q
 ;
 ; Old images Didn't require Parent Pointer,Parent root, Parent Image Pointer
 ;I 'MAGPK S MAGRY(0)="0^Missing the Parent file pointer" Q
 ;I 'MAGPKDA S MAGRY(0)="0^Missing the Parent root pointer" Q
 ;I 'MAGPKIP S MAGRY(0)="0^Missing the Parent image pointer" Q
 ;
 ; Surgery reports
 I (MAGPK=130) D  Q
 . ; Patch.  if MAGPK exists, but not a MAGPKDA
 . I 'MAGPKDA S MAGRY(0)="0^Missing the Parent root pointer" Q
 . I 'MAGPKIP S MAGRY(0)="0^Missing the Parent image pointer" Q
 . I '$D(^SRF(MAGPKDA,0)) S MAGRY(0)="0^Invalid Image pointer to associated package report entry" Q
 . I '$D(^SRF(MAGPKDA,2005,MAGPKIP,0)) S MAGRY="0^Invalid Image pointer in associated package file" Q
 . I '(MAGDFN=$P(^SRF(MAGPKDA,0),U,1)) S MAGRY(0)="0^Image and associated report have different patient pointers" Q
 . I '(MAGIEN=+$G(^SRF(MAGPKDA,2005,MAGPKIP,0))) S MAGRY(0)="0^Associated report does not point back to Image" Q
 . S MAGRY(0)="1^Okay"
 ;
 ; TIU documents;
 I MAGPK=8925 D  Q
 . ; Patch.  if MAGPK exists, but not a MAGPKDA
 . I 'MAGPKDA S MAGRY(0)="0^Missing the Parent root pointer" Q
 . I 'MAGPKIP S MAGRY(0)="0^Missing the Parent image pointer" Q
 . I '$D(^TIU(8925,MAGPKDA,0)) S MAGRY(0)="0^Invalid Image pointer to associated package report entry" Q
 . I '$D(^TIU(8925.91,MAGPKIP,0)) S MAGRY(0)="0^Invalid Image pointer in associated package file" Q
 . I '(MAGDFN=$P($G(^TIU(8925,MAGPKDA,0)),U,2)) S MAGRY(0)="0^Image and associated report have different patient pointers" Q
 . S MAGZ=MAGPKDA_"^"_MAGIEN
 . I '(MAGZ=$G(^TIU(8925.91,MAGPKIP,0))) S MAGRY(0)="0^Associated report does not point back to Image" Q
 . S MAGRY(0)="1^Okay"
 ;
 ; Medicine reports
 I ((MAGPK>689.999)&(MAGPK<703)) D  Q
 . ; Patch.  if MAGPK exists, but not a MAGPKDA
 . I 'MAGPKDA S MAGRY(0)="0^Missing the Parent root pointer" Q
 . I '$D(^MCAR(MAGPK,MAGPKDA,0)) S MAGRY(0)="0^Invalid Image pointer to associated package report entry" Q
 . I MAGPKIP I '$D(^MCAR(MAGPK,MAGPKDA,2005,MAGPKIP,0)) S MAGRY(0)="0^Invalid Image pointer in associated package file" Q
 . I '(MAGDFN=$P($G(^MCAR(MAGPK,MAGPKDA,0)),U,2)) S MAGRY(0)="0^Image and associated report have different patient pointers" Q
 . ;I '(MAGIEN=+^MCAR(MAGPK,MAGPKDA,2005,MAGPKIP,0)) S MAGRY(0)="0^Associated report does not point back to Image" Q
 . I '$D(^MCAR(MAGPK,MAGPKDA,2005,"B",MAGIEN)) S MAGRY(0)="0^Associated report does not point back to Image" Q
 . S MAGRY(0)="1^Okay"
 . ;
 . ;         S MCFILE=+$P($P(^MCAR(697.2,PSIEN,0),U,2),"(",2)
 . ;      S PATFLD=$O(^DD(MCFILE,"B","MEDICAL PATIENT",""))
 . ;         S:PATFLD="" PATFLD=1
 . ;
 . ;          S TMP=$P($P(^DD(MCFILE,PATFLD,0),U,4),";",2)
 . ;      Q $S(DFN'=$P(^MCAR(MCFILE,MCIEN,0),U,TMP):"O^Image and associated report have different patient pointers",1:"1")
 ;
 ; Radiology reports
 I MAGPK=74 D  Q
 . ; Patch.  if MAGPK exists, but not a MAGPKDA
 . I 'MAGPKDA S MAGRY(0)="0^Missing the Parent root pointer" Q
 . I '$D(^RARPT(MAGPKDA,0)) S MAGRY(0)="0^Invalid Image pointer to associated package report entry" Q
 . I MAGPKIP I '$D(^RARPT(MAGPKDA,2005,MAGPKIP,0)) S MAGRY(0)="0^Invalid Image pointer in associated package file" Q
 . ;
 . I '(MAGDFN=$P($G(^RARPT(MAGPKDA,0)),U,2)) S MAGRY(0)="0^Image and associated report have different patient pointers" Q
 . ;I '(MAGIEN=+$G(^RARPT(MAGPKDA,2005,MAGPKIP,0))) S MAGRY(0)="0^Associated report does not point back to Image" Q
 . I '$D(^RARPT(MAGPKDA,2005,"B",MAGIEN)) S MAGRY(0)="0^Associated report does not point back to Image" Q
 . S MAGRY(0)="1^Okay"
 ;
 ; Laboratory reports
 I (MAGPK>62.999)&(MAGPK<64) D  Q
 . ;I $P(^MAG(2005.03,MAGTMPRT,0),"^",4)=63
 . S MAGRY(0)="1^Lab image not checked "
 . ;D @$S(MAGTMPRT=63:"AU",MAGTMPRT=63.2:"AU",1:"LAB") Q
 ;
 S MAGRY(0)="2^Images only point to Patient."
 Q
CHKGRPCH(CHKY,GRPIEN,GRPDFN,GRPCH) ; Check the child of a Group.  
 ;       i.e. an IEN in the "1" node of the Group.
 ;       Can't just check the IEN by calling CHK.  It might be okay that way.
 ;       Have to compare it to Groups IEN, and DFN
 N CHN0
 S CHN0=$G(^MAG(2005,GRPCH,0)) I '$L(CHN0) S CHKY="0^Invalid Image pointer" Q
 I $P(CHN0,U,7)'=GRPDFN S CHKY="0^Patient Mismatch in Group member:"_GRPCH Q
 I $P(CHN0,U,10)'=GRPIEN S CHKY="0^Pointer Mismatch in Group member:"_GRPCH Q
 S CHKY="1^Okay Group Image"
 Q
