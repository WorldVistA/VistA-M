SR61UTL ;BIR/SLM-Transmit missing surgery risk data
 ;;3.0; Surgery ;**61**;24 Jun 93
 ;;ICD9 code@occurrence date^ICD9 code@occurrence date^ICD9 code@occu...
EN1 S SITE=+$P($$SITE^SROVAR,"^",3)
 S X=0 F  S X=$O(^XPD(9.7,"B","SR*3.0*57",X)) Q:'X  S SRDA=X
 S Z=$G(^XPD(9.7,SRDA,1)),SRZZ=$E($P(Z,"^",3),1,7)
 S SRZZ=$S(SRZZ="":"2960911",1:SRZZ)
 S (SRDFN,SRI)=0 F  S SRDFN=$O(^SRF("ARS","N","T",SRDFN)) Q:'SRDFN  S SRTN=0 F  S SRTN=$O(^SRF("ARS","N","T",SRDFN,SRTN)) Q:'SRTN  I $P(^SRF(SRTN,"RA"),"^",6)="Y" S SRTDT=$E($P(^SRF(SRTN,"RA"),"^",4),1,7) I SRTDT'<SRZZ D
 .S SRSDATE=$E($P(^SRF(SRTN,0),"^",9),1,7)
 .D OCC^SROAUTL0 F I=1:1:26 S SROC(I)=$TR(SROC(I)," ","")
 .S SRZ=0 F SRZ=21,29:1:32 I $P($G(SROOC(SRZ)),U)="NO ICD9 CODE ENTERED" S $P(SROOC(SRZ),U)="NS"
 .S SRRES=$P($G(SROOC(29)),U)_"@"_SROC(8) I SRRES="@" S SRRES=""
 .S SRCNS=$P($G(SROOC(30)),U)_"@"_SROC(16) I SRCNS="@" S SRCNS=""
 .S SRUTR=$P($G(SROOC(31)),U)_"@"_SROC(12) I SRUTR="@" S SRUTR=""
 .S SRCAR=$P($G(SROOC(32)),U)_"@"_SROC(20) I SRCAR="@" S SRCAR=""
 .S SROTH=$P($G(SROOC(21)),U)_"@"_SROC(26) I SROTH="@" S SROTH=""
 .S SRDIV=$P($G(^SRF(SRTN,8)),"^")
 .S SRI=SRI+1,^TMP("SRA",$J,SRI)=SITE_"^"_SRDIV_"^"_SRTN_"^"_SRRES_"^"_SRCNS_"^"_SRUTR_"^"_SRCAR_"^"_SROTH
ACK ;
 S XMSUB="*** SR*3*61 FROM VAMC-"_SITE_" ***",XMDUZ=^XMB("NETNAME")
 S XMY("G.SRCOSERV@ISC-CHICAGO.DOMAIN.EXT")=""
 S XMTEXT="^TMP(""SRA"",$J," N I D ^XMD
 K ^TMP("SRA"),SRTN,SITE,SRCAR,SRCNS,SRDA,SRDFN,SRI,SROC,SROOC,SROTH,SRRES,SRSDATE,SRTDT,SRUTR,SRZ,SRZZ,SRDIV
 S ZTREQ="@"
 Q
POST ; postinit action for SR*3*61
 S ^DD(130,0,"ID",26)="W:$D(^(""OP"")) ""   "",$P(^(""OP""),U,1)"
 S ZTRTN="EN1^SR61UTL",ZTDESC="Surgery Risk Assessment Retransmission Routine",ZTIO="" S:$G(XPDQUES("POS1")) ZTDTH=XPDQUES("POS1")
 D ^%ZTLOAD
 Q
