MAG7UFO ;WOIFO/MLH - HL7 utilities - populate NEW PERSON phone(s) into an XPN field ; 12 Jun 2003  4:27 PM
 ;;3.0;IMAGING;**11**;14-April-2004
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
NPFON(XFLD,XIEN) ; FUNCTION - populate NEW PERSON phone(s) into an XPN field
 ;
 ; Input:    XFLD       name of array into which to populate
 ;                        (see MAG7UP for structure)
 ;           XIEN       internal entry number on ^VA(200)
 ; 
 ; Expects:  Fileman variables from call to DI or Kernel
 ; 
 ; function return:     error status (default = '0', false)
 ;
 N FGET ; --- GET return (discarded)
 N FEXIT ; -- exit status flag
 N NPFON ; -- array for return of phone numbers
 N IFON ; --- index for NPFON array
 N ILOOP ; -- loop index
 N PHN ; ---- the actual phone number
 N IREP ; --- repetition index for XFLD
 ;
 S FEXIT=0 ; default no error
 I $G(XFLD)="" D  Q FEXIT
 . S FEXIT="-1;valid array not provided"
 . Q
 E  I '$G(XIEN) D  Q FEXIT
 . S FEXIT="-2;valid NEW PERSON IEN not provided"
 . Q
 D GETS^DIQ(200,XIEN,".131;.132;.133;.134;.135;.136;.137;.138","","NPFON")
 F ILOOP=1:1:8 D
 . S IFON=ILOOP/1000+.13,PHN=$G(NPFON(200,XIEN_",",IFON))
 . I PHN]"" D
 . . S IREP=$O(@XFLD@(" "),-1)+1
 . . S @XFLD@(IREP,1,1)=PHN
 . . S @XFLD@(IREP,2,1)=$P("PRN^WPN^^^^^BPN^BPN","^",ILOOP)
 . . S @XFLD@(IREP,3,1)=$P("PH^PH^PH^PH^PH^FX^BP^BP","^",ILOOP)
 . . Q
 . Q
 Q FEXIT
