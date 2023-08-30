RAORD6 ;HISC/CAH - AISC/RMO-Print A Request Cont. ; Mar 16, 2023@06:47:30
 ;;5.0;Radiology/Nuclear Medicine;**5,10,15,18,27,45,41,75,85,99,123,132,144,200**;Mar 16, 1998;Build 2
 ; 3-p75 10/12/2006 GJC RA*5*75 print Reason for Study
 ; 4-p75 10/12/2006 KAM RA*5*75 display the request print date in the header
 ; 5-p75 10/12/2006 KAM RA*5*75 update header "Age" to "Age at req"
 ; 6-p85 06/20/2007 KAM RA*5*85 Reason for Study/Bar Code print issue
 ;                              Remedy Call - 193859
 ; 5-P123 6/23/2015 MJT RA*5*123 NSR 20140507 print weight & date taken in Radiology requests
 ; 5-P132 11/1/2017 RTW RA*5*123 NSR 20160706 print height & date taken in Radiology requests
 ; 2-p200 3/01/2023 KLM RA*5*200 NSR 20220815 display patient preferred name in the header
 ; 
 ;Supported IA #10104 reference to ^XLFSTR
 ;Supported IA #10060 reference to ^VA(200
 D HD Q:RAX["^"
 I $$PTSEX^RAUTL8(RADFN)="F" D  ;display pregnancy status for females ptch 45
 .W !,"Pregnant at time of order entry: ",?22,$S($P(RAORD0,"^",13)="y":"YES",$P(RAORD0,"^",13)="n":"NO",1:"UNKNOWN")
 .Q:'$D(RAOIFN)
 .Q:'$D(^RADPT("AO",$G(RAOIFN),RADFN))
 .N RAINVDT,RA5
 .S RAINVDT=$O(^RADPT("AO",RAOIFN,RADFN,0))
 .Q:'$G(RAINVDT)
 .S RA5=$O(^RADPT("AO",RAOIFN,RADFN,RAINVDT,0))
 .Q:'$G(RA5)
 .N R3,RAPCOMM S R3=$G(^RADPT(RADFN,"DT",$G(RAINVDT),"P",$G(RA5),0))
 .S RAPCOMM=$G(^RADPT(RADFN,"DT",+$G(RAINVDT),"P",+$G(RA5),"PCOMM"))
 .W:$P(R3,U,32)'="" !,"Pregnancy Screen: ",$S($P(R3,"^",32)="y":"Patient answered yes",$P(R3,"^",32)="n":"Patient answered no",$P(R3,"^",32)="u":"Patient is unable to answer or is unsure",1:"")
 .W:$P(R3,U,32)'="n"&$L(RAPCOMM) !,"Pregnancy Screen Comment: ",RAPCOMM
 .Q
 W:$P(RAORD0,"^",24)="y" !!?12,"*** Universal Isolation Precautions ***"
 W:$D(RA("VDT")) !!?8,"** Note Request Associated with Visit on ",RA("VDT")," **"
 W !!,"Requested:",?18,RA("PRC INFO")
 ;KLM/P144 - removed option conditions below to print the exam information
 ;we want to print case #s etc when registering no matter what
 I $D(^TMP($J,"RA DIFF PRC")),('$D(RAFOERR)) D  Q:RAX["^"
 . ; don't print registered procedure info (CPT, Proc Type, Imaging
 . ; Type) if entering through 'Request An Exam', 'Register Patient
 . ; for Exams' or 'Add Exams To Last Visit'.  Don't print if ordered
 . ; through ANY version of OE/RR.  If ordered through OE/RR, RAFOERR
 . ; will be defined. (Set in RAORD1 & RAO7RO)
 . N RAT,RA18NLIN S RAT="",RA18NLIN=0 W !,"Registered:"
 . F  S RAT=$O(^TMP($J,"RA DIFF PRC",RAT)) Q:RAT=""  D  Q:RAX["^"
 .. D HD:($Y+10)>IOSL Q:RAX["^"  ; 5-P123
 .. W:RA18NLIN ! W ?12,RAT
 .. S RA18NLIN=1
 .. Q
 . Q
 I $G(RACMFLG("O"))'="" W !?12,"** The requested procedure has contrast media assigned **"
 I $G(RACMFLG("R"))'="" W !?12,"** A registered procedure uses contrast media **"
 W:$D(RA("MOD")) !,"Procedure Modifiers:",?22,RA("MOD")
 I RA("PRC MSG") D  Q:RAX["^"
 . N A,B,C,X S (A,C)=0 W !,"Procedure Message: ",!
 . F  S A=$O(^RAMIS(71,+$P(RAORD0,"^",2),3,A)) Q:A'>0!(RAX["^")  D
 .. S B=+$G(^RAMIS(71,+$P(RAORD0,"^",2),3,A,0))
 .. S X=$G(^RAMIS(71.4,B,0))
 .. W:'C ?3,"-" W:C !?3,"-"
 .. D OUTTEXT^RAUTL9(X,"",5,80,4,"","!")
 .. D HD:($Y+10)>IOSL S C=C+1  ; 5-P123
 .. Q
 . Q
 W !,"Request Status:",?22,$E(RA("OST"),1,24)
 I $P(RAORD0,"^",5)=1!($P(RAORD0,"^",5)=3) D  Q:RAX["^"
 . W !,"Reason ",$S($P(RAORD0,"^",5)=1:"Cancelled",1:"Held"),":"
 . W ?22,$S($D(^RA(75.2,+$P(RAORD0,"^",10),0)):$E($P(^(0),"^"),1,50),$P(RAORD0,"^",27)]"":$E($P(RAORD0,"^",27),1,50),1:"UNKNOWN")
 . D HD:($Y+10)>IOSL Q:RAX["X"  ; 5-P123
 . I $D(^RAO(75.1,RAOIFN,1)) D  Q:RAX["^"
 .. N X,I,RAXX
 .. K ^UTILITY($J,"W")
 .. W !,"Hold Description:",!
 .. S I=0 F  S I=$O(^RAO(75.1,RAOIFN,1,I)) Q:'I  S (RAXX,X)=^(I,0) D HD:($Y+10)>IOSL Q:RAX["^"  S X=RAXX D ^DIWP  ; 5-P123
 .. Q:RAX["^"
 .. D HD:($Y+10)>IOSL Q:RAX["X"  ; 5-P123
 .. D ^DIWW:$D(RAXX)
 .. D HD:($Y+10)>IOSL Q:RAX["X"  ; 5-P123
 . I $P(RAORD0,"^",5)=1 D
 .. W !!,?(IOM-(IOM/2+15)),"*********************",!,?(IOM-(IOM/2+15)),"* C A N C E L L E D *",!,?(IOM-(IOM/2+15)),"*********************"
 W:$P(RAORD0,"^",5)=6&($D(RA("ST"))) !,"Exam Status:",?22,RA("ST")
 W:$P(RAORD0,"^",5)=8&($D(RA("SDT"))) !,"Exam Scheduled:",?22,RA("SDT")
 D HD:($Y+10)>IOSL Q:RAX["^"  ; 5-P123
 W !!,"Requester:",?22,$E(RA("PHY"),1,20)
 W:RA("PHY")'="UNKNOWN" !?1,"Tel/Page/Dig Page: ",$G(RA("RPHOINFO"))
 D HD:($Y+10)>IOSL Q:RAX["^"  ; 5-P123
 W !,"Attend Phy Current:",?22,$E(RA("ATTEN"),1,20)
 W:RA("ATTEN")'="UNKNOWN" !?1,"Tel/Page/Dig Page: ",$G(RA("APHOINFO"))
 D HD:($Y+10)>IOSL Q:RAX["^"  ; 5-P123
 W !,"Prim Phy Current:",?22,$E(RA("PRIM"),1,20)
 W:RA("PRIM")'="UNKNOWN" !?1,"Tel/Page/Dig Page: ",$G(RA("PPHOINFO"))
 K RAPASS1,RAPASS2
 S RAPASS1=RA("ATTEN"),RAPASS2=RA("OATTEN")
 D HD:($Y+10)>IOSL Q:RAX["^"  ; 5-P123
 I $$ID^RAORD6(RAPASS1,RAPASS2) D
 . W !,"Attend Phy At Order:",?22,$E(RA("OATTEN"),1,20)
 . W:RA("OATTEN")'="UNKNOWN" !?1,"Tel/Page/Dig Page: ",$G(RA("OAPHOINFO"))
 . Q
 S RAPASS1=RA("PRIM"),RAPASS2=RA("OPRIM")
 I $$ID^RAORD6(RAPASS1,RAPASS2) D
 . W !,"Prim Phy At Order:",?22,$E(RA("OPRIM"),1,20)
 . W:RA("OPRIM")'="UNKNOWN" !?1,"Tel/Page/Dig Page: ",$G(RA("OPPHOINFO"))
 . Q
 K RAPASS1,RAPASS2
 I +$P(RAORD0,"^",8) D
 . N RAPPRAD S RAPPRAD=+$P(RAORD0,"^",8)
 . S:$P($G(^VA(200,RAPPRAD,20)),"^",2)]"" RAPPRAD=$P(^(20),"^",2)
 . S:RAPPRAD=+RAPPRAD RAPPRAD=$P(^VA(200,RAPPRAD,0),"^")
 . W !,"Approved by: ",?22,RAPPRAD
 . Q
 D HD:($Y+10)>IOSL Q:RAX["^"  ; 5-P123
 W !,"Date/Time Ordered:",?22,$S($D(RA("ODT")):RA("ODT"),1:""),"  by ",$E(RA("USR"),1,20)
 W:$D(RA("RDT")) !,"Date Desired:",?22,RA("RDT")
 D:$P(RAORD0,"^",5)=1 USERCAN^RAORD3
 D HD:($Y+10)>IOSL Q:RAX["^"  ; 5-P123
 W:$D(RA("PDT")) !,"Pre-op Date/Time:",?22,RA("PDT"),!!?26,"**** P R E - O P ****",!
BAR ;Print bar-coded SSN on request form if term type has bar code setup
 I $G(RASSN)'?3N1"-"2N1"-".E G CONT
 S X3=$E(RASSN,1,3)_$E(RASSN,5,6)_$E(RASSN,8,11)
 ; 06/20/2007 KAM/BAY RA*5*85 Added 2 line feeds
 D PSET^%ZISP I IOBARON]"",(IOBAROFF]"") W !!!?49,@IOBARON,X3,@IOBAROFF,!
 D PKILL^%ZISP
 ;
CONT D HD:($Y+10)>IOSL Q:RAX["^"  D ODX^RABWUTL(RAOIFN) ; * Billing Aware *  ; 5-P123
 D HD:($Y+10)>IOSL Q:RAX["^"  ; 5-P123
 ; 06/20/2007 KAM/BAY RA*5*85 Added line feed to the next line
 I $L(RA("STY_REA")) W ! D DIWP^RAUTL5(1,68,"Reason for Study: "_RA("STY_REA")) ;3-p75
 D HD:($Y+10)>IOSL Q:RAX["^"  K ^UTILITY($J,"W"),^(1) W !,"Clinical History:",! K RAXX F RAV=0:0 S RAV=$O(^RAO(75.1,RAOIFN,"H",RAV)) Q:'RAV  I $D(^(RAV,0)) S RAXX=^(0) D HD:($Y+10)>IOSL Q:RAX["^"  S X=RAXX D ^DIWP  ; 5-P123
 Q:RAX["^"  D HD:($Y+10)>IOSL Q:RAX["^"  D ^DIWW:$D(RAXX),HD:($Y+10)>IOSL Q:RAX["^"  D WORK ;always print bottom section of form 012601  ; 5-P123
 W ! S BOT=IOSL-($Y+4) S:($E(IOST,1,6)="P-BROW"&($D(DDBRZIS))) BOT=5 F BT=1:1:BOT W !
 K BOT,BT
 W !,"VA Form 519a-ADP"
 Q
 ;
WORK W !,RALNE,!,"Date Performed: ________________________",?46
 I $O(^RADPT("AO",RAOIFN,0))="" W "Case No.: ______________________"
 E  W "Case No.: ______see above_______"
 D HD:($Y+10)>IOSL Q:RAX["^"  ; 5-P123
 W !,"Technologist Initials: _________________"
 D HD:($Y+10)>IOSL Q:RAX["^"  ; 5-P123
 W !?46,"Number/Size Films: _____________",!,"Interpreting Phys. Initials: ___________",?65,"_____________",!?65,"_____________",!
 D HD:($Y+10)>IOSL Q:RAX["^"  ; 5-P123
 W !,"Comments:"
 ;
TC D EN30^RAO7PC1(RAOIFN),TC^RAORD61 Q:RAX["^"
 ;
DASHLN W ! F I=1:1:5 D HD:($Y+10)>IOSL Q:RAX["^"  W !,RALNE ;P18  ; 5-P123
 Q
 ;
HD S:'$D(RAPGE) RAPGE=0 D CRCHK Q:$G(RAX)["^"  S RATAB=$S($D(RA("ILC")):1,1:16)
 ;10/12/2006 KAM Remedy tk 162508 Changed next line added "Printed:"
 W:$Y @IOF W !?RATAB,">>"_$S($D(RACRHD):"Discontinued ",1:"")_"Rad/NM Consultation" W:$D(RA("ILC")) " for ",$E(RA("ILC"),1,17) W "<<Printed:" S X="NOW",%DT="T" D ^%DT K %DT D D^RAUTL W ?52,Y ;P18 4-P74
 S RAPGE=RAPGE+1 W ?71,"Page ",RAPGE ;P18
 I $L(RA("NME"))<31 D  Q  ;2-p200 If name does not exceed original column size, print in original format.
 . W !,RALNE1,!,"Name         : ",RA("NME"),?46,"Urgency    : ",RA("OUG") W:$D(RA("PORTABLE")) "  *PORTABLE*"
 . W !,"Pt ID Num    : ",RASSN,?46,"Transport  : ",RA("TRAN")
 . S Y=RA("DOB") D D^RAUTL W !,"Date of Birth: ",Y,?46,"Patient Loc: ",$E(RA("HLC"),1,20)
 . ;10/12/2006 KAM Remedy Ticket 162508 changed next line
 . W !,"Age at req   : ",RA("AGE"),?46,"Phone Ext  : ",RA("HPH") ;5-P75
 . W !,"Sex          : ",$S(RA("SEX")="M":"MALE",1:"FEMALE") W:$D(RA("ROOM-BED")) ?46,"Room-Bed   : ",RA("ROOM-BED")
 . ; *** NSR 20140507 Start Mod to print weight & date taken in Radiology requests ***
 . ; RTW BEGIN RA*5.0*132 ADD HEIGHT
 . W !,"Height (in.) : ",$S($D(RA("HT")):RA("HT"),1:"") W ?46,"Height Date: ",$S($D(RA("HTDT")):RA("HTDT"),1:"") ;5-P132 RTW
 . ; RTW END RA*5.0*132 ADD HEIGHT
 . W !,"Weight (lbs) : ",$S($D(RA("WT")):RA("WT"),1:"") W ?46,"Weight Date: ",$S($D(RA("WTDT")):RA("WTDT"),1:"") ;5-P123
 . ; *** NSR 20140507 End Mod to print weight & date taken in Radiology requests ***
 . ; 5-P123 moved next line to here from line above Start Mod
 . W !,RALNE1
 . W:$P(RAORD0,U,5)=1 !,"***C A N C E L L E D***",?56,"***C A N C E L L E D***"
 . Q
 ;
HD2 ;2-p200 - Modified header if PT NAME (PREFERRED NAME) exceeds column-one length of 30 chars.
 N RARTC,RARTC2,RAPTLOC,RALRB S RARTC=45,RARTC2=56 ;set right column vars
 I $D(RA("ROOM-BED"))&(RA("HPH")]"") D  ;Adjust right column for combined pt loc/room-bed if needed
 .S RARTC=41,RAPTLOC="Pt Loc/Room-Bed: "
 .S RALRB=$E(RA("HLC"),1,20)_"/"_RA("ROOM-BED")
 .I $L(RALRB)>20 S RARTC=41-($L(RALRB)-20),RARTC2=56-($L(RALRB)-20) ;adjust column if needed
 .Q
 W !,RALNE1,!,"Name         : ",RA("NME")
 W !,"Pt ID Num    : ",RASSN,?RARTC,"Urgency",?RARTC2,": ",RA("OUG") W:$D(RA("PORTABLE")) "  *PORTABLE*"
 S Y=RA("DOB") D D^RAUTL W !,"Date of Birth: ",Y,?RARTC,"Transport",?RARTC2,": ",RA("TRAN")
 ;10/12/2006 KAM Remedy Ticket 162508 changed next line
 W !,"Age at req   : ",RA("AGE")
 I RA("HPH")=""!(RA("HPH")]""&('$D(RA("ROOM-BED")))) W ?RARTC,"Patient Loc",?RARTC2,": "_$E(RA("HLC"),1,20)
 I $D(RA("ROOM-BED"))&(RA("HPH")]"") W ?RARTC,RAPTLOC,$E(RA("HLC"),1,20)_"/"_RA("ROOM-BED")
 W !,"Sex          : ",$S(RA("SEX")="M":"MALE",1:"FEMALE")
 I $D(RA("ROOM-BED"))&(RA("HPH")="") W ?RARTC,"Room-Bed",?RARTC2,": "_RA("ROOM-BED") ;print room-bed in place of non-existant phone nbr
 E  W ?RARTC,"Phone Ext",?RARTC2,": "_RA("HPH")
 ; *** NSR 20140507 Start Mod to print weight & date taken in Radiology requests ***
 ; RTW BEGIN RA*5.0*132 ADD HEIGHT
 W !,"Height (in.) : ",$S($D(RA("HT")):RA("HT"),1:"") W ?RARTC,"Height Date",?RARTC2,": ",$S($D(RA("HTDT")):RA("HTDT"),1:"") ;5-P132 RTW
 ; RTW END RA*5.0*132 ADD HEIGHT
 W !,"Weight (lbs) : ",$S($D(RA("WT")):RA("WT"),1:"") W ?RARTC,"Weight Date",?RARTC2,": ",$S($D(RA("WTDT")):RA("WTDT"),1:"") ;5-P123
 ; *** NSR 20140507 End Mod to print weight & date taken in Radiology requests ***
 ; 5-P123 moved next line to here from line above Start Mod
 W !,RALNE1
 W:$P(RAORD0,U,5)=1 !,"***C A N C E L L E D***",?56,"***C A N C E L L E D***"
 Q
 ;
CRCHK I RAPGE,$E(IOST)="C" W !!,$C(7),"Press RETURN to continue or '^' to stop " R X:DTIME S RAX=X
 Q
ID(X,Y) ; Checks for the following condition:
 ; 1) Attending Phy. Current & Attending Phy. At Order are the same.
 ; 2) Primary Phy. Current & Primary Phy. At Order are the same.
 ; Input Variables:
 ; 'X'-> Attending/Primary Phy. Current
 ; 'Y'-> Attending/Primary Phy. At Order
 I X']""!(Y']"") Q 0
 I $$UP^XLFSTR(X)="UNKNOWN",($$UP^XLFSTR(Y)="UNKNOWN") Q 0
 N A,B,Z S A=+$O(^VA(200,"B",X,"")),B=+$O(^VA(200,"B",Y,""))
 I A>0,(B>0),(A=B) S Z=0
 E  S Z=1
 Q Z ; $S(Z=1:"different physician",Z=0:"same physician")
