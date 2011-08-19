RAPROD ;HISC/FPT,GJC AISC/MJK-Detailed Exam View ;05/13/09  06:45
 ;;5.0;Radiology/Nuclear Medicine;**10,35,45,56,99**;Mar 16, 1998;Build 5
 ;Supported IA #2056 GET1^DIQ
 ;Supported IA #2053 UPDATE^DIE
 ;Supported IA #10040 ^SC(
 ;Supported IA #10060 ^VA(200
START S RADI=^RADPT(RADFN,"DT",RADTI,0) S:$D(^("P",RACNI,"COMP")) RA("COMP")=^("COMP") S RA("REA")=$S($D(^("R")):^("R"),1:"")
 S RA("TECH")=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"TC",0)) I RA("TECH") S RA("TECH")=$S($D(^VA(200,+^(RA("TECH"),0),0)):$P(^(0),"^"),1:"")
 S X=$P(Y(0),"^",4),RA("CAT")=$S(X="I":"INPATIENT",X="O":"OUTPATIENT",X="S":"SHARING",X="C":"CONTRACT",X="R":"RESEARCH",X="E":"EMPLOYEE",1:"UNKNOWN")
 S RA("RST")=$$RSTAT^RAO7PC1A
 F I=1:1:13 S Y=$T(LIST+I),@$P(Y,";",3)=$S($D(@($P(Y,";",4)_+$P(@$P(Y,";",5),"^",$P(Y,";",6))_",0)")):$P(^(0),"^"),1:"")
 ;
 N RAOPRC ; this will be the Requested Procedure defined only if it
 ; differs from the Registered Procedure
 I +$P(Y(0),U,11),($$DPROC^RAUTL15(RADFN,RADTI,RACNI,+$P(Y(0),U,11))]"") D
 . S RAOPRC=$$GET1^DIQ(75.1,+$P(Y(0),"^",11)_",",2)
 . Q
VIEW W @IOF S X="",$P(X,"=",80)="" W X K X
 W !?2,"Name        : ",RANME,"    ",RASSN
 W !?2,"Division    : ",$E(RA("DIV"),1,20),?40,"Category     : ",RA("CAT")
 W !?2,"Location    : ",$S($D(^SC(+RA("LOC"),0)):$P(^(0),"^"),1:"Unknown"),?40,"Ward         : ",$E(RA("WRD"),1,24)
 W !?2,"Exam Date   : ",RADATE,?40,"Service      : ",$E(RA("SERV"),1,24)
 W !?2,"Case No.    : ",RACN W ?40,"Bedsection   : ",$E(RA("BED"),1,24)
 W !?40,"Clinic       : ",$E(RA("CL"),1,24)
 S Y=$E(RA("CAT")) I "CSR"[Y W !?40,$E($S("C"=Y:"Contract     : "_RA("CONT"),"S"=Y:"Sharing      : "_RA("CONT"),"R"=Y:"Research     : "_RA("REA"),1:""),1,38)
 W:$X>1 ! S X="",$P(X,"-",80)="" W X K X
 W !?2,"Registered    : ",$E(RAPRC,1,60) D PRCCPT
 W:$G(RAOPRC)]"" !?2,"Requested     : ",$E(RAOPRC,1,60)
 W !?2,"Requesting Phy: ",$E(RA("PHY"),1,20),?40,"Exam Status  : ",$S($D(^RA(72,RAST,0)):$E($P(^(0),"^"),1,24),1:"")
 W !?2,"Int'g Resident: ",$E(RA("RES"),1,20),?40,"Report Status: ",$E(RA("RST"),1,21)
 S RAPREVER=+$P($G(^RARPT(RARPT,0)),"^",13)
 W !?2,"Pre-Verified  : ",$E($S($D(^VA(200,RAPREVER,0)):$P(^(0),"^",1),1:"NO"),1,20),?40,"Cam/Equip/Rm : ",$E(RA("RM"),1,20) K RAPREVER
 W !?2,"Int'g Staff   : ",$E(RA("STAFF"),1,20),?40,"Diagnosis    : ",$E(RA("DIA"),1,24)
 W !?2,"Technologist  : ",$E(RA("TECH"),1,20),?40,"Complication : ",$E(RA("CMP"),1,24)
 I $D(RA("COMP")) W !?2,"Comment       : " F I=1:60 Q:$E(RA("COMP"),I,I+59)']""  W ?18,$E(RA("COMP"),I,I+59)
 ;W:$X>1 !
 W !
 I $$PTSEX^RAUTL8(RADFN)="F" D  ;get pt sex and display pregnancy status for females, ptch #99
 .N RAOR751 S RAOR751=$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),U,11)
 .W ?2,"Pregnant at time of order entry: ",$$GET1^DIQ(75.1,$G(RAOR751)_",",13)
 K RAFL W ?47,"Films :" F I=0:0 S I=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"F",I)) Q:I'>0  I $D(^(I,0)) S X=^(0) W ?55,$S($D(^RA(78.4,+$P(X,"^"),0)):$P(^(0),"^"),1:"Unknown")," - ",+$P(X,"^",2),!
 W:$X>1 ! S X="",$P(X,"-",34)="" W X
 W "Modifiers" W $E(X,1,32) K X
 W !?2,"Proc Modifiers:" D MODS^RAUTL2 F I=1:1 Q:$P(Y,", ",I)']""  W ?18,$P(Y,", ",I),!
 N J
 W !?2,"CPT Modifiers : " W:Y(1)="None" Y(1),!
 I Y(1)'="None" F I=1:1 Q:$P(Y(2),", ",I)']""  S J=$P(Y(2),", ",I),J=$$BASICMOD^RACPTMSC(J,DT) W ?18,$P(J,"^",2)," ",$P(J,"^",3),! I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF W !
 Q:+$G(RAXIT)
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF W !
 Q:+$G(RAXIT)
 ;
 ;check for Contrast Media data, print it if it exists.
 I $O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CM",0)) D
 .W !?2,"Contrast Media: " S RACM=1
 .N DIWF,DIWL,DIWR,DIWT,X,Z
 .S X=$$CM^RADEM1(RADFN,RADTI,RACNI),DIWL=20,DIWF="C50"
 .D ^DIWP S Z=0
 .F  S Z=$O(^UTILITY($J,"W",DIWL,Z)) Q:'Z  D
 ..W ?18,^UTILITY($J,"W",DIWL,Z,0)
 ..W:+$O(^UTILITY($J,"W",DIWL,Z)) !
 ..Q
 .K ^UTILITY($J,"W")
 .Q
 ;
 I $O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"RX",0)) D PHARM^RAPROD2(RACNI_","_RADTI_","_RADFN_",") W ! ; display pharmaceutical data
 I +$G(RAXIT) K RAXIT Q
 I +$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),"^",28) D RDIO^RAPROD2(+$P(^(0),"^",28)) W ! ; display radiopharm data
 I +$G(RAXIT) K RAXIT Q
 W:$X>1 ! S X="",$P(X,"=",80)="" W X K X
 G ^RAPROD1
 ;
PRCCPT ; display Proc's abbrv, proc type, CPT
 Q:$G(RADTI)=""  Q:$G(RACNI)=""
 ;
 N RADISPLY
 S RADISPLY=$G(^RAMIS(71,+$P($G(^RADPT(+RADFN,"DT",+RADTI,"P",+RACNI,0)),U,2),0)) ; set $ZR to file 71 before calling prccpt^radd1
 S RADISPLY=$$PRCCPT^RADD1()
 W ?54,RADISPLY
 Q
SETL ;Set long display preference
 N RA1,RA2,DIR
 S RA1=$O(^RA(79,0)) Q:'RA1
 S RA2=$O(^RA(79,RA1,"LDIS","B",DUZ,0))
 I RA2 D  Q
 . W !!,"Your preference for Long Display of Procedures has already been set."
 . S DIR(0)="Y",DIR("A")="Do you want to delete your preference ",DIR("B")="No"
 . S DIR("?",1)="If you answer 'Yes', then all Radiology reports requested by you will"
 . S DIR("?",2)="will default to the condensed display, which means that repeated procedures"
 . S DIR("?")="and associated modifiers will only be listed once."
 . D ^DIR
 . Q:'Y
 . D DEL150
 . Q
 W !
 S DIR(0)="Y",DIR("A",1)="Do you want to set your preference for Long Display of Procedures"
 S DIR("A")="in all Radiology reports ",DIR("B")="No"
 S DIR("?",1)="If you answer 'Yes', then all Radiology reports requested by you will"
 S DIR("?",2)="list all repeated procedures and associated modifiers instead of"
 S DIR("?")="listing repeated procedures only once, which is the condensed (default) format."
 D ^DIR
 Q:'Y
 D STUF150
 Q
DEL150 ;Delete user ien from 1st record in file 79's field 150
 ; note: DIK utility looks for DA(1) here
 Q:'$D(DUZ)#2
 S DA(1)=$O(^RA(79,0)) Q:'DA(1)
 S DIK="^RA(79,"_DA(1)_",""LDIS"","
 S DA=$O(^RA(79,DA(1),"LDIS","B",DUZ,0))
 Q:'DA
 D ^DIK
 K DIK,DA
 W !!,"Your preference for Long Display of Procedures has been removed.",!
 Q
STUF150 ;Stuff user ien into 1st record in file 79's field 150
 Q:'$D(DUZ)#2
 S RA1=$O(^RA(79,0)) Q:'RA1
 K RAFDA,RAIEN,RAMSG
 S RAFDA(79.03,"?+2,"_RA1_",",.01)=DUZ
 D UPDATE^DIE("","RAFDA","RAIEN","RAMSG")
 W !!,"Your preference for Long Display of Procedures has been set.",!
 Q
CDIS ; set up RACDIS array to store 1st non-duplicate proc+pmod+cptmod
 N N1,N2,R1,RA71,Y
 K RACDIS
 D LDIS
 S N1=0
 F  S N1=$O(^RADPT(RADFN,"DT",RADTI,"P",N1)) Q:'N1  S R1=$G(^(N1,0)) D:R1]""
 . S RA71=$P(R1,U,2),RACNI=N1
 . D MODS^RAUTL2
 . S RACDIS("B",RA71,Y,Y(1),N1)=""
 . S N2=$O(RACDIS("B",RA71,Y,Y(1),0))
 . S RACDIS(N2)=$G(RACDIS(N2))+1 ;increment lowest ien of same proc+pmod+cptmod
 . S:RACDIS(N2)>1 RACDIS("RAFLDUP")=1 ;>1 same proc+pmod+cptmod
 . Q
 Q
LDIS ; See if user prefers Long Display of Procedures
 N RA1
 S RA1=$O(^RA(79,0)) Q:'RA1
 S:$O(^RA(79,RA1,"LDIS","B",DUZ,0)) RALDIS=1
 Q
LIST ;
 ;;RA("DIV");^DIC(4,;RADI;3
 ;;RA("LOC");^RA(79.1,;RADI;4
 ;;RA("WRD");^DIC(42,;Y(0);6
 ;;RA("SERV");^DIC(49,;Y(0);7
 ;;RA("CL");^SC(;Y(0);8
 ;;RA("CONT");^DIC(34,;Y(0);9
 ;;RA("RES");^VA(200,;Y(0);12
 ;;RA("DIA");^RA(78.3,;Y(0);13
 ;;RA("PHY");^VA(200,;Y(0);14
 ;;RA("STAFF");^VA(200,;Y(0);15
 ;;RA("CMP");^RA(78.1,;Y(0);16
 ;;RA("RM");^RA(78.6,;Y(0);18
 ;;RA("BED");^DIC(42.4,;Y(0);19
