HLCSGTM ;OIFO-O/RWF - (TCP/IP) GT.M Linux ;08/13/2007
 ;;1.6;HEALTH LEVEL SEVEN;**122**;Oct 13, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; 1. port number is input from VMS COM file, such as HLSxxxxDSM.COM,
 ;    HLSxxxxCACHE.COM, or HLSxxxxGTM.COM file, where xxxx is port
 ;    number.
 ; 2. find the ien of #870(logical link file) for the multi-listener
 Q
 ;
IEN(HLPORT) ;
 ; HLIEN870: ien in #870 (logical link file)
 ; HLPRTS: port number in entry to be tested
 ;
 N HLPRTS,HLIEN870
 I '$G(HLPORT) D ^%ZTER Q
 S HLIEN870=0
 F  S HLIEN870=$O(^HLCS(870,"E","M",HLIEN870)) Q:'HLIEN870  D  Q:(HLPRTS=HLPORT)
 . S HLPRTS=$P(^HLCS(870,HLIEN870,400),"^",2)
 I 'HLIEN870 D ^%ZTER Q
 ;
 Q HLIEN870
 ;
GTMLNX ; From Linux xinetd script
 ;Get port from ZSHOW "D"
 S U="^",$ZT="",$ET="D ^%ZTER HALT" ;Setup the error trap
 ; GTM specific code
 S IO=$P X "U IO:(nowrap:nodelimiter:IOERROR=""TRAP"")" ;Setup device
 S @("$ZINTERRUPT=""I $$JOBEXAM^ZU($ZPOSITION)""")
 K ^TMP($J) ZSHOW "D":^TMP($J)
 F %=1:1 Q:'$D(^TMP($J,"D",%))  S X=^(%) Q:X["LOCAL"
 S IO("IP")=$P($P(X,"REMOTE=",2),"@"),IO("PORT")=+$P($P(X,"LOCAL=",2),"@",2)
 S %=$P($ZTRNLNM("SSH_CLIENT")," ") S:%="" %=$ZTRNLNM("REMOTEHOST")
 S HLDP=$$IEN(IO("PORT"))
 ;
 D LISTEN^HLCSTCP
 Q
 ;
 ;Sample Linux script
 ;#!/bin/bash
 ;#HL7 Listener
 ;cd /home/vista/dev/
 ;. ./gtmprofile
 ;#env > hl7log.txt
 ;$gtm_dist/mumps -r GTMLNX^HLCSGTM
 ;exit 0
 ;
 ;Sample xinetd config file
 ;service hl7tcp
 ;{
 ;        socket_type     = stream
 ;        user            = gtmuser
 ;        wait            = no
 ;        disable         = no
 ;        server          = /bin/bash
 ;        server_args     = -l /home/vista/dev/hl7tcp.sh
 ;        passenv         = REMOTE_HOST
 ;}
