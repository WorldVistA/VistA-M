RAORD2 ;HISC/CAH,FPT,GJC,DAD AISC/RMO-Detailed Request Display ;9/3/99  13:48
 ;;5.0;Radiology/Nuclear Medicine;**5,10,51,45,75**;Mar 16, 1998;Build 4
 K XQADATA
 D HOME^%ZIS K DIC S DIC="^DPT(",DIC(0)="AEMQ"
 W ! D ^DIC G Q:Y<0
 S RADFN=+Y,RANME=$S($D(^DPT(RADFN,0)):$P(^(0),"^"),1:"Unknown")
 S RAOFNS="Display",RAOVSTS="1;2;3;5;6;8" D LOCATN I $G(RAQUIT) D Q Q
 I RAONE]"" S ^TMP($J,"RA L-TYPE",$P(RAONE,"^"),$P(RAONE,"^",2))=""
 S ^TMP($J,"RA L-TYPE","Unknown")=""
 I '$D(^TMP($J,"RA L-TYPE")) D ERROR^RAUTL7A D Q QUIT
 S X=0 W !!,"Imaging Location(s) included:"
 F  S X=$O(^TMP($J,"RA L-TYPE",X)) Q:X']""  D
 . W:($X+$L(X)+2)'<IOM !?$L("Imaging Location(s) included:") W ?($X+3),X
 . Q
 W ! K DIR S DIR(0)="E" D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) D Q Q
 D ^RAORDS G Q:'$D(RAORDS)
OERR ; Entry Point for OE/RR Cancel/Hold Alert
 I $D(XQADATA) D
 . S RAORDS(1)=+XQADATA
 . I $P(XQADATA,",",2)'="" S RADFN=$P(XQADATA,",",2)
 S RAPKG="",RAOSTSYM="dc^c^h^^p^^^s",$P(RALNE,"-",79)="",RAX=""
 F RAOLP=1:1 S RAOIFN=$S($D(RAORDS(RAOLP)):RAORDS(RAOLP),1:0) Q:'RAOIFN!(RAX=U)  D DISORD
 ;
 K:RAX="^" XQAID,XQAKILL I $D(XQAID) S DFN=$P(XQAID,",",2) D DELETE^XQALERT
Q K %,DIC,I,OREND,RA,RACI,RACNI,RADFN,RADIV,RADIVPAR,RADPT0,RADTI,RALNE
 K RANME,RAOFNS,RAOIFN,RAOLP,RAORD0,RAORDS,RAOSTS,RAOSTSYM,RAOVSTS,RAPKG
 K RAONE,RAQUIT,RASSN,X,XQAID,XQALERT,Y,RAX,VA200,VAERR,VAIP
 K RAPARENT,RACMFLG
 K DFN,DIPGM,DISYS,DIW,DIWI,DIWT,DIWTC,DIWX,DN,RA6,RA7,POP,^TMP($J,"PRO-ORD")
 K ^TMP($J,"RA L-TYPE"),^TMP($J,"RAORDS"),^TMP($J,"RA DIFF PRC") Q
 ;
 ;
DISORD Q:'$D(^DPT(RADFN,0))  S RADPT0=^(0),RA("NME")=$P(RADPT0,"^"),RA("DOB")=$P(RADPT0,"^",3),RASSN=$$SSN^RAUTL Q:'$D(^RAO(75.1,RAOIFN,0))  S RAORD0=^(0)
 ;determine if ordered procedure has CM assoc.; return null if none
 S RAZPRC0=$G(^RAMIS(71,+$P(RAORD0,U,2),0))
 S RACMFLG("O")=$$CMEDIA^RAO7UTL(+$P(RAORD0,U,2),$P(RAZPRC0,U,6))
 K RAZPRC0
 I $D(^RADPT("AO",RAOIFN,RADFN)) D DPRC(RAOIFN,RADFN)
 S RA("PROC. NODE")=$G(^RAMIS(71,+$P(RAORD0,U,2),0))
 S RA("PRC")=$E($P(RA("PROC. NODE"),U),1,36)
 S RA("PRCTY")=$P(RA("PROC. NODE"),U,6)
 S RA("PRCTY")=$$XTERNAL^RAUTL5(RA("PRCTY"),$P($G(^DD(71,6,0)),U,2))
 S RA("PRCTY")=$E(RA("PRCTY"))_$$LOW^XLFSTR($E(RA("PRCTY"),2,99))
 S RA("CPT")=+$P(RA("PROC. NODE"),U,9)
 ; don't find CPT code if procedure has type = Parent
 S RA("CPT")=$S($E(RA("PRCTY"))="P":"",1:$P($$NAMCODE^RACPTMSC(RA("CPT"),DT),U))
 S RA("PRCIT")=+$P(RA("PROC. NODE"),U,12)
 S RA("PRCIT")=$P($G(^RA(79.2,RA("PRCIT"),0)),U,3)
 S RA("PROC INFO")="",$E(RA("PROC INFO"),1,36)=RA("PRC")
 S RA("CNCAT")="("_RA("PRCIT")_" "_RA("PRCTY")_" "_RA("CPT")_")"
 S $E(RA("PROC INFO"),38,60)=RA("CNCAT") K RA("CNCAT"),RA("PRCIT")
 K RA("PRCTY"),RA("CPT")
 S RA("STY_REA")=$P($G(^RAO(75.1,RAOIFN,.1)),U) ;P75
 K RA("MOD") F I=0:0 S I=$O(^RAO(75.1,RAOIFN,"M","B",I)) Q:'I  I $D(^RAMIS(71.2,+I,0)) S RA("MOD")=$S('$D(RA("MOD")):$P(^(0),"^"),1:RA("MOD")_", "_$P(^(0),"^"))
 S RA("OST")=$P($P(^DD(75.1,5,0),$P(RAORD0,"^",5)_":",2),";")_$S($P(RAOSTSYM,"^",$P(RAORD0,"^",5))="":"",1:" ("_$P(RAOSTSYM,"^",$P(RAORD0,"^",5))_")")
 S RA("PHY")=$S($D(^VA(200,+$P(RAORD0,"^",14),0)):$P(^(0),"^"),1:"")
 ; Requesting Physician phone/pager info
 D PHONE^RAORD5("R",+$P(RAORD0,"^",14))
 S RA("HLC")=$S($D(^SC(+$P(RAORD0,"^",22),0)):$P(^(0),"^"),1:"")
 S DFN=RADFN,VA200=1 D IN5^VADPT I VAIP(1) S RA("ROOM-BED")=$S(+VAIP(6):$P(VAIP(6),"^",2),1:"")
 K RA("ODT") S X=$P(RAORD0,"^",16) I X S:$P(X,".",2) X=$P(X,".")_"."_$$NOSECNDS^RAORD3($P(X,".",2)) S RA("ODT")=$$FMTE^XLFDT(X,"1P")
 S RA("USR")=$S($D(^VA(200,+$P(RAORD0,"^",15),0)):$P(^(0),"^"),1:"")
 D HDR ; display a header
 W !,"Requested :",?12,RA("PROC INFO")
 I $D(^TMP($J,"RA DIFF PRC")) D
 .N CRTN,I S CRTN=0,I="" W !,"Registered:"
 .F  S I=$O(^TMP($J,"RA DIFF PRC",I)) Q:I']""  D
 ..W:CRTN ! W ?12,I S CRTN=1
 .Q
 I $G(RACMFLG("O"))'="" W:$X ! W ?12,"** The requested procedure has contrast media assigned **"
 I $G(RACMFLG("R"))'="" W:$X ! W ?12,"** A registered procedure uses contrast media **"
 W:$D(RA("MOD")) !,"Procedure Modifiers:",?22,RA("MOD")
 W !!,"Current Status:",?22,$E(RA("OST"),1,24)
 W !,"Requester:",?22,$E(RA("PHY"),1,24)
 W !?1,"Tel/Page/Dig Page: ",RA("RPHOINFO")
 W !,"Patient Location:",?22,$E(RA("HLC"),1,20)
 W:$D(RA("ROOM-BED")) !,"Room-Bed:",?22,$E(RA("ROOM-BED"),1,20)
 W !,"Entered:",?22,$S($D(RA("ODT")):RA("ODT"),1:""),"  by ",$E(RA("USR"),1,20)
 ;
ENDIS ;OE/RR Entry Point for the PRINT ACTION Option
 I '$D(RAPKG) Q:'$D(ORPK)  S RAOIFN=+ORPK Q:'$D(^RAO(75.1,RAOIFN,0))  S RAORD0=^(0),RADFN=+$P(RAORD0,"^")
 S RA("TRAN")=$S($P(RAORD0,"^",19)']"":"",1:$P($P(^DD(75.1,19,0),$P(RAORD0,"^",19)_":",2),";"))
 K RA("ST") I $D(^RADPT("AO",RAOIFN,RADFN)) S RADTI=+$O(^(RADFN,0)),RACNI=+$O(^(RADTI,0)) I $D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) S RA(0)=^(0) I $D(^RA(72,+$P(RA(0),"^",3),0)) S RA("ST")=$P(^(0),"^")
 I '$D(RAPKG) D DPRC(RAOIFN,RADFN) K ^TMP($J,"RA DIFF PRC")
 S RADIV(0)=$G(^SC(+$P(RAORD0,"^",22),0))
 S RADIV=+$$SITE^VASITE(DT,+$P(RADIV(0),"^",15)) S:RADIV<0 RADIV=0
 S RADIV=$S($D(^RA(79,RADIV,0)):RADIV,1:$O(^RA(79,0)))
 S RADIVPAR=$S($D(^RA(79,+RADIV,.1)):^(.1),1:"")
 K RA("RDT") S Y=$P(RAORD0,"^",21) I Y S:$P(Y,".",2) Y=$P(Y,".")_"."_$$NOSECNDS^RAORD3($P(Y,".",2)) S RA("RDT")=$$FMTE^XLFDT(Y,"1P")
 K RA("PDT") S Y=$P(RAORD0,"^",12) I Y S:$P(Y,".",2) Y=$P(Y,".")_"."_$$NOSECNDS^RAORD3($P(Y,".",2)) S RA("PDT")=$$FMTE^XLFDT(Y,"1P")
 K RA("VDT") S Y=$P(RAORD0,"^",17) I Y S:$P(Y,".",2) Y=$P(Y,".")_"."_$$NOSECNDS^RAORD3($P(Y,".",2)) S RA("VDT")=$$FMTE^XLFDT(Y,"1P")
 K RA("SDT") S Y=$P(RAORD0,"^",23) I Y S:$P(Y,".",2) Y=$P(Y,".")_"."_$$NOSECNDS^RAORD3($P(Y,".",2)) S RA("SDT")=$$FMTE^XLFDT(Y,"1P")
 S RA("ILC")=$S('$P(RAORD0,"^",20):"UNKNOWN",'$D(^RA(79.1,+$P(RAORD0,"^",20),0)):"UNKNOWN",$D(^SC(+^(0),0)):$P(^(0),"^"),1:"UNKNOWN")
 I $S('$D(XQORNOD(0)):0,$P(XQORNOD(0),"^",3)'="Results Display":0,1:1),$D(RA(0)) D ^RAORR3 Q
 D ^RAORD3 K RA,RACI,RACNI,RADIV,RADIVPAR,RADPT0,RADTI,RAORD0,RAOSTS,X,Y I '$D(RAPKG) K RADFN,RAOIFN
 Q
LOCATN ; Select or default to a Rad/Nuc Med location.
 S RAONE=$$LOC1() Q:RAONE]""
 S RADIC="^RA(79.1,",RADIC(0)="QEAMZ"
 S RADIC("A")="Select Rad/Nuc Med Location: "
 S RADIC("B")="All",RAUTIL="RA L-TYPE"
 W !! D EN1^RASELCT(.RADIC,RAUTIL) K DIC,RADIC,RAUTIL,X,Y
 Q
LOC1() ; Checking for only one Imaging Location
 ; Pass back null if more that one entry exists in 79.1 
 ; If one entry, pass back: external Hosp. Loc. file_"^"_IEN of file 79.1
 N X,Y S X=""
 I $P($G(^RA(79.1,0)),"^",4)=1 D
 . S Y=+$O(^RA(79.1,0)) Q:'Y
 . S Y(0)=$G(^RA(79.1,Y,0)),Y(1)=+$P(Y(0),"^")
 . S Y(44)=$P($G(^SC(Y(1),0)),"^"),X=Y(44)_"^"_Y
 . Q
 Q X
HDR ; Header for the 'Detailed Request Display' option.  Called from above
 ; (D HDR) and from RAORD3
 W @IOF,?22,"**** Detailed Display ****",!!,"Name: ",RA("NME"),"    (",RASSN,")" S Y=RA("DOB") D D^RAUTL W ?45,"Date of Birth: ",Y,!,RALNE
 Q
 ;
DPRC(RAOIFN,RADFN) ; If the ordered procedure has been registered check
 ;if this is an examset. If not an examset, find the status of the exam
 ;RA("ST"). Also, check if the ordered procedure has been changed at
 ;time of registration (DPROC^RAUTL15). If it has, store the data off
 ;in ^TMP($J,"RA DIFF PRC").
 ;
 ; NOTE: The only time we don't set ^TMP($J,"RA DIFF PRC") is when
 ; we are using the 'Detailed Request Display' option and the ordered
 ; procedure is the same as the registered procedure.  All other
 ; Request display options output the ordered procedure, the
 ; registered procedure and exam case number if the order
 ; is active.
 ;
 ;Set the variable RACMFLG("R") to "Y" if an exam, either a single or
 ;descendant, has used contrast media during the examination.
 ;
 N RA7003,RACNI,RADTI,RAFLG K RA("ST"),^TMP($J,"RA DIFF PRC")
 S (RADTI,RAFLG)=0
 F  S RADTI=+$O(^RADPT("AO",RAOIFN,RADFN,RADTI)) Q:RADTI'>0  D
 . S RACNI=0
 . F  S RACNI=$O(^RADPT("AO",RAOIFN,RADFN,RADTI,RACNI)) Q:RACNI'>0  D
 .. I $D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) D
 ... S RA7003=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),RAFLG=RAFLG+1
 ... S:$G(RACMFLG("R"))="" RACMFLG("R")=$S($P(RA7003,U,10)="Y":"Y",1:"")
 ... S RA("ST")=$$GET1^DIQ(72,+$P(RA7003,"^",3)_",",.01)
 ... N RAPRC S RAPRC=$$DPROC^RAUTL15(RADFN,RADTI,RACNI,RAOIFN)
 ... S:RAPRC]"" ^TMP($J,"RA DIFF PRC",RAPRC)=""
 ... Q
 .. Q
 . Q
 K:RAFLG>1 RA("ST") ; >1 reg. xam for this order, RA("ST") not valid
 Q
