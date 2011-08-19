XPDIA3 ;SFISC/RWF - Install Pre/Post Actions for Kernel files cont. ;6/22/06  09:13
 ;;8.0;KERNEL;**201,302,393,498**;Jul 10, 1995;Build 13
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;^XTMP("XPDI",,XPDA,"KRN",XPDFILE,OLDA) is the global root
 ;XPDNM=package name, XPDA=ien in ^XPD(9.6,
 ;DA=ien in file, OLDA= ien in ^XTMP
 ;
PAR0F2 ;PARAMETER file 8989.5: post.  This is a fake entry called from the post of file 8989.51
 ;Now load any entries from 8989.5
 N XP1,XP2,XP3,DIK,OLDA,DA,ERR,PN,PE,PT,ROOT
 S XP1=$O(^XTMP("XPDI",XPDA,"PKG",0)) ;Get the package
 Q:'XP1  S PN=$G(^XTMP("XPDI",XPDA,"PKG",XP1,0))
 S PE=$$FIND1^DIC(9.4,,"MX",$P(PN,U,2)) ;Get the IEN of the package
 S OLDA=0,ROOT=$NA(^XTMP("XPDI",XPDA,"KRN",8989.5))
 F  S OLDA=$O(@ROOT@(OLDA)) Q:'OLDA  D
 . S XP1=@ROOT@(OLDA,0)
 . S $P(XP1,U,1)=PE_";DIC(9.4," ;entity
 . S $P(XP1,U,2)=$$LK^XPDIA($NA(^XTV(8989.51)),$P(XP1,U,2))
 . S DA=$$LKPAR($P(XP1,U),$P(XP1,U,2),$P(XP1,U,3))
 . ;Remove the current entry if we have one
 . I DA>0 S DIK="^XTV(8989.5," D ^DIK
 . ;Otherwise Add the zero node, See that we have a IEN
 . I DA'>0 D ADDPAR($P(XP1,U),$P(XP1,U,2),$P(XP1,U,3)) S DA=$$LKPAR($P(XP1,U),$P(XP1,U,2),$P(XP1,U,3))
 . Q:'DA  ;don't have a entry
 . ;Merge the date ;with IHS fix
 . M ^XTV(8989.5,DA)=^XTMP("XPDI",XPDA,"KRN",8989.5,OLDA)
 . S ^XTV(8989.5,DA,0)=XP1 ;zero node with new pointers
 . ;Get Definition and check if Data Type is pointer, then get pointed to global ref.
 . S PT=$G(^XTV(8989.51,+$P(XP1,U,2),1)) D:$P(PT,U)="P"
 . . S XP3=$G(^XTV(8989.5,DA,1)),PT=$P(PT,U,2)
 . . S:PT $P(XP3,U)=$$FIND1^DIC(PT,"","X",$P(XP3,U)) ;resolve pointer value
 . . S:$P(XP3,U) ^XTV(8989.5,DA,1)=XP3
 . ;X-ref it
 . S DIK="^XTV(8989.5," D IX1^DIK
 Q
 ;
LKPAR(ENT,PAR,INST) ;Lookup an entry
 Q $O(^XTV(8989.5,"AC",PAR,ENT,INST,0))
 ;
ADDPAR(ENT,PAR,INST) ;Add a parameter instance
 N FDA,FDAIEN,DIERR
 S FDA(8989.5,"+1,",.01)=ENT
 S FDA(8989.5,"+1,",.02)=PAR
 S FDA(8989.5,"+1,",.03)=INST
 D UPDATE^DIE("","FDA","FDAIEN","DIERR")
 Q
 ;
PAR1F1 ;PARAMETER File 8989.51: file Pre
 Q
PAR1E1 ;PARAMETER file 8989.51: entry pre
 N XP1,XP2,XP3
 S ^TMP($J,"XPD",DA)=""
 ;if there is a new Description, kill the old Description
 K:$O(^XTMP("XPDI",XPDA,"KRN",8989.51,OLDA,20,0)) ^XTV(8989.51,DA,20)
 ;Kill any old Allowable entries
 K:$O(^XTMP("XPDI",XPDA,"KRN",8989.51,OLDA,30,0)) ^XTV(8989.51,DA,30)
 Q
PAR1F2 ;PARAMETER file 8989.51: file post
 N XPD,DIK,DA
 S DA=0
 F  S DA=$O(^TMP($J,"XPD",DA)) Q:'DA  D
 . S DIK="^XTV(8989.51," D IX1^DIK
 D PAR0F2 ;Go load the entries from 8989.5
 Q
PAR1DEL(RT) ;Delete Parameter Def entries
 D DELPTR^XPDUTL1(8989.51,RT) ;Cleanup pointers
 D DELIEN^XPDUTL1(8989.51,RT) ;Cleanup entries
 Q
 ;
PAR2F1 ;PARAMETER File 8989.52: file Pre
 K ^TMP($J,"XPD")
 Q
PAR2E1 ;PARAMETER file 8989.52: entry Pre
 N XP1,XP2,ROOT
 S ROOT=$NA(^XTMP("XPDI",XPDA,"KRN",8989.52))
 S XP2=$P(@ROOT@(OLDA,0),U,4) ;Use instance of
 ;Because we change the transport global see that a restart will work
 I $L(XP2),XP2?1A.E S $P(@ROOT@(OLDA,0),U,4)=$$LK^XPDIA($NA(^XTV(8989.51)),XP2)
 S XP1=0
 F  S XP1=$O(@ROOT@(OLDA,10,XP1)),XP2="" Q:'XP1  D
 . S XP2=$P(@ROOT@(OLDA,10,XP1,0),U,2) ;Parameter
 . I $L(XP2),XP2?1A.E S $P(@ROOT@(OLDA,10,XP1,0),U,2)=$$LK^XPDIA($NA(^XTV(8989.51)),XP2)
 . Q
 Q
PAR2F2 ;PARAMETER file 8989.52: file Post
 Q
PAR2DEL(RT) ;Delete Parameter Templates
 D DELIEN^XPDUTL1(8989.52,RT)
 Q
