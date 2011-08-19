PXRMCAT ; SLC/PJH - Edit/Inquire reminder categories ;01/05/2001
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;Called by option PXRM REMINDER CATEGORIES
 ;
START N DIC,PXRMHD,PXRMCAT,PXRMGTYP,Y
SELECT ;General selection
 S PXRMHD="Reminder Categories",PXRMGTYP="RCAT",PXRMCAT=""
 D START^PXRMSEL(PXRMHD,PXRMGTYP,"PXRMCAT")
 ;Should return a value
 I PXRMCAT D  G SELECT
 .S PXRMHD="REMINDER CATEGORY NAME:"
 .;Listman option
 .D START^PXRMGEN(PXRMHD,PXRMGTYP,PXRMCAT)
END Q
 ;
 ;Build Category Inquiry array
 ;----------------------------
BUILD(ARRAY,D0) ;
 N D1,IC,LEVEL,SEQ,TAB,TXT,TEMP
 ;Category Description
 S LEVEL=5 D DES
 ;Reminders
 S LEVEL=0 D REM
 ;Sort Sub-category into display order
 D SORT(D0,.TEMP)
 ;Sub-category ... D0=IEN OF PARENT D1=NODE NUMBER IN 10 OF CHILD 
 S SEQ=0
 F  S SEQ=$O(TEMP(SEQ)) Q:'SEQ  D
 .S D1=TEMP(SEQ)
 .D GETLST(D0,D1,0)
 Q
 ;
 ;Build display for selected category - Called from PXRMGEN
 ;---------------------------------------------------------
CAT(PXRMCAT) ;
 N DATA,DARRAY,SUB
 S VALMCNT=0 K ^TMP("PXRMGENS",$J),^TMP("PXRMGEN",$J)
 ;
 ;Format headings to include category name
 S HEADER=PXRMHD_" "_$P(^PXRMD(811.7,PXRMCAT,0),U)
 ;
 ;Build Reminder Category Display
 D BUILD(.DARRAY,PXRMCAT) M ^TMP("PXRMGENS",$J)=DARRAY
 ; 
 ;Put the list into the array List Manager is using.
 S SUB="",VALMCNT=0
 F  S SUB=$O(^TMP("PXRMGENS",$J,SUB)) Q:SUB=""  D
 .S DATA=$G(^TMP("PXRMGENS",$J,SUB))
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMGEN",$J,VALMCNT,0)=DATA
 K ^TMP("PXRMGENS",$J)
 ;Create headings
 D CHGCAP^VALM("HEADER1","")
 D CHGCAP^VALM("HEADER2","")
 D CHGCAP^VALM("HEADER3","")
 Q
 ;
 ;Category description
 ;--------------------
DES ;array.
 N DIWF,DIWL,DIWR,SUB,X
 S DIWF="C70",DIWL=0,DIWR=70
 K ^UTILITY($J,"W")
 S SUB=0
 F  S SUB=$O(^PXRMD(811.7,D0,1,SUB)) Q:SUB=""  D
 .S X=$G(^PXRMD(811.7,D0,1,SUB,0))
 .D ^DIWP
 S ARRAY(1)="Category Description:",IC=1
 F  S SUB=$O(^UTILITY($J,"W",0,SUB)) Q:SUB=""  D
 .S IC=IC+1,ARRAY(IC)=$J("",LEVEL)_^UTILITY($J,"W",0,SUB,0)
 K ^UTILITY($J,"W")
 Q
 ;
 ;Get list of sub-categories
 ;--------------------------
GETLST(D0,D1,LEVEL) ;
 N CHILD,DATA,NAME,PXRMIEN,PXRMCAT,PXRMSEQ,SEQ,SUB,TEMP
 ;Determine if this subcategory has children
 S DATA=$G(^PXRMD(811.7,D0,10,D1,0)) Q:DATA=""
 S PXRMCAT=$P(DATA,U) Q:PXRMCAT=""
 S PXRMSEQ=$P(DATA,U,2),NAME=$G(^PXRMD(811.7,PXRMCAT,0))
 I NAME="" S NAME=PXRMCAT
 I LEVEL=0 S IC=IC+1,ARRAY(IC)=""
 S IC=IC+1,ARRAY(IC)=$J("",LEVEL)_"Sub-category:"_NAME
 S ARRAY(IC)=ARRAY(IC)_$J("",38-$L(NAME))_" Sequence: "_PXRMSEQ
 ;Increment tab
 S LEVEL=LEVEL+5
 ;Don't allow > 4 levels
 I LEVEL>20 S IC=IC+1,ARRAY(IC)=$J("",LEVEL)_"Further levels" Q
 ;Save details of reminders for this category
 D REM
 ;Sort Sub-categories into display order
 D SORT(PXRMCAT,.TEMP)
 ;
 ;Process sub-sub categories in the same manner
 S SEQ=""
 F  S SEQ=$O(TEMP(SEQ)) Q:SEQ=""  D
 .S SUB=TEMP(SEQ)
 .D GETLST(PXRMCAT,SUB,LEVEL)
 Q
 ;
 ;Reminders for this category
 ;---------------------------
REM S SUB=0 K TEMP
 ;Sort Reminders from this category into display sequence
 F  S SUB=$O(^PXRMD(811.7,PXRMCAT,2,SUB)) Q:SUB=""  D
 .S DATA=$G(^PXRMD(811.7,PXRMCAT,2,SUB,0)) Q:DATA=""
 .S PXRMIEN=$P(DATA,U) Q:PXRMIEN=""
 .S SEQ=$P(DATA,U,2)
 .S DATA=$G(^PXD(811.9,PXRMIEN,0)) Q:DATA=""
 .S NAME=$P(DATA,U) I NAME="" S NAME="Unknown"
 .S TEMP(SEQ_0)=NAME
 ;
 I LEVEL=0,$O(TEMP("")) S IC=IC+1,ARRAY(IC)=""
 ;
 ;Re-save reminders in output array for display
 S SEQ=""
 F  S SEQ=$O(TEMP(SEQ)) Q:SEQ=""  D
 .S IC=IC+1
 .S ARRAY(IC)=$J("",LEVEL)_"Sequence: "_$J(SEQ/10,2)_"   Reminder: "_TEMP(SEQ)
 Q
 ;
 ;Sort Sub-Categories for this category into display order
 ;--------------------------------------------------------
SORT(PXRMCAT,TEMP) ;
 N DATA,SEQ,SUB
 S SUB=0 K TEMP
 F  S SUB=$O(^PXRMD(811.7,PXRMCAT,10,SUB)) Q:SUB=""  D
 .S DATA=$G(^PXRMD(811.7,PXRMCAT,10,SUB,0)) Q:DATA=""
 .S SEQ=$P(DATA,U,2),TEMP(SEQ)=SUB
 Q
