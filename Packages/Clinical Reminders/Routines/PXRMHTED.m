PXRMHTED ;;BP/WAT - Edit VA-HT PERIODIC EVALUATION ;08/13/13  07:26
 ;;2.0;CLINICAL REMINDERS;**19**;Feb 04, 2005;Build 187
 ; 10026 ^DIR | 10018 ^DIE
 ;This routine runs the option PXRM DEFINITION FREQUENCY EDIT.  It permits a limited edit to the reminder frequency
 ;for the VA-HT PERIODIC EVALUATION reminder definition.  The function findings are also automatically updated with
 ;the new frequency value.
READ() ;reader call
 ;
 N DIR,X,Y
 K DIRUT
 S DIR(0)="F^^I X'=""90D""&(X'=""120D"")&(X'=""180D"")&(X'=""3M"")&(X'=""4M"")&(X'=""6M"") K X"
 S DIR("B")="180D"
 S DIR("A")="Enter a new REMINDER FREQUENCY"
 S DIR("A",1)=""
 S DIR("A",2)="The current frequency for this reminder definition is: "_$G(CURFREQ)
 S DIR("A",3)=""
 ;;
 S DIR("?")="90D (or 3M), 120D (or 4M), 180D (or 6M)"
 S DIR("?",1)="Choose one of the following frequencies for this reminder definition:"
 S DIR("?",2)=""
 D ^DIR K DIR
 I (Y="")!(Y="^") S DUOUT=1
 Q Y
EDIT ;edit call
 ;
 N DA,DIE,DR,CURFREQ,NEWFREQ,DTOUT,DUOUT,FNSTR
 S DA(1)=$O(^PXD(811.9,"B","VA-HT PERIODIC EVALUATION",""))
 S DA=$O(^PXD(811.9,DA(1),7,0))
 S CURFREQ=^PXD(811.9,DA(1),7,DA,0) ;force numeric to remove unit letter
 S NEWFREQ=$$READ^PXRMHTED
 S:CURFREQ="3M" CURFREQ=90 ;ensure frequency in Days & numeric for use in function string
 S:CURFREQ="4M" CURFREQ=120
 S:CURFREQ="6M" CURFREQ=180
 Q:$D(DUOUT)!$D(DTOUT)
 S DIE="^PXD(811.9,"_DA(1)_",7,"
 S DR=".01///^S X=NEWFREQ"
 D ^DIE
 S DA=0
 S:NEWFREQ="3M" NEWFREQ=90
 S:NEWFREQ="4M" NEWFREQ=120
 S:NEWFREQ="6M" NEWFREQ=180
 F  S DA=$O(^PXD(811.9,DA(1),25,DA)) Q:+DA=0  D
 .S FNSTR=^PXD(811.9,DA(1),25,DA,3) Q:$G(FNSTR)=""
 .S FNSTR=$$STRREP^PXRMUTIL(FNSTR,+CURFREQ,+NEWFREQ)
 .S DIE="^PXD(811.9,"_DA(1)_",25,"
 .S DR="3///^S X=FNSTR"
 .D ^DIE
 .S FNSTR=""
 W !!,"Done",!
 Q
 ;
