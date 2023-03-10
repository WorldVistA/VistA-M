RCTCSP7 ;ALBANY/RGB-CROSS - SERVICING TRANSMISSION CONT'D ;08/03/17 3:34 PM
 ;;4.5;Accounts Receivable;**327,315,336,350,343**;Mar 20, 1995;Build 59
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRCA*4.5*327 Moved rec code from RCTCSPD to create room
 ;             for batch mods.
 ;
 ;PRCA*4.5*336 Set CS call switch for address setup
 ;             Also, ensure that pos 260 & 275 are set
 ;             to 10 spaces for non-numeric phone number
 ;
 ;PRCA*4.5*343 Moved NAME subroutine from RCTCSPD to get
 ;             under SACC routine size max
 ;
REC2C ;
 N REC,KNUM,DEBTNR,DEBTORNB,TAXID,RCDFN,PHONE,ADDRCS
 S REC="C2C"_ACTION_"3636001200"_"DM1D "
 S KNUM=$P($P(B0,U,1),"-",2)
 ;S DEBTNR=$E(SITE,1,3)_$$LJZF(KNUM,7)_$TR($J(BILL,20)," ",0),REC=REC_DEBTNR
 S DEBTNR=$$AGDEBTID^RCTCSPD,REC=REC_DEBTNR ; PRCA*4.5*350
 S DEBTORNB=$E(SITE,1,3)_$TR($J(DEBTOR,12)," ",0)
 S REC=REC_DEBTORNB
 S TAXID=$$TAXID(DEBTOR)
 S REC=REC_TAXID
 S REC=REC_"SLFIND"
 S REC=REC_$$BLANK(20)
 S RCDFN=+DEBTOR0
 S REC=REC_$$LJSF($$NAMEFF(RCDFN),60)_"Y"
 S ADDRCS=$$ADDR^RCTCSP1(RCDFN,1),PHONE=$P(ADDRCS,U,6)    ;PRCA*4.5*336
 S REC=REC_$$LJSF($P(ADDRCS,U,1),35)_$$LJSF($P(ADDRCS,U,2),35)_$$LJSF($P(ADDRCS,U,3),15)_$$LJSF($P(ADDRCS,U,4),2)_$$LJSF($P(ADDRCS,U,5),9)
 S REC=REC_$$COUNTRY^RCTCSP1A($P(ADDRCS,U,7)) ;COUNTRY label moved due to routine size PRCA*4.5*315/DRF
 S REC=REC_"Y"
 S REC=REC_$S(+PHONE:"P",1:" ")         ;PRCA*4.5*336
 S REC=REC_$$LJSF($TR(PHONE,"() -"),10)_$$BLANK(4)
 S REC=REC_$S(+PHONE:"Y",1:" ")         ;PRCA*4.5*336
 S REC=REC_$$BLANK(450-$L(REC))
 S ^XTMP("RCTCSPD",$J,BILL,ACTION,"2C")=REC
 S $P(^XTMP("RCTCSPD",$J,"BILL",ACTION,BILL),U,1)=$$TAXID(DEBTOR)
 D CLR19(BILL,4)
 Q
 ;
NAMEFF(DFN) ;returns name for document and name in file
 N FN,LN,MN,NM,DOCNM,VA,VADM
 S NM=""
 D DEM^VADPT
 I $D(VADM) S NM=VADM(1)
 S LN=$TR($P(NM,",")," .'-"),MN=$P($P(NM,",",2)," ",2)
 I ($E(MN,1,2)="SR")!($E(MN,1,2)="JR")!(MN?2.3"I")!(MN?0.1"I"1"V"1.3"I") S MN=""
 S FN=$P($P(NM,",",2)," ")
 S DOCNM=LN_" "_FN_" "_MN
 Q DOCNM
 ;
BLANK(X) ;returns 'x' blank spaces
 N BLANK
 S BLANK="",$P(BLANK," ",X+1)=""
 Q BLANK
 ;
TAXID(DEBTOR) ;computes TAXID to place on documents
 N TAXID,DIC,DA,DR,DIQ
 S TAXID=$$SSN^RCFN01(DEBTOR)
 S TAXID=$$LJSF(TAXID,9)
 Q TAXID
 ;
LJSF(X,Y) ;x left justified, y space filled
 S X=$E(X,1,Y)
 S X=X_$$BLANK(Y-$L(X))
 Q X
 ;
LJZF(X,Y) ;x left justified, y zero filled
 S X=X_"0000000000"
 S X=$E(X,X,Y)
 Q X
 ;
CLR19(BILL,X) ; clear the send flag
 S $P(^PRCA(430,BILL,19),U,X)=""
 ;
NAME(DFN) ;returns name for document and name in file - called by RCTCSPD
 N FN,LN,MN,NM,DOCNM,VA,VADM
 S NM=""
 D DEM^VADPT
 I $D(VADM) S NM=VADM(1)
 S LN=$TR($P(NM,",")," .'-"),MN=$P($P(NM,",",2)," ",2)
 I ($E(MN,1,2)="SR")!($E(MN,1,2)="JR")!(MN?2.3"I")!(MN?0.1"I"1"V"1.3"I") S MN=""
 S FN=$P($P(NM,",",2)," ")
 S DOCNM=$$LJ^XLFSTR($E(LN,1,35),35)_$$LJ^XLFSTR($E(FN,1,35),35)_$$LJ^XLFSTR($E(MN,1,35),35)
 Q DOCNM
 ;
