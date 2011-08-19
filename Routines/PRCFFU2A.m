PRCFFU2A ;WISC/SJG-FMS RC2&RC3 SEGMENTS ;11/29/93  09:45
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
RC2(NODE,TYCODE) ;BUILD 'RC2' SEGMENT
 ;
 ;PRCTMP ARRAY:
 ; file 440   .01 (Name)           .06 (Federal source), 
 ;             34 (Vendor code)     35 (Alternate address)
 ;
 ; file 442   .1  (P.O. date)        5 (Vendor)
 ;
 N SEG,VEND,FMSVENID,X
 S TMPLINE=TMPLINE+1
 S SEG="RC2^^^^^^"_TYCODE
 K PRCTMP N DA
 S DIC=442,DR=".1;5",DA=+PO,DIQ="PRCTMP(",DIQ(0)="IE"
 D EN^DIQ1
 K DIC,DIQ,DR
 ;
 S (BEGDATE,PODATE,X)=PRCFA("OBLDATE")
 S $P(SEG,U,2)=$E(X,2,3) ; year
 S $P(SEG,U,3)=$E(X,4,5) ; month
 S $P(SEG,U,4)=$E(X,6,7) ; day
 ;
 S $P(SEG,U,5)="SO"
 S $P(SEG,U,6)=$TR(PRCFA("REF"),"-","")_"  "
 ;
RC2Q S $P(SEG,U,16)="ADJUSTMENT AR"
 ;
 S ^TMP($J,"PRCMO",INT,TMPLINE)=SEG_"^~"
 K PRCTMP
 Q
 ;
RC3 S TMPLINE=TMPLINE+1
 S SEG="RC3^^01"
 S X=$P($G(PRCFA("ACCPD")),U)
 S $P(SEG,U,4)=$E(X,1,2) ; ACCT month
 S $P(SEG,U,5)=$E(X,3,4) ; ACCT year
 S ^TMP($J,"PRCMO",INT,TMPLINE)=SEG_"^~"
 Q
