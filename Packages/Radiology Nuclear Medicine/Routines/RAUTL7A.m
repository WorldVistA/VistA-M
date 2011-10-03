RAUTL7A ;HISC/CAH,FPT-Utility for RACCESS array ;9/10/01  15:13
 ;;5.0;Radiology/Nuclear Medicine;**31**;Mar 16, 1998
LOCIMG1() ;Determines if user has access to more than one loc of
 ;the current imaging type
 ;Returns Null if more than one Rad/NM Loc, or if no access
 ;Returns Rad/NM Loc File 79.1 IEN if one only.
 N X,Y,Z,RALOCTOT S X=$O(RACCESS(DUZ,"LOC",0)) Q:'X ""
 S (RALOCTOT,X)=0 S Z=$O(^RA(79.2,"B",RAIMGTY,0))
 F  S X=$O(RACCESS(DUZ,"LOC",X)) Q:'X  D
 . I $P($G(^RA(79.1,X,0)),U,6)=Z S RALOCSAV=X,RALOCTOT=RALOCTOT+1
 . Q
 I RALOCTOT=1 Q RALOCSAV
 Q ""
ERROR ; Display error message
 W !!?5,"You do not have access to any Imaging Locations."
 W !?5,"Contact your ADPAC for further assistance.",$C(7)
 Q
IMGNUM() ; Detrmines the number of selectable imaging types based on
 ; division parameters.  Called fron SELIMG^RAUTL7
 N X,Y S (X,Y)=0
 F  S X=$O(^TMP($J,"DIV-IMG",X)) Q:X'>0  S Y=Y+1
 Q Y
SETUP ; Setup temp global to screen i-type by division
 ; Requires ^TMP($J,"RA D-TYPE",Division name), RACCESS "DIV-IMG"
 ; elements.  Creates ^TMP($J,"DIV-IMG",Imaging Type IEN)=""
 ; Called fron SELIMG^RAUTL7
 N RAX,RAY,RAZ S RAX=""
 F  S RAX=$O(^TMP($J,"RA D-TYPE",RAX)) Q:RAX']""  D
 . I $D(RACCESS(DUZ,"DIV-IMG",RAX)) D
 .. S RAY="" F  S RAY=$O(RACCESS(DUZ,"DIV-IMG",RAX,RAY)) Q:RAY']""  D
 ... S RAZ=+$O(^RA(79.2,"B",RAY,0)),^TMP($J,"DIV-IMG",RAZ)=""
 ... Q
 .. Q
 . Q
 Q
LOCNUM() ;Detrmines the number of selectable imaging locations based on
 ; division parameters.  Called fron SELLOC^RAUTL7
 N X,Y S (X,Y)=0
 F  S X=$O(^TMP($J,"DIV-ITYP-ILOC",X)) Q:X'>0  S Y=Y+1
 Q Y
SETUPL ; Setup temp global to screen img-loc, where
 ;    img-loc must be within previously selected img-typ(s)
 ; Requires RACCESS(duz,"LOC") and ^TMP($J,"RA ITYPE")
 ; Creates ^TMP($J,"DIV-ITYP-ILOC",Img Loc ien)
 ; and  eg. RACCESS(duz,"DIV-ITYP-ILOC","cgo(ws)","gen rad","x-ray")
 ; Called from SELLOC^RAUTL7
 N RAX,RAY,RAZ,RAW
 S RAX=0
 ; allow other img locations with img types that match at least one
 ; of the user's accessible img location's img types
 ; so, loop thru all img locations
SETUPL1 S RAX=$O(^RA(79.1,RAX)) Q:'RAX  ;eg. 7
 S RAY=+$P(^RA(79.1,RAX,0),"^",6) G:RAY="" SETUPL1 ;eg. 1
 G:'$O(^TMP($J,"RA I-TYPE",$P($G(^RA(79.2,+RAY,0)),U),0)) SETUPL1
 S RAZ=$P($G(^RA(79.1,RAX,"DIV")),U) G:RAZ="" SETUPL1 ;eg. 639
 S RAW=$P(^DIC(4,+RAZ,0),U) G:RAW="" SETUPL1 ;eg. CHICAGO (WS)
 ; match on selected imaging type
 G:'$D(^TMP($J,"RA I-TYPE",$P($G(^RA(79.2,+RAY,0)),"^"),+RAY)) SETUPL1
 ; match on selected division(s)
 G:'$D(^TMP($J,"RA D-TYPE",RAW,RAZ)) SETUPL1
 S ^TMP($J,"DIV-ITYP-ILOC",RAX)=""
 ; following line replaces original code from DIVIACC section of ^RAUTL7
 ; raccess(duz,"DIV-ITYP-ILOC" is used by ZEROUT^RADLY1 to
 ; zerout the ^tmp($j,"radly"   nodes
 S RACCESS(DUZ,"DIV-ITYP-ILOC",RAW,$P($G(^RA(79.2,+RAY,0)),"^"),$P($G(^SC(+$P($G(^RA(79.1,+RAX,0)),U),0)),U))=""
 G SETUPL1
 Q
VERIFY ; verify old reports
 ; back door function to "administratively verify" old reports 
 ; that were never verified
 W !,"This subroutine prompts you for a date and places all unverified reports"
 W !,"through that date into a status of Verified.",!
 I '$D(^RARPT("ASTAT")) W !!,"NO UNVERFIED REPORTS CROSS REFERENCE" Q
 K DIR S DIR(0)="D",DIR("A")="Enter a date",DIR("?")="All unverified reports through this date will be marked as Verified."
 D ^DIR K DIR I $D(DIRUT) D KILL Q
 S RAENDATE=Y
DEVICE ;
 S ZTRTN="START^RAUTL7A",ZTDESC="Rad/Nuc Med Verify Old Reports",ZTSAVE("RAENDATE")=""
 D ZIS^RAUTL
 I RAPOP D KILL Q
START ;
 U IO K DIR,DIRUT,DIROUT,DTOUT,DUOUT
 S RASTATUS="",(RACOUNT,RAPAGE)=0,RAENDATE=$P(RAENDATE,".")_"."_9999
 S:$D(ZTQUEUED) ZTREQ="@"
 D NOW^%DTC S Y=X X ^DD("DD") S RATIME=Y
 D HEADER
 F  S RASTATUS=$O(^RARPT("ASTAT",RASTATUS)) Q:RASTATUS=""!($D(DIRUT))  S RARPT=0 F  S RARPT=$O(^RARPT("ASTAT",RASTATUS,RARPT)) Q:RARPT'>0  D  Q:$D(DIRUT)
 .S RARPT0=$G(^RARPT(RARPT,0)) Q:RARPT0=""
 .S RADTE=$P(RARPT0,U,3) Q:RADTE=""!(RADTE>RAENDATE)
 .S RADFN=$P(RARPT0,U,2) Q:RADFN=""
 .S RADTI=9999999.9999-RADTE
 .S RACNI=$O(^RADPT("ADC",$P(RARPT0,U,1),RADFN,RADTI,0)) Q:RACNI=""
 .S DFN=RADFN D DEM^VADPT
 .S RANAME=$P(VADM(1),U,1),RASSN=$P(VADM(2),U,2) K DFN,VADM
 .S RACOUNT=RACOUNT+1
 .S RADPT0=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 .S RARES=+$P(RADPT0,U,12) I $D(^VA(200,RARES,0)) S RARES=$P(^VA(200,RARES,0),U,1)
 .S RASTAFF=+$P(RADPT0,U,15) I $D(^VA(200,RASTAFF,0)) S RASTAFF=$P(^VA(200,RASTAFF,0),U,1)
 .W !!,$P(RARPT0,U,1),?15,RANAME_"  ("_RASSN_")",?60,"Status: ",RASTATUS
 .W !,"Resident: ",$S(RARES=0:"<none>",RARES]"":RARES,1:"<none>")
 .W ?43,"Staff: ",$S(RASTAFF=0:"<none>",RASTAFF]"":RASTAFF,1:"<none>")
 .K DIE,DR S DIE="^RARPT(",DR="5////V",DA=RARPT D ^DIE
 .I ($Y+4)>IOSL D  Q:$D(DIRUT)  W @IOF D HEADER
 ..Q:$E(IOST)'="C"
 ..K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 ..S DIR(0)="E" D ^DIR K DIR
 ..Q
 .I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 DIRUT=1
 .Q
 W !!,"Total: ",RACOUNT
KILL ;
 K %,DIR,DIROUT,DIRUT,DTOUT,DUOUT,POP,RACNI,RACOUNT,RADFN,RADPT0,RADTE,RADTI,RAENDATE,RANAME,RAPAGE,RAPOP,RARPT,RARPT0,RARES,RASSN,RATIME,RASTAFF,RASTATUS,X,Y,ZTDESC,ZTRTN,ZTSAVE
 D CLOSE^RAUTL
 Q
HEADER ;
 W:$Y>0 @IOF
 S RAPAGE=RAPAGE+1
 W "Verify Reports Prior to "_$E(RAENDATE,4,5)_"/"_$E(RAENDATE,6,7)_"/"_$E(RAENDATE,2,3)
 W !,"Run Date/Time: ",RATIME,?70,"Page: ",RAPAGE
 W !,$$REPEAT^XLFSTR("-",79),!
 Q
DISPLAY ; back door function to display all reports not verified in file 74
 ; prints [captioned] dump of entire record
 W !!,"This subroutine loops through the unverified reports cross-reference of"
 W !,"File 74 and displays the report entry including computed field values.",!!
 D ^%ZIS
 U IO W:$Y>0 @IOF
 S RA4CHX=""
 F  S RA4CHX=$O(^RARPT("ASTAT",RA4CHX)) Q:RA4CHX=""!($D(DIRUT))  D
 . S RA4CHX1=0 F  S RA4CHX1=$O(^RARPT("ASTAT",RA4CHX,RA4CHX1)) Q:'RA4CHX1!($D(DIRUT))  D
 .. I $D(^RARPT(RA4CHX1,0)) S DIC="^RARPT(",DA=+RA4CHX1,DIQ(0)="C" W:$Y>0 @IOF D EN^DIQ I '$D(DIRUT) D  Q:$D(DIRUT)
 ...Q:$E(IOST)'="C"
 ...K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 ...S DIR(0)="E" D ^DIR K DIR
 ...Q
 D ^%ZISC
 K A,D0,D1,DA,DIC,DIQ,DIRUT,DIW,DIWF,DIWL,DIWR,DIWT,DK,DL,DN,DTOUT,DUOUT,DX,I,POP,RA4CHX,RA4CHX1,RACN,RARPT,S,X,Y
 Q
