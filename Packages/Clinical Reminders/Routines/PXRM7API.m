PXRM7API ;SLC/JVS Clinical Reminders HL7 API; 09/21/2006
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;This is the beginning of the HL7 API's
 ;
 ;VARIABLE LIST
 ;IEN = IEN OF ENTRY IN EXTRACT FILE 810.3
 Q
 ;======================================================
HL7(IEN,SEE,ID) ;AllRequiredParameters
 ;IEN= The Ien of the entry in file 810.3 (Extract File)
 ;SEE=If you want to view the HL7 message, set to 1
 ;.ID= ID of the message.
 ;MODE=A or I A=from archive I=initial Load
 D EXTRACT^PXRM7XT(IEN,SEE,.ID)
 Q
 ;=======================================================
STATUS(ID) ;
 ;RETURNS THE STATUS OF THE MESSAGE
 ;ID= MESSAGE ID WHICH IS THE IEN IN FILE #772
 D STORE
 N IEND0,IEND1,STATUS
 S STATUS=""
 Q:'$D(^PXRMXT(810.3,"AHLID"))
 S IEND0=$O(^PXRMXT(810.3,"AHLID",ID,0))
 S IEND1=$O(^PXRMXT(810.3,"AHLID",ID,IEND0,0))
 S STATUS=$P($G(^PXRMXT(810.3,IEND0,5,IEND1,0)),"^",3)
 Q STATUS
 ;=======================================================
STATUS2(ID) ;
 ;RETURNS THE STATUS OF THE MESSAGE
 ;ID= MESSAGE ID WHICH IS THE IEN IN FILE #772
 N IDD,ID1,ID2,STATUS
 S STATUS=""
 S ID1=$O(^HL(772,"C",ID,0))
 S ID2=$O(^HL(772,"C",ID,ID1))
 D GETS^DIQ(772,ID2,20,"E","STATUS")
 S IDD=ID2_","
 S STATUS=$G(STATUS(772,IDD,20,"E"))
 Q STATUS
 ;======================================================
STORE ;
 N IEND0,IEND1,HL7ID,STATHL,STATX
 S HL7ID=""
 S IEND0=0 F  S IEND0=$O(^PXRMXT(810.3,IEND0)) Q:IEND0=""  D
 .S IEND1=0 F  S IEND1=$O(^PXRMXT(810.3,IEND0,5,IEND1)) Q:IEND1=""  D
 ..S HL7ID=$P($G(^PXRMXT(810.3,IEND0,5,IEND1,0)),"^",1)
 ..Q:HL7ID=""
 ..S STATHL=$$STATUS2^PXRM7API(HL7ID)
 ..S STATX=$P(^PXRMXT(810.3,IEND0,5,IEND1,0),"^",3)
 ..I STATHL'="" D
 ...S $P(^PXRMXT(810.3,IEND0,5,IEND1,0),"^",3)=STATHL
 ..I STATHL="",STATX="" D
 ...S $P(^PXRMXT(810.3,IEND0,5,IEND1,0),"^",3)="Successfully Completed"
 Q
 ;
