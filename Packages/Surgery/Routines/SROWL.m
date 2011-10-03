SROWL ;B'HAM ISC/MAM - ENTER PATIENT ON WAITING LIST ; 4/18/07 11:55am
 ;;3.0;Surgery;**58,119,162**;24 Jun 93;Build 4
 ;
ENTER ; enter a patient on the waiting list
 S SRSOUT=0 W @IOF K DIC S DIC(0)="QEAMZL",(DIC,DLAYGO)=133.8,DIC("A")="  Select Surgical Specialty: " D ^DIC K DIC,DLAYGO G:Y<0 END S SRSS=+Y,SRSS1=+Y(0)
 S SRSSNM=$P(^SRO(137.45,SRSS1,0),"^")
PAT W ! S DIC=2,DIC(0)="QEAMZ",DIC("A")="  Select Patient: " D ^DIC K DIC I Y<0 W !!,"No action taken." G END
 S DFN=+Y,SRNM=$P(Y(0),"^") I $D(^DPT(DFN,.35)),$P(^(.35),"^")'="" S Y=$E($P(^(.35),"^"),1,7) D D^DIQ W !!,"The records show that "_SRNM_" died on "_Y_".",! G PAT
 I $O(^SRO(133.8,"AP",DFN,SRSS,0)) D CHK G:"Yy"'[ECYN END
OP W ! K DIR S DIR("A")="  Select Operative Procedure",DIR(0)="133.801,1" D ^DIR I $D(DTOUT)!$D(DUOUT) W !!,"No action taken." G END
 S SROPER=Y
 W ! D NOW^%DTC S SRSDT=%
 K DD,DO,DIC,DR,DA S DIC(0)="L",DIC="^SRO(133.8,SRSS,1,",DA(1)=SRSS,X=DFN D FILE^DICN I +Y S SROFN=+Y
 K DA,DIE,DR S DA=SRSS,DIE=133.8,DR="1///"_SRNM,DR(2,133.801)="1////"_SROPER_";2///"_SRSDT_";4T;W !;5T;6T;W !;3T",DR(3,133.8013)=".01T;1T;2T;3T;4T;5T" D ^DIE K DIE,DR
 D WL^SROPCE1 I SRSOUT G DEL
 W @IOF,!,SRNM_" has been entered on the waiting list",!,"for "_SRSSNM
END D PRESS,^SRSKILL W @IOF
 Q
PRESS W ! K DIR S DIR("A")="Press RETURN to continue  ",DIR(0)="FOA" D ^DIR K DIR
 Q
DEL S DA(1)=SRSS,DA=SROFN,DIK="^SRO(133.8,"_DA(1)_",1," D ^DIK
 W @IOF,!,"Classification information is incomplete.  No action taken." G END
 Q
HELP W !!,"Enter RETURN if you want to continue entering a new procedure on the waiting",!,"list for "_SRNM_".  If the procedure you are about to enter appears",!,"above, enter 'NO' to quit this option."
 W !!,"Press RETURN to continue  " R X:DTIME
 Q
CHK ; check for existing entries for a patient
 W @IOF,!,"Procedure(s) already entered for "_SRNM,!,"on the Waiting List for "_SRSSNM,!
 S SROFN=0 F  S SROFN=$O(^SRO(133.8,"AP",DFN,SRSS,SROFN)) Q:'SROFN  D LIST
 W !!,"Do you wish to continue entering a new procedure for "_SRNM_" on",!,"the waiting list for "_SRSSNM_" ?  YES// " R ECYN:DTIME I '$T!(ECYN["^") S ECYN="N" Q
 S ECYN=$E(ECYN) S:"y"[ECYN ECYN="Y"
 I "YNn"'[ECYN D HELP G CHK
 Q
LIST ; list existing procedures for specialty selected
 S SROPER=$P(^SRO(133.8,SRSS,1,SROFN,0),"^",2),SRDT=$P(^(0),"^",3),SROPDT=$P(^(0),"^",5),Y=SRDT D D^DIQ S SRDT=$E(Y,1,12) I SROPDT S Y=SROPDT D D^DIQ S SROPDT=$E(Y,1,12)
 K SROP,MM,MMM S:$L(SROPER)<36 SROP(1)=SROPER I $L(SROPER)>35 S SROPER=SROPER_"  " S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !,SRNM,?40,"Date Entered on List:",?66,SRDT,!,?3,SROP(1),?40,"Tentative Operation Date: ",?66,SROPDT
 I $D(SROP(2)) W !,?3,SROP(2)
 W !
 Q
LOOP ; break procedure if greater than 36 characters
 S SROP(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROP(M))+$L(MM)'<36  S SROP(M)=SROP(M)_MM_" ",SROPER=MMM
 Q
REFPHY   ; Look up Referring Physician in "New Person" file with filter and auto-populate Referring Physician demographic fields
 N SRCONT,Y,SRDEMO
 S SRCONT=""
PRMPT R !,"Is this a VA Physician from this facility?  (Y/N): <Y> ",SRCONT:DTIME I '$T Q
 I SRCONT["?" D  G PRMPT
 .W !!,"Enter 'Y' if you would like to select the Referring Physician from this facility's VA personnel.",!,"Enter 'N' to continue data entry.",!
 S:SRCONT="" SRCONT="Y"
 I SRCONT="^" S X="" Q
 Q:(SRCONT'["Y")&(SRCONT'["y")
 ; Store FileMan variables and arrays
 M SRDABAK=DA,SRDICBAK=DIC,SRDZERO=D0,SRDRBAK=DR,SRXBAK=X,SRDOBAK=DO
 ; Setup variables and call ^DIC to lookup REFERRING PHYSICIAN from NEW PERSON file
 S DIC="^VA(200,",DIC(0)="E",DIC("B")=X
 D ^DIC
 ; Restore FileMan's variables and arrays
 M DA=SRDABAK,DIC=SRDICBAK,D0=SRDZERO,DR=SRDRBAK,X=SRXBAK,DO=SRDOBAK
 K SRCONT,SRDABAK,SRDICBAK,SRDZERO,SRDRBAK,SRXBAK,SRDOBAK
 Q:Y="-1"        ; Quit if no record was selected from the NEW PERSON file
 S SRNPREC=$P(Y,U,1)_","   ;The record number of the NEW PERSON file
 ; Retrieve demographic data from the NEW PERSON file.
 D GETS^DIQ(200,SRNPREC,".01:.116;.132","","SRDEMO")
 ; Build SRDEMO array for "stuffing" into REFERRING PHYSICIAN demographic fields
 S X=SRDEMO(200,SRNPREC,".01")                       ;Name
 S SRDEMO(1)=SRDEMO(200,SRNPREC,".111")        ;Address
 S:$L(SRDEMO(200,SRNPREC,".112"))>0 SRDEMO(1)=SRDEMO(1)_" "_SRDEMO(200,SRNPREC,".112")   ;Concatenate Address 2 to single address
 S:$L(SRDEMO(200,SRNPREC,".113"))>0 SRDEMO(1)=SRDEMO(1)_" "_SRDEMO(200,SRNPREC,".113")   ;Concatenate Address 3 to single address
 S SRDEMO(1)=$E(SRDEMO(1),1,75)
 S SRDEMO(2)=SRDEMO(200,SRNPREC,".114")        ;City
 S SRDEMO(3)=SRDEMO(200,SRNPREC,".115")        ;State
 S SRDEMO(4)=SRDEMO(200,SRNPREC,".116")        ;Zip
 S SRDEMO(5)=SRDEMO(200,SRNPREC,".132")        ;Office Phone
 ; Set up DR array that FileMan will use, with a call to ^DIE, after this subroutine Quits to "stuff" the demographic data.
 ; all fields except STATE will ignore input transform (SR*3.0*162)
 S DIC("DR")="1////"_SRDEMO(1)_";2////"_SRDEMO(2)_";3///"_SRDEMO(3)_";4////"_SRDEMO(4)_";5////"_SRDEMO(5)_";6////"_$P(Y,U,1)
 S DIC(0)="Z"    ;Tells FileMan to file the data without any more user input
 Q
