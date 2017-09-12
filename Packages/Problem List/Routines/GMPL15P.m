GMPL15P ;SLC/JVS -- Post Install Routine ;3/19/99  11:00
 ;;2.0;Problem List;**15,23**;Aug 25, 1994
 ;
 ; This routine should be removed after installing patch 
 ; GMPL*2*23
 Q
EN ;ENTRY POINT
 ;This will update the new cross reference that was add
 ;by patch GMPL*2*15
 N IEN,DFN,MODIFIED,MODIFIE1,XPDIDTOT
 K ^AUPNPROB("MODIFIED")
 S IEN=0,XPDIDTOT=$P(^AUPNPROB(0),"^",3)
 F  S IEN=$O(^AUPNPROB(IEN)) Q:IEN<1  D
 . ;D UPDATE^XPDID(IEN)
 . S DFN=$P(^AUPNPROB(IEN,0),"^",2)
 . S MODIFIED=$P(^AUPNPROB(IEN,0),"^",3)
 . I '$D(^AUPNPROB("MODIFIED",DFN)) S ^AUPNPROB("MODIFIED",DFN,MODIFIED)="" Q
 . I $D(^AUPNPROB("MODIFIED",DFN)) S MODIFIE1=$O(^AUPNPROB("MODIFIED",DFN,0))  I MODIFIED>MODIFIE1 K ^AUPNPROB("MODIFIED",DFN) S ^AUPNPROB("MODIFIED",DFN,MODIFIED)="" Q
 Q
TASK ;Task the job of creating the initial Cross Reference
 ;
 S ZTRTN="EN^GMPL15P"
 S ZTDESC="Create Problem List X-ref Patch GMPL*2*15"
 S ZTSAVE=("DUZ")
 S ZTDTH=$H
 S ZTIO=""
 D ^%ZTLOAD
 ;
 I $D(ZTSK) D BMES^XPDUTL("Task Number: "_$G(ZTSK))
 I '$D(ZTSK) D BMES^XPDUTL("TASK JOB DID NOT RUN!")
 I '$D(ZTSK) D MES^XPDUTL("Start Task with  D TASK^GMPL15P")
 Q
