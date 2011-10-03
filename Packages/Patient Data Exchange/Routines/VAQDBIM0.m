VAQDBIM0 ;ALB/JRP - MEANS TEST EXTRACTION;1-MAR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
 ; **********
 ; * PARTS OF THIS ROUTINE HAVE BEEN COPIED AND ALTERED FROM THE
 ; * DGMTSC* ROUTINES.  FOR MODULES THIS WAS DONE FOR, A REFERENCE
 ; * TO THE DGMTSC* ROUTINE WILL BE INCLUDE.
 ; **********
 ;
HEADER(SCREEN,ARRAY,OFFSET) ;SCREEN HEADER
 ;INPUT  : SCREEN - Screen number
 ;         ARRAY - Where to store header (full global reference)
 ;         OFFSET - Where to start adding lines
 ;       Input also includes all DG* variables required to build
 ;       the screen header.
 ;OUTPUT : n - Number of lines in display
 ;         -1^Error_text - Error
 ;
 ;This module is based on HD^DGMTSCU
 ;
 ;CHECK INPUT
 Q:('$D(SCREEN)) "-1^Screen number not passed"
 Q:('$D(ARRAY)) "-1^Reference to output array not passed"
 Q:('$D(OFFSET)) "-1^Offset not passed"
 ;DECLARE VARIABLES
 N TMP,INFO,Y,LINES
 S LINES=OFFSET
 S TMP=$G(DGMTSC(SCREEN))
 Q:(TMP="") "-1^Could not determine header information"
 S INFO="----- "_$P(TMP,";",2)_" -----"
 S TMP=((80-$L(INFO))\2)+1
 S @ARRAY@("DISPLAY",OFFSET,0)=$$INSERT^VAQUTL1(INFO,"",TMP)
 S OFFSET=OFFSET+1
 S @ARRAY@("DISPLAY",OFFSET,0)=""
 S OFFSET=OFFSET+1
 Q (OFFSET-LINES)
 ;
TITLE(ARRAY,OFFSET) ;MAIN TITLE FOR MEANS TEST DATA SEGMENT
 ;INPUT  : ARRAY - Where to store title (full global reference)
 ;         OFFSET - Where to start adding lines
 ;       Input also includes all DG* variables required to build
 ;       the screen header.
 ;OUTPUT : n - Number of lines in display
 ;         -1^Error_text - Error
 ;
 ;This module is based on HD^DGMTSCU
 ;
 ;CHECK INPUT
 Q:('$D(ARRAY)) "-1^Reference to output array not passed"
 Q:('$D(OFFSET)) "-1^Offset not passed"
 ;DECLARE VARIABLES
 N TMP,INFO,Y,LINES
 S LINES=OFFSET
 S INFO=$$REPEAT^VAQUTL1("-",79)
 S TMP="< Means Test Data >"
 S Y=((80-$L(TMP))\2)+1
 S INFO=$$INSERT^VAQUTL1(TMP,INFO,Y)
 S @ARRAY@("DISPLAY",OFFSET,0)=INFO
 S OFFSET=OFFSET+1
 S @ARRAY@("DISPLAY",OFFSET,0)=""
 S OFFSET=OFFSET+1
 S INFO="ANNUAL INCOME FOR "
 S Y=$$LYR^DGMTSCU1(DGMTDT) X ^DD("DD") S INFO=INFO_Y
 S Y=((80-$L(INFO))\2)+1
 S INFO=$$INSERT^VAQUTL1(INFO,"",Y)
 S @ARRAY@("DISPLAY",OFFSET,0)=INFO
 S OFFSET=OFFSET+1
 S TMP=$$DOBFMT^VAQUTL99(DGMTDT,0)
 S INFO="MEANS TEST DONE ON "_TMP
 S Y=((80-$L(INFO))\2)+1
 S INFO=$$INSERT^VAQUTL1(INFO,"",Y)
 S @ARRAY@("DISPLAY",OFFSET,0)=INFO
 S OFFSET=OFFSET+1
 S @ARRAY@("DISPLAY",OFFSET,0)=""
 S OFFSET=OFFSET+1
 Q (OFFSET-LINES)
 ;
ERROR(TRAN,ARRAY,OFFSET,REASON) ;ERROR DISPLAY
 ;INPUT  : TRAN - Pointer to VAQ - TRANSACTION file
 ;         ARRAY - Where to store information (full global reference)
 ;         OFFSET - Line segment started on
 ;         REASON - Reason for error (optional)
 ;OUTPUT : n - Number of lines in display
 ;         -1^Error_text - Error
 ;NOTES  : If TRAN>0
 ;           Encryption is based on the transaction
 ;         Else
 ;           Encryption is based ont the parameter file
 ;
 ;CHECK INPUT
 S TRAN=+$G(TRAN)
 I (TRAN) Q:('$D(^VAT(394.61,TRAN))) "-1^Did not pass valid pointer to VAQ - TRANSACTION file"
 Q:('$D(ARRAY)) "-1^Reference to output array not passed"
 Q:('$D(OFFSET)) "-1^Offset not passed"
 S REASON=$G(REASON)
 ;DECLARE VARIABLES
 N TMP,INFO,Y,LINES
 S LINES=OFFSET
 ;DELETE WHAT HAS BEEN ADDED
 S Y=$$KILLARR^VAQUTL1(ARRAY,"DISPLAY",LINES)
 Q:(Y) Y
 ;CREATE ERROR SEGMENT
 S INFO=$$REPEAT^VAQUTL1("-",79)
 S TMP="< Means Test Data >"
 S Y=((80-$L(TMP))\2)+1
 S INFO=$$INSERT^VAQUTL1(TMP,INFO,Y)
 S @ARRAY@("DISPLAY",OFFSET,0)=INFO
 S OFFSET=OFFSET+1
 S @ARRAY@("DISPLAY",OFFSET,0)=""
 S OFFSET=OFFSET+1
 S TMP="Unable to extract Means Test data"
 S Y=((80-$L(TMP))\2)+1
 S INFO=$$INSERT^VAQUTL1(TMP,"",Y)
 S @ARRAY@("DISPLAY",OFFSET,0)=INFO
 S OFFSET=OFFSET+1
 I (REASON'="") D
 .S REASON="("_REASON_")"
 .S Y=((80-$L(REASON))\2)+1
 .S INFO=$$INSERT^VAQUTL1(REASON,"",Y)
 .S @ARRAY@("DISPLAY",OFFSET,0)=INFO
 .S OFFSET=OFFSET+1
 F Y=1:1:2 S @ARRAY@("DISPLAY",OFFSET,0)="" S OFFSET=OFFSET+1
 ;CHECK TO SEE IF ENCRYPTION IS ON - ENCRYPT ARRAY IF IT IS
 S:(TRAN) TMP=$$TRANENC^VAQUTL3(TRAN,0)
 S:('TRAN) TMP=$$NCRYPTON^VAQUTL2(0)
 S:(TMP) TMP=$$ENCDSP^VAQHSH(TRAN,ARRAY,TMP,LINES,(OFFSET-LINES))
 Q (OFFSET-LINES)
