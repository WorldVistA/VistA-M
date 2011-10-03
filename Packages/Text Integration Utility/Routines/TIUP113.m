TIUP113 ; SLC/JAK - Post-Install for TIU*1*113 ;12/01/03
 ;;1.0;TEXT INTEGRATION UTILITIES;**113**;Jun 20, 1997
BUILD ; -- Rebuild SEARCH CATEGORIES so DIVISION is selectable
 D KILL^TIUDD8
 Q
MAIN ; -- Control unit
 N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 W !!,"PATCH TIU*1*113"
 W !!,"Load the DIVISION field for TIU DOCUMENT file (#8925) entries.",!
 S ZTRTN="SETDIV^TIUP113",ZTIO="",ZTSAVE("DUZ")=""
 S ZTDESC="DIVISION field load for File #8925 - Patch 113"
 D ^%ZTLOAD
 I $G(ZTSK) D
 . W !!,"A task has been queued in the background and a bulletin will be sent"
 . W !,"to you upon completion of the task or if the task is stopped."
 . W !!,"The task number is "_$G(ZTSK)_"."
 Q
SETDIV ; -- Automatically set division for documents
 N TIUCNT,TIUDA,TIUS
 S ^XTMP("TIUP113","T0")=$$NOW^XLFDT
 ; Initialize re-start if check point exists
 I +$G(^XTMP("TIUP113","CHKPT")) D
 . S TIUDA=+$G(^XTMP("TIUP113","CHKPT"))
 E  D
 . ; Initialize if not re-start
 . S ^XTMP("TIUP113",0)=$$FMADD^XLFDT(DT,90)_U_DT
 . S ^XTMP("TIUP113","EX")=0 F TIUS=1,2 S ^XTMP("TIUP113","EX",TIUS)=0
 . S (TIUDA,^XTMP("TIUP113","CHKPT"))=0
 K ^XTMP("TIUP113","STOP")
 ;
 ; Loop thru TIU Document entries
 F  S TIUDA=$O(^TIU(8925,TIUDA)) Q:+TIUDA'>0!($G(ZTSTOP))  D
 . S TIUCNT=+$G(TIUCNT)+1
 . ; Register activity in the ^XTMP("TIUP113", array
 . S ^XTMP("TIUP113","CHKPT")=TIUDA
 . ; Check if user requested to stop task
 . I $G(TIUCNT)>1000 D
 . . I $$S^%ZTLOAD S ZTSTOP=1
 . . E  S TIUCNT=0
 . ;
 . I +$P($G(^TIU(8925,TIUDA,12)),U,12) Q
 . N TIUDTYP,TIUEX
 . S TIUDTYP=+$P($G(^TIU(8925,TIUDA,0)),U)
 . ; -- Ignore records of (document type) type=component
 . I TIUDTYP,$P($G(^TIU(8925.1,TIUDTYP,0)),U,4)="CO" Q
 . ; -- Check if hospital location and entry date/time don't exist
 . I '$D(^TIU(8925,TIUDA,12)) D SETEX(TIUDA,1) Q
 . ; -- Get IFP from HL's Division
 . N RESULT,TIUE,TIUHL,TIUDVHL,TIUIFP
 . S (TIUDVHL,TIUE,TIUHL,TIUIFP)=0
 . S TIUHL=+$P($G(^TIU(8925,TIUDA,12)),U,5) I TIUHL D
 . . S TIUDVHL=+$P($G(^SC(TIUHL,0)),U,15) I TIUDVHL D
 . . . S TIUE=+$P($G(^TIU(8925,TIUDA,12)),U) I TIUE D
 . . . . S TIUIFP=+$$SITE^VASITE(TIUE,TIUDVHL) I TIUIFP>0 S RESULT=TIUIFP
 . I 'TIUHL!('TIUDVHL)!('TIUE)!(TIUIFP<0) D
 . . D SETEX(TIUDA,1)
 . E  D
 . . D SETRSLT(TIUDA,RESULT)
 ;
SETCHKQ ; Send bulletin and re-set check point
 I $G(ZTSTOP) S ^XTMP("TIUP113","STOP")=$$NOW^XLFDT
 S ^XTMP("TIUP113","T1")=$$NOW^XLFDT
 S ^XTMP("TIUP113","EX")=+$G(^XTMP("TIUP113","EX",1))+(+$G(^XTMP("TIUP113","EX",2)))
 ;
 D MAIL^TIUP113P
 ;
 I '$G(ZTSTOP) S ^XTMP("TIUP113","CHKPT")=""
 Q
SETEX(TIUDA,TIUEX) ; -- Load ^XTMP with exception entries
 ; Input -- TIUDA  TIU Document file (#8925) IEN
 ;          TIUEX  Exception types:
 ;                 1=Cannot determine DIVISION from Hospital Location
 ;                 2=Attempted to load DIVISION data but entry in use
 ;                 (value=1) (see SETRSLT for value=2)
 S ^XTMP("TIUP113","EX",TIUEX,TIUDA)=""
 S ^XTMP("TIUP113","EX",TIUEX)=+$G(^XTMP("TIUP113","EX",TIUEX))+1
 Q
SETRSLT(TIUDA,RESULT) ; -- Set DIVISION data and ADIV x-ref
 ; Input -- TIUDA   TIU Document file (#8925) IEN
 ;          RESULT  Institution file (#4) IEN
 N DIE,DR,DA
 L +^TIU(8925,+TIUDA):5 E  D  Q
 . S ^XTMP("TIUP113","EX",2,TIUDA)=RESULT
 . S ^XTMP("TIUP113","EX",2)=+$G(^XTMP("TIUP113","EX",2))+1
 S DIE="^TIU(8925,",DA=+TIUDA,DR="1212////^S X=RESULT"
 D ^DIE
 L -^TIU(8925,+TIUDA)
 Q
UPDATE ; -- Exception entries
 W !,"If you did not receive a mail message which indicated the post-"
 W !,"install COMPLETED, you must invoke MAIN^TIUP113 from Programmer"
 W !,"mode before following the instructions below.",!
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 N RESULT,TIUCHC,TIUDA,TIUDIV,TIUI,TIUJ,TIUK,TIUNOEX,TIUOUT,TIUS
 S TIUOUT=0 F TIUK=7,9,18 S DIR("A",TIUK)=""
 S DIR("A",1)="Below are listed the choices for what action(s) to take"
 S DIR("A",2)="on the exception entries. It is recommended you select"
 S DIR("A",3)="choice 3 and also possibly choice 2. The numbers can be"
 S DIR("A",4)="selected by commas, dashes, or a combination of both."
 S DIR("A",5)="You can invoke this entry point (>D UPDATE^TIUP113)"
 S DIR("A",6)="as often as you wish."
 S DIR("A",8)="CHOICES:"
 S DIR("A",10)="1- Exit and do not load Division for exception entries."
 S DIR("A",11)="2- For exception entries in which Division could not be"
 S DIR("A",12)="   determined from the Hospital Location, prompt me to"
 S DIR("A",13)="   select one Division and load entries with this"
 S DIR("A",14)="   Division. (type A)"
 S DIR("A",15)="3- For exception entries that were previously in use,"
 S DIR("A",16)="   try to load Division data again. (type B)"
 S DIR("A")="Select (a) NUMBER(S)"
 S DIR(0)="L^1:3" D ^DIR G EXIT:$D(DIRUT) S TIUCHC=Y
 I TIUCHC[1 Q
 I TIUCHC[2 N DIR,X,Y S DIR(0)="P^40.8" D ^DIR G EXIT:Y'>0!$D(DIRUT) D
 . S TIUDIV=+Y,TIUIFP=+$$SITE^VASITE(,TIUDIV),RESULT=TIUIFP
 F TIUI=1:1:($L(TIUCHC,",")-1) D
 . S TIUS=$P(TIUCHC,",",TIUI)
 . I TIUS=2 D NOEX(TIUS,1) I 'TIUNOEX D
 . . N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 . . S ZTRTN="TWOA^TIUP113",ZTIO=""
 . . S (ZTSAVE("DUZ"),ZTSAVE("RESULT"))=""
 . . S ZTDESC="Choice 2 UPDATE^TIUP113 - Patch 113"
 . . D ^%ZTLOAD
 . . I $G(ZTSK) D
 . . . W !!,"A task has been queued in the background for Choice 2."
 . . . W !,"The task number is "_$G(ZTSK)_"."
 . . Q
 . I TIUS=3 D THREEB(TIUS)
 Q
TWOA ; -- Load entries with selection
 ; Input -- RESULT  Institution file (#4) IEN
 N TIUCNT
 S TIUDA=0 D
 . F  S TIUDA=$O(^XTMP("TIUP113","EX",1,TIUDA)) Q:+TIUDA'>0!($G(ZTSTOP))  D
 . . D SETRSLT(TIUDA,RESULT)
 . . K ^XTMP("TIUP113","EX",1,TIUDA)
 . . S TIUCNT=+$G(TIUCNT)+1
 . . ; Check if user requested to stop task
 . . I $G(TIUCNT)>1000 D
 . . . I $$S^%ZTLOAD S ZTSTOP=1
 . . . E  S TIUCNT=0
 ;
 I '$G(ZTSTOP) S ^XTMP("TIUP113","EX",1)=0
 Q
THREEB(TIUS) ; -- Try to load locked entries
 ; Input --   TIUS  Choice 3
 S TIUDA=0 N RESULT D NOEX(TIUS,2) I 'TIUNOEX D
 . W !!,"...Choice 3 - UPDATING NOW....",!!
 . F  S TIUDA=$O(^XTMP("TIUP113","EX",2,TIUDA)) Q:+TIUDA'>0  D
 . . S RESULT=$G(^XTMP("TIUP113","EX",2,TIUDA))
 . . D SETRSLT(TIUDA,RESULT)
 . . I +$P($G(^TIU(8925,TIUDA,12)),U,12) K ^XTMP("TIUP113","EX",2,TIUDA)
 . S ^XTMP("TIUP113","EX",2)=0
 Q
NOEX(TIUS,TIUJ) ; -- No exceptions
 ; Input -- TIUS  Choice 2 or 3
 ;       -- TIUJ  Exception entry types A (1) or B (2)
 S TIUNOEX=0
 I +$G(^XTMP("TIUP113","EX",TIUJ))=0 D
 . W !,"Choice: ",TIUS,"-type ",$S(TIUJ=2:"B",1:"A")
 . W " has no exceptions."
 . S TIUNOEX=1
 Q
DEVICE ; -- Device Selection
 N TIUMSG,TIUOUT S TIUOUT=0
 S TIUMSG(1)="Remember to finish the post-install after review of"
 S TIUMSG(2)="the output by invoking UPDATE^TIUP113"
 D MES^XPDUTL(.TIUMSG)
 W !! S %ZIS="Q" D ^%ZIS I POP K POP S TIUOUT=1 G EXIT
 I $D(IO("Q")) D  Q
 . S ZTRTN="PRINT^TIUP113"
 . S ZTDESC="TIU*1*113 POST-INSTALL EXCEPTION LIST"
 . D ^%ZTLOAD W !,$S($D(ZTSK):"Request queued",1:"Request Cancelled!")
 . K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,%ZIS
 . D HOME^%ZIS
 U IO D PRINT,^%ZISC
 Q
PRINT ; -- Print job
 N TIUDA,TIUIFP,TIUOUT,TIUS,TIUST S TIUOUT=0
 I $D(ZTQUEUED) S ZTREQ="@"
 F TIUS=1,2 Q:TIUOUT  S TIUDA=0 D
 . I TIUS=2 D ASK Q:TIUOUT
 . D HDR W !!,$P($T(EXHDR+TIUS),";",3)
 . I +$G(^XTMP("TIUP113","EX",TIUS))=0 W !?4,"No exceptions." Q
 . F  S TIUDA=$O(^XTMP("TIUP113","EX",TIUS,TIUDA)) Q:+TIUDA'>0!(TIUOUT)  D
 . . I $Y>(IOSL-4) D ASK Q:TIUOUT  D HDR W !!,$P($T(EXHDR+TIUS),";",3)
 . . W !?4,TIUDA
 . . S TIUST=$P($G(^TIU(8925,+TIUDA,0)),U,5) I TIUST>0 D
 . . . W "  ",$P($G(^TIU(8925.6,+TIUST,0)),U)
 . . I TIUS=2 D
 . . . S TIUIFP=$G(^XTMP("TIUP113","EX",2,TIUDA))
 . . . W ": ",$$GET1^DIQ(4,TIUIFP,.01)
 Q
ASK ; -- End of Page
 I IO=IO(0),$E(IOST)="C" D
 . W ! N DIR,X,Y S DIR(0)="E"
 . D ^DIR I $D(DUOUT)!$D(DTOUT) S TIUOUT=1
 Q
HDR ; -- Header
 N LNE,TIUNOW
 D NOW^%DTC S Y=% X ^DD("DD") S TIUNOW=Y
 W @IOF,"TIU*1*113 POST-INSTALL EXCEPTION LIST - Printed: ",TIUNOW
 W !!,"Listed below are TIU DOCUMENT entry numbers that did not get "
 W "DIVISION data",!,"loaded. If a division name is listed with an "
 W "entry number, the record was",!,"in use and the division data "
 W "could not be loaded."
 W ! S LNE="",$P(LNE,"-",(IOM-1))="" W LNE
 Q
EXHDR ; -- Exception entry headers
 ;;A. Cannot determine DIVISION from Hospital Location: 
 ;;B. Attempted to load DIVISION data but entry in use: 
 ;
EXIT ; -- Exits here if ^ at: DEVICE prompt,
 ; -- two UPDATE areas, or at End of Page
 I TIUOUT D
 . W $C(7),$C(7),!!,"OK...please remember to finish the post-install "
 . W "by: >D UPDATE^TIUP113"
 Q
