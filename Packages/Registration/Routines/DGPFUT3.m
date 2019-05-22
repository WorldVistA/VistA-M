DGPFUT3 ;ALB/SAE - PRF UTILITIES CONTINUED ; 6/9/04 5:06pm
 ;;5.3;Registration;**554,951**;Aug 13, 1993;Build 135
 ;     Last Edited: SHRPE/SGM, Aug 22, 2018 18:22
 ;
 Q  ; no direct entry
 ; ICR# TYPE DESCRIPTION
 ;----- ---- ------------------------------------------
 ; 2055 Sup  $$EXTERNAL^DILFD
 ; 2056 Sup  $$GET1^DIQ
 ; 2171 Sup  $$NS^XUAF4
 ;10103 Sup  ^XLFDT: $$FMTE, $$NOW
 ;10060 Sup  File 200 FM Read
 ;
REVIEW(DGPFDA,DGPFHX,DGPFIEN,DGPFOPT,DGPFACT) ; Entry point for review display
 ;
 ; This is the driver routine for redisplaying entry detail to the user
 ; for their review before filing a new or edited PRF Flag or PRF Flag
 ; Assignment record.
 ;
 ; This routine builds the temporary array which is then used to
 ; create the temporary global for review by the user.
 ;
 ; Called from the following options and actions:
 ; Option                    Action                       Calling Routine
 ; RECORD FLAG ASSIGNMENT    ASSIGN FLAG                  AF^DGPFLMA2
 ; RECORD FLAG ASSIGNMENT    EDIT FLAG ASSIGNMENT         EF^DGPFLMA3
 ; RECORD FLAG ASSIGNMENT    CHANGE ASSIGNMENT OWNERSHIP  CO^DGPFLMA4
 ; RECORD FLAG MANAGEMENT    ADD NEW RECORD FLAG          AF^DGPFLF3
 ; RECORD FLAG MANAGEMENT    EDIT RECORD FLAG             EF^DGPFLF5
 ; RECORD FLAG RETRANSMISSION  <no LM action>             RT^DGPFHLF
 ;
 ; Input:
 ;   DGPFDA - data array
 ;        - derived from DGPFA  if called by Flag Assignment transaction
 ;        - derived from DGPFLF if called by Flag Management transaction
 ;   DGPFHX - history array
 ;        - derived from DGPFAH if called by Flag Assignment transaction
 ;        - derived from DGPFLH if called by Flag Management transaction
 ;   DGPFIEN - IEN of the Flag Assignment for EF and CO
 ;           - this will be null for all other calls to this routine
 ;   DGPFOPT - XQY0 variable for option name - used for headers
 ;   DGPFACT - XQORNOD(0) variable for action name - used for headers
 ;
 ; Output:
 ;   none - A temporary global is built and displayed.
 ;
 ; Temporary variables:
 N TXN  ; transaction - one of the following:
 ;        FA - FLAG ASSIGNMENT - Assign Flag
 ;        FA - FLAG ASSIGNMENT - Edit Flag Assignment
 ;        FA - FLAG ASSIGNMENT - Change Assignment Ownership
 ;        FM - FLAG MANAGEMENT - Add New Record Flag
 ;        FM - FLAG MANAGEMENT - Edit Record Flag
 ;
 ; dg*951
 ; The variable DGPFIEN is reset in this module to a different meaning
 N DGFIEN S DGFIEN=+$G(DGPFIEN)
 N DGPFLOUT  ; (L)ocal(OUT)put array with values needed to setup global
 N DGPFGOUT  ; (G)lobal (OUT)put array name.  Contains assignment detail
 ;
 S TXN=$S($P(DGPFOPT,U)["FLAG ASSIGNMENT":"FA",1:"FM")
 S TXN=TXN_U_$P($P(DGPFOPT,U),"DGPF ",2)
 S TXN=TXN_U_$P(DGPFACT,U,3,4)
 ;
 S DGPFGOUT=$NA(^TMP("DGPFARY",$J)) K @DGPFGOUT
 S DGPFLOUT("ASGMNTIEN")=DGPFIEN
 ;
 D BLDLOCAL(.DGPFDA,.DGPFHX,TXN,.DGPFLOUT)
 D BLDGLOB^DGPFUT4(.DGPFDA,.DGPFHX,TXN,.DGPFLOUT,DGPFGOUT)
 D DISPLAY^DGPFUT5(TXN,DGPFGOUT) ; order thru global, display to user
 ;
 K @DGPFGOUT ; remove temporary global array
 Q
 ;
BLDLOCAL(DGPFDA,DGPFHX,TXN,DGPFLOUT) ;
 ; This procedure builds a local array (DPGFLOUT) of all fields
 ;
 ; Input:
 ;   DGPFDA - flag assignment data array
 ;   DGPFHX - flag assignment history array
 ;   TXN - transaction containing current option and action
 ;   DGPFLOUT - Local Output array
 ;
 ; Output:
 ;   none
 ;
 I $P(TXN,U)="FA" D BLDLOCFA(.DGPFDA,.DGPFHX,.DGPFLOUT) ; bld local array
 I $P(TXN,U)="FM" D BLDLOCFM(.DGPFDA,.DGPFHX,.DGPFLOUT) ; bld local array
 Q
 ;
BLDLOCFA(DGPFDA,DGPFHX,DGPFLOUT) ; build (L)ocal (OUT)put array
 ;
 ; This procedure builds a local array (DPGFLOUT) of all
 ; FLAG ASSIGNMENT fields to be presented to the user.
 ;
 ; Input:
 ;   DGPFDA - flag assignment data array
 ;   DGPFHX - flag assignment history array
 ;   DGPFLOUT - Local Output array
 ;
 ; Output:
 ;   DGPFLOUT - (L)ocal (OUT)put array
 ;
 ; Temporary variables:
 N DGERR,DIERR
 N DGPFIEN  ; Internal Entry Number
 N DGPFPAT  ; patient data array
 N DGPFFLG  ; flag data array
 N DGPFAHX  ; temporary array for holding last assignment
 N DGPFIA   ; initial assignment internal value
 N DGPFLAST ; last assignment
 ;
 Q:'$$GETPAT^DGPFUT2($P(DGPFDA("DFN"),U),.DGPFPAT)
 Q:'$$GETFLAG^DGPFUT1($P($G(DGPFDA("FLAG")),U),.DGPFFLG)
 ;
 S DGPFLOUT("PATIENT")=$G(DGPFPAT("NAME"))
 S DGPFLOUT("FLAGNAME")=$P($G(DGPFFLG("FLAG")),U)
 S DGPFLOUT("FLAGTYPE")=$P($G(DGPFFLG("TYPE")),U,2)
 S DGPFLOUT("CATEGORY")=$S(DGPFDA("FLAG")["26.11":"II (LOCAL)",DGPFDA("FLAG")["26.15":"I (NATIONAL)",1:"")
 ;
 S DGPFIEN=+$G(DGPFDA("STATUS"))
 S DGPFLOUT("STATUS")=$$EXTERNAL^DILFD(26.13,.03,"F",DGPFIEN)
 ;
 ; set initial assignment
 S DGPFLOUT("INITASSIGN")=$$FMTE^XLFDT($P($G(DGPFHX("ASSIGNDT")),U),"5")  ; AF
 I $G(DGPFLOUT("ASGMNTIEN"))]"" D  ; EF and CO actions
 . S DGPFIA=$$GETADT^DGPFAAH(DGPFLOUT("ASGMNTIEN"))
 . S DGPFLOUT("INITASSIGN")=$$FMTE^XLFDT($P($G(DGPFIA),U),"5")
 ;
 ; set last review date
 S DGPFLOUT("LASTREVIEW")="N/A"  ; AF action
 I $G(DGPFLOUT("ASGMNTIEN"))]"" D  ; EF and CO actions
 . S DGPFLAST=$$GETLAST^DGPFAAH(DGPFLOUT("ASGMNTIEN"))
 . S DGPFAHX=$$GETHIST^DGPFAAH(DGPFLAST,.DGPFAHX)
 . Q:+$G(DGPFAHX("ASSIGNDT"))=+$G(DGPFIA)  ; do not set if = init asgn
 . S DGPFLOUT("LASTREVIEW")=$$FMTE^XLFDT($P($G(DGPFAHX("ASSIGNDT")),U),"5D")
 ;
 ; set next review date
 S DGPFLOUT("REVIEWDT")="N/A"
 I $G(DGPFDA("REVIEWDT"))]"" D
 . S DGPFLOUT("REVIEWDT")=$$FMTE^XLFDT($P($G(DGPFDA("REVIEWDT")),U),"5D")
 ;
 S DGPFIEN=+$G(DGPFDA("OWNER"))_","
 S DGPFLOUT("OWNER")=$P($$NS^XUAF4(+DGPFIEN),U)
 ;
 S DGPFIEN=+$G(DGPFDA("ORIGSITE"))_","
 S DGPFLOUT("ORIGSITE")=$P($$NS^XUAF4(+DGPFIEN),U)
 ;
 S DGPFIEN=$G(DGPFHX("ACTION"))
 S DGPFLOUT("ACTION")=$$EXTERNAL^DILFD(26.14,.03,"F",DGPFIEN)
 ;
 S DGPFLOUT("ACTIONDT")=$$FMTE^XLFDT($$NOW^XLFDT,"5T")
 ;
 S DGPFIEN=DUZ_","
 S DGPFLOUT("ENTERBY")=$$GET1^DIQ(200,DGPFIEN,.01,"","","DGERR")
 ;
 ; word processing fields
 S DGPFIEN=+$G(DGPFHX("APPRVBY"))_","
 S DGPFLOUT("APPRVBY")=$$GET1^DIQ(200,DGPFIEN,.01,"","","DGERR")
 ;
 ; set DBRS if present, dg*3.5*951
 ; for EF action, show all DBRS# to display
 ; for AF action DGFIEN=0
 ; see DBRS^DGPFUT61 for format of DGPFA("DBRS"_x)
 ;
 I DGPFLOUT("FLAGNAME")="BEHAVIORAL" D
 . Q:'$D(DGPFDA("DBRS#"))
 . N I,J S (I,J)=0 F  S I=$O(DGPFDA("DBRS#",I)) Q:I=""  D
 . . N X,Y,NM,OTH
 . . S NM=$P(DGPFDA("DBRS#",I),U)
 . . S OTH=$P(DGPFDA("DBRS OTHER",I),U,2)
 . . I OTH="" S OTH="<no value>"
 . . S J=J+1
 . . S DGPFLOUT("DBRS#",J)=NM
 . . S DGPFLOUT("DBRS OTHER",J)=OTH
 . . Q
 . Q
 ;
 M DGPFLOUT("NARR")=DGPFDA("NARR")
 M DGPFLOUT("COMMENT")=DGPFHX("COMMENT")
 ;
 Q
 ;
BLDLOCFM(DGPFDA,DGPFHX,DGPFLOUT) ; build (L)ocal (OUT)put array
 ;
 ; This procedure builds a local array (DPGFLOUT) of all
 ; FLAG MANAGEMENT fields to be presented to the user.
 ;
 ; Input:
 ;   DGPFDA - flag management data array
 ;   DGPFHX - flag management history array
 ;   DGPFLOUT - (L)ocal (OUT)put array
 ;
 ; Output:
 ;   DGPFLOUT - (L)ocal (OUT)put array
 ;
 ; Temporary variables:
 N DGPFSUB  ; loop control variable
 ;
 S DGPFLOUT("FLAGNAME")=$P($G(DGPFDA("FLAG")),U,2)
 S DGPFLOUT("CATEGORY")="II (LOCAL)"
 S DGPFLOUT("FLAGTYPE")=$P($G(DGPFDA("TYPE")),U,2)
 S DGPFLOUT("STATUS")=$P($G(DGPFDA("STAT")),U,2)
 S DGPFLOUT("REVFREQ")=$P(DGPFDA("REVFREQ"),U)
 S DGPFLOUT("NOTIDAYS")=$P(DGPFDA("NOTIDAYS"),U)
 S DGPFLOUT("REVGRP")=$P(DGPFDA("REVGRP"),U,2)
 S DGPFLOUT("TIUTITLE")=$E($P(DGPFDA("TIUTITLE"),U,2),1,51)
 S DGPFLOUT("ENTERDT")=$$FMTE^XLFDT($$NOW^XLFDT,"5T")
 S DGPFIEN=DUZ_","
 S DGPFLOUT("ENTERBY")=$$GET1^DIQ(200,DGPFIEN,.01,"","","DGERR")
 ;
 ; principal investigator(s)
 S DGPFSUB=""
 F  S DGPFSUB=$O(DGPFDA("PRININV",DGPFSUB)) Q:DGPFSUB=""  D
 . Q:$G(DGPFDA("PRININV",DGPFSUB,0))="@"
 . S DGPFLOUT("PRININV",DGPFSUB,0)=$P($G(DGPFDA("PRININV",DGPFSUB,0)),U,2)
 ;
 ; word processing fields
 M DGPFLOUT("DESC")=DGPFDA("DESC")
 M DGPFLOUT("REASON")=DGPFHX("REASON")
 ;
 Q
