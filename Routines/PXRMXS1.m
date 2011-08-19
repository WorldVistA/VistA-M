PXRMXS1 ; SLC/PJH - Reminder Reports DIC Prompts;10/11/2001
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;
 ;Check for category reminders
 ;----------------------------
FOUND(CIEN) ;
 N DATA,FOUND,RIEN,SUB
 S FOUND=0,SUB=0
 F  S SUB=$O(^PXRMD(811.7,CIEN,2,SUB)) Q:SUB=""  D  Q:FOUND
 .S DATA=$G(^PXRMD(811.7,CIEN,2,SUB,0)) Q:DATA=""
 .S RIEN=$P(DATA,U) Q:RIEN=""
 .;Ignore disabled reminders
 .I '$P($G(^PXD(811.9,RIEN,0)),U,6) S FOUND=1
 Q FOUND
 ;
 ;Add reminder category reminders to reminder array
 ;-------------------------------------------------
MERGE N RCIEN,RCNT,RCSUB,RIEN,RPNAM,RSUB,SUB
 K ^TMP("PXRMXS1",$J)
 K REMINDER
 ;Extract each category in turn
 S RCSUB=""
 F  S RCSUB=$O(PXRMRCAT(RCSUB)) Q:'RCSUB  D
 .S RCIEN=$P(PXRMRCAT(RCSUB),U) Q:'RCIEN
 .;Add category reminders to reminder array
 .D MREM(RCIEN,.REMINDER)
 ;
 ;Add individual reminders at the end
 S SUB="",RSUB=+$O(REMINDER(""),-1)
 F  S SUB=$O(PXRMREM(SUB)) Q:'SUB  D
 .;Ignore duplicates
 .S RIEN=$P(PXRMREM(SUB),U) Q:'RIEN  Q:$D(^TMP("PXRMXS1",$J,RIEN))
 .S RSUB=RSUB+1,REMINDER(RSUB)=PXRMREM(SUB),^TMP("PXRMXS1",$J,RIEN)=""
 ;
 K ^TMP("PXRMXS1",$J)
 Q
 ;
MREM(CIEN,REM) ;Add to output array
 N DATA,NAME,NREM,RIEN,PNAME,SEQ,SUB,TEMP
 ;Add to end of list
 S NREM=+$O(REM(""),-1)
 ;
 ;Sort Reminders from this category into display sequence
 S SUB=0 K TEMP
 F  S SUB=$O(^PXRMD(811.7,CIEN,2,SUB)) Q:SUB=""  D
 .S DATA=$G(^PXRMD(811.7,CIEN,2,SUB,0)) Q:DATA=""
 .;Ignore duplicates
 .S RIEN=$P(DATA,U) Q:RIEN=""  Q:$D(^TMP("PXRMXS1",$J,RIEN))
 .S SEQ=$P(DATA,U,2)_0
 .S DATA=$G(^PXD(811.9,RIEN,0))
 .S NAME=$P(DATA,U),PNAME=$P(DATA,U,3)
 .S TEMP(SEQ)=RIEN_U_NAME_U_NAME_U_PNAME
 .S ^TMP("PXRMXS1",$J,RIEN)=""
 ;
 ;Re-save reminders in output array for display
 ;unique number^type^name^parent^reminder ien
 ;
 S SEQ=""
 F  S SEQ=$O(TEMP(SEQ)) Q:SEQ=""  D
 .S NREM=NREM+1,REM(NREM)=TEMP(SEQ)
 ;
 ;Sort Sub-Categories for this category into display order
 S SUB=0 K TEMP
 F  S SUB=$O(^PXRMD(811.7,CIEN,10,SUB)) Q:SUB=""  D
 .S DATA=$G(^PXRMD(811.7,CIEN,10,SUB,0)) Q:DATA=""
 .S SEQ=$P(DATA,U,2),TEMP(SEQ)=SUB
 ;
 ;Process sub-sub categories in the same manner
 S SEQ=""
 F  S SEQ=$O(TEMP(SEQ)) Q:SEQ=""  D
 .N IEN
 .S SUB=TEMP(SEQ),IEN=$P($G(^PXRMD(811.7,CIEN,10,SUB,0)),U) Q:'IEN
 .D MREM(IEN,.REM)
 Q
 ;
 ;Check if a category has any sub-categories
 ;------------------------------------------
OK(CIEN) ;
 ;Check in reminder multiple
 I $$FOUND(CIEN) Q 1
 ;
 ;Otherwise check the sub-categories
 N DATA,FOUND,IEN,SUB
 S FOUND=0,SUB=0
 F  S SUB=$O(^PXRMD(811.7,CIEN,10,SUB)) Q:SUB=""  D  Q:FOUND
 .S DATA=$G(^PXRMD(811.7,CIEN,10,SUB,0)) Q:DATA=""
 .S IEN=$P(DATA,U) Q:'IEN
 .;Check for active reminders in reminder multiple
 .S FOUND=$$FOUND(IEN)
 Q FOUND
