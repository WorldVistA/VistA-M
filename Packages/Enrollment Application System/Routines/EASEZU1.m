EASEZU1 ;ALB/jap - Utilities for 1010EZ Processing ;10/12/00  13:08
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;;Mar 15, 2001
 ;
KEY711(EASKEY) ;get file #711 record associated with key
 ;input  EASKEY = character string equal to a 1010EZ Assigned Data Name OR Data Key
 ;output KEYIEN = pointer to file #711 for the 1010EZ data element is 1st piece;
 ;                format: ien^Assigned Data Name^Data Key
 ;                returns ".1" if EASKEY is invalid, i.e., data element is unknown
 ;
 N N,KEYIEN,X,XX,Y,DA,DIE,DR
 S KEYIEN=""
 ;key passed in is Data Key
 I EASKEY[".",EASKEY[";" D
 .S KEYIEN=$O(^EAS(711,"C",EASKEY,0)) Q:'KEYIEN
 .S X=$P(^EAS(711,KEYIEN,0),U,1)
 .S KEYIEN=KEYIEN_U_X_U_EASKEY
 ;key passed in is Assigned Data Name
 I KEYIEN="" D
 .S KEYIEN=$O(^EAS(711,"AB",EASKEY,0)) Q:'KEYIEN
 .S X=$P(^EAS(711,KEYIEN,0),U,2)
 .S KEYIEN=KEYIEN_U_EASKEY_U_X
 I KEYIEN="" S KEYIEN=".1"
 Q KEYIEN
 ;
DATA712(EASAPP,EASKEY,EASMM) ;get 1010EZ data associated with data key
 ;input  EASAPP  = ien to #712 for Application
 ;       EASKEY  = IEN to file #711;
 ;                 OR KEYIEN returned by KEY711^EASEZU1
 ;       EASMM   = multiple number; default is 1; optional
 ;                 pertains to data elements that may be multiple,
 ;                 i.e., additional child dependents
 ;                 
 ;output    RTR  = piece 1 - 1010EZ data associated with Data Key for this Application;
 ;                 piece 2 - subrecord ien associated with Data Key for this Application;
 ;                 returns ^ if data item not found in this Application
 ;
 N N,OUT,KEYIEN,MULTIPLE,X,RTR,IN,UP
 I '$D(^EAS(712,EASAPP,0)) Q U
 ;this is the "unknown" data element
 I EASKEY=.1 Q U
 I '$G(EASMM) S EASMM=1
 S KEYIEN=+EASKEY
 S OUT=0,N=0,X="",RTR=U
 F  S N=$O(^EAS(712,EASAPP,10,"B",KEYIEN,N)) Q:'N  D  Q:OUT
 .S MULTIPLE=$P($G(^EAS(712,EASAPP,10,N,0)),U,2)
 .I MULTIPLE=EASMM D
 ..;use 'updated' data if present
 ..S X=$G(^EAS(712,EASAPP,10,N,1)),IN=$P(X,U,1),UP=$P(X,U,2)
 ..S RTR=$S(UP'="":UP,1:IN),RTR=RTR_U_N,OUT=1
 Q RTR
 ;
LINKUP(EASAPP,EASAEL,EASLINK) ;place link into a file #712 Data Element subrecord
 ;input  EASAPP  = ien to #712 for Application
 ;       EASAEL  = ien to Data Elements subrecord in #712
 ;       EASLINK = file ien OR file_ien;subfile_ien to link 1010EZ data
 ;                 with existing Patient database record
 ;exit if record/subrecord not valid in #712
 N DA,DR,DIE,X,Y
 Q:'EASAPP  Q:'$D(^EAS(712,EASAPP,0))
 Q:'EASAEL  Q:'$D(^EAS(712,EASAPP,10,EASAEL,0))
 ;place link in Data Element subrecord of #712
 S DA(1)=EASAPP,DA=EASAEL,DR(1)=10
 S DIE="^EAS(712,EASAPP,10,"
 S DR="2.1///^S X=EASLINK;"
 D ^DIE
 Q
 ;
ADD71201(EASAPP,KEYIEN,LINK,MULTIPLE) ;add another subrecord to #712.01
 ;used in cases where Patient data exists but 1010EZ data does not;
 ;this new subrecord will hold the VistA database ien(s)
 ;
 ;input EASAPP = ien to file #712
 ;      KEYIEN = ien to file #711 for data element
 ;      LINK   = ien(s) in VistA database;
 ;               format: ien_main_file;ien_subfile
 ;      MULTIPLE = default is 1; (optional)
 ;                 currently only needed for additional child dependents
 ;                 associated with Section IIB of the form.
 ;output NEWIEN = ien to new subrecord in sibfile #712.01
 N NEWIEN,LASTIEN,DA,DIC,DIE,DR,DLAYGO,DINUM,X,Y
 Q:'KEYIEN
 Q:LINK=""
 S LASTIEN=$O(^EAS(712,EASAPP,10,9999),-1),NEWIEN=LASTIEN+1
 ;create subrecord
 S DIC="^EAS(712,EASAPP,10,",DIC(0)="L",DLAYGO="",X=KEYIEN,DINUM=NEWIEN
 S DA(1)=EASAPP,DIC("P")=$P(^DD(712,10,0),U,2)
 K DD,DO D FILE^DICN
 ;file data element link
 S DIE="^EAS(712,EASAPP,10,",DA=NEWIEN,DA(1)=EASAPP,DR(1)="10;"
 S MULTIPLE=$G(MULTIPLE) S:'MULTIPLE MULTIPLE=1
 S DR=".1///^S X=MULTIPLE;2.1///^S X=LINK;"
 D ^DIE
 Q
 ;
GETANY(EASAPP,EASDFN,EASAEL,EASKEY) ;get data from VistA database for any field related to 1010EZ
 ;input  EASAPP  = ien to #712 for Application
 ;       EASDFN  = ien to #2 for Applicant
 ;       either EASAEL or EASKEY must be non-null
 ;       EASAEL  = ien to Data Elements subrecord in #712; optional
 ;       EASKEY  = data key from Data Elements subrecord in #712; optional
 ;
 ;output     RTR = data obtained from Patient database; external format
 ;                 OR -1 if invalid input
 ;
 ;the "link" below is a pointer (ien) to file or subfile record that
 ; was previously found to contain data which potentially matches
 ; 1010EZ data 
 ;
 N X,LINK,N,FILE,SUBFILE,FIELD,ARRAY,DIQ,DA,DR,DIC,RTR
 S EASKEY=$G(EASKEY),N=0
 I 'EASAEL,EASKEY="" Q -1
 I 'EASAEL,EASKEY'="" D
 .S EASAEL=$P($$DATA712(EASAPP,EASKEY),U,2) Q:'EASAEL
 .S N=$O(^EAS(711,"C",EASKEY,0))
 I EASKEY="",EASAEL S N=$P($G(^EAS(712,EASAPP,10,EASAEL,0)),U,1)
 I 'N Q -1
 ;database parameters in #711
 S X=$G(^EAS(711,N,1)),FILE=$P(X,U,1),SUBFILE=$P(X,U,2),FIELD=$P(X,U,3)
 ;get link ien if other than file #2
 S LINK=$P($G(^EAS(712,EASAPP,10,EASAEL,2)),U,2)
 ;if data location is main file #2, then link is dfn
 I FILE=2,(SUBFILE=2!SUBFILE="") S LINK=EASDFN
 ;
 ;if no link to database, quit
 I 'LINK Q -1
 ;otherwise setup FM call & use link to get data
 I (SUBFILE="")!(SUBFILE=FILE) D
 .;data in main file
 .S DIQ="ARRAY",DIQ(0)="E",DA=LINK,DR=FIELD,DIC=FILE
 .D EN^DIQ1
 .S RTR=$G(ARRAY(FILE,LINK,FIELD,"E"))
 I SUBFILE'="",SUBFILE'=FILE D
 .;data in subfile
 .;in this case LINK = file_ien;subfile_ien
 .S DIQ="ARRAY",DIQ(0)="E",DA=$P(LINK,";",1),DIC=FILE
 .;get field # for subfile
 .S DR=$O(^DD(FILE,"SB",SUBFILE,0))
 .S DR(SUBFILE)=FIELD,DA(SUBFILE)=$P(LINK,";",2)
 .D EN^DIQ1
 .S RTR=$G(ARRAY(SUBFILE,$P(LINK,";",2),FIELD,"E"))
 Q RTR
