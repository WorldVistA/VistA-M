MAGGSIV ;WOIFO/GEK/NST - Imaging RPC Broker calls. Validate Image data array ; [ 12/27/2000 10:49 ]
 ;;3.0;IMAGING;**7,8,20,59,108,121**;Mar 19, 2002;Build 2340;Oct 20, 2011
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
VAL(MAGRY,MAGARRAY,ALL) ;RPC [MAG4 VALIDATE DATA]
 ;Call to Validate the Image Data Array before a new image/modified entry is attempted.  
 ; Called from MAGGSIA, MAGGSIUI and Capture GUI.
 ;  Parameters : 
 ;    MAGARRAY - array of 'Field numbers'|'Action codes'  and their Values 
 ;                     MAGARRAY(1)="5^38"  Field#:  5   Value: 38
 ;         an example of an action code is the Code for File Extension    
 ;                     MAGARRAY(2)="EXT^JPG"  Action: EXT Value: JPG                        
 ;    ALL - "1" = Validate ALL fields, returning an array of error messages.
 ;          "0" = Stop validating if an error occurs, return
 ;                           the error message in (0) node.
 ;  Return Variable
 ;    MAGRY() - Array
 ;      Successful   MAGRY(0) = 1^Image Data is Valid.
 ;      UNsuccessful MAGRY(0) = 0^Error desc
 ;                   IF ALL then MAGRY(1..N) =0^Error desc of all errors
 N MAGGFLD,MAGGDAT,MAGFSPEC,CHKOK,MAGETXT,MAGRET,MAGRES
 N Y,AITEM,CT,MAGERR,DFNFLAG,DAT1,X,MAX
 N $ETRAP,$ESTACK S $ETRAP="D ERR^"_$T(+0)
 S ALL=$G(ALL)
 S MAGRY(0)="0^Validating the Data Array..."
 S MAGERR="",DFNFLAG=0,CT=0
 ;  Do we have any data ? 
 I ($D(MAGARRAY)<10) S MAGRY(0)="0^No input data, Operation CANCELED" Q
 ;  Flag if from Maximus
 S MAX=0
 S X="" F  S X=$O(MAGARRAY(X)) Q:X=""  I $P(MAGARRAY(X),U,1)="TRKID"!($P(MAGARRAY(X),U,1)="108") I $P($P(MAGARRAY(X),U,2),";",1)="MAX" S MAX=1
 ;  Loop through Input Array
 S AITEM="" F  S AITEM=$O(MAGARRAY(AITEM)) Q:AITEM=""  D  I $L(MAGERR) Q:'ALL  S CT=CT+1,MAGRY(CT)=MAGERR,MAGERR=""
 . S MAGERR=""
 . S MAGGFLD=$P(MAGARRAY(AITEM),U,1),MAGGDAT=$P(MAGARRAY(AITEM),U,2,99)
 . I MAGGFLD="" S MAGERR="0^A Field Number/Action Code is required: "_" Item: "_MAGARRAY(AITEM) Q
 . I MAGGDAT="" S MAGERR="0^A Value is required."_" Item: "_MAGARRAY(AITEM) Q
 . I MAGGFLD=5 S DFNFLAG=1
 . ; This inadvertently disallowed Tracking ID's on Group Images.
 . ;I MAGGFLD=108 I $D(^MAG(2005,"ATRKID",MAGGDAT)) S MAGERR="0^Tracking ID Must be Unique !" Q
 . I MAGGFLD=108 I ($L(MAGGDAT,";")<2) S MAGRY(0)="0^Tracking ID Must have "";"" Delimiter" Q
 . ; Check for possible action codes that could be in the array.
 . I $$ACTCODE(MAGGFLD) D  Q
 . . S DAT1=MAGGDAT
 . . S Y=$$VALCODE(MAGGFLD,.MAGGDAT) S:'Y MAGERR=Y_" Item: "_MAGARRAY(AITEM)
 . . I DAT1'=MAGGDAT S MAGARRAY(AITEM)=MAGGFLD_"^"_MAGGDAT
 . ; If we are adding Multiple Images to a Group, they must be Validated.
 . ;   we could have multiple "2005.04^IENs" in this array. Which means we are 
 . ;   adding existing Images to a New/Existing Group.
 . I MAGGFLD=2005.04 D  Q  ; 2005.04 isn't the field number, #4 is the field number
 . . I $G(MAGGDAT,0)=0 Q  ;Creating a new Group, with no group entries is the usual way
 . . ; to do it.  Then make successive calls to ADD, Adding each Image to the 
 . . ; Object Group multiple of the Group Parent (fld#14) as it is created.
 . . I '$D(^MAG(2005,MAGGDAT,0)) S MAGERR="0^Group Object "_MAGGDAT_" doesn't exist"_" Item: "_MAGARRAY(AITEM)
 . . ;  We can't allow adding an image if it already has a group parent.
 . . I $P(^MAG(2005,MAGGDAT,0),U,10) S MAGERR="0^The Image to be added to the Group, already has a Group Parent"_" Item: "_MAGARRAY(AITEM)
 . ; if we are getting a WP line of text for Long Desc Field.  Can't validate it.
 . I MAGGFLD=11 Q  ; this is a line of the WP Long Desc field.
 . I (MAGGFLD=17),(MAGGDAT=0) Q  ; Patch 108 BP work around don't check -  a new TIU stub will be created 
 . I MAGGFLD="ACTION" Q  ; Patch 121  new ACTION Field, we skip.
 . ; NEW CALL TO VALIDATE FILE,FIELD,DATA 
 . S DAT1=MAGGDAT
 . I '$$VALID^MAGGSIV1(2005,MAGGFLD,.MAGGDAT,.MAGRES) S MAGERR="0^"_MAGRES Q
 . I DAT1'=MAGGDAT S MAGARRAY(AITEM)=MAGGFLD_"^"_MAGGDAT
 . Q
 ;
 ; if there was an Error in data we'll quit now.
 ; If ALL is true, then MAGRY(1...N) will exist if there were errors.
 I $O(MAGRY(0)) S MAGRY(0)="0^Errors were found in data." Q
 ; If ALL is false, then MAGERR will exist if there was an error.
 I $L(MAGERR) S MAGRY(0)=MAGERR Q
 ;
 ;  If all data is valid we get here.
 ;  Last Test, see if a Patient was in array, 
 ;  (Patient is the only Required field check done in this routine).
 I 'DFNFLAG S MAGRY(0)="0^A Patient DFN is required. " Q
 S MAGRY(0)="1^Data is Valid."
 Q
ACTCODE(CODE) ;Function that returns True (1) if this code is a valid Import API Action Code
 ; Patch 8.  We're adding 107 as an action code, so it will pass validation even if the entry
 ;   in the Acquisition Device File doesn't exist;
 ;   it will be validated in PRE^MAGGSIA1 and a new Acquisition Device entry made if needed.
 I $E(CODE,1,8)="PXTIUTXT" Q 1 ; P108
 I ",107,PXSGNTYP,PXTIUTCNT,PXNEW,PXTIUTTL,ACQD,IEN,EXT,ABS,JB,WRITE,BIG,"[(","_CODE_",") Q 1
 I ",DICOMSN,DICOMIN,ACQS,ACQL,STATUSCB,CALLMTH,USERNAME,PASSWORD,DELFLAG,TRNSTYP,"[(","_CODE_",") Q 1
 I ",ACTION,"[(","_CODE_",") Q 1
 Q 0
VALCODE(CODE,VALUE) ; We validate the values for the possible action codes
 N MAGY
 I VALUE="" Q "0^NO VALUE in Action Code string: """_X_""
 ; Patch 8, added 107 
 I ",ACQL,CALLMTH,USERNAME,PASSWORD,"[(","_CODE_",") Q 1 ; NO VALIDATION FOR THESE CODES
 I ($E(CODE,1,8)="PXTIUTXT")!(CODE="PXTIUTCNT") Q 1  ; NO VALIDATION FOR TIU TEXT 
 D @CODE
 Q MAGY
 ;  Each Tag is a valid Action code
IEN I $D(^MAG(2005,VALUE)) S MAGY=1
 E  S MAGY="0^INVALID IMAGE IEN."
 Q
ACTION ; Patch 121 ACTION = "RESCIND"
 I VALUE="RESCIND" S MAGY=1 Q
 S MAGY="0^Invalid ACTION: "_VALUE
 Q
PXNEW ; New Package (TIU note)
 I (PXNEW'=0),(PXNEW'=1),(PXNEW'="") D
 . S MAGY="0^Invalid New Package Value."
 . S CT=CT+1,MAGRY(CT)="Invalid PXNEW value - 0, 1, or blank only!"
 E  S MAGY=1
 Q
PXSGNTYP ; Signature type
 I (PXSGNTYP'=0),(PXSGNTYP'=1),(PXSGNTYP'="") D
 . S MAGY="0^Invalid Signature type Value."
 . S CT=CT+1,MAGRY(CT)="Invalid PXSGNTYP value - 0, 1, or blank only!"
 E  S MAGY=1
 Q
PXTIUTTL ; Check for valid TIU title
 N VALIEN
 I $$GETTIUDA^MAGGSIV(.MAGY,VALUE,.VALIEN) S VALUE=VALIEN
 Q
EXT ; code will go here to validate the extension type.  i.e. we won't let types .exe .bat .com .zip ... etc.
 ;  Maybe a modification to Object Type file, to have allowable extensions in the file, and a 
 ;  cross reference on a new field EXTENSION.  The capture workstation wouldn't have to ask the 
 ; user for the file type of each file, and we wouldn't get WORD .DOC files that the user called Color Images
ABS ; Meaning: Have the BP create the abstract
JB ; Meaning: Have the BP copy the image to the JukeBox
BIG ; Meaning: There is a big file also, set the Image File field ? to indicate there is a BIG File.
 S MAGY=1
 Q
WRITE ; Meaning: This is the Internal Entry (or "PACS") of the WRITE Directory. Images will be written
 ; here instead of the default WRITE Directory.
 S MAGY=$$DRIVE^MAGGTU1(VALUE)
 Q
DICOMSN ;Meaning: DICOM Series Number.  This will be entered in the Group Object multiple, field #1
 ;We were validating this as an integer, but it can be anything, no way to validate.
 S MAGY=1
 Q
DICOMIN ;Meaning: DICOM Image Number.  This will be entered in the Group Object multiple, field #2
 ; We were validating this as an integer, but it can be anything, no way to validate.
 S MAGY=1
 Q
DELFLAG ;Meaning: This flag tells the Delphi Import Component to Delete the Image files after successful processing
 I ",TRUE,FALSE,0,1,"[(","_$$UPPER(VALUE)_",") S MAGY=1
 E  S MAGY="0^INVALID Value "
 I VALUE="1" S VALUE="TRUE"
 I VALUE="0" S VALUE="FALSE"
 Q
TRNSTYP ;Meaning: This flag is for future use, for now it is ignored, defaults to "NEW"
 S MAGY=1
 Q
STATUSCB ; Meaning: This is the TAG^RTN that Imaging calls to report the 
 ; status of the Import.
 S MAGY="0^Error validating TAG^RTN: "_VALUE
 I '$L($T(@VALUE)) S MAGY="0^Invalid Status CallBack "_VALUE
 E  S MAGY=1
 Q
ACQS ; We need to make sure the ACQS (Acquisition Site) is a Valid entry in Imaging Site Params.
 S VALUE=$P(VALUE,";") ; Stop error, when old OCX sends data.
 ; Next Block is for VIC (Maximus) that sends Station Number.
 N ERR S ERR=0
 I MAX D  Q:ERR
 . S X=$O(^DIC(4,"D",VALUE,""))
 . I X="" S MAGY="0^Invalid STATION NUMBER: (ACQS): "_VALUE,ERR=1 Q
 . S VALUE=X
 . Q
 I '$$CONSOLID^MAGBAPI S MAGY=1 Q
 ;Patch 20 will have this.
 I '$D(^MAG(2006.1,"B",VALUE)) S MAGY="0^Acquisition Site ("_VALUE_") is Not in Site Param File." Q
 S MAGY=1
 Q
107 ;    107 and ACQD are the same.  Calling 107 falls into validation for ACQD.
ACQD ; 107 and ACQD are ACQUISITION DEVICE FILE (2006.04) pointers or Values.
 ; If it is an integer, We assume the value is an IEN and validate it here.
 I ((+VALUE)=VALUE),'$D(^MAG(2006.04,VALUE)) S MAGY="0^Invalid IEN ("_VALUE_") for ACQUISITION DEVICE File." Q
 ; if it is not an integer, it is either a new/existing entry for 2006.04 Result is Success,
 ;       and it will be validated in PRE^MAGGSIA1 and added to File 2006.04 if needed.
 S MAGY=1
 Q
UPPER(X) ;
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
ERR ; ERROR TRAP FOR Import API
 N ERR S ERR=$$EC^%ZOSV
 S MAGRY(0)="0^ETRAP: "_ERR
 D @^%ZOSF("ERRTN")
 Q
 ;
 ;***** Verify and return TIU Title IEN
 ;
 ; Input Parameters
 ; ================
 ; TITLE - an Integer (the IEN of file 8925.1)  or Text value of the entry in 8925.1 
 ;  
 ; Return Values
 ; =============
 ; Returns 0 if TITLE is valid
 ; Returns 1 if TITLE is not valid
 ;
 ; if TITLE is not valid then MAGY = "0^error message"
 ; if TITLE is valid then MAGY = 1 and TIEN = TIU Title IEN
 ;
GETTIUDA(MAGY,TITLE,TIEN) ;
 I TITLE="" S MAGY="0^Invalid data: Note TITLE is blank!" Q 0
 ; Is TITLE integer (IEN)
 I TITLE?1.N D  Q +MAGY
 . I $D(^TIU(8925.1,"AT","DOC",TITLE)) S MAGY=1 S TIEN=TITLE Q
 . S MAGY="0^Invalid data: Note TITLE ("_TITLE_") is invalid"
 . Q
 N DONE
 S (DONE,TIEN)=""
 S TITLE=$$UP^XLFSTR(TITLE) ; IA #10104
 F  Q:DONE  S TIEN=$O(^TIU(8925.1,"B",TITLE,TIEN)) Q:TIEN=""  D
 . I $D(^TIU(8925.1,"AT","DOC",TIEN)) S DONE=1
 . Q
 I DONE S MAGY=1 ; TIEN is already set
 E  S MAGY="0^Invalid data: TITLE IEN ("_TITLE_") is invalid"
 Q +MAGY
