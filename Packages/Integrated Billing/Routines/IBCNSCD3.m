IBCNSCD3 ;ALB/CPM - DELETE INSURANCE COMPANY (CON'T) ; 11-MAY-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**28,46**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ; 
MERGE ; Determine whether company information must be merged to another.
 ;  Required variable input:
 ;       IBCNS  --  Pointer to the company in file #36
 ;
 ;  Variable output:
 ;    IBCALLAR  --  Set to 1 if billing activity must be re-pointed
 ;    IBCALLIR  --  Set to 1 if Insurance reviews must be re-pointed
 ;       IBREP  --  Pointer to a company in file #36, or 0
 ;      IBREPN  --  May be set to an insurance company name
 ;      IBQUIT  --  Set to 1 if the user wants to quit the option
 ;
 N IBAR,IBMERGE,IBCNSRD,IBCNSRD1
 W !!,$TR($J("",80)," ","="),!
 S (IBCALLAR,IBCALLIR,IBMERGE,IBREP,IBQUIT)=0
 ;
 ; - check AR to see if the company is filed as a debtor
 S IBAR=+$$DEL^RCAMINS(IBCNS)
 I 'IBAR W !?3,">> This company is not established as a debtor in Accounts Receivable.",!
 I IBAR=1 W !?3,">> There is a debtor, but no bills, for this company in Accounts Receivable.",!
 I IBAR=2 S (IBCALLAR,IBMERGE)=1 W !?3,">> There is billing activity associated with this company!",!
 ;
 ; - see if there are Insurance Reviews for the company
 I $D(^IBT(356.2,"AIACT",IBCNS)) S (IBCALLIR,IBMERGE)=1 W !?3,">> There are known Insurance Reviews associated with this company.",!
 ;
 I 'IBMERGE W !,"** This company may be deleted from your system without merging. **" G MERGEQ
 ;
 ; - select another company to merge information into
 W !!,"You must merge the information from this company into another company!",!
 S IBCNSRD=$P($G(^DIC(36,IBCNS,0)),"^",16)
 I IBCNSRD,$G(^DIC(36,IBCNSRD,0))]"" S IBCNSRD=$G(^(0)),IBCNSRD1=$G(^(.11)) D
 .W !?2,"Please note that insurance policy and plan information was repointed to:"
 .W !?6,$P(IBCNSRD,"^"),"      (",$S($P(IBCNSRD,"^",5):"Ina",1:"A"),"ctive Company)"
 .I $P(IBCNSRD1,"^")]"" W !?6,$P(IBCNSRD1,"^")
 .I $P(IBCNSRD1,"^",2)]"" W !?6,$P(IBCNSRD1,"^",2)
 .I $P(IBCNSRD1,"^",3)]"" W !?6,$P(IBCNSRD1,"^",3)
 .I $P(IBCNSRD1,"^",4)]"" W !?6,$P(IBCNSRD1,"^",4),"  ",$P($G(^DIC(5,+$P(IBCNSRD1,"^",5),0)),"^",2),"   ",$E($P(IBCNSRD1,"^",6),1,5),$S($E($P(IBCNSRD1,"^",6),6,9)]"":"-"_$E($P(IBCNSRD1,"^",6),6,9),1:"")
 ;
 S DIC(0)="QEAMZ",DIC="^DIC(36,",DIC("A")="Select Company to Merge Information: ",DIC("S")="I +Y'=IBCNS,'$G(^(5))",DIC("W")="D ID^IBCNSCD3"
 W ! D ^DIC K DIC S IBREP=+Y I Y<0 S IBQUIT=1 W !!,"No 'merge' company selected!" G MERGEQ
 I IBCALLAR,$$DEL^RCAMINS(IBREP)<1 W !!,"This company is not established as a debtor in Accounts Receivable!",!,"It will be established as a debtor prior to merging the billing activity."
 S IBREPN=Y(0,0)
MERGEQ Q
 ;
 ;
INTRO ; Introductory text.
 W !!,"This action is designed to allow the deletion of Insurance companies"
 W !,"which meet one of the following criteria:"
 W !!," o The company was entered by error, and there is little or no insurance"
 W !,"   or billing activity associated with the company."
 W !!," o The company is really the same company as another entry in your file"
 W !,"   and you wish to merge all activity for the company to the other entry."
 W !!,"It is not necessary, nor desirable, to delete every company which is inactive."
 Q
 ;
WARN ; Describe how the delete/merge will work.
 W !!,$TR($J("",70)," ","*")
 W !,"There may be entries in various files which point to ",$P(IBCNSD,"^")
 W !,"which are not immediately obvious.  ",$S(IBREP:"Merg",1:"Delet"),"ing this company"
 W !,"will cause a background job to be queued later in the day which will"
 W !,"find all such entries and delete or merge these pointers as necessary."
 W !!,"You will receive a mail message from the system when this job is complete."
 W !,"Please note that there is a potential problem where pointers will be"
 W !,"deleted when there is no company into which the pointed fields may be"
 W !,"merged.  The mail message will indicate which records those are so they"
 W !,"may be reviewed.",!,$TR($J("",70)," ","*")
 Q
 ;
HLP ; Reader help for deleting companies
 I 'IBREP W !!,"If you wish to delete this company, enter 'YES.'  Otherwise, enter 'NO.'" Q
 W !!,"If you enter 'YES,' all information pertaining to ",$P(IBCNSD,"^")
 W !,"will be repointed to ",IBREPN,".  ",$P(IBCNSD,"^")
 W !,"will then be flagged for deletion from your system."
 W !!,"If you do not want this action to occur, enter 'NO.'"
 Q
 ;
ID ; Display the company identifer.
 N IB
 W:$D(^(.11)) "   ",$P(^(.11),U,1),"   ",$P(^(.11),U,4)
 S IB=Y,Y=$S('$D(^(.11)):"",$D(^DIC(5,+$P(^(.11),U,5),0))#2:$P(^(0),U,1),1:""),C=$P(^DD(5,.01,0),U,2) D Y^DIQ:Y]"" W "   ",Y,@("$E("_DIC_"IB,0),0)") S Y=IB
 W:$D(^(0)) "   ",$P(^(0),U,2)
 W "   (ien: ",+Y,")"
 Q
