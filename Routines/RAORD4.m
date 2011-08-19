RAORD4 ;HISC/CAH,FPT,GJC AISC/RMO-Print Requests by Date ;2/3/98  06:50
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;Call RAPSET1 to establish RAMDV
 D SET^RAPSET1 I $D(XQUIT) K XQUIT Q
 K RALOC I $P(RAMDV,"^",21) D ASKLOC G Q:'$D(RALOC)
 W !!,"Request Status Selection",!,"------------------------" S RARD("A")="Select Status: "
 S RARD(1)="Discontinued^print discontinued requests.",RARD(2)="Complete^print completed requests.",RARD(3)="Hold^print requests on hold."
 S RARD(4)="Pending^print pending requests.",RARD(5)="Request Active^print active requests.",RARD(6)="Scheduled^print scheduled requests."
 S RARD(7)="All Current Orders^print hold, pending, active and scheduled requests.",RARD("B")=4
 D SET^RARD K RARD G Q:X["^" S RAOASTS=$S($E(X)="D":"1",$E(X)="C":"2",$E(X)="H":"3",$E(X)="P":"5",$E(X)="R":"6",$E(X)="S":"8",$E(X)="A":"3;5;6;8",1:"") G Q:RAOASTS=""
 ;Based on whether user wants requests included based on Date Entered (fld 16) or Date Desired (fld 21), set RACRIT to correct piece # of Rad Order rec
 W !!!,"Date Criteria Selection",!,"-----------------------"
 K DIR S DIR(0)="S^E:ENTRY DATE OF REQUEST;D:DESIRED DATE FOR EXAM",DIR("A")="Date criteria to use for choosing requests to print",DIR("B")="E" D ^DIR G Q:$D(DTOUT)!($D(DUOUT)) S RACRIT=$S(Y="D":21,1:16) ;ch
 S RASKTIME="" S RADDT=1 D DATE1^RAUTL K RADDT,RASKTIME G Q:RAPOP
 D HS G Q:$D(DIRUT)
 S ZTRTN="START^RAORD4",ZTSAVE("BEGDATE")="",ZTSAVE("ENDDATE")="",ZTSAVE("RAOASTS")="",ZTSAVE("RAHS")="",ZTSAVE("RACRIT")="" S:$D(RALOC) ZTSAVE("RALOC")=""
 S:$D(RAOPT) ZTSAVE("RAOPT(")=""
 W ! D ZIS^RAUTL G:RAPOP Q
 ;
START ; Start printing process
 U IO K ^TMP($J,"RAHS"),^TMP($J,"RAORD4")
 S RABEGDT=$S($P(BEGDATE,".",2):BEGDATE,1:BEGDATE-.0001),RAENDDT=$S($P(ENDDATE,".",2):ENDDATE,1:ENDDATE+.9999)
 F RADFN=0:0 S RADFN=$O(^RAO(75.1,"AS",RADFN)) Q:'RADFN  F RALP=1:1 S RAOSTS=$P(RAOASTS,";",RALP) Q:RAOSTS=""  D CHKORD
 I '$D(^TMP($J,"RAORD4")) D  G Q
 . W:$Y>0 @IOF
 . W !?5,"There are no Requests for the selected Date Range."
 . Q
 S (RALNM,RAX)="",RAPGE=0 F RAILP=0:0 S RALNM=$O(^TMP($J,"RAORD4",RALNM)) Q:RALNM=""!(RAX["^")  F RAOURG=0:0 S RAOURG=$O(^TMP($J,"RAORD4",RALNM,RAOURG)) Q:'RAOURG!(RAX["^")  D CHKSTA
 ;
Q K BEGDATE,D,DN,DIROUT,DIRUT,DTOUT,DUOUT,ENDDATE,GMTSTYP,POP,RAPOP,RABEGDT,RACRIT,RADFN,RADTI,RACNI,RAENDDT,RAHS,RALIFN,RALNM,RALOC,RALP,RAOASTS,RAODTE,RAOIFN,RAOURG,RAPGE,RAX,DIC,RAILP,RAORD0,RAOSTS,VAERR,VAIN
 K ^TMP($J,"RAHS"),^TMP($J,"RAORD4")
 K RAMES,X,X1,Y,J,Z,ZTDESC,ZTRTN,ZTSAVE
 W ! D CLOSE^RAUTL
 D Q^RAORD5
 K C,DFN,DIC,DIR,DISYS,DIW,DIWT,D0,POP
 Q
 ;
 ;;The following code is used to SET-UP the utility global
CHKORD F RAOIFN=0:0 S RAOIFN=$O(^RAO(75.1,"AS",RADFN,RAOSTS,RAOIFN)) Q:'RAOIFN  I $D(^RAO(75.1,RAOIFN,0)) S RAORD0=^(0),RAODTE=+$P(RAORD0,"^",RACRIT) I RAODTE>RABEGDT,RAODTE<RAENDDT D CHKLOC:$D(RALOC),SETUTL:'$D(RALOC)
 Q
 ;
CHKLOC I RALOC="ALL"!(RALOC=+$P(RAORD0,"^",20)) S RALIFN=+$P(RAORD0,"^",20),RALNM=$S('$D(^RA(79.1,RALIFN,0)):"UNKNOWN",$D(^SC(+^(0),0)):$P(^(0),"^"),1:"UNKNOWN") D SETUTL
 Q
 ;
SETUTL S ^TMP($J,"RAORD4",$S($D(RALNM):RALNM,1:"L"),$S($P(RAORD0,"^",6):$P(RAORD0,"^",6),1:9),RAOSTS,RAODTE,RAOIFN)=RAORD0
 Q
 ;
ASKLOC R !!,"Select IMAGING LOCATION: ",X:DTIME Q:'$T!(X="^")!(X="")  I $E(X,1,3)="ALL"!($E(X,1,3)="all") S RALOC="ALL" Q
 S DIC="^RA(79.1,",DIC(0)="EMQ" D ^DIC I Y>0 S RALOC=+Y Q
 W:X'["?" *7 W !!?3,"Enter 'ALL' or select an Imaging Location to print pending requests." G ASKLOC
 ;
 ;;The following code is used to PRINT the utility global
CHKSTA F RAOSTS=0:0 S RAOSTS=$O(^TMP($J,"RAORD4",RALNM,RAOURG,RAOSTS)) Q:'RAOSTS!(RAX["^")  D CHKDTE
 Q
 ;
CHKDTE F RAODTE=0:0 S RAODTE=$O(^TMP($J,"RAORD4",RALNM,RAOURG,RAOSTS,RAODTE)) Q:'RAODTE!(RAX["^")  D CHKUTL
 Q
 ;
CHKUTL ; Print Health Summary if applicable
 N RA751 S RAOIFN=0
 F  S RAOIFN=$O(^TMP($J,"RAORD4",RALNM,RAOURG,RAOSTS,RAODTE,RAOIFN)) Q:'RAOIFN!(RAX["^")  D
 . S RADFN=+$G(^TMP($J,"RAORD4",RALNM,RAOURG,RAOSTS,RAODTE,RAOIFN))
 . S RA751(0)=$G(^RAO(75.1,RAOIFN,0)),RA751(2)=$P(RA751(0),"^",2)
 . D ^RAORD5 Q:RAHS=0!(RAX["^")
 . S GMTSTYP=+$P($G(^RAMIS(71,+RA751(2),0)),"^",13)
 . Q:GMTSTYP'>0!($D(^TMP($J,"RAHS",GMTSTYP,RADFN)))
 . I $E(IOST)="C" D CRCHK^RAORD6 Q:RAX["^"
 . K DIROUT W:$Y>0 @IOF D ENX^GMTSDVR(RADFN,GMTSTYP)
 . S RAPGE=0,^TMP($J,"RAHS",GMTSTYP,RADFN)=""
 . S:$D(DIROUT) RAX="^"
 . Q
 Q
HS ; print Health Summary for each patient?
 W ! K DIR,DIRUT,DIROUT,DTOUT,DUOUT
 S DIR(0)="Y",DIR("A")="Print HEALTH SUMMARY for each patient"
 D ^DIR K DIR
 Q:$D(DIRUT)
 S RAHS=+Y
 Q
