RANPRO ;BPFO/CLT - NEW RADIOLOGY PROCEDURE ; 27 Oct 2016  4:57 PM
 ;;5.0;Radiology/Nuclear Medicine;**127,138**;Mar 16, 1998;Build 22
 ;
EN ; Main entry point - driver for PROCEDURE prompt loop
 ;
 N RANQUIT,RANHIT,RADIO,RAMIS,RAPTY,RAIMAG,RA65,RARMPF,RAEXC
 S RANQUIT=0,RANHIT=0
 F  Q:$G(RANQUIT)  D EN2
 I $G(RANHIT) D 22^RAMAIN2
 Q
 ;
EN2 ; Loop entry point for PROCEDURE prompt
 N RACPT,RADA,RANM,RAPNM,RASEED,RATYP,RAX,RAYY,X,Y,RAMV,RACODE,RANEW,RAP3,RATYPE,I,RA7111DA
 N RANEW71,ARY,A,B,C,D,E,F,RALRDA,RACMDIFF,RACTIVE,RAENALL,RAFILE,RAY,RAPROC,RASTAT,RATRKCMA,RAXTMPNM
 N DD,DA,DO,DIC,DIR,DR,RAEND,RACODE1,RAOLDIEN,DIE,RANMSG,RATRKCMB,RADANEW1,RAFOUND,AA,EE
 N DIK,XX,RADUZ,RAFN,RAINADT,RAS,XMDUN,DTOUT,DUOUT
 S RANQUIT="",RANMSG="",RAMV=0
 K ^XTMP("RAMAIN4",$J)
 S (RANEW,RANEW71,RANQUIT)=0
 F  D  Q:$G(RAFOUND)!$G(RANQUIT)!$G(RANEW)
 .K X,Y,RAEND,DIR
 .S DIR(0)="FUO^1:60",DIR("A",1)=" ",DIR("A")="RAD/NUC MED PROCEDURE NAME"
 .S DIR("PRE")="S:$D(X) X=$$UP^XLFSTR(X) K:$L(X)>60 X S:$G(X)[""?"" X=-99"
 .D ^DIR S:Y=-99 (X,Y)="?" S RANM=Y I X=""!(X["^") S RANQUIT=1 Q
 .S RAPNM=RANM
 .K Y D SEARCH(RAPNM,.Y)
 .Q:(Y="")!(Y<0)!(Y="?")
 .S (RAPNM,RANM)=Y
 .I $G(Y)>0&$L($P(Y,"^",2)) S RAFOUND=1 D  Q  ; Match found
 .. I $P(Y,"^",2)]"" S (RAPNM,RANM)=$P(Y,"^",2) M RAYY=Y
 .I $L($G(Y)) S (RAPNM,RANM)=Y S RAFOUND=1  ; Not found, but something entered, ask if adding new
 .;
 .I '$D(^RAMIS(71,"B",RANM))!($G(RANEW)&'$G(RAYY)) S RAMV=3 D
 .. N Y K DIR S DIR(0)="Y",DIR("A")="Are you adding "_RANM_" as a new Radiology Procedure",DIR("B")="YES" D ^DIR
 .. I $G(Y)=1 S RANEW=1 Q
 .. I $G(Y)'=1 S RAMV=2,RANEW=0,RAEND=2
 ;
 S RANHIT=1 ; Flag to indicate at least one procedure was entered; ensure validity checker is run before exiting option
 I ('$G(RANEW)&($G(RAEND)=2))!($G(RAEND)=1) D END Q
 I $G(RAEND)=1!$G(RANQUIT) D END Q
TEMP ;ENTER THE TEMPORARY NEW PROCEDURE INTO 71.11
 I '$G(RANEW) G:$L(RANM) OLD G:'$L(RANM) END
 G:$G(RAEND) END
 ; create DA in temp file
 K DD,DO,DIC,X,Y S DIC="^RAMRPF(71.11,",DIC(0)="L",X=RANM D FILE^DICN
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
 ; changes for RA*5.0*138
 ;S RAP3=$P(^RAMIS(71,0),U,3)+1
 I $G(RA7111DA)="" S RA7111DA=$G(^TMP("RA7111DA",$J))
 ;S $P(^RAMIS(71,0),U,3)=RAP3
 ;S (RADA,RADANEW1)=RAP3
 ;get 71.11 data
 K ARY D GETS^DIQ(71.11,RA7111DA_",","**","I","ARY") S AA=RA7111DA_","
 ;
 ; use DICN to get next file 71 entry
 K DIC S DIC="^RAMIS(71,",DA="",X=ARY(71.11,AA,.01,"I"),DIC(0)="L",Y="" I X'="" D FILE^DICN
 S DA=+Y I DA<1 W !,"Not Able to Create File 71 entry" G TD
 S (RADA,RAP3,RADANEW1)=DA
 ;
 ; place temp file (71.11) data into Procedure file (71)
 ;
 S AA=RA7111DA_","
 K DR S DA=+RADA,DR=".01///"_ARY(71.11,AA,.01,"I"),DIE="^RAMIS(71," D ^DIE
 ;
 K DR S DIE="^RAMIS(71,",DR="",DA=+RADA F I=2,3,4,5,6,7,9,11,12,13,17,18,19,20 I $G(ARY(71.11,AA,I,"I"))'="" S:DR'="" DR=DR_";" S DR=DR_I_"///"_$G(ARY(71.11,AA,I,"I"))
 D ^DIE
 K DR S DR="",DA=+RADA F I=100,900,901,902,903 I $G(ARY(71.11,AA,I,"I"))'="" S:DR'="" DR=DR_";" S DR=DR_I_"///"_$G(ARY(71.11,AA,I,"I"))
 D ^DIE
 ; education description
 K DR S DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",""EDU"",",B=0 F  S B=$O(ARY(71.11,AA,500,B)) Q:'B  D
 . S C=ARY(71.11,AA,500,B),DA=0,X=C K DIC,DD,DO S DIC=RALRDA,DIC(0)="L" I X'="" D FILE^DICN
 ; synonym
 S DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",1," I $D(ARY(71.111)) D
 . K EE M EE(71.111)=ARY(71.111)
 . S B="EE(71.111",A=B_")" F  S A=$Q(@A) Q:$E(A,1,$L(B))'=B  S C=@A D
 . . K DIC,DD,DO S DA=0,DIC=RALRDA,DIC(0)="QEAL",X=C I X'="" D FILE^DICN
 ; descendents
 S DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",4," I $D(ARY(71.1105)) D
 . K EE M EE(71.1105)=ARY(71.1105)
 . S B="EE(71.1105",A=B_")"
 . F  S A=$Q(@A) Q:$E(A,1,$L(B))'=B  S C=@A I $QS(A,3)=".01" D
 . . K DIC,DD,DO S DA=0,DIC=RALRDA,DIC(0)="L",X=C I X'="" D FILE^DICN Q:+Y<1  S DA=+Y D
 . . . S DIE=RALRDA,DR=""
 . . . S D=B_","_$C(34)_$QS(A,2)_$C(34),E=D_")"
 . . . F  S E=$Q(@E) Q:$E(E,1,$L(D))'=D  S F=@E S:DR'="" DR=DR_";" S DR=DR_$QS(E,3)_"///"_F
 . . . I DR'="" D ^DIE
 ; message
 S DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",3," I $D(ARY(71.12)) D
 . K EE M EE(71.12)=ARY(71.12)
 . S B="EE(71.12",A=B_")" F  S A=$Q(@A) Q:$E(A,1,$L(B))'=B  S C=@A D
 . . K DIC,DD,DO S DA=0,DIC=RALRDA,DIC(0)="L",X=C I X'="" D FILE^DICN
 ; film type
 S DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",""F""," I $D(ARY(71.1102)) D
 . K EE M EE(71.1102)=ARY(71.1102)
 . S B="EE(71.1102",A=B_")" F  S A=$Q(@A) Q:$E(A,1,$L(B))'=B  S C=@A D
 . . K DIC,DD,DO S DA=0,DIC=RALRDA,DIC(0)="L",X=C I X'="" D FILE^DICN
 ; amis code
 S DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",2," I $D(ARY(71.1103)) D
 . K EE M EE(71.1103)=ARY(71.1103)
 . S B="EE(71.1103",A=B_")"
 . F  S A=$Q(@A) Q:$E(A,1,$L(B))'=B  S C=@A I $QS(A,3)=".01" D
 . . K DIC,DD,DO S DA=0,DIC=RALRDA,DIC(0)="L",X=C I X'="" D FILE^DICN Q:+Y<1  S DA=+Y D
 . . . S DIE=RALRDA,DR=""
 . . . S D=B_","_$C(34)_$QS(A,2)_$C(34),E=D_")"
 . . . F  S E=$Q(@E) Q:$E(E,1,$L(D))'=D  S F=@E S:DR'="" DR=DR_";" S DR=DR_$QS(E,3)_"///"_F
 . . . I DR'="" D ^DIE
 ; contrast media
 S DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",""CM""," I $D(ARY(71.11125)) D
 . K EE M EE(71.11125)=ARY(71.11125)
 . S B="EE(71.11125",A=B_")" F  S A=$Q(@A) Q:$E(A,1,$L(B))'=B  S C=@A D
 . . K DIC,DD,DO S DA=0,DIC=RALRDA,DIC(0)="L",X=C I X'="" D FILE^DICN
 ; default cpt modifiers
 S DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",""DCM""," I $D(ARY(71.11135)) D
 . K EE M EE(71.11135)=ARY(71.11135)
 . S B="EE(71.11135",A=B_")" F  S A=$Q(@A) Q:$E(A,1,$L(B))'=B  S C=@A D
 . . K DIC,DD,DO S DA=0,DIC=RALRDA,DIC(0)="L",X=C I X'="" D FILE^DICN
 ; default medications
 S DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",""P""," I $D(ARY(71.1155)) D
 . K EE M EE(71.1155)=ARY(71.1155)
 . S B="EE(71.1155",A=B_")"
 . F  S A=$Q(@A) Q:$E(A,1,$L(B))'=B  S C=@A I $QS(A,3)=".01" D
 . . K DIC,DD,DO S DA=0,DIC=RALRDA,DIC(0)="L",X=C I X'="" D FILE^DICN Q:+Y<1  S DA=+Y D
 . . . S DIE=RALRDA,DR=""
 . . . S D=B_","_$C(34)_$QS(A,2)_$C(34),E=D_")"
 . . . F  S E=$Q(@E) Q:$E(E,1,$L(D))'=D  S F=@E S:DR'="" DR=DR_";" S DR=DR_$QS(E,3)_"///"_F
 . . . I DR'="" D ^DIE
 ; default radiopharmaceuticals
 S DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",""NUC""," I $D(ARY(71.1108)) D
 . K EE M EE(71.1108)=ARY(71.1108)
 . S B="EE(71.1108",A=B_")"
 . F  S A=$Q(@A) Q:$E(A,1,$L(B))'=B  S C=@A I $QS(A,3)=".01" D
 . . K DIC,DD,DO S DA=0,DIC=RALRDA,DIC(0)="L",X=C I X'="" D FILE^DICN Q:+Y<1  S DA=+Y D
 . . . S DIE=RALRDA,DR=""
 . . . S D=B_","_$C(34)_$QS(A,2)_$C(34),E=D_")"
 . . . F  S E=$Q(@E) Q:$E(E,1,$L(D))'=D  S F=@E S:DR'="" DR=DR_";" S DR=DR_$QS(E,3)_"///"_F
 . . . I DR'="" D ^DIE
 ; modality
 S DA(1)=RADA,RALRDA="^RAMIS(71,"_DA(1)_",""MDL""," I $D(ARY(71.11731)) D
 . K EE M EE(71.11731)=ARY(71.11731)
 . S B="EE(71.11731",A=B_")" F  S A=$Q(@A) Q:$E(A,1,$L(B))'=B  S C=@A D
 . . K DIC,DD,DO S DA=0,DIC=RALRDA,DIC(0)="L",X=C I X'="" D FILE^DICN
 ;
 S (RADA,RADANEW1)=RAP3
 W !!,"Temporary new procedure entry has been moved to the permanent ",!,"RAD/NUC MED PROCEDURE file." H 1
 ; make sure indexes are set up.
 K DA,DIK S DIK="^RAMIS(71,",DA=RADA D IX^DIK K DA,DIK ; populate indexes for (newly created procedure.
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
 K RADA,RAINADT,RASTAT,RAFILE,RAY,RAENALL
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
 I $G(RA7111DA)="" S RA7111DA=$G(^TMP("RA7111DA",$J))
 I RA7111DA>0 D
 . K DIK S DIK="^RAMRPF(71.11,",DA=RA7111DA D ^DIK K DIK
 . K ^RAMRPF(71.11,"CREAT",DT,DA)
 K ^TMP("RA7111DA",$J)
 ;
 ;D 22^RAMAIN2
 ;
END ;ROUTINE END
 K RACPT,RADA,RANM,RAPNM,RASEED,RATYP,RAX,RAYY,X,Y,RAMV,RACODE,RANEW,RAP3,RATYPE,I,RA7111DA
 K RANEW71,ARY,A,B,C,D,E,F,RALRDA,RACMDIFF,RACTIVE,RAENALL,RAFILE,RAY,RAPROC,RASTAT,RATRKCMA,RAXTMPNM
 K DD,DA,DO,DIC,DIR,DR,RAEND,RACODE1,RAOLDIEN,DIE,RANMSG,RATRKCMB,RADANEW1,RAFOUND,AA,EE
 K DIK,XX,RADUZ,RAFN,RAINADT,RAS,XMDUN,DTOUT,DUOUT
 K ^XTMP("RAMAIN4",$J)
 Q
 ;
OLD ;EXISTING PROCEDUREX ^%
 S RANEW=0  ; Make absolutely sure recursive deadlock doesn't occur - 21^RAMAIN2 calls EN^RANPRO. 
 I $G(RAYY) S (RADA,DA)=+RAYY
 I '$G(RAYY) S DIC="^RAMIS(71,",X=RANM D ^DIC S (RADA,DA)=+Y,RAYY=Y
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
SEARCH(RAINPUT,RAOUTPUT) ; Search file 71 for RAINPUT
 ; INPUT  : RAINPUT  = Input value to use in search of file 71
 ; OUTPUT : RAOUTPUT = Y array, from ^DIC, of entry selected from file 71
 ;
 I $G(RAINPUT)="" D END Q
 N RAFILE,X,Y,DD,DIC,DINUM,DLAYGO,DO,RAY,DTOUT,DUOUT
 S (RAENALL,RANEW71)=0
 S (X,RAOUTPUT)=$G(RAINPUT)
 S DIC="^RAMIS(71,",DIC(0)="MEZ"
 W ! D ^DIC
 ; To replicate legacy lookup, if no entry returned from DIC call:
 ;    1) If exact or partial match of RAINPUT in ^RAMIS(71,"B", return nothing. Calling routine should re-prompt for procedure.
 ;    2) If NO exact or partial match of RAINPUT in ^RAMIS(71, return output=RAINPUT, calling routine should prompt to add new.
 I Y=-1!$G(DUOUT)!$G(DTOUT) D  Q
 . I $L($G(RAINPUT)) D  Q:Y=""
 .. I $D(^RAMIS(71,"B",RAINPUT))!($E($O(^RAMIS(71,"B",RAINPUT)),1,$L(RAINPUT))=RAINPUT)!($G(X)="?") S (RAOUTPUT,Y)=""  ; Nothing selected
 .. I $L($G(X))<3 S (RAOUTPUT,Y)=""
 . S RAINPUT=$TR($G(RAINPUT),"""","") S (RAOUTPUT,Y)=RAINPUT S (RANEW71,RANEW)=1
 ;    Exact match found (no user interaction), or selected (user interaction)
 I +$G(Y)>0 S RAY=+Y
 I $G(RAY) S (DA)=+Y,RAFILE=71 I DA M RAOUTPUT=Y L +^RAMIS(RAFILE,DA):5 I '$T D  Q
 . W !?5,"This record is currently being edited by another user."
 . W !?5,"Try again later!",$C(7)
 . K RAOUTPUT S RAOUTPUT=""
 Q
