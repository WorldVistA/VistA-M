LR175P ;DALISC/SED - LR*5.2*175 PATCH POST INIT ROUTINE ; 5/1/98
 ;;5.2;LAB SERVICE;**175**;Sep 27, 1994
EN ; Updates for file 69.5 that will not work with KIDS
 ;First enter the protocal from file 101 and enter it into 69.5
REMOVE ;
 ;
 S DA=$O(^DIC(19,"B","LREPI (EPI) MANUAL RUN",0))
 ;
 I $G(DA)>0 S DIK="^DIC(19," D ^DIK S MSG="Removing Manual Run Option"
 E  S MSG="Manual Run Option not found, must be a testing site..."
 D BMES^XPDUTL(MSG)
 K MSG,DIK,DA
 ;
 ;
 ;
 S LRPROT=0
 S LRPROT=$O(^ORD(101,"B","LREPI",0))
 I +LRPROT>0 D
 .;ADD ADDITIONAL INFO FOR EPI.
 .S LRPATH=0 F  S LRPATH=$O(^LAB(69.5,LRPATH)) Q:+LRPATH'>0  D
 ..W !,LRPATH
 ..Q:$P($G(^LAB(69.5,LRPATH,0)),U,7)'=LRPROT
 ..S $P(^LAB(69.5,LRPATH,0),U,3)=15 ;-->LAG TIME ENTRY
 S LRPROT=0
 S LRPROT=$O(^ORD(101,"B","LRNCH",0))
 I +LRPROT>0 D
 .K DD
 .S DIC="^LAB(69.4,",DIC(0)="L",(DINUM,X)=LRPROT,DLAYGO=69.4
 .D FILE^DICN K DA,DO,DD,DIC
 .S MSG="Adding Protocal '"_$P(^ORD(101,LRPROT,0),U,1)_"' to the "
 .S MSG=MSG_"LAB SEARCH/EXTRACT File (69.5)"
 .D BMES^XPDUTL(MSG) K MSG
 .S $P(^LAB(69.4,LRPROT,0),U,3)="32000"
 .S $P(^LAB(69.4,LRPROT,0),U,5)="National Center for Health Promotion"
 .;  Add cholesterol and pap
 .  D KLIK
 .;  NOW ADD THE INFO TO FILE 69.5
 .;
 .S LRPATH=$O(^LAB(69.5,"B","NCH CHOLESTEROL",0))
 .I +LRPATH'>0 D BMES^XPDUTL("Unable to add a NCH to the LAB SEARCH/EXTRACT File (69.5)") Q
 .S $P(^LAB(69.5,LRPATH,0),U,7)=LRPROT,$P(^LAB(69.5,LRPATH,0),U,9)=50
 . ;-->Enter Lag time, cycle and PTF
 . D FILL
 .S LRPATH=$O(^LAB(69.5,"B","NCH PAP SMEAR",0))
 .I +LRPATH'>0 D BMES^XPDUTL("Unable to add a NCH to the LAB SEARCH/EXTRACT File (69.5)") Q
 .S $P(^LAB(69.5,LRPATH,0),U,7)=LRPROT,$P(^LAB(69.5,LRPATH,0),U,9)=51
 . ;-->Enter Lag time, cycle and PTF
 . D FILL
 S LRPROT=$O(^ORD(101,"B","LREPI",0))
 I +LRPROT>0 D
 .Q:'$D(^LAB(69.4,LRPROT,0))
 .S $P(^LAB(69.4,LRPROT,0),U,5)="Emerging Pathogens Initiative (EPI)"
 .S $P(^LAB(69.4,LRPROT,0),U,4)=1
 ;
SITE ;ENTER PRIMARY SITE NUMBER TO HL7 APLICATION
 S LA7VS=$$PRIM^VASITE(DT) I $G(LA7VS)'="" D
 .S LA7VS=$$SITE^VASITE(DT,LA7VS)
 .S PRIMARY=$P(LA7VS,U,3)
 .Q:+PRIMARY'>0
 .S LRAPP=$O(^HL(771,"B","NCH-LAB",0))
 .Q:+LRAPP'>0
 .Q:'$D(^HL(771,LRAPP,0))
 .S $P(^HL(771,LRAPP,0),U,3)=PRIMARY
EXIT K LRPATH,INT,X,Y,DIC,DD,LRPROT
 Q
 ;
KLIK ;
CHK ;
 ;  ARE THEY THERE?
 S LRPATH=$O(^LAB(69.5,"B","NCH CHOLESTEROL",0)) Q:+LRPATH>0
 S LRPATH=$O(^LAB(69.5,"B","NCH PAP SMEAR",0)) Q:+LRPATH>0
 ;
 F X="NCH CHOLESTEROL","NCH PAP SMEAR" D
 .  S DA=$P(^LAB(69.5,0),U,3)+1
 .  S DIC="^LAB(69.5,"
 .  S DIC(0)="L" S DLAYGO=69.5
 .  D FILE^DICN K DD,DO,DIC,DA
 ;
 ;
 Q
FILL ;
 ;                                     LAG       CYCLE   PTF 0=YES
 ;                                     /\        /\      /\
 ;  ^LAB(69.5,16,0) = NCH CHOLESTEROL^0^7^2980525^D^^4576^0^50
 ;
 S $P(^LAB(69.5,LRPATH,0),U,3)=10
 S $P(^LAB(69.5,LRPATH,0),U,5)="D"
 S $P(^LAB(69.5,LRPATH,0),U,8)=1
 ;
 Q
