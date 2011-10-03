SDWLEVAL ;;IOFO BAY PINES/ESW - WAIT LIST - DISPOSITION AFTER APPOINTMENT(S) ENTRY;12/11/08 5:11pm  ; Compiled March 6, 2009 11:11:50
 ;;5.3;Scheduling;**327,471,446,538**;AUG 13 1993;Build 5
 ;Evaluate appt for optional disposition
 ;called from SDMM, SDMM1, SDM1A, SDAM2 ; replaced SDWLR
 ;
EN(DFN,SDYN) ;evaluation if patient is on EWL
 ; SDYN passed by reference
 ;output: SDYN=0 -  no open entries in EWL
 ;        SDYN=1 -  at least one open entry in EWL
 S SDYN=0,SDYN(1)=""
 I '$D(DFN)!(DFN'?1.N) S SDYN(1)="Patient's DFN not passed." Q
 I $D(DFN),'$D(^SDWL(409.3,"B",DFN)) S SDYN(1)="This patient is not on EWL." Q
 S SDWLDA="" F  S SDWLDA=$O(^SDWL(409.3,"B",DFN,SDWLDA)) Q:SDWLDA=""  D  Q:SDYN=1
 .I $P($G(^SDWL(409.3,SDWLDA,0)),"^",17)="O" S SDYN=1,SDYN(1)="Patient has open Wait List entries."
 I SDYN=0 S SDYN(1)="Patient has no open Wait List entries."
 Q
EWLANS(SDCONT) ;display EWL OPEN entries
 ;check if to continue with EWL open entries
 S SDCONT=0
 N X,DIR,Y
 S DIR("B")="NO"
 S DIR("A")="Do you want to display open Wait list entries (Yes/No)?",DIR(0)="Y"
 S DIR("?")="Do you want to review open EWL entries for Dispositioning?"
 D ^DIR
 I Y S SDCONT=1
 Q
ASKREM ;prompt user for record for dispositioning
 S SDDIS=0 ; flag indicating disposition
 W ! N X,DIR,Y
 S DIR("B")="NO"
 S DIR("A")="DO YOU WISH TO REMOVE ANY ENTRY FROM LIST (Yes/No)? ",DIR(0)="Y"
 S DIR("?")="To disposition any entry based on scheduled appointments."
 D ^DIR
 I Y S SDDIS=1
 D ANSW(SDDIS)
 Q
ANSW(SDDIS,SDR) ;
 ;SDDIS=0 - select entries not to disposition
 ;SDDIS=1 - select entries to disposition
 N DIR,X I '$D(SDR) S SDR=1
 W !
 N STR,SS,SDCB S SDC=$O(^TMP($J,"SDWLPL",""),-1),SDCB=$O(^TMP($J,"SDWLPL",""))
 ;I SDC=SDCB S DIR("B")=SDC
 ;E  S DIR("B")=SDCB_"-"_SDC
 S DIR(0)="LO^"_SDCB_":"_SDC_"^"_"K:X=""^"" X" S DIR("A")="Select EWL entry to enter a non-removal reason or press 'Enter' key to accept the current one(s): "
 S DIR("?")="Enter number(s) or range of displayed Wait List entries or press 'Enter' key to accept the present non-removal reason."
 I SDDIS S DIR("A")="Select one of the above open EWL entries to close with an appointment or press 'Enter' key to continue>"
 D ^DIR
 N SDAN S SDAN=X I SDAN="^" W " YOU CANNOT EXIT HERE" Q
 I SDAN["-" D
 .N SXB,SXE
 .S SXB=$P(SDAN,"-"),SXE=$P(SDAN,"-",2) N SDC F SDC=SXB:1:SXE I $D(^TMP($J,"SDWLPL",SDC)) S SDWLDA=+^TMP($J,"SDWLPL",SDC) D
 ..;LOCK
 ..L +^SDWL(409.3,SDWLDA):5 I '$T W !,"Another User is Editing this Entry. Try Later." Q
 ..I 'SDDIS N SDR F  D DISPO(SDWLDA,SDC,.SDR) Q:SDR
 ..I SDDIS D GETDATA(SDWLDA) D DISEND(SDWLDA,SDC) S SDR=1
 ..L
 I 'SDDIS I SDAN=""&(SDCB=SDC) I $P($G(REC),U,13)="" S SDAN=SDC ;;;;;
 I SDAN="" D
 .I SDDIS S SDR=0 Q
 .N SDC,SDRN,SDWLDA,SDWLDS S SDC="",SDR=0 F  S SDC=$O(^TMP($J,"SDWLPL",SDC)) Q:SDC=""  S SDWLDS=^TMP($J,"SDWLPL",SDC),SDWLDA=+SDWLDS D
 ..I $P(SDWLDS,U,13)'="" K ^TMP($J,"SDWLPL",SDC)
 .I '$D(^TMP($J,"SDWLPL")) S SDR=1
 I SDAN[","!(SDAN?1N) D
 .N FF S FF=SDAN N GG,SDC F GG=1:1 S SDC=$P(FF,",",GG) Q:SDC=""  I $D(^TMP($J,"SDWLPL",SDC)) S SDWLDA=+^TMP($J,"SDWLPL",SDC) D
 ..;LOCK
 ..L +^SDWL(409.3,SDWLDA):5 I '$T W !,"Another User is Editing this Entry. Try Later." Q
 ..I 'SDDIS N SDR F  D DISPO(SDWLDA,SDC,.SDR) Q:SDR
 ..I SDDIS D GETDATA(SDWLDA) D DISEND(SDWLDA,SDC) S SDR=1
 ..L
 Q
DISEND(SDWLDA,SDC) ;display and disposition
 ;SDWLDA - IEN of 409.3  
 N DUOUT D EDIT(SDWLDA,SDC,.SDWLERR) Q:$G(DUOUT)  I SDWLERR Q
 W !!,"*** Patient has been removed from Wait List ***",!
 K ^TMP($J,"SDWLPL",SDC)
 K DIR,DIE,DR,DIC
 Q
GETDATA(SDWLDA) ;retrieval data
 N SDWLCL,SDWLDAPT,SDWLDATA,SDWLDISP,SDWLDUZ,SDWLEDT,SDWLIN,SDWLPRI,SDWLPROV,SDWLRB,SDWLSC,SDWLSP,SDWLST,SDWLTY
 S SDWLDATA=$G(^SDWL(409.3,SDWLDA,0))
 S SDWLIN=$P(SDWLDATA,U,3),SDWLCL=+$P(SDWLDATA,U,4),SDWLTY=$P(SDWLDATA,U,5),SDWLST=$P(SDWLDATA,U,6)
 S SDWLSP=$P(SDWLDATA,U,7),SDWLSS=$P(SDWLDATA,U,8),SDWLSC=$P(SDWLDATA,U,9),SDWLPRI=$P(SDWLDATA,U,10),SDWLRB=$P(SDWLDATA,U,11)
 S SDWLPROV=$P(SDWLDATA,U,12),SDWLDAPT=$P(SDWLDATA,U,16),SDWLST=$P(SDWLDATA,U,17),SDWLDUZ=DUZ,SDWLEDT=DT
 S SDWLSCL="" I SDWLSC S SDWLSCL=+$P(^SDWL(409.32,SDWLSC,0),U,1)
 I $D(^SDWL(409.3,SDWLDA,"DIS")) S SDWLDISP=$P(^SDWL(409.3,SDWLDA,"DIS"),U,3)
 Q
EDIT(SDWLDA,SDC,SDWLERR) ;ENTER/EDIT DISPOSITION
 ;SDWLDA -IEN of selected 409.3 entry
 ;SDWLERR - called by a reference
 ;SDC - sequential number in ^TMP($J,"SDWLPL",SDC
 S SDWLDUZ=DUZ,SDWLERR=0 S SDWLDISP="SA" D EDITSA Q  ;N DIR,DR,DIE,DIC
EDITSA I SDWLDISP="SA" D
 .I $O(^TMP($J,"APPT",""))=$O(^TMP($J,"APPT",""),-1) S SDAP=$O(^TMP($J,"APPT","")) Q
 .I $O(^TMP($J,"APPT",""))'=$O(^TMP($J,"APPT",""),-1) D APPTD D  I SDAP="C" W !,"Disposition canceled by user",! Q
 ..W ! K DIR,X
 ..N STR,SS,SDA S SDA=$O(^TMP($J,"APPT",""),-1) I SDA=1 S DIR("B")=1
 ..S DIR(0)="N^1:"_SDA S DIR("A")="Select appt for Removal Reason or 'C' to Quit>",DIR("?")="Select Appointment to close with the open EWL."
 ..D ^DIR
 ..S SDAP=X
 S DIE="^SDWL(409.3,",DA=SDWLDA,DR="21////^S X=SDWLDISP" D ^DIE
 S DR="19////^S X=DT" D ^DIE
 S DR="20////^S X=SDWLDUZ" D ^DIE
 S DR="23////^S X=""C""" D ^DIE
 ;if "SA" update with appoint data
 ;get appt data to file (for a particular appt #)
 I SDWLDISP="SA" N SDA D DATP(SDAP,.SDA) D
 .I $D(SDA) S DIE="^SDWL(409.3,",DA=SDWLDA D
 ..S DR="13////"_SDA(1)_";13.1////"_DT_";13.2////"_SDA(2)_";13.3////"_SDA(15)_";13.4////"_SDA(13)_";13.5////"_SDA(14)_";13.6////"_SDA(16)_";13.8////"_SDA(3)_";13.7////"_DUZ
 ..D ^DIE
 N SDWLSCL,SDWLSS,SDWLDFN
 S SDWLSCL=$P($G(^TMP($J,"SDWLPL",SDC)),U,9)
 S SDWLSS=$P($G(^TMP($J,"SDWLPL",SDC)),U,10)
 I SDWLSCL K:$D(^SDWL(409.3,"SC",SDWLSCL,SDWLDA)) ^SDWL(409.3,"SC",SDWLSCL,SDWLDA)
 S SDWLDFN=$P($G(^TMP($J,"APPT",1)),U,4)
 I SDWLSS,SDWLDFN K:$D(^SDWL(409.3,"SS",SDWLDFN,SDWLSS,SDWLDA)) ^SDWL(409.3,"SS",SDWLDFN,SDWLSS,SDWLDA)
 Q
DISPO(SDWLDA,SDC,SDR) ;
 ;SDWLDA - IEN of 409.3
 ;SDC - seq in ^TMP($J,"SDWLPL",SDC
 ;out SDR - NON REMOVAL:
 ; 1 entered
 ; 0 not entered
 K DIR,X S SDR=0
 S DIR(0)="SM^1:APPOINTMENT CRITERIA NOT MET;2:PATIENT WANTS ANOTHER APPOINTMENT;3:PROVIDER WANTS ANOTHER APPOINTMENT;4:OTHER"
 S DIR("L",1)="SELECT ONE OF THE FOLLOWING REASONS FOR # "_SDC_":",DIR("L",2)=""
 S DIR("L",3)="1. APPOINTMENT CRITERIA NOT MET",DIR("L",4)="2. PATIENT WANTS ANOTHER APPOINTMENT"
 S DIR("L",5)="3. PROVIDER WANTS ANOTHER APPOINTMENT",DIR("L,6")="4. OTHER"
 S DIR("A")="Select one of the following reasons for #: "_SDC
 D ^DIR
 S X=$E(X,1,2) S:$E(X,2)'="R" X=$E(X)
 S SDWLX=$S(X="a":"A",X="p":"P",X="pr":"PR",X="o":"O",X="A":"A",X="P":"P",X="PR":"PR",X="O":"O",X=1:"A",X=2:"P",X=3:"PR",X=4:"O",1:"^")
 I SDWLX="^" Q
 S SDR=1
 I SDWLX="O" D
 .S DIR(0)="FAO^^",DIR("A")="Comments: " D ^DIR Q:X["^"
 .S SDWLCOM=X,DA=SDWLDA,DIE="^SDWL(409.3,",DR="18.1////^S X=SDWLCOM" D ^DIE
 N DA S DA=SDWLDA
 S DIE="^SDWL(409.3,",DR="18////^S X=SDWLX" D ^DIE
 S DR="17////^S X=DUZ" D ^DIE
 S DR="16////^S X=DT" D ^DIE
 K SDWLERR,DIR,DR,DIE,X,SDWLX,SDWLDSS,SDWLASK,SDWLDA,SDWLCOM
 K ^TMP($J,"SDWLPL",SDC)
 Q
HD ;HEADER
 W:$D(IOF) @IOF W !!,?80-$L("Wait List - Disposition Patient")\2,"Wait List - Disposition Patient",!!
 Q
APPT(DFN,SD,SC) ;create appt TMP
 ;SD - appt date/time
 ;SC - clinic IEN
 N SDARR,SCNT
 S SDDIV=""
 S SDARR(1)=SD_";"_SD
 S SDARR(2)=SC
 S SDARR(4)=DFN
 S SDARR("FLDS")="1;2;3;4;10;13;14;17"
 N SAPP S SAPP=$$SDAPI^SDAMA301(.SDARR) D
 .N SDINST,SDFAC,SDINSTE
 .Q:'$D(^TMP($J,"SDAMA301",DFN))
 .S SCNT=$O(^TMP($J,"APPT",""),-1)+1
 .S ^TMP($J,"APPT",SCNT)=^TMP($J,"SDAMA301",DFN,SC,SD)
 .N SDCLIN S SDCLIN=$$CLIN^SDWLBACC(SC),SDINST=$P(SDCLIN,U),SDFAC=$P(SDCLIN,U,2),SDINSTE=$P(SDCLIN,U,3)
 .S $P(^TMP($J,"APPT",SCNT),"^",15)=SDINST_";"_SDINSTE
 .S $P(^TMP($J,"APPT",SCNT),"^",16)=SDFAC
 .K ^TMP($J,"SDAMA301",DFN,SC,SD)
 Q
APPTD ;display appt
 ;from ^TMP($J,"APPT")
 N STR,SCNT
 Q:'$D(^TMP($J,"APPT"))
 S SCNT="" F  S SCNT=$O(^TMP($J,"APPT",SCNT)) Q:SCNT=""  D
 .S STR=^TMP($J,"APPT",SCNT)
 .N ZZ F ZZ=2,3,4,10,15 S SDD(ZZ)=$P($P(STR,"^",ZZ),";",2)
 .N SD S SD=$P(STR,U) D  S Y=SD D D^DIQ S SDD(1)=Y ; date conv
 ..I SDD(3)="SCHEDULED/KEPT" S SDD(3)=";"_$S(SD<DT:"KEPT",1:"SCHEDULED")
 .S SDD(16)=$P(STR,U,16)
 .N CP,ZZ F ZZ=13,14 S CP(ZZ)=$P($P(STR,U,ZZ),";") D
 ..S SDD(ZZ)=""
 ..I CP(ZZ)>0 S SDD(ZZ)=$$GET1^DIQ(40.7,CP(ZZ)_",",.01,"I") ; stop code desc
 .;DISPLAY
 .I SCNT=1 D DPH(SCNT,.SDD)
 .D DPHD(SCNT,.SDD)
 W !
 Q
DATP(SCNT,SDA) ;
 ;SDA - to return APPT array
 S STR=^TMP($J,"APPT",SCNT)
 S SDA(1)=$P(STR,U)
 N ZZ F ZZ=2,3,10,13,14,15 S SDA(ZZ)=$P($P(STR,"^",ZZ),";",1)
 S SDA(16)=$P(STR,"^",16) ;station
 Q
DPH(SCNT,SDD) ;display appt header
 W !!,"Appointment(s) for: "_SDD(4) W !!?4,"Specialty: "_SDD(13),?60,"Station: ",SDD(16),!
 W !?3,"Appt Date/Time",?23,"Clinic",?48,"Status",?60,"Institution",! N SDL S $P(SDL,"-",79)="" W SDL,!
 Q
DPHD(SCNT,SDD) ;
 W !,SCNT,?3,SDD(1),?23,$E(SDD(2),1,23),?48,$E(SDD(10),1,10),?60,SDD(15)
 Q
