ONCPREMR ;HIRMFO/RTK-PRE-INSTALL ROUTINE CONTINUED ONC*2.11*13  09/10/97
 ;;2.11;ONCOLOGY;**13**;Mar 07, 1995
 ;
 ; Loop thru ICDO MORPHOLOGY (#164.1) file and find any duplicate entries
 ; of 9710/2 & 9710/3.  Convert any pointers that point to these entries
 ; and then delete the duplicates entries.
 ;
 W !!,"Checking for any duplicates in ICDO MORHOLOGY (#164.1) file..."
 S MRBAD=""
 F MR=0:0 S MR=$O(^ONCO(164.1,"B","MARGINAL ZONE LYMPHOMA, NOS IN",MR)) Q:MR'>0  I MR'=97102 S MRBAD=MRBAD_MR_"^"
 F MR=0:0 S MR=$O(^ONCO(164.1,"B","MARGINAL ZONE LYMPHOMA, NOS",MR)) Q:MR'>0  I MR'=97103 S MRBAD=MRBAD_MR_"^"
 I MRBAD="" G CHANGE ;if theres no duplicates, skip the conversion stuff
 ;
 ; Convert field #22 of file #165.5
 ;
 S CT=0
 W !?4,"Converting file #165.5 pointers..."
 F PRIEN=0:0 S PRIEN=$O(^ONCO(165.5,PRIEN)) Q:PRIEN'>0  D
 .S CT=CT+1 I CT#100=0 W "."
 .I '$D(^ONCO(165.5,PRIEN,2)) Q
 .S HIST=$P($G(^ONCO(165.5,PRIEN,2)),"^",3) I HIST="" Q
 .I MRBAD[HIST D
 ..I $P($G(^ONCO(164.1,HIST,0)),"^",2)="9710/2" S $P(^ONCO(165.5,PRIEN,2),"^",3)=97102 Q
 ..I $P($G(^ONCO(164.1,HIST,0)),"^",2)="9710/3" S $P(^ONCO(165.5,PRIEN,2),"^",3)=97103 Q
 ..W !,"CANNOT CONVERT POINTER IN ENTRY NUMBER: ",PRIEN Q
 .Q
 ;
 ; Convert field #64 of file #160
 ;
 S CT=0
 W !?4,"Converting file #160 pointers..."
 F PTIEN=0:0 S PTIEN=$O(^ONCO(160,PTIEN)) Q:PTIEN'>0  D
 .S CT=CT+1 I CT#100=0 W "."
 .I '$D(^ONCO(160,PTIEN,2)) Q
 .S MORPH=$P($G(^ONCO(160,PTIEN,2)),"^",10) I MORPH="" Q
 .I MRBAD[MORPH D
 ..I $P($G(^ONCO(164.1,MORPH,0)),"^",2)="9710/2" S $P(^ONCO(160,PTIEN,2),"^",10)=97102 Q
 ..I $P($G(^ONCO(164.1,MORPH,0)),"^",2)="9710/3" S $P(^ONCO(160,PTIEN,2),"^",10)=97103 Q
 ..W !,"CANNOT CONVERT POINTER IN ENTRY NUMBER: ",PTIEN Q
 .Q
 ;
 ; Convert field #70 of file #169.1
 ;
 S CT=0
 W !?4,"Converting file #169.1 pointers..."
 F ICDIEN=0:0 S ICDIEN=$O(^ONCO(169.1,ICDIEN)) Q:ICDIEN'>0  D
 .S CT=CT+1 I CT#100=0 W "."
 .I '$D(^ONCO(169.1,ICDIEN,0)) Q
 .S MRPH1=$P($G(^ONCO(169.1,ICDIEN,0)),"^",5) I MRPH1="" Q
 .I MRBAD[MRPH1 D
 ..I $P($G(^ONCO(164.1,MRPH1,0)),"^",2)="9710/2" S $P(^ONCO(169.1,ICDIEN,0),"^",5)=97102 Q
 ..I $P($G(^ONCO(164.1,MRPH1,0)),"^",2)="9710/3" S $P(^ONCO(169.1,ICDIEN,0),"^",5)=97103 Q
 ..W !,"CANNOT CONVERT POINTER IN ENTRY NUMBER: ",ICDIEN Q
 .Q
 ;
 ; Convert field #30 of file #164.1 (points to itself)
 ;
 S CT=0
 W !?4,"Converting file #164.1 pointers..."
 F MRIEN=0:0 S MRIEN=$O(^ONCO(164.1,MRIEN)) Q:MRIEN'>0  D
 .S CT=CT+1 I CT#100=0 W "."
 .I '$D(^ONCO(164.1,MRIEN,0)) Q
 .S TNCODE=$P($G(^ONCO(164.1,MRIEN,0)),"^",4) I TNCODE="" Q
 .I MRBAD[TNCODE D
 ..I $P($G(^ONCO(164.1,TNCODE,0)),"^",2)="9710/2" S $P(^ONCO(164.1,MRIEN,0),"^",4)=97102 Q
 ..I $P($G(^ONCO(164.1,TNCODE,0)),"^",2)="9710/3" S $P(^ONCO(164.1,MRIEN,0),"^",4)=97103 Q
 ..W !,"CANNOT CONVERT POINTER IN ENTRY NUMBER: ",MRIEN Q
 .Q
 ;
 ; Convert sub-field #.01 of field #20 (multiple) of file #164.2
 ;
 S CT=0
 W !?4,"Converting file #164.2 pointers..."
 F STIEN=0:0 S STIEN=$O(^ONCO(164.2,STIEN)) Q:STIEN'>0  D
 .S CT=CT+1 I CT#100=0 W "."
 .I '$D(^ONCO(164.2,STIEN,"M",0)) Q
 .F STMULT=0:0 S STMULT=$O(^ONCO(164.2,STIEN,"M",STMULT)) Q:STMULT'>0  D
 ..S STMORP=$P($G(^ONCO(164.2,STIEN,"M",STMULT,0)),"^",1) I STMORP="" Q
 ..I MRBAD[STMORP D
 ...I $P($G(^ONCO(164.1,STMORP,0)),"^",2)="9710/2" S $P(^ONCO(164.2,STIEN,"M",STMULT,0),"^",1)=97102 Q
 ...I $P($G(^ONCO(164.1,STMORP,0)),"^",2)="9710/3" S $P(^ONCO(164.2,STIEN,"M",STMULT,0),"^",1)=97103 Q
 ...W !,"CANNOT CONVERT POINTER IN ENTRY NUMBER: ",STIEN,"  SUBFIELD   ",STMULT Q
 ..Q
 .Q
 ;
 ; Delete the duplicates of MARGINAL ZONE LYMPHOMA, NOS & NOS IN SITU
 ;
 S NUM=0 F  S NUM=NUM+1,MRDA=$P(MRBAD,"^",NUM) Q:MRDA=""  D
 .S DIK="^ONCO(164.1,",DA=MRDA D ^DIK
 .Q
 ;
CHANGE ; Correct NAME (#.01) field of entries #97102,#97103 in 164.1 file
 ; and correct CODE (#1) field of entry #86221 in 164.1 file
 ;
 S DR=".01///MARGINAL ZONE LYMPHOMA, NOS IN SITU",DIE="^ONCO(164.1,",DA=97102 D ^DIE
 S DR=".01///MARGINAL ZONE LYMPHOMA, NOS",DIE="^ONCO(164.1,",DA=97103 D ^DIE
 S DR="1////8622/1",DIE="^ONCO(164.1,",DA=86221 D ^DIE
 ;
 K CT,HIST,ICDIEN,MORPH,MR,MRBAD,MRDA,MRIEN,MRPH1,NUM,PRIEN,PTIEN
 K STIEN,STMORP,STMULT,TNCODE
 Q
