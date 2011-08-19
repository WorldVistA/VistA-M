ECXTRANS ;ALB/GTS,JAP,BIR/DMA-Extract from Local Editing Files and Transmit ; 12/14/04 9:10am
 ;;3.0;DSS EXTRACTS;**2,9,12,8,13,14,23,24,33,49,54,75,71**;Dec 22, 1997
EN ;entry point
 N ECDA,ECRE,ECTMP,ECCHK,ECDIVVR,ECXDIQ,JJ,SS,OUT,DIR,DUOUT
 N DTOUT,DIRUT,DIC,X,Y,ECXLOGIC,ECSD,FODMN
 S ECXQUEUE=$P($G(^ECX(728,1,"QUEUE")),"^",1)
 I ECXQUEUE'?1"DM"1U D  Q
 .W !,"You have not defined a proper transmission queue"
 .W !,"for entry number 1 in the DSS EXTRACTS file (#728)."
 .W !,"No transmission allowed."
 .D PAUSE
 ;** check divisions for transmission
 S ECCHK=$$DIV4^XUSER(.ECTMP,DUZ)
 I 'ECCHK D  Q
 .W !,"You do not have any divisions defined in your user set up and cannot transmit."
 .S DIR(0)="FAO^1:1",DIR("A")="Hit Return to continue." D ^DIR K DIR,X,Y
 W !!,"Your user setup will only allow you to transmit extracts from the"
 W !,"following divisions:",!
 S ECDIVVR=""
 F  S ECDIVVR=$O(ECTMP(ECDIVVR)) Q:'(+ECDIVVR)  D
 .K ECXDIC S DA=ECDIVVR,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01"
 .D EN^DIQ1 W !,"   ",$G(ECXDIC(4,DA,.01,"I")) K DIC,DIQ,DA,DR,ECXDIC
 W !!,"If you can't select an extract, it is probably from another division.",!
 D PAUSE Q:OUT
AGAIN S ECRE="",DIC="^ECX(727,",DIC(0)="AEQM"
 S DIC("A")="Transmit which extract: "
 S DIC("S")="I '$D(^ECX(727,+Y,""L"")),'$D(^ECX(727,+Y,""PURG"")),$D(ECTMP(+$P($G(^ECX(727,+Y,""DIV"")),U,1)))"
 D ^DIC
 I Y<0 W !! Q
 ;get data on extract
 S DR="1;2;3;4;5;6;14;15",(ECDA,DA)=+Y,DIQ(0)="IE",DIQ="ECXDIQ" D EN^DIQ1
 I ECXDIQ(727,ECDA,14,"I")="" D
 .S ECXDIQ(727,ECDA,14,"I")=$$FISCAL^ECXUTL1(ECXDIQ(727,ECDA,3,"I"))
 .S ECXDIQ(727,ECDA,14,"E")=ECXDIQ(727,ECDA,14,"I")
 S ECXLOGIC=ECXDIQ(727,ECDA,14,"I")
 S ECSD=ECXDIQ(727,ECDA,3,"I")
 W !!,ECXDIQ(727,ECDA,6,"E")_" Extract (#"_ECDA_")",?42,"Records:    ",ECXDIQ(727,ECDA,5,"E")
 W !,"Generated on: ",ECXDIQ(727,ECDA,1,"E"),?42,"Start date: ",ECXDIQ(727,ECDA,3,"E")
 W !,"Division:     ",$E(ECXDIQ(727,ECDA,15,"E"),1,26),?42,"End date:   ",ECXDIQ(727,ECDA,4,"E")
 S X=$E(ECXDIQ(727,ECDA,14,"I"),5) S X=$S((X="")!(X=" "):"",1:"revision "_X_" of ")
 W !!,"The data was extracted using "_X_"fiscal year "_$E(ECXDIQ(727,ECDA,14,"I"),1,4)_" logic."
 W !!,"MailMan transmission of the "_ECXDIQ(727,ECDA,2,"E")_" extract is set to a"
 W !,"limit of 131,000 bytes per message.  Each extract record ends with a ^~."
 I $G(^ECX(727,ECDA,"TR")) S ECX=^("TR") D  Q:OUT
 .S OUT=0
 .W !!,"This extract was transmitted on ",$TR($$FMTE^XLFDT(ECX,"5DF")," ","0")
 .K ECX S DIR(0)="Y",DIR("A")="Do you want to retransmit " D ^DIR K DIR
 .I 'Y S OUT=1 Q
 .K ^ECX(727,ECDA,"TR")
 .S ECRE="re"
 S ECTYPE=$P(^ECX(727,ECDA,0),U,3),ECIEN=+$O(^ECX(727.1,"AC",ECTYPE,0))
 S ECPIECE=$P($G(^ECX(727.1,ECIEN,0)),U,10)
 I ECPIECE>0,$P($G(^ECX(728,1,7.1)),U,ECPIECE)]"" D  Q
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL("An "_ECTYPE_" Extract is currently running or scheduled to run.")
 .D MES^XPDUTL("Please wait until that job has completed before attempting")
 .D MES^XPDUTL("this transmission.")
 .D MES^XPDUTL(" ")
 .D PAUSE
 S ZTSK=$G(^ECX(727,ECDA,"Q"))
 I ZTSK D STAT^%ZTLOAD I ZTSK(0) I ZTSK(1)<3 D  Q
 .W !!,"Task ",ZTSK," is already queued to transmit this extract."
 .K ZTSK
 .D PAUSE
 S FODMN=$$FODMN()
 ;Field office reminder
 I FODMN D
 .W !
 .W !,"** This extract is being sent from a field office domain.  **"
 .W !,"** Extract message(s) will only be delivered to you and    **"
 .W !,"** will be placed into your 'DSSXMIT' mail basket.         **"
 .W !
 .;Ensure user has a DSSXMIT mail basket
 .N TMPARR
 .D LISTBSKT^XMXAPIB(DUZ,,,,"DSSXMIT","TMPARR")
 .I '$D(TMPARR("XMLIST","BSKT","DSSXMIT")) D
 ..;Create DSSXMIT basket
 ..N IEN,XMERR
 ..D CRE8BSKT^XMXAPIB(DUZ,"DSSXMIT",.IEN)
 ..K ^TMP("XMERR",$J)
 ;Test queue clearance
 ;I 'FODMN I (ECXLOGIC'=$$FISCAL^ECXUTL1(ECSD))!((ECXLOGIC>$$FISCAL^ECXUTL1(DT))!(ECXLOGIC=$$FISCAL^ECXUTL1(DT))) D  Q:OUT
 ;.S OUT=0
 ;.K DIR
 ;.S DIR(0)="Y"
 ;.S DIR("A",1)="** This extract will be transmitted to the AAC test queue **"
 ;.S DIR("A")="Do you want to continue "
 ;.W !! D ^DIR
 ;.I 'Y S OUT=1 Q
 ;.S ECXQUEUE=$P($G(^ECX(728,1,"QUEUE")),"^",2)
 ;.S:ECXQUEUE="" ECXQUEUE="DMT"
 S ZTSAVE("ECDA")="",ZTSAVE("ECXQUEUE")="",ZTSAVE("ECRE")=""
 S ZTRTN="START^ECXTRANS",ZTIO=""
 S ZTDESC="Transmission of extract # "_ECDA
 W !! D ^%ZTLOAD
 I $D(ZTSK) D
 .W !,"Request queued as Task #",ZTSK,"."
 .S ^ECX(727,ECDA,"Q")=ZTSK K ZTSK
 .D PAUSE
 Q
 ; entry point for task
START N DA,DIC,DIQ,DR,ECAR1,ECAR2,ECC1,ECC2,ECED,ECGPR,ECF,ECGRP,ECHEAD,ECINST
 N ECMAX,ECMAXR,ECMSN,ECPACK,ECSIZ,ECVER,ECXDIC,I,J,EXDT
 N STR,STRCNT,X,ECSD,ECXLOGIC
 S:$P(^ECX(727,ECDA,0),U,3)'="Prosthetics" ECINST=$P(^ECX(728,1,0),U)
 S:$P(^ECX(727,ECDA,0),U,3)="Prosthetics" ECINST=$P(^("DIV"),U)
 S DA=ECINST,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99"
 D EN^DIQ1 S ECINST=$G(ECXDIC(4,DA,99,"I"))
 S ECF=^ECX(727,ECDA,"FILE"),ECHEAD=^("HEAD"),ECGRP=^("GRP")
 S X=^(0),ECPACK=$P(X,U,3),ECSD=$P(X,U,4),ECED=$P(X,U,5)
 S X=$G(^("VER")),ECVER=$P(X,"^",1),ECXLOGIC=$P(X,"^",2)
 S:'ECVER ECVER=1 S ECVER=$$RJ^XLFSTR(ECVER,3,0)
 I ECXLOGIC="" S ECXLOGIC=$$FISCAL^ECXUTL1(ECSD)
 S ECXLOGIC=$$PAD^ECXUTL1(ECXLOGIC,5,"B"," ")
 I ECPACK["(setup)" S ECXQUEUE="DMU"
 K ^TMP($J)
 S ECHD(1)=ECINST_ECHEAD_$$ECXYM^ECXUTL(ECED)_ECVER_ECXLOGIC
 S ECMAX=130000,ECMAXR=250,ECLN=2,ECMSN=1,(ECRN,ECSIZ)=0,J=""
 F  S J=$O(^ECX(ECF,"AC",ECDA,J)) Q:('J)  D
 .M ECAR1=^ECX(ECF,J) S (ECAR2,ECC2)=1,(ECAR2(ECC2),ECC1)=""
 .F  S ECC1=$O(ECAR1(ECC1)) Q:ECC1=""  D
 ..S:ECC1=0 ECAR1(ECC1)=$P(ECAR1(ECC1),"^",4,999)
 ..S ECAR2(ECC2)=ECAR2(ECC2)_ECAR1(ECC1) I $L(ECAR2(ECC2))>ECMAXR D
 ...F I=ECMAXR:-1:1 Q:$E(ECAR2(ECC2),I)="^"
 ...S (X,ECAR2)=ECAR2+1,ECAR2(X)=$E(ECAR2(ECC2),I+1,$L(ECAR2(ECC2)))
 ...S ECAR2(ECC2)=$E(ECAR2(ECC2),1,I),ECC2=X
 .S ECAR2(ECC2)=ECAR2(ECC2)_"^~",ECRN=ECRN+1,X=""
 .F  S X=$O(ECAR2(X)) Q:X=""  D
 ..S ^TMP($J,ECMSN,ECLN,0)=ECAR2(X),ECLN=ECLN+1,ECSIZ=ECSIZ+$L(ECAR2(X))
 .K ECAR1,ECAR2
 .I (ECSIZ>ECMAX),($O(^ECX(ECF,"AC",ECDA,J))) D
 ..S ECLN=2,ECMSN=ECMSN+1,ECSIZ=0
 ;quit if user stopped task
 I $$S^%ZTLOAD D CLEAN Q
 ;generate mailman messages to aac
 S ECXLNCNT=9,(ECXXMZ,STRCNT)=0,STR=""
 F ECMS=1:1:ECMSN D
 .D SEND(.ECXXMZ)
 .S STR=STR_$$RJ^XLFSTR(ECXXMZ,18," "),STRCNT=STRCNT+1 I STRCNT=4 D
 ..S ^TMP($J,"LOC",ECXLNCNT,0)=STR,ECXLNCNT=ECXLNCNT+1
 ..S STR="",STRCNT=0
 I STR]"" S ^TMP($J,"LOC",ECXLNCNT,0)=STR
 ;send msg to local dss grp
 D SENDLOC,CLEAN
 Q
 ;
SEND(ECXXMZ) ;send individual messages
 N ECXDD,DA,DIC,DIE,DINUM,X,Y,Z,XMDUZ,XMTEXT,XMSUB,XMY,XMZ,FODMN
 S XMSUB="("_ECGRP_") "_ECINST_" - "_ECPACK_" DSS EXTRACT, MESSAGE "_ECMS_" OF "_ECMSN
 S XMDUZ="DSS SYSTEM",^TMP($J,ECMS,1,0)=ECHD(1)
 S XMY("XXX@Q-"_ECXQUEUE_".VA.GOV")=""
 ;Send extracts done at field offices to user instead of AAC
 S FODMN=$$FODMN()
 I FODMN D
 .K XMY
 .S XMY(DUZ)=""
 S XMTEXT="^TMP($J,ECMS,"
 D ^XMD
 S ECXXMZ=XMZ
 ;store msg# in extract log
 D FIELD^DID(727,301,"","SPECIFIER","ECXDD")
 S DA(1)=ECDA,DIC(0)="L",DIC("P")=ECXDD("SPECIFIER")
 S DIC="^ECX(727,"_DA(1)_",1,",X=XMZ,DINUM=X
 K DD,DO D FILE^DICN
 ;Move message to DSSXMIT basket if sending from field office
 I FODMN D
 .N XMERR
 .D MOVEMSG^XMXAPI(DUZ,,XMZ,"DSSXMIT",.X)
 .K ^TMP("XMERR",$J)
 Q
 ;
SENDLOC ; send message to mail group 'DSS-ECGRP'
 S TIME=$P($$HTE^XLFDT($H),":",1,2)
 S XMSUB=ECINST_" - "_ECPACK_" EXTRACT FOR DSS",XMDUZ="DSS SYSTEM"
 K XMY S XMY(DUZ)="",XMY("G.DSS-"_ECGRP_"@"_^XMB("NETNAME"))=""
 S ^TMP($J,"LOC",1,0)="The DSS "_ECPACK_" ("_ECHEAD_") extract, #"_ECDA_","
 S ^TMP($J,"LOC",2,0)="was "_ECRE_"transmitted on "_$P(TIME,"@")_" at "_$P(TIME,"@",2)_". "
 S ^TMP($J,"LOC",3,0)=" "
 S ^TMP($J,"LOC",4,0)="Maximum number of Bytes (characters) per message: 131,000 "
 S ^TMP($J,"LOC",5,0)=" "
 S ^TMP($J,"LOC",6,0)="A total of "_ECRN_" records were written."
 S ^TMP($J,"LOC",7,0)="A total of "_ECMSN_" messages were sent."
 S ^TMP($J,"LOC",8,0)="    Message numbers :"
 S XMTEXT="^TMP($J,""LOC"","
 D ^XMD
 S ^ECX(727,ECDA,"TR")=DT
 Q
 ;
CLEAN ;clean-up
 S ZTREQ="@"
 K ^TMP($J),^ECX(727,ECDA,"Q"),XMDUZ,XMTEXT,XMSUB,XMY,XMZ
 K ECDA,ECRE,ECTMP,ECCHK,ECDIVVR,ECXDIQ,ECXMAX,ECXMSG
 D ^ECXKILL
 I $$S^%ZTLOAD K ZTREQ S ZTSTOP=1
 Q
 ;
PAUSE ;pause screen
 S OUT=0
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .K DIR S DIR(0)="E" W ! D ^DIR K DIR
 I 'Y S OUT=1
 W !!
 Q
 ;
FODMN(DOMAIN)   ;Is domain a field office domain
 ;Input : DOMAIN - Domain name to check
 ;               - Default value pulled from ^XMB("NETNAME")
 ;Output: 1 = Yes  /  0 = No
 ;
 N X,SUB,OUT
 S DOMAIN=$G(DOMAIN)
 S:(DOMAIN="") DOMAIN=$G(^XMB("NETNAME"))
 S OUT=0
 F X=1:1:$L(DOMAIN,".") D  Q:OUT
 .S SUB=$P(DOMAIN,".",X)
 .I ($E(SUB,1,3)="FO-")!($E(SUB,1,4)="ISC-") S OUT=1
 Q OUT
