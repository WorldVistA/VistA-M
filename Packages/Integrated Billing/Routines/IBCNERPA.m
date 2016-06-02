IBCNERPA ;DAOU/BHS - IBCNE eIV RESPONSE REPORT (cont'd) ;03-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,345,416,528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; eIV - Insurance Verification Interface
 ;
 ; Input from IBCNERP1/2:
 ;  IBCNERTN="IBCNERP1" - Driver rtn
 ;  IBCNESPC("BEGDT")=Start Dt,  IBCNESPC("ENDDT")=End Dt
 ;  IBCNESPC("PYR")=Pyr IEN OR "" for all
 ;  IBCNESPC("PAT")=Pat IEN OR "" for all
 ;  IBCNESPC("TYPE")=A (All Responses) OR M (Most Recent Responses) for
 ;   unique Pyr/Pt pair
 ;  IBCNESPC("SORT")=1 (PyrNm) OR 2 (PatNm)
 ;  IBCNESPC("TRCN")=Trace #^IEN, if non-null, all params null
 ;  IBCNESPC("RFLAG")=Report Flag used to indicate which report is being
 ;   run.  Response Report (O), Inactive Report (1), or Ambiguous
 ;   Report (2).
 ;  IBCNESPC("DTEXP")=Expiration date used in the inactive policy report
 ;  IBOUT="R" for Report format or "E" for Excel format
 ;
 ;  Based on structure of eIV Response File (#365)
 ;  ^TMP($J,IBCNERTN,S1,S2,CT,0) based on ^IBCN(365,DA,0)
 ;    IBCNERTN="IBCNERP1", S1=PyrName(SORT=1) or PatNm(SORT=2),
 ;    S2=PatName(SORT=1) or PyrName(SORT=2), CT=Seq ct
 ;  ^TMP($J,IBCNERTN,S1,S2,CT,1) based on ^IBCN(365,DA,1)
 ;  ^TMP($J,IBCNERTN,S1,S2,2,EBCT) based on ^IBCN(365,DA,2)
 ;    EBCT=E/B IEN (365.02)
 ;  ^TMP($J,IBCNERTN,S1,S2,2,EBCT,NTCT)=based on ^IBCN(365,DA,2,EB,NT)
 ;   NTCT=Notes Ct, may not be Notes IEN, if line wrapped (365.021)
 ;  ^TMP($J,IBCNERTN,S1,S2,2,CNCT) based on ^IBCN(365,DA,3)
 ;   CNCT=Cont Pers IEN (365.03)
 ;  ^TMP($J,IBCNERTN,S1,S2,4,CT)= err txt based on ^IBCN(365,DA,4)
 ;   CT=1/2 if >60 ch long
 ; Must call at one of the entry points, EN3 or EN6
 Q
 ;
EN3(IBCNERTN,IBCNESPC,IBOUT) ; Entry pt.  Calls IBCNERP3
 N IBBDT,IBEDT,IBPY,IBPT,IBTYP,IBSRT,CRT,MAXCNT,IBPXT
 N IBPGC,X,Y,DIR,DTOUT,DUOUT,LIN,IBTRC,IPRF,IBRDT
 S IBBDT=$G(IBCNESPC("BEGDT")),IBEDT=$G(IBCNESPC("ENDDT"))
 S IBPY=$G(IBCNESPC("PYR")),IBPT=$G(IBCNESPC("PAT"))
 S IBTYP=$G(IBCNESPC("TYPE")),IBSRT=$G(IBCNESPC("SORT"))
 S IBTRC=$P($G(IBCNESPC("TRCN")),U,1),(IBPXT,IBPGC)=0
 S IBEXP=$G(IBCNESPC("DTEXP"))
 S IPRF=$G(IBCNESPC("RFLAG"))
 S IBRDT=$$FMTE^XLFDT($$NOW^XLFDT,1)
 ; Determine IO params
 I "^R^E^"'[(U_$G(IBOUT)_U) S IBOUT="R"
 I IOST["C-" S MAXCNT=IOSL-3,CRT=1
 E  S MAXCNT=IOSL-6,CRT=0
 D PRINT^IBCNERP3(IBCNERTN,IBBDT,IBEDT,IBPY,IBPT,IBTYP,IBSRT,.IBPGC,.IBPXT,MAXCNT,CRT,IBTRC,IBEXP,IPRF,IBRDT,IBOUT)
 I $G(ZTSTOP)!IBPXT G EXIT3
 I CRT,IBPGC>0,'$D(ZTQUEUED) D
 . I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
EXIT3 ; Exit pt
 Q
 ;
 ;
EN6(IBCNERTN,IBCNESPC,IBOUT) ; Entry pt.  Calls IBCNERP6
 ;
 ; Init vars
 N CRT,MAXCNT,IBPXT,IBPGC,IBBDT,IBEDT,IBPY,IBSRT,IBDTL
 N X,Y,DIR,DTOUT,DUOUT,LIN,TOTALS
 ;
 S IBBDT=$G(IBCNESPC("BEGDT"))
 S IBEDT=$G(IBCNESPC("ENDDT"))
 S IBPY=$G(IBCNESPC("PYR"))
 S IBDTL=$G(IBCNESPC("DTL"))
 S IBSRT=$G(IBCNESPC("SORT"))
 S (IBPXT,IBPGC)=0
 ;
 ; Determine IO parameters
 I IOST["C-" S MAXCNT=IOSL-3,CRT=1
 E  S MAXCNT=IOSL-6,CRT=0
 ;
 D PRINT^IBCNERP6(IBCNERTN,IBBDT,IBEDT,IBPY,IBDTL,IBSRT,.IBPGC,.IBPXT,MAXCNT,CRT,IBOUT)
 I $G(ZTSTOP)!IBPXT G EXIT6
 I CRT,IBPGC>0,'$D(ZTQUEUED) D
 . I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 ;
EXIT6 ; Exit pt
 Q
 ;
