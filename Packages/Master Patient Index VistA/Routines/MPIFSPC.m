MPIFSPC ;SLC/ARS-MASTER PATIENT INDEX SYSTEM CHECK SUM RTN ;SEP 4, 1996
 ;;1.0; MASTER PATIENT INDEX VISTA ;**48**;30 Apr 99;Build 6
 ;MPICHECK
CHECKDG(NUM) ;Check Digit Calculation
 ;change to local array of MPI global.
 ;D EXIN **48 CHANGE TO FUNCTION CALL
 ;K I,J,LTH,MPID,MPIMAP,MPIT,TAB,VAL
 N TMP
 S TMP=$$EXIN(NUM)
 Q TMP
READ ;
 ;
EXIN(NUM) ;**48 MADE THIS A FUNCTION CALL
 N SUM,I,J,LTH,MPID,MPIMAP,MPIT,TAB,VAL
 I $L(NUM)'=16 D
 .; W !,"I WILL PAD TO 16!"
 .S LTH=($L(NUM)+1) F I=LTH:1:16 S NUM="0"_NUM
 F MPIT=1:1:6  D
 .; For each check digit, compute a value
 .F MPID=1:1:16  D
 ..S MPIMAP(MPIT,0,"MAP")=0
 ..S MPIMAP(MPIT,MPID)=$E(NUM,MPID),VAL=MPIMAP(MPIT,MPID)
 ..S SUM=(MPIMAP(MPIT,MPID)+(MPIMAP(MPIT,MPID-1,"MAP")))#10
 ..S MPIMAP(MPIT,MPID,"MAP")=$P($P(^MPIF(984.5,MPIT,SUM),"^",2),";",MPID)
 .S TAB(MPIT)=MPIMAP(MPIT,16,"MAP")
 .;Q
 S SUM=""
 F J=1:1:6  D
 .S SUM=SUM_TAB(J)
 Q SUM
 ;
 ;Before calculation of check digits the number must be
 ;expanded to sixteen digits by padding zeros to the
 ;left of the number.
