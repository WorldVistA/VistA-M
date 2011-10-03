MAGUE002 ;WOIFO/MLH - database encapsulation - radiology order record ; 08 Aug 2008 9:41 AM
 ;;3.0;IMAGING;**54**;03-July-2009;;Build 1424
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
RORDRR(MAGRRPTI,ERR) ;FUNCTION - return a radiology order record
 ; input:    MAGRRPTI  radiology report index from image record
 ; output:   ERR       error message if couldn't get record
 ; function return:    radiology order record
 ; 
 N MAGRRPTR ; -- radiology report record
 N MAGD0 ; ----- Radiology patient file IEN
 N MAGD1 ; ----- date index to order record in rad pt file
 N MAGD2 ; ----- subdate index to order record in rad pt file
 N V ; --------- scratch var
 N MAGRORDR ; -- radiology order record
 N MAGRPROC ; -- radiology procedure code
 S ERR=""
 S MAGRRPTR=$G(^RARPT(MAGRRPTI,0))
 S MAGD0=$P(MAGRRPTR,"^",2)
 I 'MAGD0 S ERR="1~Radiology patient not found" Q ""
 S MAGD1=9999999.9999-$P(MAGRRPTR,"^",3)
 S V=$P(MAGRRPTR,"^",4)
 S MAGD2=$O(^RADPT(MAGD0,"DT",MAGD1,"P","B",V,"")) ; IA # 1172
 I 'MAGD2 S ERR="3~Order record pointer not found" Q ""
 S MAGRORDR=$G(^RADPT(MAGD0,"DT",MAGD1,"P",MAGD2,0)) ; IA # 1172
 I 'MAGRORDR S ERR="4~Radiology order record not found" Q ""
 S ERR=""
 Q MAGRORDR
