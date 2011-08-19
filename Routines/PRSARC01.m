PRSARC01 ;WOIFO/JAH - Recess Tracking ListManger Action Protocols ;10/17/06
 ;;4.0;PAID;**112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ; ^TMP("PRSSW",$J) index of user selected weeks.
 ; ^TMP("PRSRW",$J) index of recess weeks with hours.
 ;
EDITSTRT ; action protocol-edit AWS Start Date
 ;
 N RWREC
 S VALMBCK="R"
 I $G(PRSVIEW) D VWMSG^PRSARC03(1) Q
 N OUT
 D FULL^VALM1
 W @IOF,!
 ;
 W !,"  WARNING:  Changing the AWS start date will remove recess hours"
 W !,"            that are earlier than the new AWS start date.",!
 S OUT=$$ASK^PRSLIB00()
 S VALMBCK="R"
 Q:OUT
 N PRSDTTMP
 S PRSDTTMP=PRSDT
 D NEWSTART^PRSARC03(.OUT,.PRSDT)
 I OUT S PRSDT=PRSDTTMP Q
 ;
 S RWREC=$P(PRSFY,U,9)
 I RWREC>0 D GETFLWKS^PRSARC03(RWREC,PRSDT)
 S PRSRWHRS=$$GETAVHRS^PRSARC04(.FMWKS,PRSDT)
 N FIRSTRW
 S FIRSTRW=$O(^TMP("PRSRW",$J,0))
 I $G(FIRSTRW)>0 S FIRSTRW=+^TMP("PRSRW",$J,FIRSTRW)
 S VALMBG=$S($G(FIRSTRW)>3:FIRSTRW-1,1:1)
 Q
 ;
SETWKHRS(OUT) ;set hrs for selected weeks
 ;
 N RH1,RH2,OTHERHRS,UOH,CTRH1,CTRH2,UCTH
 S VALMBCK="R"
 D FULL^VALM1
 W @IOF,!
 I '$D(^TMP("PRSSW",$J)) D  Q
 .  W !,"No weeks have been selected."
 .  S OUT=$$ASK^PRSLIB00(1)
 .  S VALMBCK="R"
 ;
 D WHATHRS(.OUT,.RH1,.RH2,.OTHERHRS,.UOH,.CTRH1,.CTRH2,.UCTH)
 I $G(OUT) S VALMBCK="R" Q
 ;
 D SETWKSLM(.OOPSWKS,RH1,RH2,OTHERHRS,UOH,CTRH1,CTRH2,UCTH)
 ;
 I $G(OOPSWKS)'="" S VALMSG="No tour data for the following weeks: "_$P(OOPSWKS,1,$L(OOPSWKS,",")-1)
 ;
 D DSELALL
 S VALMBCK="R"
 Q
WHATHRS(OUT,RH1,RH2,OTHERHRS,UOH,CTRH1,CTRH2,UCTH) ;Ask user-which hours
 ; to use.
 ;
 ; UCTH-use current tour hours flag
 ; get current ToD hrs for week 1,2-ask whether to use hrs for recess.
 ;
 N DIR,Y,I
 S (CTRH1,CTRH2,RH1,RH2,OTHERHRS,UOH,UCTH)=0
 N PPI S PPI=$O(^PRST(458,999999),-1)
 N TH D TOURHRS^PRSARC07(.TH,PPI,+PRSNURSE,"")
 S CTRH1=TH("W1"),CTRH2=TH("W2")
 I CTRH1>0!(CTRH2>0) D
 .   S UOH=1
 .   S OTHERHRS=$$OTHERHRS^PRSARC03(CTRH1,CTRH2,+PRSNURSE)
 .   I OTHERHRS D
 ..     S DIR("A")="Set recess to match tour hours from the timecard (Recommended)"
 ..     S DIR("?",1)=" You have selected weeks in the past that have tour hours"
 ..     S DIR("?",2)=" on the nurses' timecard that are different than the"
 ..     S DIR("?",3)=" current tour hours."
 ..     S DIR("?",4)=""
 ..     S DIR("?",5)="Current tour of duty hours are as follows:"
 ..     S DIR("?",6)="   Week 1 of pay period: "_TH("W1")
 ..     S DIR("?",7)="   Week 2 of pay period: "_TH("W2")
 ..     S I=0 F  S I=$O(DIR("?",I)) Q:I'>0  W !,DIR("?",I)
 ..     S DIR("B")="YES"
 ..     S DIR(0)="Y"
 ..     D ^DIR
 ..     S (UOH,UCTH)=+Y
 .   I 'OTHERHRS!(UOH=0) D
 ..    S DIR("A")="Set recess hours to current tour of duty hours"
 ..    S DIR("?",1)="Current tour of duty hours are as follows:"
 ..    S DIR("?",2)="   Week 1 of pay period: "_TH("W1")
 ..    S DIR("?",3)="   Week 2 of pay period: "_TH("W2")
 ..    S DIR("?",4)=""
 ..    S DIR("?",5)="Choose yes to mark recess weeks with current tour of duty hours"
 ..    S DIR("?",6)="for week 1 and 2."
 ..    S DIR("?")="Enter yes or no."
 ..    S DIR("B")="YES"
 ..    S DIR(0)="Y"
 ..    S I=0 F  S I=$O(DIR("?",I)) Q:I'>0  W !,DIR("?",I)
 ..    D ^DIR
 ..    S UCTH=Y
 E  D
 .  W !,"There are no tour hours in the current pay period."
 .  S UCTH=0
 ;
 I $D(DIRUT) Q
 ;
 N ODD,EVEN
 I 'UCTH D
 .  ; return true if there are odd or even pp weeks in the selection
 .  D EVEODDWK^PRSARC03(.ODD,.EVEN)
 .  I ODD D
 ..   K DIR,Y
 ..   S DIR("B")=40
 ..   S DIR("A")="Enter recess hours for the 1st week of the pay period"
 ..   S DIR("?")="Pay period week 1 hours.  Enter the recess hours for selected weeks."
 ..   S DIR(0)="N^0:72:2"
 ..   N VALID S (VALID,OUT)=0
 ..   F  D  Q:VALID!OUT
 ...    D ^DIR
 ...    I (+Y#.25)=0 S VALID=1
 ...    I +Y=0 S Y=""
 ...    I $D(DIRUT) S OUT=1
 ...    S RH1=Y
 .  Q:$G(OUT)
 .  I EVEN D
 ..   K DIR,Y
 ..   S DIR("B")=80-$S($G(RH1)>0:RH1,1:40)
 ..   S DIR("A")="Enter recess hours for the 2nd week of the pay period"
 ..   S DIR("?")="Pay period week 2 hours.  Enter the recess hours for selected weeks."
 ..   S DIR(0)="N^0:72:2"
 ..   N VALID S (VALID,OUT)=0
 ..   F  D  Q:VALID!OUT
 ...    D ^DIR
 ...    I (+Y#.25)=0 S VALID=1
 ...    I +Y=0 S Y=""
 ...    I $D(DIRUT) S OUT=1
 ...    S RH2=Y
 Q
SETWKSLM(OOPSWKS,RH1,RH2,OTHERHRS,UOH,CTRH1,CTRH2,UCTH) ;
 ; Set weeks RECESS HOURS in listmanager display
 ;
 N ITEM,LSTITEM
 N OOPSWKS S OOPSWKS=""
 S ITEM=0
 F  S ITEM=$O(^TMP("PRSSW",$J,ITEM)) Q:ITEM'>0  D
 . ; Get item out of selectable items index
 . S RH=$S(ITEM#2:$G(RH1),1:$G(RH2))
 . I $G(OTHERHRS),$G(UOH) D
 ..  N D1,DAY,PPI,PPE S D1=$G(WKSFM(ITEM)) D PP^PRSAPPU
 ..  I $G(PPI)>0 D
 ...   K TH D TOURHRS^PRSARC07(.TH,PPI,+PRSNURSE,"")
 ...   S RH=$S(ITEM#2:TH("W1"),1:TH("W2"))
 . I RH'>0,UCTH S RH=$S(ITEM#2:CTRH1,1:CTRH2)
 . S LSTITEM=$G(^TMP("PRSSW",$J,ITEM))
 . D FLDTEXT^VALM10(LSTITEM,"RECESS HOURS",$J(RH,15,2))
 .;
 .; set hours for selected weeks, remove from array if 0
 .; 
 . I RH'>0 D
 ..  I UCTH S OOPSWKS=OOPSWKS_ITEM_","
 ..  K ^TMP("PRSRW",$J,ITEM)
 . E  D
 ..  S $P(^TMP("PRSRW",$J,ITEM),U,2)=RH
 ..  S $P(^TMP("PRSRW",$J,ITEM),U,3)=$G(WKSFM(ITEM))
 ..  ;S $P(^TMP("PRSRW",$J,ITEM),U,4)=REW
 Q
SELRWK(PR,OUT) ;PROMPT USER TO SELECT WEEKS FOR RECESS
 ; 
 ; INPUT: PR-prompt flag are they setting recess hours or removing
 ;        recess hours
 ; OUTPUT: OUT - user aborted or timed out
 S VALMBCK="R"
 I $G(PRSVIEW) D VWMSG^PRSARC03(1) Q
 N DIR,DIRUT,LISTI,ITEM,Y
 S OUT=1
 ;
 ; clear out current selections
 ;
 D DSELALL
 N PRESEL
 S PRESEL=+$P($P($G(XQORNOD(0)),U,4),"=",2)
 I PRESEL,(PRESEL'=$P($P($G(XQORNOD(0)),U,4),"=",2))!((PRESEL'>PRSWKLST)&(PRESEL'<PRSLSTRT)) S Y=$$PARSE^PRSARC08(XQORNOD(0),PRSLSTRT,PRSWKLST)
 I '(+$G(Y))!(+$G(Y)<PRSLSTRT)!(+$G(Y)>PRSWKLST) D
 .S DIR(0)="L^"_PRSLSTRT_":"_PRSWKLST
 .I $G(PR)="Z" D
 .. S DIR("A")="Enter week numbers to set back to work weeks"
 .E  D
 .. S DIR("A")="Enter week numbers to set to recess"
 .;
 .D ^DIR
 S VALMBCK="R"
 Q:$D(DIRUT)
 F I=1:1:$L(Y,",") D
 .  S ITEM=+$P(Y,",",I)
 .  Q:ITEM'>0
 . ; Get item out of selectable items index
 .  S LISTI=$G(^TMP("PRSLI",$J,ITEM))
 .;
 .; set selection week, recess
 .;
 .  S $P(^TMP("PRSRW",$J,ITEM),U)=LISTI
 .  S ^TMP("PRSSW",$J,ITEM)=LISTI
 S OUT=0
 I "ZX"'[PR D SETWKHRS(.OUT)
 S VALMBCK="R"
 Q
FLRECESS ; save recess schedule hrs to file
 S VALMBCK="Q"
 N SURE S SURE=0
 ;
 N CANADD,HASREC,OUT,CHANGE
 S CANADD=$P(PRSNURSE,U,3)
 S HASREC=$P(PRSFY,U,9)
 ;
 N DIR,Y,DIRUT
 I $G(PRSOUT)=1 D
 . S CHANGE=$$CHANGE^PRSARC03(HASREC)
 . I 'HASREC!CHANGE D
 ..  S SURE=1
 ..  S DIR("A")="Changes will be lost.  Are you sure you want to quit"
 ..  S DIR(0)="Y",DIR("B")="NO" D ^DIR
 I SURE,(Y=0!$D(DIRUT)) S VALMBCK="R",PRSOUT=0 Q
 I $G(PRSOUT)=1 S VALMBCK="Q" D:CHANGE VWMSG^PRSARC03(2) Q
 ;
 ;If new record add it. Nurse must be current AWS 9-month
 ;
 N PRSFDA,IEN,IENS,HOURS,WEEK
 D FULL^VALM1
 ;
 I CANADD,'HASREC D
 .  K PRSFDA
 .  S PRSFDA(458.8,"+1,",.01)=+PRSNURSE
 .  S PRSFDA(458.8,"+1,",1)=+PRSFY
 .  S PRSFDA(458.8,"+1,",1.1)=PRSDT
 .  D UPDATE^DIE("","PRSFDA","IEN"),MSG^DIALOG()
 .  S HASREC=$G(IEN(1))
 .  S $P(PRSFY,U,9)=HASREC
 .  S $P(PRSFY,U,10)=$E(PRSDT,4,5)_"/"_$E(PRSDT,6,7)_"/"_$E(PRSDT,2,3)
 .  S $P(PRSFY,U,11)=PRSDT
 ;
 I HASREC D
 .; start date changed?
 .  I $P($G(^PRST(458.8,HASREC,3)),U,2)'=PRSDT D
 ..   K PRSFDA,IENS
 ..   S IENS=HASREC_","
 ..   S PRSFDA(458.8,IENS,1.1)=PRSDT
 ..   D UPDATE^DIE("","PRSFDA","IEN"),MSG^DIALOG()
 ..   S $P(PRSFY,U,10)=$E(PRSDT,4,5)_"/"_$E(PRSDT,6,7)_"/"_$E(PRSDT,2,3)
 ..   S $P(PRSFY,U,11)=PRSDT
 . I $$CHANGE^PRSARC03(HASREC) D
 .. ; clean out old recess week records
 ..   N WKIEN S WKIEN=0
 ..   F  S WKIEN=$O(^PRST(458.8,HASREC,1,WKIEN)) Q:WKIEN'>0  D
 ...    S IENS=WKIEN_","_HASREC_","
 ...    S PRSFDA(458.82,IENS,.01)="@"
 ..   D FILE^DIE("E","PRSFDA")
 ..;
 ..   S WEEK=0
 ..   F  S WEEK=$O(^TMP("PRSRW",$J,WEEK)) Q:WEEK'>0  D
 ...    S HOURS=$P(^TMP("PRSRW",$J,WEEK),U,2)
 ...    Q:HOURS'>0
 ...    K PRSFDA,IENS
 ...    S IENS="+1,"_HASREC_","
 ...    S PRSFDA(458.82,IENS,.01)=WEEK
 ...    S PRSFDA(458.82,IENS,1)=HOURS
 ...    S PRSFDA(458.82,IENS,2)=$G(WKSFM(WEEK))
 ...    S PRSFDA(458.82,IENS,3)=$P(^TMP("PRSRW",$J,WEEK),U,4)
 ...    D UPDATE^DIE("","PRSFDA","IENS"),MSG^DIALOG()
 ..;
 ..;  update user edit date time
 ..;
 ..    N %,%H,%I,X D NOW^%DTC
 ..    K PRSFDA,IENS
 ..    S IENS="+1,"_HASREC_","
 ..    S PRSFDA(458.83,IENS,.01)=%
 ..    S PRSFDA(458.83,IENS,1)=DUZ
 ..    D UPDATE^DIE("","PRSFDA","IENS"),MSG^DIALOG()
 .   S VALMSG="Changes Saved."
 . E  D
 ..  S VALMSG="Recess schedule has not changed since last save."
 ;
 I '$G(PRSVONLY) D
 .  W !,VALMSG
 .  S VALMBCK="Q"
 E  D
 .  S VALMBCK="R"
 Q
 ;
DSELWK ;DESELECT WEEKS
 ;
 S VALMBCK="R"
 I $G(PRSVIEW) D VWMSG^PRSARC03(1) Q
 N OUT,ITEM,REW,RH,RDATA
 S VALMBCK="R"
 D SELRWK("Z",.OUT)
 Q:OUT
 ;
 ; remove selections from recess array
 S (ITEM,RH)=0
 F  S ITEM=$O(^TMP("PRSSW",$J,ITEM)) Q:ITEM'>0  D
 . S LSTITEM=$G(^TMP("PRSSW",$J,ITEM))
 . D FLDTEXT^VALM10(LSTITEM,"RECESS HOURS","")
 . S RDATA=^TMP("PRSRW",$J,ITEM)
 . I $P(RDATA,U,5)'>0 D
 ..   K ^TMP("PRSRW",$J,ITEM)
 . E  D
 ..  S $P(^TMP("PRSRW",$J,ITEM),U,2)=""
 ;
 D DSELALL
 S VALMBCK="R"
 Q
DSELALL ; procedure removes items from selected items index w/no effect
 ; on ListMan display.
 ;
 N ITEM,LISTI
 S ITEM=0
 F  S ITEM=$O(^TMP("PRSSW",$J,ITEM)) Q:ITEM'>0  D
 . S LISTI=$G(^TMP("PRSSW",$J,ITEM))
 . K ^TMP("PRSSW",$J,ITEM)
 Q
