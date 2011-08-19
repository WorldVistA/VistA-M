IBDFRPC2 ;ALB/AAS - Return list of selections, broker call ;29-JAN-96
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**34,38**;APR 24, 1997
 ;
SEL(RESULT,IBDF) ; -- Procedure
 ; -- called by ibdfrpc1, returns list for one selection list
 ;    see ibdfrpc1 for complete input/output lists
 ; -- Input  IBDF("IEN")    := pointer to selection list (357.2)
 ;           IBDF("PI")     := pointer to package interface (357.6) (optional)
 ;           IBDF("DFN")    := pointer to patient (2) (optional)
 ;           IBDF("CLINIC") := pointer to clinic (44) (optional)
 ;
 N OTEXT,TEXT,SC,TERM,COUNT,DCODE,SECOND,THIRD
 I $E($G(RESULT),1)="^" S ARRY=RESULT
 E  S ARRY="RESULT"
 S COUNT=+$G(@ARRY@(0))
 ;
 S @ARRY@(0)="List not found"
 G:'$G(IBDF("IEN")) SELQ
 G:$G(^IBE(357.2,IBDF("IEN"),0))="" SELQ
 ;K ^TMP("IBD-DUP",$J)
 ;
 ; -- copy list
 I '$G(IBDF("RULE-ONLY")) D COPYLIST(.RESULT,IBDF("IEN"),.COUNT)
 ;I COUNT D URH
 ;
 S @ARRY@(0)=COUNT_"^LIST^"
 D GETQLF
SELQ Q
 ;
GETQLF ; -- add selection rule and qualifiers from marking area
 ;    subcolumns to results(0) node, but only for bubbles
 N SC,NODE,BUBB,BUBBCNT
 S SC=0,BUBBCNT=0,BUBB=$O(^IBE(357.91,"B","BUBBLE (use for scanning)",0)) Q:'BUBB
 F  S SC=$O(^IBE(357.2,IBDF("IEN"),2,SC)) Q:'SC  D
 .S NODE=$G(^IBE(357.2,IBDF("IEN"),2,SC,0))
 .I $P(NODE,"^",4)=2,$P(NODE,"^",6)=BUBB S BUBBCNT=BUBBCNT+1,@ARRY@(0)=@ARRY@(0)_$P($G(^IBD(357.98,+$P(NODE,"^",9),0)),"^")_";;"_+$P(NODE,"^",10)_"::"
 ;
 ; -- if no bubbles then kill off array, leave zero node for reports
 I BUBBCNT<1 S SC=@ARRY@(0) K @ARRY S @ARRY@(0)="0^"_$P(SC,"^",2,3) S $P(@ARRY@(0),"^",4)=1
 Q
 ;
COPYLIST(RESULT,LIST,COUNT) ;copies the entries from LIST to @ARY, starting subscript at COUNT+1
 ;
 N SLCTN,SUBCOL,TEXT,IEN,NODE,TSUBCOL,NOTREAL,GROUP,ORDER,HDR,CSUBCOL,DCODE,QUANTITY,SECOND,THIRD
 ;
 I $E($G(RESULT),1)="^" S ARRY=RESULT
 E  S ARRY="RESULT"
 ;
 S SUBCOL=$$SUBCOL(LIST),TSUBCOL=+SUBCOL,CSUBCOL=+$P(SUBCOL,"^",2)
 ;
 S PRNT=""
 F  S PRNT=$O(^IBE(357.4,"APO",LIST,PRNT)) Q:PRNT=""  D
 . S GROUP=""
 . F  S GROUP=$O(^IBE(357.4,"APO",LIST,PRNT,GROUP)) Q:GROUP=""  D
 .. S HDR=$P($G(^IBE(357.4,GROUP,0)),"^")
 .. I $P($G(^IBE(357.4,GROUP,0)),"^",4)="I" S HDR="   "
 .. I HDR="BLANK" S HDR="   "
 .. S COUNT=COUNT+1,@ARRY@(COUNT)=HDR_"^^^^^^0"
 .. S ORDER=""
 .. F  S ORDER=$O(^IBE(357.3,"APO",LIST,GROUP,ORDER)) Q:ORDER=""  D
 ... S SLCTN=0
 ... F  S SLCTN=$O(^IBE(357.3,"APO",LIST,GROUP,ORDER,SLCTN)) Q:'SLCTN  D
 .... S (TEXT,DCODE,OTEXT,TERM,NOTREAL,IEN,SECOND,THIRD)=""
 .... S NODE=$G(^IBE(357.3,SLCTN,0)),IEN=$P(NODE,"^")
 .... S QUANTITY=$P(NODE,"^",9)
 .... ;
 .... ; -- handle place holder as headers
 .... S NOTREAL=$P(NODE,"^",2)
 .... I NOTREAL,$P(NODE,"^",6)'="" D  Q
 ..... I $P(NODE,"^",7) S COUNT=COUNT+1,HDR=$P(NODE,"^",6),@ARRY@(COUNT)=HDR_"^^^^^^0" Q
 ..... I $P(NODE,"^",8) S COUNT=COUNT+1,HDR="   ",@ARRY@(COUNT)=HDR_"^^^^^^0" Q
 .....;
 .... ; -- find text for entry
 .... S SUBCOL=$O(^IBE(357.3,SLCTN,1,"B",+TSUBCOL,0))
 .... S NODE=$G(^IBE(357.3,+SLCTN,1,+SUBCOL,0))
 .... S:$P(NODE,"^")=TSUBCOL TEXT=$P(NODE,"^",2)
 .... ;
 .... ; -- find display code for entry
 .... S SUBCOL=$O(^IBE(357.3,+SLCTN,1,"B",+CSUBCOL,0))
 .... S NODE=$G(^IBE(357.3,+SLCTN,1,+SUBCOL,0))
 .... S:$P(NODE,"^")=CSUBCOL DCODE=$P(NODE,"^",2)
 .... ;
 .... ; -- find optional caption and lexicon pointer
 .... S NODE=$G(^IBE(357.3,SLCTN,2))
 .... S OTEXT=$P(NODE,"^"),TERM=$P(NODE,"^",2)
 .... ;
 .... ; -- find optional second and third codes
 .... S SECOND=$P(NODE,"^",3),THIRD=$P(NODE,"^",4)
 .... ;
 .... ; -- add to array.  Is dup ien or ien+text???
 .... I $L(TEXT) S COUNT=COUNT+1 D BLDA Q
 .... ;I $L(TEXT),'$D(IBDUP(IEN_"^"_TEXT)) S COUNT=COUNT+1,IBDUP(IEN_"^"_TEXT)="" D BLDA Q  ;this line checks ien+text for duplicates
 ;
 K ^TMP("IBD-DUP",$J)
 Q
 ;
SUBCOL(LIST) ; -- function
 ; -- returns the subcolumn containing the text
 ;    input  LIST := selection list internal entry
 ; -- Assumes data returned by the package interface, piece 2 is the description
 ;
 N SC,TSUBCOL,CSUBCOL
 S (TSUBCOL,CSUBCOL)=""
 S SC=0
 F  S SC=$O(^IBE(357.2,LIST,2,SC)) Q:'SC  D
 .Q:$P($G(^IBE(357.2,LIST,2,SC,0)),"^",4)=2  ;is a marking area
 .I $P($G(^IBE(357.2,LIST,2,SC,0)),"^",5)=2 S TSUBCOL=$P(^(0),"^") Q  ;data piece 2 is usually text subcol
 .I $P($G(^IBE(357.2,LIST,2,SC,0)),"^",5)=1 S CSUBCOL=$P(^(0),"^") Q  ; data piece 1 is always code
 .I TSUBCOL="",$P($G(^IBE(357.2,LIST,2,SC,0)),"^",5)>2 S TSUBCOL=$P(^(0),"^") Q  ; -- see if other than data piece two is text subcolumn
 .I CSUBCOL="",$P($G(^IBE(357.2,LIST,2,SC,0)),"^",5)>2 S CSUBCOL=$P(^(0),"^") Q
 Q TSUBCOL_"^"_CSUBCOL
 ;
BLDA ; -- build results array
 S @ARRY@(COUNT)=TEXT ;B  ;;
 S $P(@ARRY@(COUNT),"^",2)=$G(DCODE)
 S $P(@ARRY@(COUNT),"^",3)=$S($G(NOTREAL):"",1:$G(IEN))
 S $P(@ARRY@(COUNT),"^",4)=""
 S $P(@ARRY@(COUNT),"^",5)=$G(OTEXT)
 S $P(@ARRY@(COUNT),"^",6)=$G(TERM)
 S $P(@ARRY@(COUNT),"^",7)=$S($G(NOTREAL):0,1:1)
 S $P(@ARRY@(COUNT),"^",9)=$G(QUANTITY)
 S $P(@ARRY@(COUNT),"^",10)=$G(SECOND)
 S $P(@ARRY@(COUNT),"^",11)=$G(THIRD)
 ;--added for  slctn to be passed also
 S $P(@ARRY@(COUNT),"^",12)=$G(SLCTN)
 Q
 ;
URH ; -- UnReferenced Headers removal
 ;    if a header doesn't have any data under it, then remove the header
 N X,HDR
 S X=0 F  S X=$O(@ARRY@(X)) Q:'X  D
 .I '$D(HDR),$P(@ARRY@(X),"^",1)="" S HDR=X Q  ;find a header
 .I $P(@ARRY@(X),"^",1)="" K HDR Q  ; is item under header
 .I $D(HDR),$P(@ARRY@(X),"^",1)="" K @ARRY@(HDR) S COUNT=COUNT-1,HDR=X ;hdr doesn't have any items, kill hdr node and reset header to next header
 I $D(HDR) S X=$O(@ARRY@(""),-1) I $P(@ARRY@(X),"^",1)="" K @ARRY@(X) S COUNT=COUNT-1,HDR=X ;last item in list is a header
 Q
 ;
DYN(RESULT,IBDF) ; -- Procedure
 ; -- called by ibdfrpc1 to return selection list for dynamic selections
 ;    see ibdfrpc1 for complete input/output lists
 ; -- Input  IBDF("PI")     := pointer to package interface (357.6)
 ;           IBDF("IEN")    := pointer to selection list (357.2)
 ;           IBDF("DFN")    := pointer to patient (2) (optional for provider selections)
 ;           IBDF("CLINIC") := pointer to clinic (44) (optional for active problem selections)
 ;
 N PI,DFN,CNT,COUNT,NAME,RTN,IBARY,IBCLINIC
 I $E($G(RESULT),1)="^" S ARRY=RESULT
 E  S ARRY="RESULT"
 S COUNT=+$G(@ARRY@(0))
 I '$G(IBDF("DFN")) S @ARRY@(0)="-1^Patient not defined" G DYNQ
 I $G(^DPT(+IBDF("DFN"),0))="" S @ARRY@(0)="-1^Patient not Found" G DYNQ
 S DFN=+$G(IBDF("DFN"))
 I $G(IBDF("RULE-ONLY")) G RULE
 ;
 S @ARRY@(0)="List not found"
 G:'$G(IBDF("IEN")) SELQ
 G:$G(^IBE(357.2,IBDF("IEN"),0))="" DYNQ
 ;
 S @ARRY@(0)="-1^Package Interface Not found"
 S PI=$G(^IBE(357.6,+$G(IBDF("PI")),0)) I PI="" G DYNQ
 ;
 S IBCLINIC=$G(IBDF("CLINIC"))
 I +IBCLINIC'=IBCLINIC,IBCLINIC'="" S IBCLINIC=$O(^SC("B",IBCLINIC,0))
 I +IBCLINIC=0 S @ARRY@(0)="Clinic Not Specified"
 ; 
 S NAME=$P(PI,"^"),RTN=$P(PI,"^",2,3) I RTN=""!(RTN="^") G DYNQ
 I NAME["ACTIVE PROBLEM" S NAME="GMP SELECT PATIENT ACTIVE PROBLEMS"
 S IBARY="^TMP(""IB"",$J,""INTERFACES"","""_NAME_""")"
 D @RTN
 ;
 S @ARRY@(0)=+$G(@IBARY@(0))_"^LIST^"
RULE I $G(IBDF("RULE-ONLY")) S @ARRY@(0)="1^DYNLIST^"
 ;G DYNQ:@ARRY@(0)<1
 D GETQLF
 G:$G(IBDF("RULE-ONLY")) DYNQ
 ;
 S CNT=0 F  S CNT=$O(@IBARY@(CNT)) Q:'CNT  D
 .Q:$G(@IBARY@(CNT))=""
 .;
 .; -- Process provider lists
 .I NAME["PROVIDER" D  Q
 ..I IBCLINIC<1 Q
 ..S @ARRY@(CNT)=$P(@IBARY@(CNT),"^",2)_"^^"_$P(@IBARY@(CNT),"^",1)_"^^^^1" Q
 .;
 .; -- process patient active problem lists
 .I NAME["ACTIVE PROBLEMS" D  Q
 ..S @ARRY@(CNT)=$P(@IBARY@(CNT),"^",2)_"^"_$P(@IBARY@(CNT),"^",3)_"^"_+@IBARY@(CNT)_"^^^^1"
 .I '$D(@ARRY@(CNT)) S @ARRY@(CNT)=@IBARY@(CNT)
 ;
DYNQ Q
 ;
 ; -- here are some sample tests for different lists
TEST K VAR,IBDF
 S IBDF("IEN")=489
 D SEL(.VAR,.IBDF)
 X "ZW VAR"
 Q
 ;
TEST1 K VAR,IBDF
 S IBDF("IEN")=488
 D SEL(.VAR,.IBDF)
 X "ZW VAR"
 Q
 ;
TESTD ; -- Test dynamic
 K VAR,IBDF
 ;S IBDF("PI")=71,IBDF("IEN")=103 ;provider, 1577 FEX
 ;S IBDF("PI")=73 ;patient active problems
 ;S IBDF("CLINIC")=300
 S IBDF("PI")=7,IBDF("IEN")=14 ;provider, 1577 FEX
 ;S IBDF("PI")=73 ;patient active problems
 S IBDF("DFN")=7169761
 S IBDF("CLINIC")=88
 D DYN(.VAR,.IBDF)
 X "ZW VAR"
