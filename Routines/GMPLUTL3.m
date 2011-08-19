GMPLUTL3 ; SLC/JST/JVS -- PL Utilities (CIRN)           ; 04/15/2002
 ;;2.0;Problem List;**14,15,19,25,26**;Aug 25, 1994
 ;
 ; External References
 ;   None
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
