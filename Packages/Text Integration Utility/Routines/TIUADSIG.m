TIUADSIG ;SLC/JMH - Additional signature/surrogate methods ;10/13/04 [10/15/04 9:55am]
 ;;1.0;TEXT INTEGRATION UTILITIES;**157**;Jun 20, 1997
ASURG(TIUDA) ; checks if current user is a surrogate for an additional signer
 ; if so then it returns the 8925.7 record IEN
 N TIUASDA,TIUY
 S TIUASDA="",TIUY=0
 F  S TIUASDA=$O(^TIU(8925.7,"B",TIUDA,TIUASDA)) Q:'TIUASDA!(TIUY)  D
 . N TIUAS
 . S TIUAS=$P($G(^TIU(8925.7,TIUASDA,0)),U,3)
 . Q:'$G(TIUAS)
 . I +$P($G(^TIU(8925.7,+TIUASDA,0)),U,4) Q
 . I $$ISSURFOR(DUZ,TIUAS) S TIUY=TIUASDA
 Q TIUY
ISSURFOR(USER1,USER2) ; check with kernel to see if USER1 is a surrogate for
 ; USER2
 N ACTSUR ;actual surrogate
 S ACTSUR=$$CURRSURO^XQALSURO(USER2)
 I ACTSUR=USER1 Q 1
 Q 0
