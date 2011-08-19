LA7VHL ;DALOI/DLR - Main Driver for incoming HL7 V1.6 messages ; Jan 12, 2005
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,46,62,64,67**;Sep 27, 1994
 ; This routine is not meant to be invoked by name
 ;
 QUIT
 ;
 ; This routine is called by the HL7 package V1.6 to process
 ; incoming HL7 messages.  Expected variables are those
 ; documented in the HL7 package documentation.  The line
 ; tag is called if it is entered into the PROCESSING ROUTINE
 ; field for the server protocol.
 ;
ORR ; Process incoming ORR messages
ACK ; Process incoming ACK messages
ORM ; Process incoming ORM messages
ORU ; Process incoming ORU messages
 ;
 N HLA,HLL,HLP,X,Y
 N LA76248,LA76249,LA7AAT,LA7AERR,LA7CS,LA7DT,LA7ECH,LA7FS,LA7HLS,LA7HLSA,LA7INTYP,LA7MEDT,LA7MTYP,LA7RAP,LA7PRID,LA7RSITE,LA7SAP,LA7SEQ,LA7SSITE,LA7TYPE,LA7VER,LA7VI,LA7VJ,LA7X
 ;
 S DT=$$DT^XLFDT
 S (LA76248,LA76249,LA7INTYP,LA7SEQ)=0
 ;
 K ^TMP("HLA",$J)
 ;
 ; Setup DUZ array to 'non-human' user LRLAB,HL
 ; If user not found - send alert to G.LAB MESSAGING
 S LA7X=$$FIND1^DIC(200,"","OX","LRLAB,HL","B","")
 I LA7X<1 D  Q
 . N MSG
 . S MSG="Lab Messaging - Unable to identify user 'LRLAB,HL' in NEW PERSON file"
 . D XQA^LA7UXQA(0,LA76248,0,0,MSG,"",0)
 D DUZ^XUP(LA7X)
 ;
 ; Set up LA7HLS with HL variables to build ACK message.
 ; Handle situation when systems use different encoding characters.
 D RSPINIT^HLFNC2(HL("EIDS"),.LA7HLS)
 ;
 ; Move message from HL7 global to Lab global
 F LA7VI=1:1 X HLNEXT Q:HLQUIT'>0  D
 . K LA7SEG
 . I HLNODE="" Q
 . S LA7SEG(0)=HLNODE
 . S LA7VJ=0
 . F  S LA7VJ=$O(HLNODE(LA7VJ)) Q:'LA7VJ  S LA7SEG(LA7VJ)=HLNODE(LA7VJ)
 . I $E(LA7SEG(0),1,3)="MSH" D MSH
 . I LA7SEQ<1 D REJECT("no MSH segment found") Q
 . D FILE6249^LA7VHLU(LA76249,.LA7SEG)
 ;
 ; Update entry in 62.49
 ; Change status to (Q)ueued for processing from (B)uilding
 I LA76249>0,$P($G(^LAHM(62.49,LA76249,0)),"^",3)'="E" D
 . N FDA,LA7ERR
 . S FDA(1,62.49,LA76249_",",2)="Q"
 . D FILE^DIE("","FDA(1)","LA7ERR(1)")
 ;
 ; Release lock on file #62.49 entry (tells LA7VIN message is stored).
 I LA76249>0 L -^LAHM(62.49,LA76249)
 ;
 ; Run processing routine
 I '$D(^LAHM(62.48,LA76248,1)) D CREATE^LA7LOG(5)
 I $D(^LAHM(62.48,LA76248,1)) X ^(1)
 ;
 ; Don't (ACK)nowledge ACK or ORR messages
 I $G(LA7MTYP)="ACK"!($G(LA7MTYP)="ORR") Q
 ;
 ; No application acknowledgement
 I $G(LA7AAT(1))="NE" Q
 ;
 ; Other system only wants ACK on successful completion condition and we found an error.
 I $G(LA7AERR)'="",$G(LA7AAT(1))="SU" Q
 ;
 ; Other system only wants ACK on error/reject condition
 I $G(LA7AERR)="",$G(LA7AAT(1))="ER" Q
 ;
 ; If POC interface and no error then quit - send application ack after
 ; processing message.
 I $G(LA7AERR)="",LA7INTYP>19,LA7INTYP<30 S X=$$DONTPURG^HLUTIL() Q
 ;
 ; If POC interface and error then setup HLL array
 I LA7INTYP>19,LA7INTYP<30 D
 . S HLL("SET FOR APP ACK")=1
 . S HLL("LINKS",1)=HL("EIDS")_"^"_$P(LA76248(0),"^")
 ;
 ; HL7 returns this as ACK if no errors found
 I $G(LA7AERR)="" S HLA("HLA",1)="MSA"_LA7HLS("RFS")_"AA"_LA7HLS("RFS")_HL("MID")
 ;
 ; Send ACK message
 I $D(HLA("HLA")) D
 . S HLP("NAMESPACE")="LA"
 . D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.LA7HLSA,"",.HLP)
 ;
 I $D(^TMP("HLA",$J)) D
 . S HLP("NAMESPACE")="LA"
 . D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"GM",1,.LA7HLSA,"",.HLP)
 ;
 Q
 ;
 ;
MSH ;;MSH
 ;
 N LA7CFIG,LA7MID,LA7NOW,X
 ;
 S LA7SEQ=1
 S LA7FS=$E(LA7SEG(0),4)
 S LA7ECH=$E(LA7SEG(0),5,8)
 S LA7CS=$E(LA7ECH,1)
 ; Sending application
 S LA7SAP=$P($$P^LA7VHLU(.LA7SEG,3,LA7FS),LA7CS)
 ; Sending facility
 S LA7SSITE=$P($$P^LA7VHLU(.LA7SEG,4,LA7FS),LA7CS)
 ; Receiving application
 S LA7RAP=$P($$P^LA7VHLU(.LA7SEG,5,LA7FS),LA7CS)
 ; Receiving facility
 S LA7RSITE=$P($$P^LA7VHLU(.LA7SEG,6,LA7FS),LA7CS)
 ; Date/time of message
 S LA7MEDT=$$P^LA7VHLU(.LA7SEG,7,LA7FS)
 ; Message type/trigger event/message structure
 S X=$$P^LA7VHLU(.LA7SEG,9,LA7FS)
 S LA7MTYP=$P(X,LA7CS),LA7MTYP("EVN")=$P(X,LA7CS,2),LA7MTYP("MSGSTR")=$P(X,LA7CS,3)
 ; Message Control ID
 S LA7MID=$$P^LA7VHLU(.LA7SEG,10,LA7FS)
 ; Processing ID
 S LA7PRID=$$P^LA7VHLU(.LA7SEG,11,LA7FS)
 ; Version ID
 S LA7VER=$$P^LA7VHLU(.LA7SEG,12,LA7FS)
 ; Accept acknowledgement type
 S LA7AAT(0)=$$P^LA7VHLU(.LA7SEG,15,LA7FS)
 ; Application acknowledgement type
 S LA7AAT(1)=$$P^LA7VHLU(.LA7SEG,16,LA7FS)
 ;
 S LA7CFIG=LA7SAP_LA7SSITE_LA7RAP_LA7RSITE
 S X=LA7CFIG X ^%ZOSF("LPC")
 S LA76248=+$O(^LAHM(62.48,"C",$E(LA7CFIG,1,27)_Y,0))
 I 'LA76248 S LA76248=+$O(^LAHM(62.48,"B",LA7SAP,0))
 I 'LA76248,$E(LA7SAP,1,11)="LA7V REMOTE" S LA76248=+$O(^LAHM(62.48,"B","LA7V COLLECTION "_$P(LA7SAP," ",3),0))
 I 'LA76248 D  Q
 . D CREATE^LA7LOG(1)
 . D REJECT("no config in 62.48")
 ;
 ; Determine interface type
 S LA7INTYP=+$P(^LAHM(62.48,LA76248,0),"^",9)
 ;
 I '$P($G(^LAHM(62.48,LA76248,0)),"^",3) D
 . D CREATE^LA7LOG(3)
 . D REJECT("config is inactive")
 ;
 ; store incoming message in ^LAHM(62.49)
 S LA76249=$$INIT6249^LA7VHLU
 I LA76249<1 Q
 ;
 ; update entry in 62.49
 N FDA,LA7ERR
 I $G(LA76248) S FDA(1,62.49,LA76249_",",.5)=LA76248
 S FDA(1,62.49,LA76249_",",1)="I"
 S FDA(1,62.49,LA76249_",",3)=3
 S FDA(1,62.49,LA76249_",",102)=LA7SAP
 S FDA(1,62.49,LA76249_",",103)=LA7SSITE
 S FDA(1,62.49,LA76249_",",104)=LA7RAP
 S FDA(1,62.49,LA76249_",",105)=LA7RSITE
 S FDA(1,62.49,LA76249_",",106)=LA7MEDT
 S FDA(1,62.49,LA76249_",",108)=LA7MTYP
 S FDA(1,62.49,LA76249_",",109)=LA7MID
 S FDA(1,62.49,LA76249_",",110)=LA7PRID
 S FDA(1,62.49,LA76249_",",111)=LA7VER
 S FDA(1,62.49,LA76249_",",700)=HL("EID")_";"_HLMTIENS_";"_HL("EIDS")
 D FILE^DIE("","FDA(1)","LA7ERR(1)")
 ;
 Q
 ;
 ;
REJECT(LA7AR) ; Build a reject segment if the incoming message could not be processed.
 ; Setting HLA("HLA",1) conforms to HL7 package rules for acknowledgements
 ; LA7AR is a free text string that is included in the reject
 ; message for debugging purposes.
 ;
 S HLA("HLA",1)="MSA"_LA7HLS("RFS")_"AR"_LA7HLS("RFS")_HL("MID")_LA7HLS("RFS")_LA7AR
 S LA7AERR=LA7AR
 Q
