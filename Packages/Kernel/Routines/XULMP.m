XULMP ;IRMFO-ALB/CJM/SWO/RGG - KERNEL LOCK MANAGER ;12/01/2012
 ;;8.0;KERNEL;**608**;JUL 10, 1995;Build 84
 ;;Per VA Directive 6402, this routine should not be modified
 ;
 ;  ******************************************************************
 ;  *                                                                *
 ;  *  The Kernel Lock Manager is based on the VistA Lock Manager    *
 ;  *        developed by Tommy Martin.                              *
 ;  *                                                                *
 ;  ******************************************************************
 ;Setting up parameters
 ;
GETPARMS(PARMS,ERROR) ;
 ;
 K PARMS
 S ERROR=""
 D
 .N IEN,NODE,SUB,COUNT
 .S IEN=$O(^XLM(8993.1,0))
 .I 'IEN S ERROR="Parameter file not setup" Q
 .S NODE=$G(^XLM(8993.1,IEN,0))
 .S PARMS("ON?")=$S($P(NODE,"^",2)="e":1,1:0)
 .S PARMS("PRODUCTION?")=$$PROD^XUPROD()
 .S (COUNT,SUB)=0
 .F  S SUB=$O(^XLM(8993.1,IEN,3,SUB)) Q:'SUB  D
 ..N BOX,IP,PORT,SHORTNM
 ..S NODE=$G(^XLM(8993.1,IEN,3,SUB,0))
 ..S BOX=$P(NODE,"^")
 ..Q:BOX=""
 ..S PORT=$P(NODE,"^",3)
 ..I PORT="",BOX'=$$NODE^XULMU Q
 ..S IP=$P(NODE,"^",2)
 ..I '$L(IP),BOX'=$$NODE^XULMU Q
 ..S PARMS("NODES",BOX,"IP ADDRESS")=IP
 ..S PARMS("NODES",BOX,"PORT")=PORT
 ..S PARMS("NODES",BOX,"SHORT NAME")=$P(NODE,"^",4)
 ..S PARMS("NODES",BOX)=SUB
 ..S COUNT=COUNT+1
 ..S PARMS("NODES")=COUNT
 .I '$D(PARMS("NODES",$$NODE^XULMU)) S PARMS("NODES",$$NODE^XULMU,"IP ADDRESS")="",PARMS("NODES",$$NODE^XULMU,"PORT")="",PARMS("NODES")=$G(PARMS("NODES"))+1
 Q $S($L($G(ERROR)):0,1:1)
 ;
EDIT ;Edit the site parameters
 N DA,DIE,DR
 S DA=$O(^XLM(8993.1,0))
 I 'DA D
 .N DATA
 .S DATA(.01)=+$$SITE^VASITE
 .S DA=$$ADD^XULMU(8993.1,,.DATA)
 I 'DA D PAUSE^XULMU("There is no entry in the XULM LOCK MANAGER PARAMETERS file!") Q
 S DR="[XULM EDIT PARAMETERS]"
 S DIE=8993.1
 D ^DIE
 Q
 ;
 ;
 ;
 ;
 ;
 ;
