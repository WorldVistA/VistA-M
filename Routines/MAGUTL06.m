MAGUTL06 ;WOIFO/SG - VALIDATION OF MULTI-VALUE PARAMETERS ; 3/9/09 12:53pm
 ;;3.0;IMAGING;**93**;Dec 02, 2009;Build 163
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
 Q
 ;
 ;##### VALIDATES THE LIST OF NAMES/CODES
 ;
 ; CDNMLIST      List of internal and/or external values of a 'set
 ;               of codes' field defined by the FILE and FIELD
 ;               parameters. Items should be separated by the '^'
 ;               (see also the FLAGS parameter).
 ;
 ; FILE          File/Subfile number
 ; FIELD         Field number
 ;
 ; MAG8NODE      Closed reference to a node where the results are
 ;               returned to:
 ;
 ; @MAG8NODE@(   The list of external names is returned here. Items
 ;               are separated with the same delimiter as those in
 ;               the source list.
 ;
 ;   Code)       Name
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;
 ;                 C  "Capitalize" the external names
 ;
 ;                 ,  Use comma as item separator instead of '^'
 ;                    (not recommended).
 ; 
 ;                 Z  Treat 0 (zero) as valid code regardles of
 ;                    the field definition.
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Success
 ;           >0  Number of the piece of the source list that
 ;               contains an invalid code or name.
 ;
VALCNLST(CDNMLIST,FILE,FIELD,MAG8NODE,FLAGS) ;
 N ERR,I,ICNT,ITEM,LS,MAG8MSG,MAG8RES,NAME,RC
 S FLAGS=$G(FLAGS),LS=$S(FLAGS[",":",",1:"^")
 Q:$TR(FLAGS,"C,Z")'="" $$IPVE^MAGUERR("FLAGS")
 K @MAG8NODE  S (ICNT,RC)=0
 ;
 ;=== Process items of the list
 F I=1:1:$L(CDNMLIST,LS)  D  Q:RC
 . ;--- Get item name or code
 . S ITEM=$$TRIM^XLFSTR($P(CDNMLIST,LS,I))  Q:ITEM=""
 . ;--- Special check for zero
 . I ITEM=0,FLAGS["Z"  D  Q
 . . S ICNT=ICNT+1,NAME="<empty>"
 . . S $P(@MAG8NODE,LS,ICNT)=NAME  ; External name
 . . S @MAG8NODE@(0)=NAME          ; Internal code
 . . Q
 . ;--- Validate the item
 . D CHK^DIE(FILE,FIELD,"E",ITEM,.MAG8RES,"MAG8MSG")
 . I MAG8RES="^"  S RC=I,ERR=$G(MAG8MSG("DIERR",1))  D:ERR'=701  Q
 . . I ERR=401  S RC=$$IPVE^MAGUERR("FILE")   Q
 . . I ERR=501  S RC=$$IPVE^MAGUERR("FIELD")  Q
 . ;--- Store external and internal values
 . S ICNT=ICNT+1
 . S NAME=$S(FLAGS["C":$$SNTC^MAGUTL05(MAG8RES(0)),1:MAG8RES(0))
 . S $P(@MAG8NODE,LS,ICNT)=NAME  ; External name
 . S @MAG8NODE@(MAG8RES)=NAME    ; Internal code
 . Q
 ;
 ;=== Cleanup
 I RC  K @MAG8NODE  Q RC
 Q 0
 ;
 ;##### VALIDATES THE LIST OF NAMES/POINTERS
 ;
 ; PTNMLIST      Reference to a local variable that stores a list of
 ;               IENs and/or values of the .01 field from the file
 ;               defined by the FILE parameter. Items should be
 ;               separated by the '^' (see also the FLAGS parameter).
 ;
 ; FILE          File number. The file must have the standard
 ;               "B" cross-reference for the .01 field.
 ;
 ;
 ; MAG8NODE      Closed reference to a node where the results are
 ;               returned to:
 ;
 ; @MAG8NODE@(   The list of names (.01 values) is returned here.
 ;               Items are separated with the same delimiter as those
 ;               in the source list.
 ;
 ;   IEN)        Name
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;
 ;                 C  "Capitalize" the names
 ;
 ;                 ,  Use comma as item separator instead of '^'.
 ;                    (not recommended).
 ; 
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Success
 ;           >0  Number of the piece of the source list that
 ;               contains an invalid code or name.
 ;
VALPNLST(PTNMLIST,FILE,MAG8NODE,FLAGS) ;
 N I,ICNT,IEN,ITEM,LS,MAGMSG,NAME,RC,ROOT,TMP
 S FLAGS=$G(FLAGS),LS=$S(FLAGS[",":",",1:"^")
 Q:$TR(FLAGS,"C,")'="" $$IPVE^MAGUERR("FLAGS")
 K @MAG8NODE  S (ICNT,RC)=0,ROOT=$$ROOT^DILFD(FILE,,1)
 Q:ROOT="" $$IPVE^MAGUERR("FILE")
 ;
 ;=== Process items of the list
 F I=1:1:$L(PTNMLIST,LS)  D  Q:RC
 . ;--- Get name or IEN
 . S ITEM=$$TRIM^XLFSTR($P(PTNMLIST,LS,I))  Q:ITEM=""
 . ;--- IEN
 . I +ITEM=ITEM,$D(@ROOT@(ITEM))  D  Q
 . . S NAME=$$GET1^DIQ(FILE,ITEM_",",.01,,,"MAGMSG")
 . . I $G(DIERR)  S RC=$$DBS^MAGUERR("MAGMSG",FILE,ITEM_",")  Q
 . . S ICNT=ICNT+1
 . . S:FLAGS["C" NAME=$$SNTC^MAGUTL05(NAME)
 . . S $P(@MAG8NODE,LS,ICNT)=NAME  ; Name
 . . S @MAG8NODE@(ITEM)=NAME       ; IEN
 . . Q
 . ;--- Name
 . I $D(@ROOT@("B",ITEM))<10  S RC=I  Q
 . S ICNT=ICNT+1
 . S NAME=$S(FLAGS["C":$$SNTC^MAGUTL05(ITEM),1:ITEM)
 . S $P(@MAG8NODE,LS,ICNT)=NAME
 . S IEN=""
 . F  S IEN=$O(@ROOT@("B",ITEM,IEN))  Q:IEN=""  D
 . . S @MAG8NODE@(IEN)=NAME
 . . Q
 . Q
 ;
 ;=== Cleanup
 I RC  K @MAG8NODE  Q RC
 Q 0
