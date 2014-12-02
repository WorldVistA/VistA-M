RMPOPED1 ;EDS/MDB,DDW,RVD - HOME OXYGEN MISC FILE EDITS CONT. ;7/24/98
 ;;3.0;PROSTHETICS;**168**;Feb 09, 1996;Build 43
 ;
RMPRWARN(RMPRICD,RMPRACS,RMPODFN,ITEM,RMPRCONT) ;
 ; Display Inactive ICD code warning.
 W !!,"This item contains the ICD Diagnosis Code: ",RMPRICD," which was inactive based"
 W !,"on the start date of the currently selected prescription."
 W !!,"You may 1) select a different item with no ICD code or with an active ICD code,"
 W !,"        2) enter a new item or "
 W !,"        3) proceed with this item.  If you proceed with this item, the existing"
 W !,"           ICD Diagnosis code ",RMPRICD," will be DELETED."
 W !!,"You may then enter an active ICD-",RMPRACS," Diagnosis code or you may leave"
 W !,"the ICD Diagnosis field blank."
 ; Prompt user to continue or not
 S RMPRCONT=$$CONTINUE()
 ; User does want to continue so delete ICD code from currently selected Item
 I RMPRCONT=1 D DLTITEM(RMPODFN,ITEM) Q
 ; User doesn't want to continue
 S ITEM=""
 Q
 ;
CONTINUE() ;
 ; prompt user to continue w/ current Item after warning was issued
 N DIR
 S DIR("A")="Do you wish to continue? ",DIR(0)="YA"
 W !
 D ^DIR
 W !
 I $D(DTOUT)!($D(DUOUT))!($D(DIROUT)) Q -1
 ; User quits - back to Item Prompt
 I Y<1 Q -1
 Q 1
 ;
DLTITEM(RMPODFN,ITEM) ;
 ; Delete Inactive ICD code from Item 
 S DA(1)=RMPODFN,DA=ITEM
 S DIE="^RMPR(665,"_DA(1)_",""RMPOC"","
 S DR="7///@"
 D ^DIE
 Q
 Q
 ; End of RMPOPED1
