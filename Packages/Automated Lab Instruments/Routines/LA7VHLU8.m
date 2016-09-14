LA7VHLU8 ;DALOI/JMC - LAB Application Acknowledgment builder;04/06/16  13:00
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74,88**;Sep 27, 1994;Build 10
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
 ; Called by routine LA7VIN1,LRVRARU
 ;
 ; Call with LA7 array passed by reference
 ;      LA7(62.4)=ien of related isntrument entry in file #62.4
 ;      LA7(62.48)=ien of related configuration in file #62.48
 ;      LA7(62.49)=ien of message in file #62.49 being acknowledged
 ;      LA7("ACK")=acknowledgment status (AA, AE, AR)
 ;      LA7("ID",n)= array of related message ids to stre in file #62.49
 ;      LA7("MSG")=text of error message to be returned
 ;      LA7("ERR")=if present array to build ERR segment
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
 ;ZEXCEPT: HL,LA7,LA76248
 ;
 N GBL,HLL,HLP,I,X
 N LA76249,LA7AERR,LA7DATA,LA7ECH,LA7ERR,LA7FS,LA7ID,LA7LL,LA7MID,LA7MSA,LA7MSH,LA7X,LA7Y
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
 ; Save message ids in file #62.49
 I $G(LA7(62.4)) S LA7ID=$P(^LAB(62.4,LA7(62.4),0),"^")
 E  S LA7ID=$P(LA76248(0),"^",1)
 S LA7ID=LA7ID_"-O-ACK-"
 D SETID^LA7VHLU1(LA76249,LA7ID,LA7MSA(2),1)
 D SETID^LA7VHLU1(LA76249,"",LA7MSA(2),0)
 S I=0
 F  S I=$O(LA7("ID",I)) Q:I<1  D
 . D SETID^LA7VHLU1(LA76249,"",LA7("ID",I),0)
 . D SETID^LA7VHLU1(LA76249,LA7ID,LA7("ID",I),0)
 ;
 ; Save message ids in file #62.49
 D BUILDSEG^LA7VHLU(.LA7MSA,.LA7DATA,LA7FS)
 D FILESEG^LA7VHLU(GBL,.LA7DATA)
 D FILE6249^LA7VHLU(LA76249,.LA7DATA)
 ;
 ; Build and file ERR segment if info present
 I $D(LA7("ERR")) D
 . N LABEL,X
 . K LA7DATA
 . S LA7ERR(0)="ERR"
 . I $G(LA7("ERR",3))'="" D
 . . S LABEL="HLC"_LA7("ERR",3),X=$T(@LABEL)
 . . S $P(LA7ERR(3),$E(LA7ECH),1)=LA7("ERR",3)
 . . S $P(LA7ERR(3),$E(LA7ECH),2)=$$CHKDATA^LA7VHLU3($P(X,";;",3),LA7FS_LA7ECH)
 . . S $P(LA7ERR(3),$E(LA7ECH),3)="HL70357"
 . I $G(LA7("ERR",4))'="" S LA7ERR(4)=LA7("ERR",4)
 . I $G(LA7("ERR",5))'="" D
 . . S $P(LA7ERR(5),$E(LA7ECH),1)=$P(LA7("ERR",5),"^")
 . . S $P(LA7ERR(5),$E(LA7ECH),2)=$$CHKDATA^LA7VHLU3($P(LA7("ERR",5),"^",2),LA7FS_LA7ECH)
 . . S $P(LA7ERR(5),$E(LA7ECH),3)="99VA62.485"
 . I $G(LA7("ERR",8))'="" S LA7ERR(8)=$$CHKDATA^LA7VHLU3(LA7("ERR",8),LA7FS_LA7ECH)
 . I $G(LA7("ERR",9))'="" S LA7ERR(9)=LA7("ERR",9)
 . D BUILDSEG^LA7VHLU(.LA7ERR,.LA7DATA,LA7FS)
 . D FILESEG^LA7VHLU(GBL,.LA7DATA)
 . D FILE6249^LA7VHLU(LA76249,.LA7DATA)
 ;
 ; Send the HL7 message.
 S HLL("SET FOR APP ACK")=1
 ;
 ; If LEDI interface obtain logical link from related protocol.
 ; If non-LEDI uses dynammic addressing then determine logical link based on #62.48 entry name.
 I +$P(^LAHM(62.48,LA76248,0),"^",9)=10 S LA7LL=$$GET1^DIQ(101,HL("EIDS")_",",770.7,"I")
 E   S LA7LL=$P(LA76248(0),"^")
 ;
 S HLL("LINKS",1)=HL("EIDS")_"^"_LA7LL
 S HLP("NAMESPACE")="LA"
 S HLP("SUBSCRIBER")="^"_HL("RAN")_"^"_HL("RAF")
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"GM",1,.LA7MID,"",.HLP)
 ;
 S HL("MTN")=HL("RMTN"),HL("SAN")=HL("RAN"),HL("SAF")=HL("RAF"),HL("APAT")=""
 D UPDT6249^LA7VORM1
 ;
 L -^LAHM(62.49,LA76249)
 ;
 Q
 ;
 ;
BLDERR(LA,LA7ERR) ; Build error info array for ERR segment
 ; Call with LA = LA array (by reference)
 ;       LA7ERR = variable containing error code^text based on file #62.485 entries.
 ;
 ; Returns LA("ERR") in LA array
 ;
 N LA7X
 S LA7X=+LA7ERR
 ;
 ; Initialize ERR-3 to 0 or 207 (catchall) - see HL7 Table 0357
 S LA("ERR",3)=$S(LA7X>0:207,1:0)
 ;
 I LA7X=121 S LA("ERR",3)=102
 I LA7X=11!(LA7X=26)!(LA7X=27) S LA("ERR",3)=103
 I LA7X>=106,LA7X<120 S LA("ERR",3)=103
 I LA7X=12 S LA("ERR",3)=204
 ;
 ; Set ERR-4 Severity
 I LA("ERR",3)=0 S LA("ERR",4)="I"
 E  S LA("ERR",4)="E"
 ;
 I LA7X>0 D
 . S LA("ERR",5)=LA7ERR
 . S LA("ERR",8)=$P(LA7ERR,"^",2)
 . S LA("ERR",9)="USR"
 ;
 Q
 ;
 ;
 ; HL70357 Table Message error condition codes - format ;;Value;;Description;;Comment
HLC0 ;;0;;Message accepted;;Success. Optional, as the AA conveys success. Used for systems that must always return a status code.
HLC100 ;;100;;Segment sequence error;;Error: The message segments were not in the proper order, or required segments are missing.
HLC101 ;;101;;Required field missing;;Error: A required field is missing from a segment
HLC102 ;;102;;Data type error;;Error: The field contained data of the wrong data type, e.g., an NM field contained ?FOO?.
HLC103 ;;103;;Table value not found;;Error: A field of data type ID or IS was compared against the corresponding table, and no match was found.
HLC104 ;;104;;Value too long;;Error: a value exceeded the normative length, or the length that the application is able to safely handle.
HLC200 ;;200;;Unsupported message type;;Rejection: The Message Type is not supported.
HLC201 ;;201;;Unsupported event code;;Rejection: The Event Code is not supported.
HLC202 ;;202;;Unsupported processing id;;Rejection: The Processing ID is not supported.
HLC203 ;;203;;Unsupported version id;;Rejection: The Version ID is not supported.
HLC204 ;;204;;Unknown key identifier;;Rejection: The ID of the patient, order, etc., was not found. Used for transactions other than additions, e.g., transfer of a non-existent patient.
HLC205 ;;205;;Duplicate key identifier;;Rejection: The ID of the patient, order, etc., already exists. Used in response to addition transactions (Admit, New Order, etc.).
HLC206 ;;206;;Application record locked;;Rejection: The transaction could not be performed at the application storage level, e.g., database locked.
HLC207 ;;207;;Application internal error;;Rejection: A catchall for internal errors not explicitly covered by other codes
