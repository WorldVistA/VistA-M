DPTLK2 ;ALB/RMO,ERC - MAS Patient Look-up Add New Patient ;13 Feb 2020  3:00 PM
 ;;5.3;Registration;**32,197,214,244,532,578,615,620,647,680,702,653,915,1000**;Aug 13, 1993;Build 2
 N DPTCT,DGVV,DPTLIDR,DGCOL S DGCOL=0
 I $D(DDS) D CLRMSG^DDS S DX=0,DY=DDSHBX+1 X DDXY
 I '$D(DUZ(0)) W:DIC(0)["Q" !?3,*7,"Unable to Add Patient. Your Fileman Access Code is undefined." S DPTDFN=-1 G Q
 I $S($D(DLAYGO):2\1-(DLAYGO\1),1:1),DUZ(0)'="@",$D(^DIC(2,0,"LAYGO")) F I=1:1 I DUZ(0)[$E(^("LAYGO"),I) Q:I'>$L(^("LAYGO"))  S DPTDFN=-1 W:DIC(0)["Q" *7," ??" G Q
 N DG20NAME S DG20NAME=$G(DPTX),DPTX=$$FORMAT^XLFNAME7(.DG20NAME,3,30,,1)
 S DPTX=$S($E(DPTX)[""""&($E(DPTX,$L(DPTX))[""""):$P(DPTX,"""",2),$E(DPTX)["""":$P(DPTX,"""",2),$E(DPTX,$L(DPTX))["""":$P(DPTX,"""",1),1:DPTX)
 I $L(DPTX)<3!($L(DPTX)>30)!(DPTX?1P.E)!(DPTX'[",")!(DPTX'?1U.ANP) W:DIC(0)["Q" *7," ??" S DPTDFN=-1 G Q
 ; DG*647
 I $P($G(XQY0),U)="DG COLLATERAL PATIENT" S DGCOL=1,DGCOL("DR")=$P(DIC("DR"),";",5,8)
 ;**915 do enterprise search if register a patient option
 I $P($G(XQY0),"^",2)="Register a Patient",$T(PATIENT^MPIFXMLP)'="" D  G Q
 . N DGSAVDFN
 . I '$G(DGSEARCH) S DGSAVDFN=$$SEARCH^DPTLK7(DPTX,DPTXX)
 . I $G(DGSAVDFN)>0 S DPTDFN=DGSAVDFN Q
 . S DPTDFN=-1 S:DPTDFN<1&('$D(DTOUT)) DUOUT=1
 K DPTLID I DIC(0)["E" D ASKADD D  G Q:DPTDFN<0 I ('$D(DIC("DR")))!(DGCOL) D CHKID G Q:DPTDFN<0 D ^DPTLK3 G Q:DPTDFN<0 W !!?3,"...adding new patient"
 .S:DPTDFN<1&('$D(DTOUT)) DUOUT=1
 S X=DPTX,DPT("NO^")=$G(DIE("NO^")) K DD,DO,DPTX N DPTZNV
 S:$D(DPT("DR")) DIC("DR")="S DIE(""NO^"")=""BACK"";"_DPT("DR")
 I DGCOL S:$D(DPT("DR")) DIC("DR")=DPT("DR")_";"_DGCOL("DR")
 D FILE^DICN K:$D(DPT("DR")) DIC("DR")
 I +Y>0 W ?24,"...new patient added",!?3
 S DPTDFN=Y S:$L(DPT("NO^")) DIE("NO^")=DPT("NO^")
 ;offer prompt of patient file components
 K DA,DIE,DR
 S DIE="^DPT(",DA=+Y,DR="S DIE(""NO^"")=""BACK"";.01///^S (X,DPTZNV)=$$NCEDIT^DPTNAME(DA,1,.DG20NAME)"
 D ^DIE K DR
 ;look for other (local) identifiers
 I '$D(DIC("DR")),DIC(0)["E",'DGCOL D
 .F DPTID=0:0 S DPTID=$O(^DD(2,0,"ID",DPTID)) Q:'DPTID  D
 ..I $F(DPTGID,U_DPTID_U) Q
 ..I '$D(^DD(2,DPTID,0)) Q
 ..S DPTLID=""
 ..S DPTLIDR=$S('$D(DPTLIDR):DPTID,1:DPTLIDR_";"_DPTID)
 I $D(DPTLID) W !!?3,"Please enter the following additional information:",!?3 S DIE="^DPT(",DA=+DPTDFN,DIE("NO^")="BACK",DR=DPTLIDR D ^DIE K DIE,DA,DR
 ;
Q K DFN,DPT("DR"),DPTLID,DPTGID,DPTID,DPTID0,DPTIDS
 Q
 ;
ASKADD I $D(DDS) I $Y>21 D CLRMSG^DDS S DX=0,DY=DDSHBX+1 X DDXY
 S Y=+$P(^DPT(0),U,4)+1 W !?3,*7,"ARE YOU ADDING ",$S(DPTX'?.N:"'"_DPTX_"' AS ",1:""),"A NEW PATIENT (THE ",Y,$S(Y#10=1&(Y#100-11):"ST",Y#10=2&(Y#100-12):"ND",Y#10=3&(Y#100-13):"RD",1:"TH"),")"
 S %=2 D YN^DICN S DPTDFN=$S(%<0!(%=2):-1,%=1:1,1:0) I 'DPTDFN W !?6,"Enter 'YES' to add a new applicant, or 'NO' not to." G ASKADD
 I %=1 S:$$CONF1^DPTNAME(DPTX)'=1 DPTDFN=-1
 Q
 ;
CHKID K DFN S DPTDFN=1,DPTGID="^.02^.03^.09^391^1901^.301^994^" I DGCOL S DPTGID="^.03^.09^.02^.3601^"
 F DPTCT=2:1 S DPTID=$P(DPTGID,U,DPTCT) Q:'DPTID!(DPTDFN<0)  D CHKID1
 Q
 ;
CHKID1 I $D(^DD(2,DPTID,0)) S DPT("DR")=$S('$D(DPT("DR")):DPTID,1:DPT("DR")_";"_DPTID),DPTID0=^DD(2,DPTID,0) D ASKID S:'$D(X) DPTDFN=-1
 Q
 ;
ASKID N DGREC W !?3,"PATIENT ",$P(DPTID0,U),": " R X:DTIME D  I $D(DTOUT)!$G(DUOUT)!($G(DGREC)=1) W !?6,*7,"<'",DPTX,"'> NOT ADDED" K X Q
 .S:'$T DTOUT=U
 .S:X="^" DUOUT=1
 .Q:$D(DTOUT)!($G(DUOUT))!(X["^")
 .I DPTID=.09 D
 ..;added with DG*5.3*653 - ERC
 ..I X="P"!(X="p") S DPTGID=$P(DPTGID,".09",1)_".09^.0906"_$P(DPTGID,".09",2)
 ..N DGNEWPT
 ..S DGNEWPT=1
 ..D REC^DGSEC
 I X["^" W:$E(X)["^" !?6,*7,"Sorry, '^' not allowed!" W " ??" G ASKID
 ; field 994 is not a required field
 I DPTID=994 I X["?" D HLPID G ASKID
 I DPTID=994 I X="" G SKIP
 I X["?"!(X="") W:X="" *7," ??" D HLPID G ASKID
 I $P(DPTID0,U,2)["S" F I=1:1 S Y=$P($P(DPTID0,U,3),";",I) K:Y="" X Q:Y=""  I $P(Y,":",1)=X!($E($P(Y,":",2),1,$L(X))=X) S X=$P(Y,":",1),DPTSET=$P(Y,":",2) Q
SKIP I $P(DPTID0,U,2)["P" D P1 G ASKID:Y'>0 Q:'$D(X)  S DPTIDS(DPTID)=+Y,DPT("DR")=DPT("DR")_"////"_+Y K DPTSET Q  ;**1000,Story 1171329 (mko): Return DPTIDS(DPTID)=pointer value and use 4-slash stuff for the field
 I DPTID=.301,$D(X) D CHKIT Q:'$D(X)  I $D(X) W:$D(DPTSET) " ",DPTSET S DPTIDS(DPTID)=X,DPT("DR")=DPT("DR")_"///"_X K DPTSET Q
 I DPTID'=.301 X $P(DPTID0,U,5,99) I $D(X) W:$D(DPTSET) " ",DPTSET S DPTIDS(DPTID)=X,DPT("DR")=DPT("DR")_"///"_X K DPTSET Q
 W:'$D(X)&($P(DPTID0,U,2)'["D") *7," ??" D HLPID G ASKID
 ;
HLPID W:$D(^DD(2,DPTID,.1)) !?5,^(.1) W:$D(^DD(2,DPTID,3)) !?5,^(3) I $D(X),X["?" F I=0:0 S I=$O(^DD(2,DPTID,21,I)) Q:'I!(I>3&(X?1"?"))  I $D(^(I,0)) W !?5,^(0) I I>2,X?1"?" W !?5,"..."
 X:$D(^DD(2,DPTID,4)) ^(4) I $P(DPTID0,U,2)["D" S X="?",%DT="E" D ^%DT
 I $P(DPTID0,U,2)["S" W !?7,"CHOOSE FROM: " F I=1:1 S Y=$P($P(DPTID0,U,3),";",I) Q:Y=""  W !?7,$P(Y,":",1),?15," ",$P(Y,":",2)
 I $P(DPTID0,U,2)["P" D P1
 Q
P1 I DPTID=".3601" S X=$$UCASE^DPTLK1(X) ;DG*5.3*680
 S DPTDIC=$G(DIC),DPTDIC(0)=$G(DIC(0)) S:$D(DIC("S")) DPTDIC("S")=DIC("S") S:$D(DIC("W")) DPTDIC("W")=DIC("W") S DIC="^"_$P(DPTID0,"^",3),DIC(0)="QEMZ",D="B" D IX^DIC
 S DIC=DPTDIC,DIC(0)=DPTDIC(0) S:$D(DPTDIC("S")) DIC("S")=DPTDIC("S") S:$D(DPTDIC("W")) DIC("W")=DPTDIC("W") K DPTDIC D DO^DIC1 S:X["^" DPTDFN=-1 I X'["^",X'["?",Y'>0 S X="?" G P1
 ; DG*5.3*680  S X=+Y stores the IEN of the sponsor picked to pass to FILE^DICN
 I DPTID=".3601" S X=+Y I '$D(^DPT(+Y,"VET"))!($P($G(^DPT(+Y,"VET")),U)'="Y") D EN^DDIOL("Sponsor must be a veteran","","!?4") K X W !?6,*7,"<'",DPTX,"'> NOT ADDED"
 Q
CHKIT ; do input transform for .301
 I X'="Y" Q
 S DGVV=DPTIDS(391)
 ;**1000,Story 1171329 (mko): SKIP was modified above to set DPTIDS(391) to the internal pointer value,
 ;  so only try to convert to external form if it's not numeric.
 I DGVV]"",DGVV'=+$P(DGVV,"E") S DGVV=$O(^DG(391,"B",DGVV,0))
 S DGVV=$S($D(^DG(391,+DGVV,0)):$P(^(0),"^",2),1:"")
 I DPTIDS(1901)'="Y",'DGVV D EN^DDIOL("Applicant is NOT a veteran!!","","!?4") K X W !?6,*7,"<'",DPTX,"'> NOT ADDED"
 Q
DEL ;Delete logic
 N I,J,A,G,Q,ERR S Q="""",ERR=0 F I=0:0 S I=$O(^DD(2,0,"PT",I)) Q:'I  F J=0:0 S J=$O(^DD(2,0,"PT",I,J)) Q:'J  D
 .F K=0:0 S K=$O(^DD(I,+J,1,K)) Q:'K  S A=$G(^(K,0)) I $L($P(A,U,2)),'$L($P(A,U,3)) D
 ..S G=$G(^DIC(+I,0,"GL")) Q:'$L(G)  I $D(@(G_Q_$P(A,U,2)_Q_","_DA_")")) W !,"Entry in "_$P($G(^DIC(I,0)),U)_" ("_I_") refers to this patient" S ERR=1 Q
 I ERR
