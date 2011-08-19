DIPOS104 ;SFISC/SO,GFT-POST INSTALL ROUTINE FOR PATCH DI*22.0*104 ;5:37 AM  5 Jun 2002
 ;;22.0;VA FileMan;**104**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
BEGIN ;
 S X="Checking Audit File for bad dates..."
 N DATE,CDATE,IEN,DIA
 D MES^XPDUTL(X)
 F DIA=0:0 S DIA=$O(^DIA(DIA)) Q:'DIA  D
 .S DATE=2700000 F  S DATE=$O(^DIA(DIA,"C",DATE)) Q:'DATE  I DATE?8N D
 ..F IEN=0:0 S IEN=$O(^DIA(DIA,"C",DATE,IEN)) Q:'IEN  K ^(IEN) D
 ...I $P($G(^DIA(DIA,IEN,0)),"^",2)=DATE D
 ....N X,X1,X2
 ....S X1=$E(DATE,1,7),X2=1
 ....D C^%DTC
 ....S CDATE=X
 ...S $P(^DIA(DIA,IEN,0),"^",2)=CDATE,^DIA(DIA,"C",CDATE,IEN)=""
 S X="Finished checking for bad dates."
 D MES^XPDUTL(X)
 Q
