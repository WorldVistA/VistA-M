DG696PST ;BAY/JAT;cleanup of combat vet field on file 46.1
 ;;5.3;Registration;**696*;Aug 13,1993
 ;
 ; This is a post-init routine for DG*5.3*696
 ; The purpose is to rewrite each entry that has a value in 
 ; field .08 of file #46.1 by replacing "Y" with "1" and "N" with 0.
 ;
EN ;
 D BMES^XPDUTL("Updating file #46.1")
 N DGIEN,DGSET,FDATA,DIERR
 S DGIEN=0
 F  S DGIEN=$O(^DGICD9(46.1,DGIEN)) Q:'DGIEN  D
 .Q:$P($G(^DGICD9(46.1,DGIEN,0)),U,8)=""
 .S DGSET=""
 .I $P(^DGICD9(46.1,DGIEN,0),U,8)="Y" S DGSET=1
 .I $P(^DGICD9(46.1,DGIEN,0),U,8)="N" S DGSET=0
 .S FDATA(46.1,DGIEN_",",.08)=DGSET
 .D FILE^DIE("","FDATA","DIERR")
 K FDATA,DIERR
 Q
