SDWLAPI ;;IOFO BAY PINES/TEH - WAIT LIST API;06/12/2002 ; 20 Aug 2002  2:10 PM
 ;;5.3;scheduling;**263**;AUG 13 1993
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
ASK1 ;Prompt for putting Patient on Waiting List
 ;
 ;Check Wait List file for Patient on Wait List.
 ;
 S Y=0,DIR(0)="YA0^^" S DIR("A")="Do you want to place this Patient on a Waiting List? No // "
 D ^DIR K DIR("A"),DIR(0)
 I 'Y!(Y="")!($D(DUOUT))
 D NEW^SDWLE(DFN)  ;-Call Wait List Enter/Edit Module.
 Q
ASK2 ;If appointment is made and the Patient is on the Waiting List for the Clinic/Specialty prompt
 S DIR(0)="YAO^^"
 S DIR("A",1)="This Patient is currently on the Waiting List for this Clinic/Specialty."
 S DIR("A")="Do you wish to remove from List Yes // "
 D ^DIR K DIR("A"),DIR(0)
 I 'Y D
 .S DIE="^SDWL(409.3",DA=SDWLDA,DR="18Reason for Not Dispositioning: "
 D EDIT^SDWLDISP
END Q
