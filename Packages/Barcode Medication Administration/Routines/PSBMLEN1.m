PSBMLEN1 ;BIRMINGHAM/EFC-BCMA MEDICATION LOG FUNCTIONS ;03/06/16 3:06pm
 ;;3.0;BAR CODE MED ADMIN;**3,4,9,11,13,28,50,83**;Mar 2004;Build 89
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ; Reference/IA
 ; ENE^PSJBCMA4/3416
 ;
 ;*83 - move Disp Drug data to param 11 from 10 previously.  Param 10
 ;      now in use for Remove time not used in this manual entry
 ;    -  add Rem time string to display
 ;    -  validation checks for proper use of Inj & derm site text
 ;
NEW(Y) ; Create the new entry
 N PSBREC,PSB,PSBADST,PSBFREQ
 S PSBMMEN=1
 W @IOF D CLEAN^PSBVT,PSJ1^PSBVT(DFN,Y)
 D NOW^%DTC
 I PSBOSP<% D  Q:%'=1
 .W @IOF,$C(7)
 .W !,"NOTICE: This order is NOT currently active."
 .W !,"        Are You Sure You Want To Continue"
 .S %=2 D YN^DICN
 I PSBADST="" S PSBFREQ=$$GETFREQ^PSBVDLU1(DFN,PSBONX),PSBADST=$$GETADMIN^PSBVDLU1(DFN,PSBONX,PSBOST,PSBFREQ,PSBDT)
 E  K ^TMP("PSB",$J,"GETADMIN") S ^TMP("PSB",$J,"GETADMIN",0)=PSBADST
 S PSBODSCH=0 I (PSBFREQ#1440'=0),(1440#PSBFREQ'=0) S PSBODSCH=1
 W !,"Order:         ",PSBONX
 W !,"Medication:    ",PSBOITX
 W !,"Dosage:        ",PSBDOSE
 W !,"Schedule:      ",PSBSCH
 W !,"Admin Times:   ",$S(PSBODSCH:"(Odd Sched.)",1:PSBADST)
 D:PSBMRRFL>0                            ;add Removal times if MRR *83
 .W !,"Removal Times: "
 .W $S(PSBMRRFL=1:$$REMSTR^PSBUTL(PSBADST,PSBDOA,PSBSCHT,PSBOSP,PSBOPRSP),1:PSBRMST)
 I $D(^XUSEC("PSB READ ONLY",DUZ)) D  Q
 .W !!,"Medications CANNOT be administered while in PSB READ ONLY mode.",!! R "Press ENTER KEY to continue. ",PSBCNTNU:5
 W !!,"Is this the correct Order" S %=1 D YN^DICN Q:%'=1
 ;
 ; PRN, One-Time, On Call orders
 ;
 I PSBSCHT'="C" D
 .D VAL^PSBMLVAL(.PSB,DFN,+PSBONX,$E(PSBONX,$L(PSBONX)))
 .I PSBSCHT="P",($D(PSB(1))) W !!,"Brief Administration History:  ",! S X=$O(PSB(" "),-1),X=$S(X>4:4,1:X) F I=1:1:X W !,?5,PSB(I)
 .I $D(^XUSEC("PSB READ ONLY",DUZ)) W !,"This operation is NOT AVAILABLE in PSB READ ONLY mode.",! Q
 .I ($D(^XUSEC("PSB STUDENT",DUZ))),('$D(^XUSEC("PSB INSTRUCTOR"))) W !,"This operation is NOT AVAILABLE in PSB READ ONLY mode.",! Q
 .W !!,"Create an administration for this order" S %=1 D YN^DICN Q:%'=1
 .I PSBSCHT="P" D  Q:Y=""!(Y["^")
 ..K DIR S DIR(0)="FB^1:30",DIR("A")="PRN Reason (1-30 characters)"
 ..W !!,"NOTICE: PRN Reason is Required for ALL PRN Entries",!
 ..D ^DIR
 ..I Y=""!(Y["^") W !!,"Sorry, Reason is required, No Entry Made!" Q
 ..S PSBREC(6)=$P(Y,"|")
 .; Build the form of dosage to CAP or TAB or null
 .S:(PSBDOSEF'?1"CAP".E)&(PSBDOSEF'?1"TAB".E)&(PSBDOSEF'?1"PATCH".E) PSBDOSEF=""
 .; Build the variable dose check #####-#####MG
 .S PSBVARD=$S(PSBDOSE?1.5N1"-"1.5N.E:1,1:0)
 .S PSBREC(0)=DFN
 .S PSBREC(1)=PSBONX
 .S PSBREC(2)=PSBSCHT
 .S PSBREC(3)="G"
 .S PSBREC(4)=PSBOIT
 .S PSBREC(5)=""
 .S PSBREC(7)="Entry created with 'Manual Medication Entry' option."
 .S PSBREC(8)=""
 .S PSBREC(9)=$S(PSBONX["U":"UDTAB",1:"PBTAB")
 .S PSBREC(10)=""                   ;init Rmv dt/tim for One Times *83
 .S PSBINDX=11                        ;Disp Drug moved to param 11 *83
 .S X="" F  S X=$O(PSBDDA(X)) Q:X=""  D
 ..S PSBREC(PSBINDX)=$P(PSBDDA(X),U,1,2)_U_$P(PSBDDA(X),U,4)_U_$P(PSBDDA(X),U,4)_U_PSBDOSEF_U_U_U_PSBMRRFL    ;add MRR flag 8th piece *83
 ..S PSBINDX=PSBINDX+1
 .S X="" F  S X=$O(PSBADA(X)) Q:X=""  S PSBREC(PSBINDX)=PSBADA(X),PSBINDX=PSBINDX+1
 .S X="" F  S X=$O(PSBSOLA(X)) Q:X=""  S PSBREC(PSBINDX)=PSBSOLA(X),PSBINDX=PSBINDX+1
 .D FILE
 .I $G(DA),PSBREC(2)="O",$D(^PSB(53.79,DA)) I $P(^PSB(53.79,DA,0),U,9)="G" D ENE^PSJBCMA4(PSBREC(0),PSBREC(1))
 ;
 ; Continuous Meds
 ;
 I PSBSCHT="C" D
 .W ! S %DT="AEQ",%DT("A")="Enter the DATE the medication was administered: "
 .D NOW^%DTC S %DT(0)=(-1)*X,%DT("B")="" D ^%DT K %DT(0) Q:Y<1  S PSBDTX=Y D D^DIQ
 .S:PSBODSCH PSBSCTMX=$$GETADMIN^PSBVDLU1(DFN,PSBONX,PSBOST,PSBFREQ,PSBDTX)
 .F PSBXX=0:1 Q:$G(^TMP("PSB",$J,"GETADMIN",PSBXX))=""  D
 ..S X="",Y=$G(^TMP("PSB",$J,"GETADMIN",PSBXX))
 ..F Z=1:1:$L(Y,"-") S X=X_$S(X]"":";",1:"")_Z_":"_$P(Y,"-",Z)
 .I PSBODSCH,PSBSCTMX="" D  Q
 ..W !!,"Order "_PSBONX_" is NOT SCHEDULED for administration on that entered date."
 ..K DIR S DIR(0)="E^" D ^DIR
 .K DIR S DIR(0)="S^"_X,DIR("A")="Select Administration Time"
 .D ^DIR Q:Y<1
 .S PSBDTX=+(PSBDTX_"."_Y(0))
 .S Y=PSBDTX D D^DIQ
 .W !!,"Create an administration for ",Y S %=1 D YN^DICN  Q:%'=1
FORUM .; Build the form of dosage to CAP or TAB or null
 .S PSBDOSEF=$G(PSBDOSEF)
 .S:(PSBDOSEF'?1"CAP".E)&(PSBDOSEF'?1"TAB".E)&(PSBDOSEF'?1"PATCH".E) PSBDOSEF=""
 .; Build the variable dose check #####-#####MG
 .S PSBVARD=$S(PSBDOSE?1.5N1"-"1.5N.E:1,1:0)
 .S PSBREC(0)=DFN
 .S PSBREC(1)=PSBONX
 .S PSBREC(2)=PSBSCHT
 .S PSBREC(3)="G"
 .S PSBREC(4)=PSBOIT
 .S PSBREC(5)=PSBDTX
 .S PSBREC(6)=""
 .S PSBREC(7)="Entry created with 'Manual Medication Entry' option."
 .S PSBREC(8)=""
 .S PSBREC(9)=$S(PSBONX["U":"UDTAB",1:"PBTAB")
 .;init Rmv dt/time for continuous meds *83
 .S:PSBMRRFL PSBREC(10)=$S((PSBMRRFL&PSBDOA):$$FMADD^XLFDT(PSBDTX,,,PSBDOA),1:"")
 .S PSBINDX=11                   ;Disp Drug moved to param 11      *83
 .S X="" F  S X=$O(PSBDDA(X)) Q:X=""  D
 ..S PSBREC(PSBINDX)=$P(PSBDDA(X),U,1,2)_U_$P(PSBDDA(X),U,4)_U_$P(PSBDDA(X),U,4)_U_PSBDOSEF_U_U_U_PSBMRRFL    ;add MRR flag 8th piece *83
 ..S PSBINDX=PSBINDX+1
 .S X="" F  S X=$O(PSBADA(X)) Q:X=""  S PSBREC(PSBINDX)=PSBADA(X),PSBINDX=PSBINDX+1
 .S X="" F  S X=$O(PSBSOLA(X)) Q:X=""  S PSBREC(PSBINDX)=PSBSOLA(X),PSBINDX=PSBINDX+1
 .D FILE
 K ^TMP("PSB",$J)
 Q
 ;
FILE ; Call the med log RPC to file it and DDS to edit it
 N PSB,PSBSAVE,PSBAUDIT
 D RPC^PSBML(.PSB,"+1^MEDPASS",.PSBREC)
 I '$D(PSB) S PSB(0)=1,PSB(1)="-1^INCOMPLETE ENTRY^"_PSBINCX
 I +PSB(1)<1 D  Q
 .W @IOF,!,"Error(s) Creating Med Log Entry",!
 .S X=$S(PSB(0)=1:0,1:1) F  S X=$O(PSB(X)) Q:X=""  W !,$J($S(X=1:X,1:X-1),2),". ",$S(X=1:$P(PSB(X),"^",2,3),1:PSB(X))
 .W !!,"No Med Log Entry Created.",!!
 .K DIR S DIR(0)="E" D ^DIR
 S PSBSAVE=0 S:'$G(PSBMMEN) PSBAUDIT=1
 S DA=$P(PSB(1),U,3),DDSFILE=53.79,DDSPARM="C"
 I $P(^PSB(53.79,DA,.1),U,1)?.N1"U" S DR="[PSB NEW UD ENTRY]"
 I $P(^PSB(53.79,DA,.1),U,1)?.N1"V" S DR="[PSB NEW IV ENTRY]"
 D ^DDS
 L +^PSB(53.79,DA):DILOCKTM I  L -^PSB(53.79,DA) I PSBSAVE'=1 D
 .W !,"Incomplete Med Log Entry, Deleting...#",DA S A=^PSB(53.79,DA,0),DFN=$P(A,U,1),AADT=$P(A,U,6)
 .K ^PSB(53.79,"AADT",DFN,AADT,DA) S DIK="^PSB(53.79," D ^DIK
 ;
 ;*83 convert Kills to tag so can be used by existing patch & new body site logic
 S PSBXUIT=""      ;init field error/kill flag *83
 I PSBSAVE=1 D
 .I $D(DA) D:($P(^PSB(53.79,DA,0),U,9)="G")
 ..I $D(^PSB(53.79,DA,.5)) S PSBY=0 F  S PSBY=$O(^PSB(53.79,DA,.5,PSBY)) Q:+PSBY<1  D
 ...I $P(^PSB(53.79,DA,.5,PSBY,0),U,4)="PATCH" D
 ....S (PSBYX,PSBXUIT)="" F  S PSBYX=$O(^PSB(53.79,"AORDX",PSBDFN,PSBONX,PSBYX),-1)   Q:PSBYX=""  D  Q:PSBXUIT
 .....S PSBYZ="" S PSBYZ=$O(^PSB(53.79,"AORDX",PSBDFN,PSBONX,PSBYX,PSBYZ)) I (PSBYZ'=DA),$P(^PSB(53.79,PSBYZ,0),U,9)="G" D
 ......W !!,"PATCH has been GIVEN before this admin completed"
 ......S PSBXUIT=1 D KILL
 ....Q:PSBXUIT
 ....S ^PSB(53.79,"APATCH",$P(^PSB(53.79,DA,0),U),$P(^PSB(53.79,DA,0),U,6),DA)=""
 .Q:PSBXUIT
 .;      new body site validation checks *83
 .I $D(DA) D SITECHK D:PSBXUIT KILL
 .;
 .Q:(PSBIEN="+1")&('$D(PSBIEN(1)))
 .Q:PSBXUIT
 .S X=$S($P(PSBIEN,",",2)]"":$P(PSBIEN,",",2),PSBIEN="+1":PSBIEN(1),1:"")
 .I X]"" I ($F("HR",$P(^PSB(53.79,X,0),U,9))>1) F Y=.5,.6,.7 S Z=0 F  S Z=$O(^PSB(53.79,X,Y,Z)) Q:+Z=0  S $P(^PSB(53.79,X,Y,Z,0),U,3)=0
 .I X]"",$G(PSBMMEN)=1 D SCANFAIL ;If Manual Med Entry was used, document "scanning failure"
 G:PSBXUIT FILE   ;for field errors refile and run form again *83
 Q
 ;
SITECHK ;Inj or Derm site field validate
 S PSBXUIT=""
 I $P(^PSB(53.79,DA,.1),U,6)]"",$P(^PSB(53.79,DA,.1),U,8)]"" D
 .W !!,"Entry of both Injection and Dermal site fields are not allowed."
 .S PSBXUIT=1
 I 'PSBXUIT,PSBNJECT,$P(^PSB(53.79,DA,.1),U,6)="" D
 .W !!,"Injection site required for this medication set to prompt for Injection Site."
 .S PSBXUIT=1
 I 'PSBXUIT,PSBMRRFL,$P(^PSB(53.79,DA,.1),U,8)="" D
 .W !!,"Dermal site required for this medication requiring removal (MRR)."
 .S PSBXUIT=1
 I 'PSBXUIT,'PSBNJECT,$P(^PSB(53.79,DA,.1),U,6)]"" D
 .W !!,"Not flagged as Injection Site medication, Injection Site field must be blank."
 .S PSBXUIT=1
 I 'PSBXUIT,'PSBMRRFL,$P(^PSB(53.79,DA,.1),U,8)]"" D
 .W !!,"Not flagged as medication requiring removal (MRR), Dermal Site field must be blank."
 .S PSBXUIT=1
 Q
KILL ;Kill and write msg
 W !!,"Incomplete Med Log Entry, Deleting...#",DA,!,$C(7)
 S A=^PSB(53.79,DA,0),DFN=$P(A,U,1),AADT=$P(A,U,6)
 K ^PSB(53.79,"AADT",DFN,AADT,DA) S DIK="^PSB(53.79," D ^DIK
 K DIR S DIR(0)="E" D ^DIR
 Q
 ;
FDATE ;Check Admin Time for future date/time.
 N PSBTIMX
 S PSBTIMX=X D NOW^%DTC
 I PSBTIMX>% W $C(7) S (DDSERROR,DDSBR)=1 D HLP^DDSUTL("Future date/time is not allowed")
 Q
 ;
SCANFAIL ;File an MSF record
 N PSBPRM,PSBRSLT,PSBX,PSBX1,PSBX2
 S PSBX=^PSB(53.79,DA,0)
 S PSBX1=^PSB(53.79,DA,.1)
 S PSBPRM(0)=$P(PSBX,U,1)_U_$P(PSBX1,U,1)_U_"Manual Medication Entry"_U_""_U_"M"_U_1
 I $P(PSBX1,U,1)["U",$P($G(^PSB(53.79,DA,.5,1,0)),U,1)]"" D
 .S PSBX2="DD"_U_$P($G(^PSB(53.79,DA,.5,1,0)),U,1)
 I $P(PSBX1,U,1)["V",$P($G(^PSB(53.79,DA,.6,1,0)),U,1)]"" D
 .S PSBX2="ADD"_U_$P($G(^PSB(53.79,DA,.6,1,0)),U,1)
 I $G(PSBX2)="",$P(PSBX1,U,1)["V",$P($G(^PSB(53.79,DA,.7,1,0)),U,1)]"" D
 .S PSBX2="SOL"_U_$P($G(^PSB(53.79,DA,.7,1,0)),U,1)
 I $G(PSBX2)]"" S PSBPRM(1)=PSBX2
 D SCANFAIL^PSBVDLU3(.PSBRSLT,.PSBPRM)
 Q
