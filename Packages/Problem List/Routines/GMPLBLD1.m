GMPLBLD1 ; SLC/MKB -- Bld PL Selection Lists cont ;;3/12/03 13:48
 ;;2.0;Problem List;**3,28**;Aug 25, 1994
 ;
 ; This routine invokes IA #3991,#10082
 ;
SEL() ; Select item(s) from list
 N DIR,X,Y,MAX,GRP S GRP=$D(GMPLGRP) ; =1 if editing groups, 0 if lists
 S MAX=$P($G(^TMP("GMPLST",$J,0)),U,1) I MAX'>0 Q "^"
 S DIR(0)="LAO^1:"_MAX,DIR("A")="Select "_$S('GRP:"Category",1:"Problem")_"(s)"
 S:MAX>1 DIR("A")=DIR("A")_" (1-"_MAX_"): "
 S:MAX'>1 DIR("A")=DIR("A")_": ",DIR("B")=1
 S DIR("?")="Enter the "_$S('GRP:"categories",1:"problems")_" you wish to select, as a range or list of numbers"
 D ^DIR S:$D(DTOUT)!(X="") Y="^"
 Q Y
 ;
SEL1() ; Select item from list
 N DIR,X,Y,MAX,GRP S GRP=$D(GMPLGRP) ; =1 if editing groups, 0 if lists
 S MAX=$P($G(^TMP("GMPLST",$J,0)),U,1) I MAX'>0 Q "^"
 S DIR(0)="NAO^1:"_MAX_":0",DIR("A")="Select "_$S('GRP:"Category",1:"Problem")
 S:MAX>1 DIR("A")=DIR("A")_" (1-"_MAX_"): "
 S:MAX'>1 DIR("A")=DIR("A")_": ",DIR("B")=1
 S DIR("?")="Enter the "_$S('GRP:"category",1:"problem")_" you wish to select, by number"
 D ^DIR I $D(DTOUT)!(X="") S Y="^"
 Q Y
 ;
SEQ(NUM) ; Enter/edit seq #, returns new #
 N DIR,X,Y,GRP S GRP=$D(GMPLGRP) ; =1 if editing groups, 0 if lists
 S DIR(0)="NA^.01:999.99:2",DIR("A")="SEQUENCE: " S:NUM DIR("B")=NUM
 S DIR("?",1)="Enter a number indicating the sequence of this item in the "_$S('GRP:"list;",1:"category;")
 S DIR("?")="up to 2 decimal places may be used, to order these items."
SQ D ^DIR I $D(DTOUT)!(X="^") Q "^"
 I X?1"^".E W $C(7),$$NOJUMP G SQ
 I Y=NUM Q NUM
 I $D(^TMP("GMPLIST",$J,"SEQ",Y)) D  G SQ
 . W $C(7),!!,"Sequence number already in use!  Please enter another number."
 . W !,"Use the 'Change View' option to display the current sequence numbers.",!
 Q Y
 ;
HDR(TEXT) ; Enter/edit group subheader text in list
 N DIR,X,Y S:$L(TEXT) DIR("B")=TEXT
 S DIR(0)="FAO^2:30",DIR("A")="HEADER: "
 S DIR("?")="Enter the text you wish displayed as a header for this category of problems"
 S:$D(DIR("B")) DIR("?",1)=DIR("?")_";",DIR("?")="enter '@' if no header text is desired."
H1 D ^DIR I $D(DTOUT)!(X="^") Q "^"
 I X?1"^".E W $C(7),$$NOJUMP G H1
 I X="@" Q:$$SURE^GMPLX "" G H1
 Q Y
 ;
TEXT(TEXT) ; Edit problem text
 N DIR,X,Y S:$L(TEXT) DIR("B")=TEXT
 S DIR(0)="FAO^2:80",DIR("A")="DISPLAY TEXT: "
 S DIR("?")="Enter the text you wish presented here for this problem."
T1 D ^DIR I $D(DTOUT)!("^"[X) S Y="^" G TQ
 I X?1"^".E W $C(7),$$NOJUMP G T1
 I X="@" G:'$$SURE^GMPLX T1 S Y="@" G TQ
TQ Q Y
 ;
CODE(CODE) ; Enter/edit problem code
 N DIR,X,Y
 S DIR(0)="PAO^ICD9(:QEMZ",DIR("A")="ICD CODE: " S:$L(CODE) DIR("B")=CODE
 S DIR("?")="Enter the code you wish to be displayed with this problem."
 S DIR("S")="I $$STATCHK^ICDAPIU($P(^(0),U),DT)"
C1 D ^DIR I $D(DTOUT)!(X="^") S Y="^" G CQ
 I X?1"^".E W $C(7),$$NOJUMP G C1
 I X="@" G:'$$SURE^GMPLX C1 S Y=""
 S:+Y'>0 Y="" S:+Y>0 Y=Y(0,0)
CQ Q Y
 ;
FLAG(DFLT) ; Edit category flag
 N DIR,X,Y S DIR(0)="YAO",DIR("B")=$S(+DFLT:"YES",1:"NO")
 S DIR("A")="SHOW PROBLEMS AUTOMATICALLY? "
 S DIR("?",1)="Enter YES if you wish the problems contained in this category to be",DIR("?",2)="automatically displayed upon entry to this list; NO will display only the",DIR("?")="category header until the user selects it to view."
F1 D ^DIR I $D(DTOUT)!(X="^") Q "^"
 I X?1"^".E W $C(7),$$NOJUMP G F1
 Q Y
 ;
NOJUMP() ; Message
 Q "   ^-jumping not allowed!"
 ;
RETURN() ; End of page prompt
 N DIR,X,Y
 S DIR(0)="E" D ^DIR
 Q +Y
 ;
TMPIFN() ; Get temporary IFN ("#N") for ^TMP("GMPLIST",$J,)
 N I,LAST S (I,LAST)=0
 F  S I=$O(^TMP("GMPLIST",$J,I)) Q:+I'>0  S:I?1.N1"N" LAST=+I
 S I=LAST+1,I=$E("0000",1,4-$L(I))_I
TMPQ Q I_"N"
 ;
DELETE(IFN) ; Kill entry in ^TMP("GMPLIST",$J,)
 N SEQ,ITEM S ^TMP("GMPLIST",$J,0)=^TMP("GMPLIST",$J,0)-1
 S SEQ=+^TMP("GMPLIST",$J,IFN),ITEM=$P(^TMP("GMPLIST",$J,IFN),U,2),^TMP("GMPLIST",$J,IFN)="@"
 K ^TMP("GMPLIST",$J,"SEQ",SEQ),^TMP("GMPLIST",$J,"PROB",ITEM),^TMP("GMPLIST",$J,"GRP",ITEM)
 K:IFN?1.N1"N" ^TMP("GMPLIST",$J,IFN)
 Q
 ;
RESEQ ; Resequence items
 N SEL,NUM,SEQ,NSEQ,PIECE,IFN,GMPQUIT S VALMBCK=""
 S SEL=$$SEL G:SEL="^" RSQ
 F PIECE=1:1:$L(SEL,",") D  Q:$D(GMPQUIT)  W !
 . S NUM=$P(SEL,",",PIECE) Q:NUM'>0
 . S IFN=$P($G(^TMP("GMPLST",$J,"B",NUM)),U,1) Q:+IFN'>0  S SEQ=$P(^TMP("GMPLIST",$J,IFN),U,1)
 . W !!,$P(^TMP("GMPLIST",$J,IFN),U,3)
 . S NSEQ=$$SEQ(SEQ) I NSEQ="^" S GMPQUIT=1 Q 
 .I SEQ'=NSEQ S ^TMP("GMPLIST",$J,IFN)=NSEQ_U_$P(^TMP("GMPLIST",$J,IFN),U,2,$L(^TMP("GMPLIST",$J,IFN),U)),^TMP("GMPLIST",$J,"SEQ",NSEQ)=IFN,GMPREBLD=1 K ^TMP("GMPLIST",$J,"SEQ",SEQ)
 I $D(GMPREBLD) S VALMBCK="R",GMPLSAVE=1 ; D BUILD in exit action
RSQ S:'VALMCC VALMBCK="R" S VALMSG=$$MSG^GMPLX
 Q
 ;
EDIT ; Edit category display
 N GRPS,NUM,IFN,HDR,FLG,PIECE,GMPQUIT,GMPREBLD S VALMBCK=""
 S GRPS=$$SEL G:GRPS="^" EDQ
 F PIECE=1:1:$L(GRPS,",") D  Q:$D(GMPQUIT)  W !
 . S NUM=$P(GRPS,",",PIECE) Q:NUM'>0
 .S IFN=$P($G(^TMP("GMPLST",$J,"B",NUM)),U,1) Q:+IFN'>0
 . S HDR=$P(^TMP("GMPLIST",$J,IFN),U,3),FLG=$P(^TMP("GMPLIST",$J,IFN),U,4)
 . S HDR=$$HDR(HDR) I HDR="^" S GMPQUIT=1 Q
 . S FLG=$$FLAG(FLG) I FLG="^" S GMPQUIT=1 Q
 . S $P(^TMP("GMPLIST",$J,IFN),U,3,4)=HDR_U_FLG,GMPREBLD=1
 I $D(GMPREBLD) S VALMBCK="R",GMPLSAVE=1 D BUILD^GMPLBLD("^TMP(""GMPLIST"",$J)",GMPLMODE)
EDQ S:'VALMCC VALMBCK="R" S VALMSG=$$MSG^GMPLX
 Q
