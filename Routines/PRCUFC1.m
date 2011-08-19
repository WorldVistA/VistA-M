PRCUFC1 ;WISC/SJG-CONVERSION ROUTINE TO PROCESS OBLIGATIONS ;4/27/94  11:30
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 QUIT
 ; No top level entry
 ; Special Fund Control Point = 1
GPFO ; Entry point for Original Entry General Post Fund Conversion Documents
 S PRCFA("MOD")="E^0^Original Entry"
 S PRCFA("IDES")="General Post Fund Conversion Original Entry"
 D FCP Q:FATAL
 D DET^PRCUFCU1,RECD^PRCUFCU1,CALC^PRCUFCU1
 D GPF
 Q
GPFM ; Entry point for Modification Entry General Post Fund Conversion Documents
 S PRCFA("MOD")="M^1^Modification Entry"
 S PRCFA("IDES")="General Post Fund Conversion Modification Entry"
 D FCP Q:FATAL
 D DET^PRCUFCU1,RECD^PRCUFCU1,CALC^PRCUFCU1
 I PRCFCHG("BOC","TOT")=0 S FATAL=1 Q
 F PRCFA="VEND","FOB","DEL","DELSCH","PPT" S PRCFA(PRCFA)=1
 D GPF
 Q
GPF ; Processing common for all General Post Fund documents
 S PO(0)=ND(0),PO=LOOP,PRCFA("PODA")=+LOOP
 S PRCFA("BBFY")=$$BBFY^PRCFFU5(PO)
 S IDFLAG="I"
 S PARAM1="^"_PRC("SITE")_"^"_PRC("CP")_"^"_PRC("FY")_"^"_PRCFA("BBFY")
GPF1 D DOCREQ^PRC0C(PARAM1,"SPE","PRCFMO")
 S PRCFMO("G/N")=$P(PRCFMO,U,12)
 S PRCFA("REF")=$P(PO(0),U),PRCFA("SYS")="FMS"
 S PRCFA("SFC")=$P(PO(0),U,19),PRCFA("MP")=$P(PO(0),U,2)
 S PRCFA("TT")=$S(PRCFA("MP")=2:"SO",PRCFA("MP")=1:"MO",PRCFA("MP")=8:"MO",1:"MO")
GPF2 D NOW^%DTC S PRCFA("OBLDATE")=X
 S MOD=$P(PRCFA("MOD"),U,2) D STACK^PRCUFCE(MOD)
 K ^TMP($J,"PRCMO")
 N FMSINT S FMSINT=+PO,FMSMOD=$P(PRCFA("MOD"),U,1)
 D NEW^PRCUFCA(FMSINT,PRCFA("TT"),FMSMOD)
 N LOOP S LOOP=0 F  S LOOP=$O(^TMP($J,"PRCMO",GECSFMS("DA"),LOOP)) Q:'LOOP  D SETCS^GECSSTAA(GECSFMS("DA"),^(LOOP))
 K ^TMP($J,"PRCMO")
GPF3 D SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 D SETPARAM^GECSSDCT(GECSFMS("DA"),+PO)
 N FMSDOCT S FMSDOCT=$P(PRCFA("REF"),"-",2) D EN7^PRCFFU41(PRCFA("TT"),FMSMOD,PRCFA("OBLDATE"),FMSDOCT)
 QUIT
FCP ; Get 'dummy' GPF Fund Control Point accounting information
 N X
 S FATAL=0,X="GPFS FMS CONVERSION"
 S PRC("CP")=$O(^PRC(420,PRC("SITE"),1,"C",X,0))
 Q
