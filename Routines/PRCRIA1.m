PRCRIA1 ;TPA/RAK/WASH IRMFO - Date Range ;8/27/96  15:37
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
DATERNG(EARLY,LATE) ;Extrinsic Function - returns start & end dates
 ;---------------------------------------------------------------------
 ;     DATE - Value returned in four pieces.
 ;
 ;            fmstartdate^fmenddate^ouputstartdate^outputenddate
 ;
 ;            Piece one and two are the date ranges in fileman format.
 ;            Piece three and four are the same dates in output format:
 ;                             dy-Mon-yr
 ;
 ;                               ********
 ;                               * NOTE *
 ;                               ********
 ;          - The first piece will always be the earliest date entered.
 ;
 ;          - The second piece 'ending date' will have .999 concatenated
 ;            to the end of it for fileman sorting purposes. Strip this
 ;            off if not needed.  Ex: S $P(DATE,U,2)=$P($P(DATE,U,2),"."
 ;
 ;  Optional Parameters:
 ;
 ;    EARLY - If defined, the earliest date that may be selected.
 ;            (must be in fileman format)
 ;
 ;     LATE - If defined, the latest date that may be selected.
 ;            (must be in fileman format)
 ;---------------------------------------------------------------------
 N DATE,DATE1,DATE2,DIR,DIRUT,LINE,X,Y
 S DATE="",EARLY=$G(EARLY),LATE=$G(LATE)
RANGE ;Ask date ranges
 S DIR(0)="DOA^"_$S(EARLY:EARLY,1:"")_":"_$S(LATE:LATE,1:"")_":E)"
 S DIR("A")="Start with Date: "
 S DIR("?")=" "
 S DIR("?",1)="Enter the starting date.",LINE=2
 I EARLY S DIR("?",LINE)="Date must not precede "_$$FMTE^XLFDT(EARLY),LINE=LINE+1
 I LATE S DIR("?",LINE)="Date must not follow "_$$FMTE^XLFDT(LATE)
 W ! D ^DIR I $D(DIRUT) Q ""
 S DATE1=Y,DIR("A")="  End with Date: "
 S DIR("?",1)="Enter the ending date."
 D ^DIR W:Y="" !!,"You must enter an 'End with Date'" G:Y="" RANGE I Y="^" Q ""
 S DATE2=Y,Y=1 I DATE1=DATE2 K DIR D 
 .S DIR(0)="YO",DIR("A")="Are you asking for just one days data"
 .S DIR("B")="Y" W ! D ^DIR K DIR
 I Y="^" Q ""
 I Y'=1 G RANGE
 ; Set earliest date into first piece.
 S DATE=$S(DATE2<DATE1:DATE2,1:DATE1)_U_$S(DATE2>DATE1:DATE2,1:DATE1)
 S $P(DATE,U,3)=$$FMTE^XLFDT($P(DATE,U))
 S $P(DATE,U,4)=$$FMTE^XLFDT($P(DATE,U,2))
 S $P(DATE,U,2)=$P(DATE,U,2)_.999
 Q DATE
