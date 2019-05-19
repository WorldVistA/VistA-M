YS129PST ;SLC/LLH - Patch 129 post-init ; 03/20/2017
 ;;5.01;MENTAL HEALTH;**129**;Dec 30, 1994;Build 12
 ;
 ; This patch moves 13 instruments to "dropped" and updates the Scale Group name for 2 instruments
 ; so charting works better (there were additional Scale Group updates but those instruments are in patch 121)
 Q
 ;
 ;
EDTDATE ; date used to update 601.71:18
 ;;3170322.1321
 Q
 ;  
POST ; Post-init calls for patch 129
 N NM
 D GETSG
 D ADDIDX ; add indices for CESD -- Center for Epidemiologic Studies Depression Scale
 D PHQ9CT ; switch choices in PHQ9 to be 0-3 instead of 1-4
 ; drop tests:  note CIWA-AR was in this list, can't do as CIWA-AR- not released
 F NM="AUIR","CESD5","DOM80","DOMG","ERS","HLOC" D DROPTST(NM)
 F NM="IEQ","RLOC","SAI","SDES","SMAST","VALD","WAS" D DROPTST(NM)
 D UPDVER^YTQAPI7(3,"1.0.3.72") ; set MHA client version
 Q
 ;
GETSG ; Update Scale Group name
 N IDX,SGIEN,SGNM,TSTIEN,TSTNM
 S IDX=0 F  S IDX=IDX+1,TSTNM=$P($T(TESTS+IDX),";;",2) Q:TSTNM="zzzzz"  D
 .S TSTIEN=$O(^YTT(601.71,"B",TSTNM,0)) Q:'TSTIEN
 .S SGIEN=$O(^YTT(601.86,"AD",TSTIEN,0)) Q:'SGIEN
 .S SGNM=$P($T(TESTS+IDX),";;",3)
 .D UPDSG(SGIEN,SGNM) ; update Scale Group Name
 Q
 ;
UPDSG(SGIEN,SGNM) ; update Scale Group Name
 N FDA,DIERR
 S FDA(601.86,SGIEN_",",2)=SGNM
 D FILE^DIE("","FDA")
 I $D(DIERR) D BMES^XPDUTL("ERROR: "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 D CLEAN^DILF
 Q
 ;
ADDIDX ; add indices for CESD 
 N TSTIEN,SGIEN
 S TSTIEN=$O(^YTT(601.71,"B","CESD",0))
 I 'TSTIEN D BMES^XPDUTL("ERROR: "_$G(^TMP("DIERR",$J,1,"TEXT",1))),CLEAN^DILF
 S SGIEN=$O(^YTT(601.86,"AD",TSTIEN,0))
 I 'SGIEN D BMES^XPDUTL("ERROR: "_$G(^TMP("DIERR",$J,1,"TEXT",1))),CLEAN^DILF
 S ^YTT(601.86,"B",SGIEN,SGIEN)=""
 S ^YTT(601.86,"AD",TSTIEN,SGIEN)=""
 S ^YTT(601.86,"AC",TSTIEN,1,SGIEN)=""
 Q
 ;
DROPTST(NAME) ; Change OPERATIONAL to dropped, update LAST EDIT DATE
 N IEN
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 D FLD2DROP(IEN)
 Q
 ; 
FLD2DROP(IEN) ; update OPERATIONAL field to be "Dropped", LAST EDIT DATE
 N FDA,DIERR
 S FDA(601.71,IEN_",",10)="D"
 S FDA(601.71,IEN_",",18)=$P($T(EDTDATE+1),";;",2)
 D FILE^DIE("","FDA")
 I $D(DIERR) D MES^XPDUTL("ERROR: "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 D CLEAN^DILF
 Q
 ;
PHQ9CT ; update PHQ9 choice type
 N TEST,SEQ,CTNT,X0,X2,QSTN,CTYP,CID
 S TEST=$O(^YTT(601.71,"B","PHQ9",0))
 S SEQ=0 F  S SEQ=$O(^YTT(601.76,"AD",TEST,SEQ)) Q:'SEQ  D
 . S CTNT=0 F  S CTNT=$O(^YTT(601.76,"AD",TEST,SEQ,CTNT)) Q:'CTNT  D
 . . S X0=^YTT(601.76,CTNT,0),QSTN=$P(X0,U,4)
 . . S X2=^YTT(601.72,QSTN,2),CTYP=$P(X2,U,3)
 . . S CID=$O(^YTT(601.89,"B",CTYP,0)) Q:'CID
 . . N CHG S CHG(1)=0
 . . D UPDANY(601.89,CID,.CHG)
 . . K CHG S CHG(18)=$P($T(EDTDATE+1),";;",2)
 . . D UPDANY(601.71,TEST,.CHG)
 Q
UPDANY(FILEN,IEN,CHGS) ; update any MH record
 Q:FILEN<601  Q:FILEN>604  ; limit to MH files
 N FDA,DIERR
 M FDA(FILEN,IEN_",")=CHGS
 D FILE^DIE("","FDA")
 I $D(DIERR) D BMES^XPDUTL("ERROR: "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 D CLEAN^DILF
 K CHGS ; clean up for next call
 Q
 ;
TESTS ; Scale Group Names updated
 ;;AUDIT;;AUDIT Scale
 ;;PCL-5;;PCL-5 Scale
 ;;zzzzz
 ;
