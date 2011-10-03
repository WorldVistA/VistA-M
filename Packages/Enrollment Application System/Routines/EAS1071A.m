EAS1071A ;ALB/PJH - ESR and HEC Messaging ; 11/27/07 3:01pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**71**;15-MAR-01;Build 18
 ;
 ;PROTOCOL FILE access through DBIA 3173
 ;
TAG(RETURN,MODE) ; Called from EAS ESR MESSAGING RPC (triggered from HEC)
 N STOP
 S STOP=0
 ;Enable ESR
 I MODE=1 D EN1(.RETURN) D:STOP RESET(.RETURN) Q
 ;Set ESR as system of record
 I MODE=2 D QRY(.RETURN,"ESR") D:STOP QRY(.RETURN,"HEC") Q
 ;Remove HEC
 I MODE=3 D EN^EAS1071B(.RETURN) D:STOP RESET^EAS1071B(.RETURN)  Q
 ;Remove ESR
 I MODE=4 D RESET(.RETURN) D:STOP EN1(.RETURN) Q
 ;Set HEC as system of record
 I MODE=5 D QRY(.RETURN,"HEC") D:STOP QRY(.RETURN,"ESR") Q
 ;Enable HEC
 I MODE=6 D RESET^EAS1071B(.RETURN) Q
 ;
 S RETURN="-1^RPC Called with invalid MODE parameter"
 Q
 ;
EN1(ARR) ;Enable ESR messaging
 ;
 N ADDR,PORT,STATION,TCPDATA,SLLN,VER,DA,FILE,RET,ERROR
 ;
 S:MODE=1 ARR="ESR messaging NOT enabled"
 ;
 ; Get site's Station #
 S STATION=$P($$SITE^VASITE,"^",3)
 ;
 ;Activate EAS ESR event driver server protocols
 D PROTOCOL Q:STOP
 ;Update VAMC event driver protocols (outgoing)
 D DRIVERS(STATION) Q:STOP
 ;Set production IP address and port on Logical Links
 D SETLL16 Q:STOP
 ;
 S:MODE=1 ARR="ESR messaging enabled"
 ;
 Q
 ;
SETLL16 ;Update Sending Logical Link
 ;
 N ADDR,PORT,SHUTDOWN,SLLN,RET
 ;
 ;Production Install
 I $$PROD^XUPROD D  Q:STOP
 .S PORT=8090            ;Vitria production port#
 .S ADDR=$$IPLIVE        ;ESR production (from dental package)
 .S SHUTDOWN=""          ;Shutdown LLP set to No
 .;Abort if no IP address found for production account
 .I ADDR="" D ABORT1 Q
 ;Test/development account values to null
 E  S PORT="",ADDR="00.0.000.00",SHUTDOWN=1
 ;Update value in logical link file
 S SLLN="LLESROUT",RET=$$LL16(SLLN,ADDR,PORT,SHUTDOWN)
 I +RET<0 D ABORT2(RET,"ESR Send Link:"_SLLN)
 Q
 ;
 ;
PROTOCOL ;Remove Disable Text from EAS ESR server protocols
 ;
 N RESULT,SIEN,V,N,N1,LNCNT,LINE,PROTRET,NAM
 S NAM="EAS ESR"
 F  S NAM=$O(^ORD(101,"B",NAM)) Q:NAM'["EAS ESR"  D  Q:STOP
 . Q:NAM'["SERVER"  Q:NAM["QRY-Z10"  Q:NAM["QRY-Z11"
 . S RESULT=$$EDP(NAM,"")
 . I +RESULT<0 D ABORT2(RESULT,"Event Driver:"_NAM)
 ;
 Q
 ;
DRIVERS(STATION) ;Add EAS ESR client to VAMC event driver
 ;
 N ERROR,FILE,IEN101,LINE,LNCNT,RETURN,SIEN101,SNAM
 S LNCNT=1
 F  S LINE=$T(PROTDAT+LNCNT) Q:$P(LINE,";",3)="END"  D  Q:STOP
 .S NAM="VAMC "_STATION_" "_$P(LINE,";",3)_" SERVER"
 .S IEN101=$O(^ORD(101,"B",NAM,0))
 .I +IEN101=0 D  Q
 ..S ERROR="IEN OF RECORD TO BE UPDATED NOT FOUND"
 ..S RETURN=-1_"^"_ERROR
 ..D ABORT2(RETURN,"Event Driver:"_NAM)
 .;
 .;Client Protocol
 .S SNAM="EAS ESR "_STATION_" "_$P(LINE,";",3)_" CLIENT"
 .S SIEN101=$O(^ORD(101,"B",SNAM,0))
 .I +SIEN101=0 D  Q
 ..S ERROR="IEN OF RECORD TO BE UPDATED NOT FOUND"
 ..S RETURN=-1_"^"_ERROR
 ..D ABORT2(RETURN,"Subscriber:"_SNAM)
 .;Skip if already present
 .I $D(^ORD(101,IEN101,775,"B",SIEN101)) D  Q
 ..D WARN(NAM,SNAM)
 ..S LNCNT=LNCNT+1
 .;Add subscriber to event driver
 .S RETURN=$$SUBSCR(IEN101,SIEN101)
 .I +RETURN<0 D ABORT2(RETURN,"driver with Subscriber:"_SNAM) Q
 .S LNCNT=LNCNT+1
 ;
 Q
 ;
WARN(EDP,SP) ;Display Warning Message
 ;
 N ARR
 ;
 S ARR(1)="===================================================="
 S ARR(2)="=                 WARNING                          ="
 S ARR(3)="===================================================="
 S ARR(4)="When updating "_EDP
 S ARR(5)="===================================================="
 S ARR(5)="**"_SP_" is already defined**"
 ;
 Q
 ;
ABORT1 ;Warning and mail message in case of no IP address
 ;
 S STOP=1
 S ARR(1)="===================================================="
 S ARR(2)="=                 ABORTED                          ="
 S ARR(3)="===================================================="
 S ARR(4)="No IP address for VIE was found on the system"
 S ARR(5)="The IP address must be entered on the LLESROUT"
 S ARR(6)="logical link (file #870) before ESR transmissions"
 S ARR(7)="can begin"
 Q
 ;
ABORT2(ERRMSG,SUBJ) ;Display Install Error message and set STOP
 ;
 S STOP=1
 S ARR(1)="===================================================="
 S ARR(2)="=                   ABORTED                        ="
 S ARR(3)="===================================================="
 S ARR(4)="When updating "_SUBJ
 S ARR(5)="===================================================="
 S ARR(5)="**ERROR MSG: "_$P(ERRMSG,"^",2)
 Q
 ;
LL16(LLNAME,TCPADDR,TCPPORT,SHUTDOWN) ;Update Logical Link Port and Address
 ;
 N FILE,DATA,RETURN,DEFINED,ERROR,DA,DGENDA
 S FILE=870
 S IEN870=$O(^HLCS(870,"B",LLNAME,0))
 I 'IEN870 D  Q RETURN
 . S ERROR="IEN OF RECORD TO BE UPDATED NOT FOUND"
 . S RETURN=-1_"^"_ERROR
 ;
 S DATA(400.01)=TCPADDR                    ;TCP/IP ADDRESS
 S DATA(400.02)=TCPPORT                    ;TCP/IP PORT
 S DATA(4.5)=1                             ;AUTOSTART
 S DATA(14)=SHUTDOWN                       ;SHUTDOWN LLP
 ;
 S RETURN=$$UPD^DGENDBS(FILE,IEN870,.DATA,.ERROR)
 S:ERROR'=""!(+RETURN=0) RETURN=-1_"^"_ERROR
 ;
 Q RETURN
 ;
EDP(PNAME,DTXT) ;Remove Disable Text from Event Driver Protocols
 ;
 N DATA,FILE,DGENDA,RETURN,ERROR,DA
 S FILE=101
 ; If already exists then skip
 S IEN101=$O(^ORD(101,"B",PNAME,0))
 I 'IEN101 D  Q RETURN
 . S ERROR="IEN OF RECORD TO BE UPDATED NOT FOUND"
 . S RETURN=-1_"^"_ERROR
 ;
 S DATA(2)=DTXT
 S RETURN=$$UPD^DGENDBS(FILE,IEN101,.DATA,.ERROR)
 I ERROR'=""!(+RETURN=0) S RETURN=-1_"^"_ERROR
 ;
 Q RETURN
 ;
SUBSCR(IEN101,SIEN101) ;Add client to event driver as a subscriber
 ;
 N DATA,DGENDA,ERROR,FILE,RETURN
 S DGENDA(1)=IEN101
 S FILE=101.0775
 S DATA(.01)=SIEN101
 S RETURN=$$ADD^DGENDBS(FILE,.DGENDA,.DATA,.ERROR)
 S:ERROR'=""!(+RETURN=0) RETURN=-1_"^"_ERROR
 ;
 Q RETURN
 ;
IPLIVE() ;Get IP address for production system
 ;
 ;Search for DENTVHLAAC logical link
 S IENS=$$FIND1^DIC(870,"","X","DENTVHLAAC","","","ERR")
 ;If not found return null IP address
 I 'IENS Q ""
 ;Otherwise return TCP/IP ADDRESS
 Q $$GET1^DIQ(870,IENS_",",400.01)
 ;
RESET(ARR) ;Disable or Remove ESR protocols
 N DA,DIK,ERROR,IEN101,LINE,LCT,NAM
 N PREFHEC,PREFESR,SIEN101,SNAM,STOP,SITE
 ;
 I MODE=4 S ARR="ESR messaging NOT disabled"
 ;
 ; Get site's Station #
 S SITE=$P($$SITE^VASITE,"^",3)
 S PREFHEC="VAMC "_SITE_" "
 S PREFESR="EAS ESR "_SITE_" "
 S STOP=0
 ;
 I $$SOR^EAS1071C(PREFESR,PREFHEC) D  Q
 .S ARR="Unable to disable messaging, ESR is SOR"
 ;
 ;Disable to Vista to ESR servers
 S NAM="EAS ESR"
 F  S NAM=$O(^ORD(101,"B",NAM)) Q:NAM'["EAS ESR"  D  Q:STOP
 .Q:NAM'["SERVER"  Q:NAM["QRY-Z10"  Q:NAM["QRY-Z11"
 .;Insert disable text
 .S RESULT=$$EDP(NAM,"ESR-to-Site Messaging Inactive")
 .I +RESULT<0 D ABORT2(RESULT,"Event Driver:"_NAM)
 ;
 ;Remove ESR client subscriber protocols from shared servers
 F LCT=1:1 S LINE=$T(PROTDAT+LCT) Q:$P(LINE,";",3)="END"  D  Q:STOP
 .S NAM=PREFESR_$P(LINE,";",3)_" CLIENT"
 .S SIEN101=$O(^ORD(101,"B",NAM,0))
 .I +SIEN101=0 D  Q
 ..S ERROR="IEN OF RECORD TO BE UPDATED NOT FOUND"
 ..S RETURN=-1_"^"_ERROR
 ..D ABORT2(RETURN,"Event Driver:"_NAM)
 .;If this is a SUBSCRIBER remove from SERVER
 .I $O(^ORD(101,"AB",SIEN101,0)) D REMOVE(SIEN101,NAM)
 ;
 ;
 I MODE=4,'STOP S ARR="ESR messaging disabled"
 Q
 ;
REMOVE(CLIENT,CNAM) ;Remove clients from server
 N DA,DIK,SERV,SNAM,SUB
 S SERV=0
 F  S SERV=$O(^ORD(101,"AB",CLIENT,SERV)) Q:'SERV  D
 .S SUB=0,SNAM=$P($G(^ORD(101,SERV,0)),U)
 .F  S SUB=$O(^ORD(101,"AB",CLIENT,SERV,SUB)) Q:'SUB  D
 ..S DA(1)=SERV,DA=SUB,DIK="^ORD(101,"_DA(1)_",775," D ^DIK
 Q
 ;
PROTDAT ;
 ;;ORU-Z07
 ;;ORU-Z09
 ;;ORF-Z07
 ;;END
 ;
QRY(ARR,SYS) ;Switch system of record (moves QRY-Z10/Z11 Protocols)
 ;
 N PREFHEC,PREFESR,RESULT,SIEN,SITE,V,N,N1,LNCNT,LINE,PROTRET,NAM
 ; Get site's Station #
 S SITE=$P($$SITE^VASITE,"^",3)
 S PREFHEC="VAMC "_SITE_" "
 S PREFESR="EAS ESR "_SITE_" "
 S STOP=0,ARR="SOR unchanged"
 ;
 N ERROR,PREF,RETURN
 ;System being made SOR
 S PREF=$S(SYS="HEC":PREFHEC,1:PREFESR)
 ;Check messaging is settup for system being added
 I '$$Z07^EAS1071C(PREF,PREFHEC) D  Q
 .S ERROR="MESSAGING NOT ENABLED FOR "_SYS
 .S RETURN=-1_"^"_ERROR
 .D ABORT2(RETURN,SYS_" as system of record")
 .S STOP=0
 ;
 I SYS="ESR" D  Q
 .;Disable HEC Z10/Z11 protocols
 .D UNLINK^EAS1071C(PREFHEC) Q:STOP
 .;Enable ESR Z10/Z11 protocols
 .D LINK^EAS1071C Q:STOP
 .;Return message
 .S ARR="ESR set as SOR"
 ;
 I SYS="HEC" D  Q
 .;Disable ESR Z10/Z11 protocols
 .D UNLINK^EAS1071C(PREFESR) Q:STOP
 .;Enable HEC Z10/Z11 protocols
 .D LINK^EAS1071C Q:STOP
 .;Return message
 .S ARR="HEC set as SOR"
 Q
