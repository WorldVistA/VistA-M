RAEDCN ;HISC/CAH,FPT,GJC,SS AISC/MJK,RMO-Edit Exams by Case Number ; Feb 19, 2021@08:08:21
 ;;5.0;Radiology/Nuclear Medicine;**5,13,10,18,28,31,34,45,85,97,124,175**;Mar 16, 1998;Build 2
 ;
 ; 06/11/2007 KAM/BAY RA*5*85 Remedy Call 174790 Change Exam Cancel
 ;            to allow only descendent exams with stub report
 ;
 ;last modified by SS JUNE 21,2000 for P18
START D SET^RAPSET1 I $D(XQUIT) K XQUIT,RAFLG,RADR,POP,RAQUICK Q
START1 ;
 N RAERR
 D ^RACNLU S RAERR=0 G EXIT:X="^"
 I RADR="[RA DIAGNOSTIC BY CASE]" D  I RAERR R !?5,"Press RETURN to exit:",RAXIT:DTIME G EXIT
 .N RAPRTSET,RAMEMARR,RA3,RA7003,RA17
 .D EN2^RAUTL20(.RAMEMARR)
 .S RA3=99
 .; disallow case that is a member of a printset, fld 25 = 2
 .I RAPRTSET W ! D WHYMSG2^RASTED S RAERR=1 Q
 .S RA7003=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 .S RA17=$P(RA7003,U,17)
 .; disallow case that has no report or has stub report
 .I 'RA17!($$STUB^RAEDCN1(+RA17)) S RAERR=1 W !?3,$C(7),"No report has been entered yet for this exam, therefore it cannot be edited.",! Q
 .; disallow case that has an elec. filed report
 .I $P($G(^RARPT(+RA17,0)),U,5)="EF" S RAERR=1 D WARN1 Q
 .Q
 I $D(^RA(72,"AA",RAIMGTY,9,+RAST)),'$D(^XUSEC("RA MGR",+$G(DUZ))) W !!?3,$C(7),"You do not have the appropriate access privileges to edit completed exams." G START1
 I $D(^RA(72,"AA",RAIMGTY,0,+RAST)) W !!?3,$C(7),"Exam has been 'cancelled' therefore it cannot be edited." G START1
 I RADR="[RA DIAGNOSTIC BY CASE]",$D(^RARPT(RARPT,0)),$P(^(0),"^",5)="V" W !!?3,$C(7),"A report has been verified for this exam, therefore it cannot be edited.",! G START
 S DA=RADFN,DIE("NO^")="OUTOK",DIE="^RADPT(",DR=RADR
 I $D(RAFLG("EDIT"))!($D(RAFLG("DIAG"))) D  G:+$G(RAXIT) START1
 . S RADADA=RADTI,RADIE="^RADPT("_RADFN_",""DT"","
 . S RAXIT=$$LOCK^RAUTL12(RADIE,RADADA)
 . Q
 I RADR="[RA EXAM EDIT]" D
 . N RADISPLY
 . S RADISPLY=$G(^RAMIS(71,+$P($G(^RADPT(+RADFN,"DT",+RADTI,"P",+RACNI,0)),U,2),0)) ; set $ZR to 71 for prccpt^radd1, not call raprod since diff col
 . S RADISPLY=$$PRCCPT^RADD1()
 . W !,?24,RADISPLY
 .;
 .;save 'before' CM data value to compare against the possible 'after'
 .;value
 .D TRK70CMB^RAMAINU(RADFN,RADTI,RACNI,.RATRKCMB) ;RA*5*45
 .;
 . Q
 D:RADR'="[RA NO PURGE SPECIFICATION]" SVBEFOR^RAO7XX(RADFN,RADTI,RACNI) ;P18 save before edit to compare it in RAUTL1 later
 D ^DIE K DIE("NO^"),DE,DQ,DIE,DR,RAZCM
 D:RADR'="[RA NO PURGE SPECIFICATION]" UP1^RAUTL1
 ;
 ;1) check data consistency between 'CONTRAST MEDIA USED' & 'CONTRAST
 ;MEDIA'
 ;2) check 'before' CM data against 'after' CM data, file in audit log
 ;if necessary. Remember, contrast media asked when in input template:
 ;RA EXAM EDIT (RA*5*45)
 I RADR="[RA EXAM EDIT]" D
 .S RACMDA=RACNI,RACMDA(1)=RADTI,RACMDA(2)=RADFN
 .D XCMINTEG^RAMAINU1(.RACMDA) ;1
 .D TRK70CMA^RAMAINU(RADFN,RADTI,RACNI,RATRKCMB) ;2
 .K RACMDA Q
 ;
 I $D(RAFLG("EDIT"))!($D(RAFLG("DIAG"))) D UNLOCK^RAUTL12(RADIE,RADADA)
 K RATRKCMB,RADUZ,RAZZ W ! G START1:'+$G(RAXIT)
 ;
EXIT ;clean up symbol table and exit
 K %,%DT,%W,%X,%Y,%Y1,A,C,D0,D1,D2,DA,DIC,DIE,DIV,DK,I,ORIFN,ORVP,POP,RACN,RACNI,RACS,RACT,RADADA,RADATE,RADFN,RADIE,RADIV,RADR,RADTE,RADTI,RAEXFM,RAEXLBLS,RAFIN,RAFL,RAFLG,RAFLH,RAFLHFL,RAHEAD,RAI,RAJ
 K RAMES,RANME,RANUM,RAOIFN,RAOR,RAORDIFN,RAOREA,RAORIFN,RAOSEL,RAOSTS,RAPOP,RAPRI,RAPRC,RAQUICK,RAPRIT,RARPT,RARPTZ,RASN,RASSN,RAST,RASTI,RAVW,X,XQUIT,VAINDT,VADMVT,Y,^TMP($J,"RAEX")
 K %H,%I,D,D3,DDER,DI,DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,GMRAL,RAEXOR
 K J,SDCLST,R1,RA,RACANC,RACN0,RACPT,RACPTNDE,RADA,RAEND,RAFELIG,RAFST
 K RAIX,RAN,RAOBR4,RAPRCNDE,RAPROC,RAPROCIT,RAPRV,RAXIT,VA,VADM,VAERR,Z
 K DFN,DIPGM,DISYS,DQ,DR,HLN,HLRESLT,HLSAN,RAAFTER,RABEFORE,X0
 K DLAYGO,DDH,RADFLTP
 Q
 ;
DIAG N RADIAG,RAXIT
 S RAXIT=0,RAFLG("DIAG")="",RADR="[RA DIAGNOSTIC BY CASE]" G START
 ;
SAVE S RADR="[RA NO PURGE SPECIFICATION]" G START
 ;
EDIT ; Case No. Exam Edit
 N RAEDIT,RAXIT
 N RAREM,RANUZD1,RAPSDRUG,RA00,RADIOPH,RALOW,RAHI,RADRAWN,RAASK,RADOSE,RASKMEDS,RAWHICH ;these are used by the edit template
 S RAXIT=0,RAFLG("EDIT")="",RAQUICK=1,RADR="[RA EXAM EDIT]" G START
 ;
CANCEL ;new w/RA5p124
 D SET^RAPSET1 ;checks for DUZ if not defined we exit
 I $D(XQUIT) K XQUIT Q
 ;
 ;check for EXAM CANCELLED ("C") 0 if found, else 1
 Q:$$CKREASON^RAEDCN1("C")=1  ;RA5P124
 ;
 ;*** this code down to ASKCAN stays w/124 ***
 D ^RACNLU G EXIT:X="^" I $D(^RA(72,"AA",RAIMGTY,0,+RAST)) W !?3,$C(7),"This exam has already been cancelled!" G EXIT
 I $D(^RA(72,+RAST,0)),$P(^(0),"^",6)'="y" W !?3,$C(7),"This exam is in the '",$P(^(0),"^"),"' status and cannot be 'CANCELLED'." G EXIT
 ; 06/11/2007 KAM/BAY *85 Added descendent check to next line
ASKIMG I RARPT,($$STUB^RAEDCN1(RARPT)),($$PSET^RAEDCN1(RADFN,RADTI,RACNI)) D  G:"Nn"[$E(X) EXIT G:"Yy"[$E(X) ASKCAN W:X'["?" $C(7) W !!?3,"Enter 'YES' to cancel a descendent exam with images, or 'NO' not to." G ASKIMG
 . S X=RANME_"'s Case No. "_$E(RADTE,4,7)_$E(RADTE,2,3)_"-"_RACN ;p175
 . W !!?10,"----------------------------------",$C(7)
 . W !?10,X
 . W !?10,"This descendent exam has associated images.",$C(7)
 . W !?10,"----------------------------------",$C(7)
 . I '$D(^XUSEC("RA MGR",DUZ)) D  S X="N" Q
 .. W !!?3,"** You do not have the  RA MGR  key to cancel an exam with images. **",$C(7)
 .. R !!?10,"Press RETURN to continue.",X:DTIME
 .. Q
 . R !!,"Do you really want to cancel this exam with images? NO//",X:DTIME S:'$T!(X="")!(X["^") X="N"
 . Q
 ;
 I RARPT W !?3,$C(7),"A report has been filed for this case. Therefore cancellation is not allowed!" G EXIT
 ;
 ;is someone editing this patient record? if yes, quit (check moved w/RA5p124)
 L +^RADPT(RADFN):1 I '$T W !,$C(7),"Someone else is editing the patient you selected",!,"Please try later" K RADTE,RACN,RAPOP,RADUZ G EXIT
 ; you set a lock, you must clear it!
 ;
ASKCAN ;interact with the user use DIR RA5p124
 N %,DIR,DIROUT,DIRUT,DTOUT,DUOUT,RAY2,RAY3,X,Y
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("?")="Enter 'YES' to cancel this exam. or 'NO' not to."
 S DIR("A")="Do you wish to cancel this exam now"
 D ^DIR
 ;Yes/No: Y=1 for yes else Y=0 for no
 ;$D(DIRUT) indicates caret or timeout
 I $D(DIRUT)!(Y=0) D  Q
 .L -^RADPT(RADFN) ;unlock
 .D EXIT ;cleanup vars
 .Q
 ;/ end askcan /
 ;
 ;When an exam is cancelled & it is associated with data in the Nuc
 ;Med Exam Data file (70.2) ask the user if this pointer to 70.2 is
 ;to be deleted.  Also delete the flag 'Dosage Ticket Printed?' which
 ;indicates that the dosage ticket had printed for this exam.
 D DELPNT^RAUTL20(RADFN,RADTI,RACNI)
 ;
 ;get TECHNOLOGIST COMMENT & REASON FOR CANCELLATION (both optional)
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S RATCOM=$$GETTCOM^RAUTL11(RADFN,RADTI,RACNI) ;pseudo default
 S DIR(0)="70.07,4A",DIR("A")="TECHNOLOGIST COMMENT: "_RATCOM_"//" D ^DIR
 I $D(DUOUT)#2!($D(DTOUT)#2) L -^RADPT(RADFN) D EXIT QUIT 
 S RATCOM=$P(Y,U)
 ;
 ;/*** RA5_0P175 begin ***/
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="70.03,3.5^^I ""^1^9^""[(U_$P(^(0),U,2)_U)"
 S DIR("A")="REASON FOR CANCELLATION" D ^DIR
 I $D(DUOUT)#2!($D(DTOUT)#2) L -^RADPT(RADFN) D EXIT QUIT
 ; Staying true to past functionality, this is not a required
 ; field. There is no default reason presented to the user.
 S RAREASON=$S(+Y>0:+Y,1:$O(^RA(75.2,"B","EXAM CANCELLED","")))
 ;  >>> RA5_0P175 'EXAM CANCELLED' becomes the default reason <<<
 ;/*** RA5_0P175 end ***/
 ;
 ;(we've not canceled the exam just yet)
 S RAY2=$G(^RADPT(RADFN,"DT",RADTI,0)) ;70.02
 S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) ;70.03
 S RAOIFN=+$P(RAY3,U,11)
 ;
 ;In EXMCAN^RAORDC the logic (EN1^RASETU) is called to check
 ;if there are multiple studies registered for the same date/time.
 ;RAEXOR = the ORDER of the exam status for the exam in play
 ;RAOSTS = is the request status the order will be set to.
 S (RAEXOR,RAOSTS)=0 D EXMCAN^RAORDC
 ;
 ;check if the user times out or ^'s out (function returns -1)
 ;when asked if they want to cancel the order in RAORDC.
 I RAOSTS=-1 L -^RADPT(RADFN) Q
 ;
 ;cancel the exam, update exam status tracking and activity logs
 D CANCEL^RAEDCN1
 ;release the lock
 L -^RADPT(RADFN)
 ;
PACS ;call all RA CANCEL* event drivers only if the order status
 ;and exam status have been updated! this is a new LOCK series
 D CANCEL^RAHLRPC
 D EXIT ;cleanup
 QUIT
 ;
 ;
DUP ; Option: RA FLASH
 N RAREGX,RAYN D SET^RAPSET1 I $D(XQUIT) K XQUIT,POP Q
DUP1 D ^RACNLU G EXIT:X="^"
 G EXIT:'$D(^RADPT(RADFN,"DT",RADTI,0))
 S RAREGX(0)=$G(^RADPT(RADFN,"DT",RADTI,0))
 S RAREGX(4)=+$P(RAREGX(0),"^",4)
 I +$G(RAMLC)'=RAREGX(4) D  I $P(RAYN,"^",2) D EXIT QUIT
 . W !!?3,"Your sign-on location is: "
 . W $P($G(^SC(+$G(^RA(79.1,+$G(RAMLC),0)),0)),"^")_".  The location"
 . W !?3,"of case ",RACN," is "
 . W $P($G(^SC(+$G(^RA(79.1,RAREGX(4),0)),0)),"^"),".",!
 . K DIR,DIROUT,DIRUT,DTOUT,DUOUT S DIR(0)="Y",DIR("B")="Yes"
 . S DIR("?")="Enter 'Y'es to switch locations or 'N'o exit the option."
 . S DIR("A")="Do you wish to switch Imaging Locations" D ^DIR
 . S RAYN=+Y_"^"_$S($D(DIRUT):1,1:0)
 . K DIR,DIROUT,DIRUT,DTOUT,DUOUT  Q:'+RAYN  ; quit if no
 . D KILL^RAPSET1,SET^RAPSET1 ; else switch locations
 . I $D(XQUIT) S $P(RAYN,"^",2)=1 K XQUIT
 . Q
 S ION=$P(RAMLC,"^",3) ; imaging location flash card printer (if any)
 G EXIT:'$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) S Y=^(0),Y=$S($D(^RAMIS(71,+$P(Y,"^",2),0)):$P(^(0),"^",3),1:"")
 ; if Y, then convert the pointer value 'Y' to the .01 value of
 ; the procedure flash card printer (if any)
 I Y]"",$D(^%ZIS(1,+Y,0)) D
 . S Y(0)=$$GET1^DIQ(3.5,+Y,.01) ; .01 value for proc flash card printer
 . S:Y(0)'=$P(RAMLC,"^",3) ION=Y(0) K Y(0)
 . ; if flash card printer for the imaging location differs from
 . ; the procedure flash card printer, default (print to) to the flash
 . ; card printer for the procedure.
 . Q
 S RAMES="W !!,""Duplicates queued to print on "",ION,"".""",RAFLH=$S($P(RAMLC,"^",7):$P(RAMLC,"^",7),1:1),RAEXFM=$S($P(RAMLC,"^",9):$P(RAMLC,"^",9),1:1),RAFLHFL=RACNI
FLH ; Flash Cards
 R !,"How many flash cards? 1// ",X:DTIME G DUP1:'$T!(X["^") S:X="" X=1 S RANUM=X I '(RANUM?.N)!(RANUM>20) W !?3,$C(7),"Must be a whole number less than 21!" G FLH
EXM ; Exam Labels
 R !,"How many exam labels? 1// ",X:DTIME G DUP1:'$T!(X["^") S:X="" X=1 S RAEXLBLS=X I '(RAEXLBLS?.N)!(RAEXLBLS>20) W !?3,$C(7),"Must be a whole number less than 21!" G EXM
 S IOP="Q" S:ION]"" RADFLTP=ION
 K RAFL D Q^RAFLH,EXIT G DUP1
 ;
SETVARS ; Setup key Rad/Nuc Med variables
 I $O(RACCESS(DUZ,""))="" D SETVARS^RAPSET1(0)
 Q:'($D(RACCESS(DUZ))\10)  ; user does not have location access
 I $G(RAIMGTY)="" D SETVARS^RAPSET1(1) K:$G(RAIMGTY)="" XQUIT
 Q
WARN1 W !?3,"An electronically filed report has already been entered for this case.",!?3,"Please use the 'Outside Report Entry/Edit' option to change or enter",!?3,"diagnostic code for this case.",!!
 Q
