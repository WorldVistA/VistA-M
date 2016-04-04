DIKKFORM ;SFISC/MKO-ENTRY POINTS FOR THE 'DIKC EDIT' FORM ;11:34 AM  16 Nov 1998
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ;==========================
 ; [DIKK EDIT] entry points
 ;==========================
 ;
PRIOVAL ;Validation on Priority (#1)
 Q:$P(^DD("KEY",DA,0),U,3)=X
 N PK
 I X="P" D
 . S PK=$O(^DD("KEY","AP",$$GET^DDSVAL(.31,DA,.01),"P",0)) Q:'PK
 . S DDSERROR=1
 . D HLP^DDSUTL($C(7)_"Primary Key '"_$P(^DD("KEY",PK,0),U,2)_"' is already defined on this file.")
 Q
 ;
UIVAL ;Validation on Uniqueness Index (#3)
 ;Index must be Regular, used for Lookup/Sorting, have no set/kill
 ;conditions, and consist only of field-type cross reference values
 ;with no transforms.
 Q:X=""
 N CRV,FIL,FLD,LN0,SS
 ;
 ;Check that Index is regular and has no set/kill condition
 I $P($G(^DD("IX",X,0)),U,4)'="R" D UIERR("Selected index is not a Regular index.") Q
 I $P($G(^DD("IX",X,0)),U,14)'="LS"!($E($P($G(^(0)),U,2))="A") D UIERR("Selected index is not used for Lookup.") Q
 D:$G(^DD("IX",X,1.4))'?."^" UIERR("Selected index has a Set Condition.")
 D:$G(^DD("IX",X,2.4))'?."^" UIERR("Selected index has a Kill Condition.")
 ;
 ;Check Cross Reference Values
 S CRV=0 F  S CRV=$O(^DD("IX",X,11.1,CRV)) Q:'CRV  D
 . S LN0=$G(^DD("IX",X,11.1,CRV,0))
 . I $P(LN0,U,2)'="F" D UIERR("Selected index has a computed value.") Q
 . I $G(^DD("IX",X,11.1,CRV,2))'?."^" D UIERR("Selected index has a value with a transform.") Q
 Q
 ;
UIERR(MSG) ;Set DDSERROR=1 and print MSG
 N X
 S DDSERROR=1
 D HLP^DDSUTL($C(7)_$G(MSG))
 Q
 ;
FORMDV ;Form-Level Data Validation
 ;In the Fields multiple, check that Sequence Numbers are unique and
 ;consecutive from 1.
 ;(Duplicate file/field combinations are checked automatically
 ;because they're key fields.)
 N DIKKDA,DIKKI,DIKKLIST,DIKKSQ
 ;
 ;Build list
 ;  DIKKLIST(seq#,ien)
 ;while checking for duplicates
 ;
 S DIKKDA(1)=DA
 S DIKKDA=0 F  S DIKKDA=$O(^DD("KEY",DA,2,DIKKDA)) Q:'DIKKDA  D
 . S DIKKSQ=$$GET^DDSVAL(.312,.DIKKDA,1)
 . I $D(DIKKLIST(DIKKSQ)) D
 .. D:'$D(DDSERROR) MSG^DDSUTL($C(7)_"UNABLE TO SAVE CHANGES")
 .. S DDSERROR=1
 .. D MSG^DDSUTL("The sequence number "_DIKKSQ_" is used more than once.")
 . E  S DIKKLIST(DIKKSQ,DIKKDA)=""
 ;
 ;If no duplicates, check that sequence numbers are consecutive from 1
 I '$D(DDSERROR) D
 . S DIKKSQ=0
 . F DIKKI=1:1 S DIKKSQ=$O(DIKKLIST(DIKKSQ)) Q:'DIKKSQ!$G(DDSERROR)  D:DIKKSQ'=DIKKI
 .. S DDSERROR=1
 .. D MSG^DDSUTL($C(7)_"UNABLE TO SAVE CHANGES")
 .. D MSG^DDSUTL("Sequence numbers must be consecutive numbers starting with 1.")
 Q
 ;
NAMEPAC ;Post-Action on Change for Name of Key
 N DIKKSD,DIKKUI
 ;
 S DIKKUI=$$GET^DDSVAL(.31,DA,3) Q:'DIKKUI
 S DIKKSD=$$GET^DDSVAL(.11,DIKKUI,.11)
 Q:DIKKSD'?1"Uniqueness Index for Key '"1A1"'".E
 ;
 S $E(DIKKSD,27)=X
 D PUT^DDSVAL(.11,DIKKUI,.11,DIKKSD)
 Q
