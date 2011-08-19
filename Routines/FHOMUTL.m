FHOMUTL ;Hines OIFO/RTK OUTPATIENT MEALS UTILITIES  ;2/04/03  15:15
 ;;5.5;DIETETICS;**1,2,5**;Jan 28, 2005;Build 53
 ;
DIV ;ask for Communication office if Multi-division.
 N FHSCNT,FH
 K FHSITE,FHSITENM
 S FHSCNT=0 F FH=0:0 S FH=$O(^FH(119.73,FH)) Q:FH'>0  S FHSCNT=FHSCNT+1,FHSITE=FH,FHSITENM=$P($G(^FH(119.73,FH,0)),U,1)
 I (FHSCNT=1),($P($G(^FH(119.9,1,0)),U,20)'="Y") Q
D2 I FHSCNT>1 K FHSITE,FHSITENM,X R !!,"Select COMMUNICATION OFFICE (or ALL): ALL// ",X:DTIME S:X="" X="ALL" Q:'$T!("^"[X)  D TR^FH I X="ALL" S FHSITE=0
 I X'="ALL" K DIC S DIC="^FH(119.73,",DIC(0)="EMQ" D ^DIC G:Y<1 D2 S FHSITE=+Y,FHSITENM=$P(Y,U,2)
 Q
 ;
STDATE ;Prompt for start date (if FHPSDT="N" do not allow past dates)
 S STDT="" D NOW^%DTC S Y=X D DD^%DT S FHDTDF=Y
 K DIR S DIR("A")="Select Start Date: ",DIR("B")=FHDTDF
 S DIR(0)="DAO" I $G(FHPSDT)="N" S DIR(0)="DAO^FHDTDF"
 D ^DIR Q:$D(DIRUT)  S STDT=Y S Y=STDT D DD^%DT W "  ",Y
 Q
ENDATE ;Prompt for end date
 S ENDT="" D NOW^%DTC S Y=X D DD^%DT S FHDTDF=Y K DIR
 S DIR("A")="Select End Date: ",DIR("B")=FHDTDF,DIR(0)="DAO^"_STDT D ^DIR
 Q:$D(DIRUT)  S ENDT=Y S Y=ENDT D DD^%DT W "  ",Y
 Q
OUTLOC ;Prompt for outpatient location - screen for ONLY Outpatient Locations
 S FHLOC="",FHOUT="O"
 K DIC S DIC="^FH(119.6,",DIC(0)="AEQZ"
 S DIC("A")="Select Outpatient Ordering Location: "
 S DIC("S")="I $P(^(0),U,3)=FHOUT" D ^DIC
 Q:$D(DUOUT)  I Y=-1 Q
 S FHLOC=+Y,FHCOMM=$P($G(^FH(119.6,FHLOC,0)),U,8)
 I '$O(^FH(119.6,FHLOC,"L",0)) S FHLOC="",FHCOMM="" W !!,"The selected location does not have an Associated Hospital Location.  To set",!,"the Associated Hospital Location use option ENTER/EDIT NUTRITION LOCATIONS."
 Q
 ;
RMBED ;Prompt for outpatient room-bed - must be set up for Outpatient Location
 S (FHRMBD,FHRMBSL)=""
 I $G(FHLOC)="" W !!,"No OUTPATIENT LOCATION selected" Q
 I '$D(^FH(119.6,FHLOC,"R")) Q
 F FHRMBI=0:0 S FHRMBI=$O(^FH(119.6,FHLOC,"R",FHRMBI)) Q:FHRMBI'>0  D
 .S FHRMBPT=$P($G(^FH(119.6,FHLOC,"R",FHRMBI,0)),U),FHRMBSL(FHRMBPT)=1
 K DIC S DIC="^DG(405.4,",DIC(0)="AEQZ"
 S DIC("A")="Select Outpatient Room-Bed: "
 S DIC("S")="I $D(FHRMBSL(+Y))" D ^DIC
 Q:$D(DUOUT)  I Y=-1 Q
 S FHRMBD=+Y
 Q
GTFHDFN ;Get FHDFN, given DFN
 K DIR S DIR(0)="NAO",DIR("B")="ENTER DFN" D ^DIR Q:$D(DIRUT)  S ZZDFN=Y
 S FHZ115="P"_ZZDFN,FHDFN=$O(^FHPT("B",FHZ115,""))
 I '$D(^DPT(ZZDFN)) W !!,"DFN '",ZZDFN,"' NOT FOUND IN FILE 2",! Q
 I FHDFN="" W !!,"NO CORRESPONDING FHDFN"
 W !!," NAME: ",$P($G(^DPT(ZZDFN,0)),U,1)
 W !?2,"DFN: ",ZZDFN,!,"FHDFN: ",FHDFN,!
 Q
GETOPT ;Select outpatient for recurring meals
 S FHFIND=1 D ^FHOMDPA I FHDFN="" S FHFIND=0 Q
 I '$D(^FHPT(FHDFN,0)) S FHFIND=0 Q  ;W !!,"UNKNOWN SELECTION !"
 I $O(^FHPT(FHDFN,"OP",0))="" W !!,"NO RECURRING MEALS FOR THIS PERSON" S FHFIND=0 Q
 W ! D STDATE I STDT="" S FHFIND=0 Q
 Q
PATNAME ;Get name and demographics of patient/new person
 ;input variable: FHDFN
 S (FHDOB,FHBID,FHSEX,DFN)="" D GETZN
 I FILE="P" S FHPTNM=$P($G(^DPT(IEN,0)),U,1)
 I FILE="N" S FHPTNM=$P($G(^VA(200,IEN,0)),U,1)
 ;Get SSN,Age,DOB,Sex of patient/new person
 I FILE="P" D
 .S DFN=IEN
 .D PID^FHDPA S FHSSN=PID
 .S FHSEX=$P($G(^DPT(DFN,0)),U,2),FHDOB=$P($G(^DPT(DFN,0)),U,3)
 .S FHBID=BID
 I FILE="N" D
 .S IEN200=IEN,FHSSN=$P($G(^VA(200,IEN,1)),U,9)
 .S FHBID=$E(FHSSN,6,$L(FHSSN))
 .S FHSEX=$P($G(^VA(200,IEN,1)),U,2),FHDOB=$P($G(^VA(200,IEN,1)),U,3)
 S FHAGE="" D NOW^%DTC
 I FHDOB'="" S FHAGE=$E(%,1,3)-$E(FHDOB,1,3)-($E(%,4,7)<$E(FHDOB,4,7))
 Q
GETZN ;Get first piece of zero node in 115
 S FHPCZN=$P($G(^FHPT(FHDFN,0)),U,1),FILE=$E(FHPCZN,1)
 S IEN=$E(FHPCZN,2,99)
 Q
DIETVER ;Verify that diet selected is from the allowable diets in 119.9
 D DIETLST I $D(FHDIETS(FHDIET)) Q
 S FHDIET="" W *7," ==> NOT ALLOWED",! D DIETMSG Q
DIETHLP ;Display allowable diets from 119.9
 D DIETLST,DIETMSG Q
DIETLST ;Build list
 K FHDIETS,SPD S FHSPDTS="",SPD=$P($G(^FH(119.9,1,0)),U,2,6)_"^"_$P($G(^FH(119.9,1,1)),U,1,10)
 S FHDEF=$P($G(^FH(119.9,1,0)),U,2)
 F A=1:1:15 S AB=$P(SPD,U,A) D
 .I AB="" Q
 .S FHDIETS(AB)=AB
 .S FHSPDTS=FHSPDTS_$P($G(^FH(111,AB,0)),U,1)_"^"
 Q
DIETMSG ;Display message
 W !?3,"You must select from the diets set up in the Site Parameters:"
 S AB="" F  S AB=$O(FHDIETS(AB)) Q:AB'>0  W !?3,$P($G(^FH(111,AB,0)),U)
 W ! Q
 Q
EXMSG ;Display message stating meal NOT ordered
 D TYPE
 W !!?3,FHMSGML," NOT ordered!",! H 2
 Q
OKMSG ;Display message stating meal ordered successfully
 D TYPE
 D PATNAME W !!?3,FHMSGML," ordered for ",FHPTNM,"...",! H 2
 Q
TYPE ;
 S FHMSGML=$S(FHMSG1="G":"Guest meal",FHMSG1="S":"Special meal",FHMSG1="R":"Recurring meal",FHMSG1="E":"Early/Late tray",FHMSG1="T":"Tubefeeding",1:"Additional order")
 Q
UPXMSG ;
 W !!?3,"Recurring meal NOT updated! ",! H 2
 Q
UPDMSG ;
 D PATNAME W !!?3,"Recurring meal updated for ",FHPTNM,"...",! H 2
 Q
SMSTAT ;Status of last special meal request
 S FHSMNUM=$O(^FHPT(FHDFN,"SM","B",""),-1) I FHSMNUM="" S FHSTAT="" Q
 I $E(FHSMNUM,1,7)'=DT S FHSTAT="" Q
 S FHSTAT=$P($G(^FHPT(FHDFN,"SM",FHSMNUM,0)),U,2)
 Q
RANGE ;Check for validity of range of numbers entered
 S FHCLST="",FLG="",X=FHNUM D TR^FH S FHNUM=X
 I FHNUM="A"!(FHNUM?1"A"1.2"L") S FHNUM="1-"_NUM
 F K=1:1 S K1=$P(FHNUM,",",K) Q:K1=""!(FLG="QUIT")  D
 .S K2=$S(K1["-":$P(K1,"-",2),1:+K1),K1=+K1 D CK I FLG="QUIT" Q
 .F K3=K1:1:K2 S FHCLST=FHCLST_K3_","
 Q
CK I K1<1!(K1>NUM)!(K1'?1N.N) D C1 Q
 I K2<1!(K2>NUM)!(K2'?1N.N) D C1 Q
 Q:K2'<K1
C1 W !,"  Enter numbers or range or ALL (E.G.,  1,3,4 or 3-5 or 1,3-5)" S FLG="QUIT",FHCLST="" Q
 Q
MSHOM ;Code MSG for outpatient orders
 D SITE^FH
 S MSG(1)="MSH|^~\&|DIETETICS|"_SITE(1)_"|||||ORM"
 S MSG(2)="PID|||"_DFN_"||"_$P($G(^DPT(DFN,0)),"^",1)
 S FHOLOC=$O(^FH(119.6,FHLOC,"L",0)) I FHOLOC="" Q  ;RESULTS IN NO BKDOOR
 S FHOLOC=$G(^FH(119.6,FHLOC,"L",FHOLOC,0))
 S FHOLOCNM=$P($G(^SC(FHOLOC,0)),U,1)
 S MSG(3)="PV1||O|"_FHOLOC_"^"_FHOLOCNM_"||||||||||||||||"
 Q
MSHCA ;Code Cancel/Discontinue for outpatient orders
 D NOW^%DTC S FHNOW=% K MSG S ACT="OC" D SITE^FH
 I $G(FHCATXT)="" S FHCATXT="Dietetics Canceled order."
 S MSG(1)="MSH|^~\&|DIETETICS|"_SITE(1)_"|||||ORM"
 S MSG(2)="PID|||"_DFN_"||"_$P($G(^DPT(DFN,0)),"^",1)
 S DATE=$$FMTHL7^XLFDT(FHNOW)
 S MSG(3)="ORC|"_ACT_"|"_FHORN_"^OR|"_FILL_"^FH|||||||||"_DUZ_"|||"_DATE_"|"_FHCATXT
 Q
MSHSS ;Code MSG for outpatient send status messages
 D SITE^FH
 S MSG(1)="MSH|^~\&|DIETETICS|"_SITE(1)_"|||||ORR"
 S MSG(2)="PID|||"_DFN_"||"_$P($G(^DPT(DFN,0)),"^",1)
 S MSG(3)="ORC|SR|"_FHORN_"^OR|"_FILL_"||"_FHSTTS
 Q
CONVC ;Convert Amount/Unit in file 118.2, from "C" to "ML".
 F FHII=0:0 S FHII=$O(^FH(118.2,FHII)) Q:FHII'>0  D
 .S FHAU=$P(^FH(118.2,FHII,0),U,3)
 .I FHAU["C" S FHAF=$P(FHAU,"C",1),FHAS=$P(FHAU,"C",2) D
 ..S $P(^FH(118.2,FHII,0),U,3)=FHAF_"ML"_FHAS
 Q
MONUM ;Prompt for number of monitors to display
 W ! K DIR S FHNUM="",DIR("?")="Select ALL to view all monitors, or select a specific number.  For example, enter 20 to display the 20 most recent monitors."
 S DIR(0)="F",DIR("A")="How many monitors would you like to display?"
 S DIR("B")="ALL" D ^DIR
 I $D(DIRUT) S FHNUM="" Q
 S FHNUM=Y I FHNUM'="A",FHNUM'="ALL",FHNUM'?1.5N D MONUM Q
 I FHNUM="A"!(FHNUM="ALL") S FHNUM=99999
 Q
