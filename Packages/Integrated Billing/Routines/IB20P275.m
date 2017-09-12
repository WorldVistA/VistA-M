IB20P275 ;WOIFO/SS - POST INIT ROUTINE FOR IB*2*275 ;11-MAY-04
 ;;2.0;INTEGRATED BILLING;**275**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
POST ; adding charge removal reason entries if not there
 N IBX,IBT,IBY,X,Y,DIC,DO
 D ADDAUTO
 D ADDCRR
 Q
 ;
ADDAUTO ; need to add charge removal reasons
 N IBX,IBT,IBY,DIC,Y,X
 F IBX=1:1 S IBY=$P($T(AUTO+IBX),";",3,99) Q:IBY=""  S IBT=$P(IBY,";") I '$O(^IBE(354.2,"B",IBT,0)) K DO D
 . S DIC="^IBE(354.2,",DIC(0)="",X=IBT,DIC("DR")=$P(IBY,";",2,5)
 . D FILE^DICN I Y>0 D BMES^XPDUTL("  --> Added Exemption Reason File: "_IBT)
 Q
ADDCRR ; add charge removal reasons
 N IBX,IBT,IBY,DIC,Y,X
 F IBX=1:1 S IBY=$P($T(CRR+IBX),";",3,99) Q:IBY=""  S IBT=$P(IBY,";") I '$O(^IBE(350.3,"B",IBT,0)) K DO D
 . S DIC="^IBE(350.3,",DIC(0)="",X=IBT,DIC("DR")=$P(IBY,";",2,3)
 . D FILE^DICN I Y>0 D BMES^XPDUTL("  --> Added Charge Removal Reasons: "_IBT)
 Q
 ;
 ;
AUTO ; Exemption Reasons to add in #354.2 
 ;;FORMER POW;.02///Patient is a former Prisoner Of War;.03///COPAY INCOME EXEMPTION;.04///EXEMPT;.05///80
 ;;UNEMPLOYABLE VETERAN;.02///Patient is an unemployable veteran;.03///COPAY INCOME EXEMPTION;.04///EXEMPT;.05///90
 ;;
 ;
CRR ; charge removal reasons to add in #350.3
 ;;RX FOR FORMER POW;.02///POW;.03///RX
 ;;RX FOR UNEMPLOYABLE VETERAN;.02///UNEMPL;.03///RX
 ;;
 ;
