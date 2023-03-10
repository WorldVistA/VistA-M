PXQPPUTILR ;SLS/PKR - Utility for primary provider, report. ;08/14/2020
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 454
 ;
 ;===============
REPORT ;Report what was done.
 N FMTSTR,IENS,JND,NL,NOUT,NUM,OUTPUT,PROVIDER,PROVNAME
 N REPEND,REPSTART,TEMP,TEXT
 N VISIT,VISITID,VISITIEN,X
 S REPSTART=^TMP("PXQPPR",$J,"REPSTART")
 S REPEND=$$NOW^XLFDT
 S TEXT(1)="Primary Provider repair utility started "_$$FMTE^XLFDT(REPSTART)_"."
 S TEXT(2)="Finished "_$$FMTE^XLFDT(REPEND)_"."
 S TEXT(3)="Elapsed time "_$$FMDIFF^XLFDT(REPEND,REPSTART,3)_"."
 S TEXT(4)=""
 S TEXT(5)="Encounter start date: "_$$FMTE^XLFDT(^TMP("PXQPPR",$J,"STARTDATE"))
 S TEXT(6)="Encounter end date:   "_$$FMTE^XLFDT(^TMP("PXQPPR",$J,"ENDDATE"))
 S TEXT(7)=" "
 S NL=7
 ;
 ;Lab encounters.
 I $D(^TMP("PXQPPR",$J,"LAB")) D
 . S NL=NL+1,TEXT(NL)=" "
 . S NL=NL+1,TEXT(NL)="Lab Encounter Results:"
 . I $D(^TMP("PXQPPR",$J,"LAB","SETP")) D
 .. S FMTSTR="25L2^44L2^7L"
 .. S NL=NL+1,TEXT(NL)=" "
 .. S NL=NL+1,TEXT(NL)="List of Ordering Providers Made Primary"
 .. S TEMP="Visit^Primary Provider^Result"
 .. D COLFMT^PXRMTEXT(FMTSTR,TEMP," ",.NOUT,.OUTPUT)
 .. S NL=NL+1,TEXT(NL)=OUTPUT(1)
 .. S NUM=0,VISITIEN=""
 .. F  S VISITIEN=$O(^TMP("PXQPPR",$J,"LAB","SETP",VISITIEN)) Q:VISITIEN=""  D
 ... S VISIT=$P(^AUPNVSIT(VISITIEN,0),U,1)
 ... S VISITID=$P(^AUPNVSIT(VISITIEN,150),U,1)
 ... S VISIT=$$FMTE^XLFDT(VISIT)_" ("_VISITID_")"
 ... S PROVIDER=$O(^TMP("PXQPPR",$J,"LAB","SETP",VISITIEN,""))
 ... S PROVNAME=$P(^VA(200,PROVIDER,0),U,1)_" ("_PROVIDER_")"
 ... S RESULT=^TMP("PXQPPR",$J,"LAB","SETP",VISITIEN,PROVIDER)
 ... I RESULT="SUCCESS" S NUM=NUM+1
 ... S TEMP=VISIT_"^"_PROVNAME_"^"_RESULT
 ... D COLFMT^PXRMTEXT(FMTSTR,TEMP," ",.NOUT,.OUTPUT)
 ... F JND=1:1:NOUT S NL=NL+1,TEXT(NL)=OUTPUT(JND)
 .. S NL=NL+1,TEXT(NL)=" "
 .. S NL=NL+1,TEXT(NL)=NUM_" lab encounters had a primary provider automatically set."
 . I $D(^TMP("PXQPPR",$J,"LAB","OPEN")) D
 .. S NL=NL+1,TEXT(NL)=" "
 .. S NL=NL+1,TEXT(NL)="Lab Encounters Opened For Editing"
 .. S NUM=0,VISITIEN=""
 .. F  S VISITIEN=$O(^TMP("PXQPPR",$J,"LAB","OPEN",VISITIEN)) Q:VISITIEN=""  D
 ... S VISIT=$P(^AUPNVSIT(VISITIEN,0),U,1)
 ... S VISITID=$P(^AUPNVSIT(VISITIEN,150),U,1)
 ... S VISIT=$$FMTE^XLFDT(VISIT)_" ("_VISITID_")"
 ... S NL=NL+1,TEXT(NL)=VISIT
 ... S NUM=NUM+1
 .. S NL=NL+1,TEXT(NL)=" "
 .. S NL=NL+1,TEXT(NL)=NUM_" lab encounters were opened for editing."
 S NL=NL+1,TEXT(NL)=" "
 ;
 ;Radiology encounters.
 I $D(^TMP("PXQPPR",$J,"RAD")) D
 . S NL=NL+1,TEXT(NL)=" "
 . S NL=NL+1,TEXT(NL)="Radiology Encounter Results:"
 . I $D(^TMP("PXQPPR",$J,"RAD","SETP")) D
 .. S FMTSTR="25L2^44L2^7L"
 .. S NL=NL+1,TEXT(NL)=" "
 .. S NL=NL+1,TEXT(NL)="List of Encounter Providers Made Primary"
 .. S TEMP="Visit^Primary Provider^Result"
 .. D COLFMT^PXRMTEXT(FMTSTR,TEMP," ",.NOUT,.OUTPUT)
 .. S NL=NL+1,TEXT(NL)=OUTPUT(1)
 .. S NUM=0,VISITIEN=""
 .. F  S VISITIEN=$O(^TMP("PXQPPR",$J,"RAD","SETP",VISITIEN)) Q:VISITIEN=""  D
 ... S VISIT=$P(^AUPNVSIT(VISITIEN,0),U,1)
 ... S VISITID=$P(^AUPNVSIT(VISITIEN,150),U,1)
 ... S VISIT=$$FMTE^XLFDT(VISIT)_" ("_VISITID_")"
 ... S PROVIDER=$O(^TMP("PXQPPR",$J,"RAD","SETP",VISITIEN,""))
 ... S PROVNAME=$P(^VA(200,PROVIDER,0),U,1)_" ("_PROVIDER_")"
 ... S RESULT=^TMP("PXQPPR",$J,"RAD","SETP",VISITIEN,PROVIDER)
 ... I RESULT="SUCCESS" S NUM=NUM+1
 ... S TEMP=VISIT_"^"_PROVNAME_"^"_RESULT
 ... D COLFMT^PXRMTEXT(FMTSTR,TEMP," ",.NOUT,.OUTPUT)
 ... F JND=1:1:NOUT S NL=NL+1,TEXT(NL)=OUTPUT(JND)
 .. S NL=NL+1,TEXT(NL)=" "
 .. S NL=NL+1,TEXT(NL)=NUM_" radiology encounters had a primary provider automatically set."
 .;
 . I $D(^TMP("PXQPPR",$J,"RAD","NO EXAM")) D
 .. S NL=NL+1,TEXT(NL)=" "
 .. S NL=NL+1,TEXT(NL)="No Radiology Exams are linked to the following encounters."
 .. S NUM=0,VISITIEN=""
 .. F  S VISITIEN=$O(^TMP("PXQPPR",$J,"RAD","NO EXAM",VISITIEN)) Q:VISITIEN=""  D
 ... S VISIT=$P(^AUPNVSIT(VISITIEN,0),U,1)
 ... S VISITID=$P(^AUPNVSIT(VISITIEN,150),U,1)
 ... S VISIT=$$FMTE^XLFDT(VISIT)_" ("_VISITID_")"
 ... S NUM=NUM+1
 ... S NL=NL+1,TEXT(NL)=VISIT
 .. S NL=NL+1,TEXT(NL)=" "
 .. S NL=NL+1,TEXT(NL)=NUM_" radiology encounters could not be linked to an exam."
 .;
 . I $D(^TMP("PXQPPR",$J,"RAD","VISIT")) D
 .. S NL=NL+1,TEXT(NL)=" "
 .. S NL=NL+1,TEXT(NL)="The following Radiology Exams were linked to an encounter."
 .. S FMTSTR="30L2^35L"
 .. S TEMP="Exam IENS^Visit"
 .. D COLFMT^PXRMTEXT(FMTSTR,TEMP,"  ",.NOUT,.OUTPUT)
 .. S NL=NL+1,TEXT(NL)=OUTPUT(1)
 .. S NUM=0,VISITIEN=""
 .. F  S VISITIEN=$O(^TMP("PXQPPR",$J,"RAD","VISIT",VISITIEN)) Q:VISITIEN=""  D
 ... S NUM=NUM+1
 ... S VISIT=$P(^AUPNVSIT(VISITIEN,0),U,1)
 ... S VISITID=$P(^AUPNVSIT(VISITIEN,150),U,1)
 ... S VISIT=$$FMTE^XLFDT(VISIT)_" ("_VISITID_")"
 ... S IENS=^TMP("PXQPPR",$J,"RAD","VISIT",VISITIEN)
 ... S TEMP=IENS_"^"_VISIT
 ... D COLFMT^PXRMTEXT(FMTSTR,TEMP,"  ",.NOUT,.OUTPUT)
 ... S NL=NL+1,TEXT(NL)=OUTPUT(1)
 .. S NL=NL+1,TEXT(NL)=" "
 .. S NL=NL+1,TEXT(NL)=NUM_" Exams were linked to a Visit."
 .;
 . I $D(^TMP("PXQPPR",$J,"RAD","PROXY")) D
 .. S NL=NL+1,TEXT(NL)=" "
 .. S NL=NL+1,TEXT(NL)="Encounters with RADIOLOGY,OUTSIDE SERVICE as Primary Provider Opened For Editing"
 .. S NUM=0,VISITIEN=""
 .. F  S VISITIEN=$O(^TMP("PXQPPR",$J,"RAD","PROXY",VISITIEN)) Q:VISITIEN=""  D
 ... S VISIT=$P(^AUPNVSIT(VISITIEN,0),U,1)
 ... S VISITID=$P(^AUPNVSIT(VISITIEN,150),U,1)
 ... S VISIT=$$FMTE^XLFDT(VISIT)_" ("_VISITID_")"
 ... S NL=NL+1,TEXT(NL)=VISIT
 ... S NUM=NUM+1
 .. S NL=NL+1,TEXT(NL)=" "
 .. S NL=NL+1,TEXT(NL)=NUM_" radiology encounters were opened for editing."
 S NL=NL+1,TEXT(NL)=" "
 ;
 ;Show the results.
 S X="IORESET"
 D ENDR^%ZISS
 D BROWSE^DDBR("TEXT","NR","Primary Provider Repair Utility Report")
 W IORESET
 D KILL^%ZISS
 K ^TMP("PXQPPR",$J)
 Q
 ;
