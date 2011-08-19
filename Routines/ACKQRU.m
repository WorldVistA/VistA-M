ACKQRU ;AUG/JLTP BIR/PTD HCIOFO/AG-Support Routine for Reports ; 9/2/09 11:56am
 ;;3.0;QUASAR;**17**;Feb 11, 2000;Build 28
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
DTRANGE ;
BEGDT N ACKTMPB
 S DIR(0)="D^:"_DT_":AEXP",DIR("A")="Beginning Date"
 S DIR("?")="Enter the earliest date for which you want to see data"
 S DIR("??")="^S ACKQHLP=1 D ^ACKQHLP"
 D ^DIR K DIR
 I Y?1"^"1.E W !,"Jumping not allowed.",! G BEGDT
 Q:$D(DIRUT)  S ACKBD=Y-.1,ACKXBD=$$NUMDT^ACKQUTL(Y),ACKTMPB=Y
 ;
ENDDT ; S DIR(0)="D^"_(ACKBD+.1)_":"_DT_":AEXP",DIR("A")="Ending Date"
 S DIR(0)="D"
 S DIR("A")="Ending Date"
 S DIR("?")="Enter the latest date for which you want to see data"
 S DIR("??")="^S ACKQHLP=1 D ^ACKQHLP"
 D ^DIR K DIR
 I Y?1"^"1.E W !,"Jumping not allowed.",! G ENDDT
 Q:$D(DIRUT)  S ACKED=Y+.9,ACKXED=$$NUMDT^ACKQUTL(Y)
 I Y<ACKTMPB W !,"End date cannot be before the Begin date.",! G ENDDT
 Q
PARAMS ;
 ; this subroutine contains two standard prompts
 ;  1.   Select     a = AUDIOLOGY
 ;                  s = SPEECH PATHOLOGY
 ;                  b = BOTH
 ;  2.   Choose     1 = ONE CLINICIAN
 ;                  2 = ONE OTHER PROVIDER
 ;                  3 = ONE STUDENT
 ;                  4 = ALL CLINICIANS
 ;                  5 = ALL OTHER PROVIDERS
 ;                  6 = ALL STUDENTS
 ; it returns
 ;     DIRUT=1    user chose to exit
 ;     ACKASB     response to prompt 1
 ;                (A=audio, S=speech, B=Both)
 ;     ACKSS      response to prompt 2 (1-6)
 ;     ACKSTF()   array containing all selected staff
 ;                where ACKSTF(n)=persons IEN on NEW PERSON FILE
 ;
 N DIR,I,X,Y,DIC,ACKQHLP
 ;
 ; prompt 1
 S DIR(0)="S^a:AUDIOLOGY;s:SPEECH PATHOLOGY;b:BOTH"
 S DIR("A")="Select",DIR("B")="BOTH"
 S DIR("??")="^W !!,""You can select Audiology visits, Speech Pathology visits, or Both."",!"
 D ^DIR K DIR Q:$D(DIRUT)
 S ACKASB=$S(Y="a":"A",Y="s":"S",1:"B")
 ;
 ; prompt 2
 S DIR(0)="S^1:ONE CLINICIAN;2:ONE OTHER PROVIDER;3:ONE STUDENT;4:ALL CLINICIANS;5:ALL OTHER PROVIDERS;6:ALL STUDENTS"
 S DIR("A")="Choose",DIR("??")="^S ACKQHLP=4 D ^ACKQHLP"
 D ^DIR K DIR Q:$D(DIRUT)
 S ACKSS=Y
 K ACKSTF
 ; if ONE staff member selected then ask for name
 I ACKSS<4 D  Q:$D(DIRUT)
 . S DIC("A")="Select "_$S(ACKSS=1:"CLINICIAN",ACKSS=2:"OTHER PROVIDER",1:"STUDENT")_": "
 . S DIC(0)="AEMQZ",DIC=509850.3
 . S DIC("S")="I $P(^(0),U,2)]"""",$P(""CF^O^S"",U,ACKSS)[$P(^(0),U,2)"
 . D ^DIC K DIC S:Y<0 DIRUT=1 Q:$D(DIRUT)
 . ;*17 Update to correctly set DUZ
 . ;S ACKSTF(+Y)=$P(Y,U,2)
 . S ACKSTF(+Y)=$$CONVERT1^ACKQUTL4(+Y)
 ; if ALL staff selected then get them from staff file
 I ACKSS>3 D
 . S I=0 F  S I=$O(^ACK(509850.3,I)) Q:'I  D
 . . S X=$P(^ACK(509850.3,I,0),U,2)
 . . I X="" Q
 . . I ACKSS=4,"CF"'[X Q
 . . I ACKSS=5,X'="O" Q
 . . I ACKSS=6,X'="S" Q
 . . ;*17 Update to correctly set DUZ
 . . ;S ACKSTF(I)=$P(^ACK(509850.3,I,0),U)
 . . S ACKSTF(I)=$$CONVERT1^ACKQUTL4(I)
 ;
 ; end
 Q
 ;
GETDIV(DIVARR,ACKSTA,ACKOPT) ; get all the Divisions and put them in DIVARR
 ;   INPUT: DIVARR must be passed by reference
 ;          ACKSTA division status (optional)
 ;                 'A' will get active divisions only (default)
 ;                 'I' will get inactive divisions only
 ;                 'AI' or 'IA' will get all divisions 
 ;          ACKOPT options. so far the only option is 'U' to output the
 ;                  names in uppercase.
 ;   RETURNS: DIVARR= number found (n)
 ;            DIVARR(1,n)=x^y^name
 ;            DIVARR(2,name)=n
 ;        and DIVARR(3,x)=n
 ;              where x=IEN of Div from Medical Center Division file
 ;                and y=sequence number from A&SP Site Parameter file
 ;                      (in other words ^ACK(509850.8,1,2,y)=x^...)
 ;                and name=the division name
 ;
 N ACKTGT,ACKMSG,ACKSCRN,ACK,SEQ,DIV,DIVNAME
 K DIVARR
 ; build screen based on requested status
 I $G(ACKSTA)="" S ACKSTA="A"
 S ACKSCRN="I """_ACKSTA_"""[$P(^(0),U,2)"
 ; go get 'em
 D LIST^DIC(509850.83,",1,",".01","I","*","","","",ACKSCRN,"","ACKTGT","ACKMSG")
 ; now transfer to output array
 S DIVARR=$P(ACKTGT("DILIST",0),U,1)
 FOR ACK=1:1:DIVARR D
 . S SEQ=ACKTGT("DILIST",2,ACK),DIV=ACKTGT("DILIST",1,ACK)
 . S DIVNAME=$$GET1^DIQ(40.8,DIV_",",.01)
 . S DIVARR(1,ACK)=DIV_U_SEQ_U_DIVNAME
 . S DIVARR(2,$$UP($G(ACKOPT),DIVNAME))=ACK
 . S DIVARR(3,DIV)=ACK
 Q
UP(ACKOPT,X) ; convert X to uppercase (if requested)
 I ACKOPT["U" Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q X
 ;
STOPSORT(ACKASB,ACKVSC) ; determine stop code sort value
 ; this function determines whether the Stop Code for the Visit is 
 ;  valid for the type of report selected. 
 ; If it is not valid the function returns 0
 ; If it is valid the function returns an integer which may be used to 
 ;  sequence the visit so that Audio comes first, Audio/Tel next,
 ;  then Speech and Speech/Tel.
 ; If an unknown Visit Stop Code is encountered, it is given a 9
 ;  which means it will appear at the end of the report as UNKNOWN.
 I ACKVSC="A" Q $S(ACKASB="A":1,ACKASB="B":1,1:0)  ; audiology #1
 I ACKVSC="AT" Q $S(ACKASB="A":2,ACKASB="B":2,1:0)  ; telephone audiology #2
 I ACKVSC="S" Q $S(ACKASB="S":3,ACKASB="B":3,1:0)  ; speech #3
 I ACKVSC="ST" Q $S(ACKASB="S":4,ACKASB="B":4,1:0)  ; telephone speech #4
 Q 9  ; any other value 9
 ;
STOPNM(ACKSORT) ; convert stop code sort value into a stop code name
 I ACKSORT=1 Q "AUDIOLOGY"
 I ACKSORT=2 Q "AUDIOLOGY TELEPHONE"
 I ACKSORT=3 Q "SPEECH PATHOLOGY"
 I ACKSORT=4 Q "SPEECH TELEPHONE"
 Q "UNKNOWN"
 ;
