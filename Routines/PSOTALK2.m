PSOTALK2 ;BIR/EJW - SCRIPTALK ENROLLMENT FUNCTIONS ;3-28-02
 ;;7.0;OUTPATIENT PHARMACY;**135,182,326**;DEC 1997;Build 11
 ;External reference ^PS(55 supported by DBIA 2228
 ;External reference ^TMP("TIUP", ^TIUPNAPI, ^TIU(8925.1 supported by DBIA 1911
ENROLL ;
 N PSOSTEN,PSOIND,PSOLAST,DFN
 S PSOIND=""
 I '$G(PSOFIRST) D INSTR S PSOFIRST=1
 W !
 K DIC W ! S DIC(0)="QEAM",DIC("A")="Select PATIENT: " D EN^PSOPATLK S Y=PSOPTLK K DIC,PSOPTLK I Y<1!($D(DUOUT))!($D(DTOUT)) D CLEAN Q
 S PSOPT=+Y
 S DFN=PSOPT D DEM^VADPT I +$G(VADM(6)) W !,"Patient is deceased",! G ENROLL
 I '$D(^PS(55,PSOPT)) D
 .S DIC="^PS(55,",DLAYGO=55
 .K DD,DO S DIC(0)="L",(DINUM,X)=PSOPT D FILE^DICN D:Y<1  K DIC,DA,DR,DD,DO
 ..S $P(^PS(55,PSOPT,0),"^")=PSOPT K DIK S DA=PSOPT,DIK="^PS(55,",DIK(1)=.01 D EN^DIK K DIK
 S PSOSTEN=$G(^PS(55,"ASTALK",PSOPT))
 S DIR(0)="Y",DIR("A")="SCRIPTALK PATIENT" S DIR("B")=$S(PSOSTEN:"Y",1:"N") D ^DIR K DIR
 S PSOSTEN=Y
 I PSOSTEN D MAIL,GETIND
 D SET55
 D NOTE(PSOPT)
 K PSOIND,PSOPT,PSOSTEN,PSOLAST,X,Y
 G ENROLL
 ;
SET55 ; SET MULTIPLE FOR SCRIPTALK ENROLLMENT AUDIT
 N PSODA,PSOERR,PSOIEN,PSOSTDT
 I PSOPT="" Q
 S PSOSTDT=$$NOW^XLFDT
 S PSODA(55.0108,"+1,"_PSOPT_",",.01)=PSOSTDT
 S PSODA(55.0108,"+1,"_PSOPT_",",1)=PSOSTEN
 S PSODA(55.0108,"+1,"_PSOPT_",",2)=PSOIND
 S PSODA(55.0108,"+1,"_PSOPT_",",3)=$G(DUZ)
 D UPDATE^DIE("","PSODA","PSOIEN","PSOERR")
 Q
 ;
GETIND ; GET INDICATION FOR ENROLLMENT
 S PSOLAST=$P($G(^PS(55,PSOPT,"SCTALK",0)),"^",4) I PSOLAST'="" S PSOIND=$P($G(^PS(55,PSOPT,"SCTALK",PSOLAST,0)),"^",3) ; IF PRIOR ANSWER WAS 'Y' - GET PRIOR INDICATION
 S DIR(0)="S^B:BLIND VETERAN;L:LOW VISION",DIR("A")="INDICATION" S DIR("B")=PSOIND D ^DIR K DIR
 S PSOIND=$G(Y)
 Q
 ;
INSTR ;
 W @IOF
 I $O(^TIU(8925.1,"B","SCRIPTALK ENROLLMENT",0))="" Q
 W !
 W !?3,"At the conclusion of this enrollment option, you will be given"
 W !?3,"the opportunity to sign a progress note recording the enrollment"
 W !?3,"of new ScripTalk patients. If you modify the record of a patient"
 W !?3,"that was previously enrolled, and they remain enrolled, you may"
 W !?3,"wish to either delete or edit the text of the generated note."
 W !!
 K PSOSQ,PSOTT,PSOSTP
 Q
 ;
NOTE(PSOPT) ;CREATE A PROGRESS NOTE FOR PATIENT 'PSOPT' ABOUT ENROLLMENT
 Q:'+$G(^PS(55,"ASTALK",PSOPT))  ; IF THIS PTS ENROLLMENT ISN'T ACTIVE
 S PSOTITL=$O(^TIU(8925.1,"B","SCRIPTALK ENROLLMENT",0))
 Q:'+PSOTITL  ;IF NO TITLE ON SYSTEM
 S PSOPTNM=$P($G(^DPT(PSOPT,0)),U,1)
 S PSOLINE=1
 S ^TMP("TIUP",$J,PSOLINE,0)=PSOPTNM_" was enrolled in ScripTalk today, and is now eligible to receive"
 S PSOLINE=PSOLINE+1
 S ^TMP("TIUP",$J,PSOLINE,0)="prescriptions with encoded speech-capable labels."
 S ^TMP("TIUP",$J,0)=U_U_PSOLINE_PSOLINE_U_DT_U
INSTALL K TIUDA
 D NEW^TIUPNAPI(.TIUDA,PSOPT,DUZ,$$NOW^XLFDT,PSOTITL)
 Q
 ;
CLEAN K PSOLINE,PSOPTNM,PSOTITL,PSOSTP,PSOPT,PSOFIRST
 K ^TMP("TIUP",$J)
 Q
 ;
AUDREP ;
 K DIC W ! S DIC(0)="QEAM",DIC("A")="Select PATIENT: " D EN^PSOPATLK S Y=PSOPTLK K DIC,PSOPTLK I Y<1!($D(DUOUT))!($D(DTOUT)) Q
 S PSOPT=+Y
 S ZTSAVE("*")=""
 W !!,"You may queue the report to print, if you wish.",!
 K %ZIS,POP,IOP S %ZIS="QM" D ^%ZIS I $G(POP) W !!,"Nothing queued to print.",! G DONE
 I $D(IO("Q")) S ZTRTN="AUDRQ^PSOTALK2",ZTDESC="Report of ScripTalk Enrollment",ZTSAVE("*")="" D ^%ZTLOAD K %ZSI W !,"Report queued to print.",! G DONE
AUDRQ ;
 U IO
 S PSOOUT=0,PSODV=$S($E(IOST)="C":"C",1:"P")
 S PSOPGCT=1
 D TITLEA I PSOOUT G DONE
 S PSOAUD=0 F  S PSOAUD=$O(^PS(55,PSOPT,"SCTALK",PSOAUD)) Q:PSOAUD=""  D  I PSOOUT Q
 .S PSONODE=$G(^PS(55,PSOPT,"SCTALK",PSOAUD,0))
 .S PSOSTAT=$P(PSONODE,"^",2)
 .S PSOTIME=$$FMTE^XLFDT($P(PSONODE,U,1)),PSOTIME=$P(PSOTIME,"@")_"  "_$P(PSOTIME,"@",2)
 .S PSOTIME=$P(PSOTIME,":",1,2)
 .I ($Y+5)>IOSL&('$G(PSOOUT)) D TITLEA I PSOOUT Q
 .W !,?2,PSOTIME
 .W ?25,$S(PSOSTAT:"YES",PSOSTAT=0:"NO",1:" ")
 .S PSOIND=$P(PSONODE,"^",3)
 .I 'PSOSTAT S PSOIND=""
 .W ?35,$S(PSOIND="B":"BLIND VETERAN",PSOIND="L":"LOW VISION",1:"")
 .I $P(PSONODE,"^",4)'="" D  W ?52,$E(PSODUZ,1,27)
 ..K DIC,X,Y S DIC="^VA(200,",DIC(0)="M",X="`"_+$P(PSONODE,"^",4) D ^DIC S PSODUZ=$S(+Y:$P(Y,"^",2),1:"UNKNOWN") K DIC,X,Y
 I PSOOUT G DONE
END ;
 I '$G(PSOOUT),$G(PSODV)="C" W !!,"** End of Report **" K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $G(PSODV)="C" W !
 E  W @IOF
DONE K PSOPT,PSOAUD,PSONODE,PSOIND,PSOSTAT,PSOPGCT,Y,IOP,POP,IO("Q"),DIRUT,DUOUT,DTOUT,PSODV,PSOOUT
 K PSODFN,PSOIND,PSOSSN,PSOPRINT,PSONM,^TMP($J,"PSOTALK2")
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
TITLEA ;
 I $G(PSODV)="C",$G(PSOPGCT)'=1 W ! K DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSOOUT=1 Q
 W @IOF
 W !,"SCRIPTALK AUDIT HISTORY" S Y=DT X ^DD("DD") W ?40,"Date printed: ",Y,?70,"Page: ",PSOPGCT,!!
 S PSOPGCT=PSOPGCT+1
 W !,"Name: ",$E($P(^DPT(PSOPT,0),"^"),1,25),"    Currently enrolled: ",$S($G(^PS(55,"ASTALK",PSOPT)):"YES",1:"NO"),!!
 W !?24,"Previous",?35,"Previous"
 W !,?2,"Date-Time Set",?25,"Status",?35,"Indication",?52,"Entered by"
 W !,?2,"-------------------",?24,"--------",?35,"-------------",?52,"--------------------",!
 Q
 ;
ENQ ;
 W ! K DIR S DIR(0)="Y",DIR("B")="Y",DIR("A")="Do you want to report only active enrollees" D ^DIR K DIR D:$D(DIRUT) MESS G:Y["^"!($D(DIRUT)) DONE S PSOPRINT=$S(Y:1,1:0)
 W !!,"You may queue the report to print, if you wish.",!
 K %ZIS,POP,IOP S %ZIS="QM" D ^%ZIS I $G(POP) W !!,"Nothing queued to print.",! G DONE
 I $D(IO("Q")) S ZTRTN="RPENROLL^PSOTALK2",ZTDESC="Report of ScripTalk Enrollment",ZTSAVE("*")="" D ^%ZTLOAD K %ZSI W !,"Report queued to print.",! G DONE
RPENROLL ;
 U IO
 S PSOOUT=0,PSODV=$S($E(IOST)="C":"C",1:"P")
 S PSOPGCT=1
 D TITLEE I PSOOUT G DONE
 K ^TMP($J,"PSOTALK2")
 D GETDFN
 I '$D(^TMP($J,"PSOTALK2")) W !!,"No patients to report!",!! G DONE
 S PSONM="" F  S PSONM=$O(^TMP($J,"PSOTALK2",PSONM)) Q:PSONM=""  S PSOSSN="" F  S PSOSSN=$O(^TMP($J,"PSOTALK2",PSONM,PSOSSN)) Q:PSOSSN=""  D  I PSOOUT G DONE
 .S PSOIND=^TMP($J,"PSOTALK2",PSONM,PSOSSN)
 .I ($Y+5)>IOSL&('$G(PSOOUT)) D TITLEE I PSOOUT Q
 .W !,PSONM,?25," ",PSOSSN I 'PSOPRINT W ?43,$S(+$P(PSOIND,"^",3):"YES",1:"NO")
 .W !,?3,$S($P(PSOIND,"^",2)="B":"BLIND VETERAN",$P(PSOIND,"^",2)="L":"LOW VISION",1:" ")
 .W ?58,$$FMTE^XLFDT($P(PSOIND,"^")),!
 G END
 ;
TITLEE ;
 I $G(PSODV)="C",$G(PSOPGCT)'=1 W ! K DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSOOUT=1 Q
 W @IOF
 W !,"Report of ScripTalk Enrollment",?40,"Date printed: "_$$FMTE^XLFDT(DT),?70,"Page: ",PSOPGCT,!!
 S PSOPGCT=PSOPGCT+1
 W !,"Patient name",?25," SSN" I 'PSOPRINT W ?40,"Active enrollee?"
 W !?3,"Indication",?57,"Enrollment last updated"
 W !,"--------------",?25,"-----------" W:'PSOPRINT ?40,"-------------" W ?57,"-----------------------",!
 Q
 ;
GETDFN ;
 N DFN
 S PSODFN=0 F  S PSODFN=$O(^PS(55,"ASTALK",PSODFN)) Q:PSODFN=""  D
 .I PSOPRINT I '$G(^PS(55,"ASTALK",PSODFN)) Q
 .S DFN=PSODFN D DEM^VADPT I +$G(VADM(6)) Q  ; DECEASED
 .S PSOSEQ=$P($G(^PS(55,DFN,"SCTALK",0)),"^",4)
 .S PSOAUD=""
 .I PSOSEQ'="" S PSOAUD=$G(^PS(55,DFN,"SCTALK",PSOSEQ,0))
 .I $G(VA("PID"))="" S VA("PID")=" "
 .S ^TMP($J,"PSOTALK2",VADM(1),VA("PID"))=$P(PSOAUD,"^")_"^"_$P(PSOAUD,"^",3)_"^"_$G(^PS(55,"ASTALK",PSODFN))
 Q
 ;
MESS W !!,"No report printed!",!!
 Q
 ;
MAIL ; MAKE SURE MAIL STATUS IS COMPATIBLE WITH SCRIPTALK PATIENT
 N MAIL
 S MAIL=$G(^PS(55,PSOPT,0)) I $P(MAIL,"^",3)>1 Q
MAILP W !!,"REMINDER: CMOP does not fill ScripTalk prescriptions.Please select mail"
 W !,"status:  2 (DO NOT MAIL), 3 (LOCAL REGULAR MAIL) or 4 (LOCAL CERTFIED MAIL)."
 R !,"MAIL: ",MAIL:120
 I MAIL?1"^".E Q
 I MAIL<2!(MAIL>4) W !,"INVALID MAIL SETTING - ENTER 2,3, OR 4" G MAILP
 W "  ",$S(MAIL=2:"DO NOT MAIL",MAIL=3:"LOCAL REGULAR MAIL",1:"LOCAL CERTIFIED MAIL")
 S $P(^PS(55,PSOPT,0),"^",3)=MAIL
 Q
