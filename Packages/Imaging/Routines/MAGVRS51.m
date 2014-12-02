MAGVRS51 ;WOIFO/DAC/JSL/NST - Utilities for RPC calls for DICOM file processing ; 7 Jun 2012 2:43 PM
 ;;3.0;IMAGING;**118,138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
OUTSEP() ; Name value separator for output data ie. NAME|TESTPATIENT
 Q "|"
MULTISEP() ; Name value separator for multiple option values ie. READ|1`WRITE|1`DELETE|0
 Q "="
STATSEP() ; Status and Result separator ie. -3``No record IEN  
 Q "`"
INPUTSEP() ; Name value separator for input data ie. NAME`TESTPATIENT   
 Q "`"
DCRCTSET(OUT,ATTS) ; Set DICOM Correct data into file 2006.575
 N FDA,ERR,IENS,STUDYUID,IEN,FIELDERR
 S IENS="+1,"
 S OSEP=$$OUTSEP,ISEP=$$INPUTSEP,SSEP=$$STATSEP
 D SETFDA^MAGVRS44(2006.575,.ATTS,IENS,.FDA,.FIELDERR)
 S FILEPATH=$G(FDA(2006.575,"+1,",.01))
 I FILEPATH="" S OUT="-1"_SSEP_"No FILEPATH identified" Q
 I $D(^MAGD(2006.575,"B",FILEPATH)) S OUT="-4"_SSEP_"Non-unique FILEPATH" Q
 S STUDYUID=$G(FDA(2006.575,"+1,",9)) S LOCATION=$G(FDA(2006.575,"+1,",36))
 K FDA(2006.575,"+1,",9),FDA(2006.575,"+1,",36)
 D UPDATE^DIE("","FDA","","ERR")
 S IEN=$O(^MAGD(2006.575,"B",FILEPATH,"")) ; New Record IEN
 S OUT="0"_SSEP_$G(FIELDERR)_SSEP_IEN ; Set return ouput to IEN of new record
 K FDA
 I $D(ERR("DIERR",1,"TEXT",1)) S OUT="-2"_SSEP_$G(ERR("DIERR",1,"TEXT",1))
 K ERR
 ;Must re-file with Study UID after location has been set to create "F" (location & Study UID) x-ref
 S FDA(2006.575,IEN_",",9)=1
 D FILE^DIE("","FDA","ERR")
 K FDA,ERR
 I $D(ERR("DIERR",1,"TEXT",1)) S OUT="-3"_SSEP_"Related record:"_$G(ERR("DIERR",1,"TEXT",1))
 ;
 ;Must re-file with Study UID after location has been set to create "F" (location & Study UID) x-ref
 S FDA(2006.575,IEN_",",36)=LOCATION
 D FILE^DIE("","FDA","ERR")
 I $D(ERR("DIERR",1,"TEXT",1)) S OUT="-3"_SSEP_"Related record:"_$G(ERR("DIERR",1,"TEXT",1))
 K FDA,ERR
 ;
 ;Must re-file with Study UID after location has been set to create "F" (location & Study UID) x-ref
 S FDA(2006.575,IEN_",",9)=STUDYUID
 D FILE^DIE("","FDA","ERR")
 K FDA,ERR
 I $D(ERR("DIERR",1,"TEXT",1)) S OUT="-3"_SSEP_"Related record:"_$G(ERR("DIERR",1,"TEXT",1))
 ; 
 Q
DCRCTGET(OUT,MACHID) ; Get DICOM Correct data from file 2006.575 
 ; Return record data for all fixed and deleted images of machine ID provided
 N IEN,J,RIEN,DOB,DFN,ICN,SEX,VADM,PATLOOK,SERVTYPE,CASENUMB,NEWCASE
 S OSEP=$$OUTSEP,ISEP=$$INPUTSEP,SSEP=$$STATSEP,J=2,IEN=0,OUT(1)="0"_SSEP_SSEP
 F  S IEN=$O(^MAGD(2006.575,IEN)) Q:+IEN=0  D
 . ; Return deleted records
 . I ($P($G(^MAGD(2006.575,IEN,0)),U,6)=1)&(MACHID=$P($G(^MAGD(2006.575,IEN,1)),U,4)) D  Q
 . . S OUT(J)="FILEPATH"_OSEP_$P($G(^MAGD(2006.575,IEN,0)),U,1)_SSEP,J=J+1
 . . S OUT(J)="DELETE FLAG"_OSEP_1_SSEP,J=J+1
 . . Q
 . I (+$G(^MAGD(2006.575,IEN,"FIXD"))'=1)!(MACHID'=$P($G(^MAGD(2006.575,IEN,1)),U,4)) Q  ; Loop through all DICOM failed images
 . D REFRESH(.OUT,IEN,.J)
 . D REFRESHF(.OUT,IEN,.J)
 . S RIEN=""
 . I $D(^MAGD(2006.575,IEN,"RLATE")) D  ; RLATE - Related images loop
 . . F  S RIEN=$O(^MAGD(2006.575,IEN,"RLATE","B",RIEN)) Q:RIEN=""  D
 . . . D REFRESH(.OUT,RIEN,.J)
 . . . D REFRESHF(.OUT,IEN,.J)
 . . . Q
 . . Q
 . ; Look up patient DFN and retrieve DOB, Sex, ICN.
 . S SERVTYPE=$$GET1^DIQ(2006.575,IEN,"SERVICE TYPE","E"),CASENUMB=$$GET1^DIQ(2006.575,IEN,"CASE NUMB","E"),NEWCASE=$$GET1^DIQ(2006.575,IEN,"NEWCASE NO","E")
 . I NEWCASE'="" S CASENUMB=NEWCASE
 . I (SERVTYPE="")!(CASENUMB="") Q
 . S PATLOOK=$$LOOKUP^MAGVORDR(CASENUMB,SERVTYPE)
 . I +PATLOOK=-1 Q
 . S DFN=$P(PATLOOK,"~",2)
 . D DEM^VADPT ; Supported IA (#10061)
 . S OUT(J)="DFN"_OSEP_DFN_SSEP,J=J+1
 . S DOB=+$$FM2IDF^MAGVAF01(+($G(VADM(3))))
 . S SEX=$E($G(VADM(5)))
 . S ICN=$S($T(GETICN^MPIF001)'="":$$GETICN^MPIF001(DFN),1:"-1^NO MPI") ; Supported IA (#2701)
 . S OUT(J)="DATE OF BIRTH"_OSEP_DOB_SSEP,J=J+1
 . S OUT(J)="SEX"_OSEP_SEX_SSEP,J=J+1
 . S OUT(J)="INTEGRATION CONTROL NUMBER"_OSEP_ICN_SSEP,J=J+1
 . Q
 Q
DCRCTCNT(OUT,MACHID,SERVTYPE) ; Get count of entries with provided machine id and service type from file 2006.575 
 N IEN,J,ISEP,SSEP
 S OSEP=$$OUTSEP,ISEP=$$INPUTSEP,SSEP=$$STATSEP,J=0,IEN=0
 I MACHID="" S OUT="-1"_SSEP_"No machine ID provided" Q
 I SERVTYPE="" S OUT="-1"_SSEP_"No service type provided" Q
 F  S IEN=$O(^MAGD(2006.575,IEN)) Q:+IEN=0  D
 . I (MACHID=$P($G(^MAGD(2006.575,IEN,1)),U,4))&(SERVTYPE=$$GET1^DIQ(2006.575,IEN,"SERVICE TYPE","E")) S J=J+1  ; Loop through all unfixed images
 S OUT="0"_SSEP_SSEP_J
 Q
DCRCTDEL(OUT,FILEPATH) ;  DICOM Correct delete entry
 N IEN,LOCATION,OSEP
 S OSEP=$$OUTSEP,ISEP=$$INPUTSEP,SSEP=$$STATSEP
 I $G(FILEPATH)="" S OUT="-1"_SSEP_"No Filepath provided" Q
 S IEN=$O(^MAGD(2006.575,"B",FILEPATH,""))
 I IEN="" Q
 S FDA(2006.575,IEN_",",.01)="@"
 D UPDATE^DIE("","FDA",IEN,"ERR")
 I $D(ERR("DIERR")) S OUT="-2"_SSEP_$G(ERR("DIERR",1,"TEXT",1))
 I $G(OUT)="" S OUT="0"_SSEP_SSEP
 Q 
REFRESH(OUT,IEN,OUTI) ; Retrieve specified file data attributes
 N FIELD,MULTOUT,FDA,ERR,OSEP,ISEP,SSEP,MULTIPLE,DATETIME,UIEN,UFILE,FORMAT,FILE
 N MULTOUT,FDA,VALUE
 S OSEP=$$OUTSEP,SSEP=$$STATSEP,FILE=2006.575,FIELD=""
 F FIELD="FILEPATH","GATEWAY LOCATION","IMAGE UID","STUDY UID","SERVICE TYPE" D
 . I FIELD["IEN" S FORMAT="I" ; If the field is an IEN pointer return the internal format rather than the UID string
 . S VALUE=$$GET1^DIQ(FILE,IEN,FIELD,"E")
 . S OUT(OUTI)=FIELD_OSEP_VALUE_SSEP
 . S OUTI=OUTI+1
 . Q
 Q
REFRESHF(OUT,IEN,OUTI) ; Retrieve specified file data attributes - Fixed Information
 N FIELD,MULTOUT,FDA,ERR,OSEP,ISEP,SSEP,MULTIPLE,DATETIME,UIEN,UFILE,FORMAT,FILE
 N MULTOUT,FDA,VALUE
 S OUT(OUTI)=""
 S OSEP=$$OUTSEP,SSEP=$$STATSEP,FILE=2006.575,FIELD=""
 F FIELD="INSTRUMENT NAME","MACHINE ID","NEWNME","NEWSSN","NEWCASE NO","NEW PROC IEN","NEW PROCEDURE" D
 . I FIELD["IEN" S FORMAT="I" ; If the field is an IEN pointer return the internal format rather than the UID string
 . S VALUE=$$GET1^DIQ(FILE,IEN,FIELD,"E")
 . S OUT(OUTI)=FIELD_OSEP_VALUE_SSEP
 . S OUTI=OUTI+1
 . Q
 Q
REFRESHP(OUT,DFN,OUTI) ; Retrieve specified file data attributes - Patient Information
 N FIELD,MULTOUT,FDA,ERR,OSEP,ISEP,SSEP,MULTIPLE,DATETIME,UIEN,UFILE,FORMAT,FILE
 N MULTOUT,FDA,VALUE
 S OSEP=$$OUTSEP,SSEP=$$STATSEP,FILE=2,FIELD=""
 F FIELD="DATE OF BIRTH","SEX","INTEGRATION CONTROL NUMBER" D
 . I FIELD["IEN" S FORMAT="I" ; If the field is an IEN pointer return the internal format rather than the UID string
 . S VALUE=$$GET1^DIQ(FILE,IEN,FIELD,"E")
 . S OUT(OUTI)=FIELD_OSEP_VALUE_SSEP
 . S OUTI=OUTI+1
 . Q
 Q
MULTIPLE(FILE,FIELD) ; Process multiple DB entries
 N MULTIPLE,FNUM
 S FNUM=$$FLDNUM^DILFD(FILE,FIELD)
 Q:FNUM="" 0
 S MULTIPLE=$$GET1^DID(FILE,FNUM,,"MULTIPLE-VALUED")
 Q MULTIPLE
INTRFACE ; Entry for AE INSTANCE and SECURITY MATRIX interface
 N Y
 S Y=""
 W !,"DICOM AE SECURITY MATRIX APPLICATION EDIT"
 F  Q:$G(Y)=-1  D AEINTR2(.Y)
 Q
AEINTR2(Y) ;  Edit/Add AE Instance
 ; Select AE Instance
 N NEW,I,D,IEN,DLAYGO,DIE,D0,DA,DIC,DIR,IENS,S,X,DO
 S DLAYGO=2006.9192
 S DIC="^MAGV(2006.9192,"
 S DIC(0)="QEALN"
 S DIC("W")="D OUTLINE^MAGVRS51(Y)"  ; write a line in the lookup
 D ^DIC
 I Y=-1 Q
 S IEN=$P(Y,U,1) S NEW=$P(Y,U,3)
 I NEW=1 D AEINTR3(IEN,NEW)
 ; If entry was deleted quit
 I NEW'=1 D
 . S DIC="^MAGV(2006.9192,"
 . S DA=IEN
 . D EN^DIQ
 . K DIC,IENS,S,X
 . D AEINTR3(IEN,NEW)
 . Q
 ; Quit if entry was just deleted by user
 I '$D(^MAGV(2006.9192,IEN)) K DA Q
 S DIE=2006.9192
 K DIC
 S DA=IEN
 S DIC="^MAGV(2006.9192,",DIC(0)="QEAL"
 I NEW=1 S DR="12" D ^DIE
 I NEW'=1 D
 . ;List Services and Roles
 . D AEINTR6(IEN,.I)
 . S DIR(0)="Y",DIR("B")="NO",DIR("A")="Add/Modify/Delete Services and Roles for this entry"
 . D ^DIR K DIR
 . W !
 . I Y=1 S DR="12" D ^DIE
 K DA
 Q
AEINTR3(IEN,NEW) ; DICOM AE SECURITY MATRIX User Interface - Allows user to add and edit AE entries
 N DIE,DR,DA,FDA,ERR,DIC,FLAGNAME,FLAGVALU,DIR,DLAYGO,D0,SMIEN
 S DIE=2006.9192
 I Y=-1 Q
 I NEW'=1 S DR=".01;1;1.1;1.3;1.4;2;2.1;3;4;6;7;8;9;10;11;13;14"
 I NEW=1 S DR="1//VISTA_STORAGE;1.3//NO;1.4//V;2.1;3;4"
 S DA=IEN
 D ^DIE
 K DIC,IENS,S,X
 ; Quit if entry was just deleted by user
 I '$D(DA) Q
 I NEW=1 D
 . S FDA(2006.9192,DA_",",6)=1
 . S FDA(2006.9192,DA_",",7)=1
 . S FDA(2006.9192,DA_",",8)=1
 . S FDA(2006.9192,DA_",",9)=1
 . S FDA(2006.9192,DA_",",10)=1
 . S FDA(2006.9192,DA_",",11)="RAD"
 . D FILE^DIE("","FDA","SMIEN")
 . Q
 ; Display default flags and default flag values for C-STORE entries
 I NEW=1 D
 . W !!,"Flag Names",?20,"Flag Values",!
 . W "-------------------------------",!
 . F J=6:1:11 D
 . . S FLAGNAME=$$GET1^DID(2006.9192,J,"","LABEL")
 . . S FLAGVALU=$$GET1^DIQ(2006.9192,DA_",",J)
 . . W FLAGNAME,?20,FLAGVALU,!
 . . Q
 . ;Ask the user if they accept the field defaults for the flags names and flag values
 . S DIR(0)="Y",DIR("B")="YES",DIR("A")="Accept these defaults"
 . D ^DIR K DIR
 . I Y'=1 S DR="6;7;8;9;10;11" D ^DIE K DIC,IENS,S,X
 . S DR="13;14" D ^DIE K DIC,IENS,S,X
 K DA
 Q
AEINTR6(SMIEN,I) ; Display DICOM AE SECURITY MATRIX entries for a given AE Instance
 N DSRIEN,DSERVICE,DROLE,I
 S I=0,DSRIEN=0
 W !!
 F  S DSRIEN=$O(^MAGV(2006.9192,SMIEN,3,DSRIEN)) Q:(DSRIEN="")!(+DSRIEN=0)  D
 . S I=I+1
 . S IENS=DSRIEN_","_SMIEN_","
 . S DSERVICE=$$GET1^DIQ(2006.919212,IENS,.01)
 . S DROLE=$$GET1^DIQ(2006.919212,IENS,1)
 . W $P(I,U,1)_") "_DSERVICE_" "_DROLE,!
 . Q
 I I=0 W "No DICOM AE SECURITY MATRIX entries for this AE INSTANCE",!
 Q
 ;
OUTLINE(Y)  ; Form the output line in the DICOM AE SECURITY MATRIX Lookup
 N OUT,I,SUBFILE
 I '$D(Y) Q
 D GETS^DIQ(2006.9192,Y_",","12*","","OUT")
 ; Output the data
 S I=""  ; IENs
 S SUBFILE="2006.919212"
 F  S I=$O(OUT(SUBFILE,I)) Q:I=""  D
 . W !,?18,$G(OUT(SUBFILE,I,.01)),?28,$G(OUT(SUBFILE,I,1))
 . Q
 Q
