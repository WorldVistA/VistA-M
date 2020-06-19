XINDX12 ;OSEHRA/CJE - Create phantom routines for build components ;2018-03-01  8:37 AM
 ;;7.3;TOOLKIT;**10001**;Apr 25, 1995;Build 4
 ; Entire routine authored by Chirstopher Edwards
 ;
 ; Variables passed through the stack:
 ; B = {IEN}
 ; INDLC = {counter}
 ; INDRN = {faux routine prefix}
 ; INDC = {IEN} ; {NAME} - {DISPLAY NAME}
 ; INDX = {code to be XINDEXED}
 ; INDL = {NAME field (.01) of IEN}
 ;
 ; FAUX Routine Structure
 ; ^UTILITY($J,1,INDRN,0,INDLC,0)={Field Name (INDC)}
 ; ^UTILITY($J,1,INDRN,0,INDLC+1,0)={MUMPS Code (INDX)}
 ;
SORT ;Process Sort Templates
 ; ========  =====  ===============================  ===================================  =============================================
 ; File      Field  Field Name                       Global Location                      Comments
 ; ========  =====  ===============================  ===================================  =============================================
 ; .401      1815   ROUTINE INVOKED                  ^DIBT(D0,ROU)
 ; .401      1816   PREVIOUS ROUTINE INVOKED         ^DIBT(D0,ROUOLD)
 ; .4014     10     GET CODE                         ^DIBT(D0,2,D1,GET)                   Part of Sort Field Data Subfile
 ; .4014     11     QUERY CONDITION                  ^DIBT(D0,2,D1,QCON)                  Part of Sort Field Data Subfile
 ; .4014     16     COMPUTED FIELD CODE              ^DIBT(D0,2,D1,CM)                    Part of Sort Field Data Subfile
 ; .4014     20     SUBHEADER OUTPUT                 ^DIBT(D0,2,D1,OUT)                   Part of Sort Field Data Subfile
 ; .401418   5      RELATIONAL CODE                  ^DIBT(D0,2,D1,2,D2,RCOD)             Part of Relational Jump Field Data Subfile
 ; .401419   2      OVERFLOW CODE                    ^DIBT(D0,2,D1,3,D2,OVF0)             Part of Overflow Data Subfile
 ; .4011624  4      DISPAR(0,n,OUT)                  ^DIBT(D0,BY0D,D1,2)                  Part of Sort Range Data For BY(0)
 ; ========  =====  ===============================  ===================================  =============================================
 W !,"Processing Sort Templates",!
 S INDX=$S($L($P($G(^DIBT(B,"ROU")),U,1)):"D ^"_$P($G(^DIBT(B,"ROU")),U,1),1:";")
 S INDC=B_" ; "_INDL_" - ROUTINE INVOKED (#1815)"
 D ADD^XINDX11
 ;
 S INDX=$S($L($P($G(^DIBT(B,"ROUOLD")),U,1)):"D ^"_$P($G(^DIBT(B,"ROUOLD")),U,1),1:";")
 S INDC=" ; "_INDL_" - PREVIOUS ROUTINE INVOKED (#1816)"
 D ADD^XINDX11
 ;
 N SUB,SUB2
 S (SUB,SUB2)=""
 F  S SUB=$O(^DIBT(B,2,SUB)) Q:SUB=""  Q:SUB'=+SUB  D
 . S INDX=$S($L($P($G(^DIBT(B,2,SUB,"GET")),U,1)):$G(^DIBT(B,2,SUB,"GET")),1:";")
 . S INDC=B_"P"_SUB_" ; "_INDL_" - GET CODE (#10) - "_SUB
 . D ADD^XINDX11
 . ;
 . S INDX=$S($L($P($G(^DIBT(B,2,SUB,"QCON")),U,1)):$G(^DIBT(B,2,SUB,"QCON")),1:";")
 . S INDC=" ; "_INDL_" - QUERY CONDITION (#11) - "_SUB
 . D ADD^XINDX11
 . ;
 . S INDX=$S($L($P($G(^DIBT(B,2,SUB,"CM")),U,1)):$G(^DIBT(B,2,SUB,"CM")),1:";")
 . S INDC=" ; "_INDL_" - COMPUTED FIELD CODE (#16) - "_SUB
 . D ADD^XINDX11
 . ;
 . S INDX=$S($L($P($G(^DIBT(B,2,SUB,"OUT")),U,1)):$G(^DIBT(B,2,SUB,"OUT")),1:";")
 . S INDC=" ; "_INDL_" - SUBHEADER OUTPUT (#20) - "_SUB
 . D ADD^XINDX11
 . ;
 . F  S SUB2=$O(^DIBT(B,2,SUB,2,SUB2)) Q:SUB2=""  Q:SUB2'=+SUB2  D
 . . S INDX=$S($L($P($G(^DIBT(B,2,SUB,2,SUB2,"RCOD")),U,1)):$G(^DIBT(B,2,SUB,2,SUB2,"RCOD")),1:";")
 . . S INDC=B_"RCOD"_SUB_"P"_SUB2_" ; "_INDL_" - RELATIONAL CODE (#5) - "_SUB_" - "_SUB2
 . . D ADD^XINDX11
 . ;
 . S SUB2=""
 . F  S SUB2=$O(^DIBT(B,2,SUB,3,SUB2)) Q:SUB2=""  Q:SUB2'=+SUB2  D
 . . S INDX=$S($L($P($G(^DIBT(B,2,SUB,3,SUB2,"OVF0")),U,1)):$G(^DIBT(B,2,SUB,3,SUB2,"OVF0")),1:";")
 . . S INDC=B_"OVF0"_SUB_"P"_SUB2_" ; "_INDL_" - OVERFLOW CODE (#2) - "_SUB_" - "_SUB2
 . . D ADD^XINDX11
 ;
 S SUB=""
 F  S SUB=$O(^DIBT(B,"BY0D",SUB)) Q:SUB=""  Q:SUB'=+SUB  D
 . S INDX=$S($L($P($G(^DIBT(B,"BY0D",SUB,2)),U,1)):$G(^DIBT(B,"BY0D",SUB,2)),1:";")
 . S INDC=B_"BY0D"_SUB_" ; "_INDL_" - DISPAR (#4) - "_SUB
 . D ADD^XINDX11
 Q
 ; Input and Print templates are implemented in XINDX13
 ; The executable code doesn't have defined field numbers in the DD,
 ; So we put all of the lines together as "EXECUTABLE CODE"
 ; Thanks to Sam Habiel for the implementation requried to support this.
INPUT ; Input Templates
 W !,"Processing Input Templates",!
 S INDC=B_" ; "_INDL_" - EXECUTABLE CODE"
 D ADD^XINDX11
 D DIETM^XINDX13
 Q
PRINT ; Print Templates
 W !,"Processing Print Templates",!
 S INDC=B_" ; "_INDL_" - EXECUTABLE CODE"
 D ADD^XINDX11
 D DIPTM^XINDX13
 Q
FORM ;Process Forms
 ; ========  =====  ===============================  ===================================  =============================================
 ; File      Field  Field Name                       Global Location                      Comments
 ; ========  =====  ===============================  ===================================  =============================================
 ; .403      11     PRE ACTION                       ^DIST(.403,D0,11)
 ; .403      12     POST ACTION                      ^DIST(.403,D0,12)
 ; .403      14     POST SAVE                        ^DIST(.403,D0,14)
 ; .403      20     DATA VALIDATION                  ^DIST(.403,D0,20)
 ; .4031     11     PRE ACTION                       ^DIST(.403,D0,40,D1,11)
 ; .4031     12     POST ACTION                      ^DIST(.403,D0,40,D1,12)
 ; .4032     11     PRE ACTION                       ^DIST(.403,D0,40,D1,40,D2,11)
 ; .4032     12     POST ACTION                      ^DIST(.403,D0,40,D1,40,D2,12)
 ; .4032     98     COMPUTED MULTIPLE                ^DIST(.403,D0,40,D1,40,D2,COMP MUL)
 ; ========  =====  ===============================  ===================================  =============================================
 W !,"Processing Forms",!
 S INDX=$S($L($P($G(^DIST(.403,B,11)),U,1)):$P($G(^DIST(.403,B,11)),U,1),1:";")
 S INDC=B_" ; "_INDL_" - PRE ACTION (#11)"
 D ADD^XINDX11
 ;
 S INDX=$S($L($P($G(^DIST(.403,B,12)),U,1)):$P($G(^DIST(.403,B,12)),U,1),1:";")
 S INDC=" ; "_INDL_" - POST ACTION (#12)"
 D ADD^XINDX11
 ;
 S INDX=$S($L($P($G(^DIST(.403,B,14)),U,1)):$P($G(^DIST(.403,B,14)),U,1),1:";")
 S INDC=" ; "_INDL_" - POST SAVE (#14)"
 D ADD^XINDX11
 ;
 S INDX=$S($L($P($G(^DIST(.403,B,20)),U,1)):$P($G(^DIST(.403,B,20)),U,1),1:";")
 S INDC=" ; "_INDL_" - DATA VALIDATION (#20)"
 D ADD^XINDX11
 ;
 N SUB,SUB2
 S (SUB,SUB2)=""
 F  S SUB=$O(^DIST(.403,B,40,SUB)) Q:SUB=""  Q:SUB'=+SUB  D
 . S INDX=$S($L($P($G(^DIST(.403,B,40,SUB,11)),U,1)):$P($G(^DIST(.403,B,40,SUB,11)),U,1),1:";")
 . S INDC=B_"P"_SUB_" ; "_INDL_" - PRE ACTION FILE (#.4031) FIELD (#11) - "_SUB
 . D ADD^XINDX11
 . ;
 . S INDX=$S($L($P($G(^DIST(.403,B,40,SUB,12)),U,1)):$P($G(^DIST(.403,B,40,SUB,12)),U,1),1:";")
 . S INDC=" ; "_INDL_" - POST ACTION FILE (#.4031) FIELD (#12) - "_SUB
 . D ADD^XINDX11
 . ;
 . F  S SUB2=$O(^DIST(.403,B,40,SUB,40,SUB2)) Q:SUB2=""  Q:SUB2'=+SUB2  D
 . . S INDX=$S($L($P($G(^DIST(.403,B,40,SUB,40,SUB2,11)),U,1)):$P($G(^DIST(.403,B,40,SUB,40,SUB2,11)),U,1),1:";")
 . . S INDC=B_"P"_SUB_"P"_SUB2_" ; "_INDL_" - PRE ACTION FILE (#.4032) FIELD (#11) - "_SUB_" - "_SUB2
 . . D ADD^XINDX11
 . . ;
 . . S INDX=$S($L($P($G(^DIST(.403,B,40,SUB,40,SUB2,12)),U,1)):$P($G(^DIST(.403,B,40,SUB,40,SUB2,12)),U,1),1:";")
 . . S INDC=" ; "_INDL_" - POST ACTION FILE (#.4032) FIELD (#12) - "_SUB_" - "_SUB2
 . . D ADD^XINDX11
 . . ;
 . . S INDX=$S($L($P($G(^DIST(.403,B,40,SUB,40,SUB2,"COMP MUL")),U,1)):$P($G(^DIST(.403,B,40,SUB,40,SUB2,"COMP MUL")),U,1),1:";")
 . . S INDC=" ; "_INDL_" - COMPUTED MULTIPLE FILE (#.4032) FIELD (#98) - "_SUB_" - "_SUB2
 . . D ADD^XINDX11
 Q
DIALOG ;Process Dialogs
 ; ========  =====  ===============================  ===================================  =============================================
 ; File      Field  Field Name                       Global Location                      Comments
 ; ========  =====  ===============================  ===================================  =============================================
 ; .84       6      POST MESSAGE ACTION              ^DI(.84,D0,6)
 ; ========  =====  ===============================  ===================================  =============================================
 W !,"Processing Dialogs",!
 S INDX=$S($L($P($G(^DI(.84,B,6)),U,1)):$P($G(^DI(.84,B,6)),U,1),1:";")
 S INDC=B_" ; "_INDL_" - POST MESSAGE ACTION (#6)"
 D ADD^XINDX11
 Q
HELP ;Process Help Frames
 ; ========  =====  ===============================  ===================================  =============================================
 ; File      Field  Field Name                       Global Location                      Comments
 ; ========  =====  ===============================  ===================================  =============================================
 ; 9.2       10.1   ENTRY EXECUTE STATEMENT          ^DIC(9.2,D0,10.1)
 ; 9.2       10.2   EXIT EXECUTE STATEMENT           ^DIC(9.2,D0,10.2)
 ; ========  =====  ===============================  ===================================  =============================================
 W !,"Processing Help Frames",!
 S INDX=$S($L($P($G(^DIC(9.2,B,10.1)),U,1)):$P($G(^DIC(9.2,B,10.1)),U,1),1:";")
 S INDC=B_" ; "_INDL_" - ENTRY EXECUTE STATEMENT (#10.1)"
 D ADD^XINDX11
 ;
 S INDX=$S($L($P($G(^DIC(9.2,B,10.2)),U,1)):$P($G(^DIC(9.2,B,10.2)),U,1),1:";")
 S INDC=" ; "_INDL_" - EXIT EXECUTE STATEMENT (#10.2)"
 D ADD^XINDX11
 Q
KEY ;Process Security Keys
 ; ========  =====  ===============================  ===================================  =============================================
 ; File      Field  Field Name                       Global Location                      Comments
 ; ========  =====  ===============================  ===================================  =============================================
 ; 19.1      4      GRANTING CONDITION               ^DIC(19.1,D0,4)
 ; ========  =====  ===============================  ===================================  =============================================
 W !,"Processing Security Keys",!
 S INDX=$S($L($P($G(^DIC(19.1,B,4)),U,1)):$P($G(^DIC(19.1,B,4)),U,1),1:";")
 S INDC=B_" ; "_INDL_" - GRANTING CONDITION (#4)"
 D ADD^XINDX11
 Q
LIST ;Process List Templates
 ; ========  =====  ===============================  ===================================  =============================================
 ; File      Field  Field Name                       Global Location                      Comments
 ; ========  =====  ===============================  ===================================  =============================================
 ; 409.61    100    HEADER CODE                      ^SD(409.61,D0,HDR)
 ; 409.61    102    EXPAND CODE                      ^SD(409.61,D0,EXP)
 ; 409.61    103    HELP CODE                        ^SD(409.61,D0,HLP)
 ; 409.61    105    EXIT CODE                        ^SD(409.61,D0,FNL)
 ; 409.61    106    ENTRY CODE                       ^SD(409.61,D0,INIT)
 ; 409.61    107    ARRAY NAME                       ^SD(409.61,D0,ARRAY)                 Holds a variable name prefaced by a space
 ; ========  =====  ===============================  ===================================  =============================================
 W !,"Processing List Templates",!
 S INDX=$S($L($G(^SD(409.61,B,"HDR"))):$G(^SD(409.61,B,"HDR")),1:";")
 S INDC=B_" ; "_INDL_" - HEADER CODE (#100)"
 D ADD^XINDX11
 ;
 S INDX=$S($L($G(^SD(409.61,B,"EXP"))):$G(^SD(409.61,B,"EXP")),1:";")
 S INDC=" ; "_INDL_" - EXPAND CODE (#102)"
 D ADD^XINDX11
 ;
 S INDX=$S($L($G(^SD(409.61,B,"HLP"))):$G(^SD(409.61,B,"HLP")),1:";")
 S INDC=" ; "_INDL_" - HELP CODE (#103)"
 D ADD^XINDX11
 ;
 S INDX=$S($L($G(^SD(409.61,B,"FNL"))):$G(^SD(409.61,B,"FNL")),1:";")
 S INDC=" ; "_INDL_" - EXIT CODE (#105)"
 D ADD^XINDX11
 ;
 S INDX=$S($L($G(^SD(409.61,B,"INIT"))):$G(^SD(409.61,B,"INIT")),1:";")
 S INDC=" ; "_INDL_" - ENTRY CODE (#106)"
 D ADD^XINDX11
 ;
 S INDX=$S($L($G(^SD(409.61,B,"ARRAY"))):"I $L("_$P($G(^SD(409.61,B,"ARRAY"))," ",2,99)_") Q",1:";")
 S INDC=" ; "_INDL_" - ARRAY NAME (#107)"
 D ADD^XINDX11
 Q
PROTOCOL ;Process Protocols
 ; ========  =====  ===============================  ===================================  =============================================
 ; File      Field  Field Name                       Global Location                      Comments
 ; ========  =====  ===============================  ===================================  =============================================
 ; 101       15     EXIT ACTION                      ^ORD(101,D0,15) E1,245
 ; 101       20     ENTRY ACTION                     ^ORD(101,D0,20) E1,245
 ; 101       24     SCREEN                           ^ORD(101,D0,24) E1,245
 ; 101       26     HEADER                           ^ORD(101,D0,26) E1,245
 ; 101       27     MENU HELP                        ^ORD(101,D0,27) E1,245
 ; 101       100    ORDER PRINT ACTION               ^ORD(101,D0,100) E1,245
 ; 101       100.1  ORDER CANCEL ACTION              ^ORD(101,D0,100.1) E1,245
 ; 101       100.2  ORDER PURGE ACTION               ^ORD(101,D0,100.2) E1,245
 ; 101       771    PROCESSING ROUTINE               ^ORD(101,D0,771) E1,245
 ; 101       772    RESPONSE PROCESSING ROUTINE      ^ORD(101,D0,772) E1,245
 ; 101       774    ROUTING LOGIC                    ^ORD(101,D0,774) E1,245
 ; 101       21     REQUIRED VARIABLES               ^ORD(101,D0,21,D1,0)                 Required Variables sub file
 ; 101.05    .02    METHOD ACTION                    ^ORD(101,D0,101.05,D1,1) E1,245      Method sub file
 ; ========  =====  ===============================  ===================================  =============================================
 W !,"Processing Protocols",!
 K INDN
 S INDN=$P($G(^ORD(101,B,0)),U,1)
 S INDX=$S($L($E($G(^ORD(101,B,15)),1,245)):$E($G(^ORD(101,B,15)),1,245),1:";")
 S INDC=B_" ; "_INDN_" - EXIT ACTION (#15)"
 D ADD^XINDX11
 ;
 S INDX=$S($L($E($G(^ORD(101,B,20)),1,245)):$E($G(^ORD(101,B,20)),1,245),1:";")
 S INDC=" ; "_INDN_" - ENTRY ACTION (#20)"
 D ADD^XINDX11
 ;
 S INDX=$S($L($E($G(^ORD(101,B,24)),1,245)):$E($G(^ORD(101,B,24)),1,245),1:";")
 S INDC=" ; "_INDN_" - SCREEN (#24)"
 D ADD^XINDX11
 ;
 S INDX=$S($L($E($G(^ORD(101,B,26)),1,245)):$E($G(^ORD(101,B,26)),1,245),1:";")
 S INDC=" ; "_INDN_" - HEADER (#26)"
 D ADD^XINDX11
 ;
 S INDX=$S($L($E($G(^ORD(101,B,27)),1,245)):$E($G(^ORD(101,B,27)),1,245),1:";")
 S INDC=" ; "_INDN_" - MENU HELP (#27)"
 D ADD^XINDX11
 ;
 S INDX=$S($L($E($G(^ORD(101,B,100)),1,245)):$E($G(^ORD(101,B,100)),1,245),1:";")
 S INDC=" ; "_INDN_" - ORDER PRINT ACTION (#100)"
 D ADD^XINDX11
 ;
 S INDX=$S($L($E($G(^ORD(101,B,100.1)),1,245)):$E($G(^ORD(101,B,100.1)),1,245),1:";")
 S INDC=" ; "_INDN_" - ORDER CANCEL ACTION (#100.1)"
 D ADD^XINDX11
 ;
 S INDX=$S($L($E($G(^ORD(101,B,100.2)),1,245)):$E($G(^ORD(101,B,100.2)),1,245),1:";")
 S INDC=" ; "_INDN_" - ORDER PURGE ACTION (#100.2)"
 D ADD^XINDX11
 ;
 S INDX=$S($L($E($G(^ORD(101,B,771)),1,245)):$E($G(^ORD(101,B,771)),1,245),1:";")
 S INDC=" ; "_INDN_" - PROCESSING ROUTINE (#771)"
 D ADD^XINDX11
 ;
 S INDX=$S($L($E($G(^ORD(101,B,772)),1,245)):$E($G(^ORD(101,B,772)),1,245),1:";")
 S INDC=" ; "_INDN_" - ORDER PURGE ACTION (#772)"
 D ADD^XINDX11
 ;
 S INDX=$S($L($E($G(^ORD(101,B,774)),1,245)):$E($G(^ORD(101,B,774)),1,245),1:";")
 S INDC=" ; "_INDN_" - ROUTING LOGIC (#774)"
 D ADD^XINDX11
 ;
 N SUB
 S SUB=""
 F  S SUB=$O(^ORD(101,B,21,SUB)) Q:SUB=""  Q:SUB'=+SUB  D
 . S INDX=$S($L($E($G(^ORD(101,B,21,SUB,0)),1,17)):"$G("_$E($G(^HL(771,B,"MSG",SUB,"R")),1,17)_")",1:";")
 . I INDX="D Q" S INDX=";"
 . S INDC=B_"R"_SUB_" ; "_INDN_" - REQUIRED VARIABLES SUB FILE (#101.021) REQUIRED VARIABLES (#1) - "_SUB
 . D ADD^XINDX11
 ;
 S SUB=""
 F  S SUB=$O(^ORD(101,B,101.05,SUB)) Q:SUB=""  Q:SUB'=+SUB  D
 . S INDX=$S($L($E($G(^ORD(101,B,101.05,SUB,1)),1,245)):$E($G(^ORD(101,B,101.05,SUB,1)),1,245),1:";")
 . I INDX="D Q" S INDX=";"
 . S INDC=B_"M"_SUB_" ; "_INDN_" - METHOD SUB FILE (#101.05) METHOD ACTION (#.02) - "_SUB
 . D ADD^XINDX11
 ;
 Q
HL7AP ; Process HL7 Application Parameters
 ; ========  =====  ===============================  ===================================  =============================================
 ; File      Field  Field Name                       Global Location                      Comments
 ; ========  =====  ===============================  ===================================  =============================================
 ; 771.06    1      PROCESSING ROUTINE               ^HL(771,D0,MSG,D1,R)
 ; ========  =====  ===============================  ===================================  =============================================
 W !,"Processing HL7 Application Parameters",!
 N SUB
 S SUB=""
 F  S SUB=$O(^HL(771,B,"MSG",SUB)) Q:SUB=""  Q:SUB'=+SUB  D
 . S INDX=$S($L($E($G(^HL(771,B,"MSG",SUB,"R")),1,17)):"D "_$E($G(^HL(771,B,"MSG",SUB,"R")),1,17),1:";")
 . I INDX="D Q" S INDX=";"
 . S INDC=B_"P"_SUB_" ; "_INDL_" - HL7 MESSAGE SUB FILE (#771.06) PROCESSING ROUTINE (#1) - "_SUB
 . D ADD^XINDX11
 Q
RPC ; Process Remote Procedures
 ; ========  =====  ===============================  ===================================  =============================================
 ; File      Field  Field Name                       Global Location                      Comments
 ; ========  =====  ===============================  ===================================  =============================================
 ; 8994      .02    TAG                              ^XWB(8994,D0,0) Piece 2              Needs to be concatenated with ROUTINE
 ; 8994      .03    ROUTINE                          ^XWB(8994,D0,0) Piece 3
 ; ========  =====  ===============================  ===================================  =============================================
 W !,"Processing Remote Procedures",!
 S INDX=$S($L($P($G(^XWB(8994,B,0)),U,2))&($L($P($G(^XWB(8994,B,0)),U,3))):"D "_$P($G(^XWB(8994,B,0)),U,2)_"^"_$P($G(^XWB(8994,B,0)),U,3),1:";")
 S INDC=B_" ; "_INDL_" - TAG ROUTINE (#.02 & .03)"
 D ADD^XINDX11
 Q
