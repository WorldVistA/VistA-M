RARTE2 ;HISC/SWM-Edit/Delete a Report ;7/16/01  14:05
 ;;5.0;Radiology/Nuclear Medicine;**10,31**;Mar 16, 1998
 ; known vars-->RADFN,RACNI,RADTI,RARPT,RARPTN
PTR ; if current ^RADPT() rec is a PRINT SET,
 ; then for other ^RADPT() recs of the same PRINT SET,
 ; create its corresponding subrec in ^RARPT()
 S RAXIT=0
 I '$D(RADFN)!'$D(RACNI)!'$D(RADTI)!'$D(RARPT)!'$D(RARPTN) D  Q
 . S RAXIT=1 Q:$G(RARIC)
 . I '$D(RAQUIET) W !!,$C(7),"Missing data (routine RARTE2)",! S RAOUT=$$EOS^RAUTL5() Q
 . S RAERR="Missing data needed by routine RARTE2"
 . Q
 N RA1,RA2,RA3,RAFDA,RAIEN,RAMSG ;RA3=exam status
 S RA1=0
PTR2 S RA1=$O(^RADPT(RADFN,"DT",RADTI,"P","B",RA1)) Q:RA1=""  S RA2=$O(^(RA1,0)),RA3=$P(^RADPT(RADFN,"DT",RADTI,"P",RA2,0),"^",3) G:$P(^(0),"^",25)'=2 PTR2 ;skip non-combined rpt
 G:RA2=RACNI PTR2 ;skip already processed case
 K RAFDA,RAIEN,RAMSG
ASK G:$G(RARIC) UPD G:$D(RAQUIET) UPD ; don't ask, if from Img pkg or Kurzweil
 I $P(^RA(72,+RA3,0),"^",3)=0 D  G:%=2 PTR2 G:%'=1 ASK
 . W !!,"Case ",RA1," of this print set has been cancelled."
 . W !,"Do you want to include it in the report anyway"
 . S %=2 D YN^DICN
 . W:%>0 "...",$S(%=2:"Ex",%=1:"In",1:""),"clude case ",RA1
 . Q
 ; update file #70, field REPORT TEXT
UPD S $P(^RADPT(RADFN,"DT",RADTI,"P",RA2,0),U,17)=RARPT
 D INSERT
 Q:RAXIT  G PTR2
INSERT ; add subrec to file #74's subfile #74.05
 S RAFDA(74.05,"?+2,"_RARPT_",",.01)=$P(RARPTN,"-")_"-"_RA1
 D UPDATE^DIE("","RAFDA","RAIEN","RAMSG")
 I $D(RAMSG) D  Q
 . S RAXIT=1 Q:$G(RARIC)
 . I '$D(RAQUIET) W !!,$C(7),"Error encountered while setting sub-records (routine RARTE2)",! S RAOUT=$$EOS^RAUTL5() Q  ;error detected
 . S RAERR="Error encountered while setting sub-recs from RARTE2"
 Q
DEL17(RAIEN) ;del other print set members' pointer to #74
 Q:'$D(RADFN)!('$D(RADTI))
 N RA4,RA1 D EN3^RAUTL20(.RA4)
 Q:'$O(RA4(0))
 S RA1=""
D18 S RA1=$O(RA4(RA1)) Q:RA1=""
 ; kill xrefs, if any, for file #70's REPORT TEXT
 S DA(2)=RADFN,DA(1)=RADTI,DA=RA1
 ; if this exam's piece 17 doesn't match RAIEN, then don't remove pc17
 I $P($G(^RADPT(RADFN,"DT",RADTI,"P",RA1,0)),"^",17)'=RAIEN G D18
 D ENKILL^RAXREF(70.03,17,RAIEN,.DA)
 ; set REPORT TEXT to null
 S:$D(^RADPT(RADFN,"DT",RADTI,"P",RA1,0)) $P(^(0),"^",17)=""
 G D18
COPY ;copy physicians and diagnoses
 Q:'$D(RADFN)!('$D(RADTI))!('$D(RACNI))!('$D(RAMEMARR))!('$D(RADRS))
 W !!,"... now copying ",$S(RADRS=1:"Diagnostic Codes",1:"Staff & Resident data")," to other cases in this print set ...",!
 N RA1,RA2,RA3
 N RA1PR,RA1PS ;prim res/staff
 N RA1SR,RA1SS ; sec res/staff arrays--(ien subfile #70.11)=ien file #200
 N RA1PD,RA1SD ; prim diag, then sec diags array
 N RAFDA,RAIEN,RAMSG
 ;prim res, prim staff, prim diag
 S RA1=^RADPT(RADFN,"DT",RADTI,"P",RACNI,0) S:RADRS=2 RA1PR=$P(RA1,"^",12),RA1PS=$P(RA1,"^",15) S:RADRS=1 RA1PD=$P(RA1,"^",13)
 ;sec residents
 I RADRS=2,$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SRR",0)) S RA1=0 F  S RA1=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SRR",RA1)) Q:+RA1'=RA1  S RA1SR(RA1)=+^(RA1,0)
 ;sec staff
 I RADRS=2,$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SSR",0)) S RA1=0 F  S RA1=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SSR",RA1)) Q:+RA1'=RA1  S RA1SS(RA1)=+^(RA1,0)
 ;sec diagnoses
 I RADRS=1,$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX",0)) S RA1=0 F  S RA1=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX",RA1)) Q:+RA1'=RA1  S RA1SD(RA1)=+^(RA1,0)
 ;loop thru other cases of this printset
 S RA1=0
COPYLOOP S RA1=$O(RAMEMARR(RA1)) G:RA1="" COPYREF G:RA1=RACNI COPYLOOP ;skip what's done already
 ;
 ; copy primary staff and resident via Fileman
 I RADRS=2 D
 . S DA(2)=RADFN,DA(1)=RADTI,DA=RA1
 . S DIE="^RADPT("_DA(2)_",""DT"","_DA(1)_",""P"","
 . S DR="12////"_RA1PR_";15////"_RA1PS
 . D ^DIE K DA,DIE,DR ; no locking
 . Q
 ;
 ; copy primary diagnostic code via Fileman
 I RADRS=1 D
 . S DA(2)=RADFN,DA(1)=RADTI,DA=RA1
 . S DIE="^RADPT("_DA(2)_",""DT"","_DA(1)_",""P"","
 . S DR="13////"_RA1PD
 . D ^DIE K DA,DIE,DR ; no locking
 . Q
 ;
 S RA2=RA1_","_RADTI_","_RADFN ;stem for dataserver call
 S DA(3)=RADFN,DA(2)=RADTI,DA(1)=RA1 ;base vars for DIK call
 I RADRS=2 S RA3=0 D KIL3 G:RAXIT Q ; sec res
 I RADRS=2 S RA3=0 D KIL4 G:RAXIT Q ; sec staff
 I RADRS=1 S RA3=0 D KIL5 G:RAXIT Q ; sec diag
 G COPYLOOP
KIL3 S RA3=$O(^RADPT(RADFN,"DT",RADTI,"P",RA1,"SRR",RA3)) G:RA3="" COPY3
 S DA=RA3
 S DIK="^RADPT("_DA(3)_",""DT"","_DA(2)_",""P"","_DA(1)_",""SRR"","
 D ^DIK
 G KIL3
COPY3 K RAFDA,RAIEN,RAMSG S RA3=$O(RA1SR(RA3)) Q:'RA3  Q:RAXIT
UP3 ;
 S RAFDA(70.09,"?+2,"_RA2_",",.01)=RA1SR(RA3)
 D UPDATE^DIE("","RAFDA","RAIEN","RAMSG") G:'$D(RAMSG) COPY3
 S RAXIT=1 W !!,$C(7),"Error encountered while in adding rec ",RA3," to sub-file 70.09" Q
KIL4 S RA3=$O(^RADPT(RADFN,"DT",RADTI,"P",RA1,"SSR",RA3)) G:RA3="" COPY4
 S DA=RA3
 S DIK="^RADPT("_DA(3)_",""DT"","_DA(2)_",""P"","_DA(1)_",""SSR"","
 D ^DIK
 G KIL4
COPY4 K RAFDA,RAIEN,RAMSG S RA3=$O(RA1SS(RA3)) Q:'RA3  Q:RAXIT
UP4 ;
 S RAFDA(70.11,"?+2,"_RA2_",",.01)=RA1SS(RA3)
 D UPDATE^DIE("","RAFDA","RAIEN","RAMSG") G:'$D(RAMSG) COPY4
 S RAXIT=1 W !!,$C(7),"Error encountered while in adding rec ",RA3," to sub-file 70.11" Q
KIL5 S RA3=$O(^RADPT(RADFN,"DT",RADTI,"P",RA1,"DX",RA3)) G:RA3="" COPY5
 S DA=RA3
 S DIK="^RADPT("_DA(3)_",""DT"","_DA(2)_",""P"","_DA(1)_",""DX"","
 D ^DIK
 G KIL5
COPY5 K RAFDA,RAIEN,RAMSG S RA3=$O(RA1SD(RA3)) Q:'RA3  Q:RAXIT
UP5 ;
 S RAFDA(70.14,"?+2,"_RA2_",",.01)=RA1SD(RA3)
 D UPDATE^DIE("","RAFDA","RAIEN","RAMSG") G:'$D(RAMSG) COPY5
 S RAXIT=1 W !!,$C(7),"Error encountered while in adding rec ",RA3," to sub-file 70.14" Q
COPYREF ; clear out Fileman vars and quit
 K DA,DIK
 Q  ; don't need to re-xref again
Q K DA Q
