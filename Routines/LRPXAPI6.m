LRPXAPI6 ;SLC/STAFF Lab Extract API code ;10/5/03  14:53
 ;;5.2;LAB SERVICE;**295**;Sep 27, 1994
 ;
CONDS(CONDS,COND,TYPE,ITEM) ; from LRPXAPI3
 ; returns array CONDS of conditions - for Micro and AP
 ; used to determine match, XCONDS determines exact match
 I COND["|" D XCONDS(.CONDS,COND,TYPE,$G(ITEM)) Q
 N EQUAL,ITEMCHAR,NOTEQUAL,NUM,PIECE
 K CONDS
 I $E(COND)="~" S COND=$E(COND,2,245)
 S ITEM=$G(ITEM)
 I $L(ITEM) S COND=COND_"~"_$P(ITEM,";",2)_"="_$P(ITEM,";",3)
 S NUM=1
 F  S PIECE=$P(COND,"~",NUM) Q:PIECE=""  D
 . S NUM=NUM+1
 . S ITEMCHAR=$E(PIECE)
 . I ITEMCHAR="S",TYPE="A" D  Q
 .. S CONDS("AS",PIECE)=""
 . I ITEMCHAR="I",TYPE="M" D  Q
 .. S CONDS("MIR",PIECE)=""
 . I ITEMCHAR="R",TYPE="M" D  Q
 .. S CONDS("MIR",PIECE)=""
 . I ITEMCHAR="C" D  Q
 .. S CONDS(TYPE_"C",PIECE)=""
 . S NOTEQUAL=+$P(PIECE,"'=",2)
 . I NOTEQUAL S CONDS(0,TYPE_";"_ITEMCHAR_";"_NOTEQUAL)="" Q
 . S EQUAL=+$P(PIECE,"=",2)
 . I EQUAL S CONDS(1,TYPE_";"_ITEMCHAR_";"_EQUAL)="" Q
 S CONDS="~"
 Q
 ;
XCONDS(CONDS,COND,TYPE,ITEM) ;
 ; returns array CONDS of conditions - for Micro and AP
 ; used to determine exact match
 N EQUAL,ITEMCHAR,NOTEQUAL,NUM,PIECE
 K CONDS
 I $E(COND)="|" S COND=$E(COND,2,245)
 S ITEM=$G(ITEM)
 I $L(ITEM) S COND=COND_"|"_$P(ITEM,";",2)_"="_$P(ITEM,";",3)
 S NUM=1
 F  S PIECE=$P(COND,"|",NUM) Q:PIECE=""  D
 . S NUM=NUM+1
 . S ITEMCHAR=$E(PIECE)
 . I ITEMCHAR="S",TYPE="A" D  Q
 .. S CONDS("AS",PIECE)=""
 .. S CONDS("X","A;S")=""
 . I ITEMCHAR="I",TYPE="M" D  Q
 .. S CONDS("MIR",PIECE)=""
 .. S CONDS("X","MIR","I")=""
 . I ITEMCHAR="R",TYPE="M" D  Q
 .. S CONDS("MIR",PIECE)=""
 .. S CONDS("X","MIR","R")=""
 . I ITEMCHAR="C" D  Q
 .. S CONDS(TYPE_"C",PIECE)=""
 .. S CONDS("X",TYPE_";C")=""
 . S NOTEQUAL=+$P(PIECE,"'=",2)
 . I NOTEQUAL D  Q
 .. S CONDS(0,TYPE_";"_ITEMCHAR_";"_NOTEQUAL)=""
 .. S CONDS("X",TYPE_";"_ITEMCHAR)=""
 . S EQUAL=+$P(PIECE,"=",2)
 . I EQUAL D  Q
 .. S CONDS(1,TYPE_";"_ITEMCHAR_";"_EQUAL)=""
 .. S CONDS("X",TYPE_";"_ITEMCHAR)=""
 . S CONDS("X",TYPE)=""
 S CONDS="|"
 I NUM=2 S CONDS="~"
 Q
 ;
ITEM(ITEM,TYPE,COND,ERR) ; from LRPXAPI1
 ; return an item from condition
 N DEL,ITEMCHAR,NUM,PIECE
 S ERR=1,ITEM=""
 I TYPE="C" Q
 I COND["|" S DEL="|"
 E  S DEL="~"
 S NUM=1
 F  S PIECE=$P(COND,DEL,NUM) Q:PIECE=""  D  Q:$L(ITEM)
 . S NUM=NUM+1
 . S ITEMCHAR=$E(PIECE)
 . I $E(PIECE,2)'="=" Q
 . I ITEMCHAR="C" Q
 . I ITEMCHAR="R" Q
 . I ITEMCHAR="I",TYPE="M" Q
 . I ITEMCHAR="S",TYPE="A" S ITEM="A;S;1."_$P(PIECE,"=",2) Q
 . S ITEM=TYPE_";"_ITEMCHAR_";"_$P(PIECE,"=",2) Q
 I $L(ITEM) S ERR=0
 Q
 ;
CHECK(VAR,COND,VALUE) ; $$(variable,condition,value) -> 1 or 0
 S @VAR=VALUE
 X COND
 Q $T
 ;
TEST ; *** used for testing only
 F  D T
 Q
T N TYPE,ERR,COND,CONDS K CONDS
 ;D GETTYPE^LRPXAPPU(.TYPE,.ERR) I ERR Q
 D GETCOND^LRPXAPPU(.COND,"A",.ERR) I ERR Q
 D CONDS(.CONDS,COND,"A")
 ;W ! ZW CONDS
 ;I $$MATCH^LRPXAPI5(2,2950206.1116,.CONDS) W !,"YES",! Q
 ;I $$MATCH^LRPXAPI5(14,2980910.100232,.CONDS) W !,"YES",! Q
 I $$MATCH^LRPXAPI5(16,2960503,.CONDS) W !,"YES",! Q
 W !,"NO",!
 Q
