XPDUTL1 ;SFISC/RWF - KIDS utilities (Delete pointers) ;10/28/2002  09:33
 ;;8.0;KERNEL;**229**;Jul 10,1995
 Q
 ;New with patch 229
 ;DELPTR will go thru all the files that point to a given file and
 ;delete any pointer to a set of deleted entries.
 ;FILE is the file number that the entries are being deleted from.
 ;DELRT is the closed root of an array of IEN values being deleted.
 ;SKIP is an array of files to skip from deleting
DELPTR(FILE,DELRT,SKIP) ;
 N DA,FDA,IENS,PFL,PFE,EXE
 S PFL=0
 F  S PFL=$O(^DD(FILE,0,"PT",PFL)),PFE=0 Q:PFL'>0  D
 . I $D(SKIP(PFL)) Q  ;Skip this File
 . F  S PFE=$O(^DD(FILE,0,"PT",PFL,PFE)) Q:PFE'>0  D
 . . D BUILD(PFL,PFE) Q
 . Q
 Q
 ;
BUILD(FL,FE) ;BUILD and Execute SCAN
 N DIC,CNT,FLD,LV,EX,ND,QUIT
 S LV=0,EX=0,QUIT=0,FLD=$G(^DD(FL,FE,0)) Q:'$L(FLD)
 ;Get the pointing field
 S EX(LV,1)=FLD,FLD(0)=$P(FLD,"^",4),FLD(1)=$P(FLD(0),";"),FLD(2)=$P(FLD(0),";",2)
 S EX(LV,2)=FLD(1) ;Save the node
 ;find the path to this field
 S DIC=$$PATH(LV+1,FL,FE) ;Leave EX as global
 I QUIT Q  ;Couldn't build the path
 ;Build the code to check this pointer value
 S ND=FLD(1)
 S EX(LV)="S X=$P($G("_DIC_"ND)),U,"_FLD(2)_") I $L(X),$D(@DELRT@(X)) S IEN=$$IENS^DILF(.DA),CNT=CNT+1,FDA("_PFL_",IEN,"_PFE_")=""@"" D:CNT>10 FILE^XPDUTL1"
 ;Run the scan
 D SCAN
 Q
 ;
PATH(LV,FL,FE) ;Return path to node
 N DIC,DA,FLD,FL2,FE2
 ;At the root of the file
 S DA=$S(LV>1:"DA("_(LV-1)_")",1:"DA")
 I $D(^DIC(FL,0,"GL")) D  Q DIC_DA_","
 . S DIC=$G(^DIC(FL,0,"GL"))
 . S EX(LV,1)=DIC,EX=LV
 . S EX(LV)="S "_DA_"=0 F  S "_DA_"=$O("_DIC_DA_")) Q:"_DA_"'>0  X EX("_(LV-1)_")"
 . Q
 ;In a sub-file
 S FL2=$G(^DD(FL,0,"UP")) I 'FL2 S QUIT=1 Q ""
 S FE2=$O(^DD(FL2,"SB",FL,0)) I 'FE2 S QUIT=1 Q ""
 S FLD=$G(^DD(FL2,FE2,0)),FLD(0)=$P(FLD,"^",4),FLD(1)=$P(FLD(0),";"),FLD(2)=$P(FLD(0),";",2)
 S ND(LV)=FLD(1) ;Use a variable for nodes
 S DIC=$$PATH(LV+1,FL2,FE2)_"ND("_LV_"),"_DA
 S EX(LV,1)=DIC
 S EX(LV)="S "_DA_"=0 F  S "_DA_"=$O("_DIC_")) Q:"_DA_"'>0  X EX("_(LV-1)_")"
 Q DIC_","
 ;
SCAN ;Manage the scan of a file
 N CNT,DA,FDA
 S CNT=0
 X EX(EX)
 I CNT>0 D FILE
 Q
FILE ;File a FDA
 N MSG S CNT=0
 D FILE^DIE("KS","FDA","MSG")
 ;I $D(MSG) ZW MSG ;***DEBUG***
 Q
 ;
DELIEN(FL,RT) ;Delete the iens in RT from file FL
 N DA,DIK,XPDI
 S DIK=$G(^DIC(FL,0,"GL")),XPDI=0 Q:'$L(DIK)
 F  S XPDI=$O(@RT@(XPDI)) Q:'XPDI  S DA=XPDI D ^DIK
 Q
 ;
