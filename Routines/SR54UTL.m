SR54UTL ;BIR/SLM-Transmit missing surgery risk data ; [ 05/24/96  8:00 AM ]
 ;;3.0; Surgery ;**54**;24 Jun 93
 ;;site-id^divison^ien^airway index^airway trauma^major/minor^in/out patient status^race^death unrelated/related^occurrence date^occurrence date^occ...
EN1 S SITE=+$P($$SITE^SROVAR,"^",3)
 S (SRDFN,SRI)=0 F  S SRDFN=$O(^SRF("ARS","N","T",SRDFN)) Q:'SRDFN  S SRTN=0 F  S SRTN=$O(^SRF("ARS","N","T",SRDFN,SRTN)) Q:'SRTN  I $P(^SRF(SRTN,"RA"),"^",6)="Y" S SROPD=$E($P(^SRF(SRTN,0),"^",9),1,7) I SROPD'<"2950901" D
 .S (SRDIV,SRAI,SRAT,SRACE,SRDEATH)=""
 .S SRDIV=$P($G(^SRF(SRTN,8)),U),SRAI=$P($G(^SRF(SRTN,.3)),"^",9),SRMJN=$P(^SRF(SRTN,0),"^",3),SRMJN=$S(SRMJN="J":"J",SRMJN="N":"N",1:"")
 .S SRSTATUS=$P(^SRF(SRTN,0),"^",12),SRSTATUS=$S(SRSTATUS="I":"I",SRSTATUS="O":"O",1:""),SRACE=$P(^SRF(SRTN,208),"^",10),SRDEATH=$P($G(^SRF(SRTN,.4)),"^",7)
 .K SRTECH,SRZ S SRT=0 F  S SRT=$O(^SRF(SRTN,6,SRT)) Q:'SRT  D ^SROPRIN Q:$D(SRZ)
 .I $D(SRTECH) S SRAT=$P(^SRF(SRTN,6,SRT,0),"^",14)
 .I '$D(SRTECH) S SRAT=""
 .S SRSDATE=SROPD D OCC^SROAUTL0 F I=1:1:26 S SROC(I)=$TR(SROC(I)," ","")
 .S SRLINE(1)=SITE_"^"_SRDIV_"^"_SRTN_"^"_SRAI_"^"_SRAT_"^"_SRMJN_"^"_SRSTATUS_"^"_SRACE_"^"_SRDEATH_"^"_SROC(1)_"^"_SROC(2)_"^"_SROC(25)_"^"_SROC(4)_"^"_SROC(6)_"^"_SROC(7)_"^"_SROC(5)_"^"_SROC(9)_"^"_SROC(10)_"^"_SROC(11)_"^"
 .S SRLINE(1)=SRLINE(1)_SROC(19)_"^"_SROC(13)_"^"_SROC(14)_"^"_SROC(15)_"^"_SROC(22)_"^"_SROC(17)_"^"_SROC(18)_"^"_SROC(21)_"^"_SROC(23)_"^"_SROC(24)_"^"_SROC(26)_"^"_SROC(3)_"^"_SROC(8)_"^"_SROC(16)_"^"_SROC(12)_"^"_SROC(20)
 .S SRI=SRI+1,^TMP("SRA",$J,SRI)=SRLINE(1)
ACK ;
 S XMSUB="SURGERY RISK ASSESSMENT RETRANSMISSION COMPLETE FOR VAMC-"_SITE,XMDUZ=^XMB("NETNAME")
 S XMY("G.SURGERY DEVELOPMENT TEAM@ISC-BIRM.VA.GOV")=""
 S XMTEXT="^TMP(""SRA"",$J," N I D ^XMD
 K SRDIV,SRAI,SRAT,SRACE,^TMP("SRA"),SRTN,SITE
 S ZTREQ="@"
 Q
POST ; postinit action for SR*3*54
 S ^DD(130,0,"ID",26)="W:$D(^(""OP"")) ""   "",$P(^(""OP""),U,1)"
 S ZTRTN="EN1^SR54UTL",ZTDESC="Surgery Risk Assessment Retransmission Routine",ZTIO="" S:$G(XPDQUES("POS1")) ZTDTH=XPDQUES("POS1")
 D ^%ZTLOAD
 Q
