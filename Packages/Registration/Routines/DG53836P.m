DG53836P ;ALB/SCK - DG*5.3*836 POST INIT ; 
 ;;5.3;Registration;**836**;AUG 13,1993;Build 35
 ;
POST ;
 N DGPAR,DGERR
 ;
 Q:'XPDQUES("POS1")
 ;
 D BMES^XPDUTL("Updating Parameters File...")
 S DGPAR=XPDQUES("POS2","B")
 I DGPAR']"" D  Q
 . D BMES^XPDUTL("Nothing entered, exiting Parameter update.")
 ;
 D CHG^XPAR("PKG.REGISTRATION","DGPF SUICIDE FLAG",,DGPAR,.DGERR)
 I +$G(DGERR)>0 D  Q
 . D BMES^XPDUTL(DGERR)
 ;
 Q
 ;
UPD ; Programmer access point to manually change Parameter entry
 N DGPAR,DGERR,DIR,DIRUT,X,Y
 ;
 S DIR(0)="FAO^^"
 S DIR("A")="Local Flag: "
 S DIR("A",2)="are using as your Suicide Prevention flag."
 S DIR("A",1)="Enter the Local Patient Record flag that you"
 S DIR("?")="for your Suicide Prevention flag, this is a free text value."
 S DIR("?",1)="Answer with the Local Patient Record Flag that you are using"
 D ^DIR K DIR
 Q:$D(DIRUT)
 S DGPAR=$G(Y)
 ;
 D CHG^XPAR("PKG.REGISTRATION","DGPF SUICIDE FLAG",,DGPAR,.DGERR)
 I '+$G(DGERR) D
 . W !?3,"Parameter Defintion has been updated!"
 ;
 I +$G(DGERR)>0 D
 . W !?3,"An Error occurred:"
 . W !?3,$P($G(DGERR),U,2)
 Q
