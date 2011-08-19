SR122PST ;BIR/RJS - SRAAIS PROTOCOL 101 UPDATE ;11/21/03
 ;;3.0;SURGERY;**122**;21 Nov 03
START ; THIS ROUTINE IS USED TO UPDATE THE PROTOCOL FILE 101 FOR THE AAIS
 ; SURGERY INTERFACE. IT IS A POST INSTALL ROUTINE FOR SR*3.0*122
 S (SRSNDB,SRLOGB)="SR AAIS",SRRECB="SR SURGERY",SRFDA="101",(SRSND,SRREC,SRLOG,SRBAD)=""
 S SRSND=$O(^HL(771,"B",SRSNDB,SRSND)),SRREC=$O(^HL(771,"B",SRRECB,SRREC)),SRLOG=$O(^HLCS(870,"B",SRLOGB,SRLOG))
 F SRLINE=1:1 S SRTXT=$P($T(SRAAIS+SRLINE),";;",2,99) Q:SRTXT=""  D
 . K SRFIELD S SRIEN=""
 . S SRIEN=$O(^ORD(101,"B",SRTXT,SRIEN))_","
 . S:SRIEN="," SRBAD=1
 . S SRFIELD(SRFDA,SRIEN,"99")=$H,SRFIELD(SRFDA,SRIEN,"770.1")=SRSND
 . S SRFIELD(SRFDA,SRIEN,"770.2")=SRREC,SRFIELD(SRFDA,SRIEN,"770.7")=SRLOG
 . D FILE^DIE("","SRFIELD","SRERR")
 . I $D(SRERR("DIERR",1)) D
 .. S MSGTXT=SRTXT_" NOT UPDATED - ERROR CODE "_SRERR("DIERR",1)
 .. D BMES^XPDUTL(MSGTXT)
 .. K MSGTXT
 . I '$D(SRERR("DIERR",1)) D
 .. S MSGTXT=SRTXT_" SUCCESSFULLY UPDATED"
 .. D BMES^XPDUTL(MSGTXT)
 .. K MSGTXT
 . K SRERR
 . Q
 I SRBAD=1 D BMES^XPDUTL("THERE WAS AN ERROR IN THE POST INSTALL"),BMES^XPDUTL("PLEASE CONTACT EVS")
 K SRSND,SRLOG,SRREC,SRTXT,SRLINE,SRIEN,SRFDA,SRFIELD,SRERR,SRBAD
 D BMES^XPDUTL("PROTOCOL UPDATE COMPLETE")
 Q
SRAAIS ;;
 ;;SR Notification of Appointment Booking
 ;;SR Notification of Appointment Cancellation
 ;;SR Notification of Appointment Deletion
 ;;SR Notification of Appointment Modification
 ;;SR Notification of Appointment Rescheduling
 ;;SR Other Master File Notification
 ;;SR Query for Scheduling Information
 ;;SR Receiver of Appointment Cancellation
 ;;SR Receiver of Appointment Deletion
 ;;SR Receiver of Appointment Modification
 ;;SR Receiver of Appointment Rescheduling
 ;;SR Receiver of Master File Notification
 ;;SR Receiver of New Appointment Booking
 ;;SR Receiver of Observation Unsolicited
 ;;SR Receiver of Scheduling Query
 ;;SR Receiver of Staff Master File Notification
 ;;SR Receiver of Unsolicited Requested Observation
 ;;SR Staff Master File Notification
 ;;SR Unsolicited transmission of AAIS Requested Observation
 ;;SR Unsolicited transmission of VistA Requested Observation
 Q
