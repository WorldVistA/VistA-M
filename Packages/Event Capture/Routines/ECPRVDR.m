ECPRVDR ;ALB/DAN - Event Capture Providers ;11/7/16  15:29
 ;;2.0;EVENT CAPTURE;**134**;8 May 96;Build 12
 ;
FILE ;Used by RPC broker to file users into file #722
 ;     Variables passed in
 ;       ECD0...n -IEN of user to be added to file #722
 ;
 ;     Varibles returned
 ;       ^TMP($J,"ECMSG",1)=Success or failure of filing records
 ;
 N ECI,ECX,ECPRV,NODE,ECFDA,IEN,ECERR,ERR,RES
 S ERR=0
 F ECI=0:1 S ECX="ECD"_ECI Q:'$D(@ECX)!(ERR)  I @ECX'="" D
 .D CHK^DIE(722,.01,,"`"_@ECX,.RES) I $G(RES)="^" S ERR=1,^TMP($J,"ECMSG",1)="0^IEN of user doesn't exist in file 200" Q
 .S ECPRV(@ECX)="" ;Put IENs in array
 I ERR Q  ;Stop processing if a bad IEN has been passed in
 ;Delete all existing entries in file 722 before putting in new list
 S NODE=$G(^EC(722,0)) I NODE="" S ^TMP($J,"ECMSG",1)="0^File 722 doesn't exist" Q
 K ^EC(722) ;remove all entries and x-refs
 S ^EC(722,0)=NODE,$P(^EC(722,0),U,3,99)="" ;reset 0 node and remove total records and last record used information
 ;Populate file with list of entries
 S IEN=0 F  S IEN=$O(ECPRV(IEN)) Q:'+IEN!(ERR)  D
 .S ECFDA(722,"+1,",.01)=IEN
 .D UPDATE^DIE("","ECFDA","","ECERR") ;Add entry to file 722
 .I $D(ECERR) S ^TMP($J,"ECMSG",1)="0^Unable to file IEN "_IEN_" into file" S ERR=1
 I 'ERR S ^TMP($J,"ECMSG",1)="1^File successfully updated"
 Q
 ;
LIST ;Return list of entries in file 722
 N I,NAM,IEN
 S I=0,NAME=""
 F  S NAME=$O(^EC(722,"AC",NAME)) Q:NAME=""  S IEN=0 F  S IEN=$O(^EC(722,"AC",NAME,IEN)) Q:'+IEN  D
 .I '$$ACTIVE^XUSER(IEN) Q  ;Don't include inactive users on the list.
 .S I=I+1,^TMP($J,"ECFIND",I)=NAME_"^"_IEN
 Q
