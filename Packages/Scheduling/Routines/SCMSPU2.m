SCMSPU2 ;ALB/JRP - UTILITIES FOR INSTALLING EXPORTED ROUTINES;24-AUG-93
 ;;5.3;Scheduling;**44**;AUG 13, 1993
 ;
EXIST(X) ;DETERMINE IF ROUTINE X EXISTS
 ;INPUT  : X - Name of routine
 ;OUTPUT : 1 - Routine exists
 ;         0 - Routine doesn't exist
 ;        "" - Error
 ;
 ;CHECK INPUT & EXISTANCE OF ^%ZOSF("TEST")
 Q:($G(X)="") ""
 Q:('$D(^%ZOSF("TEST"))) ""
 ;CHECK FOR EXISTANCE
 X ^%ZOSF("TEST") Q $T
 ;
LOAD(X,ARRAY) ;LOAD ROUTINE X INTO ARRAY
 ;INPUT  : X - Name of routine
 ;         ARRAY - Array to copy into (full global reference)
 ;OUTPUT : None
 ;NOTES  : ARRAY will be in the format
 ;           ARRAY(Line_N,0)=Line number N of routine X
 ;       : ARRAY will be killed before loading routine.  If routine
 ;         could not be loaded, ARRAY() will not exit.
 ;
 ;CHECK INPUT, KILL ARRAY, TEST FOR ^%ZOSF("LOAD")
 Q:($G(ARRAY)="")
 K @ARRAY
 Q:($G(X)="")
 Q:('$D(^%ZOSF("LOAD")))
 ;DECLARE VARIABLES
 N XCNP,DIF,TMP,TMP1,TMP2
 ;SET REQUIRED VARIABLES
 S TMP=$P(ARRAY,"(",1)
 S TMP1=$P(ARRAY,"(",2)
 S TMP2=$P(TMP1,")",1)
 S:(TMP2="") DIF=TMP_"("
 S:(TMP2'="") DIF=TMP_"("_TMP2_","
 S XCNP=0
 ;LOAD ROUTINE
 X ^%ZOSF("LOAD")
 Q
 ;
COPY(OLDROU,NEWROU,XCN) ;COPY ROUTINE OLDROU TO ROUTINE NEWROU
 ;INPUT  : OLDROU - Name of existing routine
 ;         NEWROU - New name for routine
 ;         XCN - Line in existing routine to begin copying from
 ;               (defaults to line 1)
 ;OUTPUT : 0 - Success
 ;        -1 - Error
 ;
 ;CHECK INPUT & EXISTANCE OF ^%ZOSF("SAVE")
 Q:($G(OLDROU)="") -1
 Q:($G(NEWROU)="") -1
 S XCN=+$G(XCN)
 Q:('$D(^%ZOSF("SAVE"))) -1
 ;CHECK FOR EXISTANCE OF OLDROU
 Q:('$$EXIST(OLDROU)) -1
 ;DECLARE VARIABLES
 N ROOT1,ROOT2,X,DIE
 S ROOT1="^UTILITY(""SCMSPST"","_$J_")"
 S ROOT2="^UTILITY(""SCMSPST"","_$J_","
 K @ROOT1
 ;LOAD OLDROU
 D LOAD(OLDROU,ROOT1)
 Q:('$D(@ROOT1)) -1
 ;CALL TO ^%ZOSF("SAVE") START WITH LINE AFTER XCN.  SUBTRACT
 ; ONE FROM THE VALUE PASSED TO MATCH STATED VALUE.
 S XCN=XCN-1
 ;SAVE OLDROU AS NEWROU
 S X=NEWROU
 S DIE=ROOT2
 X ^%ZOSF("SAVE")
 K @ROOT1
 ;HAVE TO ASSUME THAT SAVE WAS SUCCESSFUL
 Q 0
 ;
SECOND(ROU,STRIP) ;RETURN SECOND LINE OF ROUTINE ROU
 ;INPUT  : ROU - Name of routine
 ;         STRIP - Flad indicating of leading <TAB>;; should be stripped
 ;           If 1, strip <TAB>;;  (default)
 ;           If 0, don't strip <TAB>;;
 ;OUTPUT : Second line of ROU
 ;         NULL returned on error
 ;
 ;CHECK INPUT
 Q:($G(ROU)="") ""
 Q:('$$EXIST(ROU)) ""
 S:($G(STRIP)="") STRIP=1
 ;DECLARE VARIABLES
 N ROOT,LINE2
 S ROOT="^UTILITY(""VAQPST"","_$J_")"
 ;LOAD ROUTINE
 D LOAD(ROU,ROOT)
 Q:('$D(@ROOT)) ""
 ;GET SECOND LINE
 S LINE2=$G(@ROOT@(2,0))
 ;STRIP LEADING <TAB>;;
 S:(STRIP) LINE2=$P(LINE2,";;",2,$L(LINE2,";;"))
 K @ROOT
 Q LINE2
