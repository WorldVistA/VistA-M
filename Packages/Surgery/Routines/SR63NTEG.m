SR63NTEG ;ISC/XTSUMBLD KERNEL - checksum checker for SR*3*63 ; [ 03/11/97  6:01 AM ]
 ;;3.0; Surgery ;**63**;24 Jun 93
 ;;7.3;February 27, 1997
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4),", by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4
 Q
POST ; postinit action for SR*3*63
 ; task install notification message
 X ^%ZOSF("UCI") I Y'=^%ZOSF("PROD") G END
 S SRD=^XMB("NETNAME") I $E(SRD,1,3)="ISC"!(SRD["ISC-")!(SRD["ISC.")!(SRD["FORUM")!(SRD["TST") G END
QMSG ; queue install message
 D NOW^%DTC S (SRNOW,ZTDTH)=$E(%,1,12),ZTRTN="MSG^SR63NTEG",ZTSAVE("SRNOW")=SRNOW,ZTDESC="Patch SR*3*63 Install Message",ZTIO="" D ^%ZTLOAD
END K SRD,SRNOW
 Q
MSG ; send mail message to national database
 H 20 S SRD=^XMB("NETNAME"),X=0 F  S X=$O(^XPD(9.7,"B","SR*3.0*63",X)) Q:'X  S SRDA=X
 G:'$G(SRDA) END S Z=$G(^XPD(9.7,SRDA,1)),SRZ=$E($P(Z,"^"),1,12),SRY=SRNOW,SRZ=$$FMTE^XLFDT(SRZ),SRY=$$FMTE^XLFDT(SRY)
 K SRMSG S SRMSG(1)="Patch SR*3*63 has been installed at "_SRD_"."
 S SRMSG(2)="Start time: "_SRZ,SRMSG(3)="End time: "_SRY
 S XMSUB="SR*3*63 Installed",XMDUZ=DUZ
 S XMY("G.SR-INSTALL@ISC-BIRM.DOMAIN.EXT")=""
 S XMTEXT="SRMSG(" D ^XMD S ZTREQ="@"
 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
SROACOM ;;11015177
SROAEX ;;11939512
SROALET ;;12202080
SROAOP ;;11502784
SROAOP1 ;;9224911
SROAPCA1 ;;13076237
SROAPRT3 ;;8939450
SROAUTL ;;16245453
SROAUTL0 ;;14573054
SROAUTL2 ;;10114043
SROAUTL3 ;;9279919
SROBTCH ;;2174143
SROCANUP ;;5614462
SRONON1 ;;13612241
SROPR01 ;;9382874
SROPR02 ;;8863555
SROPRPT ;;1376841
SROPRPT1 ;;10129667
SROPRPT2 ;;8546460
SRORAT1 ;;10155202
SRORAT2 ;;6017781
SRORATA ;;4643550
SRORATP ;;5406287
SROSCH ;;10362309
SROSCH1 ;;13144564
