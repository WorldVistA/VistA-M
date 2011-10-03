DG53P543 ;BAY/JT - cleanup of file 20 ; 9/16/03 4:56pm
 ;;5.3;Registration;**543**;Aug 13, 1993
 ; patient name .01 only
 ;
ENV ; do environment check
 S XPDABORT=""
 D PROGCHK(.XPDABORT)
 I XPDABORT="" K XPDABORT
 Q
PROGCHK(XPDABORT) ; checks for necessary programmer variables
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .S XPDABORT=2
 Q
 ;
CLEANUP N DGIEN,DGFULLNM,DGLINK,DGFND,DGDPT,DGNAME,DGZERO,DGONE,DGERR,CNT,DGMID,DGTOT,DGUPDT,DGNOLINK,DGLINK0,DGLINK1,DGCONC,DGOTHERS,DGGLOBAL,X1,X2
 K ^XTMP("DG53P543")
 S X1=DT,X2=90 D C^%DTC
 S ^XTMP("DG53P543",0)=X_"^"_DT_"^Problems w/file 2 links w/file 20"
 S (DGIEN,DGTOT,DGERR,DGUPDT,DGNOLINK,DGLINK0,DGLINK1,DGOTHERS)=0
 D BMES^XPDUTL("Beginning clean-up...Reading thru entire Patient File...")
 F  S DGIEN=$O(^DPT(DGIEN)) Q:'DGIEN  D
 .S DGTOT=DGTOT+1
 .Q:$P($G(^DPT(DGIEN,0)),U)["MERGING INTO"
 .Q:$D(^DPT(DGIEN,-9))
 .S DGFULLNM=$P($G(^DPT(DGIEN,0)),U)
 .S DGLINK=+$P($G(^DPT(DGIEN,"NAME")),U)
 .I 'DGLINK D NOLINK Q
 .S DGZERO=$G(^VA(20,DGLINK,0))
 .I DGZERO="" D NOZERO Q
 .I $P(DGZERO,U)'=2!($P(DGZERO,U,2)'=".01")!(+$P(DGZERO,U,3)'=DGIEN) D BADZERO Q
 .S DGONE=$G(^VA(20,DGLINK,1))
 .I DGONE="" D NOONE Q
 .;
 .S DGERR=0
 .; skip if "error" in family name
 .I $P(DGFULLNM,",",1)["ERROR" Q
 .; compare family name
 .I $P(DGFULLNM,",",1)'=$P(DGONE,U) S DGERR=1 S ^XTMP("DG53P543",DGIEN,DGLINK,DGERR)=$P(DGFULLNM,",",1)_U_$P(DGONE,U) S DGUPDT=DGUPDT+1 Q
 .; skip if no first name
 .I $P(DGFULLNM,",",2)="",$P(DGONE,U,2)="" Q
 .; if comma in first name, skip if everything equal
 .I $P(DGONE,U,2)["," S DGCONC=$P(DGONE,U)_","_$P(DGONE,U,2) I DGCONC=DGFULLNM Q
 .; compare first name
 .S CNT=$L($P(DGONE,U,2))
 .I $E($P(DGFULLNM,",",2),1,CNT)'=$P(DGONE,U,2) S DGERR=2 S ^XTMP("DG53P543",DGIEN,DGLINK,DGERR)=DGFULLNM_"///"_$P(DGONE,U,1,5) S DGOTHERS=DGOTHERS+1 Q
 .;compare middle names and suffixes
 .S DGMID=$P($P(DGFULLNM,",",2)," ",2)
 .I DGMID=$P(DGONE,U,3)!(DGMID=$P(DGONE,U,5)) Q
 .S DGMID=$P($P(DGFULLNM,",",2)," ",2,99)
 .I $P(DGONE,U,3)'="",DGMID[$P(DGONE,U,3) Q
 .I $P(DGONE,U,5)'="",DGMID[$P(DGONE,U,5) Q
 .S DGERR=3
 .S ^XTMP("DG53P543",DGIEN,DGLINK,DGERR)=DGFULLNM_"///"_$P(DGONE,U,1,5) S DGOTHERS=DGOTHERS+1
 .Q
 ;
 D MES^XPDUTL("Total # of Patient File records read: "_DGTOT)
 D MES^XPDUTL("Total # of Name Component file #20 records needing cleanup: "_DGUPDT)
 I DGUPDT D
 .D MES^XPDUTL("I will now update these records ...")
 .D UPDATE
 .D MES^XPDUTL("Done !")
 I DGOTHERS!(DGNOLINK)!(DGLINK0)!(DGLINK1) D
 .D MES^XPDUTL("I also found other records that need attention:")
 .I DGOTHERS D MES^XPDUTL("  # of records needing reformatting: "_DGOTHERS)
 .I DGNOLINK D MES^XPDUTL("  # of records with no link: "_DGNOLINK)
 .I DGLINK0 D MES^XPDUTL("  # of records with no or bad zero node: "_DGLINK0)
 .I DGLINK1 D MES^XPDUTL("  # of records with no '1' node: "_DGLINK1)
 .S DGGLOBAL="^XTMP(""DG53P543"""
 .D MES^XPDUTL("  For more details, please see the "_DGGLOBAL_" global")
 .D MES^XPDUTL("  or print the report PRTRPT^DG53P543")
 D BMES^XPDUTL("Clean-up is complete")
 Q
NOLINK ;
 S DGNOLINK=DGNOLINK+1
 I DGFULLNM="" S ^XTMP("DG53P543",DGIEN,0)="no name on patient file" Q
 I '$D(^VA(20,"C",DGFULLNM)) S ^XTMP("DG53P543",DGIEN,0)="no link to file 20" Q
 S DGFND=0
 F  S DGFND=$O(^VA(20,"C",DGFULLNM,DGFND)) Q:'DGFND  D
 .S DGDPT=+$P($G(^VA(20,DGFND,0)),U,3)
 .I DGDPT S DGNAME=$P($G(^DPT(DGDPT,0)),U) I DGNAME'="",DGNAME=DGFULLNM S ^XTMP("DG53P543",DGIEN,0)=DGFND_" points to Patient file "_DGDPT
 Q
NOZERO ;
 S DGLINK0=DGLINK0+1
 S ^XTMP("DG53P543",DGIEN,DGLINK)="no zero node on file 20"
 Q
BADZERO ;
 S DGLINK0=DGLINK0+1
 S ^XTMP("DG53P543",DGIEN,DGLINK)="bad zero node on file 20"
 Q
NOONE ;
 S DGLINK1=DGLINK1+1
 S ^XTMP("DG53P543",DGIEN,DGLINK)="no '1' node on file 20"
 Q
UPDATE ;
 Q:'$D(^XTMP("DG53P543"))
 N DG20NAME,DA,DR,DIE,X
 S DGIEN=0
 F  S DGIEN=$O(^XTMP("DG53P543",DGIEN)) Q:'DGIEN  D
 .S DGLINK=0
 .F  S DGLINK=$O(^XTMP("DG53P543",DGIEN,DGLINK)) Q:'DGLINK  D
 ..S DGERR=0
 ..F  S DGERR=$O(^XTMP("DG53P543",DGIEN,DGLINK,DGERR)) Q:'DGERR  D
 ...I DGERR'=1 Q
 ...S DG20NAME=$P($G(^DPT(DGIEN,0)),U) I DG20NAME'="" D
 ....S DIE="^DPT(",DA=DGIEN,DR=".01///^S X=DG20NAME" D ^DIE
 ....D MES^XPDUTL("Record # "_DGIEN_" for "_$P(^DPT(DGIEN,0),U)_" has been updated")
 ....K ^XTMP("DG53P543",DGIEN,DGLINK,DGERR)
 ....K DG20NAME
 Q
 ;
PRTRPT ;
 I $$DEVICE() D PRINT
 Q
DEVICE() ; choose device and whether to queue.
 N OK,IOP,POP,%ZIS,DGX
 S OK=1
 S %ZIS="MQ"
 D ^%ZIS
 S:POP OK=0
 I OK,$D(IO("Q")) D
 .N ZTRTN,ZTDESC,ZTSKM,ZTREQ,ZTSTOP
 .S ZTRTN="PRINT^DG53P543"
 .S ZTDESC="Print of XTMP global for DG53P543."
 .F DGX=1:1:20 D ^%ZTLOAD Q:$G(ZTSK)
 .W !,$S($D(ZTSK):"Request "_ZTSK_" queued!",1:"Request Cancelled!"),!
 .D HOME^%ZIS
 .S OK=0
 Q OK
 ;
PRINT ;
 U IO
 N DGIEN,DGLINK,DGERR,DGQUIT,DGPG,DGDDT
 S (DGQUIT,DGPG)=0
 S DGDDT=$$FMTE^XLFDT($$NOW^XLFDT,"D")
 D HEAD
 S DGIEN=0,DGIEN=$O(^XTMP("DG53P543",DGIEN))
 I DGIEN="" D  Q
 .W !!!,?20,"*** No records to report ***"
 ;
 S DGIEN=0
 F  S DGIEN=$O(^XTMP("DG53P543",DGIEN)) Q:'DGIEN  D  Q:DGQUIT
 .I $D(^XTMP("DG53P543",DGIEN,0)) D 
 ..I $Y>(IOSL-4) D HEAD
 ..W "# ",DGIEN,?11,^XTMP("DG53P543",DGIEN,0),!
 .S DGLINK=0
 .F  S DGLINK=$O(^XTMP("DG53P543",DGIEN,DGLINK)) Q:'DGLINK  D
 ..I $D(^XTMP("DG53P543",DGIEN,DGLINK))=1 D
 ...I $Y>(IOSL-4) D HEAD
 ...W "# ",DGIEN,?11,$P(^DPT(DGIEN,0),U),?40,^XTMP("DG53P543",DGIEN,DGLINK),?69,"# ",DGLINK,!
 ..S DGERR=0
 ..F  S DGERR=$O(^XTMP("DG53P543",DGIEN,DGLINK,DGERR)) Q:'DGERR  D
 ...I $Y>(IOSL-4) D HEAD
 ...W "# ",DGIEN,?11,^XTMP("DG53P543",DGIEN,DGLINK,DGERR),?69,"# ",DGLINK,!
 ;
 I DGQUIT W:$D(ZTQUEUED) !!,"Report stopped at user's request" Q
 I $G(DGPG)>0,$E(IOST)="C" K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 DGQUIT=1
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
HEAD ;
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DGQUIT)=1 Q
 I $G(DGPG)>0,$E(IOST)="C" K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 DGQUIT=1
 Q:DGQUIT
 S DGPG=$G(DGPG)+1
 W @IOF,!,DGDDT,?15,"DG*5.3*543 File #20 Cleanup Utility",?70,"Page:",$J(DGPG,5),! K X S $P(X,"-",81)="" W X,!
 W !,"File 2 IEN",?11,"Patient Name///Component Last^First^Middle^Prefix^Suffix",?69,"File 20 IEN",!
 S $P(X,"-",81)="" W X,!
 Q
