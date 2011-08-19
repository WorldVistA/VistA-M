RAPMW ;HOIFO/SWM-Radiology Wait Time reports ;03/19/05 12:45
 ;;5.0;Radiology/Nuclear Medicine;**67,79,83,99**;Mar 16, 1998;Build 5
 ;RVD - 3/19/09 p99
 ;
 ; ___ set up RACESS array
 I $D(DUZ),($O(RACCESS(DUZ,""))']"") D CHECK^RADLQ3(DUZ)
 ; ___ new/set/kill other variables
 K ^TMP($J)
 ;**********************************************************
 ;*  On Dec. 14, 2006, Dr. Anderson requested that the
 ;*  RADIAION THERAPY procedure type be dropped from the
 ;*  Wait Times Report but it may be included in the future.
 ;*  
 ;*  If RADIATION THERAPY will be included again, the only
 ;*  coding that needs to be changed is the line below; it
 ;*  should be removed.  The rest of the coding that handles
 ;*  exclusion of Procedure Types don't have to be changed
 ;*  because it uses RAXCLUDE() to exclude procedure types.
 ;*
 S RAXCLUDE("RADIATION THERAPY")=""
 ;*
 ;***********************************************************
 D SETPTA
 S (RATOTAL,RAXIT)=0
 W @IOF
 W !,"Radiology Outpatient Procedure Wait Time Report"
 ; __ get report type
 D GETTYP I $D(DIRUT) G EXIT
 ; ___ get date range
 W !! D GETDATE I $D(DIRUT) G EXIT
 ; ___ get division
 S X=$$GETDIV() I X G EXIT
 ; ___ ask what to ask next, procedure or img typ
 D ASKIP I RANX="" G EXIT
 I RANX="P" D  W "."
 .W !!?5,"All PROCEDURE TYPES will be included"
 .I $O(RAXCLUDE(""))]"" D
 .W ", except "
 .S I="" F  S I=$O(RAXCLUDE(I)) Q:I=""  W I W:$O(RAXCLUDE(I))]"" ", "
 .Q
 I RANX="C" D  I RAQUIT G EXIT
 . ; ___ get procedure/CPT CODE(s)
 . D GETPROC
 . Q
 ; *79, skip ask spec imaing type
 I "B^D"[RATYP D  I $D(DIRUT) G EXIT
 . D ASKSORT I $D(DIRUT) Q
 . D ASKDAYS
 . Q
 I "B^D"[RATYP D
 .S RATXT="*** The detail report requires a 132 column output device ***"
 .S RALINE="",$P(RALINE,"*",$L(RATXT)+1)=""
 .W !!?(80-$L(RATXT)\2),RALINE,!?(80-$L(RATXT)\2),RATXT,!?(80-$L(RATXT)\2),RALINE,!
 .Q
 D GETDEV I RAPOP G EXIT
 D START
 Q
START ; taskman to del task after job, set Radiology IO
 S:$D(ZTQUEUED) ZTREQ="@" S RAIO=$S(IO="":0,1:1) ;RAIO true/false
 ; get data
 ;    remove: inpatient, cancelled
 ;    keep: specific proc/CPT, imag types if entered
 S RASAME=0 ; count # procedures cancelled and re-ordered same day
 S RANEG=0 ; count # negative Days Wait
 D GETDATA
 U:RAIO IO
 I "S^B"[RATYP D WRTSUM^RAPMW1 Q:$G(RAS99)!$G(RAL99)  ; summary report
 I RATYP="B",$E(IOST,1,2)'="C-" W @IOF
 I "D^B"[RATYP D WRTDET^RAPMW2 ; detail report
 D EXIT
 Q
GETTYP ;
 S DIR(0)="S^S:Summary;D:Detail;B:Both"
 S DIR("A")="Select Report Type",DIR("B")="S"
 S DIR("?")="Enter Summary report OR Detail report OR Both reports"
 W !!,"Enter Report Type"
 D ^DIR K DIR
 Q:$D(DIRUT)
 S RATYP=Y
 Q
GETDATE ; start and end dates
 S DIR(0)="D^:"_DT_":AEX"
 W !?4,"The starting and ending dates are based upon what was entered at",!?4,"the ""Imaging Exam Date/Time"" prompt during Registration.",!
 S DIR("A")="Enter starting date"
 S DIR("?")="Enter date to begin searching Exam date from"
 D ^DIR K DIR
 Q:$D(DIRUT)
 S RABDATE=Y
 ;
 S RADD=91,X1=RABDATE,X2=RADD D C^%DTC S RAMAXDT=X
 I RAMAXDT>DT S RAMAXDT=DT W !!?4,"** Ending Date cannot be later than today's date. **",!
 S DIR(0)="D^"_RABDATE_":"_RAMAXDT_":AEX"
 S DIR("A")="Enter ending date"
 S DIR("?",1)="+91 days max. for Summary and Detail."
 S DIR("?")="But the Ending Date cannot be later than today's date."
 D ^DIR K DIR
 Q:$D(DIRUT)
 ;
 ; RABDATE, RAEDATE original values
 ; RABEGDT, RAENDDT used in GETDATA
 ; Set to end of day
 S RAEDATE=Y,RAENDDT=RAEDATE_.9999
 ; Set to include current day
 S RABEGDT=(RABDATE-1)_.9999
 Q
GETDIV() ;
 N X S X=$$SETUPDI^RAUTL7() Q:X 1
 D SELDIV^RAUTL7
 I '$D(^TMP($J,"RA D-TYPE"))!(RAQUIT) D  Q 1
 .K RACCESS(DUZ,"DIV-IMG"),^TMP($J,"DIV-IMG")
 .Q
 Q 0
ASKIP ;
 S RANX=""
 S DIR(0)="S^C:CPT Code/Procedure Name;P:Procedure Type"
 S DIR("?")=" "
 S DIR("?",1)="   ""CPT Code/Procedure Name"" will include only the"
 S DIR("?",2)="   user selected CPT Codes and Procedure names in this"
 S DIR("?",3)="   date range, except for cases that are cancelled, have"
 S DIR("?",4)="   no credit, and are inpatient."
 S DIR("?",5)=" "
 S DIR("?",6)="   ""Procedure Type"" will include all cases in this"
 S DIR("?",7)="   date range, except for the 3 exclusions above and also"
 S DIR("?",8)="   except if the case is part of a printset and it is not"
 S DIR("?",9)="   the highest ranked modality in the printset."
 S DIR("A")="What do you want to choose next",DIR("B")="P"
 W !!,"Enter next item to select."
 D ^DIR K DIR
 Q:$D(DIRUT)
 S RANX=Y
 Q
 ; *79 removed GETIMG() section
GETPROC ;
 S RADIC="^RAMIS(71,",RADIC(0)="QEAMZ"
 S RADIC("A")="Select Procedure/CPT Code: "
 S RAUTIL="RA WAIT"
 D EN1^RASELCT(.RADIC,RAUTIL)
 Q:RAQUIT
 S RA1=""
 F  S RA1=$O(^TMP($J,"RA WAIT",RA1)) Q:RA1=""  S RA2=0 D
 .F  S RA2=$O(^TMP($J,"RA WAIT",RA1,RA2)) Q:'RA2  S ^TMP($J,"RA WAIT2",RA2)="",^TMP($J,"RA WAIT1",RA1)=$P($$NAMCODE^RACPTMSC($P($G(^RAMIS(71,RA2,0)),U,9),DT),U) D
 ..;if parent was selected, then save iens of its descendents for FILTER2
 ..I $P(^RAMIS(71,RA2,0),U,6)="P" D
 ...S RA3=0 F  S RA3=$O(^RAMIS(71,RA2,4,"B",RA3)) Q:'RA3  S ^TMP($J,"RA WAIT2",RA3)=""
 ...Q
 ..Q
 .Q
 Q
ASKSORT ;
 S DIR(0)="S^CN:Case Number;CPT:CPT Code;DD:Date Desired;D:Days Wait;DO:Date of Order;DR:Date of Registration;I:Imaging Type;PN:Patient Name;PT:PROCEDURE TYPE;PROC:Procedure Name"
 S DIR("?")="Select which item to use for sorting the Detail Report"
 S DIR("A")="Sorted by",DIR("B")="D"
 W !!,"Sort report by"
 D ^DIR
 I $D(DIRUT) K DIR Q
 S RASORT=Y
 S RASORTNM=Y(0)
 S:RASORTNM["Regis" RASORTNM="Dt. Register"
 K DIR
 Q
ASKDAYS ;
 S DIR(0)="N^0:120"
 S DIR("A")="Print wait days greater than or equal to"
 S DIR("B")="0"
 S DIR("?",1)="Enter the minimum number of Days Wait between Date Desired and Registered Date."
 S DIR("?",2)="Only cases with Days Wait greater than or equal to this value"
 S DIR("?")="will be listed in the detail report."
 D ^DIR K DIR Q:$D(DIRUT)  S RASINCE=Y
 Q
GETDEV ;
 W:RATYP="B" !!,"Specify device for both summary and detail reports."
 D TASK
 D ZIS^RAUTL
 Q
TASK ; set vars for taskman
 S ZTRTN="START^RAPMW"
 S ZTSAVE("RA*")=""
 S ZTSAVE("^TMP($J,")=""
 S ZTDESC="Radiology Outpatient Wait Time Report"
 Q
GETDATA ;
 S RABAD=0 ;=0 means nothing bad, so accept case; =1 means reject case
 ;loop thru exam date (RADTE)
 S RADTE=RABEGDT
 F  S RADTE=$O(^RADPT("AR",RADTE)) Q:'RADTE  Q:(RADTE>RAENDDT)  D
 .S RADFN="" F  S RADFN=$O(^RADPT("AR",RADTE,RADFN)) Q:'RADFN  S RABAD=0 D
 ..S RADTI="" F  S RADTI=$O(^RADPT("AR",RADTE,RADFN,RADTI)) Q:'RADTI  D FILTER1^RAPMW1 I 'RABAD D
 ...S RACNI=0 F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:'RACNI  D FILTER2^RAPMW1 I 'RABAD D CALC^RAPMW2
 ...Q
 ..Q
 .Q
 Q
EXIT ;
 S:$G(RAS99)!$G(RAL99) RAP99=1
 D:'$G(RAP99) CLOSE^RAUTL ;close dev. if it's not a mail wait and time
 K I,J,POP,RA0,RA1,RA16,RA2,RA3,RA71REC,RA72,X,X1,X2,Y
 K RABAD,RACHKDIV,RACN0,RACNI,RACNISAV,RACNL,RACOL,RACOL14
 K RACPT,RADASH,RADD,RADFN,RADIC,RADIV,RADSDT,RADTE,RADTI,RADTORD
 K RAH1,RAH3,RAH4,RAH5,RAH6,RAH7,RAH8,RAHD0,RAIMGTYP
 K RAIT,RAITYP,RAKEY,RALINE,RAMAX,RAMAXDT,RANEG,RANOW,RANX
 K RAOREC,RAORIEN,RAPATND,RAPATNM,RAPG,RAPOP,RAPROCNM,RAPSTX,RAQUIT
 K RAR,RAREC,RASAME,RASAME2,RASELDIV,RASINCE,RASORT,RASORTNM
 K RAAVG,RATOTAL,RATYP,RAUTIL,RAWAITD,RATXT,RAXDT,RAXIT,RAXMST
 K RACPTC,RACPTI,RAHI,RAHIER,RAPCT,RAPCT14,RAPRC,RAPTA,RARY,RAXCLUDE,RAMES
 K:'$G(RAP99) RAEDATE,RABDATE,RAENDDT,RABEGDT,^TMP($J),RAIO,RAIOM ;cln var if not mail
 ;
 ; ^TMP($J,"RA I-TYPE","CT SCAN",ienFile79.2)="" <--*79 not needed
 ; ^TMP($J,"RA D-TYPE","SUPPORT ISC",ienFile79)=""
 ; ^TMP($J,"RA WAIT",ProcNam,ienFile71)=""<--from EN1^RASELCT
 ; ^TMP($J,"RA WAIT1",ProcNam)=CPTcode<--hdr of rpt, SETHD^RAPMW1
 ; ^TMP($J,"RA WAIT2",ienFile71)=""<--screen cases, FILTER2^RAPMW1
 ;ex.   ^TMP($J,"RA WAIT","TEETH",31)=
 ;ex.   ^TMP($J,"RA WAIT1","TEETH")=70320
 ;ex.   ^TMP($J,"RA WAIT2",31)=
 ; ^TMP($J,"RA WAIT NO ORD",RADFN,RADTI,RACNI)=ienFile75.1
 ; ^TMP($J,"RA WAIT NO DSR DT",RADFN,RADTI,RACNI)=ienFile75.1
 ; ^TMP($J,"RA WAIT3",RASORT,RADTE,RAPATNM,RACNI)=""<--detail display
 Q
SETPTA ;Set up Proc Type Array, w Sherrill Snuggs' Xcel file
 ; also setup RATOTAL(), RACOL(,), RAHIER()
 N I,J
 S I=""
 ; RATOTAL(I) sub-total, each Proc Type
 ; RAWAITD(I) total wait days, each Proc Type
 ; RAAVG(I)   average wait days, each Proc Type
 ; RACOL14(I) <14 days column
 F  S I=$O(^RA(73.2,"AC",I)) Q:I=""  S RATOTAL(I)=0,RAWAITD(I)=0,RAAVG(I)=0,RACOL14(I,"FR")=0 F J=1:1:5 S RACOL(I,J)=0
 S I="unknown",RATOTAL(I)=0,RAWAITD(I)=0,RAAVG(I)=0,RACOL14(I,"FR")=0 F J=1:1:5 S RACOL(I,J)=0
 ; Rank Proc Types, needed to pick case from printset
 ; 1=Interventional  2=MR  3=CT  4=Card. Stress Test  5=NM
 ; 6=US  7=Mammo  8=Plain Film (Gen Rad)  9=Other
 S I=""
 F  S I=$O(RATOTAL(I)) Q:I=""  D
 .S J=$E(I,1,3)
 .S RAHIER(I)=$S(J="CAR":4,J="COM":3,J="GEN":8,J="INT":1,J="MAG":2,J="MAM":7,J="NUC":5,J="ULT":6,1:9)
 .Q
 Q
 ;added in p#99
PWT(RABDATE,RAEDATE) ;entry point of EMAIL performance and wait time as part of a task job
 S RAXCLUDE("RADIATION THERAPY")=""
 D SETPTA S (RATOTAL,RAXIT)=0
 K:$G(RAL99) RAS99
 S RANX="P",RATYP="S"
 D START
 D EXIT
 Q
