BPSPRRX2 ;ALB/SS - ePharmacy secondary billing ;16-DEC-08
 ;;1.0;E CLAIMS MGMT ENGINE;**8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
 ;BPSPAYSQ-CURRENT BILL PAYER SEQUENCE as text
 ;BPSINS-INSURANCE name
 ;BPSBILL-BILL NUMBER to display "Bill #"
 ;BPSSTAT-A/R bill status
 ;BPSRXIEN-ien of file #52
 ;BPSREF-refill #
 ;BPDISTTL (optional)- 1= display title and lines
DISPBILL(BPSPAYSQ,BPSINS,BPSBILL,BPSSTAT,BPSRXIEN,BPSREF,BPSDOS,BPDISTTL) ;
 N BPSSTR
 S BPSSTR=BPSPAYSQ_": "_BPSINS
 I $G(BPDISTTL) W !,?2,"Payer Responsible",?34,"Bill #",?44,"Status" W:$G(BPSDOS) ?55,"Date"
 I $G(BPDISTTL) W !,?2,"------------------------------",?34,"--------",?44,"------" W:$G(BPSDOS) ?55,"----------"
 W !,?2,$E(BPSSTR,1,30),?34,BPSBILL,?44,BPSSTAT
 W:$G(BPSDOS) ?55,$G(BPSDOS)
 Q
 ;prompt for the rate type
 ;BPSDEFRT (optional) - default rate type
RATETYPE(BPSDEFRT) ;
 N Y,DUOUT,DTOUT,BPQUIT,DIROUT
 S BPQUIT=0
 N DIC
 S DIC="^DGCR(399.3,"
 S DIC(0)="AEMNQ"
 S DIC("A")="SELECT RATE TYPE: "
 I $G(BPSDEFRT)>0 S DIC("B")=BPSDEFRT
 D ^DIC
 I (X="^")!$D(DUOUT)!$D(DTOUT) S BPQUIT=1
 I BPQUIT=1 Q -1
 I Y=-1,X="" Q ""
 Q $P(Y,U)
 ;
 ;Input:
 ; BRXIEN = Prescription IEN
 ; BFILL = Fill Number
 ; BFILLDAT = Fill Date of current prescription and fill number
 ; BPWHERE = RX action (BWHERE)
 ; BILLNDC = Valid NDC# with format 5-4-2
 ; BPPAYSEQ = the payer sequence for the claim: 1-primary, 2-secondary.
 ; BPSPLAN = (optional - used by secondary only) IEN of the entry in the GROUP INSURANCE PLAN file (#355.3)
 ; BPSPRDAT -(optional - used by secondary only) local array passed by reference. Contains primary claim data needed to submit a secondary claim.
 ;   Format: BPSPRDAT ("required field for secondary")
 ; BPSRTYPE =  (optional) rate type ( ien of the file #399.3)
 ; BPREVRES - (optional) reverse reason (like "ECME RESUBMIT")
 ; BPOVRPTR - (optional) Pointer to BPS NCPDP OVERIDE file.  This parameter will 
 ;            only be passed if there are overrides entered by the
 ;            user via the Resubmit with Edits (RED) option in the 
 ;            user screen.
 ;Output:
 ; Submission result (return value of EN^BPSNCPDP)
 ; RESPONSE^MESSAGE^ELIGIBILITY^CLAIMSTATUS
 ;
SUBMCLM(BRXIEN,BFILL,BFILLDAT,BPWHERE,BILLNDC,BPPAYSEQ,BPSPLAN,BPSPRDAT,BPSRTYPE,BPREVRES,BPOVRPTR) ;
 N BPSRET,BP59,BPSWCM,BPSTAT,BPZX
 S BPSRET=$$EN^BPSNCPDP(BRXIEN,BFILL,BFILLDAT,BPWHERE,BILLNDC,$G(BPREVRES),"",$G(BPOVRPTR),"","",BPPAYSEQ,"F","","",BPSPLAN,.BPSPRDAT,BPSRTYPE)
 S BP59=$$IEN59^BPSOSRX(BRXIEN,BFILL,BPPAYSEQ)
 S BPSWCM=$$MWC^PSOBPSU2(BRXIEN,BFILL)
 S BPSTAT=$S($P(BPSRET,U,4)["IN PROGRESS":"",1:$P(BPSRET,U,4)_"-")
 S BPZX="ECME:"_$S(BPSWCM="M":"MAIL",BPSWCM="W":"WINDOW",BPSWCM="C":"CMOP",1:"")_$S(BFILL>0:" RE",1:" ")_"FILL(NDC:"_$$GETNDC^PSONDCUT(BRXIEN,BFILL)_")-"_BPSTAT_$S(BPPAYSEQ=1:"p",BPPAYSEQ=2:"s",1:"")_$$INSNAME^BPSSCRU6(BP59)
 D ECMEACT^PSOBPSU1(BRXIEN,BFILL,BPZX)
 Q BPSRET
 ;add secondary e-claim related elements to MOREDATA
MORE4SEC(BPSMORE,BPSECNDR) ;
 M BPSMORE=BPSECNDR
 Q
 ;
