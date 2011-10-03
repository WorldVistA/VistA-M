IVM2078P ;ALB/EJG - Patch Post-Install functions IVM*2*78;04/07/2003
 ;;2.0;INCOME VERIFICATION;**78**;21-OCT-94
 ;
EN ;ENTRY POINT
 ;
 N ADDR,PORT,STATION,TCPDATA,AN,RLLN,SLLN,STOP,VER,DA,FILE,RET,ERROR
 ;
 ; Get site's Station #
 S STATION=$P($$SITE^VASITE,"^",3)
 ;
 S STOP=0
 D CLEANUP                        ;Cleanup message placed with wrong LL
 Q:$$SETLL16(STATION,.RLLN,.SLLN)
 D PROTOCOL(STATION,RLLN,SLLN,.AN)
 Q
 ;
SETLL16(STATION,RLLN,SLLN) ;
 ;INPUT   STATION = Station #
 ;        RLLN    = Receiving Logical Link Name
 ;        SLLN    = Sending Logical Link Name
 ;
 ;OUTPUT   0 : Success, 1 : Error
 ;
 ;PURPOSE  Create the Receiving and Sending Logical Link.
 ;
 N ADDR,PORT,RECVLL,SENDLL,RET,VISN,M,IENS
 ;
 ; Sending Logical Link
 S SLLN="LLEDBOUT"
 S PORT=33001            ;e*Gate Port#
 S ADDR="10.224.132.101"  ;e*Gate production
 S RET=$$LL16(SLLN,ADDR,PORT,1)
 I +RET<0 D ERROR(RET,"Edb Send Link:"_SLLN) Q 1
 ;
RLL ; Receiving Logical Link
 S RLLN="LLEDBIN"
 S ADDR=""
 S PORT=""    ;all stations production
 S RET=$$LL16(RLLN,ADDR,PORT,0)
 I +RET<0 D ERROR(RET,"Edb Receive Link:"_RLLN) Q 1
LL16EXIT Q STOP
 ;
 ;
PROTOCOL(STATION,RLLN,SLLN,AN) ;
 ;INPUT    STATION = Station #
 ;         RLLN    = Receiving Logical Link Name
 ;         SLLN    = Sending Logical Link Name
 ;         AN      = Array containing the Application Names
 ;
 ;OUTPUT   None
 ;
 ;PURPOSE  Update the protocols (Subscriber and Event Driver) for the
 ;         Edb/e*Gate TCP/IP interfaces
 ;
 N RESULT,SIEN,DUZ,V,N,N1,LNCNT,LINE,PROTRET,NAM,DISABTXT
 S DISABTXT=""
 F NAM="EAS EDB ORU-Z06 SERVER","EAS EDB ORU-Z09 SERVER" D
 . S RESULT=$$EDP(NAM,DISABTXT)
 . I +RESULT<0 D ERROR(RESULT,"Event Driver:"_NAM)
 Q
 ;
ERROR(ERRMSG,SUBJ) ;
 ;INPUT    ERRMSG = Error Message text
 ;         SUBJ   = Subject of the Message
 ;
 ;OUTPUT   none
 ;
 ;PURPOSE  Display an error message to the user.  Set the
 ;         variable STOP=1 which will stop the routine
 ;         from continuing to run after an error is found.
 ;
 N TXT
 S STOP=1
 S TXT=$P(ERRMSG,"^",2)
 W !,"===================================================="
 W !,"=                   ERROR                          ="
 W !,"===================================================="
 W !,"When creating "_SUBJ
 W !,"===================================================="
 W !,"**ERROR MSG: ",TXT
 Q
 ;
 ;Update Functions
 ;
LL16(LLNAME,TCPADDR,TCPPORT,AUTO) ;
 ;INPUT   LLNAME  = Logical Link Name (ex. "LLEDBOUT")
 ;        TCPADDR = TCP/IP Address
 ;        TCPPORT = TCP/IP Port #
 ;        AUTO    = AUTOSTART
 ;                  0 - DISABLED
 ;                  1 - ENABLED
 ;
 ;OUTPUT  IEN of entry (#870)  Success
 ;        -1^Error Message     Error
 ;
 ;PURPOSE Update a Logical Link for TCP/IP transmissions.
 ;
 N FILE,DATA,RETURN,DEFINED,ERROR,DA,DGENDA
 S FILE=870
 ; If already exists then skip
 ;  
 S IEN870=$O(^HLCS(870,"B",LLNAME,0))      ;IEN TO UPDATE
 I 'IEN870 D  Q RETURN                     ;IEN NOT FOUND - RETURN ERROR
 . S ERROR="IEN OF RECORD TO BE UPDATED NOT SPECIFIED"
 . S RETURN=-1_"^"_ERROR
 ;
 ; set v1.6 field values
 S DATA(400.01)=TCPADDR                    ;TCP/IP ADDRESS
 S DATA(400.02)=TCPPORT                    ;TCP/IP PORT
 S DATA(4.5)=AUTO                          ;AUTOSTART
 ;
 S RETURN=$$UPD^DGENDBS(FILE,IEN870,.DATA,.ERROR)
 S:ERROR'=""!(+RETURN=0) RETURN=-1_"^"_ERROR
 ;
 Q RETURN
 ;
EDP(PNAME,DTXT) ;
 ;INPUT   PNAME   = Protocol Name
 ;        DTXT    = Disable Text
 ;
 ;OUTPUT  IEN entry (#101) of Event Driver Protocol   Success
 ;        -1^Error Message                            Error
 ;
 ;PURPOSE Activate the Event Driver Protocol
 ;
 N DATA,FILE,DGENDA,RETURN,ERROR,DA,IEN101
 S FILE=101
 ; If already exists then skip
 ;  
 S IEN101=$O(^ORD(101,"B",PNAME,0))
 I 'IEN101 D  Q RETURN                     ;IEN NOT FOUND - RETURN ERROR
 . S ERROR="IEN OF RECORD TO BE UPDATED NOT SPECIFIED"
 . S RETURN=-1_"^"_ERROR
 ;
 S DATA(2)=DTXT                               ;DISABLE TEXT
 S RETURN=$$UPD^DGENDBS(FILE,IEN101,.DATA,.ERROR)
 I ERROR'=""!(+RETURN=0) S RETURN=-1_"^"_ERROR G EDPEXIT
 ;
EDPEXIT Q RETURN
 ;
 ;Clean up those message that have been placed into the EDB outbound
 ; logical link - LLEDBOUT erroneously.  Delete them out of LLEDBOUT
 ; queue and place into general outbound queue.
 ;
CLEANUP N IEN870,VISN,M,IEN,QIEN,SLLN
 S IEN870=$O(^HLCS(870,"B","LLEDBOUT",0))
 I 'IEN870 Q
 I '$D(^HLMA("AC","O",IEN870)) Q              ;Nothing in queue
 W !,"Requeue Z09 messages"
 S IEN=0
 F  S IEN=$O(^HLMA("AC","O",IEN870,IEN)) Q:'IEN  D
 . W !?2,"Requeued Record# ",IEN
 . L +^HLMA(IEN):0 Q:'$T
 . D REQUEUE(IEN)
 . L -^HLMA(IEN)
 W !,"Requeue of records completed.",!
 Q
 ;
 ;Requeue the transaction into the IVM Billing Transmission (#301.61)
 ; file
 ;
REQUEUE(IEN773) N DFN,HLTCP,IEN30161,IEN772,PFLG,REC,SEG,SEQ,SID
 S IEN772=+$P($G(^HLMA(IEN773,0)),"^")
 S (PFLG,SEQ)=0
 F  S SEQ=$O(^HL(772,IEN772,"IN",SEQ)) Q:'SEQ  D
 .I $P(^HL(772,IEN772,"IN",SEQ,0),"^")="PID" D
 ..S REC=$G(^HL(772,IEN772,"IN",SEQ,0))
 ..S DFN=+$P($P(REC,"^",4),"~")
 ..S PFLG=1
 .I PFLG,$P(^HL(772,IEN772,"IN",SEQ,0),"^")="FT1" D
 ..S REC=$G(^HL(772,IEN772,"IN",SEQ,0))
 ..S SID=$P(REC,"^",8)
 ..S IEN30161=$O(^IVM(301.61,"B",SID,0))
 ..S ^IVM(301.61,"ATR",DFN,IEN30161)=""     ;Requeue for IVM Billing
 I 'PFLG Q                                  ;PID Segment not found
 S HLTCP=1
 D STATUS^HLTF0(IEN773,3,,,1)           ;Set 773 transaction to COMPLETE
 Q
