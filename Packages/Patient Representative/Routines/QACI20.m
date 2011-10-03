QACI20 ; OAKOIFO/TKW - DATA MIGRATION - BUILD SUPPORTING TABLE AND ROC DATA TO MIGRATE (CONT.) ;01/12/2007  11:48
 ;;2.0;Patient Representative;**19**;07/25/1995;Build 55
 ;
EN ; Read through ROCs, check for errors and if QACI0=0, move data to staging area.
 F ROCIEN=0:0 S ROCIEN=$O(^QA(745.1,ROCIEN)) Q:'ROCIEN  S ROC0=$G(^(ROCIEN,0)) D
 . S DOTCNT=DOTCNT+1 I DOTCNT=200 W "." S DOTCNT=0
 . S X="" F I=2:1:16 S X=X_$P(ROC0,"^",I)
 . S OLDROC=$P(ROC0,"^")
 . ; If ROC has no ROC number, or nothing but a ROC number, delete it.
 . I X=""!(OLDROC="") S DIK="^QA(745.1,",DA=ROCIEN D ^DIK Q
 . ; Convert ROC Number to PATS format
 . S ROCNO=$$CONVROC^QACI2C(OLDROC)
 . I ROCNO'?3N.E1"."9N D ERROC^QACI2A(OLDROC,"ROC number is not correctly formatted") Q
 . ; Quit if ROC has already been migrated.
 . I $D(^XTMP("QACMIGR","ROC","D",ROCNO)) S X=^(ROCNO) D  Q
 .. I X="" S ^XTMP("QACMIGR","ROC","D",ROCNO)=ROCIEN Q
 .. I X'=ROCIEN D ERROC^QACI2A(OLDROC_" IEN: "_ROCIEN," is a duplicate ROC number")
 .. Q
 . ; Generate an error for duplicate ROC numbers
 . I $D(^XTMP("QACMIGR","ROC","U",ROCNO_" "))!($D(^XTMP("QACMIGR","ROC","E",OLDROC_" "))) D  Q
 .. D ERROC^QACI2A(OLDROC_" IEN: "_ROCIEN," is a duplicate ROC number") Q
 . ; Extract date of contact, convert to 'Oracle friendly' format
 . I $P(ROC0,"^",2)="" D ERROC^QACI2A(OLDROC,"DATE OF CONTACT is missing") Q
 . D DT^DILF("X",$P(ROC0,"^",2),.CONDATE)
 . I CONDATE>0 S CONDATE=$$FMTE^XLFDT(CONDATE,5)
 . I CONDATE'?1.2N1"/"1.2N1"/"4N D ERROC^QACI2A(OLDROC,"DATE OF CONTACT is invalid")
 . ; Kill ROC from list of ROCs whose data was changed during migration
 . ; and initialize variables indicating ROC was changed
 . D:'QACI0
 .. K ^XTMP("QACMIGR","ROC","C",OLDROC_" ")
 .. S (EDITEBY,EDITIBY,EDITDIV,EDITITXT,EDITRTXT)=0 Q
 . S ROC2=$G(^QA(745.1,ROCIEN,2)),ROC7=$G(^(7))
 . ;
 . ; Get station number
 . S STATION=$P(ROC0,"^",16) I STATION]"" D  Q:STATION=""
 .. I '$D(QACDIV(STATION)) D ERROC^QACI2A(OLDROC,"DIVISION pointer "_+STATION_" not in MEDICAL CENTER DIVISION file") Q 
 .. S STATION=$$STA^XUAF4(STATION)
 .. I STATION="" D ERROC^QACI2A(OLDROC,"DIVISION pointer "_+STATION_" is invalid or has no Station Number") Q
 .. I '$D(^XTMP("QACMIGR","STDINSTITUTION",STATION)) D ERROC^QACI2A(OLDROC,"DIVISION "_STATION_" is not a valid national station")
 .. Q
 . E  D
 .. S STATION=$P(ROC0,"."),EDITDIV=1
 .. I '$$LKUP^XUAF4(STATION) D ERROC^QACI2A(OLDROC,"STATION number part of ROC number is invalid.") Q
 .. I '$D(^XTMP("QACMIGR","STDINSTITUTION",STATION)) D ERROC^QACI2A(OLDROC,"DIVISION "_STATION_" is not a valid national station")
 .. Q
 . ;
 . ; Get Patient IEN
 . S DFN=$P(ROC0,"^",3) I DFN]"" D
 .. I 'DFN!('$D(^DPT(+DFN))) D ERROC^QACI2A(OLDROC,"PATIENT pointer "_+DFN_" is invalid") Q
 .. ; build data for pats_patient table
 .. S PATSERR=0 D PTDATA^QACI2B(PARENT,DFN,QACI0,.PATSERR,.PATSCNT)
 .. I PATSERR D ERROC^QACI2A(OLDROC,"PATIENT has invalid data--see ref data report") Q
 . ;
 . ;Extract and convert to Id value--contacting_entity, treatment_status
 . I 'QACI0 D
 .. S X=$P(ROC0,"^",10),CE=$S(X="":10,$G(CE(X)):CE(X),1:10)
 .. S X=$P(ROC2,"^",2) D
 ... I X]"",$G(TS(X)) S TS=TS(X) Q
 ... S TS=$S(DFN="":5,1:4) Q
 .. Q
 . ;
 . ; Get hospital location data
 . S HL=$P(ROC0,"^",12)
 . ;
 . ; Get Pats User data
 . S INFOBY=+$P(ROC0,"^",6),ENTBY=+$P(ROC0,"^",7)
 . I 'ENTBY S ENTBY=INFOBY,EDITEBY=1
 . I 'INFOBY S INFOBY=ENTBY,EDITIBY=1
 . I 'INFOBY D ERROC^QACI2A(OLDROC,"INFO TAKEN BY and ENTERED BY are both NULL")
 . D:INFOBY
 .. I '$D(^VA(200,INFOBY,0)) D ERROC^QACI2A(OLDROC,"INFO TAKEN BY pointer "_+INFOBY_" is invalid") Q
 .. ; build data for pats_user table
 .. S PATSERR=0 D USERDATA^QACI2B(PARENT,INFOBY,"U",QACI0,.PATSERR,.PATSCNT)
 .. I PATSERR D ERROC^QACI2A(OLDROC,"INFO TAKER has invalid data--see USER on ref data report") Q
 . I ENTBY,ENTBY'=INFOBY D
 .. I '$D(^VA(200,ENTBY,0)) D ERROC^QACI2A(OLDROC,"ENTERED BY pointer "_+ENTBY_" is invalid") Q
 .. ; build data for pats_user table
 .. S PATSERR=0 D USERDATA^QACI2B(PARENT,ENTBY,"U",QACI0,.PATSERR,.PATSCNT)
 .. I PATSERR D ERROC^QACI2A(OLDROC,"ENTERED BY has invalid data--see USER on ref data report") Q
 . ;
 . ; If telephone no.is null but name of contact is not, set telephone toa single space.
 . S PHONE=$P(ROC0,"^",9),PHDESC=$P(ROC0,"^",8)
 . I PHONE]"",$$TXTERR^QACI2C(PHONE,30) D ERROC^QACI2A(OLDROC,"TELEPHONE NO. too long or contains control characters")
 . I PHDESC]"",$$TXTERR^QACI2C(PHDESC,30) D ERROC^QACI2A(OLDROC,"NAME OF CONTACT too long or contains control characters")
 . I PHDESC]"",PHONE="" S PHONE=" "
 . ;
 . ; Get resolution date
 . S RESDATE=$P(ROC7,"^") I RESDATE]"" D
 .. D DT^DILF("X",$P(ROC7,"^"),.RESDATE)
 .. I RESDATE>0 S RESDATE=$$FMTE^XLFDT(RESDATE,5)
 .. I RESDATE'?1.2N1"/"1.2N1"/"4N D ERROC^QACI2A(OLDROC,"DATE RESOLVED is invalid")
 .. Q
 . ;
 . ; Get ROC Status
 . S STATUS=$P(ROC7,"^",2) I STATUS'="O",STATUS'="C" D ERROC^QACI2A(OLDROC,"STATUS not set to either Open or Closed")
 . ;
 . ; Get Congressional Contact
 . S CC=$P(ROC0,"^",13),CCNAME=""
 . I CC]"" D
 .. I '$D(^QA(745.4,+CC,0)) D ERROC^QACI2A(OLDROC,"CONGRESSIONAL CONTACT pointer "_+CC_" is invalid") Q
 .. S CCNAME=$P($G(^QA(745.4,+CC,0)),"^") S:CCNAME="" CCNAME="** no name **"
 .. I $D(^XTMP("QACMIGR","CC","E",+CC)) D ERROC^QACI2A(OLDROC,"CONGRESSIONAL CONTACT "_CCNAME_" invalid--see ref data report")
 .. Q
 . ;
 . ; Get 'Is internal appeal?' flag
 . S INTAPPL=$P(ROC2,"^",7),INTAPPL=$S(INTAPPL="Y":1,1:0)
 . ;
 . ; Get Eligibility Status and Category at time ROC was entered
 . D ELIGCAT^QACI2B(.ELIGSTAT,.CATEGORY,ROC0)
 . ;
 . ; Get rollup status
 . S RLUPSTAT=0 I $P($G(^QA(745.1,ROCIEN,7)),"^",6)=3 S RLUPSTAT=1
 . ;
 . ; Build Issue Text and Resolution Text into output global
 . N RESERR
 . D BLDTXT^QACI2C(ROCNO,ROCIEN,QACI0,.ROCCNT,.RESERR,.EDITITXT,.EDITRTXT)
 . ;
 . ; If not called from ^QACI0, Build data for report of fields changed for migration.
 . I 'QACI0,(EDITEBY+EDITIBY+EDITDIV+EDITITXT+EDITRTXT)>0 D
 .. Q:$D(^XTMP("QACMIGR","ROC","E",OLDROC_" "))
 .. S ^XTMP("QACMIGR","ROC","C",OLDROC_" ")=EDITEBY_"^"_EDITIBY_"^"_EDITDIV_"^"_EDITITXT_"^"_EDITRTXT
 .. Q
 . ; Build main ROC data - if called from ^QACI0, just set node.
 . I QACI0 S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",1)=""
 . E  S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",1)=ROCNO_"^MAIN^"_CONDATE_"^"_DFN_"^"_INFOBY_"^"_ENTBY_"^"_TS_"^"_CCNAME_"^"_STATUS_"^"_STATION_"^"_RESDATE_"^"_PHDESC_"^"_PHONE_"^"_CE_"^"_INTAPPL_"^"_ELIGSTAT_"^"_CATEGORY_"^"_RLUPSTAT_"^"
 . ;
 . ; Build Issue Code combinations into output global
 . S ISSERR=$$ENISS^QACI2D(ROCIEN,ROCNO,OLDROC,QACI0,.ROCCNT,.RESERR,HL,PARENT,STATION,.PATSCNT)
 . I ISSERR K ^XTMP("QACMIGR","ROC","U",ROCNO_" ")
 . ; Build Methods of Contact into output global
 . S (MOC,MOCSTR)=""
 . S X=$P(ROC0,"^",11)
 . I X]"" S MOC=$G(MOC(X)) I MOC="" D ERROC^QACI2A(OLDROC,"SOURCE OF CONTACT is invalid")
 . I MOC]"" S MOCSTR=MOC_"^"
 . F I=0:0 S I=$O(^QA(745.1,ROCIEN,12,I)) Q:'I  S X=$P($G(^(I,0)),"^") D:X]""
 .. S MOC=$G(MOC(X))
 .. I MOC="" D ERROC^QACI2A(OLDROC,"SOURCE(S) OF CONTACT are invalid") Q
 .. S MOCSTR=MOCSTR_MOC_"^" Q
 . I MOCSTR]"" D
 .. ; If called from ^QACI0, we don't need to save data
 .. Q:QACI0
 .. Q:$D(^XTMP("QACMIGR","ROC","E",OLDROC_" "))
 .. S ROCCNT=ROCCNT+1
 .. S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT)=ROCNO_"^MOC^"_MOCSTR
 .. Q
 . I $D(^XTMP("QACMIGR","ROC","E",OLDROC_" ")) K ^XTMP("QACMIGR","ROC","U",ROCNO_" ") Q
 . S PATSCNT("ROC")=PATSCNT("ROC")+1
 . Q
 Q
 ;
 ;
