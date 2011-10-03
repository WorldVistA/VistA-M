MDDEVCL ;HOIFO/NCA - Collect Device Data ;8:34 AM  9 Jun 2005
 ;;1.0;CLINICAL PROCEDURES;**20**;Apr 01, 2004;Build 9
 ; Reference IA # 2056 for DIQ
 ;                2263 FOR XPAR
 ;                2729 for XMXAPI calls.
 ;               10060 for NEW PERSON file (#200) access
COL ; Collect Device data for Transmission
 K ^TMP("MDMTXT",$J)
 N MDLP,MDTXT,MDTXT1,MDCT,MDSTAT,XMBODY,XMSUBJ,XMINSTR,XMTO S MDCT=0,MDSTAT=DUZ(2)
 Q:'+$$GET^XPAR("SYS","MD DEVICE SURVEY TRANSMISSION",1)
 S MDLP=0 F  S MDLP=$O(^MDS(702.09,MDLP)) Q:MDLP<1  S MDTXT=$G(^(MDLP,0)),MDTXT1=$G(^(.1)) D
 .S MDCT=MDCT+1
 .S ^TMP("MDMTXT",$J,MDCT)=MDSTAT_"^"_$P(MDTXT,"^",1)_"^"_$P(MDTXT1,"^",2)_"^"_$P(MDTXT,"^",9)_"^"_$$GET1^DIQ(200,DUZ_",",.01)
 Q:'MDCT
 S XMSUBJ="Medical Device Name Report"
 S XMINSTR("FROM")=.5,XMBODY="^TMP(""MDMTXT"",$J)"
 S XMTO="G.MDDEVICE@DEV.DEV.FO-HINES.MED.VA.GOV"
 D SENDMSG^XMXAPI(DUZ,XMSUBJ,XMBODY,XMTO,.XMINSTR) K ^TMP("MDMTXT",$J)
 I $G(XQY0)'=""&($P($G(XQY0),"^")["TRANSMISSION") W !!,"Message Transmitted."
 Q
