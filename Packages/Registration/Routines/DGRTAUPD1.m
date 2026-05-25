DGRTAUPD1 ;ALB/JAM - Real-time update of address and other contact info ;15 May 2025  10:33 AM
 ;;5.3;Registration;**1143**;Aug 13, 1993;Build 36
 ;
 Q
CHKEXT(DFN) ; Check phone number extensions
 ; For all phone numbers, determine if there is an extension being removed or added to the phone value
 ; If there is a phoneNumber value being sent, and it doesn't contain an "X", check extension:
 ;  - Check if the phone number value in the DB contains an X, if so, the extension is being removed, send the phone as-is
 ; -  else there is no extension in the DB phone, append extension field value if it exists so it gets sent
 N DGEXT
 I $G(DGPHONEDTO("HOMEPH","phoneNumber"))'="" I $G(DGPHONEDTO("HOMEPH","phoneNumber"))'["X" D
 . I $$GET1^DIQ(2,DFN,.131)["X" Q
 . S DGEXT=$$GET1^DIQ(2,DFN,.13211) I DGEXT'="" S DGPHONEDTO("HOMEPH","phoneNumber")=DGPHONEDTO("HOMEPH","phoneNumber")_"X"_DGEXT
 ;
 I $G(DGPHONEDTO("OFFICEPH","phoneNumber"))'="" I $G(DGPHONEDTO("OFFICEPH","phoneNumber"))'["X" D
 . I $$GET1^DIQ(2,DFN,.132)["X" Q
 . S DGEXT=$$GET1^DIQ(2,DFN,.13213) I DGEXT'="" S DGPHONEDTO("OFFICEPH","phoneNumber")=DGPHONEDTO("OFFICEPH","phoneNumber")_"X"_DGEXT
 ;
 I $G(DGPHONEDTO("CELLPH","phoneNumber"))'="" I $G(DGPHONEDTO("CELLPH","phoneNumber"))'["X" D
 . I $$GET1^DIQ(2,DFN,.134)["X" Q
 . S DGEXT=$$GET1^DIQ(2,DFN,.13212) I DGEXT'="" S DGPHONEDTO("CELLPH","phoneNumber")=DGPHONEDTO("CELLPH","phoneNumber")_"X"_DGEXT
 ;
 I $G(DGPHONEDTO("TEMPPH","phoneNumber"))'="" I $G(DGPHONEDTO("TEMPPH","phoneNumber"))'["X" D
 . I $$GET1^DIQ(2,DFN,.1219)["X" Q
 . S DGEXT=$$GET1^DIQ(2,DFN,.12117) I DGEXT'="" S DGPHONEDTO("TEMPPH","phoneNumber")=DGPHONEDTO("TEMPPH","phoneNumber")_"X"_DGEXT
 ;
 I $G(DGPHONEDTO("CONFPH","phoneNumber"))'="" I $G(DGPHONEDTO("CONFPH","phoneNumber"))'["X" D
 . I $$GET1^DIQ(2,DFN,.1315)["X" Q
 . S DGEXT=$$GET1^DIQ(2,DFN,.13214) I DGEXT'="" S DGPHONEDTO("CONFPH","phoneNumber")=DGPHONEDTO("CONFPH","phoneNumber")_"X"_DGEXT
 Q
