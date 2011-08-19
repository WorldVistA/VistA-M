IBCEU1 ;ALB/TMP - EDI UTILITIES FOR EOB PROCESSING ;10-FEB-99
 ;;2.0;INTEGRATED BILLING;**137,155,296,349,371**;21-MAR-94;Build 57
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
CCOB1(IBIFN,NODE,SEQ) ; Extract Claim level COB data
 ; for a bill IBIFN
 ; NODE = the file 361.1 node(s) to be returned, separated by commas
 ; SEQ = the specific insurance sequence you want returned.  If not =
 ;       1, 2, or 3, all are returned
 ; Returns IBXDATA(COB,n,node)  where COB = COB insurance sequence,
 ;  n is the entry number in file 361.1 and node is the node requested
 ;   = the requested node's data
 ;
 N IB,IBN,IBBILL,IBS,A,B,C
 ;
 K IBXDATA
 ;
 S:$G(NODE)="" NODE=1
 S IB=$P($G(^DGCR(399,IBIFN,"M1")),U,5,7)
 S:"123"'[$G(SEQ) SEQ=""
 ;
 F B=1:1:3 S IBBILL=$P(IB,U,B) I IBBILL S C=0 F  S C=$O(^IBM(361.1,"B",IBBILL,C)) Q:'C  D
 . I '$$EOBELIG(C) Q      ; eob not eligible for secondary claim
 . S IBS=$P($G(^IBM(361.1,C,0)),U,15)   ; insurance sequence
 . I $S('$G(SEQ):1,1:SEQ=IBS) D
 .. F Z=1:1:$L(NODE,",") D
 ... S A=$P(NODE,",",Z)
 ... Q:A=""
 ... S IBN=$G(^IBM(361.1,C,A))
 ... I $TR(IBN,U)'="" S IBXDATA(IBS,C,A)=IBN
 ;
 Q
 ;
CCAS1(IBIFN,SEQ) ; Extract all MEDICARE COB claim level adjustment data
 ; for a bill IBIFN (subfile 361.11 in file 361.1)
 ; SEQ = the specific insurance sequence you want returned.  If not =
 ;       1, 2, or 3, all are returned
 ; Returns IBXDATA(COB,n)  where COB = COB insurance sequence,
 ;       n is the entry number in file 361.1 and
 ;       = the 0-node of the subfile entry (361.11)
 ;    and IBXDATA(COB,n,m) where m is a sequential # and
 ;                         = this level's 0-node
 N IB,IBA,IBS,IB0,IB00,IBBILL,B,C,D,E
 ;
 S IB=$P($G(^DGCR(399,IBIFN,"M1")),U,5,7)
 S:"123"'[$G(SEQ) SEQ=""
 ;
 F B=1:1:3 S IBBILL=$P(IB,U,B) I IBBILL S C=0 F  S C=$O(^IBM(361.1,"B",IBBILL,C)) Q:'C  D
 . I '$$EOBELIG(C) Q      ; eob not eligible for secondary claim
 . S IBS=$P($G(^IBM(361.1,C,0)),U,15)   ; insurance sequence
 . I $S('$G(SEQ):1,1:SEQ=IBS) D
 .. S (IBA,D)=0 F  S D=$O(^IBM(361.1,C,10,D)) Q:'D  S IB0=$G(^(D,0)) D
 ... S IBXDATA(IBS,D)=IB0
 ... S (IBA,E)=0
 ... F  S E=$O(^IBM(361.1,C,10,D,1,E)) Q:'E  S IB00=$G(^(E,0)) D
 .... S IBA=IBA+1
 .... I $TR(IB00,U)'="" S IBXDATA(IBS,D,IBA)=IB00
 ;
 Q
 ;
SEQ(A) ; Translate sequence # A into corresponding letter representation
 S A=$E("PST",A)
 I $S(A'="":"PST"'[A,1:1) S A="P"
 Q A
 ;
EOBTOT(IBIFN,IBCOBN) ; Total all EOB's for a bill's COB sequence
 ; Function returns the total of all EOB's for a specific COB seq
 ; IBIFN = ien of bill in file 399
 ; IBCOBN = the # of the COB sequence you want EOB/MRA total for (1-3)
 ;
 N Z,Z0,IBTOT
 S IBTOT=0
 I $O(^IBM(361.1,"ABS",IBIFN,IBCOBN,0)) D
 . ; Set up prior payment field here from MRA/EOB(s)
 . S (IBTOT,Z)=0
 . F  S Z=$O(^IBM(361.1,"ABS",IBIFN,IBCOBN,Z)) Q:'Z  D
 .. ; HD64841 IB*2*371 - total up the payer paid amounts
 .. S IBTOT=IBTOT+$P($G(^IBM(361.1,Z,1)),U,1)
 Q IBTOT
 ;
 ;
LCOBOUT(IBXSAVE,IBXDATA,COL) ; Output the line adjustment reasons COB
 ;  line # data for an electronic claim
 ; IBXSAVE,IBXDATA = arrays holding formatter information for claim -
 ;                   pass by reference
 ; COL = the column in the 837 flat file being output for LCAS record
 N LINE,COBSEQ,RECCT,GRPCD,SEQ,RCCT,RCPC,DATA,RCREC,SEQLINE K IBXDATA
 S (LINE,RECCT)=0
 S RCPC=(COL#3) S:'RCPC RCPC=3
 S RCREC=$S(COL'<4:COL-1\3,1:0)
 ;S RCREC=$S(COL'<4:COL+5\6-1,1:0)
 F  S LINE=$O(IBXSAVE("LCOB",LINE)) Q:'LINE  D
 . S COBSEQ=0
 . F  S COBSEQ=$O(IBXSAVE("LCOB",LINE,"COB",COBSEQ)) Q:'COBSEQ  S SEQLINE=0 F  S SEQLINE=$O(IBXSAVE("LCOB",LINE,"COB",COBSEQ,SEQLINE)) Q:'SEQLINE  S GRPCD="" F  S GRPCD=$O(IBXSAVE("LCOB",LINE,"COB",COBSEQ,SEQLINE,GRPCD)) Q:GRPCD=""  D
 .. S RECCT=RECCT+1
 .. I COL=2 S IBXDATA(RECCT)=LINE,DATA=LINE D:RECCT>1 ID^IBCEF2(RECCT,"LCAS")
 .. I COL=3 S IBXDATA(RECCT)=$TR(GRPCD," ")
 .. S (SEQ,RCCT)=0
 .. F  S SEQ=$O(IBXSAVE("LCOB",LINE,"COB",COBSEQ,SEQLINE,GRPCD,SEQ)) Q:'SEQ  I $TR($G(IBXSAVE("LCOB",LINE,"COB",COBSEQ,SEQLINE,GRPCD,SEQ)),U)'="" D
 ... S RCCT=RCCT+1
 ... Q:COL'<4&(RCCT'=RCREC)&(RCCT'>6)
 ... S DATA=$S(COL=2:LINE,COL=3:$TR(GRPCD," "),1:$P($G(IBXSAVE("LCOB",LINE,"COB",COBSEQ,SEQLINE,GRPCD,SEQ)),U,RCPC))
 ... I COL'<4,RCCT=RCREC S:DATA'="" IBXDATA(RECCT)=DATA Q
 ... I RCCT>6 S RCCT=1,RECCT=RECCT+1 D:COL=2 ID^IBCEF2(RECCT,"LCAS") I DATA'="",$S(COL'>3:1,1:RCCT=RCREC) S IBXDATA(RECCT)=DATA
 Q
 ;
CCOBOUT(IBXSAVE,IBXDATA,COL) ; Output the claim adjustment reasons COB
 ;  data for an electronic claim
 ; IBXSAVE,IBXDATA = arrays holding formatter information for claim -
 ;                   pass by reference
 ; COL = the column in the 837 flat file being output for CCAS record
 N COBSEQ,RECCT,GRPSEQ,SEQ,RCPC,RCCT,RCREC,DATA K IBXDATA
 S RECCT=0
 S RCPC=(COL#3) S:'RCPC RCPC=3
 S RCREC=$S(COL'<4:COL+5\6-1,1:0)
 S COBSEQ=0
 F  S COBSEQ=$O(IBXSAVE("CCAS",COBSEQ)) Q:'COBSEQ  S GRPSEQ="" F  S GRPSEQ=$O(IBXSAVE("CCAS",COBSEQ,GRPSEQ)) Q:GRPSEQ=""  D
 . S RECCT=RECCT+1
 . I COL=2 S IBXDATA(RECCT)=COBSEQ D:RECCT>1 ID^IBCEF2(RECCT,"CCAS")
 . I COL=3 S IBXDATA(RECCT)=$P($G(IBXSAVE("CCAS",COBSEQ,GRPSEQ)),U)
 . S (SEQ,RCCT)=0
 . F  S SEQ=$O(IBXSAVE("CCAS",COBSEQ,GRPSEQ,SEQ)) Q:'SEQ  I $TR($G(IBXSAVE("CCAS",COBSEQ,GRPSEQ,SEQ)),U)'="" D
 .. S RCCT=RCCT+1
 .. Q:COL'<4&(RCCT'=RCREC)&(RCCT'>6)
 .. S DATA=$S(COL=2:COBSEQ,COL=3:$P($G(IBXSAVE("CCAS",COBSEQ,GRPSEQ)),U),1:$P($G(IBXSAVE("CCAS",COBSEQ,GRPSEQ,SEQ)),U,RCPC))
 .. I COL'<4,RCCT=RCREC S:DATA'="" IBXDATA(RECCT)=DATA Q
 .. I RCCT>6 S RCCT=1,RECCT=RECCT+1 D:COL=2 ID^IBCEF2(RECCT,"CCAS") I DATA'="",$S(COL'>3:1,1:RCCT=RCREC) S IBXDATA(RECCT)=DATA
 Q
 ;
COBOUT(IBXSAVE,IBXDATA,CL) ; build LCOB segment data
 ; The IBXSAVE array used here is built by INS-2, then LCOB-1.9
 ; This is basically the 361.115, but all the piece numbers here in this
 ; local array are one higher than the pieces in subfile 361.115.
 N Z,M,N,P,PCCL
 S (N,Z,P)=0 F  S Z=$O(IBXSAVE("LCOB",Z)) Q:'Z  D
 . S N=N+1
 . S M=$O(IBXSAVE("LCOB",Z,"COB",""),-1) Q:'M
 . S P=$O(IBXSAVE("LCOB",Z,"COB",M,""),-1) Q:'P
 . S PCCL=$P($G(IBXSAVE("LCOB",Z,"COB",M,P)),U,CL)
 . S:PCCL'="" IBXDATA(N)=PCCL
 . Q
 Q
 ;
COBPYRID(IBXIEN,IBXSAVE,IBXDATA) ; cob insurance company payer id
 N CT,N,NUM
 K IBXDATA
 I '$D(IBXSAVE("LCOB")) G COBPYRX
 D ALLPAYID^IBCEF2(IBXIEN,.NUM,1)
 S NUM=$G(NUM(1))
 S NUM=$E(NUM_$J("",5),1,5)
 S (CT,N)=0
 F  S N=$O(IBXSAVE("LCOB",N)) Q:'N  S CT=CT+1,IBXDATA(CT)=NUM
COBPYRX ;
 Q
 ;
EOBELIG(IBEOB) ; EOB eligibility for secondary claim
 ; Function to decide if EOB entry in file 361.1 (ien=IBEOB) is
 ; eligible to be included for secondary claim creation process
 ; The EOB is not eligible if the review status is not 3, or if there
 ; is no insurance sequence indicator, or if the EOB has been DENIED
 ; and the patient responsibility for that EOB is $0 and that EOB is
 ; not a split EOB.  Split EOB's need to be included (IB*2*371).
 ;
 NEW ELIG,IBDATA,PTRESP
 S ELIG=0
 I '$G(IBEOB) G EOBELIGX
 S IBDATA=$G(^IBM(361.1,IBEOB,0))
 I $P(IBDATA,U,4)'=1 G EOBELIGX      ; Only MRA EOB's for now
 I $D(^IBM(361.1,IBEOB,"ERR")) G EOBELIGX     ; filing error
 I $P(IBDATA,U,16)'=3 G EOBELIGX     ; review status - accepted-complete
 I '$P(IBDATA,U,15) G EOBELIGX       ; insurance sequence must exist
 S PTRESP=$P($G(^IBM(361.1,IBEOB,1)),U,2)     ; Pt Resp Amount for 1500s
 I $$FT^IBCEF(+IBDATA)=3 S PTRESP=$$PTRESPI^IBCECOB1(IBEOB)  ; for UBs
 I PTRESP'>0,$P(IBDATA,U,13)=2,'$$SPLIT^IBCEMU1(IBEOB) G EOBELIGX     ; Denied & No Pt. Resp. & not a split MRA
 ;
 S ELIG=1
EOBELIGX ;
 Q ELIG
 ;
EOBCNT(IBIFN) ; This function counts up the number of EOBs that are eligible
 ; for the secondary claim creation process for a given bill#.
 NEW CNT,IEN
 S (CNT,IEN)=0
 F  S IEN=$O(^IBM(361.1,"B",+$G(IBIFN),IEN)) Q:'IEN  D
 . I $$EOBELIG(IEN) S CNT=CNT+1
 . Q
EOBCNTX ;
 Q CNT
 ;
