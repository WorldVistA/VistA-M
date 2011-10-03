SPNRPC6 ;SD/WDE - Routine to validate electronic signature code;DEC 08, 2006
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ;
 ;
 ;
 ;
 ;
VALIDATE(RESULTS,DUZ,SPNSIG) ; Validate Electronic Sign code
 ;  Input:  spnsig - contains the signature to be validated
 ; Output: results - contains a 1 if a valid e-sig (0 if not valid),
 ; user's sig block print name, and signature block title
 S U="^"
 S RESULTS=0
 I SPNSIG="" Q
 S X=$G(SPNSIG)
 D HASH^XUSHSHP
 ;I X'="",(X=$P($G(^VA(200,DUZ,20)),U,4)) D
 I X'="",(X=$$GET1^DIQ(200,DUZ,20.4,"I")) D
 .S RESULTS=1
 .;S RESULTS=RESULTS_U_$P($G(^VA(200,DUZ,20)),U,2,3)_U_"EOL999"
 .S RESULTS=RESULTS_U_$$GET1^DIQ(200,DUZ,20.2)_U_$$GET1^DIQ(200,DUZ,20.3)_U_"EOL999"
 .Q
 K X,SPNSIG
 Q
