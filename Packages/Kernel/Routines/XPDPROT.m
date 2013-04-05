XPDPROT ;SFISC/RWF,RSD - Manage Protocol Items ;05/24/2010
 ;;8.0;KERNEL;**547**;Jul 10, 1995;Build 15
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;PARENT=Protocol to add to,  CHILD=Protocol to add to PARENT, MNE=Mnemonic (1-4 characters)
 ;SEQ=Sequence (number from 1 - 999)
ADD(PARENT,CHILD,MNE,SEQ) ;EF. Add Child to Item multiple of Parent
 Q:$G(PARENT)']"" 0 Q:$G(CHILD)']"" 0
 N X,XPD1,XPD2,XPD3,DIC,DIE,DA,D0,DR,DLAYGO
 S XPD1=$$LKPROT(PARENT) Q:XPD1'>0 "0^parent protocol not found"
 ;quit if type is not menu,protocol,protocol menu, limited protocol, or extended action
 I "MOQLX"'[$E($$TYPE(XPD1)_"^",1) Q "0^wrong type"
 S XPD2=$$LKPROT(CHILD) Q:XPD2'>0 "0^child protocol not found"
 ;if protocol is not in ITEM, add it
 I '$D(^ORD(101,XPD1,10,"B",XPD2)) D
 .S X=XPD2,(D0,DA(1))=XPD1,DIC(0)="MLF",DIC("P")=$P(^DD(101,10,0),"^",2),DLAYGO=101,DIC="^ORD(101,"_XPD1_",10,"
 .D FILE^DICN
 S XPD3=$O(^ORD(101,XPD1,10,"B",XPD2,0))
 I XPD3>0 S DR="" S:$G(MNE)]"" DR="2///"_$G(MNE)_";" S:+$G(SEQ)>0 DR=DR_"3///"_+$G(SEQ) I DR]"" S DIE="^ORD(101,"_XPD1_",10,",DA=XPD3,DA(1)=XPD1 D ^DIE
 Q XPD3>0
 ;
LKPROT(X) ;EF.  To lookup on "B"
 Q $O(^ORD(101,"B",X,0))
 ;
TYPE(X) ;EF. Return protocol type, Pass IFN.
 Q:X'>0 "" Q $P($G(^ORD(101,X,0)),"^",4)
 ;
 ;PARENT=Protocol to delete from,  CHILD=protocol to delete from PARENT
DELETE(PARENT,CHILD) ;EF. Delete entry from ITEM multiple
 Q:$G(PARENT)']"" 0 Q:$G(CHILD)']"" 0
 N XPD1,XPD2,DIK,DA,X
 S XPD1=$$LKPROT(PARENT) Q:XPD1'>0 "0^parent protocol not found"
 I "MOQLX"'[$E($$TYPE(XPD1)_"^",1) Q "0^wrong type"
 S XPD2=$$LKPROT(CHILD) Q:XPD2'>0 "0^child protocol not found"
 S DA=$O(^ORD(101,XPD1,10,"B",XPD2,0)) Q:DA'>0 0
 S DA(1)=XPD1,DIK="^ORD(101,XPD1,10," D ^DIK
 Q 1
 ;
 ;PROT=protocol to disable,  TXT=message or @ to delete existing value
OUT(PROT,TXT) ;Disable protocol
 Q:$G(PROT)']""
 N XPD,XPD1
 S XPD1=$$LKPROT(PROT) Q:XPD1'>0
 S XPD(101,XPD1_",",2)=$G(TXT) D FILE^DIE("","XPD")
 Q
 ;
 ;OLD=old name, NEW=new name
RENAME(OLD,NEW) ;Rename protocol
 Q:$G(OLD)']""  Q:$G(NEW)']""
 N XPD,XPD1
 S XPD1=$$LKPROT(OLD) Q:XPD1'>0
 S XPD(101,XPD1_",",.01)=NEW D FILE^DIE("","XPD")
 Q
FIND(RESULT,PROT) ;Find all parents for PROT
 ;  Input: RESULT - Results array name, passed by reference (req)
 ;           PROT - name of protocol (req)
 ;   Output: RESULT(0)= number of parents found
 ;                      OR
 ;                      -1 ^ error message
 ;RESULT(FILE 101 ien)= parent protocol name (FILE 101, Field .01)
 ;
 I $G(PROT)']"" S RESULT(0)="-1^protocol not defined" Q
 N XPD1,XPDCNT,XPDIEN
 S XPD1=$$LKPROT(PROT)
 I XPD1'>0 S RESULT(0)="-1^protocol not found" Q
 S (XPDCNT,XPDIEN)=0
 F  S XPDIEN=$O(^ORD(101,"AD",XPD1,XPDIEN)) Q:'XPDIEN  D
 .S RESULT(XPDIEN)=$P($G(^ORD(101,XPDIEN,0)),U,1),XPDCNT=XPDCNT+1
 S RESULT(0)=XPDCNT
 Q
