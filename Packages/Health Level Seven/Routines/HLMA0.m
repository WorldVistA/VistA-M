HLMA0 ;AISC/SAW-Message Administration Module (Cont'd) ;7/17/97  17:30
 ;;1.6;HEALTH LEVEL SEVEN;**34,109**;Oct 13, 1995
RECEIVE(HLLD0,HLLD1) ;Entry point to receive an external message
 ;
 ;This is a subroutine call with parameter passing.  There are no
 ;output parameters returned by this call.
 ;
 ;Required Input Parameter
 ;  HLLD0 = Internal entry number where message is stored in Logical Link
 ;           file or XM if message is stored in MailMan
 ;Optional Input Parameter (Required if HLLD0 does not equal XM)
 ;  HLLD1 = Internal entry number of IN QUEUE multiple entry in Logical
 ;           Link file
 ;
 ;Check for required parameter
 I $G(HLLD0)']"" Q
 I HLLD0'="XM",'$G(HLLD1) Q
 N HLRESLT
 ;Get message ID and Message Text IEN for message being received
 D CREATE^HLTF(.HLMID,.HLMTIEN,.HLDT,.HLDT1)
 K HLDT,HLDT1
 ;Call Transaction Processor
 D PROCESS^HLTP0(HLMTIEN,HLLD0,$S($G(HLLD1):HLLD1,1:""),.HLRESLT)
 ;Update Status to Successfully Completed or Error During Transmission
 D STATUS^HLTF0(HLMTIEN,$S(HLRESLT:4,1:3),$S(HLRESLT:+HLRESLT,1:""),$S(HLRESLT:$P(HLRESLT,"^",2),1:""),,$S($G(HLERR("SKIP_EVENT"))=1:1,1:0))
EXIT K HLMTIEN,HLRESLT
 Q
