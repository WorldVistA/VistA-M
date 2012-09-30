SROFILE ;BIR/MAM - EDIT SITE CONFIGURABLE FILES ;06/08/2011
 ;;3.0;Surgery;**48,41,88,100,175,176**;24 Jun 93;Build 8
START S SRO(1)="Surgery Transportation Devices^131.01",SRO(2)="Prosthesis^131.9",SRO(3)="Surgery Position^132",SRO(4)="Restraints and Positioning Aids^132.05",SRO(5)="Surgical Delay^132.4"
 S SRO(6)="Monitors^133.4",SRO(7)="Irrigations^133.6",SRO(8)="Surgery Replacement Fluids^133.7",SRO(9)="Skin Prep Agents^135.1"
 S SRO(10)="Skin Integrity^135.2",SRO(11)="Patient Mood^135.3",SRO(12)="Patient Consciousness^135.4",SRO(13)="Local Surgical Specialty^137.45",SRO(14)="Electroground Positions^138",SRO(15)="Surgery Disposition^131.6"
 S SRLINE="" F I=1:1:80 S SRLINE=SRLINE_"="
DISPLAY W @IOF,!,SRLINE,!,?20,"Update Site Configurable Surgery Files",!,SRLINE
 W !,"1.  Surgery Transportation Devices",!,"2.  Prosthesis",!,"3.  Surgery Positions",!,"4.  Restraints and Positional Aids"
 W !,"5.  Surgical Delay",!,"6.  Monitors",!,"7.  Irrigations",!,"8.  Surgery Replacement Fluids",!,"9.  Skin Prep Agents",!,"10. Skin Integrity",!,"11. Patient Mood"
 W !,"12. Patient Consciousness",!,"13. Local Surgical Specialty",!,"14. Electroground Positions",!,"15. Surgery Dispositions",!,SRLINE
ASK W ! K DIR S DIR("?",1)="Enter the number corresponding to the file that you want to update. For",DIR("?",2)="example, enter ""8"" to enter, edit, or delete information contained in"
 S DIR("?",3)="the Surgery Replacement Fluids file.",DIR("?",4)="",DIR("?",5)="NOTE:  File entries you do not want to use should be made inactive and",DIR("?")="should NOT be deleted."
 S DIR("A")="Update Information for which File ? ",DIR(0)="NOA^1:15" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'Y S SRSOUT=1 G END
 S SRFILE=Y
 S SRFNM=$P(SRO(SRFILE),"^"),SRFNUM=$P(SRO(SRFILE),"^",2) K SRO
 W @IOF,!,"Update Information in the "_SRFNM_" file.",!,SRLINE
ENTRY W !! K DIC S (DLAYGO,DIC)=SRFNUM,DIC(0)="QEAMZL",SRF=SRFNUM
 S SRP=3 I SRF=132!(SRF=135) S SRP=4
 I SRF=132.05!(SRF=132.4)!(SRF=133.4)!(SRF=133.7) S SRP=2
 I SRF=131.9 S SRP=6
 S DIC("W")="I $P(^(0),""^"",SRP) W ""         ** INACTIVE **"""
 D ^DIC N SRHL,SRHLAD,SRHLIEN S:Y>0&((SRFILE=6)!(SRFILE=8)) SRHLIEN=+Y,SRHL=^SRO(SRF,SRHLIEN,0),SRHLAD=$P(Y,U,3) K DLAYGO I Y<0 G START
 K DR S DIE=SRFNUM,DA=+Y S:SRFILE=2 DR=".01;1;2;5;6;7;8;9;10" S:SRFILE'=2 DR=".01:9999" D ^DIE D:(SRFILE=6)!(SRFILE=8) SRHL K DR,DIE,DA G ENTRY
 G START
END W @IOF D ^SRSKILL
 Q
SRHL ;HL7 master file update
 N SRENT,SRHLST,SRTBL,FEC,REC
 S FEC="UPD",SRTBL=$S(SRFILE=6:"MONITOR",SRFILE=8:"REPLACEMENT FLUID")_U_SRF_U_".01"
 S SRENT=SRHLIEN_U_^SRO(SRF,SRHLIEN,0),SRHLST=$S(SRHLAD=1:"Addition",SRHL'=SRENT:"Updating",1:"") I $G(SRHLST)'="" D
 .I $P(SRHL,U,2)="",'$P(SRHL,U,3),$P(SRENT,U,3)=1 S REC="MDC"
 .I $P(SRHL,U,2)=1,'$P(SRHL,U,3),$P(SRENT,U,3)="" S REC="MAC"
 .I $G(SRHLAD)=1 S REC="MAD"
 .D:$D(REC) MSG^SRHLMFN(SRTBL,FEC,REC,SRENT)
 .I $G(SRHLAD)=1,$P(SRENT,U,2)=1 S REC="MDC" D MSG^SRHLMFN(SRTBL,FEC,REC,SRENT)
 K SRHLIEN,SRHL,SRHLAD
 Q
