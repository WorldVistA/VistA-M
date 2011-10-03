MCPREDUP ;WISC/JAH-MEDICINE PACKAGE PRE INIT TO RUN DUPLICATE CLEAN UP ;5/2/96  13:54
 ;;2.3;Medicine;;09/13/1996
 ;this routine checks to see if the user wants to run the duplicate
 ;clean up routines (MCDUP*) and displays some help.
 N MCCLEAN
 W @IOF
 S DIR(0)="Y"
 S DIR("A",1)="There may be duplicate entries in the Medicine Package's static files. "
 S DIR("A",2)="Answer 'YES' to check for duplicates and clean duplicates up."
 S DIR("A",4)="    This process will check the medicine static files for"
 S DIR("A",5)="duplicate entries.  If duplicates exist you will be asked"
 S DIR("A",6)="if you want to clean them up.  It is recommended that you"
 S DIR("A",7)="answer YES and run this section of the post-inits.  Please"
 S DIR("A",8)="be ready to respond to prompts."
 S DIR("A",9)="    If you answer NO the installation WILL complete."
 S DIR("A",10)="However, duplicate entries may remain in the static files."
 S DIR("A",11)="You may run the duplicates clean up routines at any time"
 S DIR("A",12)="by running the routine MCPREDUP.  Simply type D ^MCPREDUP at"
 S DIR("A",13)="the programmers prompt."
 S DIR("A",14)="    This process may take a considerable amount of time,"
 S DIR("A",15)="depending especially on the extent of duplicates at your site."
 S DIR("A")="Would you like to check them"
 S DIR("B")="Y"
 D ^DIR
 S MCCLEAN=Y K DIR,Y
 D:MCCLEAN=1 ^MCDUPE
 K MCCLEAN
 Q
