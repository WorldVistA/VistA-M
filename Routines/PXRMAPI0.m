PXRMAPI0 ; SLC/PJH - Reminder Package API's;08/28/2001
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;
 ;Store CATEGORY reminders in ARRAY ; DBIA #3333
 ;---------------------------------
CATREM(CIEN,ARRAY) ;
 D STORE(CIEN,.ARRAY,0)
 Q
 ;
STORE(CIEN,ARRAY,NREM) ;Add to output array
 N DATA,NAME,RIEN,PNAME,SEQ,SUB,TEMP
 ;Sort Reminders from this category into display sequence
 S SUB=0 K TEMP
 F  S SUB=$O(^PXRMD(811.7,CIEN,2,SUB)) Q:SUB=""  D
 .S DATA=$G(^PXRMD(811.7,CIEN,2,SUB,0)) Q:DATA=""
 .S RIEN=$P(DATA,U) Q:RIEN=""
 .S SEQ=$P(DATA,U,2)_0
 .S DATA=$G(^PXD(811.9,RIEN,0))
 .S NAME=$P(DATA,U),PNAME=$P(DATA,U,3)
 .S TEMP(SEQ)=RIEN
 ;
 ;Re-save reminders in output array for display
 ;type^reminder ien^name
 ;
 S SEQ=""
 F  S SEQ=$O(TEMP(SEQ)) Q:SEQ=""  D
 .S NREM=NREM+1,ARRAY(NREM)=TEMP(SEQ)
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
 .D STORE(IEN,.ARRAY,.NREM)
 Q
 ;
OK(DIEN) ;Replaces DBA 3410 for TIU TEMPLATE REMINDER DIALOGS
 ;Must be a reminder dialog type
 I $P($G(^PXRMD(801.41,DIEN,0)),U,4)'="R" Q 0
 ;And not disabled
 I $P($G(^PXRMD(801.41,DIEN,0)),U,3)'="" Q 0
 ;Otherwise its OK
 Q 1
