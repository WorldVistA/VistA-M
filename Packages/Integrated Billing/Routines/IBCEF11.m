IBCEF11 ;ALB/TMP - FORMATTER SPECIFIC BILL FUNCTIONS - CONT ;30-JAN-96
 ;;2.0;INTEGRATED BILLING;**51,137,155,309,335,348,349,371,432,447,473,516,577,592,608,623**;21-MAR-94;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
BOX24D(A,IB) ; Returns the lines for boxes 19-24 of the CMS-1500 display
 ; IB = flag is 1 if only box 24 is needed
 Q $S('$G(IB):"36",1:"44")_"^55"
 ;
RCBOX() ; Returns the lines for revenue code boxes of the UB-04 display
 Q "19^41"
 ;
OUTPT(IBIFN,IBPRINT) ; Returns an array of service line data from
 ;                 CMS-1500 box 24.  Output is in IBXDATA(n)
 ; IBPRINT = print flag  1: return print fields
 ;                       0: return EDI fields
 ; Uses diagnosis array ^TMP("IBXSAVE",$J,"DX",IBIFN,DIAG CODE)=SEQ #
 ;   if it already exists. If not, it builds it from N-DIAGNOSES element
 ;
 ; For EDI call: Returns IBXDATA(n)=
 ;   begin date(YYYYMMDD) ^ end date(YYYYMMDD) ^ pos ^ tos ^
 ;   proc code/revenue code - if no procedure (not the pointers) ^
 ;   type of code ^ dx pointer(s ) ^ unit charge ^ units ^ modifiers separated by ;
 ;   ^ purchased charge amount ^ anesthesia minutes ^ emergency indicator ^
 ;   lab-type service flag ^ NDC ^ Units/Quantity ^ Unit/Basis of Measurement (vd/IB*2*577)
 ;
 ;   Also Returns IBXDATA(IBI,"COB",COB,m) with COB data for each line
 ;      item found in an accepted EOB for the bill and = the reference
 ;      line in the first '^' piece followed by the '0' node data of file
 ;      361.115 (LINE LEVEL ADJUSTMENTS)
 ;       COB = COB sequence # of adjustment's ins co, m = seq #
 ;         -- AND --
 ;    IBXDATA(IBI,"COB",COB,m,z,p)=
 ;           the data on the '0' node for each subordinate entry of file
 ;           361.11511 (REASONS) (Only first 3 pieces for 837 output)
 ;       z = group code, sometimes preceeded by a space   p = seq #
 ;
 ; For Print call: Returns begin date(DDMMYYYY)^end date(DDMMYYYY) or
 ;   null if equal to begin date^pos^tos^bedsection name(if no procedure)
 ;   or procedure code(not the pointer)^ ... refer to EDI call results
 ;   Also, IBXDATA(n,"TEXT")=the text to print on first line of box 24,
 ;   If no procedure code, returns IBXDATA(n,"A")=rev code abbrev
 ;
 ;  For both calls, returns IBXDATA(n,item type,item ptr)=""
 ;      -- AND --
 ;   IBXDATA(n,"RX")=RX#^drug name^NDC^refill #^(re)fill date^qty^days
 ;                   ^chrge^ien of file 362.4^NDC format
 ;           If line references a prescription
 ;      -- AND --
 ;   If no revenue code for a prescription, returns IBXDATA(n,"ARX")=""
 ;      -- AND --
 ;   IBXDATA(n,"AUX")='AUX' node of the procedure entry
 ;
 ; Also returns IBXDATA(n,"CPLNK") = soft link to corresponding entry in PROCEDURES multiple of file 399
 ;
 N IB,IBI,IBJ,IBFLD,IBDXI,IBXIEN,Z,IBXTRA,IBRX,IBRX0,IBRX1,Z0,Z1
 ;
 K ^TMP($J,"IBITEM")
 S ^TMP($J,"IBITEM")=""
 ; Build diagnosis array if not already built
 I $O(^TMP("IBXSAVE",$J,"DX",IBIFN,""))="",$O(^IBA(362.3,"AIFN"_IBIFN,"")) D
 .N Z,IBXDATA D F^IBCEF("N-DIAGNOSES",,,IBIFN)
 .S Z="" F  S Z=$O(IBXDATA(Z)) K:$O(IBXDATA(0))=""&(Z="") IBXDATA Q:Z=""  S:$P(IBXDATA(Z),U,2) ^TMP("IBXSAVE",$J,"DX",IBIFN,$P(IBXDATA(Z),U,2))=Z
 ;
 S IB(0)=$G(^DGCR(399,IBIFN,0)),IB("U")=$G(^("U")),IB("U1")=$G(^("U1"))
 S IBI="" F  S IBI=$O(^TMP("IBXSAVE",$J,"DX",IBIFN,IBI)) Q:IBI=""  S IBDXI(IBI)=^(IBI)
 I '$G(IBPRINT) D RVCE^IBCF23(IBIFN,IBIFN)
 I $G(IBPRINT) D RVCE^IBCF23(,IBIFN)
 ; Returns IBFLD(24) = begin date ^ end date ^ pos ^ tos ^
 ;     proc/bedsection/revenue code ^ dx pointer ^ unit charge ^
 ;     units ^ modifiers ^ purchased charge amount ^ anesthesia minutes ^
 ;     emergency indicator ^ soft pointer to PROCEDURES multiple in file 399 ^
 ;     NDC ^ Units
 ;         IBFLD(24,n,type,item)=""
 ;         IBFLD(24,n_"A") = revenue code abbreviation if no procedure
 ;         IBFLD(24,n,"AUX") = 'AUX' node of line item 
 ;         IBFLD(24,n,"RX") = soft pointer to file 362.4 from 'item' fld
 ;                            (can be null)
 ;
 D SET^IBCSC5A(IBIFN,.IBRX) ;prescriptions
 ; IBRX1(ien 362.4)=RX#^drug ien^NDC^refil #^(re)fil date^qty^days^chrge
 I IBRX S IBRX="" F  S IBRX=$O(IBRX(IBRX)) Q:IBRX=""  S IBRX0=0 F  S IBRX0=$O(IBRX(IBRX,IBRX0)) Q:'IBRX0  D
 . N IBRXH
 . S IBRXH=IBRX(IBRX,IBRX0)
 . ; **IB*2.0*432** added _U_$P(IBRXH,U,9) (Rx Date) to Output Formatter
 . S IBRX1(+IBRXH)=IBRX_U_$P(IBRXH,U,2)_U_$P(IBRXH,U,5)_U_$P(IBRXH,U,7)_U_IBRX0_U_$P(IBRXH,U,4)_U_$P(IBRXH,U,3)_U_$P(IBRXH,U,6)_U_+IBRXH_U_$P(IBRXH,U,8)_U_$P(IBRXH,U,9)
 K IBRX
 ;
 ; for EDI, remove any $0 line items from the IBFLD array before 
 ; dropping down into the next loop (IB*2*371)
 ; Start IB*2.0*447 BI - Code removed to allow 0 dollars to print.
 ;I '$G(IBPRINT) D
 ;. NEW IBZ,IBI,Z
 ;. M IBZ=IBFLD K IBFLD
 ;. S (IBI,Z)=0
 ;. F  S IBI=$O(IBZ(24,IBI)) Q:IBI'=+IBI  D
 ;.. I $P(IBZ(24,IBI),U,7)*$P(IBZ(24,IBI),U,8)'>0 Q
 ;.. S Z=Z+1
 ;.. M IBFLD(24,Z)=IBZ(24,IBI)
 ;.. S IBFLD(24)=Z
 ;.. Q
 ;. Q
 ; End IB*2.0*447 BI
 ;
 S IBI=0
 F  S IBI=$O(IBFLD(24,IBI)) Q:IBI'=+IBI  D
 . S IBRX1=0
 . S IBXDATA(IBI)=$P(IBFLD(24,IBI),U)_U_$P(IBFLD(24,IBI),U,$S($P(IBFLD(24,IBI),U,2)=""&'$G(IBPRINT):1,1:2))
 . S $P(IBXDATA(IBI),U,3,5)=$P(IBFLD(24,IBI),U,3,5)
 . S $P(IBXDATA(IBI),U,6)=$S($D(IBFLD(24,IBI_"X")):"CJ",1:"HC")
 . S $P(IBXDATA(IBI),U,7,13)=$P(IBFLD(24,IBI),U,6,12)
 . S $P(IBXDATA(IBI),U,14)=+$$ISLAB(IBXDATA(IBI))
 . ; MRD;IB*2.0*516 - Added NDC and Units to line level of claim,
 . ; pieces 14 & 15 of IBFLD, pieces 15 & 16 of IBXDATA. Print
 . ; in Box 24 by setting in IBXDATA(IBI,"TEXT").
 . ;S $P(IBXDATA(IBI),U,15,16)=$P(IBFLD(24,IBI),U,14,15)
 . ;I $P(IBFLD(24,IBI),U,14)'="" S IBXDATA(IBI,"TEXT")="N4"_$P(IBFLD(24,IBI),U,14)_" UN"_$P(IBFLD(24,IBI),U,15)
 . ; vd/IB*2*577 - Added Unit/Basis of Measurement to line level of claim,
 . ; piece 16 of IBFLD, piece 17 of IBXDATA.
 . ; Print in Box 24 by setting in IBXDATA(IBI,"TEXT").
 . S $P(IBXDATA(IBI),U,15,17)=$P(IBFLD(24,IBI),U,14,16)
 . I $P(IBFLD(24,IBI),U,14)'="" S IBXDATA(IBI,"TEXT")="N4"_$P(IBFLD(24,IBI),U,14)_" "_$P(IBFLD(24,IBI),U,16)_$P(IBFLD(24,IBI),U,15)
 . ;
 . I $D(IBFLD(24,IBI,"RX")) D  ;Rx
 .. S IBRX1=1
 .. I $P($G(IBFLD(24,IBI,"AUX")),U,8)'="" S $P(IBFLD(24,IBI,"AUX"),U,8)="",$P(IBFLD(24,IBI,"AUX"),U,9)=""  ;No free text allowed for rx's
 .. I $D(IBRX1(+IBFLD(24,IBI,"RX"))) D  Q  ;Soft link exists
 ...D ZERO^IBRXUTL(+$P(IBRX1(+IBFLD(24,IBI,"RX")),U,2))
 ... S IBXDATA(IBI,"RX")=IBRX1(+IBFLD(24,IBI,"RX")),$P(IBXDATA(IBI,"RX"),U,2)=$E($G(^TMP($J,"IBDRUG",+$P(IBRX1(+IBFLD(24,IBI,"RX")),U,2),.01)),1,30)
 ... K IBRX1(+IBFLD(24,IBI,"RX"))
 ... ; No soft link - must find the first Rx with the same charge
 .. S IBRX="" F  S IBRX=$O(IBRX1(IBRX)) Q:'IBRX  I +$P(IBRX1(IBRX),U,8)=+$P(IBXDATA(IBI),U,8) D  Q
 ... D ZERO^IBRXUTL(+$P(IBRX1(IBRX),U,2))
 ... S IBXDATA(IBI,"RX")=IBRX1(IBRX),$P(IBXDATA(IBI,"RX"),U,2)=$E($G(^TMP($J,"IBDRUG",+$P(IBRX1(IBRX),U,2),.01)),1,30) K IBRX1(IBRX) Q
 ... Q
 .. Q
 . ;
 . ; MRD;IB*2.0*516 - If additional service line comments to appear in
 . ; Box 24, concatenate to front if something (NDC) is already there.
 . I $G(IBFLD(24,IBI,"AUX"))'="" D
 .. I $G(IBPRINT),$P(IBFLD(24,IBI,"AUX"),U,8)'="" D
 ... I $G(IBXDATA(IBI,"TEXT"))'="" S IBXDATA(IBI,"TEXT")=$E($P(IBFLD(24,IBI,"AUX"),U,8)_" "_IBXDATA(IBI,"TEXT"),1,59)
 ... E  S IBXDATA(IBI,"TEXT")=$P(IBFLD(24,IBI,"AUX"),U,8)
 ... S $P(IBFLD(24,IBI,"AUX"),U,8)=""
 ... Q
 .. S IBXDATA(IBI,"AUX")=IBFLD(24,IBI,"AUX")
 .. Q
 . ;
 . ;JWS;IB*2.0*592:US131
 . I $G(IBFLD(24,IBI,"DEN"))'="" S IBXDATA(IBI,"DEN")=IBFLD(24,IBI,"DEN")
 . I $G(IBFLD(24,IBI,"DEND"))'="" S IBXDATA(IBI,"DEND")=$P(IBFLD(24,IBI,"DEND"),"^",4)
 . I $O(IBFLD(24,IBI,"DEN1",0)) M IBXDATA(IBI,"DEN1")=IBFLD(24,IBI,"DEN1")
 . ;end - ;JWS;IB*2.0*592:US131
 . I $G(IBPRINT) D
 .. ; START IB*2.0*447 BI ZERO DOLLAR CHANGES
 .. ; I '$P(IBXDATA(IBI),U,8),'$G(IBXDATA(IBI,"RX")) D  Q
 .. I $P(IBXDATA(IBI),U,8)="",'$G(IBXDATA(IBI,"RX")) D  Q
 ... ; END IB*2.0*447 BI ZERO DOLLAR CHANGES
 ... I $G(IBNOSHOW) Q    ; don't show errors/warnings
 ... S IBXDATA(IBI,"TEXT")="Warning:** REV CODE UNITS < #PROCEDURES, THEY MUST BE ="
 ... I $D(IBXDATA(IBI,"AUX")) S $P(IBXDATA(IBI,"AUX"),U,9)=""
 ... Q
 .. ;
 .. I $G(IBFLD(24,IBI_"A"))'="" D  Q
 ... S IBXDATA(IBI,"A")=IBFLD(24,IBI_"A")
 ... I $G(IBNOSHOW) Q    ; don't show errors/warnings
 ... S IBXDATA(IBI,"TEXT")="Warning:** REV CODE UNITS > #PROCEDURES, THEY MUST BE=: "_IBFLD(24,IBI_"A")
 ... I $D(IBXDATA(IBI,"AUX")) S $P(IBXDATA(IBI,"AUX"),U,9)=""
 ... Q
 .. ;
 .. S IBRX=$G(IBXDATA(IBI,"RX"))
 .. I IBRX'="" D  ;Format Rx detail
 ... N Z
 ... S Z=$P(IBRX,U)
 ... S Z=$S(Z'="":"Rx#"_Z_" ",1:"RX: ")
 ... S IBXDATA(IBI,"TEXT")=Z_$S($P(IBRX,U,3)'="":"NDC: "_$P(IBRX,U,3),1:"NOC: "_$P(IBRX,U,2))_" Qty: "_$P(IBRX,U,6)_" Days: "_$P(IBRX,U,7)
 ... S $P(IBXDATA(IBI,"AUX"),U,9)="N4"   ; service line comment qualifier for RX's
 ... Q
 .. Q
 . S IBXDATA(IBI,"CPLNK")=$P(IBFLD(24,IBI),U,13)
 . I '$G(IBPRINT) D COBLINE^IBCEU6(IBIFN,IBI,.IBXDATA,,.IBXTRA)
 . Q
 ;
 I $G(IBPRINT) D
 . S IBRX=0 F  S IBRX=$O(IBRX1(IBRX)) Q:'IBRX  D
 .. S IBI=+$O(IBXDATA(""),-1)+1
 .. S IBXDATA(IBI)=$$DATE($P(IBRX1(IBRX),U,5))
 .. S IBXDATA(IBI,"TEXT")="**** ERROR - NO PROC LINK TO REV CODE FOR DRUG: RX#: "_$P(IBRX1(IBRX),U)_"  NDC #: "_$P(IBRX1(IBRX),U,3)
 .. I $D(IBXDATA(IBI,"AUX")) S $P(IBXDATA(IBI,"AUX"),U,9)=""
 .. S IBXDATA(IBI,"ARX")=""
 .. D ZERO^IBRXUTL(+$P(IBRX1(IBRX),U,2))
 .. S IBXDATA(IBI,"RX")=IBRX1(IBRX),$P(IBXDATA(IBI,"RX"),U,2)=$E($G(^TMP($J,"IBDRUG",+$P(IBRX1(IBRX),U,2),.01)),1,30) K IBRX1(IBRX)
 .. Q
 . Q
 ;
 I '$G(IBPRINT),$D(IBXTRA) D COMBO^IBCEU2(.IBXDATA,.IBXTRA,0) ;Handle bundled/unbundled lines
 K ^TMP($J,"IBDRUG")
 Q
 ;
ISLAB(LDATA) ; Returns 0/1 if line item data indicates the item is a lab (1)
 ; 'LAB' is defined here as type of service = 5
 Q $E($P(LDATA,U,4))="5"
 ;
FMT(DATA,DLEN,FLEN) ; Returns a string in DATA with a max length of DLEN
 ;  and a field length of FLEN
 Q $E($E(DATA,1,DLEN)_$J("",FLEN),1,FLEN)
 ;
DATE(X,DEL) ;  Returns FM date in X as MMxDDxYYYY  where x=DEL
 S DEL=$G(DEL)
 S X=$$DATE^IBCF2(X,1,1)
 I X'="" S X=$E(X,1,2)_DEL_$E(X,3,4)_DEL_$E(X,5,8)
 Q X
 ;
BATCH() ; Sets up record for and stores/returns the next batch number
 N NUM,FAC,DO,DD,DLAYGO,DIC,X,Y
 ;Keep latest batch number for view/print edi bill extract data option
 I $D(IBVNUM) S NUM=IBVNUM G BATCHQ
 ;Check for batch resubmit - if yes, use same number as original batch
 I $P($G(^TMP("IBRESUBMIT",$J)),U,3)=1 S NUM=$P(^($J),U) G BATCHQ
 ;JWS;IB*2.0*623v24;7/17/19 increased lock timeout to 10 sec from 5
 L +^IBA(364.1,0):10 I '$T Q 0
 S FAC=+$P($$SITE^VASITE(),U,3),NUM=$O(^IBA(364.1,"B",""),-1)
 S NUM=NUM+1
 ;I $D(^IBA(364.1,+NUM,0)),$P(^(0),U,2)="" F  D  Q:'NUM!($P($G(^IBA(364.1,+NUM,0)),U,2)'="")
 ;. I $D(^IBA(364.1,NUM,0)) S DA=NUM,DIK="^IBA(364.1," D ^DIK
 ;. S NUM=$O(^IBA(364.1,"B",""),-1)
 ;JWS;IB*2.0*623v24;commented out code below, thus needed to set NUM=NUM+1 above
 ;JWS;IB*2.0*623;bug when number = 4424420000
 ;F  S NUM=$S($P(NUM,FAC,2)'="":NUM+1,1:FAC_"0000001") Q:'$D(^IBA(364.1,"B",NUM))
 ;JWS;IB*2.0*623v24;commented out code below, looking for unused batch#s
 ;I $E(NUM,1,3)'=FAC S NUM=FAC_"0000001"
 ;F  Q:'$D(^IBA(364.1,"B",NUM))  S NUM=NUM+1
 ;
 K DO,DD S DIC="^IBA(364.1,",DLAYGO=364.1,DIC(0)="L",X=NUM D FILE^DICN K DD,DO I Y'>0 S NUM=0
 L -^IBA(364.1,0)
 ;
BATCHQ Q NUM
 ;
GETLDAT(IBXIEN) ; Extract data for 837 transmission LDAT record
 ; IBXIEN - ien in file 399
 ; Sets up IBXSAVE("LDAT",n) array:
 ; Attachment report type ^ Attachment report transmission code ^ Attachment control number ^ 
 ; OB Anesthesia Additional Units ^ Purchase Service Provider ID ^ Purchase Service Amount ^
 N CPIEN,FTYPE,IBXDATA,IDS,IBIDS,NODE1,PSAMNT,PSPID,Z,PCE1,LINE
 I '+$G(IBXIEN) Q
 K IBXSAVE("LDAT")
 S FTYPE=$$FT^IBCEF(IBXIEN)
 ;JWS;IB*2.0*592; added Dental form
 I FTYPE=2!(FTYPE=7) D OUTPT(IBXIEN,0)
 I FTYPE=3 D HOS^IBCEF2(IBXIEN)
 D ALLIDS^IBCEFP(IBXIEN,.IDS,1)
 S (PSPID,PSAMNT)=""
 ; IB*2.0*473/TAZ - Convert PROVIDER code to function call to PSID^IBCEFP
 I $$SUB1OK^IBCEP8A(IBXIEN),(FTYPE=2) D
 . D PSID^IBCEFP(IBXIEN,.IDS,.IBIDS)
 . S PSPID=$G(IBIDS(0)) I PSPID="" S PSPID=$P($G(IBIDS(1)),U,1)
 ;IB*2.0*473/TAZ - END
 S Z=0 F  S Z=$O(IBXDATA(Z)) Q:'Z  D
 . S CPIEN=+$G(IBXDATA(Z,"CPLNK")) ;I 'CPIEN Q
 . I FTYPE=2,$$SUB1OK^IBCEP8A(IBXIEN) S PSAMNT=$$DOLLAR^IBCEFG1($P($G(IBXDATA(Z)),U,11))
 . S (PCE1,NODE1)=""
 . I CPIEN D
 . . S NODE1=$G(^DGCR(399,IBXIEN,"CP",CPIEN,1))
 . . S PCE1=$$GET1^DIQ(399.0304,CPIEN_","_IBXIEN_",",71)
 . . Q
 . ; MRD;IB*2.0*516 - Added addl. procedure description as piece 7 
 . ; of IBXSAVE, which will exist only if the procedure ends in '99'
 . ; or is an 'NOC/NOS' procedure.
 . ;JWS;IB*2.0*592;do not include NOC description here for Dental claims
 . S IBXSAVE("LDAT",Z)=PCE1_U_$P(NODE1,U,3)_U_$P(NODE1,U)_U_$P(NODE1,U,5)_U_$G(PSPID)_U_$G(PSAMNT)_U_$S(FTYPE=7:"",1:$P(NODE1,U,4))
 . Q
 Q
 ;
 ;/Beginning of IB*2.0*608 (US9) - vd
LDAT ;
 N Z K IBXDATA
 S Z=0 F  S Z=$O(IBXSAVE("LDAT",Z)) Q:'Z  D
 . S IBXDATA(Z)=Z D:Z>1 ID^IBCEF2(Z,"LDAT")
 ;
 I +$G(VC80) D
 . S Z=$O(IBXDATA(""),-1)+1
 . D ID^IBCEF2(Z,"LDAT")
 . D VC80L(IBXIEN,Z)  ; Process for 'SNF' claims & the last claim line
 . S A=Z
 . S IBXDATA(Z)=A
 Q
 ;
VC80L(IBIFN,LN) ; Extracts the data for the "LDAT" record for VALUE CODE 80 Line item.
 ; IBIFN = Claims internal id number
 ;    LN = 
 N VC80LN
 S VC80LN=LN
 S $P(IBXSAVE("LDAT",VC80LN),U,11)="6R"
 S $P(IBXSAVE("LDAT",VC80LN),U,12)=VC80LN_"_"_$$GET1^DIQ(399,IBIFN_", ",.01)
 Q
 ;/Ending of IB*2.0*608 - vd
 ;
