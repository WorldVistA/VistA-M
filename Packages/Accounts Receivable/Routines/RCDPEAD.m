RCDPEAD ;ALB/PJH - AUTO DECREASE ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**298**;Mar 20, 1995;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;Read ^IBM(361.1) via Private IA 4051
 ;
EN ;Auto Decrease - applies to auto-posted claims only
 N PAYID,PAYNAM,RCAMT,RCDATE,RCDAY,RCDREC,RCERA,RCLINE,RCSTART
 ;Quit if medical auto posting is OFF or medical auto decrease is OFF
 Q:'$P($G(^RCY(344.61,1,0)),U,2)  Q:'$P($G(^RCY(344.61,1,0)),U,3)
 ;Get the RCDPE PARAMETER file #344.61 field.04 AUTO DECREASE MED DAYS DEFAULT value and
 ;calculate process date by subtracting this value from today's date
 S RCDAY=$$FMADD^XLFDT(DT\1,-$P($G(^RCY(344.61,1,0)),U,4))
 ;Get the RCDPE PARAMETER file #344.61 field.05 AUTO DECREASE MED AMOUNT DEFAULT value
 S RCAMT=$P($G(^RCY(344.61,1,0)),U,5)
 ;Allow for a range of dates in future - currently only checks for RCDAY
 S RCDATE=$$FMADD^XLFDT(RCDAY,-1)
 ;Scan F index for ERA within date range
 F  S RCDATE=$O(^RCY(344.4,"F",RCDATE)) Q:'RCDATE  Q:(RCDATE\1)>RCDAY  D
 .;Scan "F" index of ERA file for ERA entries with AUTOPOST DATE field #4.03 matching RCDAY
 .S RCERA=0
 .F  S RCERA=$O(^RCY(344.4,"F",RCDATE,RCERA)) Q:'RCERA  D
 ..N RC3446,RCPARM
 ..;Check payer exclusion file for this ERA's payer
 ..S PAYID=$P($G(^RCY(344.4,RCERA,0)),U,3),PAYNAM=$P($G(^RCY(344.4,RCERA,0)),U,6)
 ..I PAYID'="",PAYNAM'="" S RCPARM=$O(^RCY(344.6,"CPID",PAYNAM,PAYID,"")) S:RCPARM'="" RC3446=$G(^RCY(344.6,RCPARM,0))
 ..;Ignore ERA if EXCLUDE MED CLAIMS POSTING  (#.06) or EXCLUDE MED CLAIMS DECREASE (#.07) fields set to 'yes'
 ..I $G(RC3446)]"" Q:$P(RC3446,U,6)=1  Q:$P(RC3446,U,7)=1
 ..;Build index to scratchpad for this ERA
 ..N RCARRAY D BUILD^RCDPEAP(RCERA,.RCARRAY)
 ..;Scan ERA DETAIL entries in #344.41 for auto-posted medical claims
 ..S RCLINE=0
 ..F  S RCLINE=$O(^RCY(344.4,"F",RCDATE,RCERA,RCLINE)) Q:'RCLINE  D
 ...;Ignore claim line if already auto decreased
 ...Q:$P($G(^RCY(344.4,RCERA,1,RCLINE,5)),U,3)
 ...;Get record detail
 ...S RCDREC=$G(^RCY(344.4,RCERA,1,RCLINE,0))
 ...;Get claim number RCBILL for the ERA line using EOB #361.1 pointer
 ...N COMMENT,EOBIEN,RCBAL,RCBILL,RCTRANDA
 ...;Get pointer to EOB file #361.1 from ERA DETAIL
 ...S EOBIEN=$P($G(^RCY(344.4,RCERA,1,RCLINE,0)),U,2),RCBILL=0
 ...;Get ^DGCR(399 pointer (DINUM for #430 file)
 ...S:EOBIEN RCBILL=$P($G(^IBM(361.1,EOBIEN,0)),U) Q:'RCBILL
 ...;If claim has been split/edit and claim changed in APAR do not auto decrease
 ...Q:$$SPLIT(RCERA,RCLINE,RCBILL,.RCARRAY)
 ...;Do not auto decrease if claim is referred to General Council
 ...Q:$P($G(^PRCA(430,RCBILL,6)),U,4)]""
 ...;Claim must be OPEN or ACTIVE
 ...N STATUS S STATUS=$P($G(^PRCA(430,RCBILL,0)),"^",8) I STATUS'=42,STATUS'=16 Q 
 ...;Do not auto decrease if claim principal balance is greater than auto decrease default amount
 ...S RCBAL=$P($G(^PRCA(430,RCBILL,7)),U) Q:RCBAL>RCAMT 
 ...;Check pending payments
 ...N PENDING S PENDING=$$PENDPAY^RCDPURET(RCBILL) K ^TMP($J,"RCDPUREC","PP") Q:PENDING>RCAMT
 ...;Apply contract adjustment for remaining balance on claim
 ...S RCTRANDA=$$INCDEC^RCBEUTR1(RCBILL,-RCBAL,"","","",1) Q:'RCTRANDA
 ...;Add comment
 ...S COMMENT(1)="Auto-Decrease Adjustment Medical" D ADDCOMM^RCBEUTRA(RCTRANDA,.COMMENT)
 ...;Update auto-decrease indicator, auto decrease amount and auto decrease date
 ...N DA,DIE,DR S DA(1)=RCERA,DA=RCLINE,DIE="^RCY(344.4,"_DA(1)_",1,",DR="7///1;8///"_RCBAL_";10///"_DT D ^DIE
 ..;Update last auto decrease date on ERA
 ..N DA,DIE,DR S DA=RCERA,DIE="^RCY(344.4,",DR="4.03///"_DT D ^DIE
 Q
 ;
SPLIT(RCSCR,RCLINE,RCBILL,RCARRAY) ;Check for SPLIT/EDIT in scratchpad
 ;Input RCSCR - IEN of #344.49
 ;      RCLINE - ERA detail line sequence number
 ;      RCBILL - IEN of #430
 ;      ARRAY - reference to passed array (from BUILD^RCDPEAP)
 ;Output return value 1/0 = Split/Not Split 
 N SUB,SUB1
 ;Find ERA line in scratchpad
 S SUB=$G(RCARRAY(RCLINE)) Q:'SUB 0
 ;Get n.001 line
 S SUB1=$O(^RCY(344.49,RCSCR,1,SUB)) Q:'SUB1 0
 ;Check sequence number is the same
 Q:$P($G(^RCY(344.49,RCSCR,1,SUB1,0)),".")'=$P($G(^RCY(344.49,RCSCR,1,SUB,0)),U) 0
 ;Check that claim number is unchanged from original ERA
 Q:$P($G(^RCY(344.49,RCSCR,1,SUB1,0)),U,7)=RCBILL 0
 ;Otherwise claim was edited (and should not be decreased)
 Q 1
