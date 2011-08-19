ECTDIR ;B'ham ISC/PTD-Direct Call to an External Routine ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;**2,14**;
 ;VARIABLE 'ECT1' MUST BE DEFINED - IT IDENTIFIES INFORMATION ABOUT THE EXTERNAL ROUTINE TO BE CALLED
 G:'$D(ECT1) EXIT I ECT1="NUR" D NURSV I $D(XQUIT) W *7,!,"Unable to determine version of NURSING operating on your system." G EXIT
VRFY S INFO=$P($T(@ECT1),";;",2),GLRT=$P(INFO,"~"),GREF=$P(INFO,"~",2),FNAM=$P(INFO,"~",3),FNUM=$P(INFO,"~",4),RTN=$P(INFO,"~",5)
 I '$D(@GLRT) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"The '"_FNAM_"' File -",!,"file number "_FNUM_" is not loaded on your system.",!! S XQUIT="" G EXIT
 I '$O(@GREF) W *7,!!,"'"_FNAM_"' File -",!,"file number "_FNUM_" has not been populated on your system.",!! S XQUIT="" G EXIT
 S X=$P(RTN,"^",2) X ^%ZOSF("TEST") I $T=0 W *7,!!,RTN," routine does not exist on your system!" G EXIT
 K %ZIS S IOP="HOME" D ^%ZIS K %ZIS,IOP W @IOF,!!
CALL ;DIRECT CALL TO EXTERNAL ROUTINE
 D @RTN
EXIT K %,%T,%X,%Y,B,C,DA,DD,DFN,DIE,DIC,ECT1,ENHI,ENLO,ENTEMP,ENTNX,FNAM,FNUM,GLRT,GREF,INFO,J,K,N,P,PKGDA,POP,R,RTN,VA,VER,X,X1,XY,Y,Z3
 Q
 ;
NURSV ;DETERMINE VERSION OF NURSING PACKAGE
 S PKGDA=$O(^DIC(9.4,"C","NURS",0)) I 'PKGDA S XQUIT="" Q
 S:$D(^DIC(9.4,PKGDA,"VERSION")) VER=+(^("VERSION")) I '$D(VER) S XQUIT="" Q
 S ECT1=$S(VER>2:"NUR2",1:"NUR1")
 Q
 ;
XTRNL ;DATA FOR EXTERNAL ROUTINE CALLS
UD ;;^PS(57.6)~^PS(57.6,0)~Unit Dose Pick List Stats~57.6~^PSGAMS
UDP ;;^PS(57.6)~^PS(57.6,0)~Unit Dose Pick List Stats~57.6~^PSGPRVR
UDS ;;^PS(57.6)~^PS(57.6,0)~Unit Dose Pick List Stats~57.6~^PSGSCT
NUR1 ;;^NURSF(213.1)~^NURSF(213.1,0)~Nurs AMIS 1106 Class~213.1~EN1^NURSAWL0
NUR2 ;;^NURSA(213.1)~^NURSA(213.1,0)~Nurs AMIS 1106 Class~213.1~EN1^NURSAWL0
DENT ;;^DENT(221)~^DENT(221,0)~Dental Treatment (AMIS)~221~^DENTP1
CONS ;;^ENG("PROJ")~^ENG("PROJ",0)~Construction Project~6925~SINGLE^ENPRP
SPACE ;;^ENG("SP")~^ENG("SP",0)~Eng Space~6928~ENT^ENSP2
EQT ;;^ENG(6914)~^ENG(6914,0)~Equipment Inv.~6914~DS^ENEQ1
