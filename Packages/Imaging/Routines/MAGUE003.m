MAGUE003 ;WOIFO/MLH - database encapsulation - radiology procedure description ; 08 Aug 2008 9:49 AM
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
PROCDESC(PROCCD,ERR) ;FUNCTION - return study description for an image
 ; input:    PROCCD    procedure IEN on ^RAMIS(71)
 ; output:   ERR       descriptive error message if any
 ; function return:    procedure code description
 ; 
 N RPROCR ; ---- radiology procedure record
 S RPROCR=$G(^RAMIS(71,+PROCCD,0)) ; IA # 1174
 I RPROCR="" S ERR="1~Missing radiology procedure code record" Q ""
 S ERR=""
 Q $P(RPROCR,"^",1)
