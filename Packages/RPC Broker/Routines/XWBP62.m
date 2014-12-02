XWBP62 ;OIFO-Oakland/RD - Test routine for patch 62  ;05/17/2002  17:41
 ;;1.1;RPC BROKER;**62**;Mar 21, 2002;Build 11
 ;Per VHA Directive 6402, this routine should not be modified
 Q
EN ;send XML message to test M2M Broker
 N ADD,PARMS,PORT,MESS,TST,X
 ;get address and port of listener
 W !!,"This routine will attempt to send an XML message to the M2M Broker."
 W !,"You will need to IP Address and Port number for the M2M Broker."
 R !,"IP Address: ",ADD:300 Q:ADD="^"!(ADD="")
 R !,"Port Number: ",PORT:300 Q:PORT="^"!(PORT="")
 ;Set up arrays for connection and message
 S PARMS("ADDRESS")=ADD,PARMS("PORT")=PORT,PARMS("RETRIES")=3
 S PARMS("RESULTS")="MESS",PARMS("REQUEST")="TST"
 S TST(1)="<?xml version=""1.0"" encoding=""utf-8"" ?>"
 S TST(2)="<vistalink type=""Gov.VA.Med.RPC.Request"" mode=""RPCBroker"" >"
 S TST(3)="<rpc uri=""XUS DIVISION GET"" >"
 S TST(4)="<session>"
 S TST(5)="<duz value=""1"" />"
 S TST(6)="<security>"
 S TST(7)="<token value=""AAA"" />"
 S TST(8)="</security>"
 S TST(9)="</session>"
 S TST(10)="</rpc>"
 S TST(11)="</vistalink>"
 ;connect to server
 I '$$OPEN^XWBRL(.PARMS) U IO W !!,"Couldn't open port",! Q
 S X=$$EXECUTE^XWBVLC(.PARMS)
 DO CLOSE^%ZISTCP
 U IO W !!
 ZW MESS
 Q
