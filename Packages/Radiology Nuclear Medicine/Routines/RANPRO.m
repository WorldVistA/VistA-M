RANPRO ;BPFO/CLT - NEW RADIOLOGY PROCEDURE ; 27 Oct 2016  4:57 PM
 ;;5.0;Radiology/Nuclear Medicine;**127**;Mar 16, 1998;Build 119
 ;
EN ;ENTRY POINT
 N RACPT,RADA,RANM,RAPNM,RASEED,RATYP,RAX,RAYY,X,Y,RAMV,RACODE,RANEW,RAP3,RATYPE,I,RA7111DA S RAMV=0
 N D,DA,DO,DIC,DIR,DR,RAEND,RACODE1,RAOLDIEN,DIE,RANQUIT,RANMSG,RATRKCMB,RADANEW1 S RANQUIT="",RANMSG=""
 N RANEW71,ARY,A,B,C,D,E,F,RALRDA,RACMDIFF,RACTIVE,RAENALL,RAFILE,RAY,RAPROC,RASTAT,RATRKCMA
 S DIR(0)="71.11,.01O",DIR("A")="RAD/NUC MED PROCEDURES NAME"
 S DIR("PRE")="K:X[""""""""!($A(X)=45) X S:$D(X) X=$$UP^XLFSTR(X) Q:(X=""^"")!$D(DTOUT)  K:$L(X)>60!($L(X)<3) X I $D(X) K:'+$$UNI30^RAUTL14(+$G(DA),X) X"
 D ^DIR S RANM=Y I X=""!(X["^") D 22^RAMAIN2 G END
 I $D(^RAMIS(71,"B",RANM)) S DIC="^RAMIS(71,",DIC("DR")=6,DIC(0)="",X=RANM D ^DIC S RAYY=Y,(DA,RADA)=+Y,(RANEW,RANEW71)=$P(RAYY,U,3) D 21^RAMAIN2 G END
 S RAPNM=RANM I '$D(^RAMIS(71,"B",RANM)) S RAEND="" D
 . S RAPNM=RANM  ;,RAPNM=$O(^RAMIS(71,"B",RANM)) I RAPNM="" S RAMV=3 Q
 . S RACODE="",I=0 F  S RAPNM=$O(^RAMIS(71,"B",RAPNM)) S:RAPNM'[RANM RAMV=3 Q:RAPNM'[RANM  D
 .. S RAOLDIEN="",RAOLDIEN=$O(^RAMIS(71,"B",RAPNM,RAOLDIEN)) D:RAOLDIEN'=""
 ... S I=I+1,RACODE=RACODE_I_":"_RAPNM_"/"_RAOLDIEN_";"
 ... Q
 .. ;S RACODE=RACODE_I+1_":New Procedure;"_I+2_":None of the above"
 .. Q
 . S RACODE1=(I+1)_":New Procedure;"_(I+2)_":None of the above",RACODE=RACODE_RACODE1
 . K DIR S DIR(0)="S^"_RACODE S DIR("A")="Enter a number from the list above"
 . D ^DIR I $D(DTOUT)!($D(DUOUT)) Q
 . I $G(X)=""!($G(X)["^") S RAMV=3,RAEND=1 Q
 . I Y(0)="New Procedure" S RANEW=1
 . I Y(0)="None of the above" S RAMV=3,RAEND=1 Q
 . Q
 ;Q:$G(Y(0))=""
 I $G(Y(0))=""!(RAEND=1) D 22^RAMAIN2 G END
 S Y(0)=$P(Y(0),"/",1) I $D(^RAMIS(71,"B",Y(0))) S RANM=Y(0) G OLD
 I '$D(^RAMIS(71,"B",RANM)) S RAMV=3 D
 . I $G(RAMV)=3 Q
 . K DIR S RAYY=Y,DIR(0)="Y",DIR("A")="Are you adding "_RANM_" as a new Radiology Procedure",DIR("B")="YES" D ^DIR
 . I $G(Y)'=1 S RAMV=2 Q
 . S DIC="^RAMRPF(71.11,",DIC(0)="L",X=RAYY,DIC("DR")=6 D ^DIC
 . S RATYPE=$P(^RAMRPF(71.11,+Y,0),U,6),RANEW=1,RAYY=Y,RA7111DA=+Y
 . S (RAPNM,RANM)=$P($G(RAYY),U,2)  ;proc. name for display purposes in template
 . Q
 ;
ENL ;S DIC="^RAMRPF(71.11,",DIC(0)="QEAMLZ",DLAYGO=71.11,DIC("DR")=6
 ;S DIC("A")="RAD/NUC MED PROCEDURES NAME: "
 ;W ! D ^DIC
 ;I $G(Y)<0!($G(Y)="")!($G(X)="^") G END
 ;S (DA,RADA)=+Y,RAY=Y,RAFILE=71.11
 ;S (RANEW71,RANEW)=$S($P(Y,U,3)=1:1,1:0) ;used in template, edit CPT Code if new rec.
 ;S (RANM,RAPNM)=$P($G(Y(0)),U) ;proc. name for display purposes in template
 ;I 'RANEW G OLD
TEMP ;ENTER THE TEMPORARY NEW PROCEDURE INTO 71.11
 I $G(RAMV)=2 S RANM=$P(Y(0),"/",1) G OLD
 G:$G(RAEND) END
 ; create DA in temp file
 K DD,DO N DIC,X,Y S DIC="^RAMRPF(71.11,",DIC(0)="L",X=RANM D FILE^DICN
 I +Y<1 W !!,"Not able to create entry in temporary area" G END
 S (RADA,RA7111DA)=+Y K ^TMP("RA7111DA",$J) S ^TMP("RA7111DA",$J)=RA7111DA K DIC,X,Y
 ; do check of name and procedure type"
 S DIE="^RAMRPF(71.11,",DA=RA7111DA,DR="6" D ^DIE
 ; If Category was bypassed by entering "^", remove temp entry and quit
 I $P($G(^RAMRPF(71.11,RADA,0)),"^",6)="" W !,"Nothing Saved" G TD
 S RACTIVE=$P($G(^RAMPRF(71.11,RADA,"I")),"^"),RASTAT=$S(RACTIVE="":1,RACTIVE>DT:1,1:0)
 D TRKCMB^RAMAINU(DA,.RATRKCMB) ;tracks existing
 ; CM definition before editing. RATRKCMB ids the before CM values
 ;
 S DIE="^RAMRPF(71.11,",DR="[NEW RAD PROCEDURE]",DA=RA7111DA D ^DIE
 I $G(Y)="^" W !,"Nothing Saved" G TD
 S RADA=DA,RACPT=$P(^RAMRPF(71.11,DA,0),U,9)
 I $G(RA7111DA)="" S RA7111DA=$G(^TMP("RA7111DA",$J))
 I $P(^RAMRPF(71.11,RA7111DA,0),U,6)'="D" D
 . W !!,"This procedure was not created as a DETAILED exam and will not be matched",!,"to the MASTER RADIOLOGY PROCEDURE FILE." H 2
 . Q
 I $G(RACPT)'="",$P(^RAMRPF(71.11,RA7111DA,0),U,6)="D" I $G(RANEW)=1 D EN^RANPRO4(RADA) G:$G(RANQUIT)=1 TD
 I $P($G(^RAMRPF(71.11,RA7111DA,0)),U,9)="",$P($G(^RAMRPF(71.11,RA7111DA,0)),U,6)="D" W !!,"No CPT Code has been entered.  This new procedure will be deleted.",*7 G TD
 S RADA=RA7111DA,RAPROC(0)=$G(^RAMRPF(71.11,RADA,0))
 S RACTIVE=$P($G(^RAMPRF(71.11,RADA,"I")),"^"),$P(RASTAT,"^",2)=$S(RACTIVE="":1,RACTIVE>DT:1,1:0)
 ;
 I RAPROC(0)]"",("^B^P^"'[(U_$P(RAPROC(0),"^",6)_U)),('+$P(RAPROC(0),"^",9)) D  G TD
 . W !?5,$C(7),"Procedure Type: ",$S($P(RAPROC(0),"^",6)="S":"SERIES",1:"DETAILED")," ...no CPT code entered..."
 . W !?5,"...will delete the record at this time.",!
 ;
MV ;MOVE TEMPORARY ENTRY TO PERMANENT ENTRY
 ;I $G(RAMV)'="" G:"13"'[RAMV END
 S RAP3=$P(^RAMIS(71,0),U,3)+1
 ;S %X="^RAMRPF(71.11,1,"
 I $G(RA7111DA)="" S RA7111DA=$G(^TMP("RA7111DA",$J))
 ;S %X="^RAMRPF(71.11,"_RA7111DA_","
 ;S %Y="^RAMIS(71,"_RAP3_","
 ;D %XY^%RCR
 S $P(^RAMIS(71,0),U,3)=RAP3
 S (RADA,RADANEW1)=RAP3
 ;get 711.11 data
 K ARY D GETS^DIQ(71.11,RA7111DA_",","**","I","ARY") S A=RA7111DA_","
 S DA=+RADA,$P(^RAMIS(71,DA,0),"^",1)=ARY(71.11,A,.01,"I")
 S DIE="^RAMIS(71,",DR="",DA=RADA F I=2,3,4,5,6,7,9,11,12,13,17,18,19,20 I $G(ARY(71.11,A,I,"I"))'="" S:DR'="" DR=DR_";" S DR=DR_I_"///"_$G(ARY(71.11,A,I,"I"))
 D ^DIE
 S DR="",DA=+RADA F I=100,900,901,902,903 I $G(ARY(71.11,A,I,"I"))'="" S:DR'="" DR=DR_";" S DR=DR_I_"///"_$G(ARY(71.11,A,I,"I"))
 D ^DIE
 ; education description
 S DR="",DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",""EDU"",",B=0 F  S B=$O(ARY(71.11,A,500,B)) Q:'B  D
 . S C=ARY(71.11,A,500,B),DA=0,X=C,DIC=RALRDA,DIC(0)="QEAL" I X'="" D FILE^DICN
 ; synonym
 S DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",1,"
 S B="ARY(71.111",A=B_")" F  S A=$Q(@A) Q:$E(A,1,$L(B))'=B  S C=@A D
 . S DA=0,DIC=RALRDA,DIC(0)="QEAL",X=C I X'="" D FILE^DICN
 ; descendents
 S DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",4,"
 S B="ARY(71.1105",A=B_")"
 F  S A=$Q(@A) Q:$E(A,1,$L(B))'=B  S C=@A I $QS(A,3)=".01" D
 . S DA=0,DIC=RALRDA,DIC(0)="QEAL",X=C I X'="" D FILE^DICN Q:+Y<1  S DA=+Y D
 . . S DIE=RALRDA,DR=""
 . . S D=B_","_$C(34)_$QS(A,2)_$C(34),E=D_")"
 . . F  S E=$Q(@E) Q:$E(E,1,$L(D))'=D  S F=@E S:DR'="" DR=DR_";" S DR=DR_$QS(E,3)_"///"_F
 . . I DR'="" D ^DIE
 ; message
 S DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",3,"
 S B="ARY(71.12",A=B_")" F  S A=$Q(@A) Q:$E(A,1,$L(B))'=B  S C=@A D
 . S DA=0,DIC=RALRDA,DIC(0)="QEAL",X=C I X'="" D FILE^DICN
 ; film type
 S DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",""F"","
 S B="ARY(71.1102",A=B_")" F  S A=$Q(@A) Q:$E(A,1,$L(B))'=B  S C=@A D
 . S DA=0,DIC=RALRDA,DIC(0)="QEAL",X=C I X'="" D FILE^DICN
 ; amis code
 S DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",2,"
 S B="ARY(71.1103",A=B_")"
 F  S A=$Q(@A) Q:$E(A,1,$L(B))'=B  S C=@A I $QS(A,3)=".01" D
 . S DA=0,DIC=RALRDA,DIC(0)="QEAL",X=C I X'="" D FILE^DICN Q:+Y<1  S DA=+Y D
 . . S DIE=RALRDA,DR=""
 . . S D=B_","_$C(34)_$QS(A,2)_$C(34),E=D_")"
 . . F  S E=$Q(@E) Q:$E(E,1,$L(D))'=D  S F=@E S:DR'="" DR=DR_";" S DR=DR_$QS(E,3)_"///"_F
 . . I DR'="" D ^DIE
 ; contrast media
 S DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",""CM"","
 S B="ARY(71.11125",A=B_")" F  S A=$Q(@A) Q:$E(A,1,$L(B))'=B  S C=@A D
 . S DA=0,DIC=RALRDA,DIC(0)="QEAL",X=C I X'="" D FILE^DICN
 ; default cpt modifiers
 S DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",""DCM"","
 S B="ARY(71.11135",A=B_")" F  S A=$Q(@A) Q:$E(A,1,$L(B))'=B  S C=@A D
 . S DA=0,DIC=RALRDA,DIC(0)="QEAL",X=C I X'="" D FILE^DICN
 ; default medications
 S DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",""P"","
 S B="ARY(71.1155",A=B_")"
 F  S A=$Q(@A) Q:$E(A,1,$L(B))'=B  S C=@A I $QS(A,3)=".01" D
 . S DA=0,DIC=RALRDA,DIC(0)="QEAL",X=C I X'="" D FILE^DICN Q:+Y<1  S DA=+Y D
 . . S DIE=RALRDA,DR=""
 . . S D=B_","_$C(34)_$QS(A,2)_$C(34),E=D_")"
 . . F  S E=$Q(@E) Q:$E(E,1,$L(D))'=D  S F=@E S:DR'="" DR=DR_";" S DR=DR_$QS(E,3)_"///"_F
 . . I DR'="" D ^DIE
 ; default radiopharmaceuticals
 S DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",""NUC"","
 S B="ARY(71.1108",A=B_")"
 F  S A=$Q(@A) Q:$E(A,1,$L(B))'=B  S C=@A I $QS(A,3)=".01" D
 . S DA=0,DIC=RALRDA,DIC(0)="QEAL",X=C I X'="" D FILE^DICN Q:+Y<1  S DA=+Y D
 . . S DIE=RALRDA,DR=""
 . . S D=B_","_$C(34)_$QS(A,2)_$C(34),E=D_")"
 . . F  S E=$Q(@E) Q:$E(E,1,$L(D))'=D  S F=@E S:DR'="" DR=DR_";" S DR=DR_$QS(E,3)_"///"_F
 . . I DR'="" D ^DIE
 ; modality
 S DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",""MDL"","
 S B="ARY(71.11731",A=B_")" F  S A=$Q(@A) Q:$E(A,1,$L(B))'=B  S C=@A D
 . S DA=0,DIC=RALRDA,DIC(0)="QEAL",X=C I X'="" D FILE^DICN
 ;
 S (RADA,RADANEW1)=RAP3
 W !!,"Temporary new procedure entry has been moved to the permanent ",!,"RAD/NUC MED PROCEDURE file." H 1
 N DA,DIK S DIK="^RAMIS(71,",DA=RADA D IX^DIK K DA,DIK ; populate indexes for (newly created procedure.
 ;
 ;tracking items
 S RAPROC(0)=$G(^RAMIS(71,RADA,0))
 ;check for data consistency between the 'CONTRAST MEDIA USED' &
 ;'CONTRAST MEDIA' fields.
 D CMINTEG^RAMAINU1(RADA,RAPROC(0))
 D TRKCMA^RAMAINU(RADA,RATRKCMB,.RATRKCMA,.RACMDIFF)
 I $O(^RAMIS(71,RADA,"NUC",0)),($P(RAPROC(0),"^",2)=1) D DELRADE(RADA)
 S RACTIVE=$P($G(^RAMIS(71,RADA,"I")),"^"),RASTAT=RASTAT_"^"_$S(RACTIVE="":1,RACTIVE>DT:1,1:0)
 ;if an active parent w/o descendants, inactivate the parent
 I $P(RASTAT,U,2),($P(RAPROC(0),U,6)="P"),('$O(^RAMIS(71,RADA,4,0))) D
  . K D,D0,D1,DA,DI,DIC,DIE,DQ,DR
  . W !!?5,"Inactivating this parent procedure - no descendents.",!,$C(7)
  . S DA=RADA,DIE="^RAMIS(71,",DR="100///"_$S($D(DT):DT,1:$$DT^XLFDT())
  . D ^DIE K D,D0,D1,DA,DI,DIC,DIE,DQ,DR S $P(RASTAT,U,2)=0 ;inactive
  I $P($G(^RA(79.2,+$P(RAPROC(0),U,12),0)),U,5)="Y",(+$O(^RAMIS(71,RADA,"NUC",0))) D VRDIO(RADA)
  I "^B^P^"[(U_$P(RAPROC(0),U,6)_U),($P(RAPROC(0),U,9)]"") D
  . K %,D,D0,DA,DE,DIC,DIE,DQ,DR
  . S DA=RADA,DIE="^RAMIS(71,",DR="9///@" D ^DIE
  . W !!?5,"...CPT code deleted because "_$S($P(RAPROC(0),U,6)="B":"Broad",1:"Parent")_" procedures",!?5,"should not have CPT codes.",!,$C(7)
  . Q
 ;
ORDITM ;ORDERABLE ITEM ENTRY
 W !,"Updating ORDERABLE ITEMS file" ;S RAMSG=RADA,RAMLNB=""
 ;S ZTREQ="@"
 N RADA,RAINADT,RASTAT,RAFILE,RAY,RAENALL
 ; update orderable file for newly created procedure
 S RADA=RADANEW1,RAINADT=$P($G(^RAMIS(71,RADA,"I")),"^")
 S RASTAT="1^"_$S(RAINADT="":1,RAINADT>DT:1,1:0)
 ;S RASTAT="1^1"
 S RAENALL=0,RAY=RADA,RAFILE=71
 S $P(RAY,"^",2)=$P($G(^RAMIS(71,RADA,0)),"^",1)
 D:$$ORQUIK^RAORDU()=1 PROC^RAO7MFN(RAENALL,RAFILE,RASTAT,RAY)
 ;D PROC^RAO7MFN(RAENALL,RAFILE,RASTAT,RAY)
 I $G(RANMSG)=1 D MSGRAN^RANPRO4(RADA)
 K RADA,RAINADT,RASTAT,RAFILE,RAY,RAENALL
 ;
TD ;DELETE THE TEMPORARY FILE ENTRY
 W !,"Deleting temporary entry in file 71.11"
 ;S DIK="^RAMRPF(71.11,",DA=1 D ^DIK
 I $G(RA7111DA)="" S RA7111DA=$G(^TMP("RA7111DA",$J))
 I RA7111DA>0 D
 . S DIK="^RAMRPF(71.11,",DA=RA7111DA D ^DIK
 . K ^RAMRPF(71.11,"CREAT",DT,DA)
 K ^TMP("RA7111DA",$J)
 ;
 D 22^RAMAIN2
 ;
END ;ROUTINE END
 K DIE,DIK,XY,RANQUIT,DIR,DIC,RACODE,RACODE1,RADA,RADUZ,RAFN,RAINADT,RAMV,RANEW,RANM,RANMSG
 K RAP3,RAPNM,RAS,RASEED,XMDUN,RATRKCMB,RADANEW1,RANEW71,ARY,A,B,C,D,E,F
 K RALRDA,RACMDIFF,RACTIVE,RAENALL,RAFILE,RAY,RAPROC,RASTAT,RATRKCMA
 Q
 ;
OLD ;EXISTING PROCEDUREX ^%
 S DIC="^RAMIS(71,",X=RANM D ^DIC S (RADA,DA)=+Y,RAYY=Y
 D 21^RAMAIN2
 G END
 ;
VRDIO(RADA) ; Validate the 'Usual Dose' field within the 'Default Radiopha-
 ; rmaceuticals' multiple.  'Usual Dose' must fall within the 'Low Adult
 ; Dose' & 'High Adult Dose' range.  This subroutine will display the
 ; Radiopharmaceutical in question along with the values in question if
 ; inconsistencies are found.
 ;
 ; Input Variable: 'RADA' the ien of the Procedure
 N RANUC S RADA(1)=RADA,RADA=0 D EN^DDIOL("","","!")
 F  S RADA=$O(^RAMIS(71,RADA(1),"NUC",RADA)) Q:RADA'>0  D
 . S RANUC(0)=$G(^RAMIS(71,RADA(1),"NUC",RADA,0))
 . Q:$P(RANUC(0),"^",2)=""  ; no need to validate, nothing input
 . I '$$USUAL^RADD2(.RADA,$P(RANUC(0),"^",2)) D
 .. N RARRY S RARRY(1)="For Radiopharmaceutical: "
 .. S RARRY(1)=RARRY(1)_$$EN1^RAPSAPI(+$P(RANUC(0),"^"),.01)_$C(7)
 .. S RARRY(2)="" D EN^DDIOL(.RARRY,"")
 .. Q
 . Q
 S RADA=RADA(1) K RADA(1)
 Q
 ;
DELRADE(RADA) ; Delete the Default Radiopharmaceuticals multiple 
 N RADA1 S RADA1=0
 W !!?3,"Deleting default radiopharmaceuticals for this procedure...",!
 F  S RADA1=$O(^RAMIS(71,RADA,"NUC",RADA1)) Q:RADA1'>0  D
 . K %,%X,%Y,D,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 . S DA(1)=RADA,DA=RADA1,DIE="^RAMIS(71,"_RADA_",""NUC"","
 . S DR=".01///@" D ^DIE
 . Q
 K %,%X,%Y,D,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 Q
 ;
