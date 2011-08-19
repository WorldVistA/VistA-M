ECXTREX ;BPFO/JRP - Queue DSS Fiscal Year Specific Extract;8-AUG-2003 ; 6/11/09 3:43pm
 ;;3.0;DSS EXTRACTS;**49,71,84,92,105,112,120**;Dec 22, 1997;Build 43
 ;
EN ;Main entry point
 W @IOF
 N DIC,X,Y,DTOUT,DUOUT
 W !,"****************************************************************"
 W !,"*                                                              *"
 W !,"* Use this option with caution since it will allow you to      *"
 W !,"* run any supported DSS extract using specific fiscal year     *"
 W !,"* logic.  By running this option you may negatively impact     *"
 W !,"* your extract data.                                           *"
 W !,"*                                                              *"
 W !,"* DO NOT USE this option unless you are an official test site  *"
 W !,"* for the DSS Fiscal Year Conversion.                          *"
 W !,"*--------------------------------------------------------------*"
 W !,"*                                                              *"
 W !,"* Note that this option does not update the last date used for *"
 W !,"* the given extraction.  It also does not verify that the time *"
 W !,"* frame selected is after the last date used for the extract.  *"
 W !,"*                                                              *"
 W !,"****************************************************************"
 W !!
 D PAUSE
 ;does user hold key?
 ;I '$$KCHK^XUSRB("ECX DSS TEST",$G(DUZ)) D  Q
 ;.W !!,"You do not have approved access to this option.",!,"Exiting...",!!
 ;.D PAUSE
 ;is this a test site for DSS FY conversion patch?
 ;I '$$CHKTEST^ECXTREX() D  Q
 ;.W !!,"This site is not a DSS Fiscal Year Conversion test site.",!,"Exiting...",!!
 ;.D PAUSE
 N ECXTEST,ECXREL S ECXTEST=$$CHKTEST^ECXTREX()
 ;
 ;Pick extract to queue
 S DIC="^ECX(727.1,"
 S DIC(0)="AEQMZ"
 S DIC("A")="Select DSS Extract to queue: "
 S DIC("S")="I ('$P(^(0),U,12))&($P(^(0),U,8)'="""")&($G(^(7))'[""Inactive"")"
 S DIC("W")="W ""("",$P(^(0),U,8),"")"""
 D ^DIC
 I ($D(DUOUT))!($D(DTOUT))!(Y<1) Q
 N ECXRTN,ECXDA
 S ECXDA=+Y
 ;Get extract specific routine name
 S ECXRTN=$G(^ECX(727.1,ECXDA,"ROU"))
 I ECXRTN="" D  Q
 .W !!,"Selected extract is not correctly defined in the EXTRACT"
 .W !,"DEFINITIONS file (#727.1).  The ROUTINE field (#4) does not"
 .W !,"have a value in it."
 .W !
 .D PAUSE
 ;Get time frame for extract
 N STRTDT,ENDDT,DIR,DIRUT,DIROUT,OUT,ECXDATES
 S OUT=0 F  S (STRTDT,ENDDT)="" D  Q:OUT
 .;Get start date (must be in past)
 .S DIR(0)="DOA"
 .S $P(DIR(0),"^",2)=":"_DT_":AEXP"
 .S DIR("A")="Starting with Date: "
 .D ^DIR
 .I $D(DIROUT)!$D(DIRUT)!(Y="") S (STRTDT,ENDDT)="" S OUT=1 Q
 .S STRTDT=Y
 .K DIR
 .;Get end date (must be in same month; must be in past)
 .S DIR(0)="DOA"
 .S X=$E(STRTDT,1,5)_"01"
 .S X=$$FMADD^XLFDT(X,32)
 .S X=$$FMADD^XLFDT(X,-($E(X,6,7)))
 .I X>DT S X=DT
 .S $P(DIR(0),"^",2)=STRTDT_":"_X_":AEXP"
 .S DIR("A")="Ending with Date: "
 .S DIR("B")=$$FMTE^XLFDT(X,"5D")
 .D ^DIR
 .I $D(DIROUT)!$D(DIRUT)!(Y="") S (STRTDT,ENDDT)=""  S OUT=1 Q
 .S ENDDT=Y
 .S OUT=1
 Q:(STRTDT="")!(ENDDT="")
 S ECXDATES=STRTDT_"^"_ENDDT_"^1"
LOGIC ;Get extract logic to use
 N ECXLOGIC,YEAR,ECXY,ECXFY,ECXREL
 S ECXFY=$P($P(ECXTEST,"#",2),"FY",2)
 S ECXREL=$P(ECXTEST,"#",3)
 S YEAR=$E(DT)+17_$E(DT,2,3)
 S X=$E(DT,1,3)_"1000" I DT>X D
 . I (ECXREL)!($$KCHK^XUSRB("ECX DSS TEST",$G(DUZ))) S YEAR=YEAR+1
 K DIR
 S DIR("A")="Select fiscal year logic to use for extract"
 S DIR(0)="SO^"
 F X=YEAR-2:1:YEAR D
 .S Y=$E(X,5)
 .S Y=$S((Y="")!(Y=" "):"",1:"Revision "_Y_" of ")
 .S DIR(0)=DIR(0)_X_":"_Y_"Fiscal Year "_$E(X,1,4)_";"
 I $$KCHK^XUSRB("ECX DSS TEST",$G(DUZ)) D
 .S X=$E(DT,1,3)_"1000" I DT'>X S X=YEAR+1 D
 ..S Y=$E(X,5)
 ..S Y=$S((Y="")!(Y=" "):"",1:"Revision "_Y_" of ")
 ..S DIR(0)=DIR(0)_X_":"_Y_"Fiscal Year "_$E(X,1,4)_";"
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) Q
 S ECXLOGIC=Y
 N ECXERR S ECXERR=0
 I ECXLOGIC>YEAR D
 . I ECXREL Q
 . S ECXERR=1
 I ECXLOGIC=YEAR D
 . I YEAR'=ECXFY Q
 . I ECXREL Q
 . S ECXERR=1
 I ECXERR S ECXERR=0 D  I ECXERR Q
 . S DIR(0)="Y" W !
 . S DIR("A",1)="WARNING: Logic has not been released for this year.  Do not use unless directed"
 . S DIR("A")="by DSO.  Do you want to continue",DIR("B")="YES" D ^DIR
 . S:$G(DIRUT) ECXERR=1 S:Y=0 ECXERR=1
 ;Queue extract
 D @("BEG^"_ECXRTN)
 Q
PAUSE ;pause screen
 N DIR,X,Y
 S DIR(0)="E"
 W !!
 D ^DIR
 W !!
 Q
 ;
CHKTEST() ;check/set release version
 ; input none
 N ECXY,ECXNM,ECXDT,FDA,JJ,LINE,RESULT,XX
 ;get patch name from field #73
 S ECXY=$$GET1^DIQ(728,"1,",73) I ECXY="" Q ""
 S ECXNM=$P(ECXY,"#"),ECXFY=$P(ECXY,"#",2),ECXSQ=$P(ECXY,"#",3)
 ;if Kernel function not on system, allow access by default
 S LINE="INSTALDT^XPDUTL",JJ=$T(@LINE) I JJ="" Q ""
 ;quit if patch never installed
 S JJ=$$INSTALDT^XPDUTL(ECXNM,.RESULT) I 'JJ Q ""
 ;get status of last patch of that name installed here
 S ECXDT=$O(RESULT(""),-1) I 'ECXDT Q ""
 S XX=RESULT(ECXDT)
 ;if last version is national, set field #73,
 I $P(XX,U,2) S ECXSQ=$P(XX,U,2)
 D TESTON(ECXNM,ECXFY,ECXSQ)
 Q $$GET1^DIQ(728,"1,",73)
 ;INSTALDT^XPDUTL doesn't work for host file
 ;
TESTON(XPDNM,ECXFY,ECXSQ) ;sets field #73 of file #728
 ; input XPDNM - variable defined by KIDS; name of patch
 ;       ECXFY - variable defined for patch fiscal year extract
 ;       ECXSQ - variable defined for patch release sequence # (optional)
 ; output none
 ; called only by post-install routine of DSS FY Conversion patch
 ;   if patch is TEST version
 N ECXNM,FDA
 S ECXNM=$G(XPDNM)
 S ECXFY=$G(ECXFY)
 S ECXSQ=$G(ECXSQ)
 Q:(ECXNM="")
 Q:(ECXFY="")
 ;update field #73 of file #728
 S FDA(728,"1,",73)=ECXNM_"#"_ECXFY_"#"_ECXSQ
 D FILE^DIE("","FDA")
 ;if released version & not a field office, then, kill testing key
 I ($G(ECXSQ)'=""),'$$FODMN2() D
 .N ECXSKEY
 .S ECXSKEY=$$LKUP^XPDKEY("ECX DSS TEST") Q:'ECXSKEY
 .D DEL^XPDKEY(+$G(ECXSKEY))
 Q
 ;
FODMN2(DOMAIN) ;Is domain a field office domain
 ;Input : DOMAIN - Domain name to check
 ;               - Default value pulled from ^XMB("NETNAME")
 ;Used in TESTON^ECXTREX to delete security key ECX DSS TEST after
 ;testing.
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
