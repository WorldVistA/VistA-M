HLUTIL2 ;ALB/MFK/MTC/JC - VARIOUS HL7 UTILITIES ;12/30/2010
 ;;1.6;HEALTH LEVEL SEVEN;**19,43,57,59,120,153**;;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
ITEM(IEN,ROUTINE) ; Return data from ITEM multiple in protocol file
 ; INPUT : IEN - Internal Entry Number for 101 (Protocol) file.
 ;         ROUTINE - name of a routine to run (either PTR or TYPE)
 ;OUTPUT : HLARY - Array of IENs from ITEM multiple
 ;  HLARY is of the form:
 ; HLARY(0)=Total number of items found
 ; HLARY(IEN)=Results from function
 N ITEM,LINE,MSG,PTR
 S IEN=$G(IEN)
 Q:(IEN="")
 S ROUTINE=$G(ROUTINE)
 S ROUTINE=$S(ROUTINE="PTR":1,ROUTINE="TYPE":2,ROUTINE=1:1,ROUTINE=2:2,1:"")
 Q:(ROUTINE="")
 S ITEM="",MSG=0
 ;  Loop through IENs within Subscriber multiple
 F  S ITEM=$O(^ORD(101,IEN,775,ITEM)) Q:(ITEM="")  D
 .S PTR=$P($G(^ORD(101,IEN,775,ITEM,0)),"^",1)
 .;  Call type to get info on that item
 .S:(ROUTINE=1) LINE=$$PTR(PTR)
 .S:(ROUTINE=2) LINE=$$TYPE(PTR)
 .;  Make sure LINE isn't error code
 .I ((+LINE)>(-1)) S MSG=MSG+1 S HLARY(PTR)=LINE
 S HLARY(0)=MSG
 K ROUTINE
 Q
PTR(IEN) ;  Return pointer information if subscriber
 ; INPUT - IEN: IEN of protocol file
 ;OUTPUT - Line from ^ORD(101,IEN,770):
 ; CLIENT^LOGICAL_LINK (both pointers)
 N RETURN,LINE,TYPE
 S IEN=$G(IEN)
 Q:(IEN="") "-1"
 ;  Make sure this is a subscriber type
 S TYPE=$P($G(^ORD(101,IEN,0)),"^",4)
 Q:(TYPE'="S") "-2"
 S LINE=$G(^ORD(101,IEN,770))
 S RETURN=$P(LINE,"^",2)_"^"_$P(LINE,"^",7)
 Q RETURN
TYPE(IEN) ;  Return portions of protocol file
 ; INPUT - IEN: IEN of protocol file
 ;OUTPUT - Line containing the following information from the protocol
 ;         file (#101)
 ;
 ; Client ^ Message Type Received ^ Event Type ^ Message Structure ^
 ;  Processing ID ^ Logical Link Pointer ^ Accept Ack ^
 ;  Application Ack ^ Version ^ Message Type Generated
 ;
 N RETURN,CLP,MTPR,ETP,LINE,TYPE,CLIENT,EVENT,MTPEVP
 N ACCACK,APPACK,VERID,VERIDP,ACKP,ACKTYP,MTPG,MTNEVN
 ;-- check if ien was passed in
 S IEN=$G(IEN)
 Q:(IEN="") "-1"
 ;
 ;  Null any variables in case they don't exist
 S (CLIENT,TYPE,EVENT,ACCACK,APPACK,VERID,MTPG,MTNEVN)=""
 ;  Get line from protocol file
 S LINE=$G(^ORD(101,IEN,770))
 ;
 ;-- get client (application that will receive the message
 S CLP=$P(LINE,U,2)
 S:(CLP) CLIENT=$P($G(^HL(771,CLP,0)),U,1)
 ;
 ;-- get message type received & generated
 S MTPR=$P(LINE,U,3)
 S MTPG=$P(LINE,U,11)
 S:(MTPR) MTPR=$P($G(^HL(771.2,MTPR,0)),U,1)
 S:(MTPG) MTPG=$P($G(^HL(771.2,MTPG,0)),U,1)
 ;
 ;-- get event type
 S ETP=$P(LINE,U,4)
 S:(ETP) EVENT=$P($G(^HL(779.001,ETP,0)),U,1)
 ;
 ;-- get message structure code
 S MTPEVP=$P(LINE,U,5)
 S:(MTPEVP) MTNEVN=$P($G(^HL(779.005,MTPEVP,0)),U,1)
 ;
 ;-- accept acknowledgement
 S ACKP=$P(LINE,U,8)
 S:(ACKP) ACCACK=$P($G(^HL(779.003,ACKP,0)),U,1)
 ;
 ;-- application acknowledgement
 S ACKTYP=$P(LINE,U,9)
 S:(ACKTYP) APPACK=$P($G(^HL(779.003,ACKTYP,0)),U,1)
 ;
 ;-- version of HL7
 S VERIDP=$P(LINE,U,10)
 S:(VERIDP) VERID=$P($G(^HL(771.5,VERIDP,0)),U,1)
 ;
 ;-- build return string
 S RETURN=CLIENT_U_MTPR_U_EVENT
 ;-- 6 processing id, 7 logical link pointer
 S RETURN=RETURN_U_MTNEVN_U_$P(LINE,U,6)_U_$P(LINE,U,7)
 S RETURN=RETURN_U_ACCACK_U_APPACK_U_VERID_U_MTPG
 Q RETURN
 ;
MSGADM(IEN) ; RETURN DATE/TIME ENTERED AND MSGID FROM FILE 773
 N X
 Q:'$G(^HLMA(+$G(IEN),0)) "-1"  S X=^(0)
 Q $P($G(^HL(772,+X,0)),"^")_"^"_$P(X,"^",2)
 ;
APPPRM(IEN) ; RETURN DATA FROM THE APPLICATION PARAMETER FILE
 N LINE,COUNTRYP,COUNTRY
 S IEN=$G(IEN)
 Q:(IEN="")
 S LINE=$G(^HL(771,IEN,0))
 S COUNTRYP=$P(LINE,"^",7),COUNTRY=""
 ;
 ; patch HL*1.6*120 - for deleting "US" entry from #779.004
 ; I COUNTRYP]"" S COUNTRY=$P(^HL(779.004,COUNTRYP,0),"^",1)
 I COUNTRYP]"" S COUNTRY=$P($G(^HL(779.004,COUNTRYP,0)),"^",1)
 ;
 S APPPRM(IEN,0)=$P(LINE,"^",1)_"^"_$P(LINE,"^",3)_"^"_COUNTRY
 S APPPRM(IEN,"EC")=$G(^HL(771,IEN,"EC"))
 S:(APPPRM(IEN,"EC")="") APPPRM(IEN,"EC")="~|\&"
 S APPPRM(IEN,"FS")=$G(^HL(771,IEN,"FS"))
 S:(APPPRM(IEN,"FS")="") APPPRM(IEN,"FS")="^"
 Q
CLRQUE ; Clear a queue by menu option
 N DIC,DIR,DIRUT,HLDIR,HLERR,HLIEN,HLL,HLLTC,X,Y,TCP
 S TCP=$O(^HLCS(869.1,"B","TCP",0))
 S DIC("S")="I $P(^(0),U,3)'=TCP"
 S DIC="^HLCS(870,",DIC(0)="AEQMZ"
 D ^DIC Q:Y<0
 K DIC S HLIEN=+Y,HLL=$P(Y(0),U,3)
 L +^HLCS(870,HLIEN):1 E  W !!,"Couldn't Lock Record, Try later.",! Q
 S DIR(0)="S^B:BOTH QUEUES;I:IN QUEUE;O:OUT QUEUE",DIR("?")="Select the queue (in, out, or both) you would like cleared"
 S DIR("A")="Enter which queue to clear",DIR("B")="B"
 D ^DIR K DIR
 S HLDIR=$S(Y="I":"IN",Y="O":"OUT",Y="B":"BOTH",1:1)
 I HLDIR=1!$D(DIRUT) L -^HLCS(870,HLIEN) Q
 ;HLLTC= TCP service type
 S:HLL HLLTC=$P($G(^HLCS(870,HLIEN,400)),U,3)
 ;TCP link
 I $G(HLLTC)]"" D  L -^HLCS(870,HLIEN) Q
 . ;multiple server, set STATE and SHUTDOWN LLP?
 . S:HLLTC="M" X=^HLCS(870,HLIEN,0),$P(X,U,5)="0 server",$P(X,U,15)=0,^(0)=X
 . I HLDIR="BOTH" D  Q
 .. F X="IN","OUT" D CLRQUET(X)
 . ;do one que
 . D CLRQUET(HLDIR)
 ;
 I HLDIR="BOTH" D
 . S HLERR=$$CLEARQUE^HLCSQUE(HLIEN,"OUT")
 . I HLERR W !,"Error in clearing out queue:",$P(HLERR,"^",2)
 . S HLERR=$$CLEARQUE^HLCSQUE(HLIEN,"IN")
 . I HLERR W !,"Error in clearing in queue:",$P(HLERR,"^",2)
 I HLDIR'="BOTH" S HLERR=$$CLEARQUE^HLCSQUE(HLIEN,HLDIR)
 L -^HLCS(870,HLIEN)
 Q
CLRQUET(Y) ;subroutine for TCP links, Y=IN or OUT
 Q:Y'="IN"&(Y'="OUT")
 N C,N,X
 S N=$E(Y),X=0
 ;get count of what is pending
 F C=0:1 S X=$O(^HLMA("AC",N,HLIEN,X)) Q:'X
 ;reset counters for messages
 S ^HLCS(870,HLIEN,Y_" QUEUE BACK POINTER")=C,^(Y_" QUEUE FRONT POINTER")=0
 Q
 ;
SHGLLP ; Show Gross LLP Error
 N DIC,IEN,ERR
 S DIC="^HLCS(870,"
 S DIC(0)="AEQM"
 D ^DIC K DIC
 S IEN=$P(Y,"^",1)
 S ERR=$P($G(^HLCS(870,IEN,0)),"^",19)
 W:(ERR'="") !,"Error: "_$P($G(^HL(771.7,ERR,0)),"^",1),!
 W:(ERR="") !,"No Gross LLP error found",!
 Q
CLGLLP ; Clear Gross LLP error
 N DIC,IEN,ERR,DA,DR
 S DIC="^HLCS(870,"
 S DIC(0)="AEQM"
 D ^DIC K DIC
 S IEN=$P(Y,"^",1)
 Q:(IEN<0)
 S DIE="^HLCS(870,"
 S DA=IEN
 S DR="18///@"
 D ^DIE K DIE
 Q
