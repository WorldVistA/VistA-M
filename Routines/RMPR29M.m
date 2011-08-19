RMPR29M ;PHX/JLT-E/MAIL FOR 2529-3 ACTION [4/14/95]
 ;;3.0;PROSTHETICS;;Feb 09, 1996
CA21(RDA,PDA) ;CANCEL 2421 MESSAGE FOR ^RMPR(664.1,RDA) AND ^RMPR(664,PDA)
 ;CALLED FROM RMPR29C Cancel a 2529-3
 ;VARIABLES REQUIRED: RDA- ENTRY NUMBER IN FILE 664.1
 ;                    PDA - ENTRY NUMBER IN FILE 664
 ;                    RMPRWO - WORK ORDER
 ;          SET: XMTEXT - TEXT FOR MAIL MESSAGE.
 Q:'$D(^RMPR(664.1,RDA,0))
 N RMPRWO,RMPRREF
 S RMPRWO=$P(^RMPR(664.1,RDA,0),U,13)
 ;rmprref is the reference number ot ifcap
 S RMPRREF=$P($G(^RMPR(664,PDA,0)),U,7)
 ;quit if the purchase has been cancelled or closed-out already
 I $D(^RMPR(664,PDA,0)),($P(^(0),8,0)!($P(^(0),U,5))) Q
 ;send message
 K XMY
 I RMPRREF'="" S XMSUB="Request to Cancel Prosthetics Purchase "_RMPRREF,RTX(1)="Work Order # "_RMPRWO_" has been Canceled.",RTX(2)="Please take action on "_RMPRREF_"."
 E  S XMSUB="2421 Request for Work Order # "_RMPRWO_" has been Canceled",RTX(1)="2421 Request for Work Order # "_RMPRWO_" has been Canceled"
 S RTX(3)="BY: "_$$EMP^RMPR31U(DUZ)
 ;get cancellation remarks from the 2529-3
 F RT=0:0 S RT=$O(^RMPR(664.1,RDA,4,RT)) Q:RT'>0  I $D(^(RT,0)) S RTX(RT+3)=^(0)
 ;
 D ADM,SUP
 I $D(XMY) S XMTEXT="RTX(" D ^XMD K XMY,RTX
 Q
 ;
IRQ ;SEND 2421 REQUEST NOTIFICATION
 Q:'$D(^RMPR(664.1,RMPRDA,0))  N RMPRWO S RMPRWO=$P(^RMPR(664.1,RMPRDA,0),U,13) K XMY
 S XMSUB="2421 Request for Work Order # "_RMPRWO_" has been initiated",RTX(1)="2421 Request for Work Order # "_RMPRWO_" has been intiated"
 S RTX(2)="BY: "_$$EMP^RMPR31U(DUZ)
 D ADM,SUP I $D(XMY) S XMTEXT="RTX(" D ^XMD K XMY,RTX
 Q
ADM ;MAKE HOLDERS OF 'RMPR LAB ADMIN' KEY RECEIVER OF MESSAGE.
 F RT=0:0 S RT=$O(^XUSEC("RMPR LAB ADMIN",RT)) Q:RT'>0  S XMY(RT)=""
 Q
SUP ;MAKE HOLDERS OF 'RMPR LAB SUPERVISOR' KEY RECEIVERS OF MESSAGE ALSO.
 F RT=0:0 S RT=$O(^XUSEC("RMPR LAB SUPERVISOR",RT)) Q:RT'>0  S XMY(RT)=""
 Q
RTM ;RETURN 2529-3 TO LAB
 ;CALLED BY RMPR29C
 ;VARIABLES REQUIRED - RMPRDA ENTRY NUMBER IN FIRL 664.1
 N PEMP,RMPRWO S PEMP=$P(^RMPR(664.1,RMPRDA,0),U,16),RMPRWO=$P(^(0),U,13) I +PEMP>0 S XMY(PEMP)=""
 F RI=0:0 S RI=$O(^RMPR(664.1,RMPRDA,2,RI)) Q:RI'>0  I $D(^(RI,0)) S RDA=^(0),RA=$P(RDA,U,5) D
 .F DA=0:0 S DA=$O(^RMPR(664.3,"C",RA,DA)) Q:DA'>0  I $D(^RMPR(664.3,DA)) F RU=0:0 S RU=$O(^RMPR(664.3,DA,1,RU)) Q:RU'>0  I $D(^(RU,0)) S PEMP=$P(^(0),U) I PEMP>0 S XMY(PEMP)=""
 S XMSUB="Work Order # "_RMPRWO_" Returned to Lab",RTX(1)=XMSUB,RTX(2)="BY: "_$$EMP^RMPR31U(DUZ)
 F RR=0:0 S RR=$O(^RMPR(664.1,RMPRDA,6,RR)) Q:RR'>0  I $D(^(RR,0)) S RTX(RR+2)=^(0)
 D SUP I $D(XMY) S XMTEXT="RTX(" D ^XMD K XMY,RTX
 Q
CA0(RDA,PDA) ;CANCEL 2421 OBLIGATION
 Q:'$D(^RMPR(664.1,RDA,0))  N RMPRWO,RMPRREF S RMPRWO=$P(^RMPR(664.1,RDA,0),U,13),RMPRREF=$P($G(^RMPR(664,PDA,0)),U,7) K XMY
 S XMSUB="2421 Request "_RMPRREF_" for Work Order # "_RMPRWO_" has been Canceled",RTX(1)="2421 Request "_RMPRREF_" for Work Order # "_RMPRWO_" has been Canceled"
 S RTX(2)="BY: "_$$EMP^RMPR31U(DUZ)
 S PEMP=$P(^RMPR(664.1,RDA,0),U,16) I +PEMP>0 S XMY(PEMP)=""
 F RI=0:0 S RI=$O(^RMPR(664.1,RDA,2,RI)) Q:RI'>0  I $D(^(RI,0)) S RDA=^(0),RA=$P(RDA,U,5) D
 .F DA=0:0 S DA=$O(^RMPR(664.3,"C",RA,DA)) Q:DA'>0  I $D(^RMPR(664.3,DA)) F RU=0:0 S RU=$O(^RMPR(664.3,DA,1,RU)) Q:RU'>0  I $D(^(RU,0)) S PEMP=$P(^(0),U) I PEMP>0 S XMY(PEMP)=""
 D SUP I $D(XMY) S XMTEXT="RTX(" D ^XMD K XMY,RTX
 Q
DA0(RDA,PDA) ;DELIVER 2421
 Q:'$D(^RMPR(664.1,RDA,0))  N RMPRWO,RMPRREF S RMPRWO=$P(^RMPR(664.1,RDA,0),U,13),RMPRREF=$P($G(^RMPR(664,PDA,0)),U,7) K XMY
 S XMSUB="2421 Request "_RMPRREF_" for Work Order # "_RMPRWO_" has been Delivered"
 S RTX(1)="The 2421 Request "_RMPRREF_"has been closed out,"
 S RTX(2)="by "_$$EMP^RMPR31U(DUZ)_"."
 S RTX(3)=" "
 S RTX(4)="This is associated with Work Order # "_RMPRWO_","
 S RTX(5)="assigned to technician "_$P(^VA(200,$P(^RMPR(664.1,RDA,0),U,16),0),U,1)_"."
 S PEMP=$P(^RMPR(664.1,RDA,0),U,16) I +PEMP>0 S XMY(PEMP)=""
 F RI=0:0 S RI=$O(^RMPR(664.1,RDA,2,RI)) Q:RI'>0  I $D(^(RI,0)) S RDA=^(0),RA=$P(RDA,U,5) D
 .F DA=0:0 S DA=$O(^RMPR(664.3,"C",RA,DA)) Q:DA'>0  I $D(^RMPR(664.3,DA)) F RU=0:0 S RU=$O(^RMPR(664.3,DA,1,RU)) Q:RU'>0  I $D(^(RU,0)) S PEMP=$P(^(0),U) I PEMP>0 S XMY(PEMP)=""
 D SUP I $D(XMY) S XMTEXT="RTX(" D ^XMD K XMY,RTX
 Q
DEL(PDA) ;DELETED 2421 REQUEST
 Q:('$D(^RMPR(664,PDA,0)))  K XMY N RMPRWO S RMPRWO=$P($G(^RMPR(664.2,+$P(^(0),U,15),0)),U) I $P(^RMPR(664,PDA,0),U,16) S XMY($P(^(0),U,16))=""
 S DIE="^RMPR(664,",DA=RMPRA,DR="24" D ^DIE S XMSUB="2421 Request for Work Order # "_RMPRWO_" Has been Deleted",RTX(1)=XMSUB,RTX(2)="BY: "_$$EMP^RMPR31U(DUZ)
 F RW=0:0 S RW=$O(^RMPR(664,PDA,4,RW)) Q:RW'>0  I $D(^(RW,0)) S RTX(RW+3)=^(0)
 D SUP I $D(XMY) S XMTEXT="RTX(" D ^XMD K XMY,RTX
 Q
SLK ;SETUP DIC("S") FOR LABOR HOURS
 ;see internal notes
 ;CALLED FROM RMPR29B
 ;VARIABLES REQUIRED: + Y
 S DIC("S")="I $P(^RMPR(664.3,+Y,0),U,2)=DA660",DIC("W")="F ZI=0:0 S ZI=$O(^RMPR(664.3,+Y,1,ZI)) Q:+ZI'>0  I $D(^(ZI,0)) W ?40,$$EMP^RMPR31U($P(^(0),U)) I $O(^RMPR(664.3,+Y,1,ZI)) W !",DLAYGO=664.3,DIC="^RMPR(664.3,",DIC(0)="QML" Q
 Q
PAP ;PURCHASE APPROVAL
 Q
 ;N RMPR90I
 ;D DIV4^RMPRSIT
 ;I '$D(^XUSEC("RMPRSUPERVISOR",DUZ)) Q
 ;S CNT=0 S RMPR90I=0 F  S RMPR90I=$O(^RMPR(664,"AP",RMPR("STA"),RMPR90I)) Q:RMPR90I'>0  S CNT=CNT+1
 ;I +CNT W !!,?5,$C(7),"There "_$S(CNT>1:"are ",1:"is ")_CNT_" Purchase Request(s) Pending Approval"
 ;Q
