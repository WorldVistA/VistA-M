MAGUFFLA ;WOIFO/MLH - Imaging FileMan utility - return list of attributes for a field; 24 Sep 2011 01:49 PM
 ;;3.0;IMAGING;**118**;Mar 19, 2002;Build 4525;May 01, 2013
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
FIELDATT(OUT,FILENO,FIELDNO) ; rpc MAG FILEMAN FIELD ATTS
 ; input:   FILENO   The number of a Fileman file or subfile
 ;          FIELDNO  The number of a field within the file
 ; 
 ; output:  OUT()    Array of return values formatted as follows:
 ;   If no input or processing error:
 ;          OUT(1) = 0``n where n = number of entries on the OUT() array
 ;          OUT(m) where 1 < m <= n
 ;                 = attribute`value
 ;   If an input or processing error:
 ;          OUT(1) = n`error_message
 ;
 ; All ^DD references permitted under ICR #5551
 ; 
 K OUT
 I FILENO=+FILENO,$D(^DD(FILENO)) ; valid input
 E  S OUT(1)="-1`'"_FILENO_"' not a valid Fileman file or subfile number" Q
 I FIELDNO=+FIELDNO,$D(^DD(FILENO,FIELDNO)) ; valid input
 E  S OUT(1)="-2`'"_FIELDNO_"' not a valid field number" Q
 N ATTSTR,ATTARY,ATT,WPIX,OUTIX
 S ATTSTR="AUDIT;AUDIT CONDITION;COMPUTE ALGORITHM;COMPUTED FIELDS USED;"
 S ATTSTR=ATTSTR_"DATE FIELD LAST EDITED;DECIMAL DEFAULT;DELETE ACCESS;"
 S ATTSTR=ATTSTR_"DESCRIPTION;FIELD LENGTH;GLOBAL SUBSCRIPT LOCATION;"
 S ATTSTR=ATTSTR_"HELP-PROMPT;INPUT TRANSFORM;LABEL,MULTIPLE-VALUED;"
 S ATTSTR=ATTSTR_"OUTPUT TRANSFORM;POINTER;READ ACCESS;SOURCE;SPECIFIER;"
 S ATTSTR=ATTSTR_"TECHNICAL DESCRIPTION;TITLE;TYPE;WRITE ACCESS;"
 S ATTSTR=ATTSTR_"XECUTABLE HELP"
 D FIELD^DID(FILENO,FIELDNO,"N",ATTSTR,"ATTARY")
 S ATT="",OUTIX=1
 F  S ATT=$O(ATTARY(ATT)) Q:ATT=""  D
 . I $D(ATTARY(ATT))=1 D  Q
 . . S OUTIX=OUTIX+1,OUT(OUTIX)=ATT_"`"_ATTARY(ATT)
 . . Q
 . S WPIX=""
 . F  S WPIX=$O(ATTARY(ATT,WPIX)) Q:WPIX=""  D
 . . S OUTIX=OUTIX+1,OUT(OUTIX)=ATT_"`"_ATTARY(ATT,WPIX)
 . . Q
 . Q
 S OUT(1)="0``"_OUTIX ; count
 Q
