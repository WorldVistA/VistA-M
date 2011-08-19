IVM2069Q ;ALB/EJG - Patch Post-Install functions IVM*2*69;11/27/2002; 9/20/01 4:16pm
 ;;2.0;INCOME VERIFICATION;**69**;21-OCT-94
 ;
 Q          ;Entry Points Only
 ;
 ;Functions are called by IVM2069P
 ;
LL16(LLNAME,LLPTYP,DEVTYP,QSIZE,TCPADDR,TCPPORT,TCPSTYP,PERSIST,STNODE) ;
 ;INPUT   LLNAME  = Logical Link Name (ex. "LL HEC 500")
 ;        LLPTYP  = LLP Type (ex. "TCP")
 ;        DEVTYP  = Device Type - Systems Monitor - display ONLY
 ;        QSIZE   = Queue Size
 ;        TCPADDR = TCP/IP Address
 ;        TCPPORT = TCP/IP Port #
 ;        TCPSTYP = TCP/IP Service Type
 ;                  C - Client (Sender)
 ;                  S - Single Listener
 ;                  M - Multi Listener
 ;        PERSIST = Is connection persistent Y or N
 ;        STNODE  = Startup Node - TaskMan Node to start on
 ;
 ;OUTPUT  IEN of entry (#870)  Success
 ;        -1^Error Message     Error
 ;
 ;PURPOSE Create a Logical Link for TCP/IP transmissions.
 ;
 N FILE,DATA,RETURN,DEFINED,ERROR,DA,DGENDA
 S FILE=870
 ; If already exists then skip
 ;  
 Q:+$O(^HLCS(870,"B",LLNAME,0))>0 ""
 ;
 ; set v1.6 field values
 S DATA(.01)=LLNAME                        ;LOGICAL LINK NAME
 S DATA(2)=$O(^HLCS(869.1,"B",LLPTYP,0))   ;LLP TYPE
 S DATA(3)=DEVTYP                          ;QUEUE TYPE
 S DATA(4.5)=1                             ;AUTOSTART
 S DATA(21)=QSIZE                          ;QUEUE SIZE
 D:TCPSTYP="C"                             ;IF CLIENT(SENDER)
 . S DATA(200.02)=3                        ;RE-TRANSMISSION ATTEMPTS
 . S DATA(200.021)="R"                     ;EXCEED RE-TRANSMISSION
 . S DATA(200.04)=90                       ;READ TIMEOUT
 . S DATA(200.05)=270                      ;ACK TIMEOUT
 S DATA(400.01)=TCPADDR                    ;TCP/IP ADDRESS
 S DATA(400.02)=TCPPORT                    ;TCP/IP PORT
 S DATA(400.03)=TCPSTYP                    ;TCP/IP SERVICE TYPE
 S DATA(400.04)=PERSIST                    ;PERSISTENT
 S DATA(400.06)=STNODE                     ;STARTUP NODE
 ;
 S RETURN=$$ADD^DGENDBS(FILE,"",.DATA,.ERROR)
 S:ERROR'=""!(+RETURN=0) RETURN=-1_"^"_ERROR
 ;
 Q RETURN
 ;
APP(ANAME,STATUS,STATION,COUNTRY) ;
 ;INPUT   ANAME   = Application Name (ex. "HEC 500")
 ;        STATUS  = "a"CTIVE or "i"INACTIVE
 ;        STATION = STATION # (ex. 500)
 ;        COUNTRY = COUNTRY NAME (ex. "USA")
 ;
 ;OUTPUT  IEN of entry (#771)   Success
 ;        -1^Error Message      Error
 ;
 ;PURPOSE Create an Application
 ;
 N DATA,FILE,RETURN,ERROR,DA
 S FILE=771
 ; If already exists then skip
 ;  
 Q:+$O(^HL(771,"B",ANAME,0))>0 ""
 S DATA(.01)=ANAME
 S DATA(2)=STATUS
 S DATA(3)=STATION
 S DATA(7)=$O(^HL(779.004,"B",COUNTRY,0))
 S RETURN=$$ADD^DGENDBS(FILE,"",.DATA,.ERROR)
 S:ERROR'=""!(+RETURN=0) RETURN=-1_"^"_ERROR
 Q RETURN
 ;
SP(PNAME,LL,RECVAPP,RMSGTYP,REVTTYP,MSGPRTN) ;
 ;INPUT   PNAME   = Protocol Name
 ;        LL      = Logical Link Name (ex. "LL VAMC 500")
 ;        RECVAPP = Receiving Application Name (ex. "VAMC 500")
 ;        RMSGTYP = Response Message Type  (ex. "ACK")
 ;        REVTTYP = Response Event Type. Usually empty, used more
 ;                  in response to a Query with an ORF message.
 ;        MSGPRTN = Message Processing Routine - Routine to parse
 ;                  regular transmission of data - MUMPS format
 ;                  (ex. "D ^IVMBORU")
 ;
 ;OUTPUT  IEN entry (#101) for Subscriber Protocol   Success
 ;        -1^Error Message
 ;
 ;PURPOSE Create a Subscriber Protocol
 ;
 N DATA,FILE,RETURN,ERROR,DA,DGENDA
 S FILE=101
 ; If already exists then skip
 ;  
 Q:+$O(^ORD(101,"B",PNAME,0))>0 ""
 S DATA(.01)=PNAME                            ;PROTOCOL NAME
 S DATA(4)="S"                                ;PROTOCOL TYPE
 S DATA(770.11)=$O(^HL(771.2,"B",RMSGTYP,0))  ;RESPONSE MSG TYPE
 S DATA(770.2)=$O(^HL(771,"B",RECVAPP,0))     ;RECEIVING APP
 S:REVTTYP]"" DATA(770.4)=$O(^HL(779.001,"B",REVTTYP,0))  ;EVENT TYPE
 S DATA(770.7)=$O(^HLCS(870,"B",LL,0))        ;LOGICAL LINK
 S DATA(771)=MSGPRTN                          ;MSG PROCESSING RTN
 S DATA(773.1)=1                              ;SEND FACILITY REQUIRED
 S DATA(773.2)=1                              ;RECV FACILITY REQUIRED
 S RETURN=$$ADD^DGENDBS(FILE,"",.DATA,.ERROR)
 S:ERROR'=""!(+RETURN=0) RETURN=-1_"^"_ERROR
 Q RETURN
 ;
EDP(PNAME,MTYP,ETYP,VER,SENDAPP,ACKPRTN,SUBIEN,DTXT,ITEMTXT) ;
 ;INPUT   PNAME   = Protocol Name
 ;        MTYP    = Message Type Name (ex. "ORU")
 ;        ETYP    = Event Type Name (ex. "Z09")
 ;        VER     = HL7 Version # (ex. 2.3.1)
 ;        SENDAPP = Sending Application Name (ex. "VAMC 290")
 ;        ACKPRTN = Acknowledgement Processing Routine -
 ;                  Routine to parse an ACK transmission - 
 ;                  MUMPs format (ex. "D ^IVMBACK")
 ;        SUBIEN  = IEN of Subscriber Protocol in ^ORD(101)
 ;        DTXT    = Disable Text
 ;        ITEMTXT = Item Text
 ;
 ;OUTPUT  IEN entry (#101) of Event Driver Protocol   Success
 ;        -1^Error Message                            Error
 ;
 ;PURPOSE Create an Event Driver Protocol and the Sub-File to
 ;        contain pointers to the Subscriber Protocol file
 ;
 N DATA,FILE,DGENDA,RETURN,ERROR,DA
 S FILE=101
 ; If already exists then skip
 ;  
 Q:+$O(^ORD(101,"B",PNAME,0))>0 ""
 S DATA(.01)=PNAME                            ;PROTOCOL NAME
 S DATA(1)=ITEMTXT                            ;ITEM TEXT
 S DATA(2)=DTXT                               ;DISABLE TEXT
 S DATA(4)="E"                                ;PROTOCOL TYPE
 S DATA(5)=+$G(DUZ)                           ;CREATOR
 S DATA(770.1)=$O(^HL(771,"B",SENDAPP,0))     ;SENDING APP
 S DATA(770.3)=$O(^HL(771.2,"B",MTYP,0))      ;MSG TYPE
 S DATA(770.4)=$O(^HL(779.001,"B",ETYP,0))    ;EVENT TYPE
 S DATA(770.8)=$O(^HL(779.003,"B","AL",0))    ;ACCEPT ACK CODE
 S DATA(770.9)=$O(^HL(779.003,"B","AL",0))    ;APPLICATION ACK TYPE
 S DATA(770.95)=$O(^HL(771.5,"B",VER,0))      ;VERSION ID
 S DATA(772)=ACKPRTN                          ;ACK PROCESSING RTN
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
