KMPDUT4B ;OAK/RAK; Multi-Lookup Array Selection cont. ;2/17/04  10:48
 ;;2.0;CAPACITY MANAGEMENT TOOLS;;Mar 22, 2002
 ;
 ;--------------------------------------------------------------------
 ;  sub-routines to select entries - called from ^KMPDUT4
 ;--------------------------------------------------------------------
ALL ;all entries selected
 Q:'$D(ARRAY)!('$D(DIC))  S MAX=+$G(MAX),SORT=+$G(SORT)
 K @ARRAY I DIC S DIC=$G(^DIC(DIC,0,"GL"))
 I MAX,($P($G(@(DIC_"0)")),U,4)>MAX) S @ARRAY@(0)="*" Q
 N ASKI W "  selecting 'All' entries"
 F ASKI=0:0 S ASKI=$O(@(DIC_ASKI_")")) Q:'ASKI  D SET(ASKI)
 Q
DISPLAY ;display entries that have been selected
 Q:'$D(DIC)  S SORT=+$G(SORT)
 I '$D(@ARRAY) W !!,"...no entries have been selected...",! Q
 I @ARRAY@(0)="*" W !!,"...'All' entries have been selected...",! Q
 D HDR^KMPDUTL4("Selected Entries from "_$P($G(@(DIC_"0)")),U)_" file")
 N ASKI,ASKOUT S ASKI="",ASKOUT=1 W !!
 F  S ASKI=$O(@ARRAY@(ASKI)) Q:ASKI=""!(ASKOUT'=1)  I ASKI'=0 D 
 .I $Y>(IOSL-4) D  Q:ASKOUT'=1
 ..D FTR^KMPDUTL4("",.ASKOUT) Q:ASKOUT'=1
 ..D HDR^KMPDUTL4("Selected Entries from "_$P($G(@(DIC_"0)")),U)_" file")
 ..W !!
 .W !?7,$S(SORT=1:ASKI,1:@ARRAY@(ASKI))
 W !
 Q
WILDCARD(X) ;entries with wildcard selected
 ;--------------------------------------------------------------------
 ;  allow wildcard selections
 ;       examples: A*
 ;                 ABC*
 ;                 SMITH*
 ;--------------------------------------------------------------------
 Q:$G(X)']""
 N ASKI,COUNT,NARRAY,OUT,STR,STR1 S (COUNT,OUT)=0
 S MAX=+$G(MAX),SORT=+$G(SORT) S:$G(D)']"" D="B"
 S STR=$E(X,1,($F(X,"*")-2)) Q:STR']""
 S STR1=STR,NARRAY=DIC_""""_D_""""_")"
 ;--------------------------------------------------------------------
 ;  if exact match on STR1
 ;--------------------------------------------------------------------
 I $D(@NARRAY@(STR1)) S ASKI=0 D  Q
 .I STR?.N S NARRAY=DIC_""""_D_""""_","_STR_")"
 .E  S NARRAY=DIC_""""_D_""""_","_""""_STR_""""_")"
 .F  S ASKI=$O(@NARRAY@(ASKI)) Q:'ASKI  D  Q:OUT
 ..D SET(ASKI) I MAX,(+$G(@ARRAY@(0))=MAX) S OUT=1
 ;--------------------------------------------------------------------
 ;  if not an exact match
 ;--------------------------------------------------------------------
 F  S STR1=$O(@NARRAY@(STR1)) Q:$E(STR1,1,$L(STR))'=STR  D  Q:OUT
 .F ASKI=0:0  S ASKI=$O(@NARRAY@(STR1,ASKI)) Q:'ASKI  D  Q:OUT
 ..D SET(ASKI) I MAX,(+$G(@ARRAY@(0))=MAX) S OUT=1
 Q
SET(IFN) ;set selected data into array
 ;--------------------------------------------------------------------
 ;    IFN - internal file number of entry
 ;--------------------------------------------------------------------
 N X,Y S IFN=+$G(IFN),SORT=+$G(SORT) Q:'IFN
 Q:'$D(DIC)!('$D(ARRAY))
 Q:'$D(@(DIC_IFN_",0)"))!($P($G(^(0)),U)']"")
 S X="`"_ASKI,DIC(0)="Z" D ^DIC Q:Y'>0
 I SORT=1 S @ARRAY@(Y(0,0))=+Y
 E  S @ARRAY@(+Y)=Y(0,0)
 S @ARRAY@(0)=$G(@ARRAY@(0))+1 W:$X>73 !?7 W "."
 Q
 ;  for future use - if unable to use `IFN in call to ^DIC
 I SORT=1 S @ARRAY@($P($G(@(DIC_ASKI_",0)")),U))=ASKI
 E  S @ARRAY@(ASKI)=$P($G(@(DIC_ASKI_",0)")),U)
