ONCOENA ;WISC/MLH-ONCOLOGY INSTALL-ENVIRONMENT CHECK HELPER
 ;;2.11;ONCOLOGY;;Mar 07, 1995
 ;
 ;  8/12/94 MLH ADDED this routine to bring ONCOENV into
 ;              compliance with SACC limit of 5000 bytes
 ;
QNORSTG ;    does user want to proceed w/o restaging?
 W !!,"No restaging will be performed.",!
 I 'OFST D  ;    on non-virgin install, make sure they want to skip restaging
 .  N DIR,Y
 .  S DIR("A")="Proceed with initialization",DIR(0)="Y"
 .  S DIR("?",1)="If you enter Y here, initialization will proceed without restaging."
 .  S DIR("?",2)=" "
 .  S DIR("?",3)="If you enter N here, initialization will cease.  You may D ^ONCOINIT"
 .  S DIR("?",4)="to restart initialization at any time.",DIR("?")=" "
 .  D ^DIR
 .  I 'Y K DIFQ W !!,"Initialization aborted.",!!
 .  Q
 ;END IF
 ;
 Q
