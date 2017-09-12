IVM2152P ;ALB/LBD - Patch IVM*2*152 Post-Install Routine ; 3/28/12 1:36pm
 ;;2.0;INCOME VERIFICATION MATCH;**152**;21-OCT-94;Build 4
 ;
 ;This routine will add new entries to the IVM DEMOGRAPHIC UPLOAD
 ;FIELDS file #301.92
 Q
 ;
EP ;Entry point - Driver
 N ABORT,FILE,I,ELEMNT,EXIST,IVMDATA,DATA,SUB,J,VALUE,FILEFLG,DIERR,ERROR
 ;
 S (ABORT,FILEFLG)=0,FILE=301.92
 F I=1:1 S ELEMNT=$P($T(TEXT+I),";;",2) Q:ELEMNT="QUIT"!(ABORT)  D
 . S EXIST=0
 . K IVMDATA S (DATA,SUB)="" F J=1:1:$L(ELEMNT,";") S DATA=$P(ELEMNT,";",J) D  Q:EXIST
 . . S SUB=$P(DATA,"~",1),VALUE=$P(DATA,"~",2),IVMDATA(SUB)=VALUE
 . . I SUB=.01 S EXIST=$$FIND1^DIC(FILE,,,IVMDATA(.01))
 . I 'EXIST D
 . . S FILEFLG=$$ADD(FILE,.IVMDATA)
 . . I FILEFLG D MES^XPDUTL("Added - "_$G(IVMDATA(.01)))
 . . I 'FILEFLG D
 . . . S ABORT=1,XPDABORT=2
 . . . D BMES^XPDUTL("Install process could not add an entry in file for "_$G(IVMDATA(.01)))
 . . . D BMES^XPDUTL("                        <<<< INSTALLATION ABORTED >>>>")
 I 'ABORT D BMES^XPDUTL("<<<< Post Install Successful >>>>")
 Q
 ;
ADD(FILE,DATA) ;
 ;Description: Creates a new record and files the data.
 ; Input:
 ;   FILE - File or sub-file number
 ;   DATA - Data array to file, pass by reference
 ;          Format: DATA(<field #>)=<value>
 ;
 ; Output:
 ;   Function Value - If no error then it returns the ien of the created record, else returns NULL.
 ;
 N FDA,FIELD,IEN,IENA,IENS,IVMDA,ERRORS
 ;
 ;IENS - Internal Entry Number String defined by FM
 ;IENA - the Internal Entry Number Array defined by FM
 ;FDA - the FDA array defined by FM
 ;IEN - the ien of the new record
 ;
 S IVMDA="+1"
 S IENS=$$IENS^DILF(.IVMDA)
 S FIELD=0
 F  S FIELD=$O(DATA(FIELD)) Q:'FIELD  D
 .S FDA(FILE,IENS,FIELD)=$G(DATA(FIELD))
 I $G(IEN) S IENA(1)=IEN
 D UPDATE^DIE("","FDA","IENA","ERRORS(1)")
 I +$G(DIERR) D
 .S ERROR=$G(ERRORS(1,"DIERR",1,"TEXT",1))
 .S IEN=""
 E  D
 .S IEN=IENA(1)
 .S ERROR=""
 D CLEAN^DILF
 Q IEN
 ;
TEXT ;;FIELD#~VALUE;FIELD#~VALUE;FIELD#~VALUE.....
 ;;.01~RESIDENCE NUMBER CHANGE DT/TM;.02~RF171P;.03~1;.04~2;.05~.1321;.06~1;.07~1;.08~1;10~S DR=.1321 D LOOK^IVMPREC9;20~S DR=.1321 D LOOK^IVMPREC9
 ;;.01~RESIDENCE NUMBER CHANGE SOURCE;.02~RF162P;.03~1;.04~2;.05~.1322;.06~1;.07~1;.08~1;10~S DR=.1322 D LOOK^IVMPREC9;20~S DR=.1322 D LOOK^IVMPREC9
 ;;.01~RESIDENCE NUMBER CHANGE SITE;.02~RF161P;.03~1;.04~2;.05~.1323;.06~1;.07~1;.08~1;10~S DR=.1323 D LOOK^IVMPREC9;20~S DR=.1323 D LOOK^IVMPREC9
 ;;QUIT
