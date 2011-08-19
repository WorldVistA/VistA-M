IBCCC2 ;ALB/AAS - CANCEL AND CLONE A BILL - CONTINUED ;6/6/03 9:56am
 ;;2.0;INTEGRATED BILLING;**80,106,124,138,51,151,137,161,182,211,245,155,296,320,348,349,371,400,433**;21-MAR-94;Build 36
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;MAP TO DGCRCC2
 ;
 ;STEP 5 - get remainder of data to move and store in MCCR then x-ref
 ;STEP 6 - go to screens, come out to IBB1 or something like that
 ;
STEP5 S IBIFN1=$P(^DGCR(399,IBIFN,0),"^",15) G END:$S(IBIFN1="":1,'$D(^DGCR(399,IBIFN1,0)):1,1:0)
 ;
 ;move pure data nodes
 F I="I1","I2","I3","M1" I $D(^DGCR(399,IBIFN1,I)) S ^DGCR(399,IBIFN,I)=^DGCR(399,IBIFN1,I)
 ;
 ;move top level data node. ;Do not move 'TX' node
 F I="U","U1","U2","U3","UF2","UF3","UF31","C","M" I $D(^DGCR(399,IBIFN1,I)) S IBND(I)=^(I) D @I
 ;
 ;move multiple level data
 F I="CC","OC","OP","OT","RC","CP","CV","PRV" I $D(^DGCR(399,IBIFN1,I,0)) D @I
 ;
 D FTPRV^IBCEU5(IBIFN) ; Ask change prov type if form type not the same
 D COBCHG(IBIFN,,.IBCOB)
 ;
 D ^IBCCC3 ; copy table files (362.3)
 ;
 S I=$G(^DGCR(399,IBIFN1,0)) I $P(I,U,13)=7,$P(I,U,20)=1 D COPYB^IBCDC(IBIFN1,IBIFN) ; update auto bill files
 D PRIOR(IBIFN) ; add new bill to previous bills in series, primary/secondary
 I +$G(IBCTCOPY) N IBAUTO S IBAUTO=1 D PROC^IBCU7A(IBIFN),BILL^IBCRBC(IBIFN),CPTMOD26^IBCU73(IBIFN) D RECALL^DILFD(399,IBIFN_",",DUZ) G END
 ;
STEP6 N IBGOEND
 ; need to kill CRD flag prior to going back into billing screen in case claim is copied for corresponding claim
 K IBCNCRD
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
 D RECALL^DILFD(399,IBIFN_",",DUZ)
ST1 S IBV=0 D ^IBCSCU,^IBCSC1 I $G(IBPOPOUT) S IBGOEND=1 G IBSCX
 S IBAC=1
 D ^IBCB1
 I $G(IBCIREDT) G ST1
IBSCX ;
 Q
 ;
 ;
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
UF31 F J=3 I $P(IBND("UF31"),"^",J)]"" S $P(^DGCR(399,IBIFN,"UF31"),"^",J)=$P(IBND("UF31"),"^",J)
 Q
C F J=10 I $P(IBND("C"),"^",J)]"" S $P(^DGCR(399,IBIFN,"C"),"^",J)=$P(IBND("C"),"^",J)
 I '$D(^DGCR(399,IBIFN1,"CP")) D CP1
 Q
M F J=1:1:9,11:1:14 I $P(IBND("M"),"^",J)]"" S $P(^DGCR(399,IBIFN,"M"),"^",J)=$P(IBND("M"),"^",J)
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
 S IBDD=399.042 F J=0:0 S J=$O(^DGCR(399,IBIFN1,I,J)) Q:'J  I $D(^(J,0)) S IBND("RC")=^(0) F K=1:1:15 S $P(^DGCR(399,IBIFN,I,J,0),"^",K)=$P(IBND("RC"),"^",K),X=$P(IBND("RC"),"^",K)
 Q
CP S ^DGCR(399,IBIFN,I,0)=^DGCR(399,IBIFN1,I,0)
 I +$G(IBNOCPT) Q
 S IBDD=399.0304 F J=0:0 S J=$O(^DGCR(399,IBIFN1,I,J)) Q:'J  I $D(^(J,0)) S IBND("CP")=^(0),IBND("CP-AUX")=$G(^("AUX")) D
 . F K=1:1:7,9:1:14,16:1:22 S $P(^DGCR(399,IBIFN,I,J,0),"^",K)=$P(IBND("CP"),"^",K)
 . ; esg - 11/2/06 - IB*2*348 - 50.09 field was added - AUX piece [9]
 . I IBND("CP-AUX")'="" F K=1:1:9 S $P(^DGCR(399,IBIFN,I,J,"AUX"),"^",K)=$P(IBND("CP-AUX"),"^",K)
 . I $D(^DGCR(399,IBIFN1,I,J,"MOD",0)) S ^DGCR(399,IBIFN,I,J,"MOD",0)=^DGCR(399,IBIFN1,I,J,"MOD",0) D
 .. S K=0 F  S K=$O(^DGCR(399,IBIFN1,I,J,"MOD",K)) Q:'K  D
 ... I $G(IBNOTC),$P($$MOD^ICPTMOD(+$P($G(^DGCR(399,IBIFN1,I,J,"MOD",K,0)),U,2),"I"),U,2)="TC" Q  ; Don't copy TC modifier from inst to prof bill
 ... S ^DGCR(399,IBIFN,I,J,"MOD",K,0)=^DGCR(399,IBIFN1,I,J,"MOD",K,0)
CP1 S IBCOD=$P($G(^DGCR(399,IBIFN,0)),"^",9) Q:IBCOD=""!('$D(^DGCR(399,IBIFN1,"C")))
 I IBCOD=9 F DGI=4,5,6 I $P(^DGCR(399,IBIFN1,"C"),"^",DGI) S X=$P(^("C"),"^",DGI)_";ICD0(",DGPROCDT=$P(^("C"),"^",DGI+7) D FILE
 I IBCOD=4 F DGI=1,2,3 I $P(^DGCR(399,IBIFN1,"C"),"^",DGI) S X=$P(^("C"),"^",DGI)_";ICPT(",DGPROCDT=$P(^("C"),"^",DGI+10) D FILE
 I IBCOD=5 F DGI=7,8,9 I $P(^DGCR(399,IBIFN1,"C"),"^",DGI) S X=$P(^("C"),"^",DGI)_";ICPT(",DGPROCDT=$P(^("C"),"^",DGI+4) D FILE
 Q
 ;
PRV S ^DGCR(399,IBIFN,I,0)=^DGCR(399,IBIFN1,I,0)
 N Z,Z0
 S Z=$P($G(^DGCR(399,IBIFN,0)),U,19),Z0=$P($G(^DGCR(399,IBIFN1,0)),U,19)
 S IBDD=399.0222 F J=0:0 S J=$O(^DGCR(399,IBIFN1,I,J)) Q:'J  I $D(^(J,0)) D
 . S ^DGCR(399,IBIFN,I,J,0)=^DGCR(399,IBIFN1,I,J,0),X=$P(^(0),"^")
 . I Z'=Z0,$S(X=3:Z0=3,X=4:Z0=2,1:0) S $P(^DGCR(399,IBIFN,I,J,0),U)=(Z0+1)
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
 S DIK="^DGCR(399,",DA=IBIFN D IX1^DIK K DA,DIK
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
