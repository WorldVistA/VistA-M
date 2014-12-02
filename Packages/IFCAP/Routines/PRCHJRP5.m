PRCHJRP5 ;OI&T/DDA - Transaction Report from 414.06 ;3/22/13 13:48
 ;;5.1;IFCAP;**174**;Oct 20,2000;Build 23
 ;Per VHA Directive 2004-38, this routine should not be modified.
 ;
 Q
EN ;Revised Transaction Report
 ;setup user data
 K XQORNOD D OP^XQCHK
 S PRCHOPT=$S($P(XQOPT,"^")="PRCHJ TRANS REPORT":1,$P(XQOPT,"^")="PRCHJ TRANS REPORT2":2,$P(XQOPT,"^")="PRCHJ TRANS REPORT3":3,1:0)
 I PRCHOPT=0 W !!,"REPORT MUST BE RUN FROM APPROPRIATE MENU OPTIONS." Q
 S:$G(PRCHEMP)="" PRCHEMP=$$GET1^DIQ(200,DUZ_",",400,"I")
 I PRCHOPT=1 I '((PRCHEMP=2)!(PRCHEMP=4)) W !!,"You are not a PPM Accountable Officer or Manager!" Q
EN2 ;
 D USERFCP
 I PRCHURSN=0 W !!,"You do not have access to any Fund Control Points!" Q
ENSING ;prompt for a single 2237
 K DIR
 S PRCH2237=0
 S DIR("A")="Select a single 2237 TRANSACTION NUMBER"
 S DIR(0)="Y",DIR("B")="NO" D ^DIR
 ;If YES go to lookup and display for a single 2237.
 I Y=1 K DIR D SINGLE I PRCH2237=0 G ENSING
 I PRCH2237'=0 G FAUXPR
 S PRCH2237="ALL"
 I $G(DUOUT)!$G(DTOUT) G EXIT
 K DIR
ENECMS ;prompt for a unique eCMS contact. PRCHECMS equals ALL or selection from ACONTACT cross-reference.
 S DIR("A")="Select a single eCMS Contact"
 S DIR(0)="Y",DIR("B")="NO" D ^DIR
 ;If NO, set PRCHECMS="ALL". If YES lookup eCMS contact then return.
 I Y=0 S (PRCHEML,PRCHECMS)="ALL"
 I Y=1 D ECMS I PRCHECMS=0 G ENECMS
 I $G(DUOUT)!$G(DTOUT) G EXIT
 K DIR
DATE ;prompt for a date range.
 ;get default start and end dates
 S PRCHDATE=$P($O(^PRCV(414.06,"AED","")),".")
 S (PRCHSTDT,Y)=$P(PRCHDATE,".") D DD^%DT S PRCHSTAR=Y
 D NOW^%DTC S (PRCHENDT,Y)=X D DD^%DT S PRCHEND=Y
 K Y
 S DIR("A")="Select ALL DATES: ("_PRCHSTAR_" - "_PRCHEND_")"
 S DIR(0)="Y",DIR("B")="NO" D ^DIR
 ;If YES, set PRCHDATE="ALL" for "ALL DATES". If NO prompt for START and END dates.
 I Y=1 S PRCHDATE="ALL"
 I Y=0 D  I PRCHSTDT=0 G DATE
 .K DIR,Y
 .; get start date
 .S PRCHSTDT=0
 .S DIR("A")="   Starting date: "
 .S DIR(0)="DA^"_PRCHDATE_":NOW:EX",DIR("B")="TODAY" D ^DIR
 .S:Y'="^" PRCHSTDT=Y
 .Q:Y="^"
 .; get end date
 .K DIR,Y
 .S PRCHENDT=0
 .S DIR("A")="   Ending date: "
 .S DIR(0)="DA^"_PRCHSTDT_":NOW:EX",DIR("B")="TODAY" D ^DIR
 .S:Y'="^" PRCHENDT=Y
 .S:Y="^" PRCHSTDT=0
 .Q
 I $G(DUOUT)!$G(DTOUT) G EXIT
 K DIR
ENSTN ;prompt for a unique station or substation. PRCHSTN equals ALL or selection from ASN cross-reference.
 ;If user has access to only one station, set the variable to that station and skip the prompt.
 ; And if the station selected does not have substations be sure to skip asking for them.
 S PRCSUBF=0
 I PRCH411=1 S PRCHSTN=$O(PRCH411(0)) S PRCSUBF=1 D:+$G(PRCH411(PRCHSTN)) SUBSTN S:$G(PRCHSUB)="" PRCHSUB="ALL" G ENFCP
 I (PRCHOPT=2)&(PRCHURSN=1) S PRCHSTN=$O(PRCHURSN(0)) D:+$G(PRCH411(PRCHSTN)) SUBSTN S:$G(PRCHSUB)="" PRCHSUB="ALL" G ENFCP
 S DIR("A")="Select a single STATION NUMBER"
 S DIR(0)="Y",DIR("B")="NO" D ^DIR
 ;If NO, set PRCHSTN="ALL". If YES lookup station contact then return.
 I Y=0 S PRCHSTN="ALL",PRCHSUB="ALL"
 I Y=1 D STN I PRCHSTN=0 G ENSTN
 I $G(DUOUT)!$G(DTOUT) G EXIT
 K DIR
ENFCP ;prompt for a unique Fund Control Point. PRCHFUND equals ALL or selection from ACP cross-reference.
 ;gather FCP accessable to this end-user 
 S DIR("A")="Select a single FUND CONTROL POINT"
 S DIR(0)="Y",DIR("B")="NO" D ^DIR
 ;If NO, set PRCHFUND="ALL". If YES lookup control point.
 I Y=0 S PRCHFUND="ALL"
 I Y=1 D FCP I PRCHFUND=0 G ENFCP
 I $G(DUOUT)!$G(DTOUT) G EXIT
 K DIR
ENTYPE ;
 S DIR(0)="LA^1:4",DIR("B")="1-4"
 S DIR("?")="This response must be a list or range, e.g., 1,3 or 1-2,4."
 S DIR("A",1)="TRANSACTION EVENTS:"
 S DIR("A",2)=""
 S DIR("A",3)=" 1 Sent to eCMS (includes resent 2237s)"
 S DIR("A",4)=" 2 Returned to Accountable Officer"
 S DIR("A",5)=" 3 Returned to Control Point"
 S DIR("A",6)=" 4 Cancelled within eCMS"
 S DIR("A",7)=""
 S DIR("A")="Select one or more of the above events: "
 D ^DIR
 S PRCHTYPE=Y,PRCHTT=0,PRCHTYTX=""
 F I=1:1 S PRCHTT=$P(PRCHTYPE,",",I) Q:PRCHTT=""  S:PRCHTYTX'="" PRCHTYTX=PRCHTYTX_", " S PRCHTYTX=PRCHTYTX_$S(PRCHTT=1:"Sent to eCMS",PRCHTT=2:"Returned to AO",PRCHTT=3:"Returned to CP",PRCHTT=4:"Cancelled within eCMS",1:"")
 I $G(DUOUT)!$G(DTOUT) G EXIT
 K DIR
ENERROR ;prompt for inclusion of ERROR text.  Default = NO, do not include error text.
 S DIR("A")="Display event ERROR TEXT"
 S DIR(0)="Y",DIR("B")="NO" D ^DIR
 ;If NO, set PRCHERTX=0.
 I Y=0 S PRCHERTX=0
 I Y=1 S PRCHERTX=1
 I $G(DUOUT)!$G(DTOUT) G EXIT
 K DIR
 ; This is the end of the sort selection.  Send to display/print.
 D FAUXPR
 Q
 ;
SINGLE ;
 K DIC
 S DIC=414.06,DIC(0)="AEQZ",D="B"
 S DIC("A")="Select a 2237: "
 S:PRCHOPT=2 DIC("S")="S PRCH=$P(^(0),U) I $D(PRCHURCP($S($P(PRCH,""-"",4)'="""":$P(PRCH,""-"",4),1:PRCH),+$G(PRCHURSN($P(PRCH,""-"")))))=1"
 D IX^DIC
 K DIC,PRCH,RESULTS
 Q:Y=-1
 S PRCH2237=Y(0,0),PRCHERTX=1
 K DIR
 Q
 ;
ECMS ;Returns with PRCHECMS set.  Failure code = 0
 S PRCHECMS=0
 K DIR
 W !
 ; Populate DIR(0) for a SET of CODES DIR call
 S DIR("L",1)="Select one of the following eCMS Contacts:"
 S DIR("L",2)=""
 S DIR(0)="SO^",PRCRIL=2,PRCRI=0,PRCETMP0=""
 F  S PRCETMP0=$O(^PRCV(414.06,"AUNQEC",PRCETMP0)) Q:PRCETMP0=""  D
 . S PRCRI=PRCRI+1,PRCRIL=PRCRIL+1,PRCETMP1=$P(PRCETMP0,"  "),PRCETMP3=$P(PRCETMP0,"  ",2)
 . S:PRCRI>1 DIR(0)=DIR(0)_";"
 . S DIR(0)=DIR(0)_PRCRI_":"_PRCETMP1
 . S:PRCRI<10 DIR("L",PRCRIL)=" "
 . S DIR("L",PRCRIL)=$G(DIR("L",PRCRIL))_"  "_PRCRI_"  "_PRCETMP0
 .Q
 S DIR("L")=""
 D ^DIR
 Q:$G(DUOUT)!$G(DTOUT)!$D(DIRUT)
 S PRCRIL=Y+2
 S PRCHECMS=$P(DIR("L",PRCRIL),Y_"  ",2)
 S PRCHEML=$P(PRCHECMS,"  ",2)
 K DIR,PRCRIL
 Q
 ;
STN ;Returns with PRCHSTN set.  Failure = 0
 ; EXCLUDE SUBSTATIONS from inital lookup.
 S PRCHSTN=0
 K DIR
 S DIR(0)="PO^411:AEQ"
 S DIR("A")="Select Station"
 S DIR("S")="I (+$P(^(0),U)=$P(^(0),U))&($D(PRCHJSN($P(^(0),U)))=1)"
 S:PRCHOPT=2 DIR("S")="I ($D(PRCHURSN(+($P(^(0),U))))=1)&(+$P(^(0),U)=$P(^(0),U))&($D(PRCHJSN($P(^(0),U)))=1)"
 D ^DIR
 K PRCRI ; Variable left over from DD; file 411 lookup post action code.
 Q:$G(DUOUT)!$G(DTOUT)!$D(DIRUT)
 S PRCHSTN=$P(Y,"^",2)
SUBSTN ;Returns PRCHSUB = ALL if the user does not want to select a substation.
 S PRCHSUB=""
 I +$G(PRCH411(PRCHSTN))=0 S PRCHSUB="ALL" Q
 S DIR("A")="   Do you want to see the records for ALL the substations of "_PRCHSTN
 S DIR(0)="Y",DIR("B")="YES" D ^DIR
 I Y=1 S PRCHSUB="ALL" Q
 I $G(DUOUT)!$G(DTOUT)!$D(DIRUT) G:'PRCSUBF STN Q
 K DIR
 S DIR(0)="SO^1:"_PRCHSTN_"  "_PRCH411(PRCHSTN,PRCHSTN)
 S PRCRI=1,PRCHSUB=PRCHSTN
 F  S PRCHSUB=$O(PRCH411(PRCHSTN,PRCHSUB)) Q:+PRCHSUB'>0  S:$D(PRCHJSB(PRCHSUB))=1 PRCRI=PRCRI+1,DIR(0)=DIR(0)_";"_PRCRI_":"_PRCHSUB_"  "_PRCH411(PRCHSTN,PRCHSUB)
 S DIR("A")="SUBSTATION" D ^DIR
 ;Returns PRCHSUB = "NONE" if user selects the PRIMARY station number,
 ;   otherwise PRCHSUB is the substation number and PRCHSTN = "SUB".
 I $G(DUOUT)!$G(DTOUT)!$D(DIRUT) G SUBSTN
 S PRCHSUB=$P(Y(0),"  ")
 I PRCHSUB'=PRCHSTN S PRCHSTN="SUB" Q
 S:PRCHSUB=PRCHSTN PRCHSUB="NONE"
 Q
 ;
FCP ; Allow selection of a FCP.
 ; All FCP accessible to this user are stored in the following array which can be used for AO screening.
 ;  PRCHURCP(fcp with any leading zeros,station)=full fcp text
 S PRCHFUND=0
 S DIC=414.06,DIC(0)="AEQSZ",D="AUNQFCP"
 S DIC("A")="Fund Control Point: "
 S DIC("W")=""
 ; No screen if AO and ALL stations
 ; Screens
 ; AO/Manager/Fiscal and a station
 S:(PRCHOPT=1)&(+PRCHSTN'=0) DIC("S")="I $D(PRCHURCP($S($P(X,""-"",4)'="""":$P(X,""-"",4),1:X),$E(PRCHSTN,1,3)))=1"
 S:(PRCHOPT=1)&(PRCHSTN="SUB") DIC("S")="I $D(PRCHURCP($S($P(X,""-"",4)'="""":$P(X,""-"",4),1:X),$E(PRCHSUB,1,3)))=1"
 S:(PRCHOPT=3)&(+PRCHSTN'=0) DIC("S")="I $D(PRCHURCP($S($P(X,""-"",4)'="""":$P(X,""-"",4),1:X),$E(PRCHSTN,1,3)))=1"
 S:(PRCHOPT=3)&(PRCHSTN="SUB") DIC("S")="I $D(PRCHURCP($S($P(X,""-"",4)'="""":$P(X,""-"",4),1:X),$E(PRCHSUB,1,3)))=1"
 ; CP and ALL stations
 S:(PRCHOPT=2)&(PRCHSTN="ALL") DIC("S")="I $D(PRCHURCP($S($P(X,""-"",4)'="""":$P(X,""-"",4),1:X)))=10"
 ; CP and a station/substation
 S:(PRCHOPT=2)&(+PRCHSTN'=0) DIC("S")="I $D(PRCHURCP($S($P(X,""-"",4)'="""":$P(X,""-"",4),1:X),$E(PRCHSTN,1,3)))=1"
 S:(PRCHOPT=2)&(PRCHSTN="SUB") DIC("S")="I $D(PRCHURCP($S($P(X,""-"",4)'="""":$P(X,""-"",4),1:X),$E(PRCHSUB,1,3)))=1"
 D IX^DIC
 Q:Y=-1
 S PRCHFUND=$P(Y(0,0),"-",4)
 W "  "_PRCHFUND
 K DIC,D
 Q
 ;
USERFCP ; Build the arrays of the FCPs and Stations the user has access to.
 K PRCHURCP,PRCHURSN
 ; Build array for Stations and Substations that exist in 414.06
 S PRCHI=0
 F  S PRCHI=$O(^PRCV(414.06,"ASN",PRCHI)) Q:+PRCHI'>0  S PRCHJSN(PRCHI)=""
 S PRCHI=""
 F  S PRCHI=$O(^PRCV(414.06,"ASB",PRCHI)) Q:PRCHI=""  S PRCHJSB(PRCHI)=""
 S PRCHURLV="OTHER"
 ; Set PPM Accountable Officers and Managers to the same access level (PRCHURLV)
 S:(PRCHEMP=2)!(PRCHEMP=4) PRCHURLV="AO"
 S (PRCH420,PRCHURSN)=0
 ; Allow access to all FCP if using AO option AND file 200 SUPPLY EMPLOYEE access level is AO or Manager OR if entered on REPORT3.
 I ((PRCHOPT=1)&(PRCHURLV="AO"))!(PRCHOPT=3) F  S PRCH420=$O(^PRC(420,PRCH420)) Q:+PRCH420'>0  D
 .S PRCH4206=0
 .F  S PRCH4206=$O(^PRC(420,PRCH420,1,PRCH4206)) Q:+PRCH4206'>0  D
 ..S PRCH6=$P($G(^PRC(420,PRCH420,1,PRCH4206,0)),"^")
 ..Q:PRCH6=""
 ..Q:$P($G(^PRC(420,PRCH420,1,PRCH4206,0)),"^",11)'="Y"
 ..S:'$D(PRCHURSN(PRCH420)) PRCHURSN(PRCH420)=PRCH420,PRCHURSN=PRCHURSN+1
 ..S PRCHURCP($P(PRCH6," "),PRCH420)=PRCH6
 ..Q
 .Q
 ; If entring on REPORT2, check for individual's assigned FCP regardless of file 200 SUPPLY EMPLOYEE access level.
 ;   This is also restriced within 420 to disallow REQUESTER acccess (only allow CP Clerk or CP Official)
 I PRCHOPT=2 S PRCHURSN=0 F  S PRCH420=$O(^PRC(420,PRCH420)) Q:+PRCH420'>0  D
 .S PRCH4206=0
 .F  S PRCH4206=$O(^PRC(420,PRCH420,1,PRCH4206)) Q:+PRCH4206'>0  D
 ..S PRCH6=$P($G(^PRC(420,PRCH420,1,PRCH4206,0)),"^")
 ..Q:PRCH6=""
 ..Q:$P($G(^PRC(420,PRCH420,1,PRCH4206,0)),"^",11)'="Y"
 ..Q:'+$G(^PRC(420,PRCH420,1,PRCH4206,1,DUZ,0))
 ..Q:(+$P($G(^PRC(420,PRCH420,1,PRCH4206,1,DUZ,0)),"^",2)=3)!(+$P($G(^PRC(420,PRCH420,1,PRCH4206,1,DUZ,0)),"^",2)=0)
 ..S:'$D(PRCHURSN(PRCH420)) PRCHURSN(PRCH420)=PRCH420,PRCHURSN=PRCHURSN+1
 ..S PRCHURCP($P(PRCH6," "),PRCH420)=PRCH6
 ..Q
 .Q
 ; Set count for IFCAP instance number of stations, and each station's number of substations.
 ;$D(^DIC(4,+$P(^(0),U,10),0)) S PRCHSITE=$P(^(0),U,1)
 S (PRCH411,PRCHINSN)=0 F  S PRCHINSN=$O(^PRC(411,"B",PRCHINSN)) Q:+PRCHINSN'>0  D
 .S PRCHINIC=0 S PRCHINIC=$O(^PRC(411,"B",PRCHINSN,PRCHINIC)) Q:+PRCHINIC'>0  D
 ..I PRCHINIC<1000000 S PRCH411=PRCH411+1,PRCH411(+PRCHINSN,$P(^PRC(411,PRCHINIC,0),"^"))=$P(^DIC(4,$P(^PRC(411,PRCHINIC,0),"^",10),0),"^")
 ..I PRCHINIC>999999 S PRCH411(+PRCHINSN)=$G(PRCH411(+PRCHINSN))+1,PRCH411(+PRCHINSN,$P(^PRC(411,PRCHINIC,0),"^"))=$P(^DIC(4,$P(^PRC(411,PRCHINIC,0),"^",10),0),"^")
 ..Q
 .Q
 Q
 ;
EXITZT ;
 W ! D ^%ZISC,HOME^%ZIS K IO("Q")
EXIT ;
 K %ZIS,D,DIC,DIR,DIROUT,DIRUT,PRCH420,PRCH4206,PRCH6,PRCRI,PRCSUBF,X,Y,ZTDESC,ZTRTN,ZTSAVE,ZTSK
 K PRCH2237,PRCHDATE,PRCHECMS,PRCHEMP,PRCHENDT,PRCHFUND,PRCHJSB,PRCHJSN,PRCHLAST,PRCHOPT,PRCHSTDT,PRCHSTN,PRCHSUB,PRCHTYPE,PRCHURCP,PRCHURSN,PRCHURLV
 Q
 ;
FAUXPR ; DISPLAY OF THE SELECTIONS
 ;SINGLE 2237
 I $G(PRCH2237)'="ALL" W !!,"The single 2237, "_PRCH2237_", has been selected for printing. " G FX
 ;EVERYTHING ELSE
 W !!,"All eCMS 2237s matching your selections below will be displayed:"
 ;ECMS CONTACT
 W !,"  ",$S(PRCHECMS="ALL":"All eCMS Contacts",1:"eCMS Contact: "_PRCHEML)
 ;DATE RANGE
 I PRCHDATE'="ALL" S Y=PRCHSTDT D DD^%DT S PRCHSTAR=Y S Y=PRCHENDT D DD^%DT S PRCHEND=Y K Y
 W !,"  ",$S(PRCHDATE="ALL":"All dates: ("_PRCHSTAR_" - "_PRCHEND_")",1:"Dates: ("_PRCHSTAR_" - "_PRCHEND_")")
 ;STATION/SUBSTATION
 W !,"  ",$S(PRCHSTN="ALL":"All Stations and Substations",1:"Station: "_$S(+PRCHSTN:PRCHSTN,PRCHSTN="SUB":+PRCHSUB,1:""))
 W $S($G(PRCHSUB)="NONE":", records for substation "_+PRCHSTN,((+PRCHSTN)&($D(PRCH411(+PRCHSTN))'=11)):"",((+PRCHSTN)&(PRCHSUB="ALL")):", records for each substation",((PRCHSTN="ALL")&(PRCHSUB="ALL")):"",1:", records for substation "_PRCHSUB)
 ;FCP
 W !,"  ",$S(PRCHFUND="ALL":"All Fund Control Points",1:"Fund Control Point: "_PRCHFUND)
 ;EVENT TYPE
 W !,"  Event Types selected are:"
 S PRCHI=1,PRCHSLTY=PRCHTYPE
 S PRCHTYPE=","
 F  S PRCHJ=$P(PRCHSLTY,",",PRCHI) Q:+PRCHJ'>0  S PRCHI=PRCHI+1 D
 .I PRCHJ=1 W !,"   1 = Sent to eCMS (includes resent 2237s)" S PRCHTYPE=PRCHTYPE_"1,"
 .I PRCHJ=2 W !,"   2 = Returned to Accountable Officer" S PRCHTYPE=PRCHTYPE_"6,"
 .I PRCHJ=3 W !,"   3 = Returned to Control Point" S PRCHTYPE=PRCHTYPE_"8,"
 .I PRCHJ=4 W !,"   4 = Cancelled within eCMS" S PRCHTYPE=PRCHTYPE_"10,"
 .Q
 ;FULL ERROR TEXT
 W !,"  ",$S(PRCHERTX:"The full text of any errors will be displayed.",1:"A note will display for any errors, but not the full text.")
FX ; Get Device
 K IOP,%ZIS
 W ! S %ZIS="MQ" D ^%ZIS W !
 G:POP EXIT
 I $D(IO("Q")) S ZTRTN="GATHER^PRCHJRP6",ZTDESC="Transaction Report - eCMS/IFCAP",ZTSAVE("PRCH*")="" D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued!",1:"Request Cancelled!"),! G EXITZT
 D GATHER^PRCHJRP6
 D EXIT
 Q
