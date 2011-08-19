EASEZC2 ;ALB/jap - Compare 1010EZ Data with VistA Database ;10/16/00  13:08
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**1,51,70**;Mar 15, 2001;Build 26
 ;
A408 ;get applicant financial data from VistA
 N IENS,IEN,B,FF,FILE,SUBF,FLD,MAP,VDATA,KEY,EASAEL
 S IENS=$G(INCREL(408,"V",1))
 Q:IENS=""
 ;associate each ien with file/subfile
 S B=0 F FF=408.12,2,408.21,408.22 D
 . S B=B+1,IEN=+$P(IENS,U,B)
 . Q:'IEN  Q:FF=2
 . S (FILE,SUBF)=FF
 . S FLD=0 F  S FLD=$O(^TMP("EZINDEX",$J,"A",FILE,SUBF,FLD)) Q:FLD=""  D
 . . S MAP=FILE_U_SUBF_U_FLD
 . . ;get patient database data
 . . S VDATA=$$GET^EASEZC1(IEN,MAP)
 . . ;store link in all 1010EZ elements associated with this file/subfile
 . . ;store patient data in tmp array and link in subfile #712.01; KEY is ien to file #711
 . . S KEY=0 F  S KEY=$O(^TMP("EZINDEX",$J,"A",FILE,SUBF,FLD,KEY)) Q:'KEY  D
 . . . S ^TMP("EZDATA",$J,KEY,1,2)=VDATA
 . . . S EASAEL=$P($G(^TMP("EZDATA",$J,KEY,1,1)),U,3)
 . . . I EASAEL D LINKUP^EASEZU1(EASAPP,EASAEL,IEN)
 . . . I 'EASAEL,VDATA'="" D ADD71201^EASEZU1(EASAPP,KEY,IEN,1)
 Q
 ;
SP408 ;get spouse financial data from VistA
 ;
 N B,TYPE,MAP,M,MM,NSD,OUT,X,IEN,IENS,KEY,FILE,FF,FFF,FLD,SUBF,SUBIEN,VDATA,WHERE
 ;get identifying data for database spouse
 S IENS=$G(INCREL(408,"S",1))
 Q:IENS=""
 ;associate each ien with file/subfile
 S B=0 F FF=408.12,408.13,408.21,408.22 D
 . S B=B+1,IEN=+$P(IENS,U,B)
 . Q:'IEN
 . S (FILE,SUBF)=FF
 . S FLD=0 F  S FLD=$O(^TMP("EZINDEX",$J,"S",FILE,SUBF,FLD)) Q:FLD=""  D
 . . S MAP=FILE_U_SUBF_U_FLD
 . . ;get patient database data
 . . S VDATA=$$GET^EASEZC1(IEN,MAP)
 . . ;store link in all 1010EZ elements associated with this file/subfile
 . . ;store patient data in tmp array and link in subfile #712.01; KEY is ien to file #711
 . . S KEY=0 F  S KEY=$O(^TMP("EZINDEX",$J,"S",FILE,SUBF,FLD,KEY)) Q:'KEY  D
 . . . S ^TMP("EZDATA",$J,KEY,1,2)=VDATA
 . . . S EASAEL=$P($G(^TMP("EZDATA",$J,KEY,1,1)),U,3)
 . . . I EASAEL D LINKUP^EASEZU1(EASAPP,EASAEL,IEN)
 . . . I 'EASAEL,VDATA'="" D ADD71201^EASEZU1(EASAPP,KEY,IEN,1)
 . ;get data in subfile #408.1275
 . I FILE=408.12 S SUBF=408.1275 S FLD=0 F  S FLD=$O(^TMP("EZINDEX",$J,"S",FILE,SUBF,FLD)) Q:FLD=""  D
 . . S SUBIEN=$$I1275^EASEZI(IEN)
 . . S MAP=FILE_U_SUBF_U_FLD,WHERE=IEN_";"_SUBIEN
 . . S VDATA=$$GET^EASEZC1(WHERE,MAP)
 . . ;store link in all 1010EZ elements associated with this file/subfile
 . . ;store patient data in tmp array and link in subfile #712.01; KEY is ien to file #711
 . . S KEY=0 F  S KEY=$O(^TMP("EZINDEX",$J,"S",FILE,SUBF,FLD,KEY)) Q:'KEY  D
 . . . S ^TMP("EZDATA",$J,KEY,1,2)=VDATA
 . . . S EASAEL=$P($G(^TMP("EZDATA",$J,KEY,1,1)),U,3)
 . . . I EASAEL D LINKUP^EASEZU1(EASAPP,EASAEL,WHERE)
 . . . I 'EASAEL,VDATA'="" D ADD71201^EASEZU1(EASAPP,KEY,WHERE,1)
 Q
 ;
C1N408 ;get child/dependent financial data from VistA
 N B,PERS,EZ,PT,TYPE,GRP,GRP1,MAP,M,MM,NSD,OUT,X,IEN,IENS,FLD,FF,FFF,FILE,SUBF,SUBIEN,VDATA,WHERE
 ;
 ;get identifying data for 1010EZ child dependents
 K PERS("EZ")
 S TYPE="CHILD1" S X=$$NSD^EASEZU3(EASAPP,TYPE,1) I X'="" S PERS("EZ",TYPE,1)=X
 S TYPE="CHILD(N)",M=0,OUT=0 F  S M=M+1 D  Q:OUT
 . S X=$$NSD^EASEZU3(EASAPP,TYPE,M)
 . I X="" S OUT=1 Q
 . S PERS("EZ",TYPE,M)=X
 ;
 ;get identifying data for all database dependents
 K PERS("PT")
 S M=0,MM=0 F  S M=$O(INCREL(408,"C",M)) Q:'M  D
 . S IEN=+$P(INCREL(408,"C",M),U,2)
 . S NSD="" F FLD=".01",".09",".03" D
 . . S FFF="408.13^408.13^"_FLD S X=$$GET^EASEZC1(IEN,FFF)
 . . I FLD=".09" S X=$$SSNOUT^EASEZT1(X)
 . . S NSD=NSD_X_U
 . S MM=MM+1,PERS("PT","CHILD",MM)=NSD,PERS("PT","CHILD",MM,"IENS")=INCREL(408,"C",M)
 ;
 ;match each EZ child dependent to database dependent if possible
 F TYPE="CHILD1","CHILD(N)" S M=0 F  S M=$O(PERS("EZ",TYPE,M)) Q:'M  D
 . S EZ=PERS("EZ",TYPE,M)
 . S MM=0 F  S MM=$O(PERS("PT","CHILD",MM)) Q:'MM  S PT=PERS("PT","CHILD",MM) D
 . . I ($P(EZ,U,2,3)=$P(PT,U,2,3))!($$CMORE^EASEZC2(EZ,PT)) D
 . . . S PERS("EZ",TYPE,M,"IENS")=PERS("PT","CHILD",MM,"IENS")
 . . . K PERS("PT","CHILD",MM)
 ;
 ;get identifying data for child in database
 F TYPE="CHILD1","CHILD(N)" S M=0 F  S M=$O(PERS("EZ",TYPE,M)) Q:'M  D
 . S IENS=$G(PERS("EZ",TYPE,M,"IENS"))
 . Q:IENS=""
 . S GRP=$S(TYPE="CHILD1":"C1",1:"CN")
 . ;associate each ien with file/subfile
 . S B=0 F FF=408.12,408.13,408.21,408.22 D
 . . S B=B+1,IEN=+$P(IENS,U,B)
 . . Q:'IEN
 . . S (FILE,SUBF)=FF
 . . S FLD=0 F  S FLD=$O(^TMP("EZINDEX",$J,GRP,FILE,SUBF,FLD)) Q:FLD=""  D
 . . . S MAP=FILE_U_SUBF_U_FLD
 . . . S GRP1=GRP I EASVRSN>5.99,FILE=408.21,"^.08^.14^.17^2.01^2.03^2.04^"[("^"_FLD_"^") S GRP1="CN"
 . . . ;get patient database data
 . . . S VDATA=$$GET^EASEZC1(IEN,MAP)
 . . . ;I FILE=408.21 W !,FLD,?8,TYPE,?18,M,?21,VDATA ;instrumentation for testing
 . . . ;store link in all 1010EZ elements associated with this file/subfile
 . . . ;store patient data in tmp array and link in subfile #712.01; KEY is ien to file #711
 . . . S KEY=$O(^TMP("EZINDEX",$J,GRP1,FILE,SUBF,FLD,0)) Q:'KEY  D
 . . . . S MM=M I EASVRSN>5.99,FILE=408.21,"^.08^.14^.17^2.01^2.03^2.04^"[("^"_FLD_"^") S:(TYPE="CHILD(N)") MM=M+1
 . . . . ;I FILE=408.21 W !,"*",FLD,?8,TYPE,?18,MM,?21,VDATA ;instrumentation for testing
 . . . . S ^TMP("EZDATA",$J,KEY,MM,2)=VDATA
 . . . . S EASAEL=$P($G(^TMP("EZDATA",$J,KEY,MM,1)),U,3)
 . . . . I EASAEL D LINKUP^EASEZU1(EASAPP,EASAEL,IEN)
 . . . . I 'EASAEL,VDATA'="" D ADD71201^EASEZU1(EASAPP,KEY,IEN,1)
 . . ;get data in subfile #408.1275
 . . I FILE=408.12 S SUBF=408.1275 S FLD=0 F  S FLD=$O(^TMP("EZINDEX",$J,GRP,FILE,SUBF,FLD)) Q:FLD=""  D
 . . . S SUBIEN=$$I1275^EASEZI(IEN)
 . . . S MAP=FILE_U_SUBF_U_FLD,WHERE=IEN_";"_SUBIEN
 . . . S VDATA=$$GET^EASEZC1(WHERE,MAP)
 . . . ;store link in all 1010EZ elements associated with this file/subfile
 . . . ;store patient data in tmp array and link in subfile #712.01; KEY is ien to file #711
 . . . S KEY=0 F  S KEY=$O(^TMP("EZINDEX",$J,GRP,FILE,SUBF,FLD,KEY)) Q:'KEY  D
 . . . . S ^TMP("EZDATA",$J,KEY,MM,2)=VDATA
 . . . . S EASAEL=$P($G(^TMP("EZDATA",$J,KEY,MM,1)),U,3)
 . . . . I EASAEL D LINKUP^EASEZU1(EASAPP,EASAEL,WHERE)
 . . . . I 'EASAEL,VDATA'="" D ADD71201^EASEZU1(EASAPP,KEY,WHERE,1)
 Q
 ;
CMORE(EZ,PT) ;
 ;input EZ = name^ssn^dob of child on 1010EZ
 ;      PT = name^ssn^dob of child in database
 ;output MATCH = 0, if no match
 N PSSN,PDOB,ESSN,EDOB,K,MATCH,MATCH1,MATCH2
 S (MATCH,MATCH1,MATCH2)=0
 S ESSN=$P(EZ,U,2),EDOB=$P(EZ,U,3),PSSN=$P(PT,U,2),PDOB=$P(PT,U,3)
 S MATCH1=0 F K=1,2,3,5,6,8,9,10,11 I $P(ESSN,U,K)=$P(PSSN,U,K) S MATCH1=MATCH1+1
 I $P(EDOB,"/",3)=$P(PDOB,"/",3) S MATCH2=1
 I MATCH1>7,MATCH2 S MATCH=1
 Q MATCH
