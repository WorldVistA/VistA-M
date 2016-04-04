DIINI009 ;VEN/TOAD-DI (FILEMAN MENU INIT) ; 05-JAN-2015
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"OPT",11388,"U")
 ;;=MONITOR A USER
 ;;^UTILITY(U,$J,"OPT",11392,0)
 ;;=DIAUDIT SHOW DD AUDIT TRAIL^Show DD Audit Trail^^R^^^^^^^^MSC FILEMAN
 ;;^UTILITY(U,$J,"OPT",11392,1,0)
 ;;=^^1^1^3130126^
 ;;^UTILITY(U,$J,"OPT",11392,1,1,0)
 ;;=This option shows all Data Dictionary changes since a certain date.
 ;;^UTILITY(U,$J,"OPT",11392,25)
 ;;=4^DIAU
 ;;^UTILITY(U,$J,"OPT",11392,"U")
 ;;=SHOW DD AUDIT TRAIL
 ;;^UTILITY(U,$J,"REM",139,0)
 ;;=DDR GETS ENTRY DATA^GETSC^DDR2^2^R
 ;;^UTILITY(U,$J,"REM",139,1,0)
 ;;=^^1^1^2951024^^^^
 ;;^UTILITY(U,$J,"REM",139,1,1,0)
 ;;=Calls database server at GETS^DIQ.
 ;;^UTILITY(U,$J,"REM",139,2,0)
 ;;=^8994.02A^1^1
 ;;^UTILITY(U,$J,"REM",139,2,1,0)
 ;;=GETS ATTRIBUTES^2^512^1
 ;;^UTILITY(U,$J,"REM",139,2,"B","GETS ATTRIBUTES",1)
 ;;=
 ;;^UTILITY(U,$J,"REM",140,0)
 ;;=DDR LISTER^LISTC^DDR^4^R^^^1
 ;;^UTILITY(U,$J,"REM",140,2,0)
 ;;=^8994.02A^1^1
 ;;^UTILITY(U,$J,"REM",140,2,1,0)
 ;;=LIST ATTRIBUTES^2^512^1
 ;;^UTILITY(U,$J,"REM",140,2,"B","LIST ATTRIBUTES",1)
 ;;=
 ;;^UTILITY(U,$J,"REM",141,0)
 ;;=DDR FILER^FILEC^DDR3^2^R
 ;;^UTILITY(U,$J,"REM",141,1,0)
 ;;=^^1^1^2950508^^
 ;;^UTILITY(U,$J,"REM",141,1,1,0)
 ;;=Generic call to file edits into FM file.
 ;;^UTILITY(U,$J,"REM",141,2,0)
 ;;=^8994.02A^2^2
 ;;^UTILITY(U,$J,"REM",141,2,1,0)
 ;;=EDIT RESULTS^2^512^1
 ;;^UTILITY(U,$J,"REM",141,2,1,1,0)
 ;;=^^1^1^2950124^
 ;;^UTILITY(U,$J,"REM",141,2,1,1,1,0)
 ;;=Results of editing to be placed in FDA array by broker.
 ;;^UTILITY(U,$J,"REM",141,2,2,0)
 ;;=EDIT MODE^1^3^1
 ;;^UTILITY(U,$J,"REM",141,2,2,1,0)
 ;;=^^1^1^2950508^^
 ;;^UTILITY(U,$J,"REM",141,2,2,1,1,0)
 ;;=Is processing in edit or add data mode.
 ;;^UTILITY(U,$J,"REM",141,2,"B","EDIT MODE",2)
 ;;=
 ;;^UTILITY(U,$J,"REM",141,2,"B","EDIT RESULTS",1)
 ;;=
 ;;^UTILITY(U,$J,"REM",141,3,0)
 ;;=^^2^2^2950508^^
 ;;^UTILITY(U,$J,"REM",141,3,1,0)
 ;;=If file update is successful, then a 1 is returned. A 0 is returned if
 ;;^UTILITY(U,$J,"REM",141,3,2,0)
 ;;=unsuccessful.
 ;;^UTILITY(U,$J,"REM",142,0)
 ;;=DDR VALIDATOR^VALC^DDR3^2^R
 ;;^UTILITY(U,$J,"REM",142,1,0)
 ;;=^^3^3^2970121^^^
 ;;^UTILITY(U,$J,"REM",142,1,1,0)
 ;;=This function allows the application to validate user input to
 ;;^UTILITY(U,$J,"REM",142,1,2,0)
 ;;=a field before filing data. The call uses the database server VAL^DIE
 ;;^UTILITY(U,$J,"REM",142,1,3,0)
 ;;=call.
 ;;^UTILITY(U,$J,"REM",142,2,0)
 ;;=^8994.02A^2^1
 ;;^UTILITY(U,$J,"REM",142,2,2,0)
 ;;=PARAMETERS^2^512^1
 ;;^UTILITY(U,$J,"REM",142,2,2,1,0)
 ;;=^^4^4^2970121^^^
 ;;^UTILITY(U,$J,"REM",142,2,2,1,1,0)
 ;;=This array contains the following parameters necessary to call VAL^DIE:
 ;;^UTILITY(U,$J,"REM",142,2,2,1,2,0)
 ;;=    - "FILE"  - file number
 ;;^UTILITY(U,$J,"REM",142,2,2,1,3,0)
 ;;=    - "IENS"  - internal entry numbers
 ;;^UTILITY(U,$J,"REM",142,2,2,1,4,0)
 ;;=    - "VALUE" - user input value
 ;;^UTILITY(U,$J,"REM",142,2,2,1,5,0)
 ;;=    - "VALUE" - user input value
 ;;^UTILITY(U,$J,"REM",142,2,"B","PARAMETERS",2)
 ;;=
 ;;^UTILITY(U,$J,"REM",142,3,0)
 ;;=^^2^2^2970121^^^
 ;;^UTILITY(U,$J,"REM",142,3,1,0)
 ;;=This call passes back information in the [data] section and
 ;;^UTILITY(U,$J,"REM",142,3,2,0)
 ;;=the [errors] section.
 ;;^UTILITY(U,$J,"REM",143,0)
 ;;=DDR DELETE ENTRY^DIKC^DDR1^1^R
 ;;^UTILITY(U,$J,"REM",143,1,0)
 ;;=^^1^1^2970912^^^^
 ;;^UTILITY(U,$J,"REM",143,1,1,0)
 ;;=This function deletes an entry in a FileMan file using ^DIK.
 ;;^UTILITY(U,$J,"REM",143,2,0)
 ;;=^8994.02A^1^1
 ;;^UTILITY(U,$J,"REM",143,2,1,0)
 ;;=PARAMETERS^2^512^1
 ;;^UTILITY(U,$J,"REM",143,2,1,1,0)
 ;;=^^3^3^2970814^^
 ;;^UTILITY(U,$J,"REM",143,2,1,1,1,0)
 ;;=This array contains the following parameters necessary to call ^DIK.
 ;;^UTILITY(U,$J,"REM",143,2,1,1,2,0)
 ;;=   "ROOT" global root of file or subfile
 ;;^UTILITY(U,$J,"REM",143,2,1,1,3,0)
 ;;=   "IEN"  internal entry number of record to be deleted in IENS format
 ;;^UTILITY(U,$J,"REM",143,2,"B","PARAMETERS",1)
 ;;=
 ;;^UTILITY(U,$J,"REM",143,3,0)
 ;;=^^1^1^2970108^
 ;;^UTILITY(U,$J,"REM",143,3,1,0)
 ;;=This parameter returns 1 if record was deleted else it returns 0.
 ;;^UTILITY(U,$J,"REM",144,0)
 ;;=DDR LOCK/UNLOCK NODE^LOCKC^DDR1^1^R
 ;;^UTILITY(U,$J,"REM",144,1,0)
 ;;=^^3^3^2970110^^^
 ;;^UTILITY(U,$J,"REM",144,1,1,0)
 ;;=This function will lock or unlock an M global node.  Also,
 ;;^UTILITY(U,$J,"REM",144,1,2,0)
 ;;=this function allows the calling application to specify the
 ;;^UTILITY(U,$J,"REM",144,1,3,0)
 ;;=timeout (in seconds) for a 'lock' command.
 ;;^UTILITY(U,$J,"REM",144,2,0)
 ;;=^8994.02A^1^1
 ;;^UTILITY(U,$J,"REM",144,2,1,0)
 ;;=PARAMETERS^2^512
 ;;^UTILITY(U,$J,"REM",144,2,1,1,0)
 ;;=^^7^7^2970110^
 ;;^UTILITY(U,$J,"REM",144,2,1,1,1,0)
 ;;=This array contains the following parameter necessary for
 ;;^UTILITY(U,$J,"REM",144,2,1,1,2,0)
 ;;=a Lock command:
 ;;^UTILITY(U,$J,"REM",144,2,1,1,3,0)
 ;;=|TAB|- NODE - the global node that needs to be locked/unlocked
 ;;^UTILITY(U,$J,"REM",144,2,1,1,4,0)
 ;;=|TAB|- LOCKMODE - the operation to be done, Lock or Unlock
 ;;^UTILITY(U,$J,"REM",144,2,1,1,5,0)
 ;;=|TAB|- TIMEOUT - integer representing the number of seconds during which
 ;;^UTILITY(U,$J,"REM",144,2,1,1,6,0)
 ;;=the system attempts to lock or unlock a node before returning control to
 ;;^UTILITY(U,$J,"REM",144,2,1,1,7,0)
 ;;=the program .
 ;;^UTILITY(U,$J,"REM",144,2,"B","PARAMETERS",1)
 ;;=
 ;;^UTILITY(U,$J,"REM",144,3,0)
 ;;=^^2^2^2970110^^
 ;;^UTILITY(U,$J,"REM",144,3,1,0)
 ;;=This parameter returns 1 if the lock or unlock command is successful,
 ;;^UTILITY(U,$J,"REM",144,3,2,0)
 ;;=otherwise a 0 is returned.
 ;;^UTILITY(U,$J,"REM",145,0)
 ;;=DDR FIND1^FIND1C^DDR2^2^R^
 ;;^UTILITY(U,$J,"REM",145,1,0)
 ;;=^^2^2^2970121^
 ;;^UTILITY(U,$J,"REM",145,1,1,0)
 ;;=This function returns the internal entry number of a record using
 ;;^UTILITY(U,$J,"REM",145,1,2,0)
 ;;=$$FIND1^DIC.
 ;;^UTILITY(U,$J,"REM",145,2,0)
 ;;=^8994.02A^1^1
 ;;^UTILITY(U,$J,"REM",145,2,1,0)
 ;;=PARAMETERS^2^512^1
 ;;^UTILITY(U,$J,"REM",145,2,1,1,0)
 ;;=^^15^15^2970121^
 ;;^UTILITY(U,$J,"REM",145,2,1,1,1,0)
 ;;=This array contains the following parameters necessary to call
 ;;^UTILITY(U,$J,"REM",145,2,1,1,2,0)
 ;;=$$FIND1^DIC.
 ;;^UTILITY(U,$J,"REM",145,2,1,1,3,0)
 ;;= 
 ;;^UTILITY(U,$J,"REM",145,2,1,1,4,0)
 ;;=   "FILE" the file or subfile number to search
 ;;^UTILITY(U,$J,"REM",145,2,1,1,5,0)
 ;;=   "IENS" the IENS that identifies the subfile if FILE is a subfile number
 ;;^UTILITY(U,$J,"REM",145,2,1,1,6,0)
 ;;=   "FLAGS" possible values include:
 ;;^UTILITY(U,$J,"REM",145,2,1,1,7,0)
 ;;=        A  allow pure numeric input to always be tried as an IEN
 ;;^UTILITY(U,$J,"REM",145,2,1,1,8,0)
 ;;=        M  multiple index allowed
 ;;^UTILITY(U,$J,"REM",145,2,1,1,9,0)
 ;;=        O  only find an exact match if possible
 ;;^UTILITY(U,$J,"REM",145,2,1,1,10,0)
 ;;=        Q  quick lookup
 ;;^UTILITY(U,$J,"REM",145,2,1,1,11,0)
 ;;=        X  exact match only
 ;;^UTILITY(U,$J,"REM",145,2,1,1,12,0)
 ;;=        R  record the ien in ^DISV via RECALL^DILFD
 ;;^UTILITY(U,$J,"REM",145,2,1,1,13,0)
 ;;=   "VALUE" the lookup value
 ;;^UTILITY(U,$J,"REM",145,2,1,1,14,0)
 ;;=   "XREF" the indexes that would be searched for a match
 ;;^UTILITY(U,$J,"REM",145,2,1,1,15,0)
 ;;=   "SCREEN" screen to apply to the record found
 ;;^UTILITY(U,$J,"REM",145,2,"B","PARAMETERS",1)
 ;;=
 ;;^UTILITY(U,$J,"REM",145,3,0)
 ;;=^^5^5^2970121^
 ;;^UTILITY(U,$J,"REM",145,3,1,0)
 ;;=This parameter returns a valid internal record number if a match
 ;;^UTILITY(U,$J,"REM",145,3,2,0)
 ;;=is found, a 0 if no match was found or a -1 if an error occurred.
 ;;^UTILITY(U,$J,"REM",145,3,3,0)
 ;;= 
 ;;^UTILITY(U,$J,"REM",145,3,4,0)
 ;;=(For now, this is 'single value'.  It will return the error array
 ;;^UTILITY(U,$J,"REM",145,3,5,0)
 ;;=later.)
 ;;^UTILITY(U,$J,"REM",146,0)
 ;;=DDR GET DD HELP^GETHLPC^DDR2^2^R
 ;;^UTILITY(U,$J,"REM",147,0)
 ;;=DDR FINDER^FINDC^DDR0^4^R^^^1
 ;;^UTILITY(U,$J,"REM",147,2,0)
 ;;=^8994.02A^1^1
 ;;^UTILITY(U,$J,"REM",147,2,1,0)
 ;;=FIND ATTRIBUTES^2^512
 ;;^UTILITY(U,$J,"REM",147,2,"B","FIND ATTRIBUTES",1)
 ;;=
 ;;^UTILITY(U,$J,"REM",353,0)
 ;;=DDR KEY VALIDATOR^KEYVAL^DDR3^2^P
 ;;^UTILITY(U,$J,"REM",353,1,0)
 ;;=^^2^2^2960221^
 ;;^UTILITY(U,$J,"REM",353,1,1,0)
 ;;=Validates that values passed in do not violate key integrity.  Underlying
 ;;^UTILITY(U,$J,"REM",353,1,2,0)
 ;;=DBS call is KEYVAL^DIE.
 ;;^UTILITY(U,$J,"REM",353,2,0)
 ;;=^8994.02A^1^1
 ;;^UTILITY(U,$J,"REM",353,2,1,0)
 ;;=VALUES TO VALIDATE^2^512^1
 ;;^UTILITY(U,$J,"REM",353,2,1,1,0)
 ;;=^^3^3^2960221^
 ;;^UTILITY(U,$J,"REM",353,2,1,1,1,0)
 ;;=Array of data used to create FDA for KEYVAL^DIE call.  Alternating lines
 ;;^UTILITY(U,$J,"REM",353,2,1,1,2,0)
 ;;=contain file#^IENS^field# and value associated with preceding file, record,
 ;;^UTILITY(U,$J,"REM",353,2,1,1,3,0)
 ;;=and field.
 ;;^UTILITY(U,$J,"REM",353,2,"B","VALUES TO VALIDATE",1)
 ;;=
 ;;^UTILITY(U,$J,"REM",353,3,0)
 ;;=^^3^3^2960430^^
 ;;^UTILITY(U,$J,"REM",353,3,1,0)
 ;;=If values pass validation, 1 is returned in first node of array.  If
 ;;^UTILITY(U,$J,"REM",353,3,2,0)
 ;;=validation fails, 0 is returned in first node followed by error
 ;;^UTILITY(U,$J,"REM",353,3,3,0)
 ;;=information.
