RMPREXT ;PHX/HNC-DATA EXTRACT FOR Nppd  ;4/20/1995
 ;;3.0;PROSTHETICS;**12,18,24,64,59,103,106,109,113,126,138**;Feb 09, 1996;Build 11
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;DBIA #4599, Vendor file read 38,39,18.3,8.3
 ;
 ;patch 113 - roll back to 5000 lines
 ;            add count of records to summary message and 
 ;            count by station number to summary total
 ;            add site- to ien, use ~ as data delimiter
 ;            add d1 and d2 flags for EXE parsing tool
 ;
 ;patch 126/hnc - check length, bug in GUI ignores DD field length
 ;
 ;patch 60/hnc - DDC interface, include DDC data fields.
 ;               8/23/2006
 ;
EN ;extract from 660
 N %ZIS,ZTIO,ZTRTN,ZTSK,ZTDESC
 S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) D QUE,HOME^%ZIS Q
PR1 ;refresh amis codes
 D ^RMPREXR
EN1 ;pass dates if needed
 S RMPRSEND=$P(XMRG,"*",5)
 S DIC="^RMPR(660,",DR=".01:100",DIQ(0)="EN"
 S RMPRB=0,RMPRCNT=0,RMPRSUB="B1 ",RMPRRECC=0,COUNT=0
 K ^TMP("RMPR",$J)
 F  S RMPRB=$O(^RMPR(660,"B",RMPRB)) Q:(RMPRB>RMPRDT2)!(RMPRB'>0)  D
 .Q:RMPRB<RMPRDT1
 .;date range check complete
 .;pick up mult records with same date
 .S RMPRA=0
 .F  S RMPRA=$O(^RMPR(660,"B",RMPRB,RMPRA)) Q:RMPRA'>0  D
 ..S RMPRRECC=RMPRRECC+1
 ..S DA=RMPRA,DIQ="RMPR"
 ..S DIC="^RMPR(660,",DR=".01:100",DIQ(0)="EN"
 ..D EN^DIQ1
 ..;verify field length
 ..;Brief Description
 ..I $D(RMPR(660,RMPRA,24,"E")) D
 ...I $L(RMPR(660,RMPRA,24,"E"))>60 S RMPR(660,RMPRA,24,"E")=$E(RMPR(660,RMPRA,24,"E"),1,60)
 ..;Deliver To
 ..I $D(RMPR(660,RMPRA,25,"E")) D
 ...I $L(RMPR(660,RMPRA,25,"E"))>30 S RMPR(660,RMPRA,25,"E")=$E(RMPR(660,RMPRA,25,"E"),1,30)
 ..;Remarks
 ..I $D(RMPR(660,RMPRA,16,"E")) D
 ...I $L(RMPR(660,RMPRA,16,"E"))>60 S RMPR(660,RMPRA,16,"E")=$E(RMPR(660,RMPRA,16,"E"),1,60)
 ..D LINECK
 ..;parse array
 ..S RMPRC=0
 ..F  S RMPRC=$O(RMPR(660,RMPRC)) Q:RMPRC'>0  D TMP
 ;clean up before calling mailman
 K DFN,RMPRFLD,RMPRE,RMPRCNT,DFN,RMPRA,RMPRC,DIQ,DIC,DR,DA,RMPRDT1,RMPRDT2
 S XMSUB="B1-F " D MAIL,EXIT
 Q
LINECK ;check the message line limit (5000)
 I RMPRCNT>5000 S XMSUB=RMPRSUB D MAIL K ^TMP("RMPR",$J) S RMPRCNT=0
 Q
TMP ;format for mailman ^TMP(namespace,$J,counter)=record,field,value
 S RMPRFLD=0
 F  S RMPRFLD=$O(RMPR(660,RMPRC,RMPRFLD)) Q:RMPRFLD'>0  D
 .S RMPRCNT=RMPRCNT+1,RMPRE=0,DFN=0
 .S RMPRE=$O(RMPR(660,RMPRC,RMPRFLD,RMPRE)) Q:RMPRE=""
 .;add station number - to ien
 .S IENSITE=$P($$SITE^VASITE,U,3),IENSITE=IENSITE_"-"
 .;strip the ~ for TEXT file
 .I RMPRFLD'=".01" S ^TMP("RMPR",$J,RMPRCNT)="d2~"_IENSITE_RMPRC_"~"_RMPRFLD_"~"_$TR(RMPR(660,RMPRC,RMPRFLD,RMPRE),"~","/")_U
 .I RMPRFLD=".01" S ^TMP("RMPR",$J,RMPRCNT)="d1~"_IENSITE_RMPRC_"~"_RMPRFLD_"~"_$TR(RMPR(660,RMPRC,RMPRFLD,RMPRE),"~","/")_U
 .;get SSN
 .I RMPRFLD=".02" D
 .  .S DFN=$P(^RMPR(660,RMPRC,0),U,2)
 .  .D DEM^VADPT,ADD^VADPT,SVC^VADPT
 .  .S RMPRCNT=RMPRCNT+1,^TMP("RMPR",$J,RMPRCNT)="d2~"_IENSITE_RMPRC_"~644~"_VA("PID")_U
 .  .;DOB int
 .  .I $G(VADM(3)) S RMPRCNT=RMPRCNT+1,^TMP("RMPR",$J,RMPRCNT)="d2~"_IENSITE_RMPRC_"~664.3~"_$P(VADM(3),U,1)_U
 .  .;DOB ext
 .  .I $G(VADM(3)) S RMPRCNT=RMPRCNT+1,^TMP("RMPR",$J,RMPRCNT)="d2~"_IENSITE_RMPRC_"~664.31~"_$P(VADM(3),U,2)_U
 .  .;Sex, int
 .  .I $G(VADM(5))'="" S RMPRCNT=RMPRCNT+1,^TMP("RMPR",$J,RMPRCNT)="d2~"_IENSITE_RMPRC_"~664.5~"_$P(VADM(5),U,1)_U
 .  .;DOD int
 .  .I $G(VADM(6)) S RMPRCNT=RMPRCNT+1,^TMP("RMPR",$J,RMPRCNT)="d2~"_IENSITE_RMPRC_"~664.6~"_$P(VADM(6),U,1)_U
 .  .;DOD ext
 .  .I $G(VADM(6)) S RMPRCNT=RMPRCNT+1,^TMP("RMPR",$J,RMPRCNT)="d2~"_IENSITE_RMPRC_"~664.61~"_$P(VADM(6),U,2)_U
 .  .;patient zip
 .  .I $G(VAPA(6)) S RMPRCNT=RMPRCNT+1,^TMP("RMPR",$J,RMPRCNT)="d2~"_IENSITE_RMPRC_"~664.62~"_VAPA(6)_U
 .  .;patient county name
 .  .I $G(VAPA(7)) S RMPRCNT=RMPRCNT+1,^TMP("RMPR",$J,RMPRCNT)="d2~"_IENSITE_RMPRC_"~664.63~"_$P(VAPA(7),U,2)_U
 .  .;city
 .  .I $G(VAPA(4)) S RMPRCNT=RMPRCNT+1,^TMP("RMPR",$J,RMPRCNT)="d2~"_IENSITE_RMPRC_"~664.66~"_VAPA(4)_U
 .  .;requestor service
 .  .;O INDICATOR
 .  .I $P($G(VASV(11)),U,1)>0 S RMPRCNT=RMPRCNT+1,^TMP("RMPR",$J,RMPRCNT)="d2~"_IENSITE_RMPRC_"~664.80~"_$P(VASV(11),U,1)_U
 .  .I $P($G(VASV(12)),U,1)>0 S RMPRCNT=RMPRCNT+1,^TMP("RMPR",$J,RMPRCNT)="d2~"_IENSITE_RMPRC_"~664.81~"_$P(VASV(12),U,1)_U
 .  .I $P($G(VASV(13)),U,1)>0 S RMPRCNT=RMPRCNT+1,^TMP("RMPR",$J,RMPRCNT)="d2~"_IENSITE_RMPRC_"~664.82~"_$P(VASV(13),U,1)_U
 .  .K VASV
 .  .;
 .  .;ICN
 .  .S ICN=$$GETICN^MPIF001(DFN)
 .  .I +ICN'=-1 S RMPRCNT=RMPRCNT+1,^TMP("RMPR",$J,RMPRCNT)="d2~"_IENSITE_RMPRC_"~664.64~"_ICN_U
 .  .;CMOR
 .  .S CMOR=$$GETVCCI^MPIF001(DFN)
 .  .I +CMOR'=-1 S RMPRCNT=RMPRCNT+1,^TMP("RMPR",$J,RMPRCNT)="d2~"_IENSITE_RMPRC_"~664.65~"_CMOR_U
 .;vendor info
 .I RMPRFLD=7 D
 ..;N DIC,DR,DA
 ..S DIC="^PRC(440,"
 ..S DA=$P(^RMPR(660,RMPRC,0),U,9)
 ..Q:+DA'>0
 ..S DR="38;39;18.3;8.3",DIQ="TAXID(",DIQ(0)="E"
 ..D EN^DIQ1
 ..S RMPRCNT=RMPRCNT+1,^TMP("RMPR",$J,RMPRCNT)="d2~"_IENSITE_RMPRC_"~664.738~"_TAXID(440,DA,38,"E")_U
 ..S RMPRCNT=RMPRCNT+1,^TMP("RMPR",$J,RMPRCNT)="d2~"_IENSITE_RMPRC_"~664.739~"_TAXID(440,DA,39,"E")_U
 ..S RMPRCNT=RMPRCNT+1,^TMP("RMPR",$J,RMPRCNT)="d2~"_IENSITE_RMPRC_"~664.7183~"_TAXID(440,DA,18.3,"E")_U
 ..S RMPRCNT=RMPRCNT+1,^TMP("RMPR",$J,RMPRCNT)="d2~"_IENSITE_RMPRC_"~664.783~"_TAXID(440,DA,8.3,"E")_U
 ;
 K VA("PID"),RMPR,VADM,VAPA,ICN,CMOR,TAXID
 Q
MAIL ;pack it up and send it off
 S XMTEXT="^TMP(""RMPR"",$J,"
MAILS ;entry point to send summary msg
 S XMDUZ=.5
 S XMY("G.PROSTHETICS@PSAS.MED.VA.GOV")=""
 S XMSUB=XMSUB_" Extract From "_$P($$SITE^VASITE,U,2)
 D ^XMD
 ;keep track of messages sent
 S RMPRM(XMZ)=XMZ_U
 S COUNT=COUNT+1
 Q
QUE ;TaskMan Queue
 S ZTIO=ION_";"_IOST K IO("Q")
 S ZTRTN="PR1^RMPREXT"
 S ZTDESC="Prosthetics National Data Extract"
 K ZTSK D ^%ZTLOAD I $G(ZTSK) U IO(0) W !,"<REQUEST QUEUED>"
 Q
EXIT ;exit point
 ;send summary msg
 S RMPRM(1)="Message Numbers Created Below, Site^Total Record #:"_U_$P($$SITE^VASITE,U,3)_U_$P($$SITE^VASITE,U,2)_U_RMPRRECC_U
 S XMSUB=RMPRSUB_"Summary ",XMTEXT="RMPRM("
 D MAILS
 K ^TMP("RMPR",$J),XMTEXT,XMDUZ,XMY,XMSUB,RMPRM
 ;send message to PCM group to let them know Austin should have all mail.
 S RMPRMM(1)="Site^Total Record # ^ Total Message #:"_U_$P($$SITE^VASITE,U,3)_U_$P($$SITE^VASITE,U,2)_U_RMPRRECC_U_COUNT
 S XMTEXT="RMPRMM("
 S XMSUB="NPPD Summary Update From "_$P($$SITE^VASITE,U,2)
 S XMY("VHACOPSASPIPReport@med.va.gov")=""
 S XMDUZ=.5
 D ^XMD
 K XMTEXT,XMDUZ,XMY,XMSUB,RMPRRECC,COUNT,RMPRMM,RMPRSEND,IENSITE
 Q
 ;
PR2 ;Bundle open obligations on 2319
 S XMDUZ=.5
 S XMY("G.RMPR SERVER")=""
 S XMSUB="Prosthetics Data Extract Open Obligations"
 S RMPRMSG(1)="The National Data Server has been activated today by Prosthetics HQ."
 S RMPRMSG(2)="Data has been collected for all open obligations."
 S RMPRMSG(3)=""
 S RMPRMSG(4)="This was activated by "_$P(XMFROM,"@",1)
 S RMPRMSG(5)=""
 S XMTEXT="RMPRMSG("
 D ^XMD
 K RMPRMSG
 K ^TMP("RMPR",$J)
 S RMPRB=0,RMPRCNT=0,RMPRSUB="B2 "
 S DIC="^RMPR(660,",DR=".01:83",DIQ(0)="EN"
 F  S RMPRB=$O(^RMPR(660,RMPRB)) Q:RMPRB'>0  D
 .I $G(^RMPR(660,RMPRB,0))="" Q
 .S RMPRA=^RMPR(660,RMPRB,0)
 .;delivery date not null
 .Q:$P(RMPRA,U,12)'=""
 .S RMPRX=$P($G(^RMPR(660,RMPRB,1)),U,1)
 .;has an IFCAP transaction number
 .Q:$P(RMPRX,U,1)=""
 .;refresh amis data
 .D
 ..N ITM,TYPE,NEW,REPAIR
 ..S ITM=$P(RMPRA,U,6),TYPE=$P(RMPRA,U,4)
 ..Q:ITM=""
 ..Q:TYPE=""
 ..S NEW=$P($G(^RMPR(661,ITM,0)),U,3)
 ..S REPAIR=$P($G(^RMPR(661,ITM,0)),U,4)
 ..I TYPE="X" S $P(^RMPR(660,RMPRB,"AM"),U,5)=REPAIR,$P(^("AM"),U,9)="" Q
 ..S $P(^RMPR(660,RMPRB,"AM"),U,9)=NEW,$P(^("AM"),U,5)=""
 .;get data
 .S DA=RMPRB,DIQ="RMPR" D EN^DIQ1,LINECK
 .S RMPRC=0
 .F  S RMPRC=$O(RMPR(660,RMPRC)) Q:RMPRC'>0  D LINECK,TMP
 K DFN,RMPRFLD,RMPRC,RMPRA,RMPRB,RMPRX,RMPRCNT,RMPRE,DR,DIC,DIQ,DA
 S XMSUB="B2-F " D MAIL,EXIT
 D ^%ZISC
 Q
 ;END
