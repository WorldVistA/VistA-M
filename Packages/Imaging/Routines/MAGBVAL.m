MAGBVAL ;WOIFO/GEK - BP Validate Site Params data array ; [ 12/27/2000 10:49 ]
 ;;3.0;IMAGING;**214,222**;Mar 19, 2002;Build 45;Aug 23, 2018
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
VAL(MAGRY,MAGARRAY,ALL) ;RPC [MAGQBP VAL]
 ;Call to Validate some of the IMAGING SITE PARAMETERS values
 ;  before the BP IMAGING SITE PARAMETERS Window is opened.
 ;
 ;  Parameters : 
 ;    MAGARRAY - array of 'Field numbers' and Optionally '^' Value 
 ;       if the input array, MAGARRAY, has no value for a field,
 ;       then we validate the current value of the field.
 ;       example:    MAGARRAY(1)="100^"   Field# = 100   Value= ""
 ;       so we would then get value from DataBase.                        
 ;    ALL - "1" = Validate ALL fields, returning an array 
 ;                of error messages.
 ;          "0" = Stop validating if an error occurs, return
 ;                           the error message in (0) node.
 ;   ALL will default to 1, if it is null.
 ;
 ;  Return Variable
 ;    MAGRY() - Array
 ;      Successful   MAGRY(0) = 1^Image Data is Valid.
 ;      UNsuccessful MAGRY(0) = 0^Error desc
 ;                   IF ALL then MAGRY(1..N) =0^Error desc of all errors
 N MAGGFLD,MAGGDAT,MAGRES,MAGPLC,MAGIENS
 N Y,AITEM,CT,MAGERR,DAT1,X
 N MAGVAL,MAGVALLB
 N $ETRAP,$ESTACK S $ETRAP="D ERR^"_$T(+0)
 S ALL=$G(ALL,1)
 S MAGPLC=$$DUZ2PLC^MAGBAPIP()
 S MAGIENS=MAGPLC_","
 S MAGRY(0)="0^Validating the Data Array..."
 S MAGERR="",CT=0
 ;  Do we have any data ? 
 I ($D(MAGARRAY)<10) S MAGRY(0)="0^No input data, Operation CANCELED" Q
 ;  Loop through Input Array
 S AITEM="" F  S AITEM=$O(MAGARRAY(AITEM)) Q:AITEM=""  D  I $L(MAGERR) Q:'ALL  S CT=CT+1,MAGRY(CT)=MAGERR,MAGERR=""
 . S MAGERR=""
 . S MAGGFLD=$P(MAGARRAY(AITEM),U,1),MAGGDAT=$P(MAGARRAY(AITEM),U,2,99)
 . ; IF MAGGDAT = "" then get current Value.
 . I MAGGDAT="" S MAGGDAT=$$GET1^DIQ(2006.1,MAGIENS,MAGGFLD,"I","MAGVAL")
 . ; HERE we Validate the Data.
 . I MAGGDAT="" Q  ;This means no data was input, and the Field has no current Value. 
 . ; 
 . S DAT1=MAGGDAT
 . I '$$VALID(2006.1,MAGGFLD,.MAGGDAT,.MAGRES) S MAGERR="0^"_MAGRES Q
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
 S MAGRY(0)="1^Data is Valid."
 Q
VALID(MAGF,MAGL,MAGD,MAGRES) ;internal call to validate value for field in a FM file.
 ; Function is boolean.  Returns:
 ;        0   -  Invalid 
 ;        1   -  Valid 
 ;        ""  -  Error
 ; Call this function before you set the FDA Array.
 ; MAGD - sent by reference because it could be Internal or External
 ;        and if it is external and valid, it is changed to Internal.
 ;        
 ; MAGF  : File Number
 ; MAGL  : Field Number
 ; MAGD  : (sent by reference) data value of field
 ; MAGRES: (sent by reference) Result message
 ;
 N MAGR,MAGMSG,MAGSP,MAGRESA,MAGPT
 N MAGLABEL,MAGWIN
 S MAGWIN=$$BROKER^XWBLIB ; If not MAGWIN,  we can write to screen.
 ;if a BAD field number, Quit
 I '$$VFIELD^DILFD(MAGF,MAGL) D  Q 0
 . S MAGRES="The field number: "_MAGL_", in File: "_MAGF_", is invalid."
 ;
 D FIELD^DID(MAGF,MAGL,"","SPECIFIER;LABEL","MAGSP")
 S MAGLABEL=MAGSP("LABEL")
 ; If it is a pointer field then:
 ; If an  integer - We assume it is an IEN of Pointed to file. Validate that and Quit.
 ; If not integer - We assume it is external value, proceed to let CHK do validate
 I (MAGSP("SPECIFIER")["P"),(+MAGD=MAGD) D  Q MAGPT
 . I $$EXTERNAL^DILFD(MAGF,MAGL,"",MAGD)'="" S MAGPT=1,MAGRES="Valid pointer" Q
 . S MAGPT=0,MAGRES="The value '"_MAGD_"' for field: "_MAGLABEL_" is an invalid Pointer. "
 . I 'MAGWIN W !,MAGF,!,MAGL
 . ; we are only deleting the Default User Pref if it is bad.
 . I (MAGL=100)&(MAGF=2006.1)&('$D(NODEL)) D DEL(MAGF,MAGL,.MAGRES)
 . Q
 ; here, so check external value.
 D CHK^DIE(MAGF,MAGL,"E",MAGD,.MAGR,"MAGMSG")
 ; If success, Quit. We changed External to Internal. Internal is in MAGR
 I MAGR'="^" S MAGD=MAGR Q 1
 ;  If not success Get the error text and Quit 0
 D MSG^DIALOG("A",.MAGRESA,245,5,"MAGMSG")
 S MAGRES=MAGRESA(1)
 Q 0
DEL(MAGF,MAGL,MAGRES) ;internal call to delete value of field
 I 'MAGWIN W !,"IN DEL  File: ",MAGF," Field: ",MAGL
 N MAGGMSG,MAGIENS
 S X=$$DUZ2PLC^MAGBAPIP()
 S MAGIENS=X_","
 ; For Default User Preference #100 
 ; in Imaging site Parameters #2006.1 
 ; we will delete the current value if it is invalid.
 K MAGGFDA,MAGGMSG
 S MAGGFDA(MAGF,MAGIENS,MAGL)="@"
 D FILE^DIE("S","MAGGFDA","MAGGMSG")
 I $D(MAGGMSG)=0 S MAGRES=MAGRES_" the value was Deleted."
 ;I $D(MAGGMSG)=10 S MAGRES=$G(MAGGMSG("DIERR",1,"TEXT",1))
 I $D(MAGGMSG)=10 S MAGRES=MAGRES_" the attempt to Delete, Failed."
 Q
ERR ;
 N ERR
 S ERR=$$EC^%ZOSV
 S MAGRY(0)="0^Error during data validation: "_ERR
 D @^%ZOSF("ERRTN")
 D CLEAN^DILF
 Q
 ;
SETVAL(MAGRY,MAGFILE,MAGDATA) ;RPC [MAGQBP SETVAL] P222 Modify entries in MAGFILE.
 ; as of patch 223,  this is used to set a modified value into the
 ; DEFAULT USER PREFERENCE field of IMAGING SITE PARAMS file.
 ; It can be modified in the future to Modify entries in any Imaging File.
 ; NOTE: Data is not validated.  we must validate before we call UPDATE 
 ; ========================
 ; MAGFILE :  two ^ pieces.  
 ;    Piece 1 is File Number
 ;    Piece 2 is IEN
 ;     example   "2006.1^1"   
 ; MAGDATA : is an array of Field^Value
 ;   example 
 ;   MAGDATA(1)="100^135"    <<< Field = 100  value = 135 
 ;
 S ^GEK("SETVAL","MAGFILE")=MAGFILE
 S I="" F  S I=$O(MAGDATA(I)) Q:'I  S ^GEK("SETVAL","MAGDATA",I)=MAGDATA(I)
 N MAGGFDA,MFILE,MIEN,ITEM,MAGERR,FLD,VAL,MAGXERR,MAGXIEN,MAGERR,DATA,NODEL
 N MAGWIN S MAGWIN=$$BROKER^XWBLIB
 N $ETRAP,$ESTACK S $ETRAP="D ERR^"_$T(+0)
 S MFILE=$P(MAGFILE,"^",1)
 S MIEN=$P(MAGFILE,"^",2)
 I (MFILE="2006.1")&(MIEN="") S MIEN=$$DUZ2PLC^MAGBAPIP()
 S MIEN=MIEN_","
 S MAGERR=0
 S ITEM="" F  S ITEM=$O(MAGDATA(ITEM)) Q:ITEM=""  D  Q:MAGERR
 . I 'MAGWIN W !,"ITEM ",ITEM
 . S DATA=MAGDATA(ITEM)
 . S FLD=$P(DATA,"^",1)
 . S VAL=$P(DATA,"^",2)
 . S NODEL=1
 . I '$$VALID(MFILE,FLD,.VAL,.RES) D  Q
 . . I 'MAGWIN W !,"VALID FAILED"
 . . S MAGERR=1
 . . S MAGRY(0)="0^"_RES
 . I 'MAGWIN W !,"VAL ",VAL
 . S MAGGFDA(MFILE,MIEN,FLD)=VAL
 . Q
 I 'MAGWIN W !,"MAGERR ",MAGERR
 I MAGERR Q
 D UPDATE^DIE("S","MAGGFDA","MAGXIEN","MAGXERR")
 I $D(DIERR) D RTRNERR(.MAGRY) Q
 S MAGRY(0)="1^Success"
 D CLEAN^DILF
 Q
RTRNERR(ETXT) ; There was error from UPDATE^DIE quit with error text
 ;ZW MAGXERR
 S ETXT="0^ERROR  "_MAGXERR("DIERR",1,"TEXT",1)
 I 'MAGWIN W !,"RTRNERR: ",ETXT
 Q
GETVAL(MAGRY,MFILE,MIEN,MFLDS) ;RPC [MAGQBP GETVAL] P222 USE GETS^DIQ TO GET FIELD VALUES.
 ; get values from File using GETS^DIQ
 ; =========================
 ; MFILE is the FM File number                         example "2006.1"
 ; MIEN is the IEN for the file entry                  example "2"
 ; MFLDS is a ';' delimited string of Field Numbers.   example "100;127;52;.01;.02;.03"
 ; 
 ; MAGRY is the result array.      MAGRY(0) is '1^Success'  or '0^error message'
 ; each entry of array is a 3 "^" delimited string  of Field Number^Internal Value^External Value
 ; example
 ; MAGRY(0)="1^Success"
 ; MAGRY(1)=".01^589^KANSAS CITY, MO"
 ; MAGRY(2)=".02^GB^GB"
 ; MAGRY(3)=".03^66^MAG1HKAN"
 ; MAGRY(4)="52^^"
 ; MAGRY(5)="100^1^FRANK,STUART (SETTING 1)"
 ; MAGRY(6)="127^^" 
 ;  
 N MAGWIN,I,CT,Y,MAGOUT,MAGXERR,FLAGS
 N N0
 K MAGRY,MAGOUT,MAGERR
 N $ETRAP,$ESTACK S $ETRAP="D ERR^"_$T(+0)
 I (MFILE="2006.1")&(MIEN="") S MIEN=$$DUZ2PLC^MAGBAPIP()
 S MIEN=MIEN_","
 S MAGWIN=$$BROKER^XWBLIB
 I 'MAGWIN W !,"FILE: ",MFILE," IEN: ",MIEN," FLDS: ",MFLDS," FLAGS: ",$G(FLAGS)
 S I=0,CT=0
 S FLAGS="IE"
 I 'MAGWIN W !,"MIEN: ",MIEN
 D GETS^DIQ(MFILE,MIEN,MFLDS,FLAGS,"MAGOUT","MAGXERR")
 I $D(MAGXERR) D RTRNERR(Y) S MAGRY(0)=Y Q
 S MAGRY(0)="1^Success"
 S CT=0
 S I="" F  S I=$O(MAGOUT(MFILE,MIEN,I)) Q:I=""  D  ;
 . S CT=CT+1
 . S MAGRY(CT)=I_"^"_MAGOUT(MFILE,MIEN,I,"I")_"^"_MAGOUT(MFILE,MIEN,I,"E")
 . Q
 Q
