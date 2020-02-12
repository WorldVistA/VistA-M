IBCCC2 ;ALB/AAS - CANCEL AND CLONE A BILL - CONTINUED ;6/6/03 9:56am
 ;;2.0;INTEGRATED BILLING;**80,106,124,138,51,151,137,161,182,211,245,155,296,320,348,349,371,400,433,432,447,516,577,592,608,623**;21-MAR-94;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;MAP TO DGCRCC2
 ;
 ;STEP 5 - get remainder of data to move and store in MCCR then x-ref
 ;STEP 6 - go to screens, come out to IBB1 or something like that
 ;
STEP5 S IBIFN1=$P(^DGCR(399,IBIFN,0),"^",15) G END:$S(IBIFN1="":1,'$D(^DGCR(399,IBIFN1,0)):1,1:0)
 ; NOTE:  any new or changed data nodes may also need to be updated in IBNCPDP5
 ;move pure data nodes
 ; MRD;IB*2.0*516 - Added "In7" nodes.
 F I="I1","I17","I2","I27","I3","I37","M1" I $D(^DGCR(399,IBIFN1,I)) S ^DGCR(399,IBIFN,I)=^DGCR(399,IBIFN1,I)
 ;
 ;move top level data node. ;Do not move 'TX' node EXCEPT piece 8 (added with IB*2.0*432)
 ;F I="U","U1","U2","U3","UF2","UF3","UF31","C","M" I $D(^DGCR(399,IBIFN1,I)) S IBND(I)=^(I) D @I
 ; add new data nodes introduced with IB*2.0*432
 ; vd - IB*2.0*623 - Added "M2".
 F I="TX","U","U1","U2","U3","U4","U5","U6","U7","U8","UF2","UF3","UF31","UF32","C","M","M2" I $D(^DGCR(399,IBIFN1,I)) S IBND(I)=^(I) D @I
 ;
 ;move multiple level data
 ;F I="CC","OC","OP","OT","RC","CP","CV","PRV" I $D(^DGCR(399,IBIFN1,I,0)) D @I
 ; add new data nodes introduced with IB*2.0*447 BI
 F I="CC","OC","OP","OT","RC","CP","CV","PRV","U9" I $D(^DGCR(399,IBIFN1,I,0)) D @I
 ;
 ;JWS;IB*2.0*592;add new Dental Claim fields; IA# 3820
 I $D(^DGCR(399,IBIFN1,"DEN")) S ^DGCR(399,IBIFN,"DEN")=^DGCR(399,IBIFN1,"DEN")
 I $D(^DGCR(399,IBIFN1,"DEN1",0)) S ^DGCR(399,IBIFN,"DEN1",0)=^DGCR(399,IBIFN1,"DEN1",0) D
 . S K=0 F  S K=$O(^DGCR(399,IBIFN1,"DEN1",K)) Q:'K  S ^DGCR(399,IBIFN,"DEN1",K,0)=^DGCR(399,IBIFN1,"DEN1",K,0)
 I $D(^DGCR(399,IBIFN1,"DEN2")) S ^DGCR(399,IBIFN,"DEN2")=^DGCR(399,IBIFN1,"DEN2")
 ;
 ; IB*2.0*432  ADDED IBSILENT flag so that this can be processed in background
 D FTPRV^IBCEU5(IBIFN,$G(IBSILENT)) ; Ask change prov type if form type not the same
 D COBCHG(IBIFN,,.IBCOB)
 ;
 D ^IBCCC3 ; copy table files (362.3)
 ;
 S I=$G(^DGCR(399,IBIFN1,0)) I $P(I,U,13)=7,$P(I,U,20)=1 D COPYB^IBCDC(IBIFN1,IBIFN) ; update auto bill files
 D PRIOR(IBIFN) ; add new bill to previous bills in series, primary/secondary
 ;
 I +$G(IBCTCOPY) N IBAUTO S IBAUTO=1 D PROC^IBCU7A(IBIFN),BILL^IBCRBC(IBIFN),CPTMOD26^IBCU73(IBIFN) D RECALL^DILFD(399,IBIFN_",",DUZ) G END
 ;
STEP6 N IBGOEND
 ;JWS;IB*2.0*623v24;need to identify valid duplicate
 I $G(IBCNCRD)=1 D
 . N DA,DR,DIE,X,Y
 . S DA=IBIFN,DIE="^DGCR(399,",DR="23////1" D ^DIE
 . Q
 ; need to kill CRD flag prior to entering billing screens in case a copy for corresponding claim is needed
 K IBCNCRD
 ; don't call IB bill edit screens if this is non-MRA background processing
 I $G(IBSTSM)=1 G END
 I '$G(IBCE("EDI"))!$G(IBCE("EDI","NEW")),'$G(IBCEAUTO) D IBSCEDT G END:$G(IBGOEND)
 ;
 ;
END K DFN,IB,IBA,IBA2,IBAD,IBADD1,IBBNO,IBCAN,IBCCC,IBDA,IBDPT,IBDR,IBDT,IBI,IBI1,IBIDS,IBIFN,IBIFN1,IBND,IBQUIT,IBU,IBUN,IBARST,IBCOB,IBCNCOPY,IBCBCOPY,IBCNCRD,IBKEY
 K IBV,IBV1,IBW,IBWW,IBYN,IBZZ,PRCASV,PRCAERCD,PRCAERR,PRCASVC,PRCAT,IBBT,IBCH,IBNDS,IBOA,IBREV,IBX,DGXRF1,VAEL,VAERR,IBAC,IBCCC,IBDD1,IBIN,DGREV,DGREV00,DGREVHDR,IBCHK
 K IBBS,IBLS,DGPCM,IBIP,IBND0,IBNDU,IBO,IBPTF,IBST,IBUC,IBDD,D,%,%DT,DIC,VA,VADM,X,X1,X2,X3,X4,Y,I,J,K,DGRVRCAL,DDH,DGACTDT,DGAMNT,DGBR,DGBRN,DGBSI,DGBSLOS,IBA1,IBOD,IBINS,IBN,IBPROC,DGFUNC,DGIFN
 Q
 ;
 ;
IBSCEDT ; call the IB bill edit screens and validate the data
 N IBV,IBPAR,IBAC,IBHV,IBH,IBCIREDT
 ; if the user came from CBW->PC and this is a non-MRA claim w/a paper EOB, set force print flag IB*2.0*432
 ; also, if the user came from CBW->PC and this is a non-MRA claim and the only EEOB we have has filing errors, set force print flag
 I $G(IBMRANOT)=1,$$COBN^IBCEF(IBIFN)>1,$G(IBFROM)=2 D 
 .I $G(IBDA)="" D FORCEPRT^IBCAPP($G(IBIFN)) Q
 .I $D(^IBM(361.1,IBDA,"ERR")) D FORCEPRT^IBCAPP($G(IBIFN)) Q
 D RECALL^DILFD(399,IBIFN_",",DUZ)
ST1 S IBV=0 D ^IBCSCU,^IBCSC1 I $G(IBPOPOUT) S IBGOEND=1 G IBSCX
 S IBAC=1
 D ^IBCB1
 I $G(IBCIREDT) G ST1
IBSCX ;
 Q
 ;
 ;
TX F J=8 I $P(IBND("TX"),"^",J)]"" S $P(^DGCR(399,IBIFN,"TX"),"^",J)=$P(IBND("TX"),"^",J)
 Q
U F J=3,4,6:1:17,20 I $P(IBND("U"),"^",J)]"" S $P(^DGCR(399,IBIFN,"U"),"^",J)=$P(IBND("U"),"^",J)
 Q
U1 F J=1:1:3,15 I $P(IBND("U1"),"^",J)]"" S $P(^DGCR(399,IBIFN,"U1"),"^",J)=$P(IBND("U1"),"^",J)
 Q
U2 F J=1:1:19 I $P(IBND("U2"),"^",J)]"" S $P(^DGCR(399,IBIFN,"U2"),"^",J)=$P(IBND("U2"),"^",J)
 Q
U3 F J=1:1:11 I $P(IBND("U3"),"^",J)]"" S $P(^DGCR(399,IBIFN,"U3"),"^",J)=$P(IBND("U3"),"^",J)
 Q
UF2 F J=1,3 I $P(IBND("UF2"),"^",J)]"" S $P(^DGCR(399,IBIFN,"UF2"),"^",J)=$P(IBND("UF2"),"^",J)
 Q
UF3 F J=4:1:6 I $P(IBND("UF3"),"^",J)]"" S $P(^DGCR(399,IBIFN,"UF3"),"^",J)=$P(IBND("UF3"),"^",J)
 Q
U4 F J=1:1:14 I $P(IBND("U4"),"^",J)]"" S $P(^DGCR(399,IBIFN,"U4"),"^",J)=$P(IBND("U4"),"^",J)
 Q
U5 F J=1:1:6 I $P(IBND("U5"),"^",J)]"" S $P(^DGCR(399,IBIFN,"U5"),"^",J)=$P(IBND("U5"),"^",J)
 Q
U6 F J=1:1:6 I $P(IBND("U6"),"^",J)]"" S $P(^DGCR(399,IBIFN,"U6"),"^",J)=$P(IBND("U6"),"^",J)
 Q
U7 F J=1:1:5 I $P(IBND("U7"),"^",J)]"" S $P(^DGCR(399,IBIFN,"U7"),"^",J)=$P(IBND("U7"),"^",J)
 Q
U8 F J=1:1:3 I $P(IBND("U8"),"^",J)]"" S $P(^DGCR(399,IBIFN,"U8"),"^",J)=$P(IBND("U8"),"^",J)
 Q
UF31 F J=3 I $P(IBND("UF31"),"^",J)]"" S $P(^DGCR(399,IBIFN,"UF31"),"^",J)=$P(IBND("UF31"),"^",J)
 Q
UF32 F J=1:1:3 I $P(IBND("UF32"),"^",J)]"" S $P(^DGCR(399,IBIFN,"UF32"),"^",J)=$P(IBND("UF32"),"^",J)
 Q
C F J=10 I $P(IBND("C"),"^",J)]"" S $P(^DGCR(399,IBIFN,"C"),"^",J)=$P(IBND("C"),"^",J)
 I '$D(^DGCR(399,IBIFN1,"CP")) D CP1
 Q
M F J=1:1:9,11:1:14 I $P(IBND("M"),"^",J)]"" S $P(^DGCR(399,IBIFN,"M"),"^",J)=$P(IBND("M"),"^",J)
 Q
 ; vd - IB*2.0*623 - Added the following module of code.
M2 F J=1:1:6 I $P(IBND("M2"),"^",J)]"" S $P(^DGCR(399,IBIFN,"M2"),"^",J)=$P(IBND("M2"),"^",J)
 Q
CC S ^DGCR(399,IBIFN,I,0)=^DGCR(399,IBIFN1,I,0)
 S IBDD=399.04 F J=0:0 S J=$O(^DGCR(399,IBIFN1,I,J)) Q:'J  I $D(^(J,0)) S ^DGCR(399,IBIFN,I,J,0)=^DGCR(399,IBIFN1,I,J,0),X=$P(^(0),"^")
OP S ^DGCR(399,IBIFN,I,0)=^DGCR(399,IBIFN1,I,0)
 S IBDD=399.043 F J=0:0 S J=$O(^DGCR(399,IBIFN1,I,J)) Q:'J  I $D(^(J,0)) S ^DGCR(399,IBIFN,I,J,0)=^DGCR(399,IBIFN1,I,J,0),X=$P(^(0),"^")
 Q
OC S ^DGCR(399,IBIFN,I,0)=^DGCR(399,IBIFN1,I,0)
 S IBDD=399.041 F J=0:0 S J=$O(^DGCR(399,IBIFN1,I,J)) Q:'J  I $D(^(J,0)) S ^DGCR(399,IBIFN,I,J,0)=^DGCR(399,IBIFN1,I,J,0),X=$P(^(0),"^")
 Q
OT S ^DGCR(399,IBIFN,I,0)=^DGCR(399,IBIFN1,I,0)
 S IBDD=399.048 F J=0:0 S J=$O(^DGCR(399,IBIFN1,I,J)) Q:'J  I $D(^(J,0)) S ^DGCR(399,IBIFN,I,J,0)=^DGCR(399,IBIFN1,I,J,0),X=$P(^(0),"^")
 Q
CV ; Don't copy value codes from inpatient inst to inpatient prof bills
 I $$FT^IBCEF(IBIFN1)'=2,$$FT^IBCEF(IBIFN)=2 Q
 S ^DGCR(399,IBIFN,I,0)=^DGCR(399,IBIFN1,I,0)
 S IBDD=399.047 F J=0:0 S J=$O(^DGCR(399,IBIFN1,I,J)) Q:'J  I $D(^(J,0)) S ^DGCR(399,IBIFN,I,J,0)=^DGCR(399,IBIFN1,I,J,0),X=$P(^(0),"^")
 Q
RC S ^DGCR(399,IBIFN,I,0)=^DGCR(399,IBIFN1,I,0)
 S IBDD=399.042 F J=0:0 S J=$O(^DGCR(399,IBIFN1,I,J)) Q:'J  I $D(^(J,0)) S IBND("RC")=^(0) F K=1:1:16 S $P(^DGCR(399,IBIFN,I,J,0),"^",K)=$P(IBND("RC"),"^",K),X=$P(IBND("RC"),"^",K)
 Q
CP S ^DGCR(399,IBIFN,I,0)=^DGCR(399,IBIFN1,I,0)
 I +$G(IBNOCPT) Q
 S IBDD=399.0304 F J=0:0 S J=$O(^DGCR(399,IBIFN1,I,J)) Q:'J  I $D(^(J,0)) S IBND("CP")=^(0),IBND("CP1")=$G(^(1)),IBND("CP2")=$G(^(2)),IBND("CP-AUX")=$G(^("AUX")) D
 . F K=1:1:7,9:1:14,16:1:22 S $P(^DGCR(399,IBIFN,I,J,0),"^",K)=$P(IBND("CP"),"^",K)
 . ; IB*2.0*432 add new 1 node
 . ; MRD;IB*2.0*516 - Added pieces 7 & 8 (NDC, Units) to 1-node.
 . F K=1:1:8 S $P(^DGCR(399,IBIFN,I,J,1),"^",K)=$P(IBND("CP1"),"^",K)
 . ; WCJ;IB*2.0*577 - Added piece 1 (UNITS/BASIS OF MEASUREMENT) to 2-node.
 . F K=1:1:1 S $P(^DGCR(399,IBIFN,I,J,2),"^",K)=$P(IBND("CP2"),"^",K)
 . ; esg - 11/2/06 - IB*2*348 - 50.09 field was added - AUX piece [9]
 . I IBND("CP-AUX")'="" F K=1:1:9 S $P(^DGCR(399,IBIFN,I,J,"AUX"),"^",K)=$P(IBND("CP-AUX"),"^",K)
 . ; IB*2.0*432 add new LNPRV multiple
 . I $D(^DGCR(399,IBIFN1,I,J,"LNPRV",0)) S ^DGCR(399,IBIFN,I,J,"LNPRV",0)=^DGCR(399,IBIFN1,I,J,"LNPRV",0) D
 .. S K=0 F  S K=$O(^DGCR(399,IBIFN1,I,J,"LNPRV",K)) Q:'K  D
 ... S ^DGCR(399,IBIFN,I,J,"LNPRV",K,0)=^DGCR(399,IBIFN1,I,J,"LNPRV",K,0)
 . I $D(^DGCR(399,IBIFN1,I,J,"MOD",0)) S ^DGCR(399,IBIFN,I,J,"MOD",0)=^DGCR(399,IBIFN1,I,J,"MOD",0) D
 .. S K=0 F  S K=$O(^DGCR(399,IBIFN1,I,J,"MOD",K)) Q:'K  D
 ... I $G(IBNOTC),$P($$MOD^ICPTMOD(+$P($G(^DGCR(399,IBIFN1,I,J,"MOD",K,0)),U,2),"I"),U,2)="TC" Q  ; Don't copy TC modifier from inst to prof bill
 ... S ^DGCR(399,IBIFN,I,J,"MOD",K,0)=^DGCR(399,IBIFN1,I,J,"MOD",K,0)
 . ;JWS;IB*2.0*592;add new Dental claim form fields
 . I $D(^DGCR(399,IBIFN1,I,J,"DEN")) S ^DGCR(399,IBIFN,I,J,"DEN")=^DGCR(399,IBIFN1,I,J,"DEN")
 . I $D(^DGCR(399,IBIFN1,I,J,"DEN1",0)) S ^DGCR(399,IBIFN,I,J,"DEN1",0)=^DGCR(399,IBIFN1,I,J,"DEN1",0) D
 .. N IBDL
 .. S K=0 F  S K=$O(^DGCR(399,IBIFN1,I,J,"DEN1",K)) Q:'K  D
 ... S ^DGCR(399,IBIFN,I,J,"DEN1",K,0)=^DGCR(399,IBIFN1,I,J,"DEN1",K,0)
 ... ;JWS;IB*2.0*592;If DENT file 228.2 link, remove it from old invoice.
 ... S IBDL=$P($G(^DGCR(399,IBIFN1,I,J,"DEN1",K,0)),"^",7)
 ... I IBDL K ^DGCR(399,"ADT",IBDL,IBIFN1)
 . ;JRA;IB*2.0*608 Add CMN info - Node 'CMN-10126' contains data specific to only the CMS-10126 form, node 'CMN-484' contains data specific to
 . ; only the CMN-484 form, and node 'CMN' contains data common to both forms.
 . I $D(^DGCR(399,IBIFN1,I,J,"CMN")) S ^DGCR(399,IBIFN,I,J,"CMN")=^DGCR(399,IBIFN1,I,J,"CMN")
 . I $D(^DGCR(399,IBIFN1,I,J,"CMN-10126")) S ^DGCR(399,IBIFN,I,J,"CMN-10126")=^DGCR(399,IBIFN1,I,J,"CMN-10126")
 . I $D(^DGCR(399,IBIFN1,I,J,"CMN-484")) S ^DGCR(399,IBIFN,I,J,"CMN-484")=^DGCR(399,IBIFN1,I,J,"CMN-484")
CP1 N DGI,IBCOD
 S IBCOD=$P($G(^DGCR(399,IBIFN,0)),"^",9) Q:IBCOD=""!('$D(^DGCR(399,IBIFN1,"C")))
 I IBCOD=9 F DGI=4,5,6 I $P(^DGCR(399,IBIFN1,"C"),"^",DGI) S X=$P(^("C"),"^",DGI)_";ICD0(",DGPROCDT=$P(^("C"),"^",DGI+7) D FILE
 I IBCOD=4 F DGI=1,2,3 I $P(^DGCR(399,IBIFN1,"C"),"^",DGI) S X=$P(^("C"),"^",DGI)_";ICPT(",DGPROCDT=$P(^("C"),"^",DGI+10) D FILE
 I IBCOD=5 F DGI=7,8,9 I $P(^DGCR(399,IBIFN1,"C"),"^",DGI) S X=$P(^("C"),"^",DGI)_";ICPT(",DGPROCDT=$P(^("C"),"^",DGI+4) D FILE
 Q
 ;
PRV ; Copy providers for cloned claim
 N Z,Z0,CNT
 S Z=$P($G(^DGCR(399,IBIFN,0)),U,19),Z0=$P($G(^DGCR(399,IBIFN1,0)),U,19),CNT=0
 S IBDD=399.0222 F J=0:0 S J=$O(^DGCR(399,IBIFN1,I,J)) Q:'J  I $D(^(J,0)) D
 . I $$GETNPI^IBCEF73A($P(^DGCR(399,IBIFN1,I,J,0),U,2))="" Q  ;Don't file provider if no NPI - IB*2*516
 . S CNT=CNT+1,^DGCR(399,IBIFN,I,CNT,0)=^DGCR(399,IBIFN1,I,J,0),X=$P(^(0),"^")
 . I Z'=Z0,$S(X=3:Z0=3,X=4:Z0=2,1:0) S $P(^DGCR(399,IBIFN,I,CNT,0),U)=(Z0+1)
 I CNT S ^DGCR(399,IBIFN,I,0)=^DGCR(399,IBIFN1,I,0),$P(^DGCR(399,IBIFN,I,0),U,3)=CNT,$P(^DGCR(399,IBIFN,I,0),U,4)=CNT
 Q
 ;
U9 ; Added for new data elements in IB*2.0*447 BI
 M ^DGCR(399,IBIFN,I)=^DGCR(399,IBIFN1,I)
 Q
 ;
COB S J=0 F  S J=$O(IBCOB(I,J)) Q:'J  S $P(^DGCR(399,IBIFN,I),U,J)=IBCOB(I,J)
 Q
 ;
FILE N DIC,DIE,DR,DA,X,Y,DLAYGO,DD,DO
 I '$D(^DGCR(399,IBIFN,"CP",0)) S DIC("P")=$$GETSPEC^IBEFUNC(399,304)
 S DIC(0)="L",DLAYGO=399,DA(1)=IBIFN,DIC="^DGCR(399,"_DA(1)_",""CP""," Q:X=""  D FILE^DICN K DO,DD Q:+Y<1  S DA=+Y
 S DIE="^DGCR(399,"_DA(1)_",""CP"",",DR="1///"_DGPROCDT D ^DIE
 K DGPROCDT
 Q
 ;
INDEX ;index entire file (set logic)
 N IBMAED D SAVERC(IBIFN,.IBMAED)  ; IB*2.0*447 BI - Save the value of piece 16 of each RC node before re-indexing.
 S DIK="^DGCR(399,",DA=IBIFN D IX1^DIK K DA,DIK
 D RESTRC(IBIFN,.IBMAED)  ; IB*2.0*447 BI - Restore the value of piece 16 of each RC node before re-indexing.
 Q
 ;
PRIOR(IBIFN) ; set Secondary/Tertiary Bill #s on prior bills, if the bill is cancelled remove it from prior bills
 N IBSEQ,IBSEQN,IBM1,I,IBIFN1
 S IBSEQ=$$COB^IBCEF(IBIFN)
 S IBSEQN=$S(IBSEQ="S":6,IBSEQ="T":7,1:"") Q:'IBSEQN
 ;
 S IBM1=$G(^DGCR(399,IBIFN,"M1")) I +$P(^DGCR(399,IBIFN,0),U,13)=7 S IBIFN=""
 F I=5,6 I I<IBSEQN  S IBIFN1=+$P(IBM1,U,I) I +IBIFN1,$D(^DGCR(399,+IBIFN1,0)) S $P(^DGCR(399,IBIFN1,"M1"),U,IBSEQN)=IBIFN
 Q
 ;
COBCHG(IBIFN,IBINS,IBCOB) ; Make changes for a new COB payer for bill
 ; IBIFN = ien of bill in file 399
 ; IBINS = ien of bill's current insurance (optional)
 ; IBCOB = array subscripted by node,piece of COB data field change
 ;
 N I,IBFRMTYP,IBTAXLST
 ; Subtract the Prior Payments from the bill's Offset (these are re-added by triggers)
 F I=4,5,6  S $P(^DGCR(399,IBIFN,"U1"),U,2)=$P($G(^DGCR(399,IBIFN,"U1")),U,2)-$P($G(^DGCR(399,IBIFN,"U2")),U,I)
 ;
 I $G(IBINS),$$MCRWNR^IBEFUNC(IBINS) D
 . ;MCRWNR is current insurance ... move payer only
 . N IBCOBN,IBX
 . S IBCOBN=$$COBN^IBCEF(IBIFN)
 . S IBCOB(0,21)=$P("S^T^",U,IBCOBN)
 . S IBCOB("M1",IBCOBN+4)=IBIFN
 . S IBCOB("TX",1)="",IBCOB("TX",2)=""
 . S IBX=$$REQMRA^IBEFUNC(IBIFN)
 . I IBX=0 S IBCOB("TX",5)=0                         ; MRA not needed
 . I IBX["R" S IBCOB("TX",5)="A"                     ; MRA skipped
 . I IBX=1,$$CHK^IBCEMU1(IBIFN) S IBCOB("TX",5)="C"  ; MRA on file
 . I $G(IBPRCOB) S IBCOB("TX",5)="C"                 ; MRA being proc'd
 . D PRIOR(IBIFN)
 . Q
 ;
 ;reset fields for next Sequence Payer
 F I=0,"M1","U2","TX" I $D(IBCOB(I)) D COB
 ;
 ; IB*2.0*211
 ; save off Form Type
 S IBFRMTYP=$P($G(^DGCR(399,IBIFN,0)),U,19)
 ; Save off Taxonomies for providers.
 S I=0 F  S I=$O(^DGCR(399,IBIFN,"PRV",I)) Q:'I  S IBTAXLST(I)=$P($G(^DGCR(399,IBIFN,"PRV",I,0)),U,15)
 ;
 ;vd - IB*2.0*623 (US4100) - Added the following to correctly process MRAs for Alternate Payer ID.
 I $D(^DGCR(399,IBIFN,"M2")) S IBND("M2")=^DGCR(399,IBIFN,"M2")
 ;
 ; fire xrefs set logic
 D INDEX
 ;
 ; Restore Form Type if changed, but don't restore Form Type if
 ;   creating CMS-1500 claim from CTCOPY1^IBCCCB
 I $G(IBCTCOPY)'=1,IBFRMTYP'=$P($G(^DGCR(399,IBIFN,0)),U,19) N DA,DIE,DR S DA=IBIFN,DIE="^DGCR(399,",DR=".19////"_IBFRMTYP D ^DIE
 ;
 ; Restore Claim MRA Status field since triggers in fields 101 & 102
 ;   will overwrite the correct value when processing the MRA/EOB.
 ; If we're processing the MRA/EOB, then a valid MRA has been received.
 I $G(IBPRCOB) N DA,DIE,DR S DA=IBIFN,DIE="^DGCR(399,",DR="24////C" D ^DIE
 ;
 ;vd - Added the following "M2" code for IB*2.0*623 (US4100)
 ; Restore Claim Alternate Payer ID data fields since triggers in fields 140-145
 ;   will overwrite the correct value when CLONing or processing the MRA/EOB. / vd - Added for IB*2.0*623 (US4100)
 I $TR($G(IBND("M2")),U)]"" D  K IBND("M2")
 . N DA,DIE,DR,II,JJ
 . F II=1:1:6 S JJ=$P($G(IBND("M2")),U,II),DA=IBIFN,DIE="^DGCR(399,",DR=(139+II)_"////"_JJ D ^DIE
 ;
 ; Only if cloning, then restore Taxonomies in fields 243 and 244 and 252.
 I '$G(IBINS),'$G(IBPRCOB) D
 . S I=$P($G(IBND("U3")),U,2)
 . I I'=$P($G(^DGCR(399,IBIFN,"U3")),U,2) D
 .. N DA,DIE,DR S DA=IBIFN,DIE="^DGCR(399,",DR="243////"_$S(I'="":I,1:"@") D ^DIE
 . ;
 . S I=$P($G(IBND("U3")),U,3)
 . I I'=$P($G(^DGCR(399,IBIFN,"U3")),U,3) D
 .. N DA,DIE,DR S DA=IBIFN,DIE="^DGCR(399,",DR="244////"_$S(I'="":I,1:"@") D ^DIE
 . ;
 . S I=$P($G(IBND("U3")),U,11)
 . I I'=$P($G(^DGCR(399,IBIFN,"U3")),U,11) D
 .. N DA,DIE,DR S DA=IBIFN,DIE="^DGCR(399,",DR="252////"_$S(I'="":I,1:"@") D ^DIE
 . Q
 ;
 ; Restore Taxonomies in field .15 in sub-file 399.0222.
 S IBTAXLST=0 F  S IBTAXLST=$O(IBTAXLST(IBTAXLST)) Q:'IBTAXLST  D
 . S I=IBTAXLST(IBTAXLST)
 . I I=$P($G(^DGCR(399,IBIFN,"PRV",IBTAXLST,0)),U,15) Q  ; No change
 . N DA,DIE,DR
 . S DA(1)=IBIFN,DA=IBTAXLST
 . S DIE="^DGCR(399,"_DA(1)_",""PRV"",",DR=".15////"_$S(I'="":I,1:"@")
 . D ^DIE
 . Q
 ;
 K IBCOB("TX")
 Q
 ;
SAVERC(IBIFN,IBMAED)  ; IB*2.0*447 BI - Save the value of piece 16 of each RC node before re-indexing.
 Q:$G(IBCTCOPY)=1  Q:$G(IBCTCOPY)=2
 N IBCNT S IBCNT=0
 Q:'$G(IBIFN)  Q:'$D(^DGCR(399,IBIFN,"RC"))
 F  S IBCNT=$O(^DGCR(399,IBIFN,"RC",IBCNT)) Q:+IBCNT=0  D
 . S IBMAED(IBCNT)=$P($G(^DGCR(399,IBIFN,"RC",IBCNT,0)),U,16)
 Q
 ;
RESTRC(IBIFN,IBMAED)  ; IB*2.0*447 BI - Restore the value of piece 16 of each RC node after re-indexing.
 Q:$G(IBCTCOPY)=1  Q:$G(IBCTCOPY)=2
 N IBCNT S IBCNT=0
 Q:'$G(IBIFN)  Q:'$D(^DGCR(399,IBIFN,"RC"))
 F  S IBCNT=$O(IBMAED(IBCNT)) Q:+IBCNT=0  D
 . S $P(^DGCR(399,IBIFN,"RC",IBCNT,0),U,16)=IBMAED(IBCNT)
 Q
