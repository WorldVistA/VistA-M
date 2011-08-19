ECXDEFIN ;ALB/JAP,BIR/DMA-Define Extract Formats for Auto Queuing ; 17 Mar 95 / 9:55 AM
 ;;3.0;DSS EXTRACTS;**24**;Dec 22, 1997
EN ;entry point from option
 N OUT,DIC,DIR,DIQ,DIRUT,DTOUT,DUOUT,DA,DR,X,Y,J,JJ
 D MES^XPDUTL(" ")
 D MES^XPDUTL("This option allows you to queue the generation of a specific DSS extract.")
 D MES^XPDUTL("The extract will then be automatically requeued to run next month and")
 D MES^XPDUTL("each subsequent month until the end of the fiscal year.  It will be")
 D MES^XPDUTL("requeued to run on the same day of each month at the same time of day.")
 D MES^XPDUTL(" ")
 S DIC="727.1",DIC(0)="AEQLMZ",ECF=0 D ^DIC
 Q:Y<0  Q:$D(DTOUT)  Q:$D(DUOUT)
 S (DA,ECDA)=+Y,ECDATA=Y(0),ECROU=^ECX(727.1,ECDA,"ROU"),X="SETUP^"_ECROU D @X
 I '$D(ECNODE) S ECNODE=7
 ;don't allow setup if more than 1 primary prosthetics division
 I ECGRP="PRO" D  Q:OUT>1
 .S OUT=0,J=0
 .S ECXDA1=$O(^ECX(728,0))
 .F  S J=$O(^ECX(728,ECXDA1,1,J)) Q:'J  I $D(^ECX(728,ECXDA1,1,J,0)) S OUT=OUT+1
 .I OUT>1 D
 ..D MES^XPDUTL(" ")
 ..D MES^XPDUTL("This DSS site is responsible for Prosthetics data from")
 ..D MES^XPDUTL("more than one Primary Prosthetics Division.  Therefore,")
 ..D MES^XPDUTL("the PRO extract may not be setup for automatic requeue.")
 ..D MES^XPDUTL(" ")
 ..D MES^XPDUTL("Please use the Prosthetics Extract option on the Package")
 ..D MES^XPDUTL("Extracts menu to generate the monthly PRO extract for each")
 ..D MES^XPDUTL("Primary Prosthetics Division.  Exiting...")
 ..D MES^XPDUTL(" ")
 .I $E(IOST)="C" D
 ..S SS=22-$Y F JJ=1:1:SS W !
 ..S DIR(0)="E" W ! D ^DIR K DIR
 ;don't allow setup if extract has never been run or if 1st extract of fiscal year
 I ECGRP'="PRO" D
 .S ECLDT=$P($G(^ECX(728,1,ECNODE)),U,ECPIECE)
 I ECGRP="PRO" D
 .S ECLDT=""
 .S ECXDA1=$O(^ECX(728,0))
 .I $D(^ECX(728,ECXDA1,1,ECXINST,0)) S ECLDT=$P(^ECX(728,ECXDA1,1,ECXINST,0),U,2)
 I ECLDT="" D MSG Q
 S X=$$CYFY^ECXUTL1(DT)
 I ECLDT=$$FMADD^XLFDT($P(X,U,3),-1) D MSG Q
 ;check if extract already queued to run
 I $P(ECDATA,"^",6) D  Q
 .F J=1:1 S X=$P($T(WARN+J),";",3,300) Q:X="QUIT"  W !,?5,X
 .S DIR(0)="YA",DIR("A")="Do you wish to proceed? ",DIR("B")="N" K DIRUT,DUOUT,DTOUT
 .D ^DIR K DIR
 .I Y D QUEUE
 D QUEUE
 Q
 ;
QUEUE ;queue thru taskmanager
 N ZTIO,ZTRTN,ZTDESC,ZTDTH,OUT,MONTH
 D MES^XPDUTL(" ")
 S OUT=0
 F  D  Q:OUT
 .D MES^XPDUTL(" ")
 .S %DT="AEXR",%DT(0)=$$NOW^XLFDT+.0002,%DT("A")="Queue to run at what date/time?  "
 .D ^%DT K %DT
 .S ECD=Y
 .I ECD<0 S OUT=1
 .I $E(ECD,6,7)>28 D  Q
 ..D MES^XPDUTL(" ")
 ..D MES^XPDUTL("Monthly extracts must be queued for a date not greater than the 28th.")
 ..D MES^XPDUTL(" ")
 .S OUT=1
 I ECD>DT D
 .S:'$D(ECINST) ECINST=+$P(^ECX(728,1,0),U)
 .S ECXINST=ECINST
 .K ECXDIC S DA=ECINST,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99"
 .D EN^DIQ1 S ECINST=$G(ECXDIC(4,DA,99,"I")) K DIC,DIQ,DA,DR,ECXDIC
 .;get last date for all extracts except prosthetics
 .I ECGRP'="PRO" D
 ..S ECLDT=$S($D(^ECX(728,1,ECNODE)):$P(^(ECNODE),U,ECPIECE),1:2610624)
 .;get last date for prosthetics
 .I ECGRP="PRO" D
 ..S ECLDT=""
 ..S ECXDA1=$O(^ECX(728,0))
 ..I $D(^ECX(728,ECXDA1,1,ECXINST,0)) S ECLDT=$P(^ECX(728,ECXDA1,1,ECXINST,0),U,2)
 .;ecldt should be valid so continue
 .I ECLDT D  Q:'$G(Y)  Q:$D(DIRUT)
 ..S ECFDT=$$LASTMON(ECD)
 ..;change to 1st day of month
 ..S $E(ECFDT,6,7)="01"
 ..S ECDIF=$$FMDIFF^XLFDT(ECFDT,ECLDT)
 ..Q:ECDIF=1
 ..S Y=$E(ECFDT,1,5)_"00" D DD^%DT S MONTH=Y K Y
 ..D MES^XPDUTL(" ")
 ..D MES^XPDUTL("The last date for the "_ECHEAD_" extract was "_$$FMTE^XLFDT(ECLDT)_".")
 ..D MES^XPDUTL(" ")
 ..D MES^XPDUTL("When the extract is run using the queue date/time you supplied, data")
 ..D MES^XPDUTL("for the month of "_MONTH_" will be extracted.")
 ..D MES^XPDUTL(" ")
 ..I ECDIF>1 D MES^XPDUTL("It appears that there is a period of time for which data will not be extracted.")
 ..I ECDIF<0 D MES^XPDUTL("It appears that you may be duplicating previously extracted data.")
 ..D MES^XPDUTL(" ")
 ..S DIR(0)="YA",DIR("A")="Do you wish to proceed? ",DIR("B")="N" K DIRUT,DUOUT,DTOUT
 ..D ^DIR K DIR
 .S ZTRTN="QUE^"_ECROU,ZTDESC=ECPACK_" EXTRACT",ZTIO="",ZTDTH=ECD
 .D ^%ZTLOAD
 .I $G(ZTSK) D
 ..S $P(^ECX(727.1,ECDA,0),"^",6)=1
 ..D MES^XPDUTL(" ")
 ..D MES^XPDUTL("Request queued as Task #"_ZTSK)
 ..D MES^XPDUTL("with automatic monthly requeue.")
 ..D MES^XPDUTL(" ")
 ..I $E(IOST)="C" D
 ...S SS=22-$Y F JJ=1:1:SS W !
 ...S DIR(0)="E" W ! D ^DIR K DIR
 K ECD,ECDA,ECDATA,ECDIF,ECF,ECFDT,ECFILE,ECGRP,ECHEAD,ECLDT,ECPIECE,ECPACK,ECROU,ECINST,ECNODE,ECXDA1,ECXINST
 Q
 ;
WARN ;
 ;;  
 ;;It appears that the extract has already been queued to run.  If you make 
 ;;changes now, there is a possibility that data for a particular date range
 ;;may be omitted from the extract process and not transmitted to AAC.
 ;; 
 ;;Before continuing, you should carefully review the extract history for
 ;;this extract.  You should also verify that this extract is not currently
 ;;queued to run in the future.
 ;;  
 ;;QUIT
 ;
MSG ;
 D MES^XPDUTL(" ")
 I ECLDT="" D
 .D MES^XPDUTL("Automatic requeue may not be setup for a DSS extract")
 .D MES^XPDUTL("which has never been previously generated.")
 I ECLDT D
 .D MES^XPDUTL("Automatic requeue may not be setup to generate the October")
 .D MES^XPDUTL("extract of the current fiscal year.")
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Please use the appropriate option on the Package Extracts")
 D MES^XPDUTL("menu to generate the first monthly "_ECHEAD_" extract of")
 D MES^XPDUTL("the current fiscal year.  Exiting...")
 D MES^XPDUTL(" ")
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .S DIR(0)="E" W ! D ^DIR K DIR
 Q
 ;
NEXTMON(ECXDATE) ;get date for date+(1 month)
 ;input ECXDATE = FM date or date/time [required]
 ;                where day of month is cannot be greater than 28
 ;output returns FM date or date/time; next month, but same day of month
 N DATE,ECXNEXT,X1,X2,X
 S DATE=$P(ECXDATE,".")
 I +$E(DATE,6,7)>28 S $E(DATE,6,7)="28"
 S X1=DATE,X2=30 D C^%DTC
 S ECXNEXT=X
 I $E(ECXNEXT,6,7)'=$E(ECXDATE,6,7) S $E(ECXNEXT,6,7)=$E(ECXDATE,6,7)
 I $P(ECXDATE,".",2) S $P(ECXNEXT,".",2)=$P(ECXDATE,".",2)
 Q ECXNEXT
 ;
LASTMON(ECXDATE) ;get last day of previous month
 ;input ECXDATE = FM date or date/time [required]
 ;output returns FM date; previous month, last day of month
 N DATE,ECXLAST,X1,X2,X
 S DATE=$P(ECXDATE,"."),DATE=$E(DATE,1,5)_"01"
 S X1=DATE,X2=-1 D C^%DTC
 S ECXLAST=X
 Q ECXLAST
