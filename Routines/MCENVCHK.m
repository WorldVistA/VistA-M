MCENVCHK ;WISC/DCB-ENVIROMENT CHECK ROUTINE ;11/16/93
 ;;2.3;Medicine;;09/13/1996
START ;This routine checks to see if the MCINSTALL routine was used
 Q:$G(MCSTART)="OKTOGO"
 W !,"You need to enter D ^MCARINS to install Medicine."
 K DIFQ
 Q
