LRMIEDZ2 ;DALIO/JMC - MICROBIOLOGY EDIT ROUTINE ;05/01/12  09:16
 ;;5.2;LAB SERVICE;**23,104,242,295,350**;Sep 27, 1994;Build 230
 ;
 ; from LRFAST,LRMIEDZ,LRVER
 ;
 ; Reference to ^DIE global supported by ICR #5002
 ;
PAT ;
 N LRUID
 S X=LRAN
 F  R:'$D(LRAN) !!,"Accession #: ",X:DTIME Q:X=""!(X[U)  D
 . S LRANOK=1,LRCAPOK=1 D LRANX^LRMIU4
 . I $G(LRANOK) D PAT1 L -^LR(LRDFN,"MI",LRIDT)
 . I $G(LRANOK) D LEDI^LRVR0
 . K LRTS I $G(LRANOK) D:LRCAPOK&($P(LRPARAM,U,14)) ^LRCAPV1
 . K:$G(LRANOK) LRAN
 . I '$G(LRANOK) W !,"Enter the accession number" K LRAN
 Q
 ;
 ;
PAT1 ; Called from above and LRFAST
 ;
 ; Set LRANOK if called from LRFAST and not set
 I $G(LRANOK)="" N LRANOK S LRANOK=1
 ;
 S LRDFN=+^LRO(68,LRAA,1,LRAD,1,LRAN,0)
 S LRUID=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3)),"^")
 S LRIDT=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),"^",5),LRCDT=+^(3),LREAL=$P(^(3),U,2),LRI=+$O(^(5,0)),LRSPEC=$S($D(^(LRI,0)):+^(0),1:"")
 ;
 I '$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0)) D  Q
 . W !,"No tests associated with this accession" S LRANOK=0
 . Q:$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.2))," ")=$P(^LRO(68,LRAA,0),U,11)
 . W !,"Verify with accession #: ",$G(^LRO(68,LRAA,1,LRAD,1,LRAN,.2))
 ;
 ; Insure DILOCKTM is defined
 I $G(DILOCKTM)="" D
 . N DIQUIET
 . S DIQUIET=1 D DT^DICRW
 ;
 L +^LR(LRDFN,"MI",LRIDT):DILOCKTM
 I '$T W !!?10,"Someone else is editing this accession ",!,$C(7) S LRANOK=0 Q
 I '$D(^LR(LRDFN,"MI",LRIDT,0)) D BB S (LRCAPOK,LRANOK)=0 Q
 S (LRBG0,Y(0))=^LR(LRDFN,"MI",LRIDT,0)
 ;
 D PATINFO
 ;
 I $$GET^XPAR("USR^DIV^PKG","LR MI VERIFY DISPLAY PROVIDER",1,"Q") D PROV
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 I $P(^LR(LRDFN,"MI",LRIDT,0),U,3) D
 . S DIR("A",1)="Final report has been verified by microbiology supervisor."
 . S DIR("A",2)="If you proceed in editing, this report will need to be reverified."
 . S DIR("B")="NO"
 E  S DIR("B")="YES"
 S DIR(0)="YO",DIR("A")="Edit this accession"
 D ^DIR
 I Y<1 S (LRCAPOK,LRANOK)=0 D ASKXQA W ! Q
 ;
 ;
AUDRTN ;
 ;
 I $P(^LR(LRDFN,"MI",LRIDT,0),U,3)!$P(^LR(LRDFN,"MI",LRIDT,0),U,9) S LRUNDO=1
 ;
 D EC^LRMIEDZ4
 I N=0 W !,"No Tests on Accession" S (LRCAPOK,LRANOK)=0 Q
 I '$D(LRNPTP) D
 . I N=1 S LRI=1 Q
 . N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 . S DIR(0)="NO^1:"_N_":0",DIR("A")="Select Test",DIR("B")=1
 . D ^DIR
 . I Y<1 S (LRCAPOK,LRANOK)=0 Q
 . S LRI=Y
 I LRANOK=0 Q
 I LRTX(LRI)="" W !,"EDIT CODE IN FILE 60 NOT DEFINED.",! S (LRCAPOK,LRANOK)=0 Q
 ;
 S LRTS=LRTS(LRI) D:LRUNDO UNDO^LRMIEDZ
 K DR
 S DA=LRIDT,DA(1)=LRDFN,DIE="^LR(LRDFN,""MI"","
 ;
 S LRSB=$S(LRTX(LRI)["11.5":1,LRTX(LRI)["23":11,LRTX(LRI)["19":8,LRTX(LRI)["15":5,LRTX(LRI)["34":16,1:"")
 S LRFIFO=LRTX(LRI)["FIFO",(LREND,LRSAME)=0 D:'LRFIFO TIME^LRMIEDZ3 I LREND K DR Q
 ;
 S LRSSC=$P(^LR(LRDFN,"MI",LRIDT,0),U,5)_U_$P(^(0),U,11)
 ;
 ;
AUDPT ;
 ; Check for "B" x-ref on #.01 field.
 F I=3,6,9,12,17 I $D(^LR(LRDFN,"MI",LRIDT,I)),'$D(^LR(LRDFN,"MI",LRIDT,I,"B")) D SETBINDX^LRMIBUG(LRDFN,LRIDT,I)
 ;
 I $D(LRLEDI) Q
 ;
 ; Set Y(0) for backward compatibility
 S Y(0)=LRBG0
 ;
 ; Execute code does not contain an edit template but fields/code
 I LRTX(LRI)'["S DR=""[",LRSB D  Q
 . X LRTX(LRI)
 . D EDIT^LRRPLU(LRDFN,LRSS,LRIDT) ; performing lab
 . D UPDATE^LRPXRM(LRDFN,"MI",LRIDT) ; clinical reminders
 . D:'LREND EC3 K DR
 . D:LRUNDO&$P($G(^LR(LRDFN,"MI",LRIDT,LRSB)),U)'="" VT^LRMIUT1
 . D ASKXQA ; ask CPRS alerts
 ;
 ; Execute code contains an edit template name
 S (X,DR)=$P($P(LRTX(LRI),"[",2),"]",1) S:X'="" X=+$O(^DIE("B",X,0)) I X<1,'$D(^DIE(+X,"DR",2,63.05)) W !,DR," template doesn't exist for Microbiology." K DR  Q
 S J=1 F  S J=+$O(^DIE(X,"DR",J)) Q:J<1  S K=+$O(^DIE(X,"DR",J,0)),DR(J-1,K)=^DIE(X,"DR",J,K)
 S DR=DR(1,63.05)
 D ^DIE
 ;
 ; Ask for performing laboratory assignment
 D EDIT^LRRPLU(LRDFN,LRSS,LRIDT)
 ;
 ; Call clincial reminders
 D UPDATE^LRPXRM(LRDFN,"MI",LRIDT)
 ;
 D EC3
 ;
 ; Ask to send CPRS alert
 D ASKXQA
 ;
 K DR
 Q
 ;
 ;
BB ;
 W !,">>>>ERROR - NO ENTRY IN FILE #63 - PLEASE NOTIFY SYSTEM MANAGER<<^ <<<",!
 Q
 ;
 ;
EC3 ;
 S LRSSCN=$P(^LR(LRDFN,"MI",LRIDT,0),U,5)_U_$P(^(0),U,11)
 D:LRSSCN'=LRSSC UPDATE
 K LRSSCN,LRSSC S LRSAME=1
 D TIME^LRMIEDZ3 D:'LREND STF^LRMIUT
 Q
 ;
 ;
UPDATE ;
 D CHECK
 K LRSSCOM,LRSSCOM1,LRSSCA,LRSSCAA,LRSSCAY,LRSSCAN,LRSSCOD,LRSSCON
 Q
 ;
 ;
CHECK ;
 S LRSSCA=$P(^LR(LRDFN,"MI",LRIDT,0),U,6),LRSSCAA=+$O(^LRO(68,"B",$P(LRSSCA," "),0))
 S X=$P(LRSSCA," ",2) D ^%DT S LRSSCAY=Y,LRSSCAN=$P(LRSSCA," ",3)
 S J=0 F  S J=+$O(^LRO(68,LRSSCAA,1,LRSSCAY,1,LRSSCAN,5,J)) Q:J<1  I ^(J,0)=LRSSC S ^(0)=LRSSCN Q
 I J<1 Q
 S LRSSCOD=$P(^LRO(68,LRSSCAA,1,LRSSCAY,1,LRSSCAN,0),U,4),LRSSCON=^(.1)
 S J=0 F  S J=+$O(^LRO(69,LRSSCOD,1,J)) Q:J<1  I $D(^(J,.1)),^(.1)=LRSSCON D ORDER Q
 Q
 ;
 ;
ORDER ;
 S $P(^LRO(69,LRSSCOD,1,J,0),U,3)=$P(LRSSCN,U,2)
 S K=0 F  S K=+$O(^LRO(69,LRSSCOD,1,J,4,K)) Q:K<1  I ^(K,0)=LRSSC S ^(0)=LRSSCN Q
 Q
 ;
 ;
PATINFO ; Display patient information
 S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3),LRUNDO=0
 D PT^LRX
 W !!,?5,PNM,"   SSN: ",SSN
 I LRDPF=2 W "   LOC: ",$S(LRWRD'="":LRWRD,1:$S($D(^LR(LRDFN,.1)):^(.1),1:"??")),!
 ;
 I LRDPF?1(1"62.3",1"67.2",1"67.3",1"67.4") Q
 ;
 W !,"Pat Info: ",$P($G(^LR(LRDFN,.091)),U)
 W ?34," Sex: ",$S(SEX="M":"MALE",SEX="F":"FEMALE",1:SEX)
 W ?48," Age: ",$$CALCAGE^LRRPU(DOB,LRCDT)," as of ",$$FMTE^XLFDT(LRCDT,"1D")
 Q
 ;
 ;
PROV ; Display provider and contact numbers.
 N LRPRAC,LRX
 S LRPRAC=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U,8)
 I LRPRAC>0,LRPRAC=+LRPRAC D GETS^DIQ(200,LRPRAC_",",".01;.132;.137;.138","E","LRPRAC(LRPRAC)","LRERR")
 ;
 W !,"Provider: "
 ;
 I LRPRAC,$D(LRPRAC(LRPRAC,200)) D  Q
 . W LRPRAC(LRPRAC,200,LRPRAC_",",.01,"E"),?40," Voice pager: ",LRPRAC(LRPRAC,200,LRPRAC_",",.137,"E")
 . W !,"   Phone: ",LRPRAC(LRPRAC,200,LRPRAC_",",.132,"E"),?38," Digital pager: ",LRPRAC(LRPRAC,200,LRPRAC_",",.138,"E")
 ;
 S LRX=""
 I LRPRAC?1"REF:"1.AN!(LRDPF=67) S LRX=$$REFDOC^LRRP1(LRDFN,LRSS,LRIDT)
 I LRX'="" W LRX
 E  W LRPRAC
 ;
 Q
 ;
 ;
ASKXQA ; Determine if user should be ask to send CPRS Alert
 ;
 N LRDEFAULT
 ;
 ; No CPRS alert for non-PATIENT file (#2) patients
 I +LRDPF'=2 Q
 ;
 S LRDEFAULT=$$GET^XPAR("USR^DIV^PKG","LR MI VERIFY CPRS ALERT",1,"Q")
 I LRDEFAULT>0 D ASKXQA^LR7ORB3(LRDFN,"MI",LRIDT,LRUID,LRDEFAULT)
 ;
 Q
