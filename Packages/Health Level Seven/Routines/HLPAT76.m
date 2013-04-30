HLPAT76 ;OAKCIOFO/AC POSTINIT ;08/06/2001  21:14
 ;;1.6;HEALTH LEVEL SEVEN;**76**;JUL 17, 1995
ENTER ; Check for incomplete messages as a result of READ ERRORS
 ; encountered by the DIRECT CONNECT API.
 D BMES^XPDUTL("Post-init will identify all incomplete messages associated with TCP links")
 D BMES^XPDUTL("These incomplete messages were a result of Network errors")
 D BMES^XPDUTL("encountered by the DIRECT CONNECT API.")
 D BMES^XPDUTL("These messages will be removed from the outbound TCP queue.")
 D BMES^XPDUTL("Scanning for incomplete messages...")
EN1 ;ENTRY POINT ONE
 N HLDA,HLFIRST,HLL,HLLAST,HLTCP,XPDIDTOT
 S HLTCP=""
 S HLFIRST=+$O(^HLMA("AC","O",0))
 I 'HLFIRST D BMES^XPDUTL("No messages in the outbound TCP queue.") Q
 S HLLAST=+$O(^HLMA("AC","O","@"),-1)
 S XPDIDTOT=HLLAST-HLFIRST+1
 F HLL=0:0 S HLL=$O(^HLMA("AC","O",HLL)) Q:HLL'>0  D
 .D UPDATE^XPDID(XPDIDTOT-(HLLAST-HLL+1))
 .F HLDA=0:0 S HLDA=$O(^HLMA("AC","O",HLL,HLDA)) Q:HLDA'>0  D
 ..F  L +^HLMA(HLDA):1 Q:$T  H 1
 ..I '$D(^HLMA(HLDA,"P")) D STATUS^HLTF0(HLDA,3,,,1)
 ..L -^HLMA(HLDA)
 Q
