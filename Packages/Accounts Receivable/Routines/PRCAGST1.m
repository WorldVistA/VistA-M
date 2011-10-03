PRCAGST1 ;WASH-ISC@ALTOONA,PA/CMS-Print Patient Statement Bottom ;10/16/96  11:13 AM
V ;;4.5;Accounts Receivable;**2,48,104,176,249**;Mar 20, 1995;Build 2
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;ENTRY FROM PRCAGST PAGE 1
 NEW AMT,BN,DAT,DESC,I,REF,THNK,TN,TTY,X,Y,RCTOTAL
 D HDR
 S DESC(1)="Previous Balance",REF="" D WRL(PDAT,.DESC,PBAL,REF)
 S DAT=0
 F  S DAT=$O(^TMP("PRCAGT",$J,DEB,DAT)) Q:'DAT  S BN=0 F  S BN=$O(^TMP("PRCAGT",$J,DEB,DAT,BN)) Q:'BN  D
 . S REF=$P($G(^PRCA(430,BN,0)),"^") ; Get Bill Name
 . I $D(^TMP("PRCAGT",$J,DEB,DAT,BN,0)) S AMT=+^(0) I AMT D  Q
 .. D BILLDESC(BN,.DESC)  ; Compile bill description
 .. D WRL(DAT,.DESC,AMT,REF) ; Print the item
 . S TN=0 F  S TN=$O(^TMP("PRCAGT",$J,DEB,DAT,BN,TN)) Q:'TN  S AMT=^(TN) D
 .. S TTY=$P(AMT,U,2) S AMT=+AMT
 .. D AMOUNT(TN,TTY,.AMT,.THNK) ; Adjust Amount sign (+/-) and "Thank You" flag
 .. D TRANDESC(TN,.DESC) ; Compile description
 .. D WRL(DAT,.DESC,AMT,REF) ; Print the item
 I ($Y+9)>(IOSL-2) D  D HDR
 . W !,"|" F I=12,46,9,12 S Y="",$P(Y,"_",I)="" W Y,"|"
 D SUM^PRCAGST2
 Q
WRL(DAT,DESC,AMT,REF) ;Write transaction
 NEW LN,I,X,Y
 S LN=1,X=0 F  S X=$O(DESC(X)) Q:'X  S LN=$G(LN)+1
 I ($Y+LN)>(IOSL-2) D  D HDR
 . W !,"|" F I=12,46,9,12 S Y="",$P(Y,"_",I)="" W Y,"|"
 W !,"|",$S($G(DAT):$$DAT(DAT),1:""),?12,"|",DESC(1),?58,"|",$J(AMT,8,2),?67,"|",?68,$G(REF),?79,"|"
 F X=1:0 S X=$O(DESC(X)) Q:'X  W !,"|",?12,"|",DESC(X),?58,"|",?67,"|",?79,"|"
 Q
 ;
 ; Get transaction description array
TRANDESC(PRTRAN,RCDESC) N RCTOTAL
 ; RCTOTAL not used in reprinted statements.
 K RCDESC
 D TRANDESC^RCCPCPS1(PRTRAN,45) ; returns RCDESC() array (max. length 45 characters)
 Q
 ;
AMOUNT(BN,TTY,AMT,THNK) ;Adjust (+/-) amount depending on Transaction Type
 N BN0,CAT,TS
 S BN0=$G(^PRCA(430,BN,0)),CAT=$$CATN^PRCAFN(+$P(BN0,U,2))
 I ",2,8,9,10,11,14,19,47,34,35,29,"[(","_TTY_",") I AMT'<0 S AMT=-AMT
 I ",2,8,9,10,11,12,14,19,47,34,35,29,"'[(","_TTY_",") I AMT<0 S AMT=-AMT
 I +CAT=33,TTY=1 I AMT<0 S AMT=-AMT
 I +CAT=33,TTY=35 I AMT>0 S AMT=-AMT
 S TS=$P($G(^PRCA(430.3,TTY,0)),U,3) I '$D(THNK),(TS=2!(TS=20)) S THNK=1
 Q
 ; Description for bills
 ; Input: PRBILL - Bill IEN
 ; Output: RCDESC(1..n) - Description Array
BILLDESC(PRBILL,RCDESC) K RCDESC
 D BILLDESC^RCCPCPS1(PRBILL,45) ; returns RCDESC() array (max. length 45 characters)
 Q
DAT(DAT) ;slash date
 I 'DAT Q ""
 Q $$SLH^RCFN01(DAT,"/")
HDR ;statement transaction header
 NEW I,Y
 S PAGE=$G(PAGE)+1
 I PAGE>1 W @IOF I $G(^RC(342,1,5))]"" F I=1:1:18 W !
 W !,"Department of Veterans Affairs",?50,"Acct No.:",$P($$SITE^VASITE(),U,3)_"/"_$E(SSN,6,9)
 W !,NAM,?50,"Page ",PAGE
 S Y="",$P(Y,"_",80)="" W !,Y
 W !,"|Date Posted|",?13,"     Description",?58,"| Amount ",?67,"| Reference |"
 W !,"|" F I=12,46,9,12 S Y="",$P(Y,"_",I)="" W Y,"|"
 Q
