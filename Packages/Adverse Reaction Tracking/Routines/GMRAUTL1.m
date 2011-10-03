GMRAUTL1 ;HIRMFO/WAA-ALLERGY UTILITIES ;12/04/92
 ;;4.0;Adverse Reaction Tracking;**33**;Mar 29, 1996;Build 5
 ;
 ; Reference to $$PROD^XUPROD supported by DBIA 4440
 ; Reference to $$TESTPAT^VADPT supported by DBIA 3744
 ; 
 Q
STPCK() ; This is to check to see if the user wanted to stop the print
 S ZTSTOP=0
 I $$S^%ZTLOAD D
 .S ZTSTOP=1 K ZTREG W !?10,"*** OUTPUT STOPPED AT USER'S REQUEST ***"
 .Q
 Q ZTSTOP
BR ; This is a online reference card entry point
 I '$$TEST^DDBRT D  Q
 .W $C(7)
 .W !,?20,"Your Terminal cannot display this Reference Card."
 .W !,?20,"Please contact IRM Service to correct this problem."
 .Q
 N X
 S X=$O(^GMRD(120.87,"B","REFERENCE CARD",0)) Q:X<1
 D WP^DDBR(120.87,X,1)
 Q
PR ; This is a print utility for the reference card for IRM
 W ! K GMRAZIS D DEV^GMRAUTL I POP W !,"PLEASE TRY LATER" S GMRAOUT=1 Q
 I $D(IO("Q")) D  Q
 . S ZTRTN="PR1^GMRAUTL1",(ZTSAVE("GMRAOUT"),ZTSAVE("GMAST"),ZTSAVE("GMAEN"))=""
 . S ZTDESC="Print reference card" D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Request queued...",1:"Request NOT queued please try Later.")
 . Q
 U IO D PR1 U IO(0)
 Q
PR1 ; Print out the card
 N GMRAOUT,GMRACD,GMRALN,X
 I $E(IOST,1)="C" W @IOF
 S GMRACD=$O(^GMRD(120.87,"B","REFERENCE CARD",0))
 S (GMRAOUT,GMRALN)=0
LP1 ; Main loop
 F  S GMRALN=$O(^GMRD(120.87,GMRACD,1,GMRALN)) Q:GMRALN<1  D  Q:GMRAOUT
 .S X=$G(^GMRD(120.87,GMRACD,1,GMRALN,0))
 .W !,X
 .I $Y>(IOSL-4) D
 ..I $E(IOST,1)="C" N DIR,DIRUT,DIROUT,DTOUT,DUOUT S DIR(0)="E" D ^DIR S:$D(DIRUT) GMRAOUT=1 W:'GMRAOUT @IOF Q
 ..W @IOF
 ..Q
 .Q
 D CLOSE^GMRAUTL
 Q
PRDTST(GMRADFN) ; GMRA*4*33 - Remove Test Patients from Live Reports
 ; This function will return 0 if the patient should not print on the report, and 1 if the patient
 ; should appear on the report.  This function will allow all patients to print on the report if the
 ; report is run in a test environment.
 ;
 I GMRADFN="" Q 0  ;DFN not defined. Should never be the case.
 I '$$PROD^XUPROD() Q 1  ;Not a production or legacy environment.  Print all patients on report.
 I $$TESTPAT^VADPT(GMRADFN) Q 0  ;Production or legacy environment.  Test patient.  Do not print on report.
 Q 1  ;Production or legacy environment.  Not a test patient.  Print on report.
 ; 
VAD(DFN,DAT,LOC,NAM,SEX,SSN,RB,PRO,PID) ; Call to VADPT
 ; This call is a generic call to 1^VADPT
 ; Input:
 ; 1     DFN = Patient Internal entry number in the Patient File
 ; 2     DAT = Date for lookup
 ;
 ; Output:
 ; 3     LOC = Hospital Location
 ; 4     NAM = Full Patient name
 ; 5     SEX = Patient SEX
 ; 6     SSN = Patient SSN
 ; 7     RB  = Patient Room Bed
 ; 8     PRO = Patient Provider
 ; 9     PID = Patient ID
 ;
 S DFN=$G(DFN) Q:DFN=""
 S VAINDT=$G(DAT) I VAINDT="" K VAINDT
 D 1^VADPT
 S LOC=$P(VAIN(4),U),NAM=VADM(1),SEX=VADM(5)
 S SSN=$P(VADM(2),U,2),RB=VAIN(5),PID=VA("PID")
 S PRO=$P(VAIN(2),U,2)
 D KVAR^VADPT K VA,VAROOT
 Q
DATE(DATE) ; This Ex-Function will date the date from the DATE
 ; and convert it to the old DD("DD") style format
 ; it returns the answer in DATE
 N Y
 S Y=$$FMTE^XLFDT(DATE,1)
 S DATE=$P(Y," ")_" "_(+$P($P(Y,",")," ",2))_","_$P(Y," ",3)
 Q DATE
