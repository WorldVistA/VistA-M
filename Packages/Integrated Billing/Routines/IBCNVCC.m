IBCNVCC ;ALB/BAA - Module for PATIENT INSURANCE CONSISTENCY CHECKER LOGIC ;25 Feb 2015
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; IB SSVI
 ;        INPUT
 ;            DFN = PATIENT DFN
 ;         INSPTR = INSURANCE TYPE MULTIPLE IEN
 ;
 ;linetags in routines correspond to IEN of file 366.2
 ;
 ;variables:  DGVT = 1 if VETERAN? = YES, 0 if NO
 ;            DGSC = 1 if SC? = YES, 0 if NO
 ;            DGCD = 0 node of file EC file (#8)
 ;           DGCHK = #s to check (separated by ,s)
 ;           DGLST = next # to check
 ;            DGER = inconsistencies found (separated by ,s)
 ;           DGNCK = 1 if missing key IB SUPERVISOR  data...can't process further
 ;
EN(DFN,INSPTR) ; need patient and insurance pointer
 N ANYMSE,CONARR,CONCHK,CONERR,CONSPEC,LOC,I5,I6,DGER,DGCHK,DGP,EXIT,DGLDT,DGLST
 N MSECHK,MSESET,MSERR,MSDATERR,RANGE,RANSET,DUOUT,I,I1
 N DGEND1,INSURCO,PLAN,PRH,PRI,DGCT,INSMUL,DGD,X
 ;
 S INSMUL=0
EN4  ; Make sure DFN and INSPTR not null
 I DFN=""!(INSPTR="") Q
 F I=0,1,2,3,4,5,7 S DGP(I)=$G(^DPT(DFN,.312,INSPTR,I))
 S INSURCO=$P(DGP(0),"^",1) I INSURCO'="" S INSURCO=$P($G(^DIC(36,INSURCO,0)),"^",1) ;W !,"Press return to continue." R X:DTIME W !!,"INSURANCE COMPANY - ",INSURCO
 S DGEND1=16  ; END LAST RULE OF INCONSISTENCY CHECKS (LAST RULE +1)
 S DGCHK="," F I=0:0 S I=$O(^IBCN(366.2,I)) Q:'I!(I=DGEND1)  I $D(^IBCN(366.2,I,0)),$S(I=1:1,I=2:1,'$P(^IBCN(366.2,I,0),"^",5):1,1:0),I'=DGEND1 S DGCHK=DGCHK_I_","
 S (DGCT,DGER)=""
 S DGLST=+$P(DGCHK,",",2) G @DGLST
1 ;INSURANCE TYPE (INSURANCE COMPANY NAME)
 ;CHECK INACTIVE INSURANCE FIRST OR NULLED POINTER
 S X=""
 S DGD=$P(DGP(0),"^",1) I (DGD="") S X=1 D COMB,NEXT I +DGLST'=2 G @DGLST
 I $P($G(^DIC(36,DGD,0)),"^",5) S X=1 D COMB,NEXT I +DGLST'=2 G @DGLST
 ;CHECK IF VALID POINTER ( IF DELETED, ETC, USUALLY IF NO OUTSTANDING BILLS)
 S I=0 S I=$P($G(^DIC(36,DGD,0)),"^",1) S I1=0 I I'="" S I1=$O(^DIC(36,"B",I,I1))
 I 'I1 S X=1 D COMB
 D NEXT I +DGLST'=2 G @DGLST
2 ;GROUP PLAN
 S PLAN="",X=""
 S I1=0 ; INCONSISTENT
 S I1=$P(DGP(0),"^",18)
 I I1'="" S PLAN=I1 S I1=$P($G(^IBA(355.3,I1,0)),"^",11) D
 .I I1=1 D
 ..S I1=0  ; INACTIVE GROUP PLAN
 .E  D
 ..I (I1=0)!(I1="") S I1=1 ; ACTIVE OR NOT SPECIFIED
 ;
 I (I1="")!('I1) S PLAN="" S X=2 D COMB
 D NEXT I +DGLST'=3 G @DGLST
3 ; COORDINATION OF BENEFITS
 ; CHECK SET OF CODES
 I '(($P(DGP(0),"^",20)=1)!($P(DGP(0),"^",20)=2)!($P(DGP(0),"^",20)=3)) S X=3 D COMB
 D NEXT I +DGLST'=4 G @DGLST
4 ;SUBCRIBER ID
 S X=""
 I $P(DGP(7),U,2)="" S X=4 D COMB
 D NEXT I +DGLST'=5 G @DGLST
 ;
5 ;DATE LAST VERIFIED
 S X=""
 D NEXT I +DGLST'=6 G @DGLST
 ;
6 ;*GROUP NUMBER(REALLY FOR COMPUTED NEW GROUP NUMBER, BUT CHECK IN PLAN'S GROUP NUMBER)
 S PLAN=$G(PLAN),X=""
 I PLAN="" S PLAN=$P(DGP(0),"^",18)
 I PLAN="" S X=6 D COMB,NEXT G @DGLST
 I $P($G(^IBA(355.3,PLAN,0)),"^",4)="" S X=6 D COMB
 D NEXT I +DGLST'=7 G @DGLST
 ;
7 ;INSURED'S DOB
 S X=""
 I $P(DGP(3),U,1)="" S X=7 D COMB
 D NEXT I +DGLST'=8 G @DGLST
 ;
8 ;INSURED'S SSN
 S X=""
 I ($P(DGP(3),U,5)=""),($P(DGP(7),U,2)="") S X=8 D COMB
 D NEXT I +DGLST'=9 G @DGLST
 ;
 ;
9 ;INSURED'S SEX
 S X=""
 I ($P(DGP(3),U,12)="") S X=9 D COMB ; ($P(DGP(3),U,12)'="M")&($P(DGP(3),U,12)'="F") S X=9 D COMB
 D NEXT I +DGLST'=10 G @DGLST
 ;
10 ;PT. RELATIONSHIP-HIPAA
 S X=""
 ;
 S PRH=$P(DGP(4),U,3) I (PRH'="01")&(PRH'=18)&(PRH'=19)&(PRH'=20)&(PRH'=29)&(PRH'=32)&(PRH'=33)&(PRH'=39)&(PRH'=41)&(PRH'=53)&(PRH'="G8") S X=10 D COMB
 ;
 D NEXT I +DGLST'=11 G @DGLST
 ;
11 ;WHOSE INSURANCE
 S X=""
 I ($P(DGP(0),U,6)'="v")&($P(DGP(0),U,6)'="s")&($P(DGP(0),U,6)'="o") S X=11 D COMB
 ;
 D NEXT I +DGLST'=12 G @DGLDT
 ;
12 ;EFFECTIVE DATE OF POLICY
 S X=""
 I $P(DGP(0),U,8)="" S X=12 D COMB
 ;
 D NEXT I +DGLST'=13 G @DGLST
 ;
13 ; *GROUP NAME ((REALLY FOR COMPUTED NEW GROUP NAME, BUT CHECK IN PLAN'S GROUP NAME)
 S X=""
 I PLAN="" S X=13 D COMB,NEXT G @DGLST
 I $P($G(^IBA(355.3,PLAN,0)),"^",3)="" S X=13 D COMB
 D NEXT I +DGLST'=14 G @DGLST
 ;
14 ;PT. RELATIONSHIP TO INSURED
 S X=""
 S PRI=$P(DGP(0),U,16) I (PRI'="01")&(PRI'="02")&(PRI'="03")&(PRI'="08")&(PRI'="09")&(PRI'="11")&(PRI'="15")&(PRI'="18")&(PRI'="32")&(PRI'="33")&(PRI'="34")&(PRI'="35")&(PRI'="36") S X=14 D COMB
 D NEXT I +DGLST'=15 G @DGLST
 ;
15 ;NAME OF INSURED
 S X=""
 I $P(DGP(0),U,17)="" S X=15 D COMB
 ;
16 ;
 S X=""
99 ; synonymous with END
 ;
END ; end of routine...find next check to execute (or goto end)
 D ^IBCNVCC1
 Q
 ;
COMB ;record inconsistency
 S DGCT=DGCT+1,DGER=DGER_X_",",DGLST=X Q
 Q
 ;
NEXT ; find the next consistency check to check (goto end if can't process further)
 S I=$F(DGCHK,(","_DGLST_",")),DGLST=+$E(DGCHK,I,999) I +DGLST,DGLST<18 Q
 Q
 ;
COMB1 S DGCT=DGCT+1,DGER=DGER_X_",",DGLST=X Q
 ;
NEXT1 S I=$F(DGCHK,(","_+DGLST_",")),DGLST=+$E(DGCHK,I,999) S:'DGLST DGLST="END"
 Q
