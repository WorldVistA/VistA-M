GMPLUTL3 ; SLC/JST/JVS/TC -- PL Utilities (CIRN)           ;08/22/12  08:50
 ;;2.0;Problem List;**14,15,19,25,26,36,42**;Aug 25, 1994;Build 46
 ;
 ; External References
 ;   DBIA  5699  $$ICDDATA^ICDXCODE
 ;
 ; This routine is primarily called by CIRN for use
 ; in HL7 (RGHOPL), and Historical Load (RGHOPLB),
 ; record creation.
 ;
 ; NOTE: This routine DOES NOT NEW the variables
 ;       that are set below.
 ;
CALL0(GMPLZ) ; Call 0 - Get Node 0
 N GMPLCOND I $P($G(^AUPNPROB(GMPLZ,1)),"^",2)="H" S GMPLCOND="H" D CLEAR Q
 I '$D(^AUPNPROB(GMPLZ,0)) D CLEAR Q
 D NODE0
 Q
 ;
CALL1(GMPLZ) ; Call 1 - Get Node 1
 N GMPLCOND I $P($G(^AUPNPROB(GMPLZ,1)),"^",2)="H" S GMPLCOND="H" D CLEAR Q
 I '$D(^AUPNPROB(GMPLZ,0)) D CLEAR Q
 D NODE1
 Q
 ;
CALL2(GMPLZ) ; Call 2 - Get both Node 0 and Node 1
 I $P($G(^AUPNPROB(GMPLZ,1)),"^",2)="H" S GMPLCOND="H" D CLEAR Q
 I '$D(^AUPNPROB(GMPLZ,0)) D CLEAR Q
 D NODE0,NODE1
 Q
 ;
NODE0 ; Set Node 0 data variables
 N GMPLZ0
 S GMPLZ0=$G(^AUPNPROB(GMPLZ,0))
 ;   Diagnosis
 S GMPLICD=$P(GMPLZ0,U)
 ;   Patient Name
 S GMPLPNAM=$P(GMPLZ0,U,2)
 ;   Date Last Modifed
 S GMPLDLM=$P(GMPLZ0,U,3)
 ;   Provider Narrative
 S GMPLTXT=$P(GMPLZ0,U,5)
 ;   Status
 S GMPLSTAT=$P(GMPLZ0,U,12)
 ;   Date of Onset
 S GMPLODAT=$P(GMPLZ0,U,13)
 ;   Date Entered
 S:'GMPLODAT GMPLODAT=$P(GMPLZ0,U,8)
 Q
 ;
NODE1 ; Set Node 1 data variables
 N GMPLZ1
 S GMPLZ1=$G(^AUPNPROB(GMPLZ,1))
 ;   Problem
 S GMPLLEX=$P(GMPLZ1,U)
 ;   Condition
 S GMPLCOND=$P(GMPLZ1,U,2)
 ;   Recording Provider
 S GMPLPRV=$P(GMPLZ1,U,4)
 ;   Responsible Provider
 S:'GMPLPRV GMPLPRV=$P(GMPLZ1,U,5)
 ;   Date Resolved
 S GMPLXDAT=$P(GMPLZ1,U,7)
 ;   Priority
 S GMPLPRIO=$P(GMPLZ1,U,14)
 Q
 ;
CLEAR ; Set Variables Equal to Null
 S (GMPLZ0,GMPLICD,GMPLPNAM,GMPLDLM,GMPLTXT,GMPLSTAT,GMPLODAT)=""
 S (GMPLZ1,GMPLLEX,GMPLPRV,GMPLXDAT,GMPLPRIO,GMPLCOND)=""
 Q
MOD(DFN) ; Return the Date the Patients Problem List was Last Modified
 Q +$O(^AUPNPROB("MODIFIED",DFN,0))
LIST ; Returns list of Problems for Patient
 ;
 ;   Input   GMPDFN  Pointer to Patient file #2
 ;           GMPCOMP Display Comments 1/0
 ;           GMTSTAT Status A/I/""
 ;
 ;   Output  GMPL    Array, passed by reference
 ;           GMPL(#)
 ;             Piece 1:  Pointer to Problem #9000011
 ;                   2:  Status
 ;                   3:  Provider Narrative
 ;                   4:  ICD code
 ;                   5:  Date of Onset
 ;                   6:  Date Last Modified
 ;                   7:  Service Connected
 ;                   8:  Special Exposures
 ;                   9:  Priority
 ;                  10:  Transcribed Problem or not
 ;                  11:  SNOMED-CT Concept code
 ;                  12:  SNOMED-CT Designation code
 ;                  13:  ICD Coding System (ex: ICD-10-CM="10D", ICD-9-CM="ICD")
 ;       GMPL(1,"ICDD")  ICD Description
 ;           GMPL(#,C#)  Comments
 ;           GMPL(0)     Number of Problems Returned
 ;
 N CNT,NUM,GMPLIST,GMPLVIEW,GMPARAM,GMPTOTAL
 Q:$G(GMPDFN)'>0  S CNT=0
 S GMPARAM("QUIET")=1,GMPARAM("REV")=$P($G(^GMPL(125.99,1,0)),U,5)="R"
 S GMPLVIEW("ACT")=GMPSTAT,GMPLVIEW("PROV")=0,GMPLVIEW("VIEW")=""
 D GETPLIST^GMPLMGR1(.GMPLIST,.GMPTOTAL,.GMPLVIEW)
 F NUM=0:0 S NUM=$O(GMPLIST(NUM)) Q:NUM'>0  D
 . N GMPL0,GMPL1,GMPL800,GMPL802,ICD,ICDD,IFN,LASTMOD,ONSET,SC,SCS,SCTC,SCTD,SP,ST,GMPLCSYS,GMPLDT
 . S IFN=+GMPLIST(NUM) Q:IFN'>0
 . S GMPL0=$G(^AUPNPROB(IFN,0)),GMPL1=$G(^(1)),GMPL800=$G(^(800)),GMPL802=$G(^(802)),CNT=CNT+1
 . S GMPLDT=$S(+$P(GMPL802,U,1):$P(GMPL802,U,1),1:$P(GMPL0,U,8)),GMPLCSYS=$S($P(GMPL802,U,2)]"":$P(GMPL802,U,2),1:$$SAB^ICDEX($$CSI^ICDEX(80,+GMPL0),GMPLDT))
 . S ICD=$P($$ICDDATA^ICDXCODE(GMPLCSYS,+GMPL0,GMPLDT,"I"),U,2),LASTMOD=$P(GMPL0,U,3)
 . S ST=$P(GMPL0,U,12),ONSET=$P(GMPL0,U,13)
 . S SC=$S(+$P(GMPL1,U,10):"SC",$P(GMPL1,U,10)=0:"NSC",1:"")
 . D SCS^GMPLX1(IFN,.SCS) S SP=$G(SCS(3))
 . S SCTC=$P(GMPL800,U),SCTD=$P(GMPL800,U,2)
 . I +SCTC'>0&(+SCTD'>0) S ICDD=$$ICDDESC^GMPLUTL2(ICD,GMPLDT,GMPLCSYS)
 . S GMPL(CNT)=IFN_U_ST_U_$$PROBTEXT^GMPLX(IFN)_U_ICD_U_ONSET_U_LASTMOD_U_SC_U_SP_U_$S($P(GMPL1,U,14)="A":"*",1:"")_U_$S('$P($G(^GMPL(125.99,1,0)),U,2):"",$P(GMPL1,U,2)'="T":"",1:"$")_U_SCTC_U_SCTD_U_GMPLCSYS
 . I $L($G(ICDD)) S GMPL(CNT,"ICDD")=ICDD
 . I $G(GMPCOMM) D
 . . N FAC,NIFN,NOTE,NOTECNT
 . . S NOTECNT=0,FAC=0
 . . F  S FAC=$O(^AUPNPROB(IFN,11,FAC)) Q:+FAC'>0  D
 . . . S NIFN=0
 . . . F  S NIFN=$O(^AUPNPROB(IFN,11,FAC,11,NIFN)) Q:NIFN'>0  D
 . . . . S NOTE=$P($G(^AUPNPROB(IFN,11,FAC,11,NIFN,0)),U,3)
 . . . . S NOTECNT=NOTECNT+1,GMPL(CNT,NOTECNT)=NOTE
 S GMPL(0)=CNT
 Q
