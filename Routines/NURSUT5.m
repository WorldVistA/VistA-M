NURSUT5 ;HIRMFO/WAA-API FOR NURS LOCATION (#211.4) FILE ;2/29/00
 ;;4.0;NURSING SERVICE;**31**;APR 25, 1997
 ;
 ;Nursing Unit Function
 ;    Input Values:
 ;    FUNCT = Piece1_^_Piece2
 ;           Piece1 must contain an "L" or "Q"
 ;               Piece1 "L" means Look-up of specified entry
 ;                      in File 211.4, and
 ;               Piece2 must contain the IEN for
 ;                      the entry in File 211.4.
 ;       
 ;               Piece1 "Q" means do a DIC style query on File
 ;                      211.4, and
 ;               Piece2 must contain "I","A" or  
 ;                      ""(i.e., null).  This will be the screen
 ;                      used on the look-up. The API will do a
 ;                      DIC style look-up for the ward.
 ;                      "I" means look-up only inactive wards.
 ;                      "A" means look-up only active wards.
 ;                      ""  means look-up all wards.
 ;
 ;    In both cases (Query or Look-up) the data will be returned
 ;    in ARRAY, which is called by reference, in the following
 ;    format.
 ;
 ;    .ARRAY = Recommend the return array should be namespaced.
 ;
 ;Return Values:
 ;    ARRAY  = -1 means that the Look-up or Query failed
 ;    ARRAY  = IEN means that the Look-up or Query was
 ;             successful. 
 ;
 ;Return Array:
 ;ARRAY(IEN,.01) = Pointer to File 44_"^"_External value of Hospital
 ;                 Location file(44), Name field(.01)
 ;ARRAY(IEN,.02) = Facility pointer to File 4_"^"_External name of
 ;                 facility
 ;ARRAY(IEN,.03) = Pointer to File 212.7_"^"_External value of NURS
 ;                 Product Line file(212.7), Name field(.01)
 ;ARRAY(IEN,1)   = Patient care status internal value_"^"_External
 ;                 value of Patient care status
 ;ARRAY(IEN,1.5) = Ward status Internal value_"^"_External value 
 ;                 of Ward status
 ;ARRAY(IEN,2)   = Total number of MAS ward pointers
 ;           X = the IEN of the entry within the MAS ward Multiple.  
 ;ARRAY(IEN,2,X,.01) = Pointer to File 42_"^"_External value of Ward
 ;                     Location file(42), Name field(.01)
 ;ARRAY(IEN,2,X,1)   = Pointer to File 213.3_"^"_External value of
 ;                     NURS AMIS Ward file(213.3), Bed Section
 ;                     field(.01)
 ;ARRAY(IEN,4)=Total number of entries within the AMIS ward pointer.
 ;           Y = the IEN of the entry within the AMIS Bed section
 ;               Multiple
 ;ARRAY(IEN,4,Y,.01) = Pointer to file 213.3_"^"_ External 
 ;                     value of NURS AMIS Ward file(213.3),
 ;                     Bed Section field(.01)
 ;ARRAY(IEN,11) = Professional Percentage
 ;ARRAY(IEN,12) = Pointer to File 211.5_"^"_External value of NURS
 ;                Clinical Background file(211.5), Description 
 ;                field(.01)
 ;ARRAY(IEN,37) = Indicates whether or not active staff is assigned
 ;                to this ward.
 ;
WARD(FUNCT,ARRAY) ; Main Entry
 N ACT,NODE,DISYS,I,NURACTV,NURMDSW,X,XXX,YY,ZZ
 S ARRAY=-1
 S ACT=$P(FUNCT,U)
 I ACT="Q" D
 . ; DIC Query Lookup for data
 . N Y,SCREEN,DIC,X,DUOUT,DTOUT
 . S SCREEN=$P(FUNCT,U,2) Q:"AI"'[SCREEN
 . S DIC="^NURSF(211.4,",DIC(0)="AEMNXQ"
 . I SCREEN'="" S DIC("S")="I $$GET1^DIQ(211.4,+Y,1.5,""I"")=SCREEN"
 . D ^DIC
 . I Y'=-1 S ARRAY=+Y
 . Q
 I ACT="L" D
 . ; Lookup/load ARRAY
 . N IEN
 . S IEN=+$P(FUNCT,U,2)
 . I $G(^NURSF(211.4,IEN,0))="" S IEN=-1
 . S ARRAY=IEN
 . Q
 Q:ARRAY=-1
 D LOAD
 Q
LOAD ; This will load the data into ARRAY
 Q:ARRAY=-1
 N I,J,IEN,LINE
 S IEN=ARRAY
 S J=$$GET1^DIQ(44,+$G(^NURSF(211.4,IEN,0)),.01,"E")
 S ARRAY(IEN,.01)=+$G(^NURSF(211.4,IEN,0))_U_$P(J,"NUR ",2)
 S ARRAY(IEN,.02)=$$GET1^DIQ(44,+$G(^NURSF(211.4,IEN,0)),3,"I")_U
 S ARRAY(IEN,.02)=ARRAY(IEN,.02)_$$GET1^DIQ(211.4,IEN,.02,"E")
 S LINE=$G(^NURSF(211.4,IEN,1))
 I LINE'="" D
 . I $P(LINE,U,4)'="" S ARRAY(IEN,.03)=$P(LINE,U,4)_U_$$GET1^DIQ(212.7,$P(LINE,U,4),.01,"E")
 . I $P(LINE,U)'="" S ARRAY(IEN,1)=$P(LINE,U)_U_$$GET1^DIQ(211.4,IEN,1,"E")
 . I $P(LINE,U,2)'="" S ARRAY(IEN,11)=$P(LINE,U,2)
 . I $P(LINE,U,3)'="" S ARRAY(IEN,12)=$P(LINE,U,3)_U_$$GET1^DIQ(211.5,$P(LINE,U,3),.01,"E")
 . Q
 I $G(^NURSF(211.4,IEN,"I"))'="" S ARRAY(IEN,1.5)=$P(^("I"),U)_U_$$GET1^DIQ(211.4,IEN,1.5,"E")
 S ARRAY(IEN,37)=$$GET1^DIQ(211.4,IEN,37,"E")
 F NODE=3,4 I +$P($G(^NURSF(211.4,IEN,NODE,0)),U,4) D SUB
 Q
SUB ; Get sub node data for 3, and 4
 N X,Z,SNODE
 S (X,Z)=0
 S SNODE=$S(NODE=3:2,NODE=4:4,1:0)
 Q:'SNODE
 F  S X=$O(^NURSF(211.4,IEN,NODE,X)) Q:X<1  D
 . N I
 . I NODE=3 D
 .. N VALUE
 .. S VALUE=$P($G(^NURSF(211.4,IEN,NODE,X,0)),U) Q:'VALUE
 .. S ARRAY(IEN,SNODE,X,.01)=VALUE_U_$$GET1^DIQ(42,VALUE,.01,"E")
 .. Q
 . D  ; Modularize this call
 .. N VALUE,PIECE,FIELD
 .. S PIECE=$S(NODE=3:2,1:1)
 .. S FIELD=$S(NODE=3:1,1:.01)
 .. S VALUE=$P($G(^NURSF(211.4,IEN,NODE,X,0)),U,PIECE) Q:'VALUE
 .. S ARRAY(IEN,SNODE,X,FIELD)=VALUE_U_$$GET1^DIQ(213.3,VALUE,.01,"E")
 . S Z=Z+1
 . Q
 S ARRAY(IEN,SNODE)=Z
 Q
