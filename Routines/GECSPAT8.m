GECSPAT8 ;WIRMFO/SAB-ADD DATA FOR FIXED ASSETS CODE SHEETS ;25 Apr 96
 ;;2.0;GEC;**8**;MAR 14, 1995
 N GECDOM,GECFDA,GECIEN,GECWP
 S GECDOM="Q-FAM.VA.GOV"
 ;S GECDOM="Q-FMD.VA.GOV" ; for test sites of patch EN*7*29
 I '$$FIND1^DIC(4.2,"","X",GECDOM,"B") D  Q
 . W $C(7),!,"Domain ",GECDOM," not found. No action taken."
 . W !,"   MailMan patch XM*DBA*92 must be installed prior to running"
 . W !,"   routine GECSPAT8. The MailMan patch establishes domain "
 . W !,"   ",GECDOM," which is required by this routine. Please rerun"
 . W !,"   this routine (D ^GECSPAT8) after installing patch XM*DBA*92."
 W !!,"Updating GENERIC CODE SHEET BATCH TYPE (#2101.1)..."
 K GECFDA,GECIEN,GECWP
 S GECWP(1,0)="This batch type contains the required information for"
 S GECWP(2,0)="Fixed Assets transmissions."
 S GECFDA(2101.1,"?+1,",.01)="FIXED ASSETS"
 S GECFDA(2101.1,"?+1,",.5)="GECWP"
 S GECFDA(2101.1,"?+1,",3)="FMS"
 S GECFDA(2101.12,"?+2,?+1,",.01)="XXX"
 S GECFDA(2101.12,"?+2,?+1,",1)=GECDOM
 S GECFDA(2101.12,"?+2,?+1,",2)="YES"
 D UPDATE^DIE("E","GECFDA","GECIEN"),MSG^DIALOG()
 W !!,"Updating GENERIC CODE SHEET TRANSACTION TYPE/SEGMENT (#2101.2)..."
 K GECFDA,GECIEN,GECWP
 S GECFDA(2101.2,"?+1,",.01)="FA:FMS"
 S GECFDA(2101.2,"?+1,",.7)="FIXED ASSETS"
 S GECFDA(2101.2,"?+1,",1)="YES"
 S GECFDA(2101.2,"?+1,",2)="FIXED ASSETS ACQUISITION"
 S GECFDA(2101.2,"?+2,",.01)="FB:FMS"
 S GECFDA(2101.2,"?+2,",.7)="FIXED ASSETS"
 S GECFDA(2101.2,"?+2,",1)="YES"
 S GECFDA(2101.2,"?+2,",2)="FIXED ASSETS BETTERMENT"
 S GECFDA(2101.2,"?+3,",.01)="FC:FMS"
 S GECFDA(2101.2,"?+3,",.7)="FIXED ASSETS"
 S GECFDA(2101.2,"?+3,",1)="YES"
 S GECFDA(2101.2,"?+3,",2)="FIXED ASSETS CHANGE"
 S GECFDA(2101.2,"?+4,",.01)="FD:FMS"
 S GECFDA(2101.2,"?+4,",.7)="FIXED ASSETS"
 S GECFDA(2101.2,"?+4,",1)="YES"
 S GECFDA(2101.2,"?+4,",2)="FIXED ASSETS DISPOSITION"
 S GECFDA(2101.2,"?+5,",.01)="FR:FMS"
 S GECFDA(2101.2,"?+5,",.7)="FIXED ASSETS"
 S GECFDA(2101.2,"?+5,",1)="YES"
 S GECFDA(2101.2,"?+5,",2)="FIXED ASSETS TRANSFER"
 D UPDATE^DIE("E","GECFDA","GECIEN") D MSG^DIALOG()
 W !!,"Process completed. Routine GECSPAT8 can be deleted now."
 Q
 ;GECSPAT8
