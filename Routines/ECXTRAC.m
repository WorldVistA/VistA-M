ECXTRAC ;ALB/GTS,JAP,BIR/DMA,CML-Package Extracts for DSS ; 7/29/07 12:51pm
 ;;3.0;DSS EXTRACTS;**9,8,14,24,30,33,49,84,105**;Dec 22, 1997;Build 70
 ;Date range, queuing and message sending for package extracts
 ;Input
 ;  ECPACK   printed name of package (e.g. Lab, Prescriptions)
 ;  ECNODE   in file 728 where last date is stored
 ;  ECPIECE  piece of node where last date is stored
 ;  ECRTN    in the form of START^ROUTINE
 ;  ECGRP    name of local mail group to receive summary message
 ;           (MUST BE 1 TO 5 UPPER CASE ALPHA - NO SPACES)
 ;  ECFILE   file number of the local editing file
 ;  ECXLOGIC Fiscal year extract logic to use (optional)
 ;  ECXDATES StartDate^EndDate^DoNotUpdate728 (optional)
 ;Generates
 ;  EC23=2nd and 3rd piece of zero node in local editing file
 ;      =YYMM of end date^pointer to 727
 ;  ECXLOGIC=Fiscal year extract logic to use
 ;
EN ;entry point
 N OUT,CHKFLG
 I '$D(ECNODE) S ECNODE=7
 I '$D(ECHEAD) S ECHEAD=" "
 I $P($G(^ECX(728,1,ECNODE+.1)),U,ECPIECE)]"" D  Q
 .W !!,$C(7),ECPACK," extract is already scheduled to run",!!
 .D PAUSE
 W @IOF,!,"Extract ",ECPACK," Information for DSS",!!
 S:'$D(ECINST) ECINST=+$P(^ECX(728,1,0),U)
 S ECXINST=ECINST
 K ECXDIC S DA=ECINST,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99"
 D EN^DIQ1 S ECINST=$G(ECXDIC(4,DA,99,"I")) K DIC,DIQ,DA,DR,ECXDIC
 ;* get last date for all extracts except prosthetics
 I ECGRP'="PRO" D
 .S ECLDT=$S($D(^ECX(728,1,ECNODE)):$P(^(ECNODE),U,ECPIECE),1:2610624)
 .S:ECLDT="" ECLDT=2610624
 ;* get last date for prosthetics
 I ECGRP="PRO" D
 .N ECXDA1
 .S ECXDA1=$O(^ECX(728,0))
 .I $D(^ECX(728,ECXDA1,1,ECXINST,0)) D
 ..S ECLDT=$P(^ECX(728,ECXDA1,1,ECXINST,0),U,2)
 .I '$D(^ECX(728,ECXDA1,1,ECXINST,0)) D
 ..S DA(1)=ECXDA1
 ..S DIC(0)="L" K ECXDD
 ..D FIELD^DID(728,59,,"SPECIFIER","ECXDD")
 ..S DIC("P")=ECXDD("SPECIFIER") K ECXDD
 ..S DIC="^ECX(728,"_DA(1)_",1,",X=ECXINST,DINUM=X
 ..K DD,DO D FILE^DICN
 ..K DIC,X,DINUM,Y,DA
 ..S ECLDT=2610624
 S X=$G(ECXDATES) S ECSD=$P(X,"^",1),ECED=$P(X,"^",2)
 S OUT=0
 I (ECSD="")!(ECED="") F  S (ECED,ECSD)="" D  Q:OUT
 .K %DT S %DT="AEX",%DT("A")="Starting with Date: " D ^%DT
 .I Y<0 S OUT=1 Q
 .S ECSD=Y
 .K %DT S %DT="AEX",%DT("A")="Ending with Date: " D ^%DT
 .I Y<0 S OUT=1 Q
 .I Y<ECSD D  Q
 ..W !!,"The ending date cannot be earlier than the starting date."
 ..W !,"Please try again.",!!
 .I $E(Y,1,5)'=$E(ECSD,1,5) D  Q
 ..W !!,"Beginning and ending dates must be in the same month and year."
 ..W !,"Please try again.",!!
 .S ECED=Y
 .I ECLDT'<ECSD D  Q
 ..W !!,"The ",ECPACK," information has already been extracted through ",$$FMTE^XLFDT(ECLDT),"."
 ..W !,"Please enter a new date range.",!!
 .S OUT=1
 I ECED]"",ECSD]"" D QUE
 Q
 ;
QUE ;queue extract
 N CHKFLG
 ;if extract is ivp (i.e., file=727.819) and data in the intermediate file use new format
 I ECFILE=727.819 D  Q:CHKFLG
 .S CHKFLG=0
 .S X="PSIVSTAT" X ^%ZOSF("TEST") I '$T Q
 .I '$D(^ECX(728.113,"A")) S CHKFLG=1 D NOIVP Q
 .S DATE=$O(^ECX(728.113,"A",ECED+1),-1) I DATE<ECSD S CHKFLG=1 D NOIVP Q
 .D CHK^ECXDIVIV Q:CHKFLG
 .D CHK2
 .S ECRTN="START^ECXPIVDN",ECVER=7
 I '$D(ECNODE) S ECNODE=7
 I '$D(ECHEAD) S ECHEAD=""
 S ECSDN=$$FMTE^XLFDT(ECSD),ECEDN=$$FMTE^XLFDT(ECED),ECSD1=ECSD-.1
 K ZTSAVE
 F X="ECINST","ECED","ECSD","ECSD1","ECEDN","ECSDN" S ZTSAVE(X)=""
 F X="ECPACK","ECPIECE","ECRTN","ECGRP","ECNODE" S ZTSAVE(X)=""
 F X="ECFILE","ECHEAD","ECVER","ECINST","ECXINST" S ZTSAVE(X)=""
 F X="ECXLOGIC","ECXDATES" S ZTSAVE(X)=""
 S ZTDESC=ECPACK_" EXTRACT: "_ECSDN_" TO "_ECEDN,ZTRTN="START^ECXTRAC",ZTIO=""
 D ^%ZTLOAD
 I $D(ZTSK) D
 .S $P(^ECX(728,1,ECNODE+.1),U,ECPIECE)="R"
 .W !,"Request queued as Task #",ZTSK,".",!
 .D PAUSE
 Q
 ;
NOIVP ;cannot generate ivp message
 W !!,?5,"There does not appear to be any data in the IV EXTRACT DATA"
 W !,?5,"file (#728.113) for the selected date range."
 W !!,?5,"The IVP extract cannot be generated."
 D PAUSE
 Q
 ;
START ; entry when queued
 S QFLG=0
 L +^ECX(727,0) S EC=$P(^ECX(727,0),U,3)+1,$P(^(0),U,3,4)=EC_U_EC L -^ECX(727,0)
 S ^ECX(727,EC,0)=EC_U_DT_U_ECPACK_U_ECSD_U_$E(ECED,1,7)_U_U_DUZ
 S ^ECX(727,EC,"HEAD")=ECHEAD
 S:ECFILE=727.816 ECFILE=727.827 S ^ECX(727,EC,"FILE")=ECFILE
 S ^ECX(727,EC,"GRP")=ECGRP
 I $G(ECXLOGIC)="" S ECXLOGIC=$$FISCAL^ECXUTL1(ECSD)
 S ^ECX(727,EC,"VER")=$G(ECVER)_"^"_ECXLOGIC
 S ^ECX(727,EC,"DIV")=ECXINST
 S DA=EC,DIK="^ECX(727," D IX^DIK K DIK,DA
 S ECRN=0,ECXYM=$$ECXYM^ECXUTL(ECED),EC23=ECXYM_U_EC
 S ECXSTART=$P($$HTE^XLFDT($H),":",1,2),ECXNOW=$H
 ;do specific extract
 D @ECRTN
 ;if task gets stop request, set ztstop and quit
 I QFLG D  Q
 .S $P(^ECX(728,1,ECNODE+.1),U,ECPIECE)="",ZTSTOP=1
 .D QKILL
 .D QMSG
 .D ^ECXKILL
 ;Set last date for extract
 I '$P($G(ECXDATES),"^",3) D
 .;* set last date for all extracts except prosthetics
 .I ECGRP'="PRO" S $P(^ECX(728,1,ECNODE),U,ECPIECE)=$P(ECED,".") Q
 .;* set last date for prosthetics
 .N ECXDA1
 .S ECXDA1=$O(^ECX(728,0))
 .S $P(^ECX(728,ECXDA1,1,ECXINST,0),U,2)=$P(ECED,".")
 S TIME=$P($$HTE^XLFDT($H),":",1,2)
 S $P(^ECX(727,$P(EC23,U,2),0),U,6)=ECRN
 ;set piece 3 and 4 of the zero node
 S ECLAST=$O(^ECX(ECFILE,99999999),-1),ECTOTAL=$P(^ECX(ECFILE,0),U,4)+ECRN,$P(^(0),U,3,4)=ECLAST_U_ECTOTAL K ECLAST,ECTOTAL
 D MSG
 S $P(^ECX(728,1,ECNODE+.1),U,ECPIECE)=""
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
MSG ; send message to mail group 'DSS-ECGRP'
 S XMSUB=ECINST_" - "_ECPACK_" EXTRACT FOR DSS",XMDUZ="DSS SYSTEM"
 K XMY S XMY("G.DSS-"_ECGRP_"@"_^XMB("NETNAME"))=""
 S ECMSG(1,0)="The DSS-"_ECPACK_" extract (#"_$P(EC23,U,2)_") for "_ECSDN
 S ECMSG(2,0)="through "_ECEDN_" was begun on "_$P(ECXSTART,"@")_" at "_$P(ECXSTART,"@",2)
 S ECMSG(3,0)="and completed on "_$P(TIME,"@")_" at "_$P(TIME,"@",2)_"."
 S ECMSG(4,0)=" "
 S ECMSG(5,0)="A total of "_ECRN_" records were written."
 S ECMSG(6,0)=" "
 S ECMSG(7,0)="Extract time was [HH:MM:SS] "_$$HDIFF^XLFDT($H,ECXNOW,3)
 S ECMSG(8,0)=" "
 S X=$E(ECXLOGIC,5) S X=$S((X="")!(X=" "):"",1:"revision "_X_" of ")
 S ECMSG(9,0)="The data was extracted using "_X_"fiscal year "_$E(ECXLOGIC,1,4)_" logic."
 S ECMSG(10,0)=" "
 S XMTEXT="ECMSG("
 D ^XMD
 Q
 ;
QMSG ; send abort message to mail group 'DSS-ECGRP'
 S XMSUB=ECINST_" - "_ECPACK_" EXTRACT FOR DSS",XMDUZ="DSS SYSTEM"
 K XMY S XMY("G.DSS-"_ECGRP_"@"_^XMB("NETNAME"))=""
 S ECMSG(1,0)="The DSS-"_ECPACK_" extract (#"_$P(EC23,U,2)_") for "_ECSDN
 S ECMSG(2,0)="through "_ECEDN_" was begun on "_$P(ECXSTART,"@")_" at "_$P(ECXSTART,"@",2)_"."
 S ECMSG(3,0)=" "
 S ECMSG(4,0)="A user stop request was received by Taskmanager which caused processing"
 S ECMSG(5,0)="to terminate before completion.  Any records which may have been created"
 S ECMSG(6,0)="in file #"_ECFILE_" for this extract have been deleted."
 S ECMSG(7,0)=" "
 S XMTEXT="ECMSG("
 D ^XMD
 Q
 ;
QKILL ;delete records created for any extract stopped at user request
 N ECX,FILE,IEN,DA,DIK
 S FILE="^ECX("_ECFILE_","
 S ECX=$P(EC23,U,2)
 F  S IEN=$O(^ECX(ECFILE,999999999),-1) Q:($P(^ECX(ECFILE,IEN,0),U,3)'=ECX)  D
 .S DIK=FILE,DA=IEN D ^DIK
 Q
 ;
CHK2 ;iv extract check - all active iv rooms to have a division
 S EC=0
 D ALL^PSJ59P5(,"??","ECXIV")
 F  S EC=$O(^TMP($J,"ECXIV",EC)) Q:'EC  I '^(EC,19) D  I CHKFLG D EXIT Q
 .S CHKFLG=$S($G(^TMP($J,"ECXIV",EC,19)):1,$G(^(19))>DT:1,1:0)
 .I CHKFLG D
 ..W !!,"All active IV Rooms in the IV Room file (#59.5) must have a ""DIVISION""",!,"assigned to run this extract!"
 ..W !!,"This information can be entered using the DSS Extract Manager's Maintenance ",!,"option ""Enter/Edit IV Room Division""."
 ..D PAUSE
EXIT K ^TMP($J,"ECXIV")
 Q
 ;
PAUSE ;pause screen
 N DIR,X,Y
 S OUT=0
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .S DIR(0)="E" W ! D ^DIR K DIR
 I 'Y S OUT=1
 W !!
 Q
