IBCEPCID ;ALB/WCJ - Provider ID functions ;13 Feb 2006
 ;;2.0;INTEGRATED BILLING;**320**;21-MAR-94
 ;; Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 G AWAY
AWAY Q
 ;
COPY(IBINS) ;  The purpose of this routine is to sync up insurance company IDs
 ; It is passed an insurance company.  If the insurance company is a stand alone company,
 ; it quits.  If it is passed a child, it synchs up with the parent.  If it is passed a parent, it syncs
 ; up with all it's children.
 ; 
 ; The IDs that synched up are Provider ID's defined for providers by an insurance company, default IDs for all
 ; Providers for and an insurance company, and additonal billing providers IDs for an insuracne company.
 ; 
 ;
 N TYPE,PARENT,CHILD,COPYINS
 Q:$G(IBINS)=""
 S TYPE=$$TYPE(IBINS)
 Q:TYPE=""
 I TYPE="P" S PARENT=IBINS,CHILD=""
 I TYPE="C" S CHILD=IBINS,PARENT=$P($G(^DIC(36,IBINS,3)),U,14) Q:PARENT=""
 D COPYTO(PARENT,CHILD,.COPYINS)
 D LOOPTRNS(.COPYINS)
 Q
 ;
TYPE(IBINS) ;
 Q $P($G(^DIC(36,+IBINS,3)),U,13)
 ;
COPYTO(PARENT,CHILD,COPYINS) ; Figure out who to copy to:
 I CHILD]"" S COPYINS(PARENT,CHILD)="" Q
 F  S CHILD=$O(^DIC(36,"APC",PARENT,CHILD)) Q:'CHILD   S COPYINS(PARENT,CHILD)=""
 Q
 ;
LOOPTRNS(COPYINS) ;
 N PARENT,CHILD,IBFILE
 S PARENT=$O(COPYINS(""))
 Q:PARENT=""   ; just in case
 ;
 S CHILD=""  F  S CHILD=$O(COPYINS(PARENT,CHILD)) Q:CHILD=""  D
 .F IBFILE=355.9,355.91,355.92 D
 .. I IBFILE=355.9 D  Q
 ... N IBPRV,CU,FT,CT,QUAL,CDA,PDA
 ... ;
 ... ; File 355.9
 ... ; Delete IDs in child but not parent
 ... ; Edit IDs that are in both 
 ... S IBPRV="" F  S IBPRV=$O(^IBA(IBFILE,"AUNIQ",IBPRV)) Q:IBPRV=""  D
 .... Q:IBPRV'[";VA(200,"    ; only copying VA providers
 .... Q:'$D(^IBA(IBFILE,"AUNIQ",IBPRV,CHILD))
 .... S CU="" F  S CU=$O(^IBA(IBFILE,"AUNIQ",IBPRV,CHILD,CU)) Q:CU=""  D
 ..... S FT="" F  S FT=$O(^IBA(IBFILE,"AUNIQ",IBPRV,CHILD,CU,FT)) Q:FT=""  D
 ...... S CT=""  F  S CT=$O(^IBA(IBFILE,"AUNIQ",IBPRV,CHILD,CU,FT,CT)) Q:CT=""  D
 ....... S QUAL=""  F  S QUAL=$O(^IBA(IBFILE,"AUNIQ",IBPRV,CHILD,CU,FT,CT,QUAL)) Q:QUAL=""  D
 ........ S CDA=$O(^IBA(IBFILE,"AUNIQ",IBPRV,CHILD,CU,FT,CT,QUAL,0))
 ........ Q:'CDA
 ........ I '$D(^IBA(IBFILE,"AUNIQ",IBPRV,PARENT,CU,FT,CT,QUAL)) D DEL(IBFILE,CDA) Q
 ........ S PDA=$O(^IBA(IBFILE,"AUNIQ",IBPRV,PARENT,CU,FT,CT,QUAL,0))
 ........ Q:PDA=""
 ........ D MOD(IBFILE,CDA,PDA) Q
 ... ;
 ... ; File 355.9
 ... ; Add IDs in parent but not child
 ... S IBPRV="" F  S IBPRV=$O(^IBA(IBFILE,"AUNIQ",IBPRV)) Q:IBPRV=""  D
 .... Q:IBPRV'[";VA(200,"    ; only copying VA providers
 .... Q:'$D(^IBA(IBFILE,"AUNIQ",IBPRV,PARENT))
 .... S CU="" F  S CU=$O(^IBA(IBFILE,"AUNIQ",IBPRV,PARENT,CU)) Q:CU=""  D
 ..... S FT="" F  S FT=$O(^IBA(IBFILE,"AUNIQ",IBPRV,PARENT,CU,FT)) Q:FT=""  D
 ...... S CT=""  F  S CT=$O(^IBA(IBFILE,"AUNIQ",IBPRV,PARENT,CU,FT,CT)) Q:CT=""  D
 ....... S QUAL=""  F  S QUAL=$O(^IBA(IBFILE,"AUNIQ",IBPRV,PARENT,CU,FT,CT,QUAL)) Q:QUAL=""  D
 ........ S PDA=$O(^IBA(IBFILE,"AUNIQ",IBPRV,PARENT,CU,FT,CT,QUAL,0))
 ........ Q:'PDA
 ........ I '$D(^IBA(IBFILE,"AUNIQ",IBPRV,CHILD,CU,FT,CT,QUAL)) D ADD(IBFILE,PDA,CHILD) Q
 .. ;
 .. ; Files 355.91 and 355.92
 .. ; Delete IDs in Child but not parent
 .. ; Edit IDs that are in both
 .. I $D(^IBA(IBFILE,"AUNIQ",CHILD)) D
 ... N CU,FT,CTORD,QUAL,PDA,CDA,DELFL
 ... S CU="" F  S CU=$O(^IBA(IBFILE,"AUNIQ",CHILD,CU)) Q:CU=""  D
 .... S FT="" F  S FT=$O(^IBA(IBFILE,"AUNIQ",CHILD,CU,FT)) Q:FT=""  D
 ..... S CTORD=""  F  S CTORD=$O(^IBA(IBFILE,"AUNIQ",CHILD,CU,FT,CTORD)) Q:CTORD=""  D
 ...... S QUAL=""  F  S QUAL=$O(^IBA(IBFILE,"AUNIQ",CHILD,CU,FT,CTORD,QUAL)) Q:QUAL=""  D
 ....... S CDA=""  F  S CDA=$O(^IBA(IBFILE,"AUNIQ",CHILD,CU,FT,CTORD,QUAL,CDA)) Q:CDA=""  D
 ........ S PDA=$O(^IBA(IBFILE,"AUNIQ",PARENT,CU,FT,CTORD,QUAL,0))
 ........ S DELFL=1
 ........ I PDA,IBFILE=355.91,$D(^IBA(IBFILE,"AUNIQ",PARENT,CU,FT,CTORD,QUAL)) S DELFL=0
 ........ I PDA,IBFILE=355.92 S DELFL=0
 ........ D:DELFL DEL(IBFILE,CDA)
 ........ D:'DELFL MOD(IBFILE,CDA,PDA)
 .. ;
 .. ; Files 355.91 and 355.92
 .. ; Add IDs that are in parent but not child
 .. I $D(^IBA(IBFILE,"AUNIQ",PARENT)) D
 ... N CU,FT,CTORD,QUAL,PDA
 ... S CU="" F  S CU=$O(^IBA(IBFILE,"AUNIQ",PARENT,CU)) Q:CU=""  D
 .... S FT="" F  S FT=$O(^IBA(IBFILE,"AUNIQ",PARENT,CU,FT)) Q:FT=""  D
 ..... S CTORD=""  F  S CTORD=$O(^IBA(IBFILE,"AUNIQ",PARENT,CU,FT,CTORD)) Q:CTORD=""  D
 ...... S QUAL=""  F  S QUAL=$O(^IBA(IBFILE,"AUNIQ",PARENT,CU,FT,CTORD,QUAL)) Q:QUAL=""  D
 ....... S PDA="" F  S PDA=$O(^IBA(IBFILE,"AUNIQ",PARENT,CU,FT,CTORD,QUAL,PDA)) Q:PDA=""  D
 ........ Q:$O(^IBA(IBFILE,"AUNIQ",CHILD,CU,FT,CTORD,QUAL,0))
 ........ D ADD(IBFILE,PDA,CHILD) Q
 Q
 ;
ADD(IBFILE,IEN,INS) ; Add a provider ID
 N DIC,DIR,X,Y,Z,DA,DR,DIE,DO,DD,DLAYGO,DTOUT,DUOUT
 N ZERO,CU,FT,CTORD,QUAL,ID
 S ZERO=$G(^IBA(IBFILE,IEN,0))
 Q:ZERO=""
 S CU=$P(ZERO,U,3)
 S FT=$P(ZERO,U,4)
 S CTORD=$P(ZERO,U,5)
 S QUAL=$P(ZERO,U,6)
 S ID=$P(ZERO,U,7)
 ;
 I IBFILE=355.91!(IBFILE=355.92) D
 . S X=INS
 . S DIC("DR")=".03////"_CU_";.04////"_FT_";.05////"_CTORD_";.06////"_QUAL_";.07////"_ID
 . I IBFILE=355.92 S DIC("DR")=DIC("DR")_";.08////A"
 ;
 I IBFILE=355.9 D
 . S DIC("DR")=".02////"_INS_";.03////"_CU_";.04////"_FT_";.05////"_CTORD_";.06////"_QUAL_";.07////"_ID
 . S X=$P(ZERO,U)
 ;
 S DIC(0)="L",(DIC,DLAYGO)=IBFILE
 D FILE^DICN
 Q
 ;
DEL(IBFILE,DA) ; Delete a Provider ID
 N DIK,DIR,X,Y,Z,I
 S DIK="^IBA("_IBFILE_","
 F I=1:1 L +^IBA(IBFILE,DA):5 I  Q
 D ^DIK
 L -^IBA(IBFILE,DA)
 Q
 ;
MOD(IBFILE,IEN,PIEN) ; Modify an existing Provider ID
 N I,ZERO,ID,PID,PZERO,FDAROOT
 S ZERO=$G(^IBA(IBFILE,IEN,0))
 Q:ZERO=""
 S PZERO=$G(^IBA(IBFILE,PIEN,0))
 Q:PZERO=""
 S ID=$P(ZERO,U,7)
 S PID=$P(PZERO,U,7)
 Q:ID=PID
 S FDAROOT(IBFILE,IEN_",",.07)=PID
 F I=1:1 L +^IBA(IBFILE,IEN):5 I  Q
 D FILE^DIE(,"FDAROOT")
 L -^IBA(IBFILE,IEN)
 Q
 ;
RESYNCH() ; Resynch everything
 L +^DIC(36):5 E  W *7,!!,"Can not lock insurance company file, please try later.",!! Q
 N INS
 S INS="" F  S INS=$O(^DIC(36,"APC",INS)) Q:INS=""  D COPY(INS)
 L -^DIC(36)
 Q
