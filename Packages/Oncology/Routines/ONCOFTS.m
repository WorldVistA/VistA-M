ONCOFTS ;Hines OIFO/GWB - TUMOR STATUS/CANCER STATUS OF PRIMARY ;02/02/00
 ;;2.11;ONCOLOGY;**24,25,47**;Mar 07, 1995;Build 19
 ;
STSM ;CREATE TUMOR STATUS MULTIPLE IN 165.5
 ;called from "AE" cross-reference of DATE OF LAST CONTACT OR DEATH
 ;Sub-field (#.01) of FOLLOW-UP Field (#400) of ONCOLOGY PATIENT (#160)
 ;N VARIABLES
 ;X=CURRENT FOLLOWUP DATE
 ;DA=CURRENT FOLLOWUP MULTIPLE ENTRY
 ;TUMOR STATUS
 N MH,LC,K,XD1,XY,XDA1
 I '$D(^ONCO(165.5,"C",DA(1))) W:'$D(ZTQUEUED) !!,?5,"Patient ",DA(1)," has no Primaries - cannot track Tumor Status",! ;NO PRIMARIES
 E  D STSMSET ;Set the primaries
 Q
 ;
STSMSET ;Patient has primaries, so set
 N CURFOLDT,PRIMARY
 S CURFOLDT=X ;Current Follow-Up Date
 S PRIMARY=0
 F  S PRIMARY=$O(^ONCO(165.5,"C",DA(1),PRIMARY)) Q:PRIMARY=""  I $$DIV^ONCFUNC(PRIMARY)=DUZ(2) D
 .N DATEDX
 .S DATEDX=$P(^ONCO(165.5,PRIMARY,0),U,16)
 .I DATEDX="" W:'$D(ZTQUEUED) !,?5," Patient ",DA(1),":  DATE DX MISSING for "_$P(^ONCO(164.2,$P(^ONCO(165.5,PRIMARY,0),U),0),U),!?5," NO Tumor Status Followup Created",!!
 .E  I DATEDX'>CURFOLDT D STSMONE
 Q
 ;
STSMONE ;Look for a corresponding tumor status for this primary, set up if none there
 I '$D(^ONCO(165.5,PRIMARY,"TS","B",CURFOLDT)) D  ;not defined, set up
 .N TUMSTAT
 .L +^ONCO(165.5,PRIMARY,"TS")
 .S:'$D(^ONCO(165.5,PRIMARY,"TS",0)) ^(0)="^165.573DA" ;set header if undefined
 .F TUMSTAT=$P(^ONCO(165.5,PRIMARY,"TS",0),U,3)+1:1 Q:'$D(^(TUMSTAT))  ;get index
 .S ^ONCO(165.5,PRIMARY,"TS",TUMSTAT,0)=CURFOLDT ;set data
 .S ^ONCO(165.5,PRIMARY,"TS","B",CURFOLDT,TUMSTAT)="" ;date xref
 .S ^ONCO(165.5,PRIMARY,"TS","AA",9999999-CURFOLDT,TUMSTAT)="" ;inverted date xref
 .S $P(^ONCO(165.5,PRIMARY,"TS",0),U,3)=TUMSTAT,$P(^(0),U,4)=$P(^(0),U,4)+1 ;update header
 .L -^ONCO(165.5,PRIMARY,"TS")
 Q
 ;
KTSM ;Delete TUMOR STATUS Multiple (#73) in ONCOLOGY PRIMARY File (#165.5)
 ;corresponding to an entry in the FOLLOW-UP Multiple (#400) in ONCOLOGY PATIENT File (#160)
 ;Called by KILL Logic of AE Cross-reference of DATE OF LAST CONTACT OR DEATH Sub-field (#.01) of FOLLOW-UP Multiple
 ;Input DA(1) = internal entry number in ONCOLOGY PATIENT File
 ;          X = date of follow-up to be deleted
 N XD1
 S XD1=0 F  S XD1=$O(^ONCO(165.5,"C",DA(1),XD1)) Q:'XD1  I $$DIV^ONCFUNC(XD1)=DUZ(2) D KTSMA
 Q
KTSMA I $D(^ONCO(165.5,XD1,"TS","B",X)) D
 .N DIK,DR,DA
 .S DA=0
 .F  S DA=$O(^ONCO(165.5,XD1,"TS","B",X,DA)) Q:'DA  D KTSMONE ;kill
 Q
 ;
KTSMONE ;kill a single tumor status sub-record
 ;DEVELOPERS NOTE:  The code is written this way because FileMan blows
 ;up if you try to make a DIK call from within DIE.  Thus this code
 ;should always be modified if any changes are made to the TUMOR STATUS
 ;multiple Field (#73) in the ONCOLOGY PRIMARY File (#165.5).
 ;When FileMan gets his act together, this logic can be simplified
 ;to a DIK call.     MLH 4/14/93
 ;
 ;kill xrefs
 K ^ONCO(165.5,XD1,"TS","B",X,DA) ;kill date xref (.01,B)
 K ^ONCO(165.5,XD1,"TS","AA",9999999-X,DA) ;kill inverse date xref (.01,AA)
 D LTS^ONCOU55(XD1,DA) ;reset LAST TUMOR STATUS Field (#95) (.02,AC)
 K ^ONCO(165.5,XD1,"TS",DA) ;kill data
 S $P(^ONCO(165.5,XD1,"TS",0),U,4)=$P($G(^ONCO(165.5,XD1,"TS",0)),U,4)-1 ;decrement count on header
 Q
 ;
DX ;DATE OF LAST CONTACT OR DEATH (160.04,.01) Input Transform 
 ;At least one DATE DX (165.5,3) must precede DATE OF LAST CONTACT OR
 ;DEATH
 ;DATE OF LAST CONTACT OR DEATH must precede DATE@TIME OF DEATH (160,29)
 N ONCOF,XD1
 S ONCOF=0,XD1=0 F  S XD1=$O(^ONCO(165.5,"C",DA(1),XD1)) Q:XD1'>0  S DATEDXZ=$P(^ONCO(165.5,XD1,0),U,16) I (DATEDXZ'>X)!(DATEDXZ="0000000")!(DATEDXZ=8888888)!(DATEDXZ=9999999) S ONCOF=1 Q
 I 'ONCOF W !,"DATE DX must precede DATE OF LAST CONTACT OR DEATH",! K X
 E  D
 .N ONCDTD
 .S ONCDTD=$P($G(^ONCO(160,D0,1)),U,8)
 .I $E(ONCDTD,6,7)="00" Q
 .I ONCDTD,ONCDTD<X W !,"DATE OF LAST CONTACT OR DEATH must precede DATE@TIME OF DEATH" K X
 Q
