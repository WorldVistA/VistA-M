RASTED ;HISC/CAH,FPT,GJC,SS AISC/TMP,TAC,RMO-Edits for status tracking ;05/22/09  12:30
 ;;5.0;Radiology/Nuclear Medicine;**1,10,18,28,45,71,82,99**;Mar 16, 1998;Build 5
 ;last modif by SS for P18 JUN 19,2000
 ;02/10/2006 BAY/KAM RA*5*71 Add ability to update exam data to V/R
 ; *** 'RASTED' is called from the routine; 'CASE^RASTEXT1'. ***
 ;last modification by SS May 12,2000
 ;
 ;Supported IA #10040 reference to ^SC
 ;Supported IA #1367 reference to LKUP^XPDKEY
 ;Supported IA #2056 reference to GET1^DIQ
 ;Supported IA #10060 reference to ^VA(200
 S RAL=X F I2=1:1 S X=$P(RAL,",",I2) Q:X=""  S RAVW="" W !!,"Case # being tracked: ",X D SEL^RACNLU D:'RACNT KEY D START:RACNT&((X'="^")&(X'=""))
 K RAL,RAI,RAPRI,I2,I3,RAVW,RAEND,RANME,RAPRC,RARPT,RADTE,RADT0,RANEXT,RANXT72,RASK,RACN,RACN0,RADFN,RADUZ,RAPOP,RAST,RAST0,RAFL,RAFST,RAIX,RASSN,RACOMP,X Q
 ;RACOMP defined if [RA STATUS CHANGE] was processed completely
START F I3=1:1:11 S @$P("RADFN^RADTI^RACNI^RANME^RASSN^RADATE^RADTE^RACN^RAPRC^RARPT^RAST","^",I3)=$P(Y,"^",I3)
 I '$D(^RA(72,+RAST,0)) W $C(7),"Invalid status for case #: ",RACN R X:3 Q
 S RAST0=^RA(72,+RAST,0) I $P(RAST0,"^",3)=9 W $C(7),!,"Exam is already complete!!" R X:3 Q
 S X1=""
 I $D(^RA(72,+$P(RAST0,"^",2),0)) S RANEXT=^(0),RASK=$S($D(^(.2)):^(.2),1:""),RANXT72=+$P(RAST0,"^",2)
NEXT I '$D(RANEXT) S DIC("A")="Enter Next Status: ",DIC="^RA(72,",DIC(0)="AEFQZ",DIC("S")="I $P(^(0),U,3),$P(^(0),U,7)=$O(^RA(79.2,""B"",RAIMGTY,0))" D ^DIC K DIC Q:Y'>0  S RANEXT=Y(0),RASK=$S($D(^RA(72,+Y,.2)):^(.2),1:""),RANXT72=+Y
 I $P(RANEXT,"^")=$P(RAST0,"^") W $C(7),!,"Status has already been set to ",$P(RANEXT,"^") R X:3 Q
 I $$LKUP^XPDKEY(+$P(RANEXT,"^",4))]"",'$D(^XUSEC($$LKUP^XPDKEY(+$P(RANEXT,"^",4)),DUZ)) W $C(7),!,"You are not authorized to change to this status" R X:3 Q
 ; check if next status has order field filled in
 G:$P(RANEXT,U,3)]"" OK2
 N RANXTIEN,RALINE S RANXTIEN=$P(RAST0,U,2),$P(RALINE,"_",50)=""
 W !!?15,$C(7),RALINE
 W !!?15,$C(7),"Default Next Status (",$P(RANEXT,U),") is *NOT* active.",!?15,$C(7),RALINE,!
NXT S RANXTIEN=$P(^RA(72,RANXTIEN,0),U,2)
 G:$P($G(^RA(72,+RANXTIEN,0)),U,3)=9 OK0 ;next default status is COMPLETE
 G:RANXTIEN="" BAD ;no next default status pointer
 G:'$D(^RA(72,RANXTIEN,0)) BAD ;no next default status record
 G:$P($G(^RA(72,RANXTIEN,0)),U,3)="" NXT ;no order data, so loop back
 G OK0
BAD W !?15,$C(7),RALINE
 W !!?18,$C(7),"There is no valid higher status to advance to.",!?15,$C(7),RALINE
KEY W !! K DIR S DIR(0)="E",DIR("A")="Press Return key to continue " D ^DIR
 K DIR,DIRUT,DUOUT Q
OK0 S RANEXT=$G(^RA(72,RANXTIEN,0)),RANXT72=RANXTIEN
OK1 W !?15,$C(7),RALINE,!!?18,"Next valid status is : ",$P(RANEXT,U),!?15,$C(7),RALINE
OK2 S RADT0=^RADPT(RADFN,"DT",RADTI,0),RACN0=^("P",RACNI,0),RACS=$P(RACN0,"^",24),RAPRIT=$P(RACN0,"^",2)
CHANGE W !!,"Name: ",RANME,?40,"Case #  : ",RACN,!,"Division : ",$S($D(^DIC(4,+$P(RADT0,"^",3),0)):$P(^(0),"^"),1:"")
 W ?40,"Location: ",$S('$D(^RA(79.1,+$P(RADT0,"^",4),0)):"",$D(^SC(+^(0),0)):$P(^(0),"^"),1:"")
 W !,"Procedure: ",RAPRC
 D PRCCPT^RAPROD
 ;p99: get sex and display pregnancy data if available for female pt.
 I $$PTSEX^RAUTL8(RADFN)="F" D
 .N RAORD0,RAPCOMM S RAORD0=$P(RACN0,U,11)
 .S RAPCOMM=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"PCOMM"))
 .W !,"PREGNANT AT TIME OF ORDER ENTRY: ",?22,$$GET1^DIQ(75.1,RAORD0_",",13)
 .W:$P(RACN0,U,32)'="" !,"PREGNANCY SCREEN: ",$S($P(RACN0,"^",32)="y":"Patient answered yes",$P(RACN0,"^",32)="n":"Patient answered no",$P(RACN0,"^",32)="u":"Patient is unable to answer or is unsure",1:"")
 .W:$P(RACN0,U,32)'="n"&$L(RAPCOMM) !,"PREGNANCY SCREEN COMMENT: ",RAPCOMM
 ;end p99
 W !,"   ***** Old Status: ",$P(RAST0,"^"),!,"   ***** New Status: ",$P(RANEXT,"^")
 I RAPRC="Unknown" W !!?5,$C(7),"This record is corrupted -- the procedure is missing,",!?5,"please contact your ADPAC or IRM",! K DIR S DIR(0)="E",DIR("A")="Press RETURN to Continue" D ^DIR K DIR,DIROUT,DIRUT,DTOUT,DUOUT Q
ASK R !,"Do you wish to continue? YES// ",X1:DTIME S:X1="" X1="Y" Q:'$T!(X1["^")!("nN"[X1)
 I X1["?" W !!,"Answer 'Yes' or 'No'.",! G ASK
 S RADUZ=DUZ I '$P(RAMDV,"^",6)!($P(RASK,"^",11)["Y") S RAPOP=0 D USER Q:RAPOP
 N RAPRTSET,RAMEMARR D EN2^RAUTL20(.RAMEMARR) ;is this a print set ?
 N RAWHICH,RAREM,RABEFORE,RAAFTER
 S DIE("NO^")="BACKOUTOK",DR="[RA STATUS CHANGE]"
 S DA=RADFN,RADADA=RADTI,DIE="^RADPT(",RADIE="^RADPT("_RADFN_",""DT"","
 S RAXIT=$$LOCK^RAUTL12(RADIE,RADADA) Q:RAXIT
 ;
 ;save 'before' CM data value to compare against the possible 'after'
 ;value
 D TRK70CMB^RAMAINU(RADFN,RADTI,RACNI,.RATRKCMB) ;RA*5*45
 ;
 D SVBEFOR^RAO7XX(RADFN,RADTI,RACNI) ;P18 save before edit to compare later
 K RACOMP D ^DIE
 ;P18. $D(RABEFORE)=0 means that RASTREQ was not run - the user has interrupted input or timeout happened. So we must call it, then check result (is status changed) and if so - update 70.03 #3 and set RA70033=X
 I '$D(RABEFORE) K DA S X=RANXT72 D:X ^RASTREQ  I $D(X)#2 S RA70033=X D U70033^RADD3(RADFN,RADTI,RACNI,X)
 ;
 ;1) check data consistency between 'CONTRAST MEDIA USED' & 'CONTRAST
 ;MEDIA'
 ;2) check 'before' CM data against 'after' CM data, file in audit log
 ;if necessary. Remember, contrast media asked when in input template:
 ;RA EXAM EDIT (RA*5*45)
 S RACMDA=RACNI,RACMDA(1)=RADTI,RACMDA(2)=RADFN
 D XCMINTEG^RAMAINU1(.RACMDA) ;1
 D TRK70CMA^RAMAINU(RADFN,RADTI,RACNI,RATRKCMB) ;2
 K RACMDA,RAOPRC
 ;
 K DIE("NO^"),DQ,DE,RATRKCMB,RAZCM
 K RANM702,RADIOPH,RADOSE,RAIEN702,RAHI,RALOW,RAPRI,RAMIS,RAI,RAPSDRUG,RAR1
 ;
 ; if EXAM STATUS didn't process, still go thru status-change-logic
 ; variables
 ; ---------
 ;   RA70033: is set in the RA STATUS CHANGE input template after the
 ;             update to the EXAMINATION STATUS field (70.03;3)
 ;    RATCXX: are technologist comments (if any) input by the user
 ;     RAMDV: division parameters, piece 10; store the date/time
 ;            of an exam status change (1 for yes, 0 for no)
 ;
 D:$D(RA70033)&($P(RAMDV,"^",10)) X7005^RADD3(RADFN,RADTI,RACNI,RAMDV,"",RA70033,$S($D(RADUZ):RADUZ,1:DUZ))
 D A7007^RADD3(RADFN,RADTI,RACNI,$S($D(RADUZ):RADUZ,1:DUZ),$G(RATCXX))
 D UNLOCK^RAUTL12(RADIE,RADADA) K RADADA,RADIE
 K RA70033,RADUZ,RATCXX
 N RACN0A ; updated version of the exam node after status updates
 W !,"...Status ",$S($D(RAAFTER)&($G(RABEFORE)=$G(RAAFTER)):"unchanged",$G(RABEFORE)>$G(RAAFTER):"backed down",1:"successfully changed")," for case #: ",RACN
 ;
 ;02/10/2006 BAY/KAM RA*5*71 ,modified in RA*5*82...
 I $D(RAAFTER),$G(RABEFORE)=$G(RAAFTER) R X:3 D  Q  ;exit if no change
 .;Modified for RA*5*82
 .N RAEXEDT S RAEXEDT=$$CMPAFTR^RAO7XX(1) ;;P18 compares if procedure was changed sends XX message
 .D:RAEXEDT EXM^RAHLRPC ;P18 compares if procedure was changed sends XX message
 ;
 ; if status got backed down, RANEXT is re-defined inside rtn RASTREQ
 ; when the above edit template gets to the EXAM STATUS field
 ;
 D ^RAORDC I +$P(RANEXT,"^",3)>1,RACS'="Y",$S($P(RACN0,"^",6)']"":1,$P(^DIC(42,+$P(RACN0,"^",6),0),U,3)="D":1,1:0) D EN^RAUTL0
 S RACN0A=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) ; updated 0 node!
 ; Do we need to 'Generate Exam Alert' based on the exam status?
 I $D(^RA(72,+$P(RACN0A,"^",3),"ALERT")),($P(^("ALERT"),"^")="y") D
 . ; fire off the 'Rad Patient Examined' alert.
 . N RAPRIT,RAORDIFN
 . S RAPRIT=+$P(RACN0A,"^",2) ; possible call to OERR3^RAORDU1
 . S RAORDIFN=+$P(RACN0A,"^",11) ; possible call to OERR^RAORDU1
 . D:$$ORVR^RAORDU()=2.5 OERR^RAUTL1
 . D:$$ORVR^RAORDU()'<3 OERR3^RAUTL1
 . Q
 ;
 R X:3 D
 .N RAEXEDT S RAEXEDT=$$CMPAFTR^RAO7XX(1)
 .D EXM^RAHLRPC
 ;P18 compares -if procedure was changed - sends XX message
 Q
USER S %="A",%DUZ=DUZ W ! D ^XUVERIFY G USERQ:%=-1 I %'=1 W $C(7)," ??" G USER
 Q
USERQ K RADUZ S RAPOP=1 Q
WHY1 ;explain why prim/sec resid/staff, diagnoses prompts are skipped
 Q:$G(DA)<1!($G(DA(1))<1)!($G(DA(2))<1)
 N RA0,RA1,RA2,RA5 N:'$D(RA3)#2 RA3 N:'$D(RA4)#2 RA4
 S RA0=$G(^RADPT(DA(2),"DT",DA(1),"P",DA,0)) Q:'RA0  S RA2=0
 I $G(RA3)=13 D WHY11 G WHYMSG ;diagnoses
 S RA3=12,RA4=70 D WHY11 ;residents
 S RA3=15,RA4=60 D WHY11 ;staff
WHYMSG W:'RA2 !!?12,"No data have been entered for ",$S(RA3'=13:"residents/staff",1:"diagnoses")," yet.",!
WHYMSG2 W !?12,$C(7),"The selected case belongs to a print set,",!?12,"Please use the 'Report Enter/Edit' option",!?12,"to enter data for ",$S(RA3=99:"residents/staff/diagnoses",RA3'=13:"residents/staff",1:"diagnoses"),".",!!
 Q
WHY11 Q:'+$P(RA0,"^",RA3)
 S RA2=1 W !!?2,$P(^DD(70.03,RA3,0),"^")," :",?35
 W:RA3'=13 $P(^VA(200,+$P(RA0,"^",RA3),0),"^") W:RA3=13 $P(^RA(78.3,+$P(RA0,"^",RA3),0),"^") W !
 S RA5=$P($P(^DD(70.03,RA4,0),"^",4),";") Q:'$O(^RADPT(DA(2),"DT",DA(1),"P",DA,RA5,0))
 S RA1=0 W !?4,$P(^DD(70.03,RA4,0),"^")," :"
 F  S RA1=$O(^RADPT(DA(2),"DT",DA(1),"P",DA,RA5,RA1)) Q:'RA1  I +^(RA1,0) W ?37 W:RA3'=13 $P($G(^VA(200,+^(0),0)),"^") W:RA3=13 $P($G(^RA(78.3,+^(0),0)),"^") W !
 Q
WHY2 ;explain why diags prompts are skipped
 N RA3 S RA3=13,RA4=13.1 G WHY1
