DGMSE ;QLB/PJH,AJB Utilities (continued); 02/01/2012
 ;;5.3;Registration;**797**;08/13/93;Build 24
 Q
 ;
 ;DBIA -5354
 ;
 ;API for clinical reminders to get military service information.
 ;
 ;
MSDATA(DFN,NEPS,ENTRYDTA,MSDATA) ;
 ;Return data for all military service episodes.
 ;Service Entry Dates are required fields.
 ;Gets new ESR data if present from multiple node (.3216)
 N DA,DGX,ENTRYDT,NODE,SEPDT
 S NEPS=0,ENTRYDT=""
 F  S ENTRYDT=$O(^DPT(DFN,.3216,"B",ENTRYDT)) Q:ENTRYDT=""  D
 . S DA=0
 . F  S DA=$O(^DPT(DFN,.3216,"B",ENTRYDT,DA)) Q:DA=""  D
 .. S NEPS=NEPS+1
 .. S NODE=$G(^DPT(DFN,.3216,DA,0))
 .. S ENTRYDT=$P(NODE,U,1),SEPDT=$P(NODE,U,2)
 .. S ENTRYDTA(ENTRYDT)=NEPS
 .. S MSDATA(NEPS,"DATE")=$S(SEPDT="":ENTRYDT,1:SEPDT)
 .. S MSDATA(NEPS,"ENTRY DATE")=ENTRYDT
 .. S MSDATA(NEPS,"SEPARATION DATE")=SEPDT
 .. S MSDATA(NEPS,"BRANCH")=$$EXTERNAL^DILFD(2,.325,"",$P(NODE,U,3))
 .. S MSDATA(NEPS,"SERVICE COMPONENT")=$$EXTERNAL^DILFD(2,.32911,"",$P(NODE,U,4))
 .. S MSDATA(NEPS,"DISCHARGE TYPE")=$$EXTERNAL^DILFD(2,.324,"",$P(NODE,U,6))
 I NEPS>0 Q
 ;Gets data from non-multiple node (.32) only if data does not exist
 ;in the multiple.
 I '$D(^DPT(DFN,.32)) Q
 S NODE=$G(^DPT(DFN,.32)),NODE("SC")=$G(^DPT(DFN,.3291))
 F DGX=7,12,17 D
 . S ENTRYDT=$P(NODE,U,(DGX-1))
 . I ENTRYDT="" Q
 . S NEPS=NEPS+1
 . S ENTRYDTA(ENTRYDT)=NEPS
 . S SEPDT=$P(NODE,U,DGX)
 . S MSDATA(NEPS,"DATE")=$S(SEPDT="":ENTRYDT,1:SEPDT)
 . S MSDATA(NEPS,"ENTRY DATE")=ENTRYDT
 . S MSDATA(NEPS,"SEPARATION DATE")=SEPDT
 . S MSDATA(NEPS,"BRANCH")=$$EXTERNAL^DILFD(2,.325,"",$P(NODE,U,(DGX-2)))
 . S MSDATA(NEPS,"SERVICE COMPONENT")=$$EXTERNAL^DILFD(2,.32911,"",$P(NODE("SC"),U,$S(DGX=7:1,DGX=12:2,DGX=17:3)))
 . S MSDATA(NEPS,"DISCHARGE TYPE")=$$EXTERNAL^DILFD(2,.324,"",$P(NODE,U,(DGX-3)))
 Q
 ;
 ;
OEIF(BDT,EDT,LSUB) ;Return a list of patient with OEF/OIF/UNK service in the
 ;date range specified by BDT to EDT.
 N DA,DFN,FDATE,SLOC,TDATE
 K ^TMP($J,LSUB)
 S TDATE=BDT-.1
 F  S TDATE=$O(^DPT("ALOEIF",TDATE)) Q:TDATE=""  D
 . S FDATE=0
 . F  S FDATE=$O(^DPT("ALOEIF",TDATE,FDATE)) Q:(FDATE>EDT)!(FDATE="")  D
 .. S SLOC=""
 .. F  S SLOC=$O(^DPT("ALOEIF",TDATE,FDATE,SLOC)) Q:SLOC=""  D
 ... S DFN=""
 ... F  S DFN=$O(^DPT("ALOEIF",TDATE,FDATE,SLOC,DFN)) Q:DFN=""  D
 .... S DA=""
 .... F  S DA=$O(^DPT("ALOEIF",TDATE,FDATE,SLOC,DFN,DA)) Q:DA=""  D
 ..... S ^TMP($J,LSUB,DFN,FDATE,TDATE,SLOC,DA)=""
 Q
