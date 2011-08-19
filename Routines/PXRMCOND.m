PXRMCOND ; SLC/PKR - Routines for evaluating conditions. ;06/01/2007
 ;;2.0;CLINICAL REMINDERS;**6**;Feb 04, 2005;Build 123
 ;
 ;============================================================
CASESEN(X,DA,FILENUM) ;
 ;Called by xref on condition case sensitive field in 811.5 and 811.9.
 N COND,GBL
 S GBL=$$GET1^DID(FILENUM,"","","GLOBAL NAME")
 S GBL=GBL_DA(1)_",20,"_DA_",3)"
 S COND=$P(@GBL,U,1)
 D SICOND(COND,.DA,FILENUM)
 Q
 ;
 ;============================================================
COND(CASESEN,ICOND,VSLIST,VA) ;Evaluate the condition.
 N CONVAL,IND,JND,NSTAR,SUB,TEMP,V,VSTAR
 S CONVAL=""
 ;If there is no condition return true.
 I $L($G(ICOND))=0 Q 1
 S NSTAR=0
 F IND=1:1 S SUB=$P(VSLIST,";",IND) Q:SUB=""  D
 . I SUB["*" S NSTAR=NSTAR+1,VSTAR(NSTAR)=$L(SUB,",")_U_SUB
 S V=$G(VA("VALUE"))
 I 'CASESEN S V=$$UP^XLFSTR(V)
 ;Move all non "*" elements of VA into V.
 I VSLIST'="" D MV(VSLIST,CASESEN,.V,.VA)
 I NSTAR=0 X ICOND S CONVAL=$T
 I NSTAR>0 S CONVAL=$$STARCOND(CASESEN,ICOND,.V,.VA,NSTAR,.VSTAR)
 Q CONVAL
 ;
 ;============================================================
KICOND(X,DA,FILENUM) ;
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 S FILENUM=$G(FILENUM)
 I FILENUM=811.5 K ^PXRMD(811.5,DA(1),20,DA,10),^PXRMD(811.5,DA(1),20,DA,11)
 I FILENUM=811.9 K ^PXD(811.9,DA(1),20,DA,10),^PXD(811.9,DA(1),20,DA,11)
 Q
 ;
 ;============================================================
MV(VSLIST,CASESEN,V,VA) ;Move the elements of VA included in VSLIST
 ;into V and uppercase if necessary.
 N IND,NE,RV,RVA,SUB
 S NE=$L(VSLIST,";")-1
 F IND=1:1:NE D
 . S SUB=$P(VSLIST,";",IND)
 . I SUB["*" Q
 . S RV="V("_SUB_")",RVA="VA("_SUB_")"
 .;If VA(SUB) does not exist skip it.
 . I '$D(@RVA) Q
 . S @RV=$S('CASESEN:$$UP^XLFSTR(@RVA),1:@RVA)
 Q
 ;
 ;============================================================
RECSUB(IND,V,VA,NSTAR,VSTAR,NM,VM,CASESEN,ICOND,CONVAL) ;Called recursively,
 ;first substitutes V array elements with "*" in subscript with a
 ;replacement value. Once all have been replaced test condition and
 ;quit if true. If not true continue until all combinations have been
 ;tested.
 N JND,RV,RVA,VSUB,VASUB
 F JND=1:1:NM(IND) Q:CONVAL  D
 . S VASUB=VM(IND,JND)
 . S RVA="VA("_VASUB_")"
 . S SUB=$P(VSTAR(IND),U,2)
 . S RV="V("_SUB_")"
 . S @RV=$S('CASESEN:$$UP^XLFSTR(@RVA),1:@RVA)
 . I IND<NSTAR D RECSUB(IND+1,.V,.VA,NSTAR,.VSTAR,.NM,.VM,CASESEN,ICOND,.CONVAL)
 . I IND=NSTAR X ICOND S CONVAL=$T
 ;If there were no substitutions to make, make sure the condition is
 ;evaluated.
 I 'CONVAL,IND=NSTAR,NM(IND)=0 X ICOND S CONVAL=$T
 Q
 ;
 ;============================================================
SCPAR(FINDPA,CASESEN,COND,UCIFS,ICOND,VSLIST) ;Set the Condition parameters.
 N CONDS
 S CONDS=$G(FINDPA(3))
 S COND=$P(CONDS,U,1)
 ;Even if there is no condition UCIFS could be used for status search.
 S UCIFS=$P(CONDS,U,3)
 I COND="" Q
 S CASESEN=$P(CONDS,U,2)
 I CASESEN="" S CASESEN=1
 S ICOND=FINDPA(10),VSLIST=FINDPA(11)
 Q
 ;
 ;============================================================
SICOND(X,DA,FILENUM) ;Set the internal condition field. Wrap all V() in $G.
 ;Called by xref on condition field in 811.5 and 811.9.
 I X="" Q
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 N CASESEN,GBL,ICOND,IND,SE,SS,SUB,SUBLIST,TEMP,VSLIST,VWSUB,XUP
 S GBL=$$GET1^DID(FILENUM,"","","GLOBAL NAME")
 S GBL=GBL_DA(1)_",20,"_DA_",3)"
 S CASESEN=$P(@GBL,U,2)
 I CASESEN="" S CASESEN=1
 ;Find each V("sub") entry.
 S XUP=$$UP^XLFSTR(X)
 I 'CASESEN S (ICOND,X)=XUP
 I CASESEN S ICOND=$$STRREP^PXRMUTIL(X,"v(","V(")
 S SS=1,VSLIST=""
 F  S SS=$F(XUP,"V(",SS) Q:SS=0  D
 . S SE=$F(X,")",SS)
 . S SUB=$E(X,SS,SE-2)
 . I $D(SUBLIST(SUB)) Q
 . S SUBLIST(SUB)=""
 . S VSLIST=VSLIST_SUB_";"
 . S VWSUB="V("_SUB_")"
 . S TEMP="$G("_VWSUB_")"
 . S ICOND=$$STRREP^PXRMUTIL(ICOND,VWSUB,TEMP)
 I FILENUM=811.5 S ^PXRMD(811.5,DA(1),20,DA,10)=ICOND,^PXRMD(811.5,DA(1),20,DA,11)=VSLIST
 I FILENUM=811.9 S ^PXD(811.9,DA(1),20,DA,10)=ICOND,^PXD(811.9,DA(1),20,DA,11)=VSLIST
 Q
 ;
 ;============================================================
STARCOND(CASESEN,ICOND,V,VA,NSTAR,VSTAR) ;Execute a star condition,
 ;look for any replacements for the * subscripts that will make the
 ;Condition true.
 N CONVAL,IND,JND,KND,MATCH,NEWV,NM,NVA,ORV,REF,SUB,SUBL,TCOND,TEMP
 N VASUB,VSSUB,VM
 ;Build a list of the subscripts in VA.
 S NVA=0,REF="VA"
 F  S REF=$Q(@REF) Q:REF=""  D
 . S SUB=$P(REF,"(",2)
 . S SUB=$P(SUB,")",1)
 . S SUBL=$L(SUB,",")
 . S NVA=NVA+1,VASUB(NVA)=SUBL_U_SUB
 ;Build a list of replacements for the * subscripts.
 F IND=1:1:NSTAR D
 . S NM=0
 . S VSSUB=$P(VSTAR(IND),U,2)
 . S SUBL=+VSTAR(IND)
 . F JND=1:1:NVA D
 .. I +VASUB(JND)'=SUBL Q
 .. S SUB=$P(VASUB(JND),U,2)
 .. S MATCH=1
 .. F KND=1:1:SUBL D
 ... S TEMP=$P(VSSUB,",",KND)
 ... I TEMP["*" Q
 ... I $P(SUB,",",KND)'=TEMP S MATCH=0,KND=SUBL
 .. I MATCH S NM=NM+1,VM(IND,NM)=SUB
 . S NM(IND)=NM
 S CONVAL=0
 F IND=1:1:NSTAR Q:CONVAL  D RECSUB(IND,.V,.VA,NSTAR,.VSTAR,.NM,.VM,CASESEN,ICOND,.CONVAL)
 Q CONVAL
 ;
 ;============================================================
VCOND(X) ;
 ;Input transform on Condition field.
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 ;The CONDITION must start with "I ".
 S X=$$UP^XLFSTR(X)
 I $E(X,1,2)'="I " D  Q 0
 . S X=""
 . D EN^DDIOL("CONDITION must start with ""I"" followed by a single space")
 ;The CONDITION cannot contain "^".
 I X["^" D  Q 0
 . S X=""
 . D EN^DDIOL("CONDITION cannot contain ""^""")
 ;The CONDITION cannot contain "@".
 I X["@" D  Q 0
 . S X=""
 . D EN^DDIOL("CONDITION cannot contain ""@""")
 ;The rest of the condition can only contain spaces if they are in
 ;a string.
 N COND,TEMP,VALID
 S COND=$E(X,3,$L(X))
 S VALID=$S(COND[" ":$$VSPACE(COND),1:1)
 I VALID S VALID=$S(COND["V(":$$VSUB(COND),1:1)
 I VALID D
 . D ^DIM
 . I '$D(X) D
 .. D EN^DDIOL("Not a valid MUMPS string")
 .. S VALID=0
 Q VALID
 ;
 ;============================================================
VSPACE(COND) ;Make sure all spaces in the condition that come after
 ;the beginning I are inside a quoted string.
 N CHAR,IND,IQ,JND,LQ,NIQ,NQP,NSP,QP,SP,SPACE,VALID
 S VALID=1
 S (LQ,NQP,NSP)=0
 F IND=1:1:$L(COND) D
 . S CHAR=$E(COND,IND)
 . I CHAR="""" D
 .. I LQ S NQP=NQP+1,QP(NQP)=LQ_U_IND,LQ=0
 .. E  S LQ=IND
 . I CHAR=" " S NSP=NSP+1,SP(NSP)=IND
 S NIQ=0
 F IND=1:1:NSP D
 . S SPACE=SP(NSP)
 . S IQ=0
 . F JND=1:1:NQP D
 .. I SPACE>$P(QP(JND),U,1),SPACE<$P(QP(JND),U,2) S IQ=1,JND=NQP Q
 . S NIQ=$S(IQ:0,1:1)
 . I NIQ S IND=NSP Q
 I NIQ D
 . D EN^DDIOL("No spaces are allowed except in quoted strings!")
 . S VALID=0
 Q VALID
 ;
 ;============================================================
VSUB(COND) ;Make sure all V subscripts are quoted strings, numbers
 ;or quoted * strings.
 N IND,RP,SS,SUB,SUBL,VALID
 S (SS,VALID)=1
 F  S SS=$F(COND,"V(",SS) Q:('VALID)!(SS=0)  D
 . S RP=$F(COND,")",SS)-2
 . I RP=-2 D  Q
 .. N TEXT
 .. S TEXT=$E(COND,SS-2,$L(COND))_" is missing a "")"""
 .. D EN^DDIOL(TEXT)
 .. S VALID=0
 . S SUBL=$E(COND,SS,RP)
 . F IND=1:1:$L(SUBL,",") D
 .. S SUB=$P(SUBL,",",IND)
 ..;Check for a number.
 .. I SUB=+SUB Q
 ..;Check for a wildcard, must be in quotes any number of * allowed.
 .. I SUB?1"""1"*"."*"""" Q
 .. ;Check for first and last character = to a ".
 .. I ($E(SUB,1)'="""")!($E(SUB,$L(SUB))'="""") S VALID=0
 I 'VALID D EN^DDIOL("All V subscripts must be quoted strings, numbers or *!")
 Q VALID
 ;
