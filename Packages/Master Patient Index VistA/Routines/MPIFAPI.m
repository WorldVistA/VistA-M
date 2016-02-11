MPIFAPI ;CMC/BP-APIS FOR MPI ;DEC 21, 1998
 ;;1.0;MASTER PATIENT INDEX VISTA;**1,3,14,16,17,21,27,28,33,35,37,43,45,44,46,48,55,56,60,61**;30 Apr 99;Build 3
 ; Integration Agreements Utilized:
 ;   ^DPT( - #2070 and #4079
 ;   ^DPT("AICN", ^DPT("AMPIMIS", ^DPT("ASCN2" - #2070
 ;   EXC, START, STOP^RGHLLOG - #2796
 ;
EN2() ;NEW ENTRY POINT FOR LOCALS
 N MPIOUT,DIC,MPICHK,MPINCK,MPINNM,MPINUM1,DA,MPINUM
 I $O(^MPIF(984.1,0))="" G SETUP
AGN2 L +^MPIF(984.1):1 E  H 3 G AGN2
 S MPINUM=0,X=$$SITE^VASITE,X=$P(X,"^",3),X=X\1
 S DIC="^MPIF(984.1,",DIC(0)="XZ" D ^DIC
 S MPINUM1=$P(Y(0),"^",4),MPICHK=$P(Y(0),"^",5),MPINNM=MPINUM1+1
 S MPINUM=MPINUM1_"V"_MPICHK,MPINCK=$$CHECKDG^MPIFSPC(MPINNM)
 S DA=1,DIE="^MPIF(984.1,",DR="1////^S X=MPINUM1;2////^S X=MPICHK;3////^S X=MPINNM;5////"_MPINCK
 D ^DIE
 K DIE,DR,X,Y
 L -^MPIF(984.1)
 Q MPINUM
SETUP ;
 N CHK,NUM,NXTCHK,NXTNUM,SITE,DA
 S SITE=$$SITE^VASITE,SITE=$P(SITE,"^",3),SITE=SITE\1
 S DIC="^MPIF(984.1,",DA=1,DIC(0)="",X=SITE
 S NUM=SITE_"0000000",CHK=$$CHECKDG^MPIFSPC(NUM),MPINUM=NUM_"V"_CHK
 S NXTNUM=NUM+1,NXTCHK=$$CHECKDG^MPIFSPC(NXTNUM)
 S DIC("DR")="1////^S X=NUM;2////^S X=CHK;3////^S X=NXTNUM;5////"_NXTCHK
 K DD,D0
 D FILE^DICN
 K DIC,X,Y
 Q MPINUM
 ;
MPILINK() ;returns MPI logical Link
 N MPIL,MPILINK
 D LINK^HLUTIL3("MPI",.MPIL)
 I '$D(MPIL) Q "-1^NOT DEFINED"
 S MPILINK=$O(MPIL(0))
 I MPILINK="" Q "-1^NOT DEFINED"
 S MPILINK=$G(MPIL(MPILINK))
 Q MPILINK
 ;
SUBNUM(DFN) ; returns SCN from MPI node for given DFN
 ; DFN - ien of patient file
 ; returns:  -1^error message << always returns.
 ;*** Subscription control numbers no longer exist
 Q "-1^No Subscription Control Number for DFN "_DFN
 ;
MPINODE(DFN) ; returns MPI node for given DFN
 ; DFN - patient file ien
 ; returns:  -1^error message or MPI node from patient file
 N TMP
 I '$D(DFN) Q "-1^DFN not defined"
 I '$D(^DPT(DFN)) Q "-1^DFN doesn't exist"
 I '$D(^DPT(DFN,"MPI")) Q "-1^No MPI node for DFN "_DFN
 L +^DPT("MPI",DFN):10 ;**45 added lock check for getting ICN data back
 N NODE S NODE=$G(^DPT(DFN,"MPI"))
 I NODE=""!(NODE?."^") S NODE="-1^No MPI data for DFN "_DFN
 I +NODE>0 D
 .;**45 checking if checksum for ICN is correct, if not update the 991.02 field
 .; and include new value in NODE returned.
 .N CHK S CHK=$$CHECKDG^MPIFSPC($P(NODE,"^"))
 .I CHK'=$P(NODE,"^",2) S TMP=$$SETICN^MPIF001(DFN,$P(NODE,"^"),CHK) S $P(NODE,"^",2)=CHK
 L -^DPT("MPI",DFN)
 Q NODE
 ;
GETADFN(ICN) ; return DFN ONLY if ICN is the active ICN
 ; ICN - Integration Control Number for patient to be returned
 ; returns:  -1^error message
 ;           DFN - IEN for the patient entry in the Patient file (#2)
 N RETURN,DFN
 I $G(ICN)'>0 Q "-1^NO ICN"
 I '$D(^DPT("AICN",ICN)) Q "-1^ICN NOT IN DATABASE"
 S DFN=$O(^DPT("AICN",ICN,0))
 I $G(DFN)'>0 Q "-1^BAD AICN CROSS-REFERENCE"
 I $P($G(^DPT(DFN,"MPI")),"^")'=ICN Q "-1^ICN is not Active one"
 Q DFN
 ;
AICN2DFN(ICN) ; return DFN ONLY if Full ICN is the active ICN
 ;**60 (elz) MVI_793 create APIs for Full ICN field
 ; ICN - Integration Control Number for patient to be returned (FULL)
 ; returns:  -1^error message
 ;           DFN - IEN for the patient entry in the Patient file (#2)
 N RETURN,DFN
 I $G(ICN)'>0 Q "-1^NO ICN"
 I ICN'["V" Q "-1^Full ICN required"
 I '$D(^DPT("AFICN",ICN)) Q "-1^ICN NOT IN DATABASE"
 S DFN=$O(^DPT("AFICN",ICN,0))
 I $G(DFN)'>0 Q "-1^BAD AFICN CROSS-REFERENCE"
 I $P($G(^DPT(DFN,"MPI")),"^",10)'=ICN Q "-1^ICN is not Active one"
 Q DFN
 ;
UPDATE(DFN,ARR,MPISILNT,REMOVE) ;api to edit 'mpi','mpifhis' and 'mpicmor' nodes
 ;**37 UPDATE module moved 3/30/05 from MPIFAPI into MPIFAPI1.
 ;Linetag must remain due to DBIA #2706.
 Q $$UPDATE^MPIFAPI1(DFN,ARR,.MPISILNT,.REMOVE)
 ;
MPIQ(DFN) ;MPI QUERY
 N MPIFARR
 L +^DPT(DFN):2 I '$T,'$D(MPIFS) W $C(7),!!,"Patient is being edited. No attempt will be made to connect to the MPI." H 2 Q
 I '$D(MPIFS) D  ;Not from SmartCard background job
 .;**37 mods to L -^DPT
 .I $G(DGNEW)=1 D  ;New patient, fields always blank, ask
 ..D WRTLN
 ..; **44 Adding Pseudo SSN Reason to the list of prompted fields if SSN is a pseudo and there isn't already a reason stored
 ..N MPIFP S MPIFP="" S DA=DFN,DIQ(0)="EI",DIC=2,DR=".09;.0906",DIQ="MPIFARR" D EN^DIQ1 K DA,DR,DIC,DQ,DR
 ..I $D(MPIFARR(2,DFN,.0906,"I")) D
 ...I MPIFARR(2,DFN,.09,"E")["P",("S"[MPIFARR(2,DFN,.0906,"I")) S MPIFP=".0906;"
 ..S DIE="^DPT(",DA=DFN,DIE("NO^")="BACK"
 ..S DR=MPIFP_".2403;.092;.093;1",DR(2,2.01)=".01;1" D ^DIE K DA,DIE,DR Q  ;*55 MPIC_1402 ALIAS SSN
 .I $G(DGNEW)="" D  ;Existing patient, get current values
 ..N MPIDOB,IMPRS,MPIMMN,MPICTY,MPIST
 ..S DIC=2,DR=".02;.03;.09;.0906;.092;.093;.2403;994;1",DR(2.01)=".01"
 ..;^ **44 include pseudo ssn reason to list
 ..S DA=DFN,DA(2.01)=1,DIQ(0)="EI",DIQ="MPIFARR"
 ..D EN^DIQ1 K DA,DIC,DIQ,DR
 ..;build DR from blank fields / imprecise DOB / pseudo SSN
 ..S DR=""
 ..S MPIDOB=$G(MPIFARR(2,DFN,.03,"I")) ;DATE OF BIRTH
 ..I MPIDOB="" S DR=DR_".03;" ;DOB null
 ..;Is DOB imprecise?
 ..I MPIDOB'="" S IMPRS=0 D
 ...I $E(MPIDOB,4,7)="0000" S IMPRS=1 ;Year only; no month/day
 ...I ($E(MPIDOB,6,7)="00")&($E(MPIDOB,4,5)'="00") S IMPRS=1 ;Year/month only; no day
 ...I IMPRS=1 S DR=DR_".03;" ;DOB imprecise
 ..I $G(MPIFARR(2,DFN,.02,"I"))="" S DR=DR_".02;" ;SEX
 ..;if the SSN is null, add to prompted fields
 ..N SSNP S SSNP=0
 ..I ($G(MPIFARR(2,DFN,.09,"E"))="") S DR=DR_".09;",SSNP=1 ;SSN
 ..I DR'="" D
 ...D WRTLN
 ...S DIE="^DPT(",DA=DFN,DIE("NO^")="BACK"
 ...D ^DIE K DA,DIE,DR,DIC,DIQ
 ...;if SSN was prompted then reinitialize SSN ARRAY variable
 ...I SSNP=1 S MPIFARR(2,DFN,.09,"E")="" S DIC=2,DR=".09" S DA=DFN,DA(2.01)=1,DIQ(0)="E",DIQ="MPIFARR" D EN^DIQ1 K DA,DIC,DIQ,DR
 ...;**44 if the PSEUDO SSN REASON field exist
 ..S DR="" ;reset DR to null to be able to concatenate the fields together since DR was just killed above
 ..I $D(MPIFARR(2,DFN,.0906,"I")) D
 ...;check to see if the SSN is a PSEUDO and the PSEUDO SSN REASON is null or "S" (FOLLOW-UP REQUIRED), if so add PSEUDO SSN REASON to the prompted fields
 ...I MPIFARR(2,DFN,.09,"E")["P",(MPIFARR(2,DFN,.0906,"I")="") S DR=DR_".0906;" ;**48 correct when SSN is prompted
 ...I MPIFARR(2,DFN,.09,"E")["P",(MPIFARR(2,DFN,.0906,"I")="S") S DR=DR_".09;" ;**48 correct when SSN is prompted
 ..I $G(MPIFARR(2,DFN,994,"I"))="" S DR=DR_"994;" ;MULTIPLE BIRTH INDICATOR
 ..S MPIMMN=$G(MPIFARR(2,DFN,.2403,"E")) ;MOTHER'S MAIDEN NAME
 ..I $$VALDT(MPIMMN) S DR=DR_".2403;" ;Validate MMN value
 ..S MPICTY=$G(MPIFARR(2,DFN,.092,"E")) ;PLACE OF BIRTH [CITY]
 ..S MPIST=$G(MPIFARR(2,DFN,.093,"E")) ;PLACE OF BIRTH [STATE]
 ..I $S($$VALDT(MPICTY):1,$$VALDT(MPIST):1,1:0) S DR=DR_".092;.093;" ;Validate POB [CITY] & [STATE] value
 ..I $G(MPIFARR(2.01,1,.01,"E"))="" S DR=DR_"1",DR(2,2.01)=".01;1" ;ALIAS **44 ADDING ALIAS SSN TO FIELDS
 ..I DR'="" D
 ...D WRTLN
 ...S DIE="^DPT(",DA=DFN,DIE("NO^")="BACK"
 ...D ^DIE K DA,DIE,DR,DIC,DIQ
 L -^DPT(DFN)
 I $D(ZTQUEUED) S ZTREQ="@"
 K MPIFRTN D VTQ^MPIFQ0
 ;**43 No longer get list of potential matches to pick from
 ;I $G(MPIFRTN)="" D
 ;. ^ Quit at LM screen when presented with a list of possible matches
 ;. \/ setup Local ICN and proceed
 ;.N ICN,ERR
 ;.S ICN=$$EN2^MPIFAPI()
 ;.Q:ICN=""!(+ICN=-1)
 ;.S ERR=$$SETICN^MPIF001(DFN,+ICN,$P(ICN,"V",2))
 ;.Q:+ERR=-1
 ;. ^ couldn't set ICN don't set other fields
 ;.S ERR=$$SETLOC^MPIF001(DFN,1),ERR=$$CHANGE^MPIF001(DFN,$P($$SITE^VASITE,"^"))
 K MPIFRTN,ZTREQ
 Q
 ;
MPIQQ(PDFN) ; Entry point for queuing d/c
 ; Returned is -1^error message OR Task #
 Q:'$D(PDFN) "-1^No DFN passed"
 S ZTRTN="MPIQ^MPIFAPI(PDFN)"
 I $D(DUZ) S ZTSAVE("DUZ")=DUZ
 S ZTSAVE("PDFN")=PDFN,ZTSAVE("MPIFS")=1
 ; ^ silent flag
 S ZTIO="",ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,0,0,1,0)
 D ^%ZTLOAD
 D HOME^%ZIS K IO("Q")
 N TSK S TSK=ZTSK
 K ZTSAVE,ZTRTN,ZTIO,ZTDTH,ZTSK
 Q TSK
 ;
WRTLN ;**37 Write intro text ONLY if there are fields to ask
 W !!,"Please verify or update the following information:",!
 Q
 ;
VALDT(VAL) ;**37 Validate value passed in.
 ;Prompt if field contains invalid data (e.g., UNKNOWN, NOT KNOWN, etc.)
 ;Returns 0 if not found
 ;Returns 1 if found
 I VAL="" Q 1
 I $E($$UP^XLFSTR(VAL),1,3)="UNK" Q 1
 I $E($$UP^XLFSTR(VAL),1,4)="NONE" Q 1
 I $E($$UP^XLFSTR(VAL),1,4)="NOT " Q 1
 I $$UP^XLFSTR(VAL)["UNAVAILABLE" Q 1
 I $$UP^XLFSTR(VAL)["DECEASED" Q 1
 I $E($$UP^XLFSTR(VAL),1,2)="DC" Q 1
 Q 0
 ;
VIC40(DFN,ICN) ; -- only allowed for approved package use
 ; this will file the FULL icn for a patient and update correlations
 ; so the local site is now a subscribing package.  This is used with the
 ; VIC 4.0 card registration where PV data was obtained from MVI.  
 ;*56 (elz)
 N MPIX,TIME,LIST
 S TIME=$$NOW^XLFDT
 S INDEX=1
 D UPDATE^MPIFQ0(DFN,ICN,"")
 Q
