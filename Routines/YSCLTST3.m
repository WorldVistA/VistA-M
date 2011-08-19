YSCLTST3 ;DALOI/LB/RLM-TRANSMISSION FOR CLOZAPINE REPORTING SYSTEM ;26 June 91
 ;;5.01;MENTAL HEALTH;**18,22,25,26,47,61,69,74,90**;Dec 30, 1994;Build 18
 ; Reference to ^DPT supported by IA #10035
 ; Reference to ^PS(55 supported by IA #787
 ; Reference to ^PS(59 supported by IA #783
 ; Reference to ^VA(200 supported by IA #10060
 ; Reference to ^LAB(60 supported by IA #333
 ; Reference to ^XMD supported by IA #10070
DEMOG ; Old entry point to send demographic data for patients from task. Obsolete
 Q
DMG ; Called by YSCLTEST
 S YSDEBUG=$P(^YSCL(603.03,1,0),"^",3)
 K ^TMP($J),^TMP("YSCL",$J),^TMP("YSCLL",$J) S YSCLLN=0,YSCLNO=20,DFN=0,YSCLIEN=0
 F  K YSCLA S YSCLIEN=$O(^YSCL(603.01,YSCLIEN)) Q:'YSCLIEN  S DFN=$P($G(^YSCL(603.01,YSCLIEN,0)),"^",2) S $P(YSSTOP,",",8)=8 Q:$$S^%ZTLOAD  D:DFN
  . I $D(^DPT(DFN,0)),$D(^YSCL(603.01,YSCLIEN,0)) S YSCLC=$P($G(^YSCL(603.01,YSCLIEN,0)),"^",1) D GET
 D TRANSMIT:YSCLLN G END
 ;
GET ;
 S $P(YSSTOP,",",9)=9 Q:$$S^%ZTLOAD
 Q:'$D(^PS(55,DFN,"SAND"))  ;Don't try to transmit if no pharmacy record
 Q:$P(^PS(55,DFN,"SAND"),"^",4)  ;Don't retransmit demographics.
 Q:$D(^TMP("YSCLL",$J,DFN))
 S ^TMP("YSCLL",$J,DFN)=1
 S YSCLP=+$P($G(^PS(55,DFN,"SAND")),"^",5),YSCLDEA=$P($G(^VA(200,YSCLP,"PS")),"^",2),YSCLP=$P($G(^VA(200,YSCLP,0)),"^")
 D DEM^VADPT,ADD^VADPT S YSCL=YSCLC_"^"_$E($P(VADM(1),",",2))_$E(VADM(1))_"^"_$P(VADM(3),"^")_"^"_$P(VADM(2),"^")_"^"_$P(VADM(5),"^")_"^"_VAPA(6)_"^"_DT
 D
  . S YSRACE="*"
  . S YSRC=0 F  S YSRC=$O(VADM(11,YSRC)) Q:'YSRC  S YSRACE=YSRACE_+VADM(11,YSRC)_"-"_+VADM(11,YSRC,1)_","
  . S YSRACE=YSRACE_"~"
  . S YSRC=0 F  S YSRC=$O(VADM(12,YSRC)) Q:'YSRC  S YSRACE=YSRACE_+VADM(12,YSRC)_"-"_+VADM(12,YSRC,1)_","
 S YSCL=YSCL_"^"_YSRACE_"^"_YSCLP_"^"_YSCLDEA
 S YSCLGL=$S($D(^PS(59)):"^PS",1:"^DIC")
 ;YSCLGL is used to indirectly hold the global reference for file 59. This is necessary due to changes in the file location. The $select may be expanded to cover future moves. DBIA 273-B
 F YSCLJ=0:0 S YSCLJ=$O(@YSCLGL@(59,YSCLJ)) Q:'YSCLJ  I $D(^(YSCLJ,"SAND")) S YSCLJ=$P(^(0),"^",5) Q
 S YSCL=YSCL_"^"_YSCLJ
 ;registration number^initials^dob^ssn^sex^zip^today^race^physician^dea^zip code (hosp)
 S YSCLLN=YSCLLN+1,^TMP($J,YSCLLN,0)=YSCL
 I VADM(5)=""!(VAPA(6)="")!('VADM(11))!('VADM(12)) D  ;RLM RACETEST
  . S ^TMP("YSCL",$J,YSCLNO,0)=$P(VADM(2),"^",1)_"   "_VADM(1)
  . S:VADM(5)="" ^TMP("YSCL",$J,YSCLNO,0)=^TMP("YSCL",$J,YSCLNO,0)_" (SEX)"
  . S:VAPA(6)="" ^TMP("YSCL",$J,YSCLNO,0)=^TMP("YSCL",$J,YSCLNO,0)_" (ZIP)"
  . S:'VADM(12) ^TMP("YSCL",$J,YSCLNO,0)=^TMP("YSCL",$J,YSCLNO,0)_" (RACE, NEW FORMAT)"
  . S:'VADM(11) ^TMP("YSCL",$J,YSCLNO,0)=^TMP("YSCL",$J,YSCLNO,0)_" (ETHNICITY)"
  . S YSCLNO=YSCLNO+1
  . S ^TMP("YSCLL",$J,DFN)=0 ; leave unmarked pending demographic data
  . I ('VADM(11))!('VADM(12)) D
  . . S ^TMP("YSCL",$J,YSCLNO,0)="NOTE: Race and Ethnicity may be entered if permission is obtained in the informed consent",YSCLNO=YSCLNO+1
  . . S ^TMP("YSCL",$J,YSCLNO,0)="document. See VHA Directive 99-035.",YSCLNO=YSCLNO+1
 ;
 Q
 ;
TRANSMIT ; remote and local messages
 S $P(YSSTOP,",",10)=10 Q:$$S^%ZTLOAD
 S XMY("S.RUCLDEM@FO-HINES.MED.VA.GOV")=""
 I YSDEBUG K XMY S XMY("G.CLOZAPINE DEBUG@FO-DALLAS.MED.VA.GOV")="",XMY("G.RUCLDEM@FO-DALLAS.MED.VA.GOV")=""
 S XMDUZ="CLOZAPINE MONITOR",XMTEXT="^TMP($J,",XMSUB=$S(YSDEBUG:"DEBUG ",1:"")_"Clozapine demographics" D ^XMD S $P(^YSCL(603.03,1,0),"^",6)=$$NOW^XLFDT
 K XMY S XMY("G.PSOCLOZ")=""
 I YSDEBUG K XMY S XMY("G.CLOZAPINE DEBUG@FO-DALLAS.MED.VA.GOV")=""
 S XMSUB=$S(YSDEBUG:"DEBUG ",1:"")_"Clozapine demographics",^TMP("YSCL",$J,2,0)=" ",XMDUZ="CLOZAPINE MONITOR",^TMP("YSCL",$J,1,0)="Clozapine demographic data was transmitted, "_YSCLLN_" records were sent.",XMTEXT="^TMP(""YSCL"",$J,"
 I $O(^TMP("YSCL",$J,10)) S ^TMP("YSCL",$J,3,0)="For the following patients, one or more of the required data",^TMP("YSCL",$J,4,0)="elements (race, sex, ZIP code) were missing.",^TMP("YSCL",$J,5,0)=" "
 I  S ^TMP("YSCL",$J,6,0)="Please have this information entered.",^TMP("YSCL",$J,7,0)="The available data was transmitted.",^TMP("YSCL",$J,8,0)=" "
 D ^XMD
 ; set transmitted field in 55 from ^TMP("YSCLL",$J)
 F DFN=0:0 S DFN=$O(^TMP("YSCLL",$J,DFN)) Q:'DFN  I ^TMP("YSCLL",$J,DFN) S $P(^PS(55,DFN,"SAND"),"^",4)=1
 Q
 ;
FLERR ;
 K XMY
 S XMY("G.CLOZAPINE ROLL-UP@FORUM.VA.GOV")=""
 I YSDEBUG K XMY S XMY("G.CLOZAPINE DEBUG@FO-DALLAS.MED.VA.GOV")=""
 S %DT="T",X="NOW" D ^%DT S YSCLNOW=$P(Y,".",2)
 S YSCLSITE=$P($$SITE^VASITE,"^",2)
 S XMSUB=$S(YSDEBUG:"DEBUG ",1:"")_"Clozapine lab data error at "_YSCLSITE_" on "_DT_" at "_YSCLNOW,^TMP("YSCL",$J,1,0)=" "
 S ^TMP("YSCL",$J,2,0)="### Clozapine data error at "_YSCLSITE_" on "_DT_" +++"
 S ^TMP("YSCL",$J,3,0)=" Clozapine Lab Test file not properly defined."
 S ^TMP("YSCL",$J,4,0)=" Data cannot be transmitted!"
 S XMTEXT="^TMP(""YSCL"",$J,",XMDUZ="Clozapine MONITOR" D ^XMD
 G END^YSCLTST2
 Q
TLIST ;
 I '$D(^YSCL(603.04)) W !,"Patch YS*5.01*90 not properly installed.  Contact IRM" S DIR(0)="E" D ^DIR Q
 W !,"Currently linked Tests:" I '$O(^YSCL(603.04,1,1,0)) W !,"No tests linked",!
 S YSCLA=0
 F  S YSCLA=$O(^YSCL(603.04,1,1,YSCLA)) Q:'YSCLA  S YSCLB=^YSCL(603.04,1,1,YSCLA,0) D
  . W !,$P(^LAB(60,$P(YSCLB,"^"),0),"^")," represents " S YSCLB=$P(YSCLB,"^",2)
  . W $S(YSCLB="W":"WHITE BLOOD COUNT",YSCLB="A":"ABSOLUTE NEUTROPHIL COUNT",YSCLB="N":"NEUTROPHIL PERCENT",YSCLB="S":"SEGS %",YSCLB="B":"BANDS %",YSCLB="T":"BANDS ABSOLUTE",YSCLB="C":"SEGS ABSOLUTE",1:"Bad Record")
 F  K DIR S DIR(0)="PA^60:EMZ",DIR("A")="Enter the name of the test for Clozapine: " W ! D ^DIR Q:Y="^"!($D(DTOUT))!($D(DUOUT))  S YSCLTST=+Y D  Q:Y="^"!($D(DTOUT))!($D(DUOUT))
  . I $D(^YSCL(603.04,1,1,"B",YSCLTST)) G TEXIST
  . K DIR S DIR(0)="SA^W:WHITE BLOOD COUNT;A:ABSOLUTE NEUTROPHIL COUNT;N:NEUTROPHIL PERCENT;S:SEGS %;B:BANDS %;T:BANDS ABSOLUTE;C:SEGS ABSOLUTE"
  . S DIR("A")="Enter the type of the test for Clozapine: "  D ^DIR Q:Y["^"!($D(DTOUT))!($D(DUOUT))  S YSCLTS1=Y
  . K DIR S DIR(0)="SA^0:uL;1:K/uL;2:Percent"
  . S DIR("A")="Enter the reporting method of the test for Clozapine: "  D ^DIR Q:Y["^"!($D(DTOUT))!($D(DUOUT))  S YSCLTS2=Y
  . K YSCLERR
  . D VAL^DIE(603.41,"+1,1,",.01,"F","`"_YSCLTST,.YSCLRES,"FDA","YSCLERR")
  . I $D(YSCLERR) W !,"There was a problem with the data, please re-enter it" Q
  . D VAL^DIE(603.41,"+1,1,",1,"F",YSCLTS1,.YSCLRES,"FDA","YSCLERR")
  . I $D(YSCLERR) W !,"There was a problem with the data, please re-enter it" Q
  . D VAL^DIE(603.41,"+1,1,",2,"F",YSCLTS2,.YSCLRES,"FDA","YSCLERR")
  . I $D(YSCLERR) W !,"There was a problem with the data, please re-enter it" Q
  . D UPDATE^DIE(,"FDA",,"ERROR")
  . I $D(YSCLERR) W !,"There was a problem with the data, please re-enter it" Q
 Q
TEXIST ;
 W !,"This entry already exists.  Do you wish to delete it?" K DIR S DIR(0)="Y" D ^DIR Q:'Y!($D(DTOUT))!($D(DUOUT))
 S DA(1)=1,DA=$O(^YSCL(603.04,1,1,"B",YSCLTST,"")),DIE="^YSCL(603.04,1,1,",DR=".01////@" D ^DIE W !,"Deleted" S Y="" Q
 Q
END K %,C,D,DA,DFN,DISYS,DR,I,R,VADM,VAPA,VAERR,Y,YSCL,YSCL1,YSCL2,YSCLC,YSCLDEA,YSCLJ,YSCLLN,YSCLNAME,YSCLNO,YSCLP,^TMP($J),^TMP("YSCL",$J),^TMP("YSCLL",$J) Q
 Q
END1 ;
 K ^TMP($J),^TMP("YSCL",$J)
 K %,%DT,%H,%T,AGE,C,CNT,D,DA,DFN,DIE,DIK,DIR,DIROUT,DIRUT,DISYS,DOB,DR
 K DRG,DTOUT,DUOUT,I,IOF,J,K,LAB,LABT,PNM,POP,R,RESULTS1,SEX,SSN,VADM,VAERR,VAPA
 K X,X1,X2,XMDUZ,XMSUB,XMTEXT,XMY,XMZ,Y,YSACT,YSCL,YSCL1,YSCL2,YSCL28,YSCLA,YSCLA1,YSCLAB
 K YSCLAB1,YSCLAB2,YSCLAB3,YSCLAB4,YSCLC,YSCLD,YSCLD0,YSCLD1,YSCLDAT1
 K YSCLDATA,YSCLDEA,YSCLDEMO,YSCLED,YSCLF,YSCLFF,YSCLFRQ,YSCLGL,YSCLGRN,YSCLI
 K YSCLID,YSCLIED,YSCLIEN,YSCLIF,YSCLJ,YSCLLAB,YSCLLD,YSCLLDFN,YSCLLDN
 K YSCLLDT,YSCLLK,YSCLLLN,YSCLLN,YSCLLO,YSCLM180,YSCLM28,YSCLM56,YSCLM7,YSCLMTCH,YSCLNAME
 K YSCLNO,YSCLNOW,YSCLNST1,YSCLNSTE,YSCLOVR,YSCLP,YSCLPHY,YSCLR,YSCLRES,YSCLRET,YSCLRWBC,YSCLRX
 K YSCLRX2,YSCLSAND,YSCLSB1,YSCLSD,YSCLSGS,YSCLSITE,YSCLSN,YSCLSP,YSCLT,YSCLTA,YSCLTDT,YSCLTEST
 K YSCLTL,YSCLTPT,YSCLTLS,YSCLTLS1,YSCLTS1,YSCLTST,YSCLTYPE,YSCLWBC,YSCLWBCC
 K YSCLWBCT,YSCLX,YSCLZ2,YSDEBUG,YSOFF,YSRACE,YSRC,YSSTOP,YSTEXT,ZTDESC
 K ZTDTH,ZTIO,ZTREQ,ZTRTN,ZTSAVE,ZTSTOP
 Q
ZEOR ;YSCLTST3
