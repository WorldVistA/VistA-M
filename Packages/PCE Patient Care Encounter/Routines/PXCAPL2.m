PXCAPL2 ;ISL/dee & LEA/Chylton - Translates data from the PCE Device Interface for "DIAGNOSIS/PROBLEM" into a call to update Problem List ;6/6/05
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**33,115,130,168**;Aug 12, 1996;Build 14
 Q
 ;   PXCADXPL  Copy of a Problem node of the PXCA array
 ;   PXCAPRV   Pointer to the provider (200)
 ;   PXCAINDX  Count of the number of problems for one provider
 ;   PXCAPL    The parameter array passed to Problem List
 ;   PXCARES   The result back from Problem List
 ;   PXCANUMB  Count of the total number of problems
 ;
PROBLIST ;Problem List
 Q:'$D(^AUPNPROB)!($T(UPDATE^GMPLUTL)="")
 N PXCAPRV,PXCAINDX,PXCANUMB
 S PXCANUMB=0
 S PXCAPRV=""
 F  S PXCAPRV=$O(PXCA("DIAGNOSIS/PROBLEM",PXCAPRV)) Q:PXCAPRV'>0  D
 . S PXCAINDX=0
 . F  S PXCAINDX=$O(PXCA("DIAGNOSIS/PROBLEM",PXCAPRV,PXCAINDX)) Q:PXCAINDX']""  D
 .. S PXCANUMB=PXCANUMB+1
 .. ;Quit if there is an error in this node
 .. Q:$D(PXCA("ERROR","DIAGNOSIS/PROBLEM",PXCAPRV,PXCAINDX))
 .. N PXCADXPL,PXCAPL,PXCARES
 .. S PXCADXPL=PXCA("DIAGNOSIS/PROBLEM",PXCAPRV,PXCAINDX)
 .. S PXCAPL("COMMENT")=$P($G(PXCA("DIAGNOSIS/PROBLEM",PXCAPRV,PXCAINDX,"NOTE")),"^",1)
 .. ;Quit if this is not a problem
 .. Q:"^^^"[$P(PXCADXPL,"^",5,8)&(PXCAPL("COMMENT")="")
 .. S PXCAPL("PATIENT")=PXCAPAT
 .. S PXCAPL("PROVIDER")=PXCAPRV
 .. S PXCAPL("LOCATION")=PXCAHLOC
 .. S PXCAPL("DIAGNOSIS")=$P(PXCADXPL,"^",1)
 .. S PXCAPL("LEXICON")=$P(PXCADXPL,"^",3)
 .. S PXCAPL("PROBLEM")=$P(PXCADXPL,"^",4)
 .. S PXCAPL("STATUS")=$P(PXCADXPL,"^",6)
 .. S PXCAPL("ONSET")=$P(PXCADXPL,"^",7)
 .. S PXCAPL("RESOLVED")=$P(PXCADXPL,"^",8)
 .. S PXCAPL("SC")=$P(PXCADXPL,"^",9)
 .. S PXCAPL("AO")=$P(PXCADXPL,"^",10)
 .. S PXCAPL("IR")=$P(PXCADXPL,"^",11)
 .. S PXCAPL("EC")=$P(PXCADXPL,"^",12)
 .. ;Add MST & HNC
 .. S PXCAPL("MST")=$P(PXCADXPL,"^",15)
 .. S PXCAPL("HNC")=$P(PXCADXPL,"^",16)
 .. S PXCAPL("CV")=$P(PXCADXPL,"^",17)
 .. S PXCAPL("SHAD")=$P(PXCADXPL,"^",18)
 .. S PXCAPL("NARRATIVE")=$P(PXCADXPL,"^",13)
 .. S:'PXCAPL("PROBLEM") PXCAPL("RECORDED")=$P($P(PXCA("ENCOUNTER"),"^"),".") ;Only if new problem
 .. D UPDATE^GMPLUTL(.PXCAPL,.PXCARES)
 .. I $G(PXCARES)'>0 D
 ... I PXCARES(0)'="Duplicate problem" S PXKERROR("PL",PXCANUMB,0,0)="Problem Not Stored = "_$G(PXCARES(0))_"  For Provider = "_PXCAPRV_"  and index = "_PXCAINDX
 ... S PXCA("WARNING","DIAGNOSIS/PROBLEM",PXCAPRV,PXCAINDX,0)="PROBLEM Not Stored^"_$G(PXCARES(0))
 .. E  I $D(^TMP("PXK",$J,"POV",PXCADNUM(PXCAPRV,PXCAINDX),0,"AFTER"))#2 S $P(^("AFTER"),"^",16)=PXCARES
 Q
 ;
