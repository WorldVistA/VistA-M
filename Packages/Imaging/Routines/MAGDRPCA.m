MAGDRPCA ;WOIFO/PMK/MLS/SG/JSL/SAF - Imaging RPCs for Importer ; 02 Nov 2009 8:47 AM
 ;;3.0;IMAGING;**53,123**;Mar 19, 2002;Build 67;Jul 24, 2012
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
CHECKUID(OUT,UIDLIST,LEVEL) ; RPC = MAG DICOM IMPORTER CHECK UIDS
 N COUNT,DUPCOUNT,DUPUID,ERROR,I,MAG0,MAGIEN,OBJECT
 I '$D(UIDLIST) S OUT(1)="-1,A list of UIDs must be supplied." Q
 I '$D(LEVEL) S OUT(1)="-2,Study or SOP Instance level must be specified." Q
 I LEVEL'="STUDY",LEVEL'="SOP" D  Q
 . S OUT(1)="-3,Level must be either ""STUDY"" or ""SOP -- """
 . S OUT(1)=OUT(1)_"the value """_LEVEL_""" was specified."
 . Q
 S COUNT=$G(UIDLIST(1)),ERROR=0
 I COUNT'>0 S OUT(1)="-4,Count of UIDs in list must be greater than zero." Q
 F I=2:1:COUNT+1 S UID=UIDLIST(I) D
 . S MAGIEN=$O(^MAG(2005,"P",UID,""))
 . I MAGIEN D
 . . S MAG0=$G(^MAG(2005,MAGIEN,0)),OBJECT=$P(MAG0,"^",6),DFN=$P(MAG0,"^",7)
 . . I LEVEL="STUDY" D  ; Study Instance UID
 . . . I OBJECT'=11 D  Q
 . . . . S OUT(I)="-5,Study Instance UID not pointing to an XRAY Group -- "
 . . . . S OUT(I)=OUT(I)_"MAGIEN = "_MAGIEN,ERROR=ERROR+1
 . . . . Q
 . . . S OUT(I)=$$LOOKUP1(MAGIEN)_"^"_$$DUPUID(LEVEL,UID)
 . . . Q
 . . E  D  ; SOP Instance UID
 . . . I OBJECT'=3,OBJECT'=100 D  Q
 . . . . S OUT(I)="-6,SOP Instance UID not pointing to an XRAY or a DICOM object -- "
 . . . . S OUT(I)=OUT(I)_"MAGIEN = "_MAGIEN,ERROR=ERROR+1
 . . . . Q
 . . . S OUT(I)=$$LOOKUP1(MAGIEN)_"^"_$$DUPUID(LEVEL,UID)
 . . . Q
 . . Q
 . E  S OUT(I)=""
 . Q
 I ERROR>1 S OUT(1)="-100,There were "_ERROR_" database inconsistency errors detected.  Look at returned data."
 E  I ERROR=1 S OUT(1)="-100,A database inconsistency error was detected. Look at returned data."
 E  S OUT(1)=COUNT
 Q
 ;
DUPUID(LEVEL,UID) ; return a list of ^MAG(2005) entries with dup uids
 N COUNT,DFN,DUPUID,I,MAG0,MAG2,MAGIEN,PARENT,RETURN,XREF,XREFLIST
 S MAGIEN=""
 F  S MAGIEN=$O(^MAG(2005,"P",UID,MAGIEN)) Q:MAGIEN=""  D
 . S MAG0=$G(^MAG(2005,MAGIEN,0)),DFN=$P(MAG0,"^",7)
 . S MAG2=$G(^MAG(2005,MAGIEN,2))
 . S PARENT="" F I=6,7,8,10 S PARENT=PARENT_"^"_$P(MAG2,"^",I)
 . S DUPUID(MAGIEN)=DFN_PARENT
 . S XREFLIST(DFN_PARENT,MAGIEN)=""
 . Q
 . ; remove duplicate Study UIDs for different groups for the same study
 I LEVEL="STUDY" D
 . S COUNT=0,XREF=""
 . F  S XREF=$O(XREFLIST(XREF)) Q:XREF=""  S COUNT=COUNT+1
 . I COUNT=1 K DUPUID
 . Q
 S COUNT=0,(MAGIEN,RETURN)=""
 F  S MAGIEN=$O(DUPUID(MAGIEN)) Q:MAGIEN=""  D
 . S RETURN=RETURN_"^"_MAGIEN,COUNT=COUNT+1
 . Q
 Q COUNT_RETURN
 ;
LOOKUP(OUT,MAGIEN) ; RPC = MAG DICOM IMPORTER LOOKUP
 S OUT=$$LOOKUP1(MAGIEN)
 Q
 ;
LOOKUP1(MAGIEN) ; patient and accession number lookup
 N DFN,I,MAG0,MAG2,NUMBER,OUT,TMP,VADM,X
 S MAG0=$G(^MAG(2005,MAGIEN,0)),MAG2=$G(^(2))
 S DFN=+$P(MAG0,"^",7)
 D  ; Protect variables that are referenced by the DEM^VADPT
 . N A,I,J,K,K1,NC,NF,NQ,T,VAHOW,VAPTYP,VAROOT,X
 . D DEM^VADPT  ; Supported IA (#10061)
 . Q
 S X="^"_DFN ; piece 1 is for an error message
 S X=X_"^"_VADM(1) ; patient name
 S X=X_"^"_VA("PID") ; patient id
 S TMP=$S(VADM(3)>0:17000000+VADM(3),1:"-1,Invalid date of birth")
 S X=X_"^"_TMP ; Patient DOB
 S X=X_"^"_$P(VADM(5),"^",1) ; patient sex
 ; $$GETICN^MPIF001 can return error code and message separated
 ; by "^". If this happens, the "^" is replaced by comma.
 S TMP=$S($T(GETICN^MPIF001)'="":$$GETICN^MPIF001(DFN),1:"-1^NO MPI") ; Supported IA (#2701)
 S X=X_"^"_$TR(TMP,"^",",") ; ICN
 I $P(MAG2,"^",6)=2006.5839 D  ; temporary consult association
 . N ACNUMB,GMRCIEN,MODIFIER,PROCNAME,STUDYDAT
 . S GMRCIEN=$P(MAG2,"^",7),ACNUMB="GMRC-"_GMRCIEN
 . S TMP=$$GET1^DIQ(123,GMRCIEN,.01,"I")\1
 . S STUDYDAT=$S(TMP>0:17000000+TMP,1:"-1,Invalid study date")
 . S PROCNAME=$$GET1^DIQ(123,GMRCIEN,1) ; TO SERVICE
 . S MODIFIER=$$GET1^DIQ(123,GMRCIEN,4) ; PROCEDURE
 . S X=X_"^"_ACNUMB_"^"_STUDYDAT_"^"_PROCNAME_"^"_MODIFIER
 . Q
 E  D  ; regular association
 . S NUMBER="`"_MAGIEN D IENLOOK^MAGDRPC9 ; lookup accession number
 . I OUT(1)<0 S X=OUT(1)_" detected in IENLOOK^MAGDRPC9"
 . E  S X=X_"^"_$P(OUT(2),"^",4,7) ; accession number, study date, procedure
 . Q
 Q X
 ;
 ;
 ;
GETDFN(OUT,ICN) ; RPC = MAG DICOM GET DFN
 S OUT=$S($T(GETDFN^MPIF001)'="":$$GETDFN^MPIF001(ICN),1:"-1^NO MPI") ; Supported IA (#2701)
 Q
 ;
 ;
 ;
ACNUMB(OUT,ACNUMB) ; RPC = MAG DICOM GET RAD INFO BY ACN
 N RADFN,RADTI,LIST,STATUS
 I $T(ACCFIND^RAAPI)'="" D  ; requires RA*5.0*47
 . S STATUS=$$ACCFIND^RAAPI(ACNUMB,.LIST) ; Private IA (#5020) 
 . Q
 E  D  ; before RA*5.0*47
 . S STATUS=$$ACCFIND(ACNUMB,.LIST)
 . Q
 I STATUS<0 S OUT=STATUS Q
 S OUT=STATUS_"^"_LIST(1)
 ; add the imaging location as 5th piece of the results
 S RADFN=$P(LIST(1),"^",1),RADTI=$P(LIST(1),"^",2)
 S OUT=OUT_"^"_$$GET1^DIQ(79.1,$P(^RADPT(RADFN,"DT",RADTI,0),"^",4),.01)
 Q
 ;
ACCFIND(Y,RAA) ; borrowed from RA*5.0*47
 ;
 ;input : Y=the accession number in either a 'sss-mmddyy-xxxxx' or
 ;          'mmddyy-xxxxx' format
 ;      : RAA(n)=the array used to return the data in the following
 ;               format RADFN_^_RADTI_^_RACNI
 ;
 ;return: n>0 successful, else n<0... 'n' is the number of array
 ;        elements when successful. When unsuccessful (n<0) 'n' is
 ;        a specific error dialog which is returned along with the
 ;        invalid accession number.
 ;
 ;        Examples:
 ;        -1^"invalid site accession number format"^accession #
 ;        -2^"invalid accession number format"^accession #
 ;        -3^"no data associated with this accession number"^accession #
 ;
 I $L(Y,"-")=3 Q:Y'?3N1"-"6N1"-"1.5N "-1^invalid site accession number format^"_Y
 I $L(Y,"-")=2 Q:Y'?6N1"-"1.5N "-2^invalid accession number format^"_Y
 N X S X=$S($L(Y,"-")=3:$NA(^RADPT("ADC1")),1:$NA(^RADPT("ADC"))) ; Private IA (#1172)
 Q:$O(@X@(Y,0))'>0 "-3^no data associated with this accession number^"_Y
 N RADFN,RADTI,RACNI,Z S:$D(U)#2=0 U="^"
 S (RADFN,Z)=0 F  S RADFN=$O(@X@(Y,RADFN)) Q:'RADFN  D
 . S RADTI=0 F  S RADTI=$O(@X@(Y,RADFN,RADTI)) Q:'RADTI  D
 . . S RACNI=0 F  S RACNI=$O(@X@(Y,RADFN,RADTI,RACNI)) Q:'RACNI  D
 . . . S Z=Z+1,RAA(Z)=RADFN_U_RADTI_U_RACNI
 . . . Q
 . . Q
 . Q
 Q Z ;success
 ;
 ;
 ;
DELETE(OUT,IMAGEUID,MACHID,FILEPATH) ; RPC = MAG DICOM IMPORTER DELETE
 S OUT=$$DELETE^MAGDIR8R(IMAGEUID,MACHID,FILEPATH)
 Q
 ;
 ;***** RETURNS THE LIST OF RADIOLOGY PROCEDURES
 ; RPC: MAG DICOM RADIOLOGY PROCEDURES
 ;
 ; .ARRAY        Reference to a local variable where results
 ;               are returned to.
 ;
 ; DIV           IEN of a record in the INSTITUTION file (#4)
 ;
PROC(ARRAY,DIV) ;
 N IMAGTYPE      ; IEN of the imaging type (file #79.2)
 N INACTDAT      ; Inactivation date of the procedure
 N OMLDAT        ; Outside imaging location data (file #2006.5759)
 N OMLIEN        ; IEN in OUTSIDE IMAGING LOCATION file (#2006.5759)
 N RADPROC       ; Radiology procedure data (file #71)
 N TODAY         ; today's date in Fileman format
 ;
 N BUF,ERROR,IEN,Z
 K ARRAY
 ;
 ;--- Validate parameters
 S DIV=$G(DIV)
 I (DIV'>0)!(DIV'=+DIV)  D  Q
 . S ARRAY(1)="-1,Invalid Institution IEN: '"_DIV_"'."
 . Q
 I $D(^DIC(4,DIV))<10  D  Q
 . S ARRAY(1)="-2,Institution with IEN="_DIV_" does not exist."
 . Q
 ;
 S ERROR=$$DISPLAY^MAGDAIRG(0)
 I ERROR=-1 D  Q
 . S ARRAY(1)="-3,""No Credit"" entries must be added to the IMAGING LOCATIONS file (#79.1)"
 . S ARRAY(2)=""
 . S ARRAY(3)="Use the IMPORTER MENU option CHECK OUTSIDE IMAGING LOCATION FILE"
 . S ARRAY(4)="on the VistA system to correct the problem."
 . Q
 I ERROR=-2 D  Q
 . S ARRAY(1)="-4,Entries must be added to the OUTSIDE IMAGING LOCATIONS file (#2006.5759)"
 . S ARRAY(2)=""
 . S ARRAY(3)="Use the IMPORTER MENU option BUILD OUTSIDE IMAGING LOCATION FILE"
 . S ARRAY(4)="on the VistA system to correct the problem."
 . Q
 I ERROR'=0 D  Q
 . S ARRAY(1)="-5,Unexpected error #"_ERROR_" returned by $$DISPLAY^MAGDAIRG(0)"
 . Q
 ;
 S (ARRAY(1),IEN)=0,TODAY=$$DT^XLFDT()
 F  S IEN=$O(^RAMIS(71,IEN))  Q:'IEN  D  ; Private IA (#1174) 
 . S RADPROC=^RAMIS(71,IEN,0),IMAGTYPE=+$P(RADPROC,U,12)
 . ;--- Get outside imaging location associated
 . ;--- with the imaging type of the procedure
 . S OMLIEN=$O(^MAGD(2006.5759,"D",DIV,IMAGTYPE,""))  Q:'OMLIEN
 . S OMLDAT=$G(^MAGD(2006.5759,OMLIEN,0))
 . Q:$P(OMLDAT,U,4)'=DIV  ; Has to be in the same Division
 . ;--- Prepare the procedure descriptor
 . S BUF=$P(RADPROC,U)_U_IEN      ; Procedure Name and IEN
 . S $P(BUF,U,3)=$P(RADPROC,U,6)  ; Type of Procedure
 . S $P(BUF,U,4)=$P(RADPROC,U,9)  ; CPT Code (file #81)
 . S $P(BUF,U,5)=IMAGTYPE         ; Type of Imaging (file #79.2)
 . S INACTDAT=$P($G(^RAMIS(71,IEN,"I")),U)
 . I INACTDAT,INACTDAT<TODAY Q    ; ignore inactive procedures
 . S $P(BUF,U,6)=INACTDAT         ; Inactivation Date
 . S $P(BUF,U,7)=$P(OMLDAT,U)     ; Imaging Location (file #79.1)
 . S Z=$P(OMLDAT,U,3)
 . S $P(BUF,U,8)=Z                ; Hospital Location (file #44) - IEN
 . S $P(BUF,U,9)=$$GET1^DIQ(44,Z,.01) ; Hospital Location (file #44) - NAME
 . ;--- Add the descriptor to the result array
 . S ARRAY(1)=ARRAY(1)+1,ARRAY(ARRAY(1)+1)=BUF
 . Q
 Q
 ;
 ;***** RETURNS THE LIST OF RADIOLOGY PROCEDURE MODIFIERS
 ; RPC: MAG DICOM RADIOLOGY MODIFIERS
 ;
 ; .ARRAY        Reference to a local variable where results
 ;               are returned to.
 ;
MOD(ARRAY) ;
 N IEN           ; IEN in the PROCEDURE MODIFIERS file (#71.2)
 N IEN2          ; IEN in the TYPE OF IMAGING subfile (#71.23)
 N IMAGTYPE      ; Imaging type (#79.2)
 N MODIFIER      ; Radiology procedure modifier name (71.2,.01)
 N PROCMOD       ; Radiology procedure modifier data
 ;
 K ARRAY
 ;
 S (ARRAY(1),IEN)=0
 F  S IEN=$O(^RAMIS(71.2,IEN))  Q:'IEN  D  ; Private IA (#4197) 
 . S PROCMOD=^RAMIS(71.2,IEN,0),MODIFIER=$P(PROCMOD,U)
 . S IEN2=0
 . F  S IEN2=$O(^RAMIS(71.2,IEN,1,IEN2))  Q:'IEN2  D
 . . S IMAGTYPE=+$G(^RAMIS(71.2,IEN,1,IEN2,0))  Q:'IMAGTYPE
 . . S ARRAY(1)=ARRAY(1)+1
 . . S ARRAY(ARRAY(1)+1)=MODIFIER_U_IEN_U_IMAGTYPE
 . . Q
 . Q
 Q
