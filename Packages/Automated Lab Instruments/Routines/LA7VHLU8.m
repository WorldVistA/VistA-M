LA7VHLU8 ;DALOI/JMC - LAB Application Acknowledgment builder;Nov 14, 2007 ;04/30/10  17:16
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 ; Reference to PROTOCOL file (#101) supported by DBIA #872
 ;
 Q
 ;
 ;
ACK(LA7) ; Returns the application acknowledgement to the sending application.
 ; Indicates any error encountered in processing the message.
 ; Used when messages are processed separately from when they are received.
 ;  Examples LEDI ORM message that builds Lab Pending Order file.
 ;
 ; Called by routine LA7VIN1
 ;
 ; Call with LA7 array passed by reference
 ;      LA7(62.48)=ien of related configuration in file #62.48
 ;      LA7(62.49)=ien of message in file #62.49 being acknowledged
 ;      LA7("ACK")=acknowledgment status (AA, AE, AR)
 ;      LA7("MSG")=text of error message to be returned
 ;
 N HL,HLMTIENS,I,LA6249,LA76248,LA7X,LA7Y
 ;
 ; Check for entry in 62.48
 S LA76248=+$G(LA7(62.48))
 I '$G(LA76248)!('$D(^LAHM(62.48,LA76248,0))) Q
 S LA76248(0)=$G(^LAHM(62.48,LA7(62.48),0)),LA7X=$P(LA76248(0),"^")
 ;
 ; Check for entry in 62.49
 S LA6249=+$G(LA7(62.49))
 I '$G(LA6249)!('$D(^LAHM(62.49,LA6249,0))) Q
 F I=0,700 S LA6249(I)=$G(^LAHM(62.49,LA6249,I))
 ;
 ; Call reprocess message to build and send ACK and clear purge flag
 S LA7Y=$$REPROC^HLUTIL($P(LA6249(700),";",2),"D BLDACK^LA7VHLU8")
 I LA7Y=0 S HLMTIENS=$P(LA6249(700),";",2),LA7X=$$TOPURG^HLUTIL()
 ;
 Q
 ;
 ;
BLDACK ; Create/initialize HL ACK (ORR) message
 ;
 ;ZEXCEPT:LA7,LA76248
 ;
 N GBL,HLL,HLP,I,X
 N LA76249,LA7AERR,LA7DATA,LA7ECH,LA7FS,LA7ID,LA7LL,LA7MID,LA7MSA,LA7MSH,LA7X,LA7Y
 ;
 ; No application acknowledgement
 I $G(HL("APAT"))="NE" Q
 ;
 ; Other system only wants ACK on successful completion condition and we found an error.
 I LA7("ACK")'="AA",$G(HL("APAT"))="SU" Q
 ;
 ; Other system only wants ACK on error/reject condition
 I LA7("ACK")="AA",$G(HL("APAT"))="ER" Q
 ;
 S GBL="^TMP(""HLA"","_$J_")"
 K @GBL
 S LA76249=$$INIT6249^LA7VHLU
 D RSPINIT^HLFNC2(HL("EIDS"),.HL)
 S LA7FS=HL("RFS"),LA7ECH=HL("RECH")
 ;
 ; Build pseudo MSH for file #62.49 entry
 S LA7MSH(0)="MSH",LA7MSH(1)=LA7ECH,LA7MSH(2)=HL("RAN"),LA7MSH(3)=HL("RAF"),LA7MSH(4)=HL("SAN"),LA7MSH(5)=HL("SAF")
 S LA7MSH(9)=HL("RMTN")_$E(LA7ECH,1)_HL("RETN"),LA7MSH(11)=HL("PID"),LA7MSH(12)=HL("VER")
 S LA7MSH(15)="AL",LA7MSH(16)="NE"
 D BUILDSEG^LA7VHLU(.LA7MSH,.LA7DATA,LA7FS)
 D FILE6249^LA7VHLU(LA76249,.LA7DATA)
 ;
 ; Build and file MSA segment
 K LA7DATA
 S LA7MSA(0)="MSA",LA7MSA(1)=LA7("ACK"),LA7MSA(2)=HL("MID")
 I $G(LA7("MSG"))'="" D
 . S LA7MSA(3)=$$CHKDATA^LA7VHLU3($P(LA7("MSG"),"^"),LA7FS_LA7ECH)
 . I $P(LA7("MSG"),"^",2)="" Q
 . S $P(LA7MSA(3),$E(LA7ECH),2)=$$CHKDATA^LA7VHLU3($P(LA7("MSG"),"^",2),LA7FS_LA7ECH)
 ;
 S LA7ID=$P(LA76248(0),"^",1)_"-O-ACK-"_LA7MSA(2)
 D SETID^LA7VHLU1(LA76249,"",LA7ID,1)
 D SETID^LA7VHLU1(LA76249,"",LA7MSA(2),0)
 ;
 ; Save message ids in file #62.49
 D BUILDSEG^LA7VHLU(.LA7MSA,.LA7DATA,LA7FS)
 D FILESEG^LA7VHLU(GBL,.LA7DATA)
 D FILE6249^LA7VHLU(LA76249,.LA7DATA)
 ;
 ; Send the HL7 message.
 S LA7LL=$$GET1^DIQ(101,HL("EIDS")_",",770.7,"I")
 S HLL("LINKS",1)=HL("EIDS")_"^"_LA7LL
 S HLL("SET FOR APP ACK")=1
 S HLP("NAMESPACE")="LA"
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"GM",1,.LA7MID,"",.HLP)
 ;
 S HL("MTN")=HL("RMTN"),HL("SAN")=HL("RAN"),HL("SAF")=HL("RAF"),HL("APAT")=""
 D UPDT6249^LA7VORM1
 L -^LAHM(62.49,LA76249)
 Q
