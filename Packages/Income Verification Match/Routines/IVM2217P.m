IVM2217P ;ALB/KUM - PATCH IVM*2*217 POST-INSTALL ROUTINE ;30 July 2025 10:36 AM
 ;;2.0;INCOME VERIFICATION MATCH;**217**;Oct 21, 1994;Build 3
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ICRs:
 ; Reference to BMES^XPDUTL supported by ICR #10141
 ; Reference to MES^XPDUTL supported by ICR #10141
 ;
 ; This routine will add new entries to the IVM DEMOGRAPHIC UPLOAD
 ; FIELDS file #301.92
 Q
 ;
ENV ;Main entry point for Environment check
 Q
 ;
PRE ;Main entry point for Pre-Install items
 ;
 Q
POST ;Main entry point for Post-Install items
 ;
 D BMES^XPDUTL(">>> Beginning the IVM*2.0*217 Post-install routine...")
 D POST1
 D BMES^XPDUTL(">>> Patch IVM*2.0*217 - Post-install complete.")
 Q
 ;
POST1 ;Adding entries 
 N IVMABRT,IVMFIL,I,IVMELE,EXIST,IVMDATA,DATA,SUB,J,VALUE,FILEFLG,DIERR,IVMERR,IEN,NAME,ERR,IVMCT
 ;
 S (IVMABRT,FILEFLG)=0,IVMFIL=301.92,IVMCT=0
 D MES^XPDUTL("Adding entries into the IVM DEMOGRAPHIC UPLOAD FIELDS (#301.92) file:")
 F I=1:1 S IVMELE=$P($T(TEXT+I),";;",2) Q:IVMELE="QUIT"!(IVMABRT)  D
 . S EXIST=0
 . K IVMDATA S (DATA,SUB)="" F J=1:1:$L(IVMELE,";") S DATA=$P(IVMELE,";",J) D
 . . S SUB=$P(DATA,"~",1),VALUE=$P(DATA,"~",2),IVMDATA(SUB)=VALUE
 . . I SUB=.01 S EXIST=$$FIND1^DIC(IVMFIL,,,IVMDATA(.01))
 . I EXIST D
 . . S NAME=IVMDATA(.01)
 . . S IEN=EXIST_","
 . . S FDA(301.92,IEN,.01)="@"
 . . D UPDATE^DIE("E","FDA","","ERR")
 . . I $D(ERR("DIERR")) D BMES^XPDUTL("    Error in deleting field "_NAME) Q
 . . D BMES^XPDUTL(NAME_" deleted to recreate with correct IEN number  ")
 . . S EXIST=0
 . . Q
 . I 'EXIST D
 . . S FILEFLG=$$ADD(IVMFIL,.IVMDATA)
 . . I FILEFLG D MES^XPDUTL("Added - "_$G(IVMDATA(.01)))
 . . I 'FILEFLG D
 . . . S IVMABRT=1
 . . . D BMES^XPDUTL("Install process could not add an entry in file for "_$G(IVMDATA(.01)))
 . . . D BMES^XPDUTL("                        <<<< INSTALLATION ABORTED >>>>")
 I 'IVMABRT D BMES^XPDUTL("<<<< Post Install Successful >>>>")
 Q
 ;
ADD(IVMFIL,DATA) ;
 ;Description: Creates a new record and files the data.
 ; Input:
 ;   IVMFIL - File or sub-file number
 ;   DATA - Data array to file, pass by reference
 ;          Format: DATA(<field #>)=<value>
 ;
 ; Output:
 ;   Function Value - If no error then it returns the ien of the created record, else returns NULL.
 ;
 N FDA,FIELD,IEN,IENA,IENS,IVMDA,IVMERRS
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
 .S FDA(IVMFIL,IENS,FIELD)=$G(DATA(FIELD))
 I $G(IEN) S IENA(1)=IEN
 D UPDATE^DIE("","FDA","IENA","IVMERRS(1)")
 I +$G(DIERR) D
 .S IVMERR=$G(IVMERRS(1,"DIERR",1,"TEXT",1))
 .S IEN=""
 E  D
 .S IEN=IENA(1)
 .S IVMERR=""
 D CLEAN^DILF
 Q IEN
 ;
TEXT ;;FIELD#~VALUE;FIELD#~VALUE;FIELD#~VALUE.....
 ;;.01~CONFIDENTIAL PHONE NUMBER;.02~PID13CA;.03~1;.04~2;.05~.1315;.06~1;.07~1;.08~1;10~S DR=.1315 D LOOK^IVMPREC9;20~S DR=.1315 D LOOK^IVMPREC9
 ;;.01~CONF PHONE CHANGE DT/TM;.02~RF171CP;.03~1;.04~2;.05~.14121;.08~1;10~S DR=.14121 D LOOK^IVMPREC9;20~S DR=.14121 D LOOK^IVMPREC9
 ;;.01~CONF PHONE CHANGE SOURCE;.02~RF162CP;.03~1;.04~2;.05~.14122;.08~1;10~S DR=.14122 D LOOK^IVMPREC9;20~S DR=.14122 D LOOK^IVMPREC9
 ;;.01~CONF PHONE CHANGE SITE;.02~RF161CP;.03~1;.04~2;.05~.14123;.08~1;10~S DR=.14123 D LOOK^IVMPREC9;20~S DR=.14123 D LOOK^IVMPREC9
 ;;QUIT
