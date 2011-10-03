EAS1071B ;ALB/PJH - EAS*1*71; ; 11/27/07 3:02pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**71**;15-MAR-01;Build 18
 Q
 ;
EN(ARR) ;ENTRY POINT
 ;
 N DA,DIK,LINE,LCT,NAM,PREFIX,RESULT
 ;
 S ARR="HEC messaging NOT disabled"
 ;
 ; Get site's Station #
 S PREFIX="VAMC "_$P($$SITE^VASITE,"^",3)_" "
 ;
 I $$SOR^EAS1071C(PREFIX,PREFIX) D  Q
 .S ARR="Unable to disable messaging, HEC is SOR"
 ;
 ;Remove HEC client subscriber protocols from shared servers
 F LCT=1:1 S LINE=$T(PROTDAT+LCT) Q:$P(LINE,";",3)="END"  D  Q:STOP
 .S NAM=PREFIX_$P(LINE,";",3)_" CLIENT"
 .S SIEN101=$O(^ORD(101,"B",NAM,0))
 .I +SIEN101=0 D  Q
 ..S ERROR="IEN OF RECORD TO BE UPDATED NOT FOUND"
 ..S RETURN=-1_"^"_ERROR
 ..D ERROR(RETURN,"Event Driver:"_NAM)
 .;If this is a SUBSCRIBER remove from SERVER
 .I $O(^ORD(101,"AB",SIEN101,0)) D REMOVE(SIEN101,NAM)
 ;
 ;Add disable text to HEC to ESR servers
 F LCT=1:1 S LINE=$T(PROTDAT1+LCT) Q:$P(LINE,";",3)="END"  D
 .S NAM=PREFIX_$P(LINE,";",3)
 .;Insert disable text
 .S RESULT=$$EDP(NAM,"HEC Legacy to Site Messaging Inactivated")
 .I +RESULT<0 D ERROR(RESULT,"Event Driver:"_NAM)
 ;
 S:'STOP ARR="HEC messaging disabled"
 Q
 ;
EDP(PNAME,DTXT) ;Remove Disable Text from Event Driver Protocols
 ;
 N DATA,FILE,DGENDA,RETURN,ERROR,DA
 S FILE=101
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
REMOVE(CLIENT,CNAM) ;Remove clients from server
 N DA,DIK,SERV,SNAM,SUB
 S SERV=0
 F  S SERV=$O(^ORD(101,"AB",CLIENT,SERV)) Q:'SERV  D
 .S SUB=0,SNAM=$P($G(^ORD(101,SERV,0)),U)
 .F  S SUB=$O(^ORD(101,"AB",CLIENT,SERV,SUB)) Q:'SUB  D
 ..S DA(1)=SERV,DA=SUB,DIK="^ORD(101,"_DA(1)_",775," D ^DIK
 Q
 ;
PROTDAT ;Vista to HEC clients on shared Event Drivers
 ;;ORU-Z07
 ;;ORU-Z09
 ;;ORF-Z07
 ;;END
 ;;NOTE THAT THESE ARE HANDLED BY QRY^EAS1071A
 ;;QRY-Z10
 ;;QRY-Z11
 ;;END
 ;
PROTDAT1 ;HEC to Vista Event Drivers to disable
 ;;ORU-Z04 SERVER H
 ;;ORU-Z05 SERVER
 ;;ORU-Z10 SERVER
 ;;ORU-Z11 SERVER
 ;;ORF-Z10 SERVER
 ;;ORF-Z11 SERVER
 ;;QRY-Z07 SERVER
 ;;MFN-ZEG SERVER
 ;;END
 ;
RESET(ARR) ;Enable or Attach HEC protocols
 N DA,DIK,ERROR,IEN101,LINE,LCT,NAM,PREFIX,SIEN101,SNAM,STOP
 ;
 S ARR="HEC messaging NOT re enabled"
 ;
 ; Get site's Station #
 S PREFIX="VAMC "_$P($$SITE^VASITE,"^",3)_" ",STOP=0
 ;
 ;Enable to Vista to HEC Legacy servers
 F LCT=1:1 S LINE=$T(PROTDAT1+LCT) Q:$P(LINE,";",3)="END"  D
 .S NAM=PREFIX_$P(LINE,";",3)
 .;Remove disable text
 .S RESULT=$$EDP(NAM,"")
 .I +RESULT<0 D ERROR(RESULT,"Event Driver:"_NAM)
 ;
 ;
 ;Add HEC client protocols to shared servers
 F LCT=1:1 S LINE=$T(PROTDAT+LCT) Q:$P(LINE,";",3)="END"  D
 .S FILE=101
 .;Server protocol
 .S NAM=PREFIX_$P(LINE,";",3)_" SERVER"
 .I NAM["Z04" S NAM=NAM_" V"
 .S IEN101=$O(^ORD(101,"B",NAM,0))
 .I 'IEN101 D  Q RETURN
 ..S ERROR="IEN OF RECORD TO BE UPDATED NOT FOUND"
 ..S RETURN=-1_"^"_ERROR
 .;
 .;Client protocol (subscriber)
 .S SNAM=PREFIX_$P(LINE,";",3)_" CLIENT"
 .I SNAM["Z04" S SNAM=SNAM_" V"
 .S SIEN101=$O(^ORD(101,"B",SNAM,0))
 .I +SIEN101=0 D  Q
 ..S ERROR="IEN OF RECORD TO BE UPDATED NOT FOUND"
 ..S RETURN=-1_"^"_ERROR
 ..D ERROR(RETURN,"Subscriber:"_SNAM)
 .;Skip if already present
 .I $D(^ORD(101,IEN101,775,"B",SIEN101)) D  Q
 ..D WARN(NAM,SNAM)
 .;Add subscriber to event driver
 .S RETURN=$$SUBSCR(IEN101,SIEN101)
 .I +RETURN<0 D ERROR(RETURN,"driver with Subscriber:"_SNAM) Q
 ;
 S:'STOP ARR="HEC messaging re enabled"
 Q
 ;
 ;
ERROR(ERRMSG,SUBJ) ;Display Install Error message and set STOP
 ;
 S STOP=1
 ;
 S ARR(1)="===================================================="
 S ARR(2)="=                   ERROR                          ="
 S ARR(3)="===================================================="
 S ARR(4)="When updating "_SUBJ
 S ARR(5)="===================================================="
 S ARR(5)="**ERROR MSG: "_$P(ERRMSG,"^",2)
 ;
 Q
 ;
WARN(EDP,SP) ;Display Warning Message
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
