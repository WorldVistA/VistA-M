IBYEPT ;ALB/BGA - PATCH IB*2*40 POST - INITIALIZATION ; 1-AUG-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**40**; 21-MAR-94
 ;
EN ; Patch IB*2*40 post initialization.
 ;
 D FIX ;       Fix spelling of Non-Acute Classification entry
 D ^IBYEPT1 ;  Queue job to clean up 'Name of Insured'
 Q
 ;
 ;
FIX ; This call corrects a problem with the spelling of the
 ; entry 'ADMISSION TO CIRCUMENT SLOWNESS' (code 3.03) in
 ; file 356.4.  'CIRCUMENT' should be spelled 'CIRCUMVENT.'
 ;
 W !!,">>> Correcting the spelling of the entry 'ADMISSION TO CIRCUMENT SLOWNESS'"
 W !,"    (code 3.03) in file #356.4 ...   "
 N IBENT,DA,DR,DIE
 I '$D(^IBE(356.4,"C","3.03")) W *7,!,"    This entry is not cross-referenced correctly!",!,"    Please contact IRMFO Customer Service staff for assistance." Q
 S IBENT=$O(^IBE(356.4,"C","3.03",0)) I IBENT'>0 W *7,!,"    This entry could not be found!",!,"    Please contact IRMFO Customer Service staff for assistance." Q
 S DR=".01////ADMISSION TO CIRCUMVENT SLOWNESS",DIE="^IBE(356.4,",DA=IBENT D ^DIE
 W "done."
 Q
