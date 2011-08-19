EASEZI1 ;ALB/jap - Database Inquiry & Record Finder for 1010EZ Processing ;10/12/00  13:08
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**57,70**;Mar 15, 2001;Build 26
 ;continuation of EASEZI, split by patch 57 due to Max size limit
 ;
RESET ;
 ;set link in file #712 record
 N FDA,ERR
 S FDA(712,EASAPP_",",3.4)=DFN
 I NEW D
 . S FDA(712,EASAPP_",",3.5)=NEW
 D FILE^DIE("","FDA","ERR")
 ;
 W !,"One moment please...",!
 S EASDFN=DFN
 ;setup tmp array for data mapping
 D LOCAL711^EASEZU2
 I '$G(EASVRSN) S EASVRSN=$$VERSION^EASEZU4(EASAPP)
 ;if applicant is new to database, user accept/not accept of data elements is constrained; 
 ;if applicant is new to VistA, mark all data elements 'accepted';
 I NEW S N=0 F  S N=$O(^EAS(712,EASAPP,10,N)) Q:'N  I $G(^EAS(712,EASAPP,10,N,1))'="" D
 . S ACCEPT="",FLD="",SUBFILE="",FILE=""
 . S KEYIEN=$P(^EAS(712,EASAPP,10,N,0),U,1)
 . I KEYIEN S X=$G(^TMP("EZDATA",$J,KEYIEN)),FILE=$P(X,U,1),SUBFILE=$P(X,U,2),FLD=$P(X,U,3),DATAKEY=$P(X,U,4),SECT=$P(DATAKEY,";",1)
 . I FLD S ACCEPT=1
 . I 'FLD S ACCEPT=-1
 . I (FILE=355.33)!(FILE>408) S ACCEPT=2
 . I FILE=2,SUBFILE=2,((FLD=.01)!(FLD=.03)!(FLD=.09)!(FLD=.531)) S ACCEPT=-1
 . I ((SUBFILE=2.01)!(SUBFILE=2.101)) S ACCEPT=-1
 . I (EASVRSN>5.99),((SECT="IIC")!(SECT="IIE")) D
 . . S QUES=$P(DATAKEY,";",2)
 . . ;EAS*1.0*70 -- added up-arrows on next two lines
 . . I SECT="IIC","^1.6^2.3^3.3^"[("^"_QUES_"^") S ACCEPT=-1 Q
 . . I SECT="IIE","^1.3^2.3^3.3^"[("^"_QUES_"^") S ACCEPT=-1
 . S $P(^EAS(712,EASAPP,10,N,0),U,3)=ACCEPT
 ;for applicants matched to existing patients check for 
 ; verified eligibility and appt request on 1010 app
 I 'NEW D
 . K ARRAY
 . S DA=EASDFN,DIC="^DPT(",DR=".3611;.3613;1010.159;1010.1511"
 . S DIQ(0)="I",DIQ="ARRAY"
 . D EN^DIQ1
 . I ARRAY(2,EASDFN,.3611,"I")="V",ARRAY(2,EASDFN,.3613,"I")="H" S ELIGVER=1
 . I ARRAY(2,EASDFN,1010.159,"I")'="",ARRAY(2,EASDFN,1010.1511,"I")'="" S APPTVER=1
 ;correlate #712 data with mapping array
 S N=0 F  S N=$O(^EAS(712,EASAPP,10,N)) Q:'N  S X=^(N,0) D
 . ;don't set array node if no 1010EZ data
 . S EZDATA=$P($G(^EAS(712,EASAPP,10,N,1)),U,1)
 . Q:EZDATA=""
 . S IEN=$P(X,U,1),MULTIPLE=$P(X,U,2),ACCEPT=$P(X,U,3)
 . S ^TMP("EZDATA",$J,IEN,MULTIPLE,1)=EZDATA_U_ACCEPT_U_N
 ;
 ;if applicant new to VistA, stop here;
 I NEW S EASEZNEW=1
 Q:$G(EASEZNEW)
 ;if matched to existing patient, get all iens needed
 W !,"Preparing for data comparison to VistA Patient database...",!
 K ALIAS,DISPOS,ENROLL,INCREL,RACE,ETHNC
 D I201^EASEZI(EASDFN,.ALIAS) W "."
 I $D(ALIAS)>1 D C201^EASEZC1
 D I2101^EASEZI(EASDFN,.DISPOS) W "."
 I $D(DISPOS)>1 D C2101^EASEZC1
 ;finish getting the rest of file #2 data needed for comparison 
 D C2^EASEZC1
 D I2711^EASEZI(EASDFN,.ENROLL) W "."
 I $D(ENROLL)>1 D C2711^EASEZC1
 D I408^EASEZI(EASDFN,EASAPP,.INCREL) W "."
 I $D(INCREL)>1 D C408^EASEZC1
 D I202^EASEZI(EASDFN,.RACE) W "."
 I $D(RACE)>1 D C202^EASEZC3
 D I206^EASEZI(EASDFN,.ETHNC) W "."
 I $D(ETHNC)>1 D C206^EASEZC3
 ;set file #355.33 data to 'always accept';
 ;set unmatched data for files #408.12, #408.13, #408.21, #408.22 to 'always accept';
 S N=0 F  S N=$O(^EAS(712,EASAPP,10,N)) Q:'N  S X=^(N,0) D
 . S KEYIEN=$P(X,U,1),MULTIPLE=$P(X,U,2)
 . I KEYIEN S X=$G(^TMP("EZDATA",$J,KEYIEN)),FILE=$P(X,U,1),SUBFILE=$P(X,U,2),FLD=$P(X,U,3),DATAKEY=$P(X,U,4),SECT=$P(DATAKEY,";",1)
 . S ACCEPT=""
 . I 'FLD S ACCEPT=-1
 . I FILE=2,SUBFILE=2,((FLD=.01)!(FLD=.03)!(FLD=.09)!(FLD=.531)) S ACCEPT=-1
 . ;set certain eligibility related data elements to 'never accept' if eligibility verified
 . I FILE=2,FLD=.313,$G(ARRAY(2,EASDFN,.3611,"I"))="V" S ACCEPT=-1
 . I FILE=2,$G(ELIGVER),((FLD=.301)!(FLD=.302)!(FLD=.36235)) S ACCEPT=-1
 . ;set appt requested element to 'never accept' if already exist
 . I FILE=2,$G(APPTVER),FLD=1010.159 S ACCEPT=-1
 . ;EAS*1.0*70 -- accept Country
 . I FILE=2,(FLD=.1173) S ACCEPT=1
 . I FILE=355.33 S ACCEPT=2
 . I FILE>408 S ACCEPT=2
 . I (EASVRSN>5.99),((SECT="IIC")!(SECT="IIE")) D
 . . S QUES=$P(DATAKEY,";",2)
 . . ;EAS*1.0*70 -- added the up-arrows on next two lines
 . . I SECT="IIC","^1.6^2.3^3.3^"[("^"_QUES_"^") S ACCEPT=-1 Q
 . . I SECT="IIE","^1.3^2.3^3.3^"[("^"_QUES_"^") S ACCEPT=-1
 . S $P(^EAS(712,EASAPP,10,N,0),U,3)=ACCEPT
 . S $P(^TMP("EZDATA",$J,KEYIEN,MULTIPLE,1),U,2)=ACCEPT
 K ALIAS,DISPOS,ENROLL,INCREL
 Q
 ;
