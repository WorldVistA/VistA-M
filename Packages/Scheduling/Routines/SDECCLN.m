SDECCLN ;ALB/RBD - VISTA SCHEDULING CLEANUP UTILITY ;MAR 15, 2017
 ;;5.3;Scheduling;**658**;Aug 13, 1993;Build 23
 ;
 Q
 ;
EN N X,Y
 W !!,"The following Utility will allow the Closing of Re-Opened SDEC APPT REQUEST"
 W !,"records which have resulted from a Cancellation in VistA of a corresponding"
 W !,"SDEC APPOINTMENT."
 ;
EN2 K DIR S DIR(0)="SO^1:Compile List of Re-Opened REQUEST records that can be Closed;2:Commit Records to Be Closed from Compiled List"
 S DIR("A")="What Would You like to Do?" D ^DIR Q:$D(DIRUT)  G:Y=1 CLINICS G WRKLIST
 Q
 ;
CLINICS K DIRUT,^TMP($J) W !!,"Please enter in, one by one, a list of Clinics to EXCLUDE from Compilation.",!
CLINIC S DIC("A")="Enter CLINIC to EXCLUDE: ",DIC="^SC(",DIC(0)="AEQMZ"
 S DIC("S")="I $P(^(0),U,3)=""C"",'$G(^(""OOS""))" D ^DIC G:X="^" EN
 I X="" K DIC G COMPILE
 S ^TMP($J,X,$P(Y,"^",1))=""
 G CLINIC
 ;
COMPILE ; Begin to Compile based on Clinics not Excluded
 I '$D(^TMP($J)) D  G:Y'=1 CLINICS
 . W !!,"You did not choose any Clinics to Exclude."
 . S DIR("B")="NO"
 . S DIR("A")="Are you sure you want to run cleanup for ALL clinics? (Y OR N):"
 . S DIR(0)="Y^AO" D ^DIR
 W !!,"Compiling for all Clinics excluding the following:",!
 S X="" F  S X=$O(^TMP($J,X)) Q:X=""  W !,X
ASKDEV W ! S SDJOBNO=$J S %ZIS="Q"
 D ^%ZIS Q:POP
 I $D(IO("Q")) D  K POP,SDJOBNO,%ZIS G EN
 . K ZTSAVE S ZTSAVE("SDJOBNO")="",ZTRTN="COMPIL2^SDECCLN"
 . S ZTDESC="Compile of Open SDEC APPT REQUEST Records"
 . D ^%ZTLOAD,^%ZISC K ZTDESC,ZTRTN
 D COMPIL2 D ^%ZISC
 K POP,SDJOBNO,%ZIS G EN
 ;
COMPIL2 ;
 ;O IO
 U IO
 N SDCID,SDCNT,SDCNCLDT,SDCLN,SDCLINS,SDCLINS2,SDATE,SDPT,SDSSN,X,Y
 N SDIEN,SDIEN2,SDLINK,SDFND
 M SDCLINS=^TMP(SDJOBNO)
 L +^XTMP("SDECCLEAN"):5 I '$T D  Q
 . W !!,"Another user is running utility at same time as you."
 . w !,"Please try again later."
 S SDCNT=+$O(^XTMP("SDECCLEAN",""),-1)+1
 S ^XTMP("SDECCLEAN",SDCNT,"START")=$H
 S ^XTMP("SDECCLEAN",SDCNT,"DUZ")=DUZ
 I '$D(^XTMP("SDECCLEAN",0)) S ^XTMP("SDECCLEAN",0)=$$FMADD^XLFDT(DT,365)
 L -^XTMP("SDECCLEAN")
 D HEADER
 S X="" F  S X=$O(SDCLINS(X)) Q:X=""  D
 . S ^XTMP("SDECCLEAN",SDCNT,"EXCLUDED CLINIC",X)=""
 . S Y="" F  S Y=$O(SDCLINS(X,Y)) Q:Y=""  D
 .. S SDCLINS2(Y)=""  ; just store Clinic IENs to Exclude
 S SDATE="" F  S SDATE=$O(^SDEC(409.85,"E","O",SDATE)) Q:SDATE=""  D
 . S SDIEN="" F  S SDIEN=$O(^SDEC(409.85,"E","O",SDATE,SDIEN)) Q:SDIEN=""  D
 .. S SDCLN=$$GET1^DIQ(409.85,SDIEN,8,"I") Q:SDCLN=""  Q:$D(SDCLINS2(SDCLN))
 .. Q:$$GET1^DIQ(409.85,SDIEN,41)="YES"
 .. Q:$$GET1^DIQ(409.85,SDIEN,4,"I")'="APPT"
 .. S SDPT=$$GET1^DIQ(409.85,SDIEN,.01,"I")
 .. S SDFND=0,SDIEN2=""   ; SDFND set if Cancellation in 409.84 Found
 .. F  S SDIEN2=$O(^SDEC(409.84,"CPAT",SDPT,SDIEN2)) Q:SDIEN2=""  D  Q:SDFND
 ... S SDCNCLDT=$$GET1^DIQ(409.84,SDIEN2,.12) Q:'$L(SDCNCLDT)
 ... S SDLINK=$$GET1^DIQ(409.84,SDIEN2,.22,"I")
 ... I $P(SDLINK,";",1)=SDIEN,$P(SDLINK,";",2)["SDEC(409.85," S SDFND=1
 .. Q:'SDFND
 .. S SDCLN=$$GET1^DIQ(409.85,SDIEN,8)
 .. S SDCID=$$GET1^DIQ(409.85,SDIEN,22,"I")
 .. S SDSSN=$$GET1^DIQ(2,SDPT,.09)
 .. S SDPT=$$GET1^DIQ(409.85,SDIEN,.01)
 .. S ^XTMP("SDECCLEAN",SDCNT,"CL",SDCLN,"PT",SDPT,"IEN",SDIEN)=SDSSN_"^"_SDCID_"^"_SDIEN2
 D DSPLIST S ^XTMP("SDECCLEAN",SDCNT,"FINISH")=$H
 Q
 ;
HEADER ; Print out the Header for the List
 N SDRUNDAT S SDRUNDAT=$$HTE^XLFDT(^XTMP("SDECCLEAN",SDCNT,"START"))
 W !!,?9,"*** Open SDEC APPT REQUESTs List run "_SDRUNDAT_" ***"
 W !!,?43,"LAST 4",?50,"APPT REQ IEN"
 W !,"CLINIC",?20,"PATIENT",?45,"SSN",?50,"  APPT IEN",?69,"CID DATE"
 N SDASH S $P(SDASH,"=",80)="" W !,SDASH,!
 Q
 ;
DSPLIST ; Display list of records
 N SDREC
 S SDCLN=""
 F  S SDCLN=$O(^XTMP("SDECCLEAN",SDCNT,"CL",SDCLN)) Q:SDCLN=""  D
 . S SDPT=""
 . F  S SDPT=$O(^XTMP("SDECCLEAN",SDCNT,"CL",SDCLN,"PT",SDPT)) Q:SDPT=""  D
 .. S SDIEN=""
 .. F  S SDIEN=$O(^XTMP("SDECCLEAN",SDCNT,"CL",SDCLN,"PT",SDPT,"IEN",SDIEN)) Q:SDIEN=""  D
 ... S SDREC=$G(^XTMP("SDECCLEAN",SDCNT,"CL",SDCLN,"PT",SDPT,"IEN",SDIEN))
 ... Q:SDREC=""  S SDSSN=$P(SDREC,"^",1),SDCID=$P(SDREC,"^",2)
 ... S SDIEN2=$P(SDREC,"^",3)
 ... W !,$E(SDCLN,1,18),?20,$E(SDPT,1,23)
 ... W ?45,$E(SDSSN,6,9)
 ... W ?50,SDIEN," ; ",SDIEN2,?69,$$FMTE^XLFDT(SDCID,5)
 Q
 ;
WRKLIST K DIRUT N SDCOUNT,SDCNT,SDSTART,SDFINISH,SDUSER S SDCOUNT=0
 S SDCNT=0 D WRKHEAD
WRKLST2 S SDCNT=$O(^XTMP("SDECCLEAN",SDCNT)) G:SDCNT="" ASKBTCH
 S SDUSER=$G(^XTMP("SDECCLEAN",SDCNT,"DUZ"))
 S SDSTART=$G(^XTMP("SDECCLEAN",SDCNT,"START"))
 S SDFINISH=$G(^XTMP("SDECCLEAN",SDCNT,"FINISH"))
 W !,SDCNT,?15,$$GET1^DIQ(200,SDUSER,.01),?30,$$HTE^XLFDT(SDSTART)
 W ?55,$$HTE^XLFDT(SDFINISH) S SDCOUNT=SDCOUNT+1
 I SDCOUNT#16=0 G ASKBTCH
 G WRKLST2
 ;
WRKHEAD N SDASH W:$D(IOF) @IOF S $P(SDASH,"=",80)=""
 W !!,"Open SDEC APPT REQUEST Compilation Lists to Choose From:"
 W !!,"Batch #",?15,"Run User",?30,"Start Date",?55,"Finish Date",!,SDASH,!
 Q
 ;
ASKBTCH N SDASKMES,SDRESP S SDASKMES="Enter Batch #"_$S(SDCNT'="":" or <Return> to continue",1:"")
 W !!,SDASKMES,":" R SDRESP:300 I '$T W "   ...  Read Timeout" G EN
 G:SDRESP["^" EN I SDRESP="" G:SDCNT="" EN D WRKHEAD G WRKLST2
 I SDRESP'?1N.N W "   ... Please enter a Batch #" G ASKBTCH
 I SDRESP=0 W "   ... Please enter a Batch #" G ASKBTCH
 I '$D(^XTMP("SDECCLEAN",SDRESP)) W "   ... Batch # not in List" G ASKBTCH
 I '$D(^XTMP("SDECCLEAN",SDRESP,"FINISH")) W "   ... Batch Run not Finished" G ASKBTCH
 I '$D(^XTMP("SDECCLEAN",SDRESP,"CL")) W "   ... Batch Run picked up No Records" G ASKBTCH
 ;
COMMIT W !!,"Committing Open records for Batch # ",SDRESP," to Closed..."
 N SDCLN,SDPT,SDIEN,SDNUM S SDCLN="",SDNUM=0
 F  S SDCLN=$O(^XTMP("SDECCLEAN",SDRESP,"CL",SDCLN)) Q:SDCLN=""  D
 . S SDPT=""
 . F  S SDPT=$O(^XTMP("SDECCLEAN",SDRESP,"CL",SDCLN,"PT",SDPT)) Q:SDPT=""  D
 .. S SDIEN=""
 .. F  S SDIEN=$O(^XTMP("SDECCLEAN",SDRESP,"CL",SDCLN,"PT",SDPT,"IEN",SDIEN)) Q:SDIEN=""  D
 ... I $$GET1^DIQ(409.85,SDIEN,23,"I")="C" Q
 ... S DR="23////C;19////"_DT_";20////"_DUZ_";21////ER;21.1////Y"
 ... S DIE="^SDEC(409.85,",DA=SDIEN D ^DIE
 ... S SDNUM=SDNUM+1 W:SDNUM#100=0 "."
 K DA,DIE,DR
 W "Done" Q
 ;
