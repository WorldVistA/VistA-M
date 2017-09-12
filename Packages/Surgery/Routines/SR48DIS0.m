SR48DIS0 ;BIR/ADM-Install Disposition Data Global ; [ 09/19/96  8:41 PM ]
 ;;3.0; Surgery ;**48**;24 Jun 93
 Q:$D(^SRO(131.6,0))
 S ^SRO(131.6,0)="SURGERY DISPOSITION^131.6I^9^9"
 S ^SRO(131.6,1,0)="PACU (RECOVERY ROOM)^R"
 S ^SRO(131.6,2,0)="WARD^W"
 S ^SRO(131.6,3,0)="MICU^M"
 S ^SRO(131.6,4,0)="SICU^S"
 S ^SRO(131.6,5,0)="CCU^C"
 S ^SRO(131.6,6,0)="OUTPATIENT^O"
 S ^SRO(131.6,7,0)="STEPDOWN^I"
 S ^SRO(131.6,7,1,0)="^131.63^1^1"
 S ^SRO(131.6,7,1,1,0)="STEP DOWN"
 S ^SRO(131.6,8,0)="MORGUE^D"
 S ^SRO(131.6,8,1,0)="^131.63^1^1"
 S ^SRO(131.6,8,1,1,0)="DEATH"
 S ^SRO(131.6,9,0)="OPERATING ROOM^OR"
 S ^SRO(131.6,"B","CCU",5)=""
 S ^SRO(131.6,"B","MICU",3)=""
 S ^SRO(131.6,"B","MORGUE",8)=""
 S ^SRO(131.6,"B","OPERATING ROOM",9)=""
 S ^SRO(131.6,"B","OUTPATIENT",6)=""
 S ^SRO(131.6,"B","PACU (RECOVERY ROOM)",1)=""
 S ^SRO(131.6,"B","SICU",4)=""
 S ^SRO(131.6,"B","STEPDOWN",7)=""
 S ^SRO(131.6,"B","WARD",2)=""
 S ^SRO(131.6,"C","C",5)=""
 S ^SRO(131.6,"C","D",8)=""
 S ^SRO(131.6,"C","I",7)=""
 S ^SRO(131.6,"C","M",3)=""
 S ^SRO(131.6,"C","O",6)=""
 S ^SRO(131.6,"C","OR",9)=""
 S ^SRO(131.6,"C","R",1)=""
 S ^SRO(131.6,"C","S",4)=""
 S ^SRO(131.6,"C","W",2)=""
 S ^SRO(131.6,"D","DEATH",8)=""
 S ^SRO(131.6,"D","STEP DOWN",7)=""
 Q
POST ; postinit action for SR*3*48
 ; task install notification message
 X ^%ZOSF("UCI") I Y'=^%ZOSF("PROD") G END
 S SRD=^XMB("NETNAME") I $E(SRD,1,3)="ISC"!(SRD["ISC-")!(SRD["ISC.")!(SRD["FORUM") G END
QMSG ; queue install message
 D NOW^%DTC S (SRNOW,ZTDTH)=$E(%,1,12),ZTRTN="MSG^SR48DIS0",ZTSAVE("SRNOW")=SRNOW,ZTDESC="Patch SR*3*48 Install Message",ZTIO="" D ^%ZTLOAD
END K DFN,NOGO,SR,SRD,SRDA,SRMSG,SRTN,SRX,SRY,SRZ,XMSUB,XMY,XMDUZ,XMTEXT
 Q
MSG ; send mail message to national database
 H 20 S SRD=^XMB("NETNAME"),X=0 F  S X=$O(^XPD(9.7,"B","SR*3.0*48",X)) Q:'X  S SRDA=X
 G:'$G(SRDA) END S Z=$G(^XPD(9.7,SRDA,1)),SRZ=$E($P(Z,"^"),1,12),SRY=SRNOW,SRZ=$$FMTE^XLFDT(SRZ),SRY=$$FMTE^XLFDT(SRY)
 K SRMSG S SRMSG(1)="Patch SR*3*48 has been installed at "_SRD_"."
 S SRMSG(2)="Start time: "_SRZ,SRMSG(3)="End time: "_SRY
 S XMSUB="SR*3*48 Installed",XMDUZ=DUZ
 S XMY("G.SR-INSTALL@ISC-BIRM.DOMAIN.EXT")=""
 S XMTEXT="SRMSG(" D ^XMD S ZTREQ="@"
 Q
