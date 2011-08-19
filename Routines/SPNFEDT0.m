SPNFEDT0 ;HISC/DAD/WAA-FIM EDIT ;7/30/96  14:23
 ;;2.0;Spinal Cord Dysfunction;**10,12,19**;01/02/1997
 ;
REPT(SPNFDFN) ; This is to select the type of data to enter for a patient.
 ; If none of the reports are selected then SPNFEXIT is set to 1
 ; and the program exits.
 ; Returns SPNFFIM as a value of 1 to 4 indicating the type
 ; of report to be entered/edited
 ; Input:
 ;      SPNFDFN = Patient DFN
 ;
 ; Output:
 ;      SPNFEXIT = 1 User exited
 ;                 0 User passed
 S SPNFEXIT=0
 I $D(IOF) W @IOF
 K DIRUT
 N SPNFMS
 S SPNFMS=0
 I $G(^SPNL(154,SPNFDFN,0))'="" D
 . S SPNFMS=$$EN2^SPNLUTL1(SPNFDFN,"MULTIPLE SCLEROSIS")
 . Q
 D  Q:SPNFEXIT!(SPNFFIM<1)
 . I $D(IOF) W @IOF
 . I $D(SPNFDFN)=0 I $D(SPNDFN) S SPNFDFN=SPNDFN
 . S SPNFFIM=0
 . K DIR S DIR(0)="SOM^1:Self Report of Function;2:FIM;3:ASIA;4:CHART;5:FAM;6:DIENER;7:DUSOI"
 . I SPNFMS S DIR(0)=DIR(0)_";8:Multiple Sclerosis"
 . S DIR("A")="Select the Record Type for this outcome"
 . S DIR("?",1)="   Enter 1 to enter/edit a Self Report of Function score."
 . S DIR("?",2)="   Enter 2 to enter/edit a FIM score."
 . S DIR("?",3)="   Enter 3 to enter/edit an ASIA score."
 . S DIR("?",4)="   Enter 4 to enter/edit a CHART score."
 . S DIR("?",5)="   Enter 5 to enter/edit a FAM score."
 . S DIR("?",6)="   Enter 6 to enter/edit a DIENER score."
 . S DIR("?",7)="   Enter 7 to enter/edit a DUSOI score."
 . S:SPNFMS DIR("?",8)="   Enter 8 to enter/edit a Multiple Sclerosis score."
 . S DIR("?")="   Choose either 1,2,3,4,5,6,7 " S:SPNFMS DIR("?")=DIR("?")_"or 8."
 . W ! D ^DIR K DIR S SPNFFIM=+Y
 . I $D(DIRUT) S SPNFEXIT=1 Q
 . I $D(DIRUT) S:$D(DTOUT)!($D(DUOUT)) SPNFEXIT=1 Q
 . Q:SPNFFIM<1
 . ;I SPNSEL="A" D ADD
 . S SPNFTYPE=SPNFFIM
 . Q
 ;I $D(IOF) W @IOF  ;commented out 8/1/02
 Q
ADD ; *** Add a record to the Outcomes file (#154.1)
 ;K DIR S DIR("A")="Enter a New Record Date : ",DIR(0)="DAO^:NOW"
 ;D DATES^SPNLKUPC  ;Date range set up of dir(0) set above as saftey
 ;D ^DIR
 ;I '+Y K DIR,Y S SPNFEXIT=1 Q
 ;S SPNDATE=Y
 ;K DD,DIC,DINUM,DO
 ;S SPNFD0=-1
 ;S DIC="^SPNL(154.1,",DIC(0)="L"
 ;S DLAYGO=154.1,X=SPNFDFN
 ;D FILE^DICN W ! S SPNFD0=+Y
 ;K DA,DIE,DR
 ;I $G(SPNSCOR)="" S SPNSCOR=""
 ;S DIE="^SPNL(154.1,",DA=SPNFD0
 ;S DR=".02///^S X="_SPNFTYPE_";.04///"_SPNDATE_";.021///"_SPNSCOR_";.023///"_$$EN^SPNMAIN(DUZ)_";1001///"_SPNCDT
 ;D ^DIE
 Q
 ;
EDIT ; *** Edit a record in the Outcomes file (#154.1)
 I $G(SPNFD0)="" S SPNFEXIT=1 Q
 I $P($G(^SPNL(154.1,+SPNFD0,0)),U)'>0 Q
 L +^SPNL(154.1,SPNFD0):0 I '$T D  Q
 . W !!?5,"Another user is editing this record."
 . W !?5,"Please try again later.",$C(7)
 . Q
 K DA,DDSFILE,DDSPAGE,DDSPARAM,DR,DTOUT
 S DDSFILE="^SPNL(154.1,",DA=SPNFD0
 S DR="["_$P($P($T(SCREEN+SPNFTYPE),";;",2),U)_"]"
 S DDSPARM="C" D ^DDS
 ;if its a new record and the user did not save the screen delete stub
 I $G(SPNNEW)="YES" I $G(DDSCHANG)="" D
 .S DIK="^SPNL(154.1,",DA=SPNFD0
 .D ^DIK
 .S SPNEXIT=1
 .Q
 K DDSPARM,CNT,SPNLTRIG,DR
 L -^SPNL(154.1,SPNFD0)
 I $P($G(^SPNL(154.1,SPNFD0,0)),U,4)'>0 D
 . S DIK="^SPNL(154.1,",DA=SPNFD0
 . D ^DIK
 . Q
 I $D(DTOUT) Q
 I $D(DIMSG) W !!,"The screen-based entry process has failed!!",! Q
 I SPNFTYPE<3,$D(^SPNL(154.1,SPNFD0,0))#2 D SCORE^SPNFEDT2(SPNFD0)
 ;to close episodes
 I SPNEXIT'=1 I $G(SPNCLOSE)'="" I SPNCLOSE=1 D CLOSE^SPNCTCLS S SPNXMIT=1
 ;sets up care end date on closing outcome record just added
 I SPNEXIT'=1 I $G(SPNCLOSE)'="" I SPNCLOSE=1 I $P($G(^SPNL(154.1,SPNFD0,8)),U,2)="" S $P(^SPNL(154.1,SPNFD0,8),U,2)=SPNDATE
HL7 ;
 ;this tag is to call the hl7 interface
 ;      spnxmit is set in spnctcls
 ;       spnxmit=0 just transmit the one record in the group
 ;       spnxmit=1 transmit all in the group (the group was closed)
 ;
 I $G(SPNXMIT)="" S SPNXMIT=0
 I $G(DDSCHANG)=1 I $G(^SPNL(154.1,SPNFD0,0))]"" D
 .D CHK^SPNHL71(SPNFD0)
 .D EXIT^SPNHL7
 .Q
 I SPNXMIT=1 D
 .S SPNA=0 F  S SPNA=$O(^TMP($J,SPNA)) Q:SPNA=""  S SPNB=0 S SPNB=$O(^TMP($J,SPNA,SPNB)) Q:SPNB=""  S SPNC=0 S SPNC=$O(^TMP($J,SPNA,SPNB,SPNC)) Q:SPNC=""  D
 ..S SPNFD0=$P($G(^TMP($J,SPNA,SPNB,SPNC)),U,1)
 ..D CHK^SPNHL71(SPNFD0)
 ..D EXIT^SPNHL7
 I SPNCT<3 D ^SPNOGRDA  ;display template grid routines INPAT AND OUTPT ONLY
 Q
 ;
SCREEN ; This is a list of what type goes to what Screenman screens.
 ;;SPNLP FUN MES^1 - Self Report of Function
 ;;SPNLP FIM FM1^2 - FIM
 ;;SPNLP ASIA MES^3 - ASIA
 ;;SPNLP CHART FM1^4 - CHART
 ;;SPNLP FAM FM1^5 - FAM
 ;;SPNLP DIENER FM1^6 - DIENER
 ;;SPNLP DUSOI FM1^7 - DUSOI
 ;;SPNLP MS FM1^8 - Multiple Sclerosis
 Q
