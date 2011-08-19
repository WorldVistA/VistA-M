LA7POC ;DALOI/JMC - Lab HL7 Point of Care; Jan 12, 2004
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**67**;Sep 27, 1994
 ;
 ; Reference to HLL("SET FOR APP ACK") supported by DBIA #TBD
 Q
 ;
RTRA ; Setup links and subscriber array for HL7 ADT message generation
 ; for those LA7POC* entries in file #62.48 which indicate they want to
 ; subscribe to ADT messages. Interface types POCA in file #62.48
 ; will be subscribers to VistA HL7 ADT messages.
 ;
 ; Called by subscriber protocol LA7POC ADT RTR which functions as a
 ; router.
 ;
 N LA76248,LA7Y
 ;
 ; Check entries with root 'LA7POC" as name and interface type POCA (21)
 ; to subscribe to ADT message feed from VistA.
 S LA76248=0
 F  S LA76248=$O(^LAHM(62.48,LA76248)) Q:'LA76248  D
 . S LA76248(0)=$G(^LAHM(62.48,LA76248,0)),LA7Y=$P(LA76248(0),"^")
 . I $E(LA7Y,1,6)'="LA7POC" Q
 . I $P(LA76248(0),"^",3)'=1 Q  ; Inactive status
 . I $P(LA76248(0),"^",9)'=21 Q
 . S HLL("LINKS",LA76248)=LA7Y_" ADT SUBS^"_LA7Y_"A"
 Q
 ;
 ;
ACK(LA7) ; Returns the application acknowledgement to the sending POC
 ; application. Indicates any error encountered in processing the POC
 ; results. Setup link for HL7 ACK message generation for LA7POC* entries
 ; in file #62.48 when POC ORU message has been processed in VistA.
 ;
 ; Called by routine LA7VPOC
 ;
 ; Call with LA7 array passed by reference
 ;      LA7(62.48)=ien of related configuration in file #62.48  
 ;      LA7(62.49)=ien of message in file #62.49 being acknowledged
 ;      LA7("ACK")=acknowledgment status (AA, AE, AR)
 ;      LA7("MSG")=text of error message to be returned
 ;
 N HL,HLMTIENS,LA6249,LA76248,LA7X,LA7Y
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
 S LA7Y=$$REPROC^HLUTIL($P(LA6249(700),";",2),"D BLDACK^LA7POC")
 I LA7Y=0 S HLMTIENS=$P(LA6249(700),";",2),LA7X=$$TOPURG^HLUTIL()
 ;
 Q
 ;
 ;
BLDACK ; Create/initialize HL ACK message
 ;
 N GBL,HLL,HLP,I,X
 N LA76249,LA7AERR,LA7DATA,LA7ECH,LA7FS,LA7ID,LA7MID,LA7MSA,LA7MSH,LA7X,LA7Y
 ;
 ; No application acknowledgement
 I HL("APAT")="NE" Q
 ;
 ; Other system only wants ACK on successful completion condition and we found an error.
 I LA7("ACK")'="AA",HL("APAT")="SU" Q
 ;
 ; Other system only wants ACK on error/reject condition
 I LA7("ACK")="AA",HL("APAT")="ER" Q
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
 S LA7ID=$P(LA76248(0),"^",1)_"-O-ACK-"_LA7MSA(2)
 D BUILDSEG^LA7VHLU(.LA7MSA,.LA7DATA,LA7FS)
 D FILESEG^LA7VHLU(GBL,.LA7DATA)
 D FILE6249^LA7VHLU(LA76249,.LA7DATA)
 ;
 ; Send the HL7 message.
 S HLL("SET FOR APP ACK")=1
 S HLL("LINKS",1)=HL("EIDS")_"^"_$P(LA76248(0),"^")
 S HLP("NAMESPACE")="LA"
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"GM",1,.LA7MID,"",.HLP)
 ;
 S HL("MTN")=HL("RMTN"),HL("SAN")=HL("RAN"),HL("SAF")=HL("RAF"),HL("APAT")=""
 D UPDT6249^LA7VORM1
 L -^LAHM(62.49,LA76249)
 Q
