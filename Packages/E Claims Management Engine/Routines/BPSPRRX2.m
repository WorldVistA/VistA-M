BPSPRRX2 ;ALB/SS - ePharmacy secondary billing ;16-DEC-08
 ;;1.0;E CLAIMS MGMT ENGINE;**8,11**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
DISPBILL(BPSPAYSQ,BPSINS,BPSBILL,BPSSTAT,BPSRXIEN,BPSREF,BPSDOS,BPDISTTL) ;
 ;Display list of bills
 ;Input:
 ;  BPSPAYSQ-CURRENT BILL PAYER SEQUENCE as text
 ;  BPSINS-INSURANCE name
 ;  BPSBILL-BILL NUMBER to display "Bill #"
 ;  BPSSTAT-A/R bill status
 ;  BPSRXIEN-Prescription (#52) file IEN
 ;  BPSREF-Fill Number
 ;  BPSDOS-Date of Service
 ;  BPDISTTL (optional)- 1= display title and lines
 N BPSSTR
 S BPSSTR=BPSPAYSQ_": "_BPSINS
 I $G(BPDISTTL) W !,?2,"Payer Responsible",?34,"Bill #",?44,"Status" W:$G(BPSDOS) ?55,"Date"
 I $G(BPDISTTL) W !,?2,"------------------------------",?34,"--------",?44,"------" W:$G(BPSDOS) ?55,"----------"
 W !,?2,$E(BPSSTR,1,30),?34,BPSBILL,?44,BPSSTAT
 W:$G(BPSDOS) ?55,$G(BPSDOS)
 Q
 ;
RATETYPE(BPSDEFRT) ;
 ;Prompt for the rate type
 ;Input:
 ;  BPSDEFRT (optional) - default rate type
 ;Return Value:
 ;  -1 - User exited
 ;  "" - Unsuccessful lookup
 ;  Rate Type Name (#.01) selected by the user
 N X,Y,DUOUT,DTOUT,BPQUIT
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
SUBMCLM(RX,FILL,DOS,BWHERE,PAYSEQ,PLAN,COBDATA,RTYPE) ;
 ;Submit claim and create activity log entry in the Prescription file
 ;Input:
 ;  RX (r) = Prescription IEN
 ;  FILL (r) = Fill Number
 ;  DOS (o) = Date of Service
 ;  BWHERE (r) = RX action
 ;  PAYSEQ (r) = Payer sequence for the claim: 1-primary, 2-secondary
 ;  PLAN (o) = IEN of the entry in the GROUP INSURANCE PLAN file (#355.3)
 ;  COBDATA (o) = Local array passed by reference. Contains data needed to submit a secondary claim (used by secondary only)
 ;  RTYPE (o) = IEN of the Rate Type file (#399.3)
 ;Output:
 ;  Submission result, either "" for invalid parameter or the return value from
 ;    EN^BPSNCPDP - RESPONSE^MESSAGE^ELIGIBILITY^CLAIM STATUS
 ;
 N BPSRET
 I '$G(RX) Q ""
 I $G(FILL)="" Q ""
 I $G(BWHERE)="" Q ""
 I '$G(PAYSEQ) Q ""
 S BPSRET=$$EN^BPSNCPDP(RX,FILL,$G(DOS),BWHERE,"","","","","","",PAYSEQ,"F","","",$G(PLAN),.COBDATA,$G(RTYPE))
 D ECMEACT^PSOBPSU1(RX,FILL,"Claim submitted to third party payer: ECME P2 Bill")
 Q BPSRET
 ;
MORE4SEC(BPSMORE,BPSECNDR) ;
 ; Add COB elements to the MOREDATA array
 ; Called by BPSNCPD4 and BPSNCPD5
 M BPSMORE=BPSECNDR
 Q
 ;
