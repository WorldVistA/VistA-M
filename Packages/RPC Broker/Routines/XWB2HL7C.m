XWB2HL7C ;ISF/RWF - Remote RPC via HL7 ;12/27/01 15:33
 ;;1.1;RPC BROKER;**27**;Mar 28, 1997
 ;
 Q
 ;
DEQ ; Dequeue to DIRECT HL7 Call...
 ;
 S ZTREQ="@"
 ;
 ; DIRECT Parameters...
 ; D DIRECT^XWB2HL7A(PROCEDURENAME,QUERY-TAG,ERROR-RETURN,
 ;                   DESTINATION,PARAMETER-ARRAY)
 ;
 ; Actual DIRECT call...
 D DIRECT^XWB2HL7A("ZREMOTE RPC",XWBHDL,.XWBMSG,LOC,.XWBPAR)
 ;
 ; Did something go wrong?
 I $P(XWBMSG,U,2) S RET(0)="-1^"_$P(XWBMSG,"^",3) QUIT  ;->
 I 'HLMTIEN S RET(0)="-1^No Message returned" QUIT  ;->
 ;
 ; Everything went OK...
 D RETURN^XWB2HL7
 D RTNDATA^XWBDRPC(.RET,XWBHDL)
 ;
 Q
 ;
 ; The code in OLDEN1 below is the original pre-XWB*1.1*27 EN1^XWB2HL7
 ; code.  The original EN1 code was moved here, to OLDEN1.  The only
 ; changes made were to change D SETUP to D SETUP^XWB2HL7.
 ;
OLDEN1(RET,LOC,RPC,RPCVER,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) ;Call a remote RPC with 1-10 parameters.
 N X,I,INX,N,XWBHL7,XWBPAR,XWBPCNT,XWBDVER,XWBESSO,XWBHDL,PMAX
 N XWBMSG,XWBSEC,RPCIEN
 D SETUP^XWB2HL7(0) I $G(RET(1))'="" Q
 ;Call HL7
 ;(procedurename, query tag, error return, destination, Parameter array)
 D CALL^XWB2HL7A("ZREMOTE RPC",XWBHDL,.XWBMSG,LOC,.XWBPAR)
 S RET(0)=XWBHDL I $P(XWBMSG,U,2) S RET(1)=$P(XWBMSG,U,2,3)
 I XWBMSG>0 D SETNODE^XWBDRPC(XWBHDL,"MSGID",+XWBMSG)
 Q
 ;
EOR ;XWB2HL7C - Remote RPC via HL7 ;12/27/01 15:33
