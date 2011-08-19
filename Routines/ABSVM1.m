ABSVM1 ;OAKLANDFO/DPC - VSS MIGRATION;10/9/2002
 ;;4.0;VOLUNTARY TIMEKEEPING;**31,33**;JUL 1994
SEND ;
 ;Entry point for the Send Data option
 N ABSRECIP,ABSSDA,ABSIEN
 N DIR,Y
 W @IOF
 D ABSIEN^ABSVMUT1 Q:'ABSIEN
 W "You are about to send VTK data to the new VSS application."
 W !!,"DO NOT RUN THIS OPTION UNTIL DIRECTED BY SYSTEM IMPLEMENTATION."
 ;W !!,"VTK OPTIONS MUST BE OUT OF SERVICE BEFORE RUNNING THIS OPTION."
 ;
 S DIR(0)="Y"
 S DIR("A")="Do you want to proceed"
 S DIR("??")="If you answer NO, you can migrate the data later."
 D ^DIR
 I 'Y W !!,"Data migration can be done later.  Bye." Q
 ;
 N DIR,OUT
 S OUT=0
 W !
 F  Q:OUT  D
 . S DIR(0)="FAO"
 . S DIR("A")="Enter a Recipient Address for the Migrated Data: "
 . S DIR("?")="See the Install Instructions for the recipients e-mail address."
 . S DIR("?",1)="Network e-mail addresses must contain '@'."
 . D ^DIR
 . I $G(DIRUT) S OUT=1 Q
 . S ABSRECIP(X)=""
 . Q
 I '$D(ABSRECIP) W !!,"Migrate the VTK data when you have obtained the proper e-mail address.  Bye." Q
 W !
 ;
 D SENDPROC^ABSVMS1(.ABSRECIP,.ABSSDA)
 W !!,"Data is being sent."
 ;
 W !!
 S DIR(0)="Y"
 S DIR("A")="Do you want to print the error lists now"
 S DIR("??")="If you answer NO, you can print the errors later."
 D ^DIR
 I Y D PRINTRES^ABSVM(.ABSSDA,ABSIEN)
 ;
 W !!,"You will be notified when the data has been received and filed."
 W !,"Your office may then begin to use the new system."
 W !!,?20,"ENJOY THE NEW VOLUNTARY SERVICE SYSTEM"
 Q
 ;
