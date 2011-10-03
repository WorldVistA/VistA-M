ORY110 ;SLC/DAN--Clean up orderable items file ;1/4/02  13:57
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**110**;Dec 17, 1997
 N IEN,DIK,IEN6,COUNT
 K ^ORD(101.43,"B") ;Delete "B" cross reference to be rebuilt below
 D MES^XPDUTL("Re-indexing the B cross reference of the SYNONYM field...")
 S IEN=0 F  S IEN=$O(^ORD(101.43,IEN)) Q:'+IEN  D
 .I $G(^ORD(101.43,IEN,0))="" K ^ORD(101.43,IEN) Q  ;Delete extraneous nodes when 0 node doesn't exist
 .I $O(^ORD(101.43,IEN,2,0)) K ^ORD(101.43,IEN,2,"B") S DIK="^ORD(101.43,IEN,2,",DIK(1)=".01^B",DA(1)=IEN D ENALL^DIK ;Reset "B" cross reference for synonym multiple
 ;
 K DIK,DA
 D MES^XPDUTL("Re-indexing the B cross reference of the ORDERABLE ITEMS file")
 S DIK="^ORD(101.43,",DIK(1)=".01^B" D ENALL^DIK ;Rebuild B cross reference at the file level
 ;
 D BMES^XPDUTL("Reviewing ORDER DIALOG file for incorrect pointer default values.")
 S IEN=0 F  S IEN=$O(^ORD(101.41,IEN)) Q:'+IEN  I $D(^(IEN,6)) D
 .S IEN6=0 F  S IEN6=$O(^ORD(101.41,IEN,6,IEN6)) Q:'+IEN6  I $L($G(^(IEN6,1)),"^")>1 S ^ORD(101.41,IEN,6,IEN6,1)=$P(^ORD(101.41,IEN,6,IEN6,1),"^"),COUNT=$G(COUNT)+1
 D MES^XPDUTL("Finished."_$S($G(COUNT)>0:" Fixed "_$G(COUNT)_" node"_$S($G(COUNT)>1:"s.",1:"."),1:""))
 ;
 S ZTRTN="DQ^ORY110",ZTDTH=$H,ZTDESC="Patch OR*3*110 ORDER file cleanup",ZTSAVE("DUZ")="",ZTIO="" D ^%ZTLOAD
 D MES^XPDUTL("Starting ORDER file clean-up job in the background.  Task # "_+$G(ZTSK))
 Q
 ;
DQ ;Entry point for background job to clean up ORDER file
 N IEN,SUB,COUNT
 S IEN=$$GETIEN(3010826.24)-1 ;get first IEN for date, subtract one so first IEN is reviewed
 I IEN=-1 D MAIL Q
 F  S IEN=$O(^OR(100,IEN)) Q:'+IEN  D
 .S SUB=0 F  S SUB=$O(^OR(100,IEN,.1,SUB)) Q:'+SUB  D
 ..I $L($G(^(SUB,0)),"^")>1 D
 ...N DIK,DA
 ...K ^OR(100,IEN,.1,"B",$G(^OR(100,IEN,.1,SUB,0))) ;delete current B xref
 ...S ^OR(100,IEN,.1,SUB,0)=$P(^OR(100,IEN,.1,SUB,0),"^") ;remove extra pieces
 ...S DIK="^OR(100,IEN,.1,",DIK(1)=".01^B" ;set index to be reset and global node
 ...S DA=SUB,DA(1)=IEN ;DA is subfile IEN, DA(1) is file level IEN
 ...D EN1^DIK ;Set B xref for this entry
 ...Q
 .S SUB=0 F  S SUB=$O(^OR(100,IEN,4.5,SUB)) Q:'+SUB  D
 ..I $L($G(^(SUB,1)),"^")>1 S ^(1)=$P(^(1),"^"),COUNT=$G(COUNT)+1 ;remove extra pieces, count changes
 ;
 D MAIL ;Send mail notification upon completion
 Q
 ;
GETIEN(STDT) ;Find first IEN associated with given start date
 N DONE,IEN
 S (DONE,IEN)=0
 F  S STDT=$O(^OR(100,"AF",STDT)) Q:'+STDT!(DONE)  D
 .S IEN=0 F  S IEN=$O(^OR(100,"AF",STDT,IEN)) Q:'+IEN  I $O(^(IEN,0))=1 S DONE=1 Q  ;Find first ORDER that is a new order
 Q IEN
 ;
MAIL ;Send email when finished
 N XMSUB,XMTEXT,XMDUZ,ORTXT,XMY
 S XMDUZ="Patch OR*3*110 Post-Init"
 S XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 S ORTXT(1)="The ORDER file clean-up initiated by patch OR*3*110 has completed."
 S ORTXT(2)=""
 S ORTXT(3)="There were "_$S($G(COUNT):COUNT,1:"no")_" changes made to the ORDER file."
 S XMTEXT="ORTXT("
 S XMSUB="Patch OR*3*110 ORDER file clean-up completed."
 D ^XMD
 Q
