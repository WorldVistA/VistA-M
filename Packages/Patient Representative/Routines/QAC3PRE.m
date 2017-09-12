QAC3PRE ;WCIOFO/ERC-Patch 3 Preinstall ;8/18/97
 ;;2.0;Patient Representative;**3**;07/25/95
 ; Routine will check the 8 Issue Codes whose names are changed
 ; with this patch and change the name now, so that the KIDS install
 ; will not create a second entry.
START ;
 N CNT,DIE,EE,QACBAD,QACCDE,QACCODE,QACDAT,QACISS,QACNUM,QACROC,QACTEXT
 S QACCODE="CA03^CA05^CC02^CC05^CC06^EL07^TI03^TI04"
 S QACTEXT(1)="Patient not Included/Disagree with Decisions about Care"
 S QACTEXT(2)="Dissatisfied with Referral Outcome"
 S QACTEXT(3)="Not treated with dignity and respect/Perceived rudeness"
 S QACTEXT(4)="Staff not listen to patient concerns/Patient feels rushed"
 S QACTEXT(5)="Phone calls not returned/answered"
 S QACTEXT(6)="VA billing for service/Pharmacy co-payment"
 S QACTEXT(7)="Excessive wait at facility for admission"
 S QACTEXT(8)="Excessive delay scheduling or rescheduling appt w/i facility"
 F CNT=1:1:8 S QACCDE=$P(QACCODE,U,CNT) D
 . S EE=0
 . S QACNUM=$O(^QA(745.2,"B",QACCDE,EE))
 . I $G(QACNUM)>0 S DIE="^QA(745.2,",DR="2///^S X=QACTEXT(CNT)",DA=QACNUM D ^DIE K DIE
 Q
