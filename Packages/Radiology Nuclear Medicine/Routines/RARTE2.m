RARTE2 ;HISC/SWM,GJC-Edit/Delete a Report ;07 Nov 2018 1:30 PM
 ;;5.0;Radiology/Nuclear Medicine;**10,31,47,124**;Mar 16, 1998;Build 4
 ; known vars-->RADFN,RACNI,RADTI,RARPT,RARPTN
 ;
 ;Routine              IA          Type
 ;-------------------------------------
 ; ^DIR               10026        (S)
 ; APPERROR^%ZTER     1621         (S)
 ;
PTR ; if the current study is the master study for
 ; the print set the accession of the master study
 ; is the .01 value of the master pset report record.
 ; All secondary studies will have their accession
 ; numbers filed in the OTHER CASE# multiple under
 ; that master pset report record. 
 ;
 ;RARPTN: the value of the .01 field of our master pset
 ;        report record (accession #)
 ;
 S RAXIT=0
 I '$D(RADFN)!'$D(RACNI)!'$D(RADTI)!'$D(RARPT)!'$D(RARPTN) D  Q
 . S RAXIT=1 Q:$G(RARIC)
 . I '$D(RAQUIET) W !!,$C(7),"Missing data (routine RARTE2)",! S RAOUT=$$EOS^RAUTL5() Q
 . S RAERR="Missing data needed by routine RARTE2"
 . Q
 ;
PTR2 ;find descendent, if part of the pset build accession #, if descendent canceled
 ;set flag on array.
 ;from RAHLO1: RARPTN=RALONGCN
 ;
 N RAO1,RA1ARY,RACCSTR
 ;RAO1    - study IEN (think RACNI)
 ;RACCSTR - front end of the accession (excludes case #) in this part
 ;          of the code (changes to full accession # in PTR3)
 ;RA1ARY  - this will be the array where our accession #s are stored
 ;          RA1ARY(RAO1,accession #)=""
 ;
 S RACCSTR=$P(RARPTN,"-",1,($L(RARPTN,"-")-1)) ;Ex: 141-040618 -or- 040618
 ;
 ;save off the accession # stored in the .01 field of the report
 ;we do not want this accession # set in the OTHER CASE# multiple
 S RA1ARY(0,RARPTN)=""
 ;
 S RAO1=0 K RAOX
 F  S RAO1=$O(^RADPT(RADFN,"DT",RADTI,"P",RAO1)) Q:'RAO1  D
 .S RAO1(0)=$G(^RADPT(RADFN,"DT",RADTI,"P",RAO1,0))
 .;get the order # of the exam status for this study RAOX(3)
 .S RAOX(3)=$P(^RA(72,+$P(RAO1(0),U,3),0),U,3)
 .I $$SILENT()=1,RAOX(3)=0 Q:$$ASK()'=1
 .;set the report pointer for the study in question
 .S $P(^RADPT(RADFN,"DT",RADTI,"P",RAO1,0),U,17)=RARPT
 .;build the accession number: +RAO1(0) = case number
 .S RAOX=RACCSTR_"-"_+RAO1(0)
 .I $P(RAO1(0),U,25)=2,('$D(RA1ARY(0,RAOX))#2) S RA1ARY(RAO1,RAOX)=""
 .Q
 K RAOX
 ;
PTR3 ; -RAO1: reused for $O subscript (think RACNI)
 ;     -RACCSTR: now represents the full accession #
 ;               Ex: 141-040618-12345 -or- 040618-12345
 ;     -RARPT: record # of RIS report in file #74
 ;
 S RAO1=0 F  S RAO1=$O(RA1ARY(RAO1)) Q:'RAO1  D
 .S RACCSTR=$O(RA1ARY(RAO1,"")) ;accession #
 .; do not file this accession # into the
 .; OTHER CASE# (#4.5) multiple if it already exists
 .; *** Milwaukee RIS issue: .01 overwritten & duplicate
 .; accessions in OTHER CASE# mult (124 T1) ***
 .D:($D(^RARPT("B",RACCSTR,RARPT))=0) INSERT
 .Q
 ;
 ;note: * I $G(RARIC) REPORT TEXT (70.03;17) is set in routine RARIC
 ;      * I $D(RAQUIET) REPORT TEXT is set in routine RAHLO1
 ;      * through the backdoor, REPORT TEXT is set in tag^routine(s):
 ;        - LOCK^RARTE4
 ;        - LOCK^RARTE5
 ;       
 ;      + noted b/c there was a hard set of the REPORT TEXT field in this code prior
 ;        to RA*5.0*124.
 Q
 ;
INSERT ; add subrec to file #74's subfile #74.05
 N RAFDA,RAIEN,RAMSG
 S RAIEN="?+1,"_RARPT_",",RAFDA(74.05,RAIEN,.01)=RACCSTR
 D UPDATE^DIE("","RAFDA","RAIEN","RAMSG")
 I $D(RAMSG) D  Q
 . S RAXIT=1 Q:$G(RARIC)
 . I '$D(RAQUIET) W !!,$C(7),"Error encountered while setting sub-records (routine RARTE2)",! S RAOUT=$$EOS^RAUTL5() Q  ;error detected
 . S RAERR="Error encountered while setting sub-recs from RARTE2"
 Q
 ;
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
 ;
SILENT() ;ask to include canceled cases if interactive
 ;RARIC: set in CREATE^RARIC
 ;RAQUIET: set in the RIS' HL7 bridge routine
 Q:$G(RARIC)!($D(RAQUIET)) 0
 Q 1
 ;
ASK() ;include canceled case in report?
 N DIRUT,DUOUT,DTOUT,DIR,X,Y,RAX
 S DIR(0)="Y",DIR("B")="No"
 S DIR("A",1)="Case "_+$P(RAO1(0),U)_" on this printset has been canceled."
 S DIR("A")="Do you want to include it in the report anyway" D ^DIR
 I $D(DIRUT) S Y=-1
 S RAX=$S(Y=1:"In",1:"Ex")_"clude case "_+$P(RAO1(0),U)
 W !!,RAX
 Q Y ;'1' for yes, '0' for no
 ;
