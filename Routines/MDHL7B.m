MDHL7B ; HOIFO/WAA -Bi-directional interface routine ;7/23/01  11:41
 ;;1.0;CLINICAL PROCEDURES;;Apr 01, 2004
 ;
 ; This routine will take an entry from 702 and submit that data
 ; to the instrument that was indicated by the user
 ; SUB is a submit function
 ;    MDD702 is the IEN for the Entry from 702 that
 ;           needs to be sent.
 ;    The function will return -1^Submission failed and why
 ;                              0^Device not Bi-Directional
 ;                              1^Study submitted
TMPSUB(MDD702) ; Process a submitted entry from user.
 ; drp 16-JUL-2002 13:30:32 
 N DEVICE
 S DEVICE=+$P(^MDD(702,MDD702,0),U,11) Q:'DEVICE "0^No Device - TEST"
 I +$P($G(^MDS(702.09,DEVICE,.1)),U,3) Q "1^Study Submitted - TEST"
 Q "0^No Bi Di Cap - TEST"
 ;
SUB(MDD702) ; Change to SUB when working
 N MDORFLG,RESULT,MSG,MDERROR
 S MDORFLG=1
 D EN1
 Q RESULT_U_MSG
 ;
CANCEL(MDD702) ; Cancel Orders
 N MDORFLG,RESULT,MSG,MDERROR
 S MDORFLG=0
 D EN1
 Q RESULT_U_MSG
 ;
EN1 ; The main entry point for the order to be processed.
 N DEVIEN,WORKING,MDIORD
 ; Get the device that will process this study
 ; Build an HL7 Message based in the device.
 ; After the device has processed the message this routine will
 ; update the status with in 702.
 S RESULT=1,MSG=$S(MDORFLG=1:"Study Submitted.",1:"Study Cancelled")
 I '$D(^MDD(702,MDD702,0)) S MSG="There is no study in 702 for entry "_MDD702_".",RESULT=-1
 I RESULT'=-1 D  ;Get the device based on the CP def
 . S DEF=$P(^MDD(702,MDD702,0),U,4) I DEF<1 S RESULT=-1,MSG="No CP DEFINITION for this entry in file 702.01."
 . Q
 I RESULT'=-1 D  ; Check to see that there is a device entered for this procedure
 . S DEVIEN=$P(^MDD(702,MDD702,0),U,11) I DEVIEN>0 Q
 . S RESULT=0,MSG="No DEVICE is defined." Q
 . Q
 ;
 ; DRP/16-MAY-2003 14:44:36 - Check for Loopback IP
 I $$GET1^DIQ(702.09,DEVIEN_",",.14)="127.0.0.1" D  Q
 . D LOOPBACK^MDHL7XXX(MDD702,DEVIEN)
 . S RESULT=+$$GET1^DIQ(702.09,DEVIEN_",",.13,"I"),MSG="OK"
 . Q
 ;
 I RESULT>0 D  ; Check to see that the device is a active and working
 . S WORKING="" D INST^MDHL7U2(DEVIEN,.WORKING)
 . Q:WORKING
 . S RESULT=-1,MSG="There is a problem with the device entry in file 702.09."
 . Q
 I RESULT>0 D  ; Check to see if the device is bi-directional
 . N LINE
 . S LINE=$G(^MDS(702.09,DEVIEN,.1))
 . I $P(LINE,U,3)'=1 D  Q  ; The Device is not Bi-Directional 
 . . S RESULT=0,MSG="Device not Bi-Directional."
 . . Q
 . ; The device is Bi-Directional and we are getting an MDIORD number.
 . S MDIORD=$$GETIORD^MDRPCOT1(MDD702) I MDIORD=-1 D
 . . S RESULT=-1,MSG="Unable to create Instrument Order Number."
 . . Q
 . Q
 I RESULT=1 D  ; Process the message to be sent
 . D EN1^MDHL7BH ; Build HL7 Message
 . I $P(MDERROR,U,2) S RESULT="-1",MSG=$P(MDERROR,U,3)
 . Q
 Q
