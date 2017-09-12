SR68UTL0 ;BIR/SLM-Transmit missing surgery risk data; 10 Jul 97 12:00
 ;;3.0; Surgery ;**68**;24 Jun 93
 Q
EN1 S SITE=+$P($$SITE^SROVAR,"^",3),SRI=0,SROPD=2961000
 F  S SROPD=$O(^SRF("AC",SROPD)) Q:'SROPD  S SRTN=0 F  S SRTN=$O(^SRF("AC",SROPD,SRTN)) Q:'SRTN  I (SROPD'<2961000),($P($G(^SRF(SRTN,"RA")),"^",6)="Y"),($P($G(^SRF(SRTN,"RA")),"^",2)="N"),($P(^SRF(SRTN,0),"^",12)="O") D
 .I $P($G(^SRF(SRTN,"RA")),"^")'="T" Q
 .S SRSDATE=SROPD D OCC^SROAUTL0 F I=1:1:26 S SROC(I)=$TR(SROC(I)," ","")
 .S SRZ=0 F SRZ=21,29:1:32 I $P($G(SROOC(SRZ)),U)="NO ICD9 CODE ENTERED" S $P(SROOC(SRZ),U)="NS"
 .S SRRES=$P($G(SROOC(29)),U)_"@"_SROC(8) I SRRES="@" S SRRES=""
 .S SRCNS=$P($G(SROOC(30)),U)_"@"_SROC(16) I SRCNS="@" S SRCNS=""
 .S SRUTR=$P($G(SROOC(31)),U)_"@"_SROC(12) I SRUTR="@" S SRUTR=""
 .S SRCAR=$P($G(SROOC(32)),U)_"@"_SROC(20) I SRCAR="@" S SRCAR=""
 .S SROTH=$P($G(SROOC(21)),U)_"@"_SROC(26) I SROTH="@" S SROTH=""
 .S SRDIV=$P($G(^SRF(SRTN,8)),"^")
 .S SRTMP=SITE_"^"_SRDIV_"^"_SRTN_"^"_SROC(1)_"^"_SROC(2)_"^"_SROC(25)_"^"_SROC(4)_"^"_SROC(6)_"^"_SROC(7)_"^"_SROC(5)_"^"_SROC(9)_"^"_SROC(10)_"^"_SROC(11)_"^"_SROC(19)_"^"_SROC(13)_"^"_SROC(14)
 .S SRTMP=SRTMP_"^"_SROC(15)_"^"_SROC(22)_"^"_SROC(17)_"^"_SROC(18)_"^"_SROC(21)_"^"_SROC(23)_"^"_SROC(24)_"^"_SROC(3)_"^"_SRRES_"^"_SRCNS_"^"_SRUTR_"^"_SRCAR_"^"_SROTH
 .S SRI=SRI+1,^TMP("SRA",$J,SRI)=SRTMP
ACK ;
 S XMSUB="*** SR*3*68 FROM VAMC-"_SITE_" ***",XMDUZ=^XMB("NETNAME")
 S XMY("G.SRCOSERV@ISC-CHICAGO.DOMAIN.EXT")=""
 S XMTEXT="^TMP(""SRA"",$J," N I D ^XMD
 K ^TMP("SRA"),SRTN,SITE,SRCAR,SRCNS,SRDA,SRI,SROC,SROOC,SROTH,SRRES,SRSDATE,SRTDT,SRUTR,SRZ,SRZZ,SRDIV,SRTMP
 S ZTREQ="@"
 Q
POST ; post-install action for SR*3*68
 ; task install notification message
 N SRD,SRNOW X ^%ZOSF("UCI") I $P(Y,",")'=$P(^%ZOSF("PROD"),",") Q
 S SRD=^XMB("NETNAME") I $E(SRD,1,3)="ISC"!(SRD["ISC-")!(SRD["ISC.")!(SRD["FORUM")!(SRD["TST.")!(SRD["TEST")!(SRD["UTL.") Q
 D TRANS
QUEUE ; queue install message
 D NOW^%DTC S (SRNOW,ZTDTH)=$E(%,1,12),ZTRTN="MSG^SR68UTL0",ZTSAVE("SRNOW")=SRNOW,ZTDESC="Patch SR*3*68 Install Message",ZTIO="" D ^%ZTLOAD
 Q
MSG ; send mail message to national database
 H 20 S SRD=^XMB("NETNAME")
 K SRMSG S SRMSG(1)="Patch SR*3*68 has been installed at "_SRD_"."
 S SRMSG(2)="Start time: "_SRZ,SRMSG(3)="End time: "_SRY
 S XMSUB="SR*3*68 Installed",XMDUZ=DUZ
 S XMY("G.SR-INSTALL@ISC-BIRM.DOMAIN.EXT")=""
 S XMTEXT="SRMSG(" D ^XMD
END S ZTREQ="@"
 Q
TRANS ; task retransmission message
 S ZTRTN="EN1^SR68UTL0",ZTDESC="Surgery Risk Assessment Retransmission Routine",ZTIO="" S:$G(XPDQUES("POS1")) ZTDTH=XPDQUES("POS1")
 D ^%ZTLOAD
 Q
