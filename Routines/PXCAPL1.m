PXCAPL1 ;ISL/dee & LEA/Chylton - Translates data from the PCE Device Interface into a call to update Problem List ;6/6/05
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**33,115,130,168**;Aug 12, 1996;Build 14
 Q
 ;   PXCAPROB  Copy of a Problem node of the PXCA array
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
 F  S PXCAPRV=$O(PXCA("PROBLEM",PXCAPRV)) Q:PXCAPRV'>0  D
 . S PXCAINDX=0
 . F  S PXCAINDX=$O(PXCA("PROBLEM",PXCAPRV,PXCAINDX)) Q:PXCAINDX']""  D
 .. S PXCANUMB=PXCANUMB+1
 .. Q:$D(PXCA("ERROR","PROBLEM",PXCAPRV,PXCAINDX))
 .. N PXCAPROB,PXCAPL,PXCARES
 .. S PXCAPROB=PXCA("PROBLEM",PXCAPRV,PXCAINDX)
 .. S PXCAPL("PROBLEM")=$P(PXCAPROB,"^",10)
 .. S PXCAPL("NARRATIVE")=$P(PXCAPROB,"^",1)
 .. S PXCAPL("PATIENT")=PXCAPAT
 .. S PXCAPL("STATUS")=$S($P(PXCAPROB,"^",3)="1":"A",$P(PXCAPROB,"^",3)="0":"I",1:"A")
 .. S PXCAPL("PROVIDER")=PXCAPRV
 .. S PXCAPL("LOCATION")=PXCAHLOC
 .. S PXCAPL("SC")=$P(PXCAPROB,"^",5)
 .. S PXCAPL("AO")=$P(PXCAPROB,"^",6)
 .. S PXCAPL("IR")=$P(PXCAPROB,"^",7)
 .. S PXCAPL("EC")=$P(PXCAPROB,"^",8)
 .. ;PX*1*115 Add MST & HNC
 .. S PXCAPL("MST")=$P(PXCAPROB,"^",13)
 .. S PXCAPL("HNC")=$P(PXCAPROB,"^",14)
 .. S PXCAPL("CV")=$P(PXCAPROB,"^",15)
 .. S PXCAPL("SHAD")=$P(PXCAPROB,"^",16)
 .. S PXCAPL("DIAGNOSIS")=$P(PXCAPROB,"^",9)
 .. S PXCAPL("RESOLVED")=$P(PXCAPROB,"^",4)
 .. S PXCAPL("ONSET")=$P(PXCAPROB,"^",2)
 .. S PXCAPL("COMMENT")=$P(PXCAPROB,"^",11)
 .. S PXCAPL("LEXICON")=$P(PXCAPROB,"^",12)
 .. D UPDATE^GMPLUTL(.PXCAPL,.PXCARES)
 .. I $G(PXCARES)'>0 D
 ... I PXCARES(0)'="Duplicate problem" S PXKERROR("PL",PXCANUMB,0,0)="Problem Not Stored = "_$G(PXCARES(0))_"  For Provider = "_PXCAPRV_"  and index = "_PXCAINDX
 ... S PXCA("WARNING","PROBLEM",PXCAPRV,PXCAINDX,0)="PROBLEM Not Stored^"_$G(PXCARES(0))
 Q
 ;
