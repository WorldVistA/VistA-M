MAGMC2CP ;WOIFO/JSL,SAF - Imaging API for Med conversion to CP
 ;;3.0;IMAGING;**47**;Feb 02, 2005
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
 ; CALL WITH:
 ;   MODE = Boolean value 0: TEST mode, 1: Real mode
 ;   VPtr = Variable pointer to Medicine file report that is being converted
 ;   MAGTIU = The internal entry number of TIU note that VI is converting the medicine pointer to
 ;   IPtr = The internal entry number was stored in the Medicine file pointer pointed back to MAG(2005
 ;   
 ; RETURN:
 ;   Error  -1^Description of error
 ;   No Action Needed  0^No Action
 ;   OK 1^Success message
 ;   
TIU(MODE,VP,MAGTIU,IP) ;
 N MAGIEN,MEDIEN,MSG,MAGRET,Y,D0,D1
 S MAGRET="0^No Action",MSG=""
 S MODE=$S($G(MODE)="":0,1:MODE)
 S MEDIEN=+$G(VP) I 'MEDIEN Q "-1^No Medicine IEN"
 S TIUIEN=+$G(MAGTIU) I 'TIUIEN Q "-1^No TIU IEN"
 S MAGIEN=IP I '$G(MAGIEN) Q "-1^No MAG IEN"
 I '$D(^MAG(2005,MAGIEN,0)) Q "-1^No image file "_MAGIEN
 I '$$CHKMED(MEDIEN,MAGIEN) Q "-1^No Medicine report found - "_MSG
 I MODE D 
 . D FILE^MAGGSTI(.MAGRET,MAGIEN,TIUIEN) I 'MAGRET S MAGRET="-1^Fail" Q
 . D LOG(MAGIEN,"TIU MEDICINE CONVERSION"_U_MODE_U_MEDIEN_U_MAGTIU_U_MEDIEN)
 . S MAGRET="1^Success"
 E  Q "0^No action"
 Q MAGRET
 ;
CHKMED(MEDIEN,MAGIEN) ;
 I '$G(MEDIEN)!'$G(MAGIEN) Q 0
 S Y=$G(^MAG(2005,MAGIEN,2)),D0=$P(Y,U,6),D1=$P(Y,U,7)
 I 'D0!'D1 S MSG="No report file "_MAGIEN_" found." Q 0
 S MAGRPT=$G(^DIC(D0,0,"GL")),LN=$L(MAGRPT) Q:MAGRPT="" 0
 S GLB=MAGRPT_$S($E(MAGRPT,LN)="(":"",$E(MAGRPT,LN)=",":"",1:",")_D1_")"  ;report global
 I $Q(@GLB)'[MAGRPT S MSG="No report file "_MAGRPT_" found." Q 0
 Q 1  ;ok
LOG(IEN,STR) ;
 S ^MAGTMP("MAGZTIU",IEN)=STR
 Q
 ;
