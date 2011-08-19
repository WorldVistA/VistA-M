TIUP146 ;SLC/RMO - Post-Install for TIU*1*146 ;9/9/02@09:51:20
 ;;1.0;Text Integration Utilities;**146**;Jun 20, 1997
 ;
EN ;Entry point to queue a job to identify documents linked to a
 ;different patient's visit
 N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 ;
 W !!,"PATCH TIU*1*146"
 W !!,"Search ALL entries in the TIU Document file (#8925) to identify"
 W !,"documents linked to a different patient's visit.",!
 ;
 ;Set variables
 S ZTRTN="EN1^TIUP146",ZTIO="",ZTSAVE("DUZ")=""
 S ZTDESC="Search TIU Documents - Patch 146"
 D ^%ZTLOAD
 I $G(ZTSK) D
 . W !!,"A task has been queued in the background and a bulletin will be sent"
 . W !,"to you upon completion of the task or if the task is stopped."
 . W !!,"The task number is "_$G(ZTSK)_"."
 Q
 ;
EN1 ;Entry point to identify documents pointing to a different patient's
 ;visit
 ; Input  -- None
 ; Output -- ^XTMP("TIUP146", Global
 N TIUD0,TIUDA,TIUDFN,TIUVSIT,TIURSTDA
 ;
 ;Initialize re-start if check point exists
 I +$G(^XTMP("TIUP146","CHKPT")) D
 . S TIURSTDA=+$G(^XTMP("TIUP146","CHKPT"))
 ELSE  D
 . ;Clean-up ^XTMP("TIUP146")
 . K ^XTMP("TIUP146")
 . ;Initialize ^XTMP("TIUP146" if not re-start
 . S ^XTMP("TIUP146",0)=$$FMADD^XLFDT(DT,90)_U_DT
 . S ^XTMP("TIUP146","CNT","EX")=0
 . S ^XTMP("TIUP146","CNT","TOT")=0
 . S ^XTMP("TIUP146","CHKPT")=""
 K ^XTMP("TIUP146","STOP")
 S ^XTMP("TIUP146","T0")=$$NOW^XLFDT
 ;
 ;Loop through documents
 S TIUDA=$S($G(TIURSTDA):TIURSTDA,1:0)
 F  S TIUDA=+$O(^TIU(8925,TIUDA)) Q:'TIUDA!($G(ZTSTOP))  I $D(^(TIUDA,0)) S TIUD0=^(0) D
 . ;Set variables
 . S TIUDFN=$P(TIUD0,U,2)
 . S TIUVSIT=$P(TIUD0,U,3)
 . ;
 . ;Check if document linked to a different patient's visit
 . I TIUVSIT>0,TIUDFN>0,+$G(^AUPNVSIT(+TIUVSIT,0)),$P(^(0),U,5)'=TIUDFN D SETXTMP(TIUDA,TIUVSIT)
 . S ^XTMP("TIUP146","CNT","TOT")=+$G(^XTMP("TIUP146","CNT","TOT"))+1
 . ;
 . ;Set check point for Document IEN
 . S ^XTMP("TIUP146","CHKPT")=TIUDA
 . ;
 . ;Check if user requested to stop task
 . I $$S^%ZTLOAD S ZTSTOP=1
 ;
 ;Send bulletin, re-set check point and clean up variables
 I $G(ZTSTOP) S ^XTMP("TIUP146","STOP")=$$NOW^XLFDT
 S ^XTMP("TIUP146","T1")=$$NOW^XLFDT
 ;
 D MAIL^TIUP146P
 ;
 I '$G(ZTSTOP) S ^XTMP("TIUP146","CHKPT")=""
 K TIURSTDA
 Q
 ;
SETXTMP(TIUDA,TIUVSIT) ;Set ^XTMP for entries processed
 ; Input  -- TIUDA    TIU Document file (#8925) IEN
 ;           TIUVSIT  VIsit file (#9000010) IEN
 ; Output -- Set ^XTMP("TIUP146","EX",TIUDA)=TIUVSIT
 S ^XTMP("TIUP146","EX",TIUDA)=TIUVSIT
 S ^XTMP("TIUP146","CNT","EX")=+$G(^XTMP("TIUP146","CNT","EX"))+1
 Q
 ;
ENDBI ;Entry point to remove documents pointing to a visit of IEN=1
 ;from ^XTMP
 N C,TIUDA
 W !,"Killing entries in ^XTMP(""TIUP146"",""EX"" that point to Visit IEN=1..."
 S (C,TIUDA)=0
 F  S TIUDA=$O(^XTMP("TIUP146","EX",TIUDA)) Q:'TIUDA  I +$G(^(TIUDA))=1 D
 . W:'(C#1000) "."
 . K ^XTMP("TIUP146","EX",TIUDA)
 . S C=C+1
 W !?1,C," ",$S(C=1:"entry",1:"entries")," removed."
 Q
