XUSTAX ;PRXM/GCD, TAXONOMY CODE LOOKUP FOR INTEGRATED BILLING ;8/3/07
        ;;8.0;KERNEL;**410,452,454,467**; July 10, 1995;Build 12
        ;
        ; Must call at an entry point.
        Q
        ;
        ; TAXIND - Extrinsic function to retrieve the taxonomy code
        ;          for a given record in the NEW PERSON file (#200).
        ;
        ; Input
        ;    XUIEN - IEN of the record in file #200
        ; Output
        ;    Piece 1 = Taxonomy X12 code of the record in file #200
        ;    Piece 2 = Taxonomy IEN from file 8932.1
TAXIND(XUIEN) ; Get taxonomy for an individual
            N U S U="^"
        I $G(XUIEN)'>0 Q U
        ;I (XUIEN?.N)=0 Q U
        I ((XUIEN?.N)!(XUIEN?.N1"."1N.N))=0 Q "-1^Invalid IEN"
        N IEN,XUPTR,XUTAXARR,DIC,DR,DA,DIQ,DI,D0,XUTAX
        S IEN=0,XUPTR=""
        F  S IEN=$O(^VA(200,XUIEN,"USC1",IEN)) Q:'IEN  D  ;Q:XUPTR'=""
        . S DIC=200,DR=8932.1,DA=XUIEN,DR(200.05)=".01:3",DA(200.05)=IEN,DIQ="XUTAXARR",DIQ(0)="I"
        . D EN^DIQ1
        . I XUTAXARR(200.05,IEN,"2","I")>DT Q  ; Not effective yet
        . I XUTAXARR(200.05,IEN,"3","I")'="",XUTAXARR(200.05,IEN,"3","I")<DT Q  ; Expired
        . S XUPTR=XUTAXARR(200.05,IEN,".01","I")
        S XUTAX=$$GET1^DIQ(8932.1,XUPTR,"X12 CODE")
        Q XUTAX_U_XUPTR
        ;
        ; TAXORG - Extrinsic function to retrieve the taxonomy code
        ;          for a given record in the INSTITUTION file (#4).
        ;
        ; Input
        ;    XUIEN - IEN of the record in file #4
        ; Output
        ;    Piece 1 = Taxonomy X12 code of the record in file #4
        ;    Piece 2 = Taxonomy IEN from file 8932.1
TAXORG(XUIEN) ; Get taxonomy for an organization
            N U S U="^"
        I $G(XUIEN)'>0 Q U
        ;I (XUIEN?.N)=0 Q U
        I ((XUIEN?.N)!(XUIEN?.N1"."1N.N))=0 Q "-1^Invalid IEN"
        N IEN,XUPTR,XUTAXAR,DIC,DR,DA,DIQ,DI,D0,XUTAX
        S IEN=0,XUPTR=""
        F  S IEN=$O(^DIC(4,XUIEN,"TAXONOMY",IEN)) Q:'IEN  D
        . S DIC=4,DR=43,DA=XUIEN,DR(4.043)=".01:.03",DA(4.043)=IEN,DIQ="XUTAXARR",DIQ(0)="IE"
        . D EN^DIQ1
        . I XUTAXARR(4.043,IEN,".03","E")'="ACTIVE" Q
        . I XUTAXARR(4.043,IEN,".02","E")="YES" S XUPTR=XUTAXARR(4.043,IEN,".01","I") Q
        . I XUPTR="" S XUPTR=XUTAXARR(4.043,IEN,".01","I")
        S XUTAX=$$GET1^DIQ(8932.1,XUPTR,"X12 CODE")
        Q XUTAX_U_XUPTR
        ;
TAXINQ(XUIEN) ;Get the last taxonomy for an individual
 I +$G(XUIEN)'=$G(XUIEN) Q ""
 N IEN,XUI,XUY,XUEXF S IEN=0,XUI="",XUEXF="-Expired"
 F  S IEN=$O(^VA(200,XUIEN,"USC1",IEN)) Q:'IEN  D
 . S XUY=+$G(^VA(200,XUIEN,"USC1",IEN,0))
 . S XUI=$G(^USC(8932.1,XUY,0))
 . S XUI=$P(XUI,"^",7)
 I +$$GET^XUA4A72(XUIEN)=-2,XUI'="" S XUI=XUI_XUEXF
 Q XUI
