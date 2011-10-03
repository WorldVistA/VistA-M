MCRH2 ;WISC/TJK-RHEUMATOLOGY ICD CODE UPDATE FOR QMAN ;7/3/96  09:14
 ;;2.3;Medicine;;09/13/1996
 ;CALLED FROM DIAGNOSIS FIELD OF RHEUMATOLOGY FILE
SET N ICD
 S ICD=$G(^MCAR(697.5,X,2,1,0)) Q:'ICD
 S:'$D(^MCAR(701,DA(1),"ICD",0)) ^(0)="^701.01P^^"
 S $P(^MCAR(701,DA(1),"ICD",0),U,3)=DA,$P(^(0),U,4)=$P(^(0),U,4)+1
 S ^MCAR(701,DA(1),"ICD",DA,0)=ICD
 S ^MCAR(701,DA(1),"ICD","B",ICD,DA)=""
 Q
KILL N ICD,I,I1
 S ICD=$P($G(^MCAR(701,DA(1),"ICD",DA,0)),U) Q:'ICD
 K ^MCAR(701,DA(1),"ICD",DA),^MCAR(701,DA(1),"ICD","B",ICD,DA)
 S $P(^MCAR(701,DA(1),"ICD",0),U,4)=$P(^MCAR(701,DA(1),"ICD",0),U,4)-1
 S I=0 F  S I=$O(^MCAR(701,DA(1),"ICD",I)) Q:I'?1N.N  S I1=I
 S $P(^MCAR(701,DA(1),"ICD",0),U,3)=$S($G(I1):I1,1:"")
 Q
PRINT ;PRINTS OUT ICD CODE ON DIAGNOSIS PRINT-CALLED BY PRINT TEMPLATE
 N ICD
 S ICD=$P($G(^MCAR(701,D0,"ICD",D1,0)),U)
 S:ICD'="" ICD=$P(^ICD9(ICD,0),U)
 W ?68,ICD
 Q
TEXTHELP ; Display help text from the Data dictionary at the beginging of ever field for RHEUMATOLOGY
 Q
 N LM,RM,HELP S LM=80,RM=0,HELP=$G(^DD(DJDD,DJAT,3)) D TEXT(HELP,LM,RM)
 Q
TEXT(STRING,LM,RM) ;Word warps a string of text and prints it out
 ;
 ;STRING = The text to display on the screen
 ;    LM = The left margin
 ;    RM = the right margin
 N SPACE,LINE,WORD,TEXT,LENGTH,COUNT,TEMP
 S RM=+RM,LM=+LM
 I (LM>80)!(LM=0) S LM=80
 I LM<RM S RM=TEMP,RM=LM,LM=TEMP
 S STRING=STRING_" <*>" ; set up a stopper for word spitter this will allow double spacing between sentences.
 I $D(DJCP) X DJCP ; if using the screen handler move to the bottom
 F SPACE=1:1 S WORD(SPACE)=$P(STRING," ",SPACE) Q:WORD(SPACE)="<*>"
 K WORD(SPACE) S TEXT="",SPACE=SPACE-1
 F COUNT=1:1:SPACE D
 .S TEMP=TEXT_WORD(COUNT)_" "
 .I $L(TEMP)>(LM-RM) W !,?RM,TEXT S TEXT=WORD(COUNT)_" "
 .E  S TEXT=TEMP
 .Q  ; end for
 W !,?RM,TEXT ; Write the text at the right margin
 I $D(DJJ($G(V))),$D(XY) S @$P(DJJ(V),U,2) X XY ;if using the screen handle routine move back to the field location. 
