MAGUFFLL ;WOIFO/MLH - Imaging FileMan utility - return list of fields in a file; 24 Sep 2011 11:52 AM
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
FIELDLST(OUT,FILENO,ORDER) ; rpc MAG FILEMAN FIELD LIST
 ; input:   FILENO   The number of a Fileman file or subfile
 ;          ORDER    Desired order of field list return:
 ;                   A   alpha
 ;                   N   numeric (default)
 ; 
 ; output:  OUT()    Array of return values formatted as follows:
 ;   If no input or processing error:
 ;          OUT(1) = 0``n where n = number of entries on the OUT() array
 ;          OUT(m) where 1 < m <= n
 ;                 = field_number`field_name
 ;   If an input or processing error:
 ;          OUT(1) = n`error_message
 ;
 ; All ^DD references permitted under ICR #5551
 ; 
 K OUT
 I FILENO=+FILENO,$D(^DD(FILENO)) ; valid input
 E  S OUT(1)="-1`'"_FILENO_"' not a valid Fileman file or subfile number" Q
 S ORDER=$G(ORDER,"N")
 I ".A.N."'[("."_ORDER_".") S OUT(1)="-2`invalid order (must be A or N)" Q
 N FIELDNAME,FIELDNO,FIELDINFO,FIELDLIST,FIELDIX,OUTIX
 S FIELDNAME=""
 F  S FIELDNAME=$O(^DD(FILENO,"B",FIELDNAME))  Q:FIELDNAME=""  D
 . S FIELDNO=0
 . F  S FIELDNO=$O(^DD(FILENO,"B",FIELDNAME,FIELDNO)) Q:'FIELDNO  D
 . . S FIELDLIST($S(ORDER="N":FIELDNO,1:$O(FIELDLIST(""),-1)+1))=FIELDNO_"`"_FIELDNAME
 . . Q
 . Q
 S FIELDIX=0,OUTIX=1
 F  S FIELDIX=$O(FIELDLIST(FIELDIX)) Q:'FIELDIX  D
 . S OUTIX=OUTIX+1,OUT(OUTIX)=FIELDLIST(FIELDIX)
 . Q
 S OUT(1)="0``"_(OUTIX-1) ; count
 Q
