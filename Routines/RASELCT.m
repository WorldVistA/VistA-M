RASELCT ;HISC/DAD-Generic file entry selector ;7/1/98  15:48
 ;;5.0;Radiology/Nuclear Medicine;**83**;Mar 16, 1998;Build 4
 ;
 ;*** SELECTS A GROUP OF RECORDS FROM A FILE ***
 ;
 ;REQUIRES:
 ;  RADIC      = FILE NUMBER OR GLOBAL ROOT
 ;  RADIC(0)   = DIC(0) STRING
 ;  RAUTIL     = NODE TO STORE DATA UNDER IN ^TMP($J,RAUTIL,
 ;
 ;OPTIONAL:
 ;  RADIC("A") = DIC("A") STRING
 ;  RADIC("B") = DIC("B") STRING
 ;  RADIC("S") = DIC("S") STRING
 ;  RADIC("W") = DIC("W") STRING
 ;     RAARRY  = LOCAL ARRAY TO STORE DATA IN
 ;     RAFLD   = field to sort by if valid data to be stored as
 ;               ^TMP($J,RAUTIL,external value of RAFLD,IEN)=""
 ;               RAFLD must reside on the zero (0) node to be valid!
 ;     RAINPUT = ONE/MANY/ALL DISTINCTION (1=ALL, 0=ONE/MANY)
 ;
 ;RETURNS:
 ;  1) RAQUIT     = $S(UP_ARROW_OUT:1 , NOTHING_SELECTED:1 , 1:0)
 ;  2) ^TMP($J,RAUTIL,EXTERNAL_.01_FIELD_DATA,IEN) = ""
 ;  3) if $D(RAFLD), ^TMP($J,RAUTIL,EXTERNAL_RAFLD_DATA,IEN) = ""
 ;
EN1(RADIC,RAUTIL,RAARRY,RAINPUT,RAFLD) ;
 S RAQUIT=0 I ($D(RADIC)[0)!($D(RADIC(0))[0)!($D(RAUTIL)[0) S RAQUIT=1 G EXIT
 I (RADIC="")!(RADIC(0)="")!(RAUTIL="") S RAQUIT=1 G EXIT
 I $G(RAINPUT)=0 K RADIC("B")
 D K S DIC=RADIC I DIC S (RADIC,DIC)=$S($D(^DIC(DIC,0,"GL"))#2:^("GL"),1:"") I DIC="" S RAQUIT=1 G EXIT
 S DIC(0)=RADIC(0),DIC(0)=$TR(DIC(0),"AL") S:DIC(0)'["Z" DIC(0)=DIC(0)_"Z" S RADIC(0)=DIC(0)
 D DO^DIC1 S RAFNUM=+DO(2),RAFNAME=$P(DO,"^"),RAFLD01=$P(^DD(RAFNUM,.01,0),"^"),RAFSCR=$S($D(DO("SCR"))#2:DO("SCR"),1:"") K DO
 I $G(RAFLD)]"" S RAQUIT=$$FLD(RAFNUM,RAFLD) G:RAQUIT EXIT
 S RACASE=$S($E(RAFLD01,($L(RAFLD01)))?1L:"s",1:"S")
 F X="A","B","S","W" S RADIC(X)=$S($D(RADIC(X))#2:RADIC(X),1:"")
 S:RADIC("A")="" RADIC("A")="Select "_RAFNAME_" "_RAFLD01_": "
 S RAALL=0,RANUM=1 K ^TMP($J,RAUTIL) D HOME^%ZIS
1 D SETDIC W !!,$S(RANUM>1:"Another one (Select/De-Select): ",1:DIC("A")),$S((RANUM=1)&(RADIC("B")]""):RADIC("B")_"// ",1:"")
 R X:DTIME S:('$T)!($E(X)="^") RAQUIT=1 G:RAQUIT EXIT S:(RANUM=1)&(X="")&(RADIC("B")]"") X=RADIC("B") G:X="" EXIT S RADSEL=$S(X?1"-"1.E:1,1:0) S:RADSEL X=$E(X,2,$L(X))
 ; RA*5*83 require exactly 3 chars when checking for "ALL"
 I $L(X),(($L(X)=3&("Aa"[$E(X))&("Ll"[$E(X,2))&("Ll"[$E(X,3)))!(X["*")) D ALL G EXIT:RAQUIT,1:RAALL
 D HELP:$E(X)="?"
 I $L($G(DIC("S")))<235 S DIC("S")=$S($G(DIC("S"))]"":DIC("S")_" ",1:"")_"I $$SEL^RASELCT(Y)"
 D ^DIC K DIC G:+Y'>0 1
 S RAMASK=+Y
 I $$CHFLD(RAFNUM)["D" D
 . N %DT,X
 . S X=Y(0,0),%DT="ST" D ^%DT S Y(0,0)=Y
 . Q
 S Y=RAMASK
 I $G(RAFLD)']"" D
 . I 'RADSEL,'$D(^TMP($J,RAUTIL,$E(Y(0,0),1,63),+Y)) S ^(+Y)="",RANUM=RANUM+1
 . I RADSEL,$D(^TMP($J,RAUTIL,$E(Y(0,0),1,63),+Y)) K ^(+Y) S RANUM=RANUM-$S(RANUM>0:1,1:0)
 . Q
 E  D
 . S RAVALUE=$$FLDSRT(RAFNUM,RAFLD) Q:RAVALUE']""
 . I 'RADSEL,'$D(^TMP($J,RAUTIL,$E(RAVALUE,1,63),+Y)) S ^(+Y)="",RANUM=RANUM+1
 . I RADSEL,$D(^TMP($J,RAUTIL,$E(RAVALUE,1,63),+Y)) K ^(+Y) S RANUM=RANUM-$S(RANUM>0:1,1:0)
 . Q
 G 1
EXIT ;
 I 'RAQUIT,($L($G(RAARRY))),('$D(@RAARRY)) D
 . S %X="^TMP($J,"""_RAUTIL_""",",%Y=RAARRY_"("
 . D %XY^%RCR
 . Q
 S RAQUIT=$S(RAQUIT:1,$O(^TMP($J,RAUTIL,""))="":1,1:0) K RADIC,RAUTIL
K K %,%X,%Y,%Z,C,D0,DA,DIC,DIK,DIR,DO,RA,RAALL,RACASE,RAD0,RADSEL,RAFLD01
 K RAFNAME,RAFNUM,RAFSCR,RALINE,RAMASK,RANUM,RAVALUE,X,Y
 Q
ALL ;
 ;I $G(RAINPUT)=0 Q
 S RAALL=1 ; Assume the user answers desires ALL entries!
 N PAT,RAX S RAX=X N X
 I RAX["*" D
 . N CHAR,I,TEMP
 . S PAT="Y'?",TEMP=""
 . F I=1:1:$L(RAX) D
 .. S CHAR=$E(RAX,I)
 .. I CHAR'="*" S TEMP=TEMP_CHAR Q
 .. D BLDPAT
 .. Q
 . D BLDPAT
 . Q
 F RAD0=0:0 S RAD0=$O(@(RADIC_"RAD0)")) Q:RAD0'>0  D AL
 W:RANUM=1&'RADSEL " ??",$C(7)
 Q
AL I RAFSCR]"" D SETDIC I $D(@(RADIC_"RAD0,0)"))#2 S (D0,DA,Y)=RAD0 X RAFSCR Q:'$T
 I RADIC("S")]"" D SETDIC I $D(@(RADIC_"RAD0,0)"))#2 S (D0,DA,Y)=RAD0 X DIC("S") Q:'$T
 S Y=$P($G(@(RADIC_"RAD0,0)")),"^"),C=$P(^DD(RAFNUM,.01,0),"^",2)
 Q:Y=""  D Y^DIQ
 I $$CHFLD(RAFNUM)["D" D
 . N %DT,X
 . S X=Y,%DT="ST" D ^%DT
 . Q
 I RAX["*",@PAT Q
 I $G(RAFLD)']"" D
 . I 'RADSEL,'$D(^TMP($J,RAUTIL,$E(Y,1,63),RAD0)) S ^(RAD0)="",RANUM=RANUM+1
 . I RADSEL,$D(^TMP($J,RAUTIL,$E(Y,1,63),RAD0)) K ^(RAD0) S RANUM=RANUM-$S(RANUM>0:1,1:0)
 . Q
 E  D
 . N Y S Y=+RAD0,Y(0)=$G(@(RADIC_+Y_",0)")),Y(0,0)=$P(Y(0),"^")
 . S RAVALUE=$$FLDSRT(RAFNUM,RAFLD) Q:RAVALUE']""
 . I 'RADSEL,'$D(^TMP($J,RAUTIL,$E(RAVALUE,1,63),RAD0)) S ^(RAD0)="",RANUM=RANUM+1
 . I RADSEL,$D(^TMP($J,RAUTIL,$E(RAVALUE,1,63),RAD0)) K ^(RAD0) S RANUM=RANUM-$S(RANUM>0:1,1:0)
 . Q
 Q
HELP ;
 N X S RA="Select a "_RAFNAME_" "_RAFLD01_" from the displayed list." D WRAP
 W !?5,"To deselect a ",RAFLD01," type a minus sign (-)",!?5,"in front of it, e.g.,  -",RAFLD01,"."
 I $G(RAINPUT)=1 W !?5,"To get all ",RAFLD01,"S type ALL."
 W !?5,"Use an asterisk (*) to do a wildcard selection, e.g.,"
 W !?5,"enter ",RAFLD01,"* to select all entries that begin"
 W !?5,"with the text '",RAFLD01,"'.  Wildcard selection is"
 W !?5,"case sensitive."
 G:$O(^TMP($J,RAUTIL,""))="" HLP
SHOW S RALINE=$Y,RA="" W !!,"You have already selected:"
 F  S RA=$O(^TMP($J,RAUTIL,RA)) Q:RA=""!RAQUIT  F RAD0=0:0 S RAD0=$O(^TMP($J,RAUTIL,RA,RAD0)) Q:RAD0'>0!RAQUIT  D SHO
HLP W ! S RAQUIT=0
 Q
SHO I $G(RAFLD)]"" S RA(0)=$P($G(@(RADIC_+RAD0_",0)")),"^")
 E  S RA(0)=RA
 I $$CHFLD(RAFNUM)["D" D
 . N Y
 . S Y=RA(0) X ^DD("DD") S RA(0)=Y
 . Q
 I RADIC(0)["N" W !?3,RAD0,?15,RA(0)
 E  W !?3,RA(0)
 D SETDIC I $D(DIC("W"))#2,DIC("W")]"",$D(@(RADIC_"RAD0,0)"))#2 S (D0,DA,Y)=RAD0 X DIC("W")
 I $Y>(IOSL+RALINE-3) D PAUSE S RALINE=$Y
 Q
WRAP ;
 W ! F  S Y=$L($E(RA,1,IOM-20)," ") W !?5,$P(RA," ",1,Y) S RA=$P(RA," ",Y+1,999) Q:RA=""
 Q
PAUSE ;
 K DIR S DIR(0)="E" D ^DIR K DIR S RAQUIT=$S(Y:0,1:1)
 Q
SETDIC ;
 K DIC,DO S DIC=RADIC
 F X="0","A","B","S","W" I RADIC(X)]"" S DIC(X)=RADIC(X)
 D DO^DIC1
 Q
CHFLD(X) ;
 N A
 S A=$P($G(^DD(X,.01,0)),U,2)
 Q:A'["P" A
 F  D  Q:A'["P"
 . S A=$TR(A,$TR(A,".0123456789"))
 . S A=$$CHFLD(A)
 . Q
 Q A
SEL(Y) ;
 N %DT,DA,DIC,DIQ,DR,RAEXTRN,RAPOINT,X
 S (RAPOINT,DA)=Y,DIC=RAFNUM,DR=.01,DIQ(0)="E",DIQ="RAEXTRN("
 D EN^DIQ1 S RAEXTRN=$G(RAEXTRN(RAFNUM,RAPOINT,.01,"E"))
 I $$CHFLD(RAFNUM)["D" S X=RAEXTRN,%DT="ST" D ^%DT S RAEXTRN=Y
 S X=$D(^TMP($J,RAUTIL,RAEXTRN,RAPOINT))
 Q $S(X#2&RADSEL:1,X[0&'RADSEL:1,1:0)
BLDPAT ;
 I TEMP]"" S PAT=PAT_"1"""_TEMP_""""
 I CHAR="*",$E(PAT,$L(PAT)-1,$L(PAT))'=".E" S PAT=PAT_".E"
 S TEMP=""
 Q
FLD(RAFNUM,RAFLD) ; Validate if field can be sorted on i.e, if 
 ; non-multiple and is either a pointer, free text, set of codes,
 ; numeric or a date/time field.
 ; 'RAFNUM' = File #           'RAFLD' = Field #
 ; returns RAPASS: 0 if valid, else 1
 Q:RAFLD=.01 1 ; .01 field is not valid!
 Q:'($D(^DD(RAFNUM,RAFLD,0))#2) 1 ; field does not exist
 N RA,RAPASS S RA(0)=$G(^DD(RAFNUM,RAFLD,0)),RA(2)=$P(RA(0),"^",2)
 S RA(4)=$P(RA(0),"^",4)
 Q:+RA(2)>0&($D(^DD(+RA(2),.01,0))) 1 ; field is a multiple, not valid
 Q:RA(4)'["0;" 1 ; field does not reside on the 0 node, not valid
 S RAPASS=1 ; set initially to not valid
 F RA="D","F","N","P","S" S:RA(2)[RA RAPASS=0 Q:'RAPASS
 Q RAPASS
FLDSRT(RAFNUM,RAFLD) ; Converts the internal value to the external value
 ; for sets of codes & pointers.
 ; 'RAFNUM' = File #           'RAFLD' = Field #
 ; 'RAPCE'  = piece position on 0 node
 N RAPCE S RAPCE=$P($P($G(^DD(RAFNUM,RAFLD,0)),"^",4),";",2)
 Q $$EXTERNAL^DILFD(RAFNUM,RAFLD,"",$P(Y(0),"^",RAPCE))
