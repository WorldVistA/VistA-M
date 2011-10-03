RAWKL ;HISC/FPT AISC/MJK,RMO-Workload Reports ;12/27/00  11:00
 ;;5.0;Radiology/Nuclear Medicine;**26**;Mar 16, 1998
 ;
 I $O(RACCESS(DUZ,""))="" D SETVARS^RAPSET1(0) S RAPSTX=""
 ; RAFL flags Tech Rpt and Camera Rpt
SUM S X="-----------------" W !!,RATITLE," Workload Report:",!,X,$E(X,1,$L(RATITLE)) K RAFL1,^TMP($J)
ASKSUM ;
 W ! K DIR S DIR(0)="Y",DIR("A")="Do you wish only the summary report",DIR("B")="NO",DIR("?")="Enter YES for a summary report or NO for a detailed report"
 D ^DIR K DIR I $D(DIRUT) D Q^RAWKL2 Q
 I RATITLE["Interpreting" D  Q:RAPRIM=-1
 . S RAPRIM=$$PRI($P(RATITLE," ",2)) D:RAPRIM=-1 Q^RAWKL2
 . Q
 S:Y=0 RAFL1=""
 K DIROUT,DIRUT,DTOUT,DUOUT
 S X=$$DIVLOC^RAUTL7() I X D Q^RAWKL2 Q
 S A="" F  S A=$O(RACCESS(DUZ,"DIV-IMG",A)) Q:A']""  D
 . Q:'$D(^TMP($J,"RA D-TYPE",A))  S A1=$O(^TMP($J,"RA D-TYPE",A,0))
 . Q:A1'>0  S B=""
 . F  S B=$O(RACCESS(DUZ,"DIV-IMG",A,B)) Q:B']""  D
 .. I $D(^TMP($J,"RA I-TYPE",B)) D IT^RALWKL2 I B1?3AP1"-".N S ^TMP($J,"RAWKL",A1,B1)=0
 .. Q
 . Q
 K A,A1,B,B1,RACCESS(DUZ,"DIV-IMG")
 S RAINPUT=$$ALLNOTH^RALWKL3() I RAINPUT="" D Q^RAWKL2 Q
 I RAINPUT=0 D RSPTR I RAQUIT=1 D Q^RAWKL2 Q
 I RAINPUT=0 S RAFLDCNT=0,RALP="" F  S RALP=$O(^TMP($J,"RAFLD",RALP)) Q:RALP=""  S RAFLDCNT=RAFLDCNT+1
 K RALP
 D DATE^RAUTL I RAPOP D Q^RAWKL2 Q
 S RAXIT=0 D DISPXAM^RALWKL1(RACRT) I RAXIT D Q^RAWKL2 Q
 S ZTDESC="Rad/Nuc Med "_RATITLE_" Workload Report",ZTRTN="START^RAWKL" S ZTSAVE("RAFL*")="",ZTSAVE("^TMP($J,""RAWKL"",")="",ZTSAVE("^TMP($J,""RAFLD"",")=""
 F RASV="BEGDATE","ENDDATE","RAFILE","RAFLDCNT","RAPCE","RAPSTX","RATITLE","RACRT","RAINPUT","RAPRIM","RACMLIST" S ZTSAVE(RASV)=""
 W ! D ZIS^RAUTL I RAPOP D Q^RAWKL2 Q
START ; start processing
 U IO K ^TMP($J,"RA") S:$D(ZTQUEUED) ZTREQ="@" K RAEOS
 S RABEG=BEGDATE-.0001,RAEND=ENDDATE+.9999,RA80DASH=$$REPEAT^XLFSTR("-",80)
 S Y=BEGDATE D D^RAUTL S BEGDATE=Y
 S Y=ENDDATE D D^RAUTL S ENDDATE=Y
 S X="NOW",%DT="T" D ^%DT K %DT D D^RAUTL S RARUNDTE=Y
 D CRIT^RAUTL1 S RACPT=""
 S RAITCNT=0,RALP=""
 F  S RALP=$O(^TMP($J,"RAWKL",RALP)) Q:RALP=""  S RAITCNT(RALP)=0,^TMP($J,"RA",RALP)="0^0^0" S RALP1="" F  S RALP1=$O(^TMP($J,"RAWKL",RALP,RALP1)) Q:RALP1=""  S RAITCNT(RALP)=RAITCNT(RALP)+1,^TMP($J,"RA",RALP,RALP1)="0^0^0"
 K RALP,RALP1
 F RADTE=RABEG:0:RAEND S RADTE=$O(^RADPT("AR",RADTE)) Q:RADTE'>0!(RADTE>RAEND)!($D(RAEOS))  S RADTI=9999999.9999-RADTE D RADFN^RAWKL1
 G:'$D(RAEOS) ^RAWKL2
 Q
 ;
TECH S RAFILE="VA(200,",RACRT=7,RAPCE="TC",RATITLE="Technologist",RAFL="" G RAWKL
 ;
RES N RAPRIM S RAFILE="VA(200,",RACRT=13,RAPCE=12,RATITLE="Interpreting Resident" G RAWKL
 ;
STAFF N RAPRIM S RAFILE="VA(200,",RACRT=14,RAPCE=15,RATITLE="Interpreting Staff" D ASK1 I $D(DIRUT) D Q^RAWKL2 Q 
 G RAWKL
 ;
PHY S RAFILE="VA(200,",RACRT=12,RAPCE=14,RATITLE="Requesting M.D." G RAWKL
 ;
ROOM S RAFILE="RA(78.6,",RACRT=11,RAPCE=18,RATITLE="Camera/Equip/Room",RAFL="" G RAWKL
 ;
RSPTR ; select res/staff/phy/tech/room to include in workload rpts
 ; Creates ^TMP($J,"RAFLD",File 200 NAME)=""
 K ^TMP($J,"RAFLD")
 S RACNT=0
 ; check for one res/staff/tech only
 I RACRT=7!(RACRT=13)!(RACRT=14) S RASUBSPT=$S(RACRT=7:"T",RACRT=13:"R",RACRT=14:"S",1:""),RAONECHK=0 F  S RAONECHK=$O(^VA(200,"ARC",RASUBSPT,RAONECHK)) Q:RAONECHK=""!(RACNT>1)  S RACNT=RACNT+1
 I RACNT=1 D RST,KILL Q
 ; check for one physician only
 I RACRT=12 S RAONECHK=0 F  S RAONECHK=$O(^XUSEC("PROVIDER",RAONECHK)) Q:RAONECHK=""!(RACNT>1)  S RACNT=RACNT+1
 I RACNT=1 D P,KILL Q
 ; check for one camera room only
 I RACRT=11 S RAONECHK=$P(^RA(78.6,0),U,4) I RAONECHK=1 S RAIEN=$O(^RA(78.6,0)) Q:RAIEN<1  S RAONENME=$P(^RA(78.6,+RAIEN,0),U,1)_$P(^RA(78.6,+RAIEN,0),U,2),RAONENME=$E(RAONENME,1,30),^TMP($J,"RAFLD",RAONENME)="" D KILL Q
 I RACRT=7!(RACRT=13)!(RACRT=14)!(RACRT=12) S RADIC="^VA(200,"
 I RACRT=11 S RADIC="^RA(78.6,"
 S RADIC(0)="QEAMZ"
 S RADIC("A")="Select "_RATITLE_": "
 I RACRT=7 S RADIC("S")="I $D(^VA(200,""ARC"",""T"",+Y))"
 I RACRT=13 S RADIC("S")="I $D(^VA(200,""ARC"",""R"",+Y))"
 I RACRT=14 S RADIC("S")="I $D(^VA(200,""ARC"",""S"",+Y))"
 I RACRT=12 S RADIC("S")="I $D(^XUSEC(""PROVIDER"",+Y))"
 S RAUTIL="RAFLD"
 D EN1^RASELCT(.RADIC,RAUTIL,"",RAINPUT)
KILL ;
 K %W,%Y1,DIC,RACNT,RADIC,RAIEN,RAONECHK,RAONENME,RASUBSPT,RAUTIL,X,Y
 Q
RST ; resident/staff/tech
 S RAIEN=$O(^VA(200,"ARC",RASUBSPT,0)),RAONENME=$P(^VA(200,+RAIEN,0),U,1),RAONENME=$E(RAONENME,1,30),^TMP($J,"RAFLD",RAONENME)=""
 Q
P ; physicians
 S RAIEN=$O(^XUSEC("PROVIDER",0)),RAONENME=$P(^VA(200,+RAIEN,0),U,1),RAONENME=$E(RAONENME,1,30),^TMP($J,"RAFLD",RAONENME)=""
 Q
PRI(RACLS) ; Ask user to include Pri. Res/Staff only in the
 ; 'Interpreting Res/Staff' report
 ; Input: RACLS-> 'Resident' or 'Staff'
 ; Returns: 1 if Pri. Staff only, 0 if Pri. & Sec. Staff included, and
 ; -1 if exiting without a report
 W ! K DIR,DIROUT,DIRUT,DTOUT,DUOUT N X,Y
 S DIR(0)="Y",DIR("A")="Count "_RACLS_" when entered as 'secondary'"_$S(RACLS?1"S".E:" staff",1:" resident")_" interpreter",DIR("B")="Yes"
 S DIR("?",1)="Answer 'Yes' if both Primary and Secondary "_RACLS_" personnel will be included"
 S DIR("?",2)="in this report.  Answer 'No' if only Primary "_RACLS_" personnel will be"
 S DIR("?")="included in this report.  Input a '^' to exit without a report."
 D ^DIR S:$D(DIRUT) Y=-1 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 Q $S(+Y=-1:-1,+Y:0,1:1)
ASK1 ; ask user if want to put CPT modifiers as separate line items
 K DIR S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Do you want to count CPT Modifiers separately"
 S DIR("?")="Enter YES to put different combinations of CPT modifiers onto separate lines"
 W ! D ^DIR K DIR
 S:Y RACMLIST=1 ;=1 means to list CPT mods as separate line items
 Q
