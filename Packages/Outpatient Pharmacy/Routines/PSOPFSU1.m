PSOPFSU1 ;BIR/LE,AM - PFSS Charge Message & Utilities ;08/09/93
 ;;7.0;OUTPATIENT PHARMACY;**201,225**;DEC 1997;Build 29
 ;External reference CHARGE^IBBAPI and GETCHGID^IBBAPI supported by DBIA 4665
 Q
 ;
CHRG(PSORXN,PSOREF,PSOCHTYP,PSOPFS) ;ENTRY POINT:  
 ;Used to pass charge msg info to an external billing system via IBB API's   
 ;       Inputs:  PSORXN = RX IEN, PSOREF = fill number, PSOCHTYP = "CG" for Charge or "CD" for Credit transaction,
 ;                PSOPFS = switch status (0 or 1) ^ PFSS Account Reference for the fill ^ PFSS Charge ID for the fill
 ;       Outputs:  none
 ;       
 N I,CLDIV,IFN,J,PSODG,PSOZCL,PSOCHID,PSOPFSA,PSODFN,PSORX,PSOFT1,PSODRG,PSODRUG,PSORXE,PSOCHG,PSOFD,PSOFT,PSOFLD
 ; quit if PFSS switch is off or not defined
 Q:'+$G(PSOPFS)
 ;
 ; check for CHARGE LOCATION before processing charge message.
 S CLDIV=$$CHLOC^PSOPFSU0()
 Q:CLDIV<1  ;if no CHARGE LOCATION, don't send charge message to either IB or external billing system.
 ;
 ; check for PFSS Acct Reference; if not one define, request one
 S PSOPFSA=$P(PSOPFS,"^",2)
 I PSOPFSA<1 D PFSI(PSORXN,PSOREF) S PSOPFSA=$P(PSOPFS,"^",2) I PSOPFSA<1 D  ;because PSOCP is too large, need to check for/get them here
 .S PSOPFSA=$$GACT^PSOPFSU0(PSORXN,PSOREF)
 Q:PSOPFSA<1  ;Normally IB returns an acct ref or zero for unsuccessful if a problem is encountered.  
 ; If IBB didn't return a value, don't send charge message because IBB will produce a hard error.  Subsequent phase of PFSS will provide further error handling.
 ;
 ; check for PFSS Charge ID. If no charge ID, means Rx never sent to external bill sys or there was a problem retrieve one.
 S PSOCHID=$P(PSOPFS,"^",3)
 ;If no Charge ID is  defined, request a Unique Charge ID and store it in file 52
 I PSOCHID<1 S PSOCHID=$$GETCHGID^IBBAPI() I PSOCHID>0 D
 . I PSOREF=0 S $P(^PSRX(PSORXN,"PFS"),"^",2)=PSOCHID  ;set directly for speed (CMOPs, etc.)
 . I PSOREF>0 S $P(^PSRX(PSORXN,1,PSOREF,"PFS"),"^",2)=PSOCHID
 Q:PSOCHID<1  ;no charge message will be sent if can't get a PFSS CHARGE ID from IB.  Subsequent phase of PFSS will provide error handling for this type problem.
 ;Retrieve all fields to pass for the charge message
 S PSOFT="4,10,21" I PSOREF=0 D CHRGOF
 I PSOREF>0 D CHRGRF
 ;Get general Rx data fields
 D GETS^DIQ(52,PSORXN,"2;3;6;105","I","PSORX")
 S PSOFT1(29)=$$NDC^PSOHDR(PSORXN,PSOREF,$S(PSOREF>0:"R",1:""))
 S PSODFN=$G(PSORX(52,PSORXN_",",2,"I")),PSODRG=$G(PSORX(52,PSORXN_",",6,"I")),PSOFT1(31)=$G(PSORX(52,PSORXN_",",105,"I"))
 D DATA^PSS50(PSODRG,,,,,"PSOSC")
 ;S PSOFT1(2)="PSO"_PSORXN_"F"_PSOREF  ;12/6/05; DECISION MADE TO NOT SEND clinicial event indicator FOR OP
 S PSOFT1(7)=$G(^TMP($J,"PSOSC",PSODRG,400)),PSOFT1(6)=PSOCHTYP,PSOFT1(13)=160
 S PSOFT1(18)=$G(PSORX(52,PSORXN_",",3,"I")),PSOFT1(18)=$$GET1^DIQ(53,PSOFT1(18)_",",15,"I")
 S PSOFT1(22)=$FN($G(^TMP($J,"PSOSC",PSODRG,16)),"",2),PSOFT1(29)=PSOFT1(29)_";"_$G(^TMP($J,"PSOSC",PSODRG,.01))
 S PSORXE(31)=$G(^TMP($J,"PSOSC",PSODRG,3)),PSORXE(17)=PSOREF
 S:(PSORXE(18)="") PSORXE(18)=$G(RELDT)  ;CMOP
 S PSORXE(15)=PSORXN
 S PSOCHG=$$CHARGE^IBBAPI(PSODFN,PSOPFSA,PSOCHTYP,PSOCHID,.PSOFT1,"",.PSODG,.PSOZCL,.PSORXE,"","")
 ;errors to be handled in subsequent phase
 K ^TMP($J,"PSOSC")
 Q
 ;
CHRGOF ;Retrieve charge fields for orig fills
 D GETS^DIQ(52,PSORXN,"4;7;8;22;31;125","I","PSORX")
 S PSOFD="22,7,4"
 F I=1:1 S PSOFLD=$P(PSOFD,",",I) Q:PSOFLD=""  S PSOFT1($P(PSOFT,",",I))=$G(PSORX(52,PSORXN_",",$P(PSOFD,",",I),"I"))
 S PSOPFSA=$G(PSORX(52,PSORXN_",",125,"I")),PSORXE(18)=$G(PSORX(52,PSORXN_",",31,"I"))
 S PSORXE(1)=PSOFT1(10)_";;"_$G(PSORX(52,PSORXN_",",8,"I"))
 D GOC
 Q
 ;
CHRGRF ;Retrieve charge fields for refills
 D GETS^DIQ(52.1,PSOREF_","_PSORXN,".01;1;1.1;15;17;21","I","PSORX")
 S PSOFD=".01,1,15"
 F I=1:1 S PSOFLD=$P(PSOFD,",",I) Q:PSOFLD=""  S PSOFT1($P(PSOFT,",",I))=$G(PSORX(52.1,PSOREF_","_PSORXN_",",$P(PSOFD,",",I),"I"))
 S PSOPFSA=$G(PSORX(52.1,PSOREF_","_PSORXN_",",21,"I")),PSORXE(18)=$G(PSORX(52.1,PSOREF_","_PSORXN_",",17,"I"))
 S PSORXE(1)=PSOFT1(10)_";;"_$G(PSORX(52.1,PSOREF_","_PSORXN_",",1.1,"I"))
 D GOC
 Q
 ;
GOC ;Called from CHRGOF, CHRGRF.  Parse OP classifications and ICD's.  Don't send null values.
 D GETS^DIQ(52,PSORXN,"52311*","I","PSORX")
 F I=1:1 Q:'$D(PSORX(52.052311,I_","_PSORXN_","))  D
 . S:PSORX(52.052311,I_","_PSORXN_",",".01","I")'="" PSODG(I,3)=PSORX(52.052311,I_","_PSORXN_",",".01","I"),PSODG(I,6)="F"
 . I I=1 F J=1:1:8 Q:'$D(PSORX(52.052311,I_","_PSORXN_",",J,"I"))  D
 . . S:PSORX(52.052311,I_","_PSORXN_",",J,"I")'="" PSOZCL(J,2)=J,PSOZCL(J,3)=PSORX(52.052311,I_","_PSORXN_",",J,"I")
 S:'$D(PSOZCL) PSOZCL="" S:'$D(PSODG) PSODG=""
 Q
 ;
CG ;Called from PSOCPB; for the last fill, send chrg message if released; PSOCPB too large for more code.
 ; this is used for SC/EI changes when no charges are cancelled.  Expects to have PSODA = RXIEN and PSOLFIL= fill#
 ;N REL,PFS
 ;I 'PSOLFIL S REL=$$GET1^DIQ(52,PSODA_",","31","I")
 ;I PSOLFIL>0 S REL=$$GET1^DIQ(52.1,PSOLFIL_","_PSODA_",","17","I")  ;REFILL
 ;I REL'=""&(PSOPFS)&(+$G(PSOPFSA)) D CHRG(PSODA,PSOLFIL,"CG",PSOPFS)
 Q
 ;
LF(PSODA) ;return last fill number;CALLED from PSOCPB
 N LF
 I $D(^PSRX(PSODA,1,0)) S LF="A",LF=$O(^PSRX(PSODA,1,LF),-1) Q LF
 Q 0  ;ORIG FILL
 ;
PFSI(PSODA,PSOREF) ;get PFSS Acct Ref and Charge ID and store in PSOPFS; Called from multiple places in this routine
 I PSOREF=0&($D(^PSRX(PSODA,"PFS"))) S PSOPFS=PSOPFS_"^"_$P(^PSRX(PSODA,"PFS"),"^",1,2) Q
 I PSOREF>0&($D(^PSRX(PSODA,1,PSOREF,"PFS"))) S PSOPFS=PSOPFS_"^"_$P(^PSRX(PSODA,1,PSOREF,"PFS"),"^",1,2)
 Q
 ;
PFSA(PSODA,PSOREF,WR) ;called from PSOCP (WR=2) and PSOCPB (WR=3)
 ;get switch status, acct ref, and charge ID, then validate switch vs availability of PFSS acct ref
 Q:'$G(WR)
 S PSOPFS=+$$SWSTAT^IBBAPI()
 D PFSI(PSODA,PSOREF)
 ; if switch is off, but have an PFSS Acct Ref for new orders, send charge to IDX
 ; if switch is off, but have a Charge ID, send cancel charge to IDX
 I '+PSOPFS,$P(PSOPFS,"^",WR)>0 S $P(PSOPFS,"^")=1
 Q
 ;
PFS ;;Called from PSOCPB; PSOCPB is too large to hold more code.  Processes copay cancels for PFS only.
 ;find any fills being cancelled for PFSS, cancel them, and remove them from PSOCAN, then return to PSOCP to process any IB cancels
 ;
 N X,I,PSOREF,PSOOLD,PREA,PSONW
 ;If it's a PFS fill, if released, and not previously cancelled, set the X array, then kill it out of PSOCAN array.
 ;Killed out of PSOCAN because don't want the IB processing to look at PFSS billed fills.
 ;Note that in PSOCPD, PFS entries are not stored in PSOCAN array if a charge ID is not defined.  So, don't have to check for release date. 
 ;If prev cancelled and PFS, kill it from PSOCAN array
 S I="" F  S I=$O(PSOCAN(I)) Q:I=""  S PSOREF=+PSOCAN(I) D
 . I PSOREF=PSODA&($P(PSOCAN(I),"^",10)="PFS") D  Q
 . . I $P(PSOCAN(I),"^",5)["CANCEL" K PSOCAN(I) Q
 . . S X(0)=$P(PSOCAN(I),"^",2)_"^"_PSORSN K PSOCAN(I)
 . I PSOREF'=PSODA&($P(PSOCAN(I),"^",10)="PFS") D
 . . I $P(PSOCAN(I),"^",5)["CANCEL" K PSOCAN(I) Q
 . . S X(PSOREF)=$P(PSOCAN(I),"^",2)_"^"_PSORSN K PSOCAN(I)
 I $G(CANTYPE)&('$D(X)) D MSGNOCAN^PSOCPB Q  ;CANTYPE=1 means trying cancelling all fills;can't cancel twice
 ;
 ;send charge messages, set activity log, display message
 S PREA="C",PSOREF=""
 F  S PSOREF=$O(X(PSOREF)) Q:PSOREF=""  S PSOPFS=1 D PFSI(PSODA,PSOREF) D CHRG(PSODA,PSOREF,"CD",PSOPFS) D ACTLOG^PSOCPA D:'$G(CANTYPE) MSG^PSOCPB
 I $G(CANTYPE)&('$D(PSOCAN)) D MSG^PSOCPB  ;if cancelling all and no legacy IB bills to cancel, write msg
 S PSOPFSA=0  ;reset variable so charge isn't sent twice if SC/EI's were also changed.
 Q
 ;
