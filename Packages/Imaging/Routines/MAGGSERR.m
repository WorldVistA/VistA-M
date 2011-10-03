MAGGSERR ;WOIFO/GEK - IMAGING ERROR TRAP, AND ERROR LOG ; [ 12/27/2000 10:49 ]
 ;;3.0;IMAGING;**7**;Jul 12, 2002
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
 ;  Calling this error trap will enable logging Imaging errors and 
 ;  sending messages for certain errors etc. later
 ; set it using :
 ;    >N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGSERR"
 ;
 ; This assumes the Return variable or array is MAGRY or MAGRY()
 ;
ERRA ; ERROR TRAP FOR Array Return variables
 N ERR S ERR=$$EC^%ZOSV
 S MAGRY(0)="0^"_ERR
 D LOGERR(ERR)
 D @^%ZOSF("ERRTN")
 Q
 ;
AERRA ; ERROR TRAP FOR Global Return Variables
 N ERR S ERR=$$EC^%ZOSV
 S @MAGRY@(0)="0^ERROR "_ERR
 D LOGERR(ERR)
 D @^%ZOSF("ERRTN")
 Q
ERR ; ERROR TRAP FOR String Return variables
 N ERR S ERR=$$EC^%ZOSV
 S MAGRY="0^ERROR "_ERR
 D LOGERR(ERR)
 D @^%ZOSF("ERRTN")
 Q
LOGERR(ERROR,MAGSESS) ;
 N SESSIEN
 S SESSIEN=$S($G(MAGSESS):MAGSESS,$D(MAGJOB("SESSION")):MAGJOB("SESSION"),1:0)
 I 'SESSIEN Q
 N MAGGFDA,MAGXERR,MAGXIEN,MAGNODE
 S MAGNODE="+1,"_+SESSIEN_","
 ;S MAGNODE="+1,10,"
 S MAGGFDA(2006.823,MAGNODE,.01)=ERROR
 D UPDATE^DIE("","MAGGFDA","MAGXIEN","MAGXERR")
 ; error flag for this session in workstation file
 I $G(MAGJOB("WRKSIEN")) D
 . S MAGNODE=+MAGJOB("WRKSIEN")_","
 . S MAGGFDA(2006.81,MAGNODE,11)=+MAGXIEN(1) ;
 . D UPDATE^DIE("","MAGGFDA","MAGXIEN","MAGXERR")
 Q
