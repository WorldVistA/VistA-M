LA7VIN2 ;DALOI/JMC - Process Incoming UI Msgs, continued ; 01/14/99
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64**;Sep 27, 1994
 ;This routine is a continuation of LA7VIN1 and is only called from there.
 Q
 ;
MSH ; Process MSH segment
 N LA7X
 ;
 I $E(LA7SEG(0),1,3)'="MSH" D  Q
 . S (LA7ABORT,LA7ERR)=7
 . D CREATE^LA7LOG(LA7ERR)
 ;
 ; Encoding characters
 S LA7FS=$E(LA7SEG(0),4)
 S LA7CS=$E(LA7SEG(0),5)
 S LA7ECH=$E(LA7SEG(0),5,8)
 ; No field or component seperator
 I LA7FS=""!(LA7CS="") D
 . S (LA7ABORT,LA7ERR)=8
 . D CREATE^LA7LOG(LA7ERR)
 ;
 ; Sending application
 S LA7SAP=$$P^LA7VHLU(.LA7SEG,3,LA7FS)
 S LA7ID=LA7SAP_"-I-"
 ;
 ; Sending facility
 S LA7SFAC=$$P^LA7VHLU(.LA7SEG,4,LA7FS)
 ;
 ; Receiving application
 S LA7RAP=$$P^LA7VHLU(.LA7SEG,5,LA7FS)
 ;
 ; Receiving facility
 S LA7RFAC=$$P^LA7VHLU(.LA7SEG,6,LA7FS)
 ;
 ; Message date/time from first component
 S LA7MEDT=$$HL7TFM^XLFDT($P($$P^LA7VHLU(.LA7SEG,7,LA7FS),LA7CS),"L")
 ;
 ; Message type
 S LA7X=$$P^LA7VHLU(.LA7SEG,9,LA7FS)
 S LA7MTYP=$P(LA7X,LA7CS,1)
 ;
 ; Message Control ID
 S LA7MID=$$P^LA7VHLU(.LA7SEG,10,LA7FS)
 ;
 ; HL7 version
 S LA7X=$$P^LA7VHLU(.LA7SEG,12,LA7FS)
 S LA7HLV=$P(LA7X,LA7CS,1)
 Q
 ;
 ;
ORC ; Process ORC segment
 N LA7X,LA7Y
 ;
 ; Order control
 S LA7OTYPE=$$P^LA7VHLU(.LA7SEG,2,LA7FS)
 ;
 ; Place order number
 S LA7PON=$$P^LA7VHLU(.LA7SEG,3,LA7FS)
 ;
 ; Setup shipping manifest variable
 S LA7Y=0
 S LA7X=$P($$P^LA7VHLU(.LA7SEG,5,LA7FS),LA7CS)
 I LA7X'="" S LA7Y=$O(^LAHM(62.8,"B",LA7X,0))
 I LA7Y S LA7628=LA7Y
 S LA7SM=LA7Y_"^"_LA7X
 ;
 ; Setup shipping configuration variable
 I $P(LA7SM,"^") S LA7629=+$P($G(^LAHM(62.8,$P(LA7SM,"^"),0)),"^",2)
 E  S LA7629=0
 ;
 ; Set new order/shipping mainfest received alert/identifiers
 I LA7MTYP="ORM",$L($P(LA7SM,"^",2)) D
 . S ^TMP("LA7-ORM",$J,LA76248,LA76249,$P(LA7SM,"^",2))=""
 . D SETID^LA7VHLU1(LA76249,LA7ID,$P(LA7SM,"^",2))
 ;
 ; Order quantity/timing (duration, units, urgency)
 S LA7ODUR=$P($$P^LA7VHLU(.LA7SEG,8,LA7FS),LA7CS,3)
 S LA7ODURU=$P($$P^LA7VHLU(.LA7SEG,8,LA7FS),LA7CS,4)
 S LA7OUR=$P($$P^LA7VHLU(.LA7SEG,8,LA7FS),LA7CS,6)
 ;
 ; Date/time of transaction
 S LA7ORDT=$$HL7TFM^XLFDT($P($$P^LA7VHLU(.LA7SEG,10,LA7FS),LA7CS),"L")
 ;
 ; Placer's entered by (id^duz^last name, first name, mi [id])
 S LA7X=$$P^LA7VHLU(.LA7SEG,11,LA7FS)
 S LA7PEB=$$XCNTFM^LA7VHLU4(LA7X,LA7ECH)
 I LA7PEB="^^" S LA7PEB=""
 ;
 ; Placer's verified by (id^duz^last name, first name, mi [id])
 S LA7X=$$P^LA7VHLU(.LA7SEG,12,LA7FS)
 S LA7PVB=$$XCNTFM^LA7VHLU4(LA7X,LA7ECH)
 I LA7PVB="^^" S LA7PVB=""
 ;
 ; Placer's ordering provider (id^duz^last name, first name, mi [id])
 S LA7X=$$P^LA7VHLU(.LA7SEG,13,LA7FS)
 S LA7POP=$$XCNTFM^LA7VHLU4(LA7X,LA7ECH)
 I LA7POP="^^" S LA7POP=""
 ;
 ; Enterer's ordering location
 S LA7X=$$P^LA7VHLU(.LA7SEG,14,LA7FS)
 S LA7Y=$$PLTFM^LA7VHLU4(LA7X,LA7ECH)
 S LA7EOL=$P(LA7Y,"^",1,3)
 I LA7EOL="^^" S LA7EOL=""
 ;
 ; Order control code reason
 S LA7OCR=$$P^LA7VHLU(.LA7SEG,17,LA7FS)
 ;
 ;
 ; If ORM order message, determine specimen collecting site from ORC
 ; segment, if none use MSH sending facility value
 S LA7CSITE=""
 I LA7MTYP="ORM" D
 . S LA7X=$P($$P^LA7VHLU(.LA7SEG,18,LA7FS),LA7CS)
 . S LA7CSITE=$$FINDSITE^LA7VHLU2(LA7X,2,1)
 . I LA7CSITE'>0 S LA7CSITE=$$FINDSITE^LA7VHLU2(LA7SFAC,2,0)
 ;
 Q
 ;
 ;
NTE ; Process NTE segment
 ; NTE segments contain comments from instruments or other facilities.
 ; NTE segments following OBR's contain comments which refer to the entire test battery.
 ; NTE segments following OBX's contain comments which are test specific.
 ;
 ; For comments in ORU messages:
 ;  Test specific comments can be prefaced with a site defined prefix -
 ;  see field REMARK PREFIX (#19) in CHEM TEST multiple of AUTOMATED INSTRUMENT (#62.4 file.
 ;  There can be more than one NTE, each will be stored as a comment in ^LAH.
 ;
 N LA7,LA7I,LA7NTE,LA7SOC
 ;
 S LA7SOC=$$P^LA7VHLU(.LA7SEG,3,LA7FS)
 S LA7NTE=$$P^LA7VHLU(.LA7SEG,4,LA7FS)
 ;
 ; Trim trailing spaces.
 I LA7NTE'="" S LA7NTE=$$TRIM^XLFSTR(LA7NTE,"R"," ")
 I LA7NTE="" S LA7NTE=" "
 ;
 I LA7MTYP="ORM" D OCOM Q
 ;
 ; Check for repeating comments in NTE segment and process
 ; If "^" in remark then translate to "~" to store.
 F LA7I=1:1:$L(LA7NTE,$E(LA7ECH,2)) D
 . S LA7RMK=$P(LA7NTE,$E(LA7ECH,2),LA7I)
 . I LA7RMK="" Q
 . S LA7RMK=$$UNESC^LA7VHLU3(LA7RMK,LA7FS_LA7ECH)
 . I LA7RMK["^" S LA7RMK=$TR(LA7RMK,"^","~")
 . I LA7MTYP="ORU" D RCOM Q
 . I LA7MTYP="ORR",$G(LA7OTYPE)="UA" D RCOM Q
 ;
 Q
 ;
 ;
PID ; Process PID segment
 N LA7X,LA7Y,X,Y
 ;
 S (DFN,LA7DOB,LA7ICN,LA7PRACE,LA7PNM,LA7PTID2,LA7PTID3,LA7PTID4,LA7SEX,LA7SSN,LRDFN,LRTDFN)=""
 ;
 ; PID Set ID
 S LA7SPID=$$P^LA7VHLU(.LA7SEG,2,LA7FS)
 ;
 ; Extract patient identifiers
 S LA7PTID2=$$P^LA7VHLU(.LA7SEG,3,LA7FS)
 S LA7PTID3=$$P^LA7VHLU(.LA7SEG,4,LA7FS)
 S LA7PTID4=$$P^LA7VHLU(.LA7SEG,5,LA7FS)
 ; Resolve ICN if identifier is from MPI
 ; Assume SSN is identifier is "SS" or blank
 F I=1:1:$L(LA7PTID3,$E(LA7ECH,2)) D
 . N J,LA7X,LA7ID
 . S X=$P(LA7PTID3,$E(LA7ECH,2),I) Q:'$L(X)
 . S LA7PTID3(I)=X,LA7ID=$P(LA7PTID3(I),$E(LA7ECH),5)
 . I LA7ID'="","NI^PI"[LA7ID D  Q
 . . S Y=$P(LA7PTID3(I),$E(LA7ECH))
 . . I Y?10N1"V"6N S LA7Y=Y
 . . E  S LA7Y=Y_"V"_$P(LA7PTID3(I),$E(LA7ECH),2)
 . . S LA7X=$$CHKICN^LA7VHLU2(LA7Y)
 . . I LA7X>0 S DFN=$P(LA7X,"^"),LA7ICN=$P(LA7X,"^",2)
 . I LA7ID="SS"!(LA7ID="") D  Q
 . . F J=1:1:3 S LA7X(J)=$P(LA7PTID3(I),$E(LA7ECH),J)
 . . I LA7X(1)'?9N.1A Q
 . . I LA7X(3)="M11",LA7X(2)'=$P($$M11^HLFNC(LA7X(1),LA7ECH),$E(LA7ECH),2) Q
 . . S LA7SSN=LA7X(1),DFN=$O(^DPT("SSN",LA7SSN,0))
 ;
 ; Check PID-2 (alternate patient id) if PID-3 did not yield SSN/ICN
 F I=1:1:$L(LA7PTID2,$E(LA7ECH,2)) D
 . N J,LA7X,LA7ID
 . S X=$P(LA7PTID2,$E(LA7ECH,2),I) Q:'$L(X)
 . S LA7PTID2(I)=X,LA7ID=$P(LA7PTID2(I),$E(LA7ECH),5)
 . I LA7ICN="",LA7ID'="","NI^PI"[LA7ID D  Q
 . . S Y=$P(LA7PTID2(I),$E(LA7ECH))
 . . I Y?10N1"V"6N S LA7Y=Y
 . . E  S LA7Y=Y_"V"_$P(LA7PTID2(I),$E(LA7ECH),2)
 . . S LA7X=$$CHKICN^LA7VHLU2(LA7Y)
 . . I LA7X>0 S DFN=$P(LA7X,"^"),LA7ICN=$P(LA7X,"^",2)
 . I LA7SSN="",LA7ID="SS"!(LA7ID="") D  Q
 . . F J=1:1:3 S LA7X(J)=$P(LA7PTID2(I),$E(LA7ECH),J)
 . . I LA7X(1)'?9N.1A Q
 . . I LA7X(3)="M11",LA7X(2)'=$P($$M11^HLFNC(LA7X(1),LA7ECH),$E(LA7ECH),2) Q
 . . S LA7SSN=LA7X(1),DFN=$O(^DPT("SSN",LA7SSN,0))
 ;
 ; Extract patient name
 S LA7X=$$P^LA7VHLU(.LA7SEG,6,LA7FS)
 I LA7X'="" S LA7PNM=$$FMNAME^HLFNC(LA7X,LA7ECH)
 ;
 ; Extract date of birth
 ; Check for degree of precision in 2nd component to provide backward compatibility with HL7 <v2.3
 S LA7X=$$P^LA7VHLU(.LA7SEG,8,LA7FS)
 I LA7X D
 . S LA7Y=$P(LA7X,LA7CS,2),LA7X=$P(LA7X,LA7CS,1)
 . I (LA7Y=""!(LA7Y="D")),$E(LA7X,9,12)="0000" S LA7X=$E(LA7X,1,8)
 . S LA7DOB=$$HL7TFM^XLFDT(LA7X)
 . I LA7DOB<1 S LA7DOB=""
 . I LA7Y="L" S LA7DOB=$E(LA7DOB,1,5)_"00"
 . I LA7Y="Y" S LA7DOB=$E(LA7DOB,1,3)_"0000"
 ;
 ; Extract patient's sex
 S LA7SEX=$$P^LA7VHLU(.LA7SEG,9,LA7FS)
 ;
 ; Extract patient's race
 S LA7X=$$P^LA7VHLU(.LA7SEG,11,LA7FS)
 I $P(LA7X,LA7CS)'="" D
 . I $P(LA7X,LA7CS,3)="0005" S $P(LA7X,LA7CS,3)="HL70005"
 . S LA7PRACE=$P(LA7X,LA7CS)_":"_$P(LA7X,LA7CS,2)_$S($P(LA7X,LA7CS,3)'="":":"_$P(LA7X,LA7CS,3),1:"")
 ;
 ; Extract patient's SSN and determine DFN
 ; If SSN determined previously from PID-3 then compare SSN's
 ; If DFN determined previously from ICN then check DFN based on SSN.
 S LA7X=$P($$P^LA7VHLU(.LA7SEG,20,LA7FS),LA7CS)
 S LA7X=$TR(LA7X,"-","") ; remove "-" if any
 I LA7X?9N.1A D
 . I LA7SSN'="",LA7X'=LA7SSN Q
 . S LA7SSN=LA7X
 . I DFN,DFN'=$O(^DPT("SSN",LA7SSN,0)) Q
 . S DFN=$O(^DPT("SSN",LA7SSN,0))
 I DFN D
 . S LRDFN=$P($G(^DPT(DFN,"LR")),"^")
 . S LRTDFN=$P($G(^DPT(DFN,"LRT")),"^")
 ;
 Q
 ;
 ;
PV1 ; Process PV1 segment
 ;
 ; PV1 Set ID
 S LA7SPV1=$$P^LA7VHLU(.LA7SEG,2,LA7FS)
 ;
 ; Extract ordering location
 S LA7LOC=$P($$P^LA7VHLU(.LA7SEG,4,LA7FS),LA7CS)
 Q
 ;
 ;
RCOM ; Store result comments in ORU messages
 ;
 ; Don't store remark if same as specimen comment (without "~").
 I $G(LA7AA),$G(LA7AD),$G(LA7AN),LA7RMK=$TR($P($G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,3)),"^",6),"~") Q
 ; Or patient info (#.091 in file 63) - info previously downloaded
 I $G(LA7AA),$G(LA7AD),$G(LA7AN),LA7RMK=$G(^LR(+$G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,0)),.091)) Q
 ;
 ; If test specific, store comment prefix with comments (see LA7VIN5)
 I $O(LA7RMK(0,0)) D  Q
 . N LA7I
 . S LA7I=0
 . F  S LA7I=$O(LA7RMK(0,LA7I)) Q:'LA7I  D
 . . I '$P(LA7RMK(0,LA7I),"^") Q
 . . ; Don't store if status not "FINAL"
 . . I $P(LA7RMK(0,LA7I),"^")=2,"CFU"'[$G(LA7ORS) Q
 . . D RMKSET^LASET(LA7LWL,LA7ISQN,LA7RMK,$P(LA7RMK(0,LA7I),"^",2))
 ;
 ; Store comment in 1 node of ^LAH global
 I $P(LA7624(0),"^",17) D RMKSET^LASET(LA7LWL,LA7ISQN,LA7RMK,"")
 K LA7RMK
 Q
 ;
 ;
OCOM ; Store order comments from ORM messages in file #69.6
 ; Check for repeating comments in NTE segment and process
 ; If "^" in remark then translate to "~" to store.
 ;
 ; If source of comment (LA7SOC) is "RQ" then comment is from CHCS which
 ; uses a composite data type for NTE-3. VistA only extracts component #9
 ; which contains the external value of the comment.
 ;
 N LA7DIE,LA7RMK,LA7WP,X
 I $G(LA7696)<1 Q
 F LA7I=1:1:$L(LA7NTE,$E(LA7ECH,2)) D
 . S LA7RMK=$P(LA7NTE,$E(LA7ECH,2),LA7I)
 . I LA7SOC="RQ" D
 . . S X=$P(LA7RMK,$E(LA7ECH),9)
 . . I X'="" S LA7RMK=X
 . I LA7RMK="" Q
 . S LA7RMK=$$UNESC^LA7VHLU3(LA7RMK,LA7FS_LA7ECH)
 . I LA7RMK["^" S LA7RMK=$TR(LA7RMK,"^","~")
 . S LA7WP(LA7I,0)=LA7RMK
 D WP^DIE(69.6,LA7696_",",99,"A","LA7WP","LA7DIE(99)")
 Q
