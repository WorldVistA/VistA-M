RAREG1 ;HISC/CAH,FPT,DAD AISC/MJK,RMO-Register Patient ;16 Jan 2018 10:02 AM
 ;;5.0;Radiology/Nuclear Medicine;**7,21,93,137**;Mar 16, 1998;Build 4
 ; 07/15/2008 BAY/KAM rem call 249750 RA*5*93 Correct DIK Calls
ASKORD I $D(RAVSTFLG),$G(YY)]"",$P(YY,U,5) D ASET G PACS
 ; radparfl = 1 if user chose detail-to-parent conversion
 ; radparpr = ien of file 74 of parent proc to replace detail proc
 K RADPARPR,RADPARFL
 S RAOLP=0,RAOVSTS="3;5;8" W ! D ^RAORDS G Q1:$D(RAOUT) G EXAM:$D(RAORDS)
 S RARD("A")="Do you want to Request an Exam for "_RANME_"? ",RARD(0)="S",RARD(1)="Yes^enter a request.",RARD(2)="No^not enter a request.",RARD("B")=2 D SET^RARD K RARD G Q1:$E(X)'="Y"
 W !!?3,"...requesting an exam for ",RANME,"...",! D ^RAORD1
EXAM ;
 ; block mixture of single proc with parent procedures
 N RA6,RA7,RA8 S RA6="",RA7=0,RA8=0
 F  S RA6=$O(RAORDS(RA6)) Q:'RA6  S:$P($G(^RAMIS(71,$P(^RAO(75.1,+RAORDS(RA6),0),U,2),0)),U,6)="P" RA7=1 S:$P($G(^RAMIS(71,$P(^RAO(75.1,+RAORDS(RA6),0),U,2),0)),U,6)'="P" RA8=1
 I RA7,RA8 W !!?7,$C(7),"You may not register a mixture of single and parent procedures.",! G Q1
 ;
 I $G(RADPARFL) D  G:Y<1 Q1 ; process detail-to-parent
 . D PSETPNT^RAREG4
 . Q
 S RAPARENT=+$P($G(^RADPT(RADFN,"DT",RADTI,0)),U,5)
 K ^TMP($J,"RAREG1") S (RAEXIT,RAQUIT,RASKIPIT,RACNICNT)=0
 D RSBIT^RAREG3
 F RAOLP=1:1 S RAOIFN=$G(RAORDS(RAOLP)) Q:'RAOIFN!RAEXIT!RAQUIT  D
 . D PROCESS^RAREG4
 . Q
 I RAEXIT,RAPARENT D EXAMDEL^RAREG2
 I $D(^TMP($J,"RAREG1")) D UOSM^RAREG2
PACS I $D(^TMP($J,"RAREG1")) S RACNT=0 F  S RACNT=$O(^TMP($J,"RAREG1",RACNT)) Q:'RACNT  D
 .S RAREGTMP=$G(^TMP($J,"RAREG1",RACNT)),RADFN=$P(RAREGTMP,U,1),RADTI=$P(RAREGTMP,U,2),RACNI=$P(RAREGTMP,U,3)
 .D REG^RAHLRPC
 .Q
 K RAREGTMP
 D:$D(RADPARFL) CKDUPORD^RAREG2 ; ck for dupl procs in outstndg orders
Q I '$D(RAREC) W !!?3,$C(7),"No exams entered for this visit. Must delete..." S DA(1)=RADFN,DA=RADTI,DIK="^RADPT("_DA(1)_",""DT""," D ^DIK W "...deletion complete!" K RAPX
 D PRNRQ^RAREG3 ;print request when exam is registered - P137 /KLM
 D LABEL^RAREG3
Q1 D Q4^RAREG4
 G PAT^RAREG
 ;
 ;CN entry point is called every time a new case number is assigned.
 ;The next available CN and last date CN's were "recycled" is stored in
 ;^RA(79.2,1,"CN")=Next availabe CN ^ date last recycled.
 ;This routine uses the next available CN unless it has been used for
 ;the same exam date before (DUP checks for duplicate case/date pair).
 ;Then the next available CN is calculated and written to the first
 ;piece of ^RA(79.2,1,"CN").  The node is locked during this transaction.
CN ;VARIABLES RATYPE,RADT AND RASET MUST EXIST AT THIS POINT
 ; 11/05/2008 BAY/KAM rem call 273496 RA*5*93 Add lock timeout to next line
 L +^RA(79.2,RATYPE,"CN"):$S($G(DILOCKTM)>0:DILOCKTM,1:3) D CAL:'$D(^RA(79.2,RATYPE,"CN")),CAL:DT>$P(^("CN"),"^",2),CAL:+^("CN")>99999 S RAX=+^RA(79.2,RATYPE,"CN") D DUP
 ; need recalculate if DUP returns an over 99999 value
 I RAX>99999 D CAL S RAX=+^RA(79.2,RATYPE,"CN") D DUP
 I 'RASET S X=RAX G CNQ
 I $D(X),X'="N",X'=RAX W !!,$C(7),"New case number must be equal to '",RAX,"'. OK? YES// " R RANS:DTIME K X I RANS["N"!(RANS["n")!('$T) G CNQ
 S X=RAX
 ; get next available short case number for future registration
 ; re-set "CN" node if future short case number >99999
 ; NOTE1: find and store next free case number for future use 091300
 F RAJ=(^RA(79.2,RATYPE,"CN")+1):1 I '$D(^RADPT("AE",RAJ)) S ^("CN")=RAJ_"^"_$P(^RA(79.2,RATYPE,"CN"),"^",2) Q
 ; if the next free case no. for future use is >99999, need recalculate
 I +^RA(79.2,RATYPE,"CN")>99999 D CAL
CNQ L -^RA(79.2,RATYPE,"CN")
 I $D(X),X>99999 W !!?3,$C(7),"You have reached the maximum limit for case numbers (99,999).",!?3,"You must first complete/purge your old exams before you can proceed." K X
 K RAJ,RATYPE,RASET,RAX,RANS,RADT Q
DUP ;Check to prevent use of same case number/date pair ;ch
 ; both short and long case numbers will be checked for duplicates 091500
 S RADTE99=$S('$D(RADTE):"",1:$E(RADTE,4,5)_$E(RADTE,6,7)_$E(RADTE,2,3))
 I '$D(^RADPT("AE",RAX)),'$D(^RADPT("ADC",RADTE99_"-"_RAX)) G DUPQ
 ; also check ADC xref while searching for next available number 08/15/00
 ; note2: even though the current available case number is being
 ;        stored, the next free case number for future use will be
 ;        found and stored later, see note1 above     091300
 F RAJ=(^RA(79.2,RATYPE,"CN")+1):1 I '$D(^RADPT("AE",RAJ)),'$D(^RADPT("ADC",RADTE99_"-"_RAJ)) S ^("CN")=RAJ_"^"_$P(^RA(79.2,RATYPE,"CN"),"^",2) S RAX=+^RA(79.2,RATYPE,"CN") Q
DUPQ K RADTE99 Q
 ;
 ; the CAL section is called if :
 ;       there isn't a ^RA(79.2,RATYPE,"CN")
 ;   or  today's date is after the date in ^RA(79.2,RATYPE,"CN") piece 2
 ;   or  ^RA(79.2,RATYPE,"CN") piece 1 is > 99999, this is
 ;       checked in two places :
 ;         before using this piece 1 as the next case number
 ;         and after calculating future free case number
 ;   or  DUP section returns a case number > 99999
 ; 
 ; the first calculation starts from today's date and finds the date
 ; for the next Saturday
 ;      %Y=day of week, 6 being Saturday
 ;
 ; the second calculation starts from ^RADPT("AE",1 and finds the
 ; lowest  n  where  ^RADPT("AE",n) doesn't exist anymore.
 ;
 ; then the results are used to replace ^RA(79.2,RATYPE,"CN")
 ;     where
 ;       piece  1  is the next free case number
 ;       piece  2  is the date for next Saturday
 ;       RATYPE is always  1   by design
 ;
CAL K RAXX S:$D(X) RAXX=X S RAX=DT F RAII=0:0 S X1=RAX,X2=1 D C^%DTC S RAX=X D H^%DTC Q:%Y=6
 D YMD^%DTC F RAJ=1:1 I '$D(^RADPT("AE",RAJ)) S ^RA(79.2,RATYPE,"CN")=RAJ_"^"_X S:$D(RAXX) X=RAXX Q
 K RAJ,RAXX,RAX,RAII Q
PROC(Y) Q $P($G(^RAMIS(71,+Y,0)),U)
ASET ; register extra cases for a exam/print set that has no VALID report yet
 ; there may be a stub report from imaging for this set
 S RAREC="" ; prevent Q  from deleting the exam at "DT" level
 S (RAEXIT,RAQUIT,RASKIPIT,RACNICNT)=0 K ^TMP($J,"RAREG1")
 N RAFIRST S RAFIRST=$O(^RADPT(RADFN,"DT",RADTI,"P",0)) Q:'RAFIRST
 S RAOIFN=$P(^RADPT(RADFN,"DT",RADTI,"P",RAFIRST,0),"^",11) ;imagg order ien
 N DIR
PS1 S DIR(0)="Y",DIR("A")="For "_RANME_"'s exam set -- register another descendent exam (Y/N)"
 W ! D ^DIR Q:'Y
 N RAPARENT S RAPARENT=1 D ORDER^RAREG2 ;preserve EXAM SET stored data
 Q:RAQUIT  ;6/18/96
 K RAPRC S RAPARENT=1 D EXAMLOOP^RAREG2 ;prevent undef RAPROC in EXAMLOOP
 ; RACNI is set by edit tmpl that's used in EXAMLOOP^RAREG2
 ; quit if registration was incomplete <-- rareg2 deleted entire case
 Q:'$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 S RAPROC=$P($G(^RAO(75.1,+$G(RAOIFN),0)),U,2) ;ien of parent procedure
 ; set value of MEMBER OF SET
 ;    can't call memset^rareg2 to set MEMBER OF SET, due possiblity of
 ;    orig. proc being a single procedure that got converted to printset
 N RA25 S RA25=$P($G(^RADPT(RADFN,"DT",RADTI,"P",RAFIRST,0)),U,25)
 I RA25 N D,D0,DA,DI,DIC,DIE,DQ,DR,X,Y S DA(2)=RADFN,DA(1)=RADTI,DA=RACNI,DR="25///"_RA25,DIE="^RADPT("_RADFN_",""DT"","_RADTI_",""P""," D ^DIE
 G:RA25'=2 PS1
 ; combined report need more processing
 G:'$G(RA17) PS1 G:'$D(^RARPT(+$G(RA17),0))#2 PS1
 ; since there's a stub rpt from imaging (RA17), set piece 17
 D SET17^RAREG2(RADFN,RADTI,RACNI)
 ; copy over any dx/res/staff
 D COPYFROM^RAREG2(RACNI)
 ; insert rec in 74.05
 N RARPT,RARPTN,RA1,RAFDA,RAIEN,RAMSG,RAERR,RAXIT
 S RARPT=RA17,RARPTN=$P(^RARPT(RARPT,0),U),RA1=$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),U)
 D:RA1 INSERT^RARTE2
 G PS1
