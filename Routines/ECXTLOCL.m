ECXTLOCL ;BIR/DMA-Package Extracts for Local Use ; 17 Mar 95 / 1:04 PM
 ;;3.0;DSS EXTRACTS;**8,49**;Dec 22, 1997
EN ;entry point
 ;Queuing and message sending for package extracts for local use
 ;Input ECPACK   printed name of package (e.g. Lab, Prescriptions)
 ;      ECRTN    in the form of START^ROUTINE
 ;      ECGRP    name of local mail group to receive summary message
 ;               (MUST BE 1 TO 5 UPPER CASE ALPHA - NO SPACES)
 ;      ECFILE   file number of the local editing file
 ; generates EC23=2nd and 3rd piece of zero node in local editing file
 ;               =YYMM of end date^pointer to 727
 ;       ECXLOGIC=Fiscal year extract logic to use
 ;
 S EC=$O(^ECX(727.1,"AF",ECFILE,0)),EC=$P($G(^ECX(727.1,EC,0)),U,5) I 'EC G ERROR
 S ECED=$$FMADD^XLFDT(DT,-EC+1),ECSD=$$FMADD^XLFDT(DT,-EC)
 ;look at results for DT-Offset so ECSD=DT-EC
 S ECINST=+$P(^ECX(728,1,0),U) K ECXDIC S DA=ECINST,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99"
 D EN^DIQ1 S ECINST=$G(ECXDIC(4,DA,99,"I")) K DIC,DIQ,DA,DR,ECXDIC
 S ECSDN=$$FMTE^XLFDT(ECSD),ECEDN=$$FMTE^XLFDT(ECED),ECSD1=ECSD-.1
 I '$D(ECXLOGIC) S ECXLOGIC=$$FISCAL^ECXUTL1(ECSD)
 L +^ECX(727,0) S EC=$P(^ECX(727,0),U,3)+1,$P(^(0),U,3,4)=EC_U_EC L -^ECX(727,0)
 S ^ECX(727,EC,0)=EC_U_DT_U_ECPACK_U_ECSD_U_$E(ECED,1,7)
 S ^ECX(727,EC,"HEAD")=ECHEAD
 S ^ECX(727,EC,"FILE")=ECFILE
 S ^ECX(727,EC,"GRP")=ECGRP
 S ^ECX(727,EC,"L")="L"
 S ^ECX(727,EC,"VER")=$G(ECVER)_"^"_ECXLOGIC
 S ^ECX(727,"AC",DT,EC)="",^ECX(727,"AD",ECPACK,EC)=""
 S ECRN=0,EC23=$$ECXYM^ECXUTL(ECED)_U_EC
EXTRACT ;do specific extract
 D @ECRTN
 S TIME=$P($$HTE^XLFDT($H),":",1,2)
 S $P(^ECX(727,$P(EC23,U,2),0),U,6)=ECRN
 S ECLAST=$O(^ECX(ECFILE,999999999),-1),ECTOTAL=$P(^ECX(ECFILE,0),U,4)+ECRN,$P(^(0),U,3,4)=ECLAST_U_ECTOTAL K ECLAST,ECTOTAL
 ;set piece 3 and 4 of the zero node
 ;
MSG ; send message to mail group 'DSS-ECGRP'
 S XMSUB=ECINST_" - "_ECPACK_" EXTRACT FOR DSS",XMDUZ="DSS SYSTEM"
 K XMY S XMY("G.DSS-"_ECGRP_"@"_^XMB("NETNAME"))=""
 S ECMSG(1,0)="The LOCAL USE DSS-"_ECPACK_" extract for "_ECSDN_" through "
 S ECMSG(2,0)=ECEDN_" was completed on "_$P(TIME,"@")_" at "_$P(TIME,"@",2)_". "
 S ECMSG(3,0)=" "
 S ECMSG(4,0)="A total of "_ECRN_" records were written."
 S ECMSG(5,0)=" "
 S X=$E(ECXLOGIC,5) S X=$S((X="")!(X=" "):"",1:"revision "_X_" of ")
 S ECMSG(6,0)="The data was extracted using "_X_"fiscal year "_$E(ECXLOGIC,1,4)_" logic."
 S ECMSG(7,0)=" "
 S XMTEXT="ECMSG(" D ^XMD
 Q
 ;
 Q
ERROR ;local extract not properly setup
 S EC(1)="The local "_ECPACK_" extract was not properly set up",EC(2)="Please review settings in file 727.1 and requeue this extract"
 K XMY S XMY("G.DSS-"_ECGRP_"@"_^XMB("NETNAME"))="",XMTEXT="EC(",XMSUB="Local extract not properly setup",XMDUZ="DSS SYSTEM" D ^XMD
 S ZTREQ="@" Q
