DG1010P0 ;ALB/REW - VA FORM 10-10 UTILITIES ;29 MAY 92
 ;;5.3;Registration;;Aug 13, 1993
UNK(X,NA,BL) ;Returns a value depending on the FIRST true condition:
 ; NA = 1    : 'NOT APPLICABLE' 
 ; X NOT NULL: X
 ; BL = 1    : NULL VALUE
 ; ELSE      : 'UNANSWERED'
 ;   INPUT -- X    Any value
 ;            NA,BL (Optional) [See above]
 ;   OUTPUT      -- [Returned]
 ;   OUTPUT[Set] -- DGUNK =1 if NA=1 or X=""
 S DGUNK=$S($G(NA):1,(X]""):0,1:1)
 Q $S(($G(NA)):"NOT APPLICABLE",(X]""):X,($G(BL)):"",1:"UNANSWERED")
DISP(N,P,NA,BL) ;
 ; Returns  the Pth '^' piece of 'N'
 ; Output is modified by NA & BL as per $$UNK[see above]
 ;   INPUT: N -- Contents of a node
 ;     P -- the Pth '^' piece
 ;     NA,BL -- Optional output modifiers
 ;   OUTPUT[Returned] --  X
 ;   OUTPUT[Set]       -- DGUNK =1 if NA=1 or X=""
 NEW X
 S X=$P($G(N),"^",P)
 S DGUNK=$S($G(NA):1,(X]""):0,1:1)
 Q $S(($G(NA)):"NOT APPLICABLE",(X]""):X,($G(BL)):"",1:"UNANSWERED")
POINT(N,P,ROOT,P2,NA,BL) ;
 ; Returns the external value of a pointer.
 ; Output is modified by NA & BL as per $$UNK[see above]
 ; INPUT: 
 ; N    -- Contents of a node
 ; P    -- the Pth '^' piece that holds the pointer
 ; ROOT -- The global root or filenumber if root is ^DIC(ROOT,
 ; P2   -- The piece of the pointed-to file [Default=1]
 ; NA,BL-- Optional output modifiers
 ;   OUTPUT[Returned] --  X
 ;   OUTPUT[Set]      -- DGUNK =1 if NA=1 or (X or N)=""
 NEW X,F
 ; F    -- VALUE OF FIELD
 S:('$G(P2)) P2=1
 S F=$P(N,"^",P)
 S:+ROOT X=$P($G(^DIC(ROOT,+F,0)),U,P2)
 S:(+ROOT=0) X=$P($G(@(ROOT_+F_",0)")),U,P2)
 S DGUNK=$S($G(NA):1,(X]""):0,1:1)
 Q $S(($G(NA)):"NOT APPLICABLE",(X]""):X,(F]""):"INVALID",($G(BL)):"",1:"UNANSWERED")
DATENP(N,P,NA,BL) ;
 ; Returns External Value of Date in the Pth '^' piece of 'N'
 ; Output is modified by NA & BL as per $$UNK[see above]
 ; INPUT: 
 ; N     -- Contents of a node
 ; P     -- the Pth '^' piece
 ; NA,BL -- Optional output modifiers
 ; OUTPUT[Returned] --  X
 ; OUTPUT[Set]      -- DGUNK =1 if NA=1 or X=""
 N Y
 S Y=$$DISP(N,P,+$G(NA),$G(BL))
 I DGUNK G QDNP
 X ^DD("DD")
QDNP ;
 Q Y
YN2(N,P) ;
 ; Ext Val of YES/NO given node & piece.
 ;IN:  N  -- Val of Node
 ;     P  -- Piece
 ;OUT:[RETURN] -- Ext Val 
 S X=$P(N,"^",P)
 Q $S((X="Y"):"YES",(X="N"):"NO",(X="U"):"UNKNOWN",(X=""):"UNANSWERED",("0"[X):"NO",("12"[X):"YES",("3"[X):"UNKNOWN",1:"INVALID")
