VAQREQ11 ;ALB/JFP - PDX, TIME/OCCURENCE LIMITS;01SEPT93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
EP ; -- Entry point
 ;    - Called from VAQREQ04
 ;    - Calls help routine VAQREQ09
 ;
DEFAULT ; -- Extracts the default time and occurrence limits for HS segments
 N PARAMND,TLDEF,OLDEF
 S PARAMND=$G(^VAT(394.81,1,"LIMITS"))
 S TLDEF=$P(PARAMND,U,1)
 S OLDEF=$P(PARAMND,U,2)
 ; -- Extracts existing limits
 I $D(^TMP("VAQSEG",$J,DOMAIN,SEGMNU)) D
 .S PARAMND=$G(^TMP("VAQSEG",$J,DOMAIN,SEGMNU))
 .S TLDEF=$P(PARAMND,U,3)
 .S OLDEF=$P(PARAMND,U,4)
 ;
DRIVER ; -- Time and Occurrence
 K TLIMIT,OLIMIT
 I $P(HSCOMPND,U,2)=1 D ASKTIME
 I $P(HSCOMPND,U,3)=1 D ASKOCC
 K DIRUT
 QUIT
 ;
ASKTIME ; -- Prompts for time limit
 ; -- Call to Dir to request time
 S DIR("A")="   Enter Time Limit: "
 S DIR("B")=TLDEF
 S DIR(0)="FAO^1:5^D CHKT1^VAQREQ11"
 S DIR("?")="^D HLPT1^VAQREQ11"
 S DIR("??")="^D HLPT2^VAQREQ11"
 W ! D ^DIR K DIR  Q:$D(DIRUT)
 S TLIMIT=Y
 QUIT
 ;
ASKOCC ; -- Prompts for occurrence limit
 ; -- Call to Dir to occurrence time
 S DIR("A")="   Enter Occurence Limit: "
 S DIR("B")=OLDEF
 S DIR(0)="FAO^1:5^D CHKO1^VAQREQ11"
 S DIR("?")="^D HLPO1^VAQREQ11"
 S DIR("??")="^D HLPO2^VAQREQ11"
 D ^DIR K DIR  Q:$D(DIRUT)
 S OLIMIT=Y
 QUIT
 ;
CHKT1 ;
 N GMTSFUNC
 S GMTSFUNC=$O(^DD("FUNC","B","UPPERCASE",0))
 X ^DD("FUNC",GMTSFUNC,1)
 K:($L(X)<1)!'((X?1N.N1"D")!(X?1N.N1"M")!(X?1N.N1"Y")) X
 QUIT
 ;
CHKO1 ;
 K:+X'=X!(X>99999)!(X<1)!(X?.E1"."1N.N) X
 QUIT
 ;
HLPO1 ; -- ? Help Message for occurrence
 N DIWL,DIWR,DIWF
 S X=$G(^DD(142.01,2,3)),DIWL=6,DIWR=80,DIWF="W"
 D ^DIWP
 D ^DIWW
 QUIT
 ;
HLPT1 ; -- ? Help Message for time
 N DIWL,DIWR,DIWF
 S X=$G(^DD(142.01,2,3)),DIWL=6,DIWR=80,DIWF="W"
 D ^DIWP
 D ^DIWW
 QUIT
 ;
HLPO2 ; -- ?? Help Message for occurrence
 N OCC,DIWL,DIWR,DIWF
 S OCC=0,DIWL=6,DIWR=80,DIWF="W"
 F  S OCC=$O(^DD(142.01,2,21,OCC))  Q:OCC=""  D
 .S X=$G(^DD(142.01,2,21,OCC,0))
 .D ^DIWP
 D ^DIWW
 QUIT
HLPT2 ; -- ?? Help Message for time
 N OCC,DIWL,DIWR,DIWF
 S OCC=0,DIWL=6,DIWR=80,DIWF="W"
 F  S OCC=$O(^DD(142.01,3,21,OCC))  Q:OCC=""  D
 .S X=$G(^DD(142.01,3,21,OCC,0))
 .D ^DIWP
 D ^DIWW
 QUIT
END ; -- End of code
 QUIT
