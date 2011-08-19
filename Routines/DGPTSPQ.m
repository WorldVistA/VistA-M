DGPTSPQ ;ALB/MTC - PTF Utility Con; 5/18/05 ; 11/26/03 9:56am
 ;;5.3;Registration;**195,397,565,664**;Aug 13, 1993;Build 15
 ;
CHQUES ;-- This function will determine if the patient has any of the
 ;   following indicated : AO, IR, EC, MST, NTR
 ;   If so the array DGEXQ will contain:
 ;     DGEXQ(1)="" - AO
 ;     DGEXQ(2)="" - IR
 ;     DGEXQ(3)="" - SW Asia Conditions/EC
 ;     DGEXQ(4)="" - MST  ;added 6/17/98 for MST enhancement
 ;     DGEXQ(5)="" - NTR  ;treatment for Head/Neck CA
 ;                        ;ONLY if (#28.11) Nose Throat Radium entered
 ;     DGEXQ(6)="" - CV   ;treatment for possible combat related 
 ;                        ;condition
 ;     DGEXQ(7)="" - SHAD ;treatment for Project 112/SHAD
 ;   Otherwise they will be undefined.
 ; This routine is called from the PTF input templates.
 ;   The following variables are defined:
 ;     DGHOLD : Movemnent record before any changes been made.
 ;     DGPTF  : PTF Record Number.
 ;     DGMOV  : PTF Movement Number (optional)
 N DGHOLD,SDCLY
 S DGHOLD=^DGPT(DA(1),"M",DA,0),SDCLY=""
 ;-- call to determine if questions should be asked. OPC uses same
 ;   criteria.
 D CL^SDCO21(DFN,$P(DGHOLD,U,10),"",.SDCLY)
 ;
 ;-- if sc > 50% and treated for sc don't ask AO/IR
 ;-- ADD KILL OF SDCLY(6) TO SKIP COMBAT VETERAN QUESTION
 I $P($G(^DGPT(DGPTF,"M",+$G(DGMOV),0)),U,18)=1 K SDCLY(1),SDCLY(2)
 ;
 G:'$D(SDCLY) CHQ
 ; AO
 I $D(SDCLY(1)) S DGEXQ(1)=""
 ; IR
 I $D(SDCLY(2)) S DGEXQ(2)=""
 ; SW Asia Conditions/EC
 I $D(SDCLY(4)) S DGEXQ(3)=""
 ; MST
 I $D(SDCLY(5)) S DGEXQ(4)="" ;added 6/17/98 for MST enhancement
 ; NTR
 I $D(SDCLY(6)) S DGEXQ(5)=""
 ; CV
 I $D(SDCLY(7)) S DGEXQ(6)=""
 ; SHAD
 I $D(SDCLY(8)) S DGEXQ(7)=""
CHQ Q
 ;
501 ;-- This is the input transform logic for the following questions:
 ;   AO, IR, EC, MST, NTR
 ;   Process: Make sure that the conditions are indicated before
 ;            allowing data to be entered. If the indicators are
 ;            not present and the question was answered, DGER
 ;            will be set to 1.
 ;   INPUT  : DGFLAG - Field to check
 ;            DGER   - DGER  error code
 N DGEXQ
 S DGER=0
 D CHQUES
 I '$D(DGEXQ(+DGFLAG)) S DGER=1
 Q
 ;
701 ;-- This is the input transform logic for the following questions
 ;   for the <701> PTF record:  AO, IR, EC, MST, NTR
 ;   Process: Check if the desired indicator was answered on a <501>.
 ;   changed 6/17/98 for MST enhancement
 ;   INPUT DGFLAG - 1=AO, 2=IR, 3=EC, 4=MST, 5=NTR, 6=CV, 7=SHAD
 N I
 S DGER=1
 ;-- loop thru <501>'s for indicator specified by DGFLAG
 S I=0 F  S I=$O(^DGPT(DA,"M",I)) Q:'I  I $P($G(^DGPT(DA,"M",I,0)),U,DGFLAG+25)'="" S DGER=0 Q
 Q
 ;
UP701 ;-- This function will loop thru the <501> and determine if any
 ;   of the SC, AO, IR, EC, MST, NTR, CV, and SHAD questions have been
 ;   answered.  If so, the cooresponding <701> will be updated.
 ;   An answer of "yes" will take presidence.
 ;
 ;   INPUT : DGPTF
 ;   changed 6/17/98 for MST emhancement
 N I,DGSC,DGAO,DGIR,DGEC,DGMOV,DGMST,DGNTR,DGCV,DGSHAD
 S (DGSC,DGAO,DGIR,DGEC,DGMST,DGNTR,DGCV,DGSHAD)="@"
 ;-- loop thru <501>s
 S I=0 F  S I=$O(^DGPT(DGPTF,"M",I)) Q:'I  S DGMOV=$G(^(I,0)) I DGMOV'="" D
 .;-- sc
 .I $P(DGMOV,U,18)'="",DGSC'=1 S DGSC=$P(DGMOV,U,18)
 .;-- ao
 .I $P(DGMOV,U,26)'="",DGAO'="Y" S DGAO=$P(DGMOV,U,26)
 .;-- ir
 .I $P(DGMOV,U,27)'="",DGIR'="Y" S DGIR=$P(DGMOV,U,27)
 .;-- ec
 .I $P(DGMOV,U,28)'="",DGEC'="Y" S DGEC=$P(DGMOV,U,28)
 .;-- mst ;added 6/17/98 for MST enhancement
 .I $P(DGMOV,U,29)'="",DGMST'="Y" S DGMST=$P(DGMOV,U,29)
 .;-- ntr
 .I $P(DGMOV,U,30)'="",DGNTR'="Y" S DGNTR=$P(DGMOV,U,30)
 .;-- cv
 .I $P(DGMOV,U,31)'="",DGCV'="Y" S DGCV=$P(DGMOV,U,31)
 .;-- shad
 .I $P(DGMOV,U,32)'="",DGSHAD'="Y" S DGSHAD=$P(DGMOV,U,32)
 ;-- update <701> fields
 ; changed 6/17/98 for MST enhancement
 S DR="79.25////^S X=DGSC;79.26////^S X=DGAO;79.27////^S X=DGIR;79.28////^S X=DGEC;79.29////^S X=DGMST;79.3////^S X=DGNTR;79.31////^S X=DGCV;79.32////^S X=DGSHAD"
 S DA=DGPTF,DIE="^DGPT("
 D ^DIE K DIE,DA,DR
UPQ Q
 ;
