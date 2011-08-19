HDISVF05 ;ALB/RMO - 7115.6 File Utilities/API Cont.; 1/11/05@2:37:00
 ;;1.0;HEALTH DATA & INFORMATICS;;Feb 22, 2005
 ;
 ;---- Begin HDIS File/Field file (#7115.6) API(s) ----
 ;
ADDFFNM(HDISFILN,HDISFLDN,HDISFIEN,HDISERRM) ;Add a New File/Field Entry
 ; Input  -- HDISFILN File Number
 ;           HDISFLDN Field Number  (Optional- Default .01)
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISFIEN  HDIS File/Field file IEN
 ;           If Failure:
 ;           HDISERRM  Error Message  (Optional)
 N HDISFDA,HDISFFNM,HDISIEN,HDISMSG,HDISOKF
 ;Initialize output
 S (HDISFIEN,HDISERRM)=""
 ;Check for missing variable, exit if not defined
 I $G(HDISFILN)'>0 D  G ADDFFNMQ
 . S HDISERRM="Required Variable Missing."
 ;Set Field Number to default of .01, if needed
 S HDISFLDN=$S('$D(HDISFLDN):.01,1:HDISFLDN)
 ;Set File/Field Name to file#~field# (i.e. 10.3~.01)
 S HDISFFNM=HDISFILN_"~"_HDISFLDN
 ;Check for existing File Number and Field Number, return error and exit if it exists
 I $D(^HDIS(7115.6,"AFIL",HDISFILN,HDISFLDN)) D  G ADDFFNMQ
 . S HDISERRM="File Number and Field Number already exists."
 ;Set array for File/Field Name, File Number and Field Number
 S HDISFDA(7115.6,"+1,",.01)=$G(HDISFFNM)
 S HDISFDA(7115.6,"+1,",.02)=$G(HDISFILN)
 S HDISFDA(7115.6,"+1,",.04)=$G(HDISFLDN)
 D UPDATE^DIE("E","HDISFDA","HDISIEN","HDISMSG")
 ;Check for error
 I $D(HDISMSG("DIERR")) D
 . S HDISERRM=$G(HDISMSG("DIERR",1,"TEXT",1))
 ELSE  D
 . S HDISFIEN=+$G(HDISIEN(1))
 . S HDISOKF=1
 D CLEAN^DILF
ADDFFNMQ Q +$G(HDISOKF)
 ;
GETIEN(HDISFILN,HDISFLDN,HDISFIEN) ;Get IEN for a File/Field by File Number and Field Number
 ; Input  -- HDISFILN File Number
 ;           HDISFLDN Field Number  (Optional- Default .01)
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISFIEN  HDIS File/Field file IEN
 ;Initialize output
 S HDISFIEN=""
 ;Check for missing variable, exit if not defined
 I $G(HDISFILN)'>0 G GETIENQ
 ;Set Field Number to .01 default if needed
 S HDISFLDN=$S('$D(HDISFLDN):.01,1:HDISFLDN)
 ;Check for entry by File Number and Field Number
 S HDISFIEN=$O(^HDIS(7115.6,"AFIL",HDISFILN,HDISFLDN,0))
GETIENQ Q +$S($G(HDISFIEN)>0:1,1:0)
 ;
GETFF(HDISFIEN,HDISFILN,HDISFLDN) ;Get File Number and Field Number for a File/Field by IEN
 ; Input  -- HDISFIEN  HDIS File/Field file IEN
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISFILN File Number
 ;           HDISFLDN Field Number
 N HDIS0
 ;Initialize output
 S (HDISFILN,HDISFLDN)=""
 ;Check for missing variable, exit if not defined
 I $G(HDISFIEN)'>0 G GETFFQ
 ;Check for File Number and Field Number by IEN
 I $D(^HDIS(7115.6,HDISFIEN,0)) S HDIS0=$G(^(0)) D
 . S HDISFILN=$P(HDIS0,"^",2)
 . S HDISFLDN=$P(HDIS0,"^",4)
GETFFQ Q +$S($G(HDISFILN)'=""&($G(HDISFLDN)'=""):1,1:0)
 ;
 ;---- End HDIS File/Field file (#7115.6) API(s) ----
