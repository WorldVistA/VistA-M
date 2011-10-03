TIUP134 ;SLC/RMO - Post-Install for TIU*1*134 ;6/6/02@09:51:20
 ;;1.0;Text Integration Utilities;**134**;Jun 20, 1997
 ;
EN ;Entry point to queue a job to automatically link the missing VISIT
 ;field for a date range of documents
 N TIUBEGDT,TIUENDT,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 ;
 W !!,"PATCH TIU*1*134"
 W !!,"Automatically Link the missing VISIT field for a date range of documents"
 W !!,"Documents must meet the following criteria to be linked:"
 W !,"- Date range cannot be before 10/1/98 or after 7/31/02"
 W !,"- Entry Date/Time is within the selected date range"
 W !,"- No visit has been associated with the document"
 W !,"- A visit exists to be associated with the document"
 W !,"- The capture method is direct or remote"
 W !,"- The status is uncosigned or completed or amended"
 W !,"- The document is under the progress notes class or consults"
 W !,"- The document has a signature date/time"
 W !,"- Workload data should be collected for the document"
 W !!,"  Special Note about Parameters:",!
 W !,"  The 'ASK DX/CPT ON ALL OPT VISITS' TIU Document parameter"
 W !,"  is not date sensitive so collecting workload is based on"
 W !,"  the value of this parameter at the time this routine is"
 W !,"  invoked rather than at the time the visit was created."
 ;
 ;Ask date range
 I '$$ASKRNG(.TIUBEGDT,.TIUENDT) G ENQ
 ;
 ;Set variables
 S (ZTSAVE("TIUBEGDT"),ZTSAVE("TIUENDT"))=""
 S ZTRTN="LNKRNG^TIUP134",ZTIO="",ZTSAVE("DUZ")=""
 S ZTDESC="Automatically link missing VISIT field for File #8925 - Patch 134"
 W ! D ^%ZTLOAD
 I $G(ZTSK) D
 . W !!,"A task has been queued in the background and a bulletin will be sent"
 . W !,"to you upon completion of the task or if the task is stopped."
 . W !,"Please only run one date range at a time."
 . W !!,"The task number is "_$G(ZTSK)_"."
ENQ Q
 ;
ASKRNG(BEGDT,ENDT) ;Prompt for date range
 ; Input  -- None
 ; Output -- 1=Successful and 0=Failure
 ;           BEGDT Begin Date
 ;           ENDT  End Date
 N DIRUT,DTOUT,DUOUT,Y
 W !!,"Please specify a date range:"
 S BEGDT=+$$READ^TIUU("DA^"_2981001_":"_3020731_":E","   Beginning: ")
 I +$D(DIRUT)!(BEGDT'>0) G ASKRNGQ
 S ENDT=+$$READ^TIUU("DA^"_BEGDT_":"_3020731_":E","        Thru: ")_"."_235959
 I +$D(DIRUT)!(ENDT'>0) G ASKRNGQ
 S Y=1
ASKRNGQ Q +$G(Y)
 ;
LNKRNG ;Entry point to automatically link a document to a visit for
 ;a specified date range
 ; Input  -- TIUBEGDT Begin Date
 ;           TIUENDT  End Date
 ; Output -- ^XTMP("TIUP134", Global
 N TIUDA,TIUDT,TIURSTDT,TIUS
 ;
 ;Exit if required variables are not defined
 I '$G(TIUBEGDT)!('$G(TIUENDT)) G LNKRNGQ
 ;
 ;Initialize re-start if check point exists
 I +$G(^XTMP("TIUP134","CHKPT")) D
 . S TIURSTDT=$P($G(^XTMP("TIUP134","CHKPT")),U,1)
 ELSE  D
 . ;Initialize ^XTMP("TIUP134" if not re-start
 . S ^XTMP("TIUP134",0)=$$FMADD^XLFDT(DT,90)_U_DT
 . S ^XTMP("TIUP134","CNT","EX")=0 F TIUS=1:1:3 S ^XTMP("TIUP134","CNT","EX",TIUS)=0
 . S ^XTMP("TIUP134","CNT","LNK")=0
 . S ^XTMP("TIUP134","CNT","TOT")=0
 . S ^XTMP("TIUP134","CHKPT")=U_TIUBEGDT_U_TIUENDT
 K ^XTMP("TIUP134","STOP")
 S ^XTMP("TIUP134","T0")=$$NOW^XLFDT
 ;
 ;Loop through Entry Date/Time of documents by specified date range
 S TIUDT=$S($G(TIURSTDT):TIURSTDT,1:TIUBEGDT)
 F  S TIUDT=$O(^TIU(8925,"F",TIUDT)) Q:'TIUDT!(TIUDT>TIUENDT)!($G(ZTSTOP))  D
 . ;Loop through documents for Entry Date/Time
 . S TIUDA=0
 . F  S TIUDA=+$O(^TIU(8925,"F",TIUDT,TIUDA)) Q:'TIUDA  D LNKONE(TIUDA)
 . ;Set check point for Entry Date/Time
 . S $P(^XTMP("TIUP134","CHKPT"),U,1)=TIUDT
 . ;Check if user requested to stop task
 . I $$S^%ZTLOAD S ZTSTOP=1
 ;
LNKRNGQ ;Send bulletin, re-set check point and clean up variables
 I $G(ZTSTOP) S ^XTMP("TIUP134","STOP")=$$NOW^XLFDT
 S ^XTMP("TIUP134","T1")=$$NOW^XLFDT
 ;
 D MAIL^TIUP134P
 ;
 I '$G(ZTSTOP) S ^XTMP("TIUP134","CHKPT")=""
 K TIUBEGDT,TIUENDT,TIURSTDT
 Q
 ;
LNKONE(TIUDA) ;Entry point to automatically link one document to visit
 ; Input  -- TIUDA    TIU Document file (#8925) IEN
 ; Output -- None
 N TIUEX,TIUMVSTF,TIUVSIT
 ;
 ;Check if document can be linked
 I $D(^TIU(8925,TIUDA,0)),$P(^(0),U,3)'>0,$$CHKDOC(TIUDA) D
 . ;Get visit to associate with document
 . D GETVST(TIUDA,.TIUVSIT,.TIUMVSTF)
 . ;If only one visit update the document with the visit
 . I $G(TIUVSIT)>0,'$G(TIUMVSTF) D
 . . I $G(TIUVSIT),$$UPDVST^TIUPXAP2(TIUDA,TIUVSIT) D
 . . . ;Document linked to visit
 . . . D SETXTMP(TIUDA,,TIUVSIT)
 . . . ;Update kids that are addenda
 . . . D UPDKIDS(TIUDA,TIUVSIT)
 . . ELSE  D
 . . . ;Unable to automatically link - entry in use
 . . . D SETXTMP(TIUDA,2)
 . ELSE  D
 . . ;Unable to automatically link - multiple visits or no matching visit
 . . S TIUEX=$S($G(TIUMVSTF):1,1:3)
 . . D SETXTMP(TIUDA,TIUEX)
 S ^XTMP("TIUP134","CNT","TOT")=+$G(^XTMP("TIUP134","CNT","TOT"))+1
 Q
 ;
CHKDOC(TIUDA) ;Check if document can be auto-linked
 ; Input  -- TIUDA    TIU Document file (#8925) IEN
 ; Output -- 1=Can be linked and 0=Cannot be linked
 N TIUD0,TIUDPRM,Y
 ;
 ;Set variables
 S Y=0
 S TIUD0=$G(^TIU(8925,TIUDA,0))
 D DOCPRM^TIULC1(+TIUD0,.TIUDPRM)
 ;
 ;Capture method must be direct or remote
 I ("^D^R^")'[(U_$P($G(^TIU(8925,TIUDA,13)),U,3)_U) G CHKDOCQ
 ;
 ;Status must be uncosigned or completed or amended
 I ("^6^7^8^")'[(U_$P(TIUD0,U,5)_U) G CHKDOCQ
 ;
 ;Document must be signed
 I '+$G(^TIU(8925,TIUDA,15)) G CHKDOCQ
 ;
 ;Document cannot be a component
 I $P($G(TIUDPRM(0)),U,4)="CO" G CHKDOCQ
 ;
 ;Document cannot be associated with a disposition location
 I +$O(^PX(815,1,"DHL","B",+$P($G(^TIU(8925,TIUDA,12)),U,11),0)) G CHKDOCQ
 ;
 ;Document must be under progress notes class or consults
 I '+$$ISA^TIULX(+TIUD0,3),'+$$ISA^TIULX(+TIUD0,+$$CLASS^TIUCNSLT) G CHKDOCQ
 ;
 ;Check if workload should be entered and set auto-link flag to yes
 I $$WORKOK^TIUPXAP1(TIUDA),$$CHKWKL^TIUPXAP2(TIUDA,.TIUDPRM) S Y=1
CHKDOCQ Q +$G(Y)
 ;
GETVST(TIUDA,TIUVSIT,TIUMVSTF) ;Get visit to associate with document
 ; Input  -- TIUDA    TIU Document file (#8925) IEN
 ; Output -- TIUVSIT  Visit file (#9000010) IEN
 ;           TIUMVSTF Multiple Visit Flag
 ;                    1=Multiple Visits
 ;
 N TIUD0,TIUDFN,TIUEDT,TIUHL,TIUVSITS,TIUVSTR
 ;
 ;Set variables
 S TIUD0=$G(^TIU(8925,TIUDA,0))
 S TIUDFN=$P(TIUD0,U,2),TIUEDT=$P(TIUD0,U,7)
 S TIUHL=$P($G(^TIU(8925,TIUDA,12)),U,11)
 S TIUVSTR=TIUHL_";"_TIUEDT_";"_$P(TIUD0,U,13)
 ;
 ;Check if document is an addendum, if it is use visit of parent
 I +$$ISADDNDM^TIULC1(TIUDA) D  G GETVSTQ
 . I $D(^TIU(8925,+$P(TIUD0,U,6),0)),$P(^(0),U,3)>0 S TIUVSIT=$P(^(0),U,3)
 ;
 ;Check if a document has already been entered for the Vstring,
 ;if it has use the visit in the AVSTRV cross-reference
 I +$G(TIUVSTR),+$O(^TIU(8925,"AVSTRV",+TIUDFN,TIUVSTR,0))>0 D  G GETVSTQ:$G(TIUVSIT)>0
 . S TIUVSIT=+$O(^TIU(8925,"AVSTRV",+TIUDFN,TIUVSTR,0))
 . I $P($G(^AUPNVSIT(+TIUVSIT,0)),U,5)'=TIUDFN S TIUVSIT=""
 ;
 ;Check PCE for a visit
 S TIUVSITS=$$GETENC^PXAPI(TIUDFN,TIUEDT,TIUHL)
 I TIUVSITS>0 S TIUVSIT=+TIUVSITS
 ;
 ;Set a flag if multiple visits
 I $P(TIUVSITS,U,2)'="" S TIUMVSTF=1
GETVSTQ Q
 ;
SETXTMP(TIUDA,TIUEX,TIUVSIT) ;Set ^XTMP for entries processed
 ; Input  -- TIUDA    TIU Document file (#8925) IEN
 ;           TIUEX    Unable to automatically link Exception types:  (Optional)
 ;                    1=Multiple Visits
 ;                    2=Entry in Use
 ;                    3=No Matching Visit
 ;           TIUVSIT  Visit file (#9000010) IEN  (Optional)
 ; Output -- Set ^XTMP("TIUP134","LNK",TIUDA)=
 ;               1st piece= 1=Linked and 0=Not Linked
 ;               2nd piece= Exception type if not linked
 ;               3rd piece= Visit file (#9000010) IEN if linked
 I $G(TIUEX) D
 . S ^XTMP("TIUP134","LNK",TIUDA)=0_U_$G(TIUEX)
 . S ^XTMP("TIUP134","CNT","EX",TIUEX)=+$G(^XTMP("TIUP134","CNT","EX",TIUEX))+1
 . S ^XTMP("TIUP134","CNT","EX")=+$G(^XTMP("TIUP134","CNT","EX"))+1
 ELSE  D
 . S ^XTMP("TIUP134","LNK",TIUDA)=1_U_U_$G(TIUVSIT)
 . S ^XTMP("TIUP134","CNT","LNK")=+$G(^XTMP("TIUP134","CNT","LNK"))+1
 Q
 ;
UPDKIDS(TIUDA,TIUVSIT) ;Update visit for kids that are addenda
 ; Input  -- TIUDA    TIU Document file (#8925) IEN
 ;           TIUVSIT  Visit file (#9000010) IEN
 ; Output -- None
 N TIUKID
 S TIUKID=0
 F  S TIUKID=$O(^TIU(8925,"DAD",TIUDA,TIUKID)) Q:'TIUKID  D
 . I +$$ISADDNDM^TIULC1(TIUKID),$P($G(^TIU(8925,TIUKID,0)),U,3)'>0 D
 . . I $$UPDVST^TIUPXAP2(TIUKID,TIUVSIT) D
 . . . D SETXTMP(TIUKID,,TIUVSIT)
 . . ELSE  D
 . . . D SETXTMP(TIUKID,2)
 Q
