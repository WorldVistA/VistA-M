MDHL7MCX ; HIRMFO/WAA - Generate HL7 Error Message for MEDICINE ; [05-07-2001 10:38]
 ;;1.0;CLINICAL PROCEDURES;;Apr 01, 2004
 ; Reference IA #1131 for ^XMB("NETNAME") access.
 ; Reference IA #2165 for HLMA1 calls.
 ; Reference IA #2729 for XMXAPI calls.
 ; Reference IA #10111 call to file 3.8 (Read w/FM).
 D BULL,GENACK S MDERROR=1 Q
BULL ; Generate error message
 I $G(MDERROR,0)=0 S MDERROR=1
 S INST=$O(^MCAR(690.7,"B",MCAPP,0)) Q:'INST
 S MG=$P($G(^MCAR(690.7,INST,0)),"^",2) Q:'MG
 S MG=$$GET1^DIQ(3.8,MG_",",.01) Q:MG=""
 S XMTO="G."_MG_"@"_^XMB("NETNAME"),XMINSTR("FROM")=.5
 S TXT(1)=ERRTX,TXT(2)=X,TXT(3)=" "
 S N=3 F X="MSH","PID","OBR","OBX" I $D(SEG(X)) S N=N+1,TXT(N)=SEG(X)
 S XMSUBJ="A Clinical Instrument HL7 Error has occurred."
 S XMBODY="TXT"
 D SENDMSG^XMXAPI(DUZ,XMSUBJ,XMBODY,XMTO,.XMINSTR)
 K TXT Q
GENACK ; Generate an HL7 ACK message
 I $G(MDERROR,0)=0 Q:$G(MDFLAG)=1  ; CP is the interface to HL7 at this point
 S HLA("HLA",1)="MSA"_HL("FS")_$S($D(ERRTX):"AR",1:"AA")_HL("FS")_HL("MID")_$S($D(ERRTX):HL("FS")_ERRTX,1:"")
 S HLEID=HL("EID"),HLEIDS=HL("EIDS"),HLARYTYP="LM",HLFORMAT=1,HLRESLTA=HL("MID")
 D GENACK^HLMA1(HLEID,HLMTIENS,HLEIDS,HLARYTYP,HLFORMAT,.HLRESTLA)
 K ERRTX Q
