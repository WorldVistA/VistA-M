RMPRPAT5 ;PHX/RFM-DISPLAY/PRINT CRITICAL COMMENTS ;8/29/1994
 ;;3.0;PROSTHETICS;**20**;Feb 09, 1996
 I '$D(RMPRDFN) D GETPAT^RMPRUTIL
 W:$E(IOST)["C" @IOF I '$D(^RMPR(665,RMPRDFN,8,1,0)) W !,"PATIENT: ",$P(^DPT(RMPRDFN,0),U),?60,"CRITICAL COMMENTS",!!,"No Patient Critical Comments Recorded for this patient!",!! S RMPRCCO=1 G CRI
 W !,"PATIENT: ",$P(^DPT(RMPRDFN,0),U),?60,"CRITICAL COMMENTS",!!
 S RO=0 F  S RO=$O(^RMPR(665,RMPRDFN,8,RO)) Q:RO=""  D WRI
CRI S %=2 W !!,"Would you like to Add/Edit Patient Critical Comments" D YN^DICN W:%=0 !,"Enter `YES or `NO`" G CRI:%=0,EXIT^RMPRPAT:$D(DTOUT),EDIT:%=1 I %=2!(%=-1) W @IOF G ASK1^RMPRPAT
WRI W !,^RMPR(665,RMPRDFN,8,RO,0) Q
EDIT I $D(RMPRCCO) S DIE=665,DA=RMPRDFN,DR=30 D ^DIE G RMPRPAT5
 K DIC S DIC="^RMPR(665,RMPRDFN,8," D EN^DIWE G RMPRPAT5
 Q
DIS Q:'$D(RMPRDFN)  I $D(RMPRDD) K RMPRDD Q
 W $C(7),$C(7),!!,"Disability Code has not been entered for this Patient!  You must enter a"
 W !,"Prosthetic Disability Code to continue." D EN^RMPRDIS I '$D(^RMPR(665,RMPRDFN,1,0)) S RMPRKILL=1 Q
 I $D(^RMPR(665,RMPRDFN,1,0)),'$O(^(0)) S RMPRKILL=1 Q
DISP ;DISPLAY DISABILITY CODES
 Q:'$D(^RMPR(665,RMPRDFN,1,0))  I '$O(^(0)) Q
 W !!,"Current Disability Codes are: "
 W ! S RO=0 F I=1:1 S RO=$O(^RMPR(665,RMPRDFN,1,RO)) Q:RO'>0!($D(RMPRQ))  D WRI1
 Q
WRI1 I I>4 W !!,"*More Disability Codes on File, See Screen 1" S RMPRQ=1 Q
 I $D(^RMPR(662,$P(^RMPR(665,RMPRDFN,1,RO,0),U,1),0)) W !,$P(^(0),U,1) D
 .S J=$P(^RMPR(665,RMPRDFN,1,RO,0),U,4)
 .W ?15,$S(J=1:"SC VIETNAM",J=2:"ALL OTHER S/C",J=3:"NSC A&A",J=4:"OTHERS ELIG",J=5:"V.I.S.T.",J=6:"VOC REHAB",J=7:"PHC",J=8:"INPATIENT",J=9:"EMPLOYEE",J=10:"PRIMA FACIA",1:"UNK")
 .W ?30,$S($P(^RMPR(665,RMPRDFN,1,RO,0),U,3)=1:"S/C",$P(^(0),U,3)=2:"NSC",1:"UNK")
 .S J=$P(^RMPR(665,RMPRDFN,1,RO,0),U,5)
 .W ?36,$S(J=1:"PL-96-151",J=2:"PL-91-500",J=3:"PL-97-37",J=4:"PL-94-581",J=5:"HOUSEBOUND",J=6:"PL-91-102",J=7:"PL-91-666",J=8:"PL-104-262 (ELIG. REFORM",1:"")
 I $P(^RMPR(665,RMPRDFN,1,RO,0),U,10) W ?50,"Deleted..."
 Q
NPC ;CHECK ALL DISABILITY CODES MARKED DELETED
 K RA F RI=0:0 S RI=$O(^RMPR(665,RMPRDFN,1,RI)) Q:RI'>0  I $D(^(RI,0)) S RA=1 I '$P(^(0),U,10) K RA Q
 I $D(RA) W !!,$C(7),?5,"The Patient's Disability Codes have been Marked as Deleted.",!,?5,"No Purchasing may be done for this patient" S RMPRKILL=1 H 3
