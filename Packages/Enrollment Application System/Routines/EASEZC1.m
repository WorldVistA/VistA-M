EASEZC1 ;ALB/jap - Compare 1010EZ Data with VistA Database ;10/16/00  13:08
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**1,51**;Mar 15, 2001
 ;
EN(EASAPP,EASDFN) ;this entry point is called as soon as user has selected an Application
 ;
 ;input  
 ;  EASAPP = application ien in file #712
 ;  EASDFN = ien in file #2; if 0, then application not yet linked to file #2
 ;output
 ;  ^TMP("EZDATA"  where
 ;  ^TMP("EZDATA",$J,ien_file711)=file#^subfile#^field#^data_id
 ;  ^TMP("EZDATA",$J,ien_file711,multiple,1)=ezdata^accept_flag^subien_subfile712.01
 ;  ^TMP("EZDATA",$J,ien_file711,multiple,2)=vista_data^link_ien
 ;
 N IEN,KEY,SUBIEN,ACCEPT,FFF,LINK,MULTIPLE,ORIG,UPD,X,Y,C2711KEY
 ;don't continue if passed in dfn doesn't match link
 I $G(EASDFN),$P($G(^EAS(712,EASAPP,0)),U,10)'=EASDFN S EASDFN="" Q
 ;don't continue if link to file #2 not available
 I '$G(EASDFN) S EASDFN=+$P($G(^EAS(712,EASAPP,0)),U,10)
 ;if applicant is new to database, user accept/not accept of data elements is constrained 
 S EASEZNEW=$P(^EAS(712,EASAPP,0),U,11)
 ;display/file/print varies with version
 S EASVRSN=$$VERSION^EASEZU4(EASAPP)  ;alb/cmf/51
 ;
 ; setup local mapping array
 D LOCAL711^EASEZU2
 ;need this for later
 S C2711KEY=+$$KEY711^EASEZU1("TYPE OF BENEFIT-ENROLLMENT")
 ;correlate #712 data with tmp mapping array
 S SUBIEN=0 F  S SUBIEN=$O(^EAS(712,EASAPP,10,SUBIEN)) Q:'SUBIEN  D
 .S X=^EAS(712,EASAPP,10,SUBIEN,0)
 .S (IEN,KEY)=$P(X,U,1),MULTIPLE=$P(X,U,2),ACCEPT=$P(X,U,3),FFF=$P(^TMP("EZDATA",$J,IEN),U,1,3)
 .S X=$G(^EAS(712,EASAPP,10,SUBIEN,1)),ORIG=$P(X,U,1),UPD=$P(X,U,2)
 .;if link exists, it is pointer to Vista database record for an existing patient
 .;  or possibly a 'new' patient (i.e., this applicant's data), if this is done post filing
 .S LINK=$P($G(^EAS(712,EASAPP,10,SUBIEN,2)),U,2)
 .;eliminate some garbage from web app
 .I (ORIG="-")!(ORIG="--")!(ORIG="//") S ORIG=""
 .Q:((ORIG="")&(UPD=""))
 .I UPD="" S ^TMP("EZDATA",$J,IEN,MULTIPLE,1)=ORIG_U_ACCEPT_U_SUBIEN
 .E  S ^TMP("EZDATA",$J,IEN,MULTIPLE,1)=UPD_U_ACCEPT_U_SUBIEN
 .;if this applicant is new to VistA database, there is no existing patient data for comparison
 .;just pickup name,ssn,dob anyway;
 .I EASEZNEW,EASDFN D
 ..S F=$P(FFF,U,1),SF=$P(FFF,U,2),FD=$P(FFF,U,3)
 ..I F=2,SF=2 I (FD=.01)!(FD=.02)!(FD=.03)!(FD=.09) S LINK=EASDFN
 ..K F,SF,FD
 .;if link to database exists then get VistA data into tmp array
 .I 'LINK,$P(FFF,U,1)=2 S LINK=EASDFN
 .I LINK D
 ..S X=$$GET(LINK,FFF) S:X=-1 X="" S ^TMP("EZDATA",$J,IEN,MULTIPLE,2)=X_U_LINK
 ..;special for file #27.11 (Enrollment) data
 ..I KEY=C2711KEY D 
 ...S CUR=$P($G(^EAS(712,EASAPP,10,SUBIEN,2)),U,2)
 ...D ENR(CUR,.VDATA) K CUR
 ...S ^TMP("EZDATA",$J,IEN,MULTIPLE,2)=VDATA_U_LINK K VDATA
 ..I $G(^TMP("EZDATA",$J,IEN,MULTIPLE,1))="" S ^TMP("EZDATA",$J,IEN,MULTIPLE,1)=U_ACCEPT_U_SUBIEN
 D C206^EASEZC3  ;alb/cmf/51 special for ethnicity multiple
 D C202^EASEZC3  ;alb/cmf/51 special for race multiple
 ;set 'transformed' data into ^TMP("EZDISP" array
 D SORT^EASEZC3(EASAPP)
 Q
 ;
GET(EASLINK,EASFFF) ;get data from existing Patient database
 ;input EASLINK  = IEN(s) needed
 ;              format: file_ien;subfile_ien
 ;       EASFFF = field # for file or subfile
 ;              format: file#^subfile#^field#
 ;output RTR = data obtained from Patient database; external format;
 ;             OR -1 if invalid input
 ;
 N FILE,SUBFILE,FIELD,RTR,ARRAY,DA,DR,DIC,DIQ,X,Y
 S FILE=$P(EASFFF,U,1),SUBFILE=$P(EASFFF,U,2),FIELD=$P(EASFFF,U,3)
 I ('FILE)!('FIELD) Q -1
 I SUBFILE,SUBFILE'=FILE,EASLINK'[";" Q -1
 I EASLINK[";",SUBFILE="" Q -1
 ;
 I (SUBFILE="")!(SUBFILE=FILE) D
 .;data in main file
 .S DIQ="ARRAY",DIQ(0)="E",DA=EASLINK,DR=FIELD,DIC=FILE
 .D EN^DIQ1
 .S RTR=$G(ARRAY(FILE,EASLINK,FIELD,"E"))
 I SUBFILE'="",SUBFILE'=FILE D
 .;data in subfile
 .;in this case EASLINK = file_ien;subfile_ien
 .S DIQ="ARRAY",DIQ(0)="E",DA=$P(EASLINK,";",1),DIC=FILE
 .;get field # for subfile
 .S DR=$O(^DD(FILE,"SB",SUBFILE,0))
 .S DR(SUBFILE)=FIELD,DA(SUBFILE)=$P(EASLINK,";",2)
 .D EN^DIQ1
 .S RTR=$G(ARRAY(SUBFILE,$P(EASLINK,";",2),FIELD,"E"))
 Q RTR
 ;
 ;
C2 ;get data from file #2 into local array L711
 ;there are alot of fields; quickest just to order thru local mapping file
 ;
 N KEY,MAP,VDATA,EASAEL
 ;2nd subscript for array is always 1 (no multiples)
 S KEY=0 F  S KEY=$O(^TMP("EZDATA",$J,KEY)) Q:'KEY  S MAP=^TMP("EZDATA",$J,KEY) I ($P(MAP,U,1)=2)&($P(MAP,U,2)=2) D
 .S EASAEL=$P($G(^TMP("EZDATA",$J,KEY,1,1)),U,3)
 .S VDATA=$$GET(EASDFN,MAP)
 .Q:VDATA=-1  Q:VDATA=""
 .;special handling for field #.362
 .I ($P(MAP,U,1)=5)="I;14D3." D
 ..I VDATA["IN LIEU OF VA COMP" S VDATA="YES"
 ..I VDATA="YES, RECEIVING MILITARY RETIREMENT" S VDATA="NO"
 .;ien to #711 is 1st subscript of local array is 
 .S ^TMP("EZDATA",$J,KEY,1,2)=VDATA
 .;if data exists in 1010EZ then insert link to file #2
 .I EASAEL D LINKUP^EASEZU1(EASAPP,EASAEL,EASDFN)
 .;if data does not exist in 1010EZ add subrecord to hold link
 .I 'EASAEL D ADD71201^EASEZU1(EASAPP,KEY,EASDFN,1)
 Q
 ;
C201 ;get data in Alias subfile #2.01 into local array L711
 ;  using ien(s) local array ALIAS
 ;
 ;for Alias name(s) - if other name on 1010EZ doesn't match any on file
 ;   then it will be auto-accepted; comparision only with matching name if any.
 N X,M,B,ADATA,VDATA,KEY,EASAEL
 S KEY=+$$KEY711^EASEZU1("APPLICANT OTHER NAME")
 S M=0 F  S M=$O(^TMP("EZDATA",$J,KEY,M)) Q:'M  D
 .S ADATA=$P(^TMP("EZDATA",$J,KEY,M,1),U,1)
 .S B=0 F  S B=$O(ALIAS(B)) Q:'B  D
 ..S VDATA=$$GET(ALIAS(B),^TMP("EZDATA",$J,KEY)) Q:VDATA=-1
 ..I VDATA=ADATA D
 ...S ^TMP("EZDATA",$J,KEY,M,2)=VDATA
 ...S EASAEL=$P(^TMP("EZDATA",$J,KEY,M,1),U,3)
 ...;only insert link if data exists in 1010EZ
 ...I EASAEL D LINKUP^EASEZU1(EASAPP,EASAEL,ALIAS(B))
 Q
 ;
C2101 ;get data in Disposition subfile #2.101 into local array L711
 ;  using ien(s) local array DISPOS
 ;
 ;display data on most recent registration if any
 ;2nd subscript of local array always 1 (no multiples)
 N B,X,FLD,KEY,ADATA,VDATA,EASAEL
 S FLD=0 F  S FLD=$O(^TMP("EZINDEX","A",2,2.101,FLD)) Q:FLD=""  D
 .S KEY=$O(^TMP("EZINDEX","A",2,2.101,FLD,0))
 .S ADATA=$G(^TMP("EZDATA",$J,KEY,1,1))
 .S VDATA=$$GET(DISPOS(1),^TMP("EZDATA",$J,KEY))
 .Q:VDATA=-1  Q:VDATA=""
 .S ^TMP("EZDATA",$J,KEY,1,2)=VDATA
 .S EASAEL=$P($G(^TMP("EZDATA",$J,KEY,1,1)),U,3)
 .;if data exists in 1010EZ then insert link
 .I EASAEL D LINKUP^EASEZU1(EASAPP,EASAEL,DISPOS(1)) Q
 .;if data does not exist in 1010EZ add subrecord to hold link
 .I 'EASAEL D ADD71201^EASEZU1(EASAPP,KEY,DISPOS(1),1)
 Q
 ;
C2711 ;get data in Current Enrollment #27.11 into local array L711
 ;  using ien(s) local array ENROLL
 ;
 ;2nd subscript of local array always 1 (no multiples)
 N X,M,B,ADATA,CUR,DGENR,VDATA,KEY,EASAEL
 S KEY=+$$KEY711^EASEZU1("TYPE OF BENEFIT-ENROLLMENT")
 S CUR=$G(ENROLL(1)),VDATA=""
 Q:CUR=-1
 Q:CUR=""
 D ENR(CUR,.VDATA)
 S ^TMP("EZDATA",$J,KEY,1,2)=VDATA
 S EASAEL=$P($G(^TMP("EZDATA",$J,KEY,1,1)),U,3)
 ;if data exists in 1010EZ then insert link
 I EASAEL D LINKUP^EASEZU1(EASAPP,EASAEL,CUR)
 ;if data does not exist in 1010EZ add subrecord to hold link
 I 'EASAEL D ADD71201^EASEZU1(EASAPP,KEY,CUR,1)
 Q
 ;
ENR(CUR,VDATA) ;get data for current enrollment from VistA database
 ;input CUR = pointer to file #27.11
 N DGENCAT
 S VDATA=""
 I $$GET^DGENA(CUR,.DGENR) D
 .I $G(DGENR("STATUS"))=10!($G(DGENR("STATUS"))=19)!($G(DGENR("STATUS"))=20) D  Q
 ..S VDATA=$S($G(DGENR("STATUS")):$$EXT^DGENU("STATUS",DGENR("STATUS")),1:"")
 .S DGENCAT=$$CATEGORY^DGENA4(+EASDFN)
 .S DGENCAT=$$EXTERNAL^DILFD(27.15,.02,"",DGENCAT)
 .S VDATA=$S($G(DGENR("PRIORITY")):$$EXT^DGENU("PRIORITY",DGENR("PRIORITY")),1:"")
 .S VDATA=VDATA_$S($G(DGENR("SUBGRP"))="":"",1:$$EXT^DGENU("SUBGRP",$G(DGENR("SUBGRP"))))
 .S VDATA=VDATA_" | "_DGENCAT
 Q
 ;
C408 ;get data from financial files into tmp mapping array
 ;  using ien(s) local array INCREL
 ;if no iens for veteran then nothing at all; exit
 I $G(INCREL(408,"V",1))="" Q
 ;link EZ applicant to veteran data
 D A408^EASEZC2
 ;link EZ spouse to spouse data
 D SP408^EASEZC2
 ;link EZ child to child/dependent data
 D C1N408^EASEZC2
 Q
