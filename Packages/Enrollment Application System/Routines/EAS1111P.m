EAS1111P ;ALB/PJH,BDB - Post-Install ;03/07/2013 5:00pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**111**;07-MAR-13;Build 59
 ;
 ;Install EAS ESR protocols for Z06
 ; protocols are installed enabled and use LLESROUT
 ;
 ;Follow up patch will add disable text to
 ; EAS EDB servers and clients
 ;
EN ;Post Install entry point
 N AN,SLLN,STATION
 ; Get site's Station #
 S STATION=$P($$SITE^VASITE,"^",3),SLLN="LLESROUT"
 S AN("S")="ESR",AN("R")="VAMC "_STATION
 D PROTOCOL(STATION,SLLN,.AN)
 Q
 ;
PROTOCOL(STATION,SLLN,AN) ;
 ;INPUT STATION = Station #
 ; SLLN = Sending Logical Link Name
 ; AN = Array containing the Application Names
 ;
 ;OUTPUT None
 ;
 ;PURPOSE Using the table in line label PROTDAT create the
 ; protocols (Subscriber and Event Driver) for the
 ; ESR TCP/IP interfaces
 ;
 N RESULT,SIEN,V,N,N1,LNCNT,LINE,PROTRET,NAM,STOP
 ;
 ;ON COMPLETION INCLUDE STATION IN PROTOCOL NAME
 S N1="EAS ESR "_STATION_" ",V="2.3.1"
 ;
 S LNCNT=1,STOP=0
 F  S LINE=$T(PROTDAT+LNCNT) Q:$P(LINE,";",3)="END"  D  Q:STOP
 . N D,DTXT,RESULT
 . S DTXT=""
 . F N=3:1 Q:$P(LINE,";",N)="LEND"  S D(N)=$$V($P(LINE,";",N))
 . S NAM=D(3)_D(4)_D(5)
 . D:NAM["CLIENT"
 . . S SIEN=$$SP(NAM,D(6),D(7),D(8),D(9),D(10),D(11))
 . . I +SIEN<0 D ERROR(SIEN,"Subscriber:"_NAM)
 . D:NAM["SERVER"
 . . N TMPNAM,ITEMTXT
 . . S TMPNAM=D(6)_D(7)_$P(NAM,"SERVER ",2)
 . . S ITEMTXT=$$GETIT(TMPNAM)
 . . S RESULT=$$EDP(NAM,D(6),D(7),D(8),D(9),D(10),D(11),D(12),ITEMTXT)
 . . I +RESULT<0 D ERROR(RESULT,"Event Driver:"_NAM)
 . S LNCNT=LNCNT+1
 ;
 D BMES^XPDUTL("ESR Z06 Protocols installed with enabled status")
 Q
 ;
ERROR(ERRMSG,SUBJ) ;Display error message and set STOP=1
 ;
 N ARR
 S STOP=1
 S ARR(1)="===================================================="
 S ARR(2)="= ERROR ="
 S ARR(3)="===================================================="
 S ARR(4)="When creating "_SUBJ
 S ARR(5)="===================================================="
 S ARR(6)="**ERROR MSG: "_$P(ERRMSG,"^",2)
 ;
 D BMES^XPDUTL(.ARR)
 ;
 Q
 ;
V(VALUE) ;FUNCTION: If variable then pass back value of it.
 ;
 I $E(VALUE)="@" Q @($E(VALUE,2,$L(VALUE)))
 Q VALUE
 ;
GETIT(N) ;FUNCTION: Given Message Type and Event Type return the
 ; Transmission Description.
 Q:N="ORUZ06" "MEANS TEST CONVERTED/REVERSED/Unsolicited ESR to VAMC"
 Q ""
 ;
PROTDAT ;;VAMC SIDE PROTOCOLS
 ;;@N1;;ORU-Z06 CLIENT;@SLLN;@AN("R");ACK;;D ORU^EASPREC3;@DTXT;LEND
 ;;@N1;;ORU-Z06 SERVER;ORU;Z06;@V;@AN("S");;@SIEN;@DTXT;LEND
 ;;END
 ;
SP(PNAME,LL,RECVAPP,RMSGTYP,REVTTYP,MSGPRTN,DTXT) ;
 ;INPUT PNAME = Protocol Name
 ; LL = Logical Link Name (ex. "LL VAMC 500")
 ; RECVAPP = Receiving Application Name (ex. "VAMC 500")
 ; RMSGTYP = Response Message Type (ex. "ACK")
 ; REVTTYP = Response Event Type. Usually empty, used more
 ; in response to a Query with an ORF message.
 ; MSGPRTN = Message Processing Routine - Routine to parse
 ; regular transmission of data - MUMPS format
 ; (ex. "D ^IVMBORU")
 ; DTXT = Disable Text
 ;
 ;OUTPUT IEN entry (#101) for Subscriber Protocol Success
 ; -1^Error Message
 ;
 ;PURPOSE Create a Subscriber Protocol
 ;
 N DATA,FILE,RETURN,ERROR,DA,DGENDA
 S FILE=101
 ; If already exists then skip
 ;
 S RETURN=+$O(^ORD(101,"B",PNAME,0)) I +$G(RETURN)>0 Q RETURN
 ;
 S DATA(.01)=PNAME ;PROTOCOL NAME
 S DATA(2)="" ;DISABLE TEXT 
 S DATA(4)="S"                                ;PROTOCOL TYPE
 S DATA(770.11)=$O(^HL(771.2,"B",RMSGTYP,0)) ;RESPONSE MSG TYPE
 S DATA(770.2)=$O(^HL(771,"B",RECVAPP,0)) ;RECEIVING APP
 S:REVTTYP]"" DATA(770.4)=$O(^HL(779.001,"B",REVTTYP,0)) ;EVENT TYPE
 S DATA(770.7)=$O(^HLCS(870,"B",LL,0)) ;LOGICAL LINK
 S DATA(771)=MSGPRTN ;MSG PROCESSING RTN
 S DATA(773.1)=1 ;SEND FACILITY REQUIRED
 S DATA(773.2)=1 ;RECV FACILITY REQUIRED
 S RETURN=$$ADD^DGENDBS(FILE,"",.DATA,.ERROR)
 S:ERROR'=""!(+RETURN=0) RETURN=-1_"^"_ERROR
 Q RETURN
 ;
EDP(PNAME,MTYP,ETYP,VER,SENDAPP,ACKPRTN,SUBIEN,DTXT,ITEMTXT) ;
 ;INPUT PNAME = Protocol Name
 ; MTYP = Message Type Name (ex. "ORU")
 ; ETYP = Event Type Name (ex. "Z06")
 ; VER = HL7 Version # (ex. 2.3.1)
 ; SENDAPP = Sending Application Name (ex. "VAMC 290")
 ; ACKPRTN = Acknowledgement Processing Routine -
 ; Routine to parse an ACK transmission - 
 ; MUMPs format (ex. "D ^IVMBACK")
 ; SUBIEN = IEN of Subscriber Protocol in ^ORD(101)
 ; DTXT = Disable Text
 ; ITEMTXT = Item Text
 ;
 ;OUTPUT IEN entry (#101) of Event Driver Protocol Success
 ; -1^Error Message Error
 ;
 ;PURPOSE Create an Event Driver Protocol and the Sub-File to
 ; contain pointers to the Subscriber Protocol file
 ;
 N DATA,FILE,DGENDA,RETURN,ERROR,DA
 S FILE=101
 ; If already exists then skip
 ; 
 S RETURN=+$O(^ORD(101,"B",PNAME,0)) I +$G(RETURN)>0 Q RETURN
 ;
 S DATA(.01)=PNAME ;PROTOCOL NAME
 S DATA(1)=ITEMTXT ;ITEM TEXT
 S DATA(2)="" ;DISABLE TEXT
 S DATA(4)="E"                                ;PROTOCOL TYPE
 S DATA(5)=+$G(DUZ) ;CREATOR
 S DATA(770.1)=$O(^HL(771,"B",SENDAPP,0)) ;SENDING APP
 S DATA(770.3)=$O(^HL(771.2,"B",MTYP,0)) ;MSG TYPE
 S DATA(770.4)=$O(^HL(779.001,"B",ETYP,0)) ;EVENT TYPE
 S DATA(770.8)=$O(^HL(779.003,"B","AL",0)) ;ACCEPT ACK CODE
 S DATA(770.9)=$O(^HL(779.003,"B","AL",0)) ;APPLICATION ACK TYPE
 S DATA(770.95)=$O(^HL(771.5,"B",VER,0)) ;VERSION ID
 S DATA(772)=ACKPRTN ;ACK PROCESSING RTN
 S RETURN=$$ADD^DGENDBS(FILE,"",.DATA,.ERROR)
 I ERROR'=""!(+RETURN=0) S RETURN=-1_"^"_ERROR G EDPEXIT
 S DGENDA(1)=RETURN
 ;
 ; ADD SUBSCRIBER SUB-FILE TO EVENT DRIVER PROTOCOL
 S FILE=101.0775
 K DATA
 S DATA(.01)=SUBIEN
 S RETURN=$$ADD^DGENDBS(FILE,.DGENDA,.DATA,.ERROR)
 S:ERROR'=""!(+RETURN=0) RETURN=-1_"^"_ERROR
 ;
EDPEXIT Q RETURN
 ;
