IBCEOB ;ALB/TMP - 835 EDI EOB MESSAGE PROCESSING ;20-JAN-99
 ;;2.0;INTEGRATED BILLING;**137,135,265,155,377,407**;21-MAR-94;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
UPDEOB(IBTDA) ; Update EXPLANATION OF BENEFITS file (#361.1) from return msg
 ; IBTDA = ien of return message
 ; Function returns ien of EOB file entry or "" if errors found
 ;          the data.  Any errors found are
 ;          stored in array ^TMP("IBCERR-EOB",$J,n) in text format
 ;          n = seq # and are stored with the EOB in a wp field
 ;
 N IB0,IB100,IBBTCH,IBE,IBMNUM,IBT,DLAYGO,DIC,DD,DO,X,Y,Z,Z0,Z1,IBEOB,IBBAD,IBOK,IB,IBA1,IBIFN,IBFILE
 K ^TMP($J),^TMP("IBCERR-EOB",$J)
 ;
 S (IBBAD,IBEOB)=""
 S IB0=$G(^IBA(364.2,IBTDA,0))
 S IBMNUM=+$P(IB0,U)
 S X=+$G(^IBA(364,+$P(IB0,U,5),0))
 ;
 I IBMNUM=""!(X="") G UPDQ
 ;
 ; Duplicate EOB Check
 S IBFILE="^IBA(364.2,"_IBTDA_",2)"
 I $$DUP(IBFILE,X) D DELMSG^IBCESRV2(IBTDA) G UPDQ
 ;
 I '$$LOCK^IBCEM(IBTDA) G UPDQ ;Lock msg file 364.2
 S IBEOB=+$$ADD3611(IBMNUM,$P(IB0,U,5),$P(IB0,U,4),X,0,IBFILE)
 L -^IBA(364.2,IBTDA,0)
 ;
 I IBEOB<0 S IBEOB="" G UPDQ
 D UPD3611(IBEOB,IBTDA,0)
 ;
UPDQ I IBEOB,$O(^TMP("IBCERR-EOB",$J,0)) D ERRUPD(IBEOB,"IBCERR-EOB")
 K ^TMP($J),^TMP("IBCERR-EOB",$J)
 D CLEAN^DILF
 Q +IBEOB
 ;
 ;
 ; NOTE: **** For all variables IB0,IBEGBL,IBEOB below:
 ; IB0 = raw data received for this record type on the 835 flat file
 ; IBEGBL = subscript to use in error global
 ; IBEOB = ien in file 361.1 for this EOB
 ;
835(IB0,IBEGBL,IBEOB) ; Store header
 ;
 Q $$HDR^IBCEOB1(IB0,IBEGBL,IBEOB)
 ;
5(IB0,IBEGBL,IBEOB) ; Record '05'
 ;
 N IBOK,DA,DR,DIE,X,Y
 K IBZDATA
 S DR=";",IBOK=1
 S DIE="^IBM(361.1,",DA=IBEOB
 ;
 I $P(IB0,U,9) S DR=DR_"1.1///"_$$DATE^IBCEU($P(IB0,U,9))_";"         ; statement start date
 I $P(IB0,U,10) S DR=DR_"1.11///"_$$DATE^IBCEU($P(IB0,U,10))_";"      ; statement end date
 S DR=$P(DR,";",2,$L(DR,";")-1)
 I DR'="" D ^DIE S IBOK=$D(Y)=0
 I 'IBOK S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Bad record 5 data"
 Q IBOK
 ;
6(IB0,IBEGBL,IBEOB) ; Record '06' - corrected patient name and/or ID#
 ; This data is not going to be filed into file 361.1 so the value of this function will always be a 1 so as to
 ; not interrupt the filing process of the EOB/MRA data into file 361.1.
 ;
 ; perform overall integrity checks on the incoming 06 record.  If anything is out of place, don't update anything
 ; and report the problem and get out.
 NEW CLM,SITE,IBM,IBIFN,IBIFN1,DFN,SEQ,DIE,DA,DR
 S DIE=361.1,DA=IBEOB,DR="61.01////^S X=IB0" D ^DIE    ; archive the raw 06 record data
 S CLM=$P(IB0,U,2),SITE=+CLM,CLM=$P(CLM,"-",2) I CLM="" D MSG(IBEOB,"The claim# in piece 2 is invalid.") G Q6
 S IBM=$G(^IBM(361.1,IBEOB,0))
 I $P(IBM,U,4)'=1 D MSG(IBEOB,"This is a non-Medicare EOB.") G Q6
 S IBIFN=+$P(IBM,U,1)                    ; claim# from MRA
 S IBIFN1=+$O(^DGCR(399,"B",CLM,""))     ; claim# from 06 record
 I IBIFN'=IBIFN1 D MSG(IBEOB,"Claim mismatch error."_IBIFN_","_IBIFN1_","_CLM_".") G Q6
 I $P($$SITE^VASITE,U,3)'=SITE D MSG(IBEOB,"Invalid station# mismatch."_$P($$SITE^VASITE,U,3)_","_SITE_".") G Q6
 S SEQ=$$COBN^IBCEF(IBIFN)               ; current payer sequence# on claim
 I '$$WNRBILL^IBEFUNC(IBIFN,SEQ) D MSG(IBEOB,"The current payer on this claim is not MEDICARE (WNR).") G Q6
 S DFN=+$P($G(^DGCR(399,IBIFN,0)),U,2)   ; patient ien
 I 'DFN D MSG(IBEOB,"The patient DFN cannot be determined.") G Q6
 ;
 D UPD^IBCEOB01(IB0,IBEOB,IBIFN,DFN,SEQ)     ; update patient insurance policy data
 ;
Q6 ; exit point for $$6 function
 Q 1
 ;
10(IB0,IBEGBL,IBEOB) ; Record '10'
 ;
 N DA,DR,DIE,X,Y,VAL,IBOK
 S DIE="^IBM(361.1,",DA=IBEOB
 S DR=".13////"_$S($P(IB0,U,3)="Y":1,$P(IB0,U,4)="Y":2,$P(IB0,U,5)="Y":3,$P(IB0,U,6)="Y":4,1:5)_";.21////"_$P(IB0,U,7)
 S DR=DR_";2.04////"_$$DOLLAR($P(IB0,U,10))_";1.01////"_$$DOLLAR($P(IB0,U,11))_$S($P(IB0,U,12)'="":";.14///"_$P(IB0,U,12),1:"")
 S DR=DR_$S($P(IB0,U,13)'="":";.1///"_$P(IB0,U,13),1:"")_";.11///"_($P(IB0,U,14)/10000)_";.12///"_($P(IB0,U,15)/100)
 I $P(IB0,U,8)'="" S DR=DR_";.08////"_$P(IB0,U,8)_$S($P(IB0,U,9)'="":";.09///"_$P(IB0,U,9),1:"")
 ;
 D ^DIE
 S IBOK=($D(Y)=0)
 I 'IBOK S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Bad record 10 data" G Q10
 ;
 ; File ICN in Bill
 D ICN^IBCEOB00(IBEOB,$P(IB0,U,12),$P($G(^IBM(361.1,IBEOB,0)),U,15),.IBOK)
 ;
Q10 Q IBOK
 ;
15(IB0,IBEGBL,IBEOB) ; Record '15'
 ; Moved due to space constraints
Q15 Q $$15^IBCEOB00(IB0,IBEGBL,IBEOB)
 ;
17(IB0,IBEGBL,IBEOB) ; Record '17'
 N A,IBOK
 S A="3;25.01;0;1;0^4;25.02;0;1;0^5;25.03;0;1;0^6;25.04;0;1;0^7;25.05;0;1;0^8;25.06;0;1;0^9;25.07;0;1;0"
 S IBOK=$$STORE^IBCEOB1(A,IB0,IBEOB)
 I 'IBOK S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Bad record 17 data"
Q17 Q IBOK
 ;
20(IB0,IBEGBL,IBEOB) ; Record '20'
 ; Moved due to space constraints
Q20 Q $$20^IBCEOB00(IB0,IBEGBL,IBEOB)
 ;
30(IB0,IBEGBL,IBEOB) ; Record '30'
 ;
 N IBOK
 D 30^IBCEOB0(IB0,IBEOB,.IBOK)
Q30 Q $G(IBOK)
 ;
35(IB0,IBEGBL,IBEOB) ; Record '35'
 ; Moved due to space constraints
Q35 Q $$35^IBCEOB00(IB0,IBEGBL,IBEOB)
 ;
37(IB0,IBEGBL,IBEOB) ; Record '37'
 ; Moved due to space constraints
Q37 Q $$37^IBCEOB00(IB0,IBEGBL,IBEOB)
 ;
40(IB0,IBEGBL,IBEOB) ; Record '40'
 ;
 N IBOK
 D 40^IBCEOB0(IB0,IBEOB,.IBOK)
Q40 Q $G(IBOK)
 ;
41(IB0,IBEGBL,IBEOB) ; Record '41'
 ;
 N IBOK
 D 41^IBCEOB0(IB0,IBEOB,.IBOK)
Q41 Q $G(IBOK)
 ;
42(IB0,IBEGBL,IBEOB) ; Record '42'
 ;
 N IBOK
 D 42^IBCEOB0(IB0,IBEOB,.IBOK)
Q42 Q $G(IBOK)
 ;
45(IB0,IBEGBL,IBEOB) ; Record '45'
 ;
 N IBOK
 D 45^IBCEOB0(IB0,IBEOB,.IBOK)
 Q $G(IBOK)
 ;
MSG(IBEOB,MSG) ; procedure to file message into field 6.03
 ; Results of processing of the "06" record type
 N DIE,DA,DR,Z
 S DIE=361.1,DA=+$G(IBEOB)
 I $G(MSG)="" G MSGX
 S Z=$P($G(^IBM(361.1,DA,6)),U,3)    ; already existing message
 I Z'="" S MSG=Z_"  "_MSG            ; append new message to existing message
 S MSG=$E(MSG,1,190)
 S DR="6.03///^S X=MSG"
 D ^DIE
MSGX ;
 Q
 ;
DOLLAR(X) ; Convert value in X to dollar format XXX.XX
 Q $S(+X:$J(X/100,$L(+X),2),1:0)
 ;
ADD3611(IBMNUM,IBTBILL,IBBATCH,X,IBAR,IBFILE) ; Add stub record to file 361.1
 ; X = the ien of the referenced bill in file 399
 ; IBTBILL = ien of transmitted bill (optional)
 ; IBBATCH = ien of batch # the transmitted bill was in (optional)
 ; IBMNUM = the message # from which this record originally came
 ; IBAR = 1 only if called from AR
 ; IBFILE = array reference of raw EOB data
 ;
 N DIC,DA,DR,DO,DD,DLAYGO,Y,REVSTAT,BS,MMI
 F  L +^IBM(361.1,0):10 Q:$T
 ;
 ; default proper review status
 S BS=$P($G(^DGCR(399,X,0)),U,13)   ; bill status
 S REVSTAT=$S(BS=7:9,BS=3:3,BS=4:3,1:0)
 S MMI=$$NET^XMRENT(IBMNUM)         ; MailMan header info
 S DIC(0)="L",DIC="^IBM(361.1,",DLAYGO=361.1
 S DIC("DR")=".16////"_REVSTAT_";.17////0"_";100.02////"_IBMNUM_$S('$G(IBAR):";.19////"_+IBTBILL_";100.01////"_IBBATCH,1:"")
 S DIC("DR")=DIC("DR")_";100.05////"_$$CHKSUM^IBCEMU1(IBFILE)_";62.01////^S X=MMI"
 D FILE^DICN
 L -^IBM(361.1,0)
 Q +Y
 ;
UPD3611(IBEOB,IBTDA,IBAR) ; From flat file 835 format, add EOB record
 ; IBEOB = the ien of the entry in file 361.1 being updated
 ; IBTDA = the ien in the source file
 ; IBAR = 1 if being called from AR
 N IBA1,IBFILE,IBEGBL,Z,IBREC,Q
 S IBFILE=$S('$G(IBAR):"^IBA(364.2,"_IBTDA_",2)",1:"^TMP("_$J_",""RCDP-EOB"","_IBTDA_")")
 S IBEGBL=$S('$G(IBAR):"IBCERR-EOB",1:"RCDPERR-EOB")
 I $G(IBAR),'$$HDR^IBCEOB1($G(^TMP($J,"RCDPEOB","HDR")),IBEGBL,IBEOB) Q
 S IBA1=0
 F  S IBA1=$O(@IBFILE@(IBA1)) Q:'IBA1  S IB0=$S('$G(IBAR):$P($G(^(IBA1,0)),"##RAW DATA: ",2),1:$G(@IBFILE@(IBA1,0))) I IB0'="" D
 . S IBREC=+IB0
 . I IBREC'=37 K ^TMP($J,37)
 . I IBREC S IB="S IBOK=$$"_IBREC_"(IB0,IBEGBL,IBEOB)",Q=IBREC_"^IBCEOB" I $T(@Q)'="" X IB S:'IBOK ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)=$S('$G(IBAR):"  ##RAW DATA: ",1:"")_IB0
 ;
 Q
 ;
ERRUPD(IBEOB,IBEGBL) ; Update error text in entry, if needed
 D WP^DIE(361.1,IBEOB_",",20,"","^TMP(IBEGBL,$J)","")
 Q
 ;
 ;
DUP(IBARRAY,IBIFN) ; Duplicate Check
 ; This function determines if the EOB data already exists in file
 ; 361.1 by comparing the checksums of the raw 835 data.
 ;
 ; IBARRAY = Literal array reference where the raw 835 data exists.
 ;           The data exists at @IBARRAY@(n,0), where n is the seq#.
 ;           For example, IBARRAY = "^IBA(364.2,IBIEN,2)"
 ;
 ; IBIFN = the bill # (ptr to 399).  The checksums of the EOB's on 
 ;         file for this bill will be compared to the checksum of the
 ;         835 raw data in the IBARRAY reference.
 ;
 ; This function returns 0 if the entry is not found (no duplicate),
 ; Otherwise, the IEN of the entry in file 361.1 is returned if this
 ; is a duplicate EOB.
 ;
 NEW DUP,IBEOB,CHKSUM1,CHKSUM2
 S DUP=0,IBIFN=+$G(IBIFN)
 I $G(IBARRAY)=""!'IBIFN G DUPX
 I '$D(^IBM(361.1,"B",IBIFN)) G DUPX     ; no EOB's on file yet
 S CHKSUM1=$$CHKSUM^IBCEMU1(IBARRAY)     ; checksum of current EOB
 I 'CHKSUM1 G DUPX                       ; must be able to be calculated
 S IBEOB=0
 F  S IBEOB=$O(^IBM(361.1,"B",IBIFN,IBEOB)) Q:'IBEOB  D  Q:DUP
 . S CHKSUM2=+$P($G(^IBM(361.1,IBEOB,100)),U,5)   ; checksum of old EOB
 . I 'CHKSUM2 Q
 . I CHKSUM1=CHKSUM2 S DUP=IBEOB Q                    ; comparison
 . Q
DUPX ;
 Q DUP
 ;
