PXRMFFH ;SLC/PKR - Routines for function finding help. ;03/01/2013
 ;;2.0;CLINICAL REMINDERS;**12,18,26**;Feb 04, 2005;Build 404
 ;
 ;======================================================
FSXHELP ;Function finding function string executable help.
 N DIR0,DONE,IND,TEXT
 S DONE=0
 ;Load the general help text.
 F IND=1:1 Q:DONE  D
 . S TEXT(IND)=$P($T(GHTEXT+IND),";",3)
 . I TEXT(IND)="**End Text**" K TEXT(IND) S DONE=1 Q
 ;Load the help text for the functions.
 D GFTEXT(IND-2,.TEXT)
 D BROWSE^DDBR("TEXT","NR","Function Finding Help")
 I $D(DDS) D REFRESH^DDSUTL S DY=IOSL-7,DX=0 X IOXY S $Y=DY,$X=DX
 Q
 ;
 ;======================================================
GFTEXT(START,TEXT) ;Load descriptions of available function finding
 ;GFTEXT(START,FUN,TEXT) ;Load descriptions of available function finding
 ;functions into the TEXT array starting at line START.
 N IEN,IND,FUNCTION,NDL,NL,PNAME
 S NL=START
 S FUNCTION=""
 F  S FUNCTION=$O(^PXRMD(802.4,"B",FUNCTION)) Q:FUNCTION=""  D
 . S NL=NL+1,TEXT(NL)=" "_FUNCTION
 S NL=NL+1,TEXT(NL)=""
 S NL=NL+1,TEXT(NL)="Details for each function follow."
 ;
 S FUNCTION=""
 F  S FUNCTION=$O(^PXRMD(802.4,"B",FUNCTION)) Q:FUNCTION=""  D
 . S IEN=$O(^PXRMD(802.4,"B",FUNCTION,""))
 . S PNAME=$P(^PXRMD(802.4,IEN,0),U,4)
 . S NL=NL+1,TEXT(NL)=" "
 . S NL=NL+1,TEXT(NL)="Function: "_FUNCTION
 . S NL=NL+1,TEXT(NL)="Print Name: "_PNAME
 .;Load the description
 . S NL=NL+1,TEXT(NL)="Description:"
 . S NDL=+$P($G(^PXRMD(802.4,IEN,1,0)),U,4)
 . F IND=1:1:NDL S NL=NL+1,TEXT(NL)=^PXRMD(802.4,IEN,1,IND,0)
 Q
 ;
 ;======================================================
GHTEXT ;Function finding general help text.
 ;;The general form for a function finding string is:
 ;; FUN1(arg1,arg2,...argN) oper1 FUN2(arg1,arg2,...,argN) ...
 ;; where FUN1 stands for function 1, FUN2 function 2, and so on.
 ;; arg1,arg2,...,argN are the regular findings whose data are arguments
 ;; to the function and oper1 stands for a MUMPS operator.
 ;; The operators can be any of the following MUMPS operators:
 ;; !&-+*/\#<>='][
 ;; 
 ;;When a function finding is evaluated, the result will be treated as a logical
 ;;true or false, where 0 is false and non-zero is true.
 ;;
 ;;An example of a function finding string is:
 ;; MRD(1,2)>MRD(5,6,7)
 ;;
 ;;This function finding will be true if the most recent date
 ;;of regular findings 1 and 2 is greater than the most recent
 ;;date of regular findings 5, 6, and 7.
 ;;
 ;;Comparisons to fixed values can also be made. An example of this is:
 ;;
 ;; MRD(1,2)>0
 ;;
 ;;Some dates associated with findings include time. For those functions
 ;;that have dates as arguments, if a date includes time, the full date
 ;;and time will be used in the calculation.
 ;;
 ;;The function finding functions are:
 ;;**End Text**
 Q
 ;
