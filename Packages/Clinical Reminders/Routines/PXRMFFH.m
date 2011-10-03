PXRMFFH ; SLC/PKR - Routines for function finding help. ;01/13/2008
 ;;2.0;CLINICAL REMINDERS;**12**;Feb 04, 2005;Build 73
 ;
 ;======================================================
FSXHELP ;Function finding function string executable help.
 N DONE,IND,TEXT
 S DONE=0
 F IND=1:1 Q:DONE  D
 . S TEXT=$P($T(TEXT+IND),";",3)
 . I TEXT="**End Text**" S DONE=1 Q
 . W !,TEXT
LOOP ;
 K TEXT
 S FUN=$$SELECT("^PXRMD(802.4)")
 I FUN=0 Q
 D GFTEXT(1,FUN,.TEXT)
 D EN^DDIOL(.TEXT) G LOOP
 Q
 ;
 ;======================================================
GFTEXT(START,FUN,TEXT) ;Load descriptions of available function finding
 ;functions into the TEXT array starting at line START.
 N IEN,IND,NDL,NL,PNAME
 S NL=START
 S IEN=$O(^PXRMD(802.4,"B",FUN,""))
 S PNAME=$P(^PXRMD(802.4,IEN,0),U,4)
 S NL=NL+1,TEXT(NL)=" "
 S NL=NL+1,TEXT(NL)="Function: "_FUN
 S NL=NL+1,TEXT(NL)="Print Name: "_PNAME
 ;Load the description
 S NL=NL+1,TEXT(NL)="Description:"
 S NDL=+$P($G(^PXRMD(802.4,IEN,1,0)),U,4)
 F IND=1:1:NDL D
 . S NL=NL+1,TEXT(NL)=^PXRMD(802.4,IEN,1,IND,0)
 Q
 ;
 ;======================================================
SELECT(GBL) ;
 N CNT,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FUN,X,Y
 S DIR("A")="For help on the functions select from the available function types"
 S DIR(0)="SO^"
 S CNT=1
 S FUN="" F  S FUN=$O(@GBL@("B",FUN)) Q:FUN=""  D
 . I CNT=1 S DIR(0)=DIR(0)_CNT_":"_FUN
 . I CNT>1 S DIR(0)=DIR(0)_";"_CNT_":"_FUN
 . S CNT=CNT+1
 D ^DIR
 I Y=""!(Y["^") Q +Y
 Q Y(0)
 ;
 ;======================================================
TEXT ;Function finding help text.
 ;;The general form for a function finding is:
 ;; FUN1(arg1,arg2,...argN) oper1 FUN2(arg1,arg2,...,argN) ...
 ;; where FUN1 stands for function 1, FUN2 function 2, and so on.
 ;; arg1,arg2,...,argN are the regular findings whose data are arguments
 ;; to the function and oper1 stands for a MUMPS operator.
 ;; The operators can be any of the following MUMPS operators:
 ;; +,-,>,<,=,&,!,[, ] and '.
 ;; 
 ;;When a function finding is evaluated the result will be treated as a logical
 ;;true or false, where 0 is false and non-zero is true.
 ;;
 ;;An example of a function finding is: MRD(1,2)>MRD(5,6,7)
 ;;This function finding will be true if the most recent date
 ;;of regular findings 1 and 2 is greater than the most recent
 ;;date of regular findings 5, 6, and 7.
 ;;
 ;;**End Text**
 Q
 ;
