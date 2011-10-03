QACI2D ; OAKOIFO/TKW - DATA MIGRATION - BUILD LEGACY DATA TO BE MIGRATED (CONT.) ;11/30/06  12:06
 ;;2.0;Patient Representative;**19**;07/25/1995;Build 55
ENISS(ROCIEN,ROCNO,OLDROC,QACI0,ROCCNT,RESERR,HL,PARENT,STATION,PATSCNT) ; Move Issue Code and related data to output global
 N I,J,X,ROCISS,ISSIEN,ISSLIST,ISSCODE,ISSNAME,FSOSIEN,FSOS,FSOSCNT,ERR,HLID,HLNAME,EMPID,EMP,EMPNAME,EMPCNT,NEWITXT,ISACTIVE,ITXT,HLINST,ROCDT
 S ERR=0
 ; Read through Issue Codes, build lists of active/inactive codes
 F ROCISS=0:0 S ROCISS=$O(^QA(745.1,ROCIEN,3,ROCISS)) Q:'ROCISS!(ERR)  S ISSIEN=$P($G(^(ROCISS,0)),"^") D:ISSIEN]""
 . S X=""
 . I ISSIEN S X=$G(^QA(745.2,ISSIEN,0))
 . I X="" D ERROC^QACI2A(OLDROC,"Issue Code Pointer "_+X_" is invalid") Q
 . S ISSCODE=$P(X,"^"),ISSNAME=$P(X,"^",3)
 . I ISSCODE=""!(ISSNAME="") S ERR=1 D ERROC^QACI2A(OLDROC,"Issue Code or Issue Code Name NULL") Q
 . ; Set a flag based on whether this is an active (migrated) issue code.
 . S ISACTIVE=$S($D(^XTMP("QACMIGR","ISS","D",ISSCODE)):1,1:0)
 . S ISSLIST(ISACTIVE,ROCISS)=ISSIEN_"^"_ISSCODE_"^"_ISSNAME
 . Q
 ;
 ; If there are no issue codes, and date of contact after FY2003, generate an error
 I '$D(ISSLIST) D  Q:ERR ERR
 . N ROCDT S ROCDT=$P(^QA(745.1,ROCIEN,0),"^",2)
 . I ROCDT<3031001 S ISSLIST(0,1)=0 Q
 . S ERR=1 D ERROC^QACI2A(OLDROC,"ROC Has no valid Issue Codes")
 . Q
 ;
 ; Build hospital location ref table data if there's at least one active issue code to migrate
 S (HLNAME,HLINST)=""
 I HL]"" D
 . S HLNAME=$P($G(^SC(+HL,0)),"^")
 . Q:'$O(ISSLIST(1,0))
 . ; First check for errors on Hospital Location
 . I HLNAME="",'$D(^SC(+HL,0)) S ERR=1 D  Q
 .. D ERROC^QACI2A(OLDROC,"LOCATION OF EVENT pointer "_+HL_" is invalid") Q
 . I HLNAME="" S ERR=1 D
 .. D ERROC^QACI2A(OLDROC,"LOCATION OF EVENT Name field is NULL") Q
 . I $D(^XTMP("QACMIGR","HL","E",HL)) D  Q
 .. D ERROC^QACI2A(OLDROC,"LOCATION OF EVENT has invalid data -- see ref data report") Q
 . S HLINST=$P($G(^XTMP("QACMIGR","HL","U",HL)),"^",3) Q:HLINST]""
 . ; Build Reference Table data for Hospital Location
 . D HLDATA(STATION,HL,QACI0,.ERR,.HLINST,.PATSCNT)
 . I ERR D ERROC^QACI2A(OLDROC,"LOCATION OF EVENT has invalid data -- see ref data report")
 . Q
 ;
 ; Build list of employees.
 S EMPCNT=0
 F I=0:0 S I=$O(^QA(745.1,ROCIEN,8,I)) Q:'I  S EMP=$P($G(^(I,0)),"^") D:EMP]""
 . S EMPNAME=""
 . ; Check for errors on Employee data
 . I '$D(^VA(200,+EMP,0)) D  Q
 .. D ERROC^QACI2A(OLDROC,"EMPLOYEE pointer "_+EMP_" is invalid")
 .. S ERR=1 Q
 . S EMPNAME=$P(^VA(200,+EMP,0),"^")
 . S EMP(EMP)=EMPNAME,EMPCNT=EMPCNT+1
 . ; Quit if there are no active issue codes to migrate.
 . Q:'$O(ISSLIST(1,0))
 . I EMPNAME="" D  Q
 .. S ERR=1
 .. D ERREF^QACI2C("EMPINV",EMP,"Name missing")
 .. D ERROC^QACI2A(OLDROC,"EMPLOYEE Name is NULL -- see EMP.INVOLVED on ref data report") Q
 . ; Build reference table data for Employee Involved.
 . D USERDATA^QACI2B(PARENT,EMP,"E",QACI0,.ERR,.PATSCNT)
 . I ERR D ERROC^QACI2A(OLDROC,"EMPLOYEE has invalid data -- see EMP.INVOLVED on ref data report")
 . Q
 Q:ERR ERR
 ;
 ;
 ; For inactive issue codes, issue multiple data goes in resolution text.
 I $O(ISSLIST(0,0)) D
 . N RTXTCNT,RESERR1,RESERR2
 . S RESERR2=" char.(8000 maximum)"
 . ; Set current resolution text number of characters and error code
 . I 'RESERR D
 .. S RTXTCNT=0
 .. S RESERR1="Resolution Text" Q
 . E  D 
 .. S RTXTCNT=$P(RESERR,"^")
 .. S RESERR1=$P(RESERR,"^",2)_" + Issue Code Data" Q
 . ; Add header to resolution text.
 . S RTXTCNT=RTXTCNT+34
 . I 'QACI0,RTXTCNT'>8000 D
 .. I RTXTCNT>0 S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT+1)=ROCNO_"^RTXT^ ",^(ROCCNT+2)=ROCNO_"^RTXT^ ",ROCCNT=ROCCNT+2
 .. I $P($G(ISSLIST(0,1)),"^")=0 S X="**  No Issue Code Assigned  **"
 .. E  S X="**  Inactive Issue Code Data  **"
 .. S ROCCNT=ROCCNT+1,^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT)=ROCNO_"^RTXT^"_X
 .. Q
 . ; Add Hospital Location data to Resolution Text
 . I HL]"" D
 .. I 'HL S HLNAME=HL
 .. S:HLNAME="" HLNAME="*Unknown*"
 .. S RTXTCNT=RTXTCNT+$L(HLNAME)+12
 .. I 'QACI0,RTXTCNT'>8000 D
 ... S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT+1)=ROCNO_"^RTXT^ "
 ... S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT+2)=ROCNO_"^RTXT^Hosp.Loc.: "_HLNAME
 ... S ROCCNT=ROCCNT+2 Q
 .. Q
 . ; Add Employee Involved data to Resolution Text
 . F EMP=0:0 S EMP=$O(EMP(EMP)) Q:'EMP  D
 .. S EMPNAME=EMP(EMP)
 .. S:EMPNAME="" EMPNAME="*Unknown*"
 .. S RTXTCNT=RTXTCNT+$L(EMPNAME)+11
 .. I 'QACI0,RTXTCNT'>8000 D
 ... S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT+1)=ROCNO_"^RTXT^ "
 ... S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT+2)=ROCNO_"^RTXT^Emp.Inv.: "_EMPNAME
 ... S ROCCNT=ROCCNT+2 Q
 .. Q
 . ; Add Issue Code and Service/Discipline data to Resolution Text
 . F I=0:0 S I=$O(ISSLIST(0,I)) Q:'I  S X=ISSLIST(0,I) D:X
 .. S ISSCODE=$P(X,"^",2),ISSNAME=$P(X,"^",3) S:ISSCODE="" ISSCODE="*Unknown*"
 .. S RTXTCNT=RTXTCNT+$L(ISSNAME)+19
 .. I 'QACI0,RTXTCNT'>8000 D
 ... S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT+1)=ROCNO_"^RTXT^ "
 ... S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT+2)=ROCNO_"^RTXT^Issue Code: "_ISSCODE_"  "_ISSNAME
 ... S ROCCNT=ROCCNT+2 Q
 .. ; Read through Service/Discipline multiples
 .. F J=0:0 S J=$O(^QA(745.1,ROCIEN,3,I,3,J)) Q:'J  S FSOSIEN=$P($G(^(J,0)),"^") D:FSOSIEN
 ... S X=$P($G(^QA(745.55,FSOSIEN,0)),"^")
 ... S:X="" X="*Unknown*"
 ... S RTXTCNT=RTXTCNT+$L(X)+14
 ... I 'QACI0,RTXTCNT'>8000 D
 .... S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT+1)=ROCNO_"^RTXT^ "
 .... S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT+2)=ROCNO_"^RTXT^  Serv/Disc: "_X
 .... S ROCCNT=ROCCNT+2 Q
 ... Q
 .. Q
 . I RTXTCNT>8000 D
 .. D ERROC^QACI2A(OLDROC,RESERR1_"="_RTXTCNT_RESERR2)
 .. S ERR=1 Q
 . Q
 ;
 ;
 ; For active issue codes, build issue code multiple data for the ROC.
 F I=0:0 S I=$O(ISSLIST(1,I)) Q:'I  S X=ISSLIST(1,I) D
 . S ISSCODE=$P(X,"^",2)
 . ;
 . ; Read through Service/Discipline multiple
 . S FSOSCNT=0,FSOSNAME=""
 . F J=0:0 S J=$O(^QA(745.1,ROCIEN,3,I,3,J)) Q:'J!(ERR)  S FSOSIEN=$P($G(^(J,0)),"^") D:FSOSIEN]""
 .. ; Check for errors
 .. I '$D(^QA(745.55,+FSOSIEN,0)) D  Q
 ... D ERROC^QACI2A(OLDROC,"SERVICE/DISCIPLINE pointer "_+FSOSIEN_" is invalid")
 ... S ERR=1 Q
 .. S FSOSNAME=$P(^QA(745.55,+FSOSIEN,0),"^")
 .. I $$TXTERR^QACI2C(FSOSNAME,50,0,1) D
 ... S ERR=1
 ... D ERROC^QACI2A(OLDROC,"SERVICE/DISCIPLINE on issue "_ISSCODE_" invalid -- see ref data report")
 ... Q
 .. ; Build reference table data for FSOS
 .. D BLDFSOS^QACI2A(FSOSIEN,FSOSNAME,QACI0,.PATSCNT)
 .. ; Quit if errors were encountered in FSOS data
 .. I $D(^XTMP("QACMIGR","FSOS","E",FSOSIEN)) S ERR=1 Q
 .. S FSOSCNT=FSOSCNT+1
 .. ;
 .. ; Set ROC Issue data for Issue Multiples with both FSOS and Employees
 .. I EMPCNT D  Q
 ... F EMP=0:0 S EMP=$O(EMP(EMP)) Q:'EMP  D:'QACI0 SETDATA
 ... Q
 .. ; If no employees notified, set Issue Multiples with FSOS
 .. S EMP="" D:'QACI0 SETDATA
 .. Q
 . I FSOSCNT=0 S FSOSNAME="" D
 .. ; If no FSOS, but there are employees, set Issue Multiples
 .. I EMPCNT D  Q
 ... F EMP=0:0 S EMP=$O(EMP(EMP)) Q:'EMP  D:'QACI0 SETDATA
 ... Q
 .. ; If there are no FSOS and no employees, set Issue Multiples
 .. S EMP="" D:'QACI0 SETDATA Q
 . Q
 ; If errors were encountered, quit with the error code
 I ERR K ^XTMP("QACMIGR","ROC","U",ROCNO) Q ERR
 Q 0
 ;
 ;
SETDATA ; Set data for Issue Code multiple on a ROC
 ; We don't call this routine if just building error report (i.e., from ^QACI0).
 S ROCCNT=ROCCNT+1
 S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT)=ROCNO_"^ISS^"_ISSCODE_"^"_FSOSNAME_"^"_EMP_"^"_HLNAME_"^"_HLINST_"^"
 Q
 ;
HLDATA(STATION,HL,QACI0,ERR,HLINST,PATSCNT) ; Load Hospital Location Data for migration
 ; IA #10040, #10112
 N Y,HLNAME S ERR=0
 S Y=$G(^SC(HL,0)) I Y="" S ERR=1 Q
 S HLNAME=$P(Y,"^"),HLINST=""
 D
 . ; Get DIVISION station number for Hospital Location
 . S HLINST=$P(Y,"^",15)
 . I HLINST S HLINST=$P($$SITE^VASITE(,HLINST),"^",3) Q:HLINST'=-1
 . ; If not found, get Institution station
 . S HLINST=$P(Y,"^",4) Q:'HLINST
 . S HLINST=$$STA^XUAF4(HLINST) Q:HLINST]""
 . ; If no station number for either one, generate an error
 . S Y=$L(HLNAME)
 . S HLNAME=$E(HLNAME,1,30)_$S(Y>30:"...",1:"")
 . S ERR=1 D ERREF^QACI2C("HL",HL,HLNAME_" - has no STATION NUMBER") Q
 I HLINST="" S HLINST=STATION
 Q:$D(^XTMP("QACMIGR","HL","D",HL))
 Q:$D(^XTMP("QACMIGR","HL","U",HL))
 I $$TXTERR^QACI2C(HLNAME,30,0,1) D
 . S HLNAME=$E(HLNAME,1,20)_$S($L(HLNAME>20):"...",1:"")
 . S ERR=1 D ERREF^QACI2C("HL",HL,HLNAME_" - NAME missing or invalid") Q
 ; Check to make sure station is on the list from std_institution table
 I '$D(^XTMP("QACMIGR","STDINSTITUTION",HLINST)) D
 . S ERR=1 D ERREF^QACI2C("HL",HL,HLINST_" is not a valid national station number") Q
 ; Quit if there are errors, or if called from ^QACI0 to just print the error report.
 Q:ERR=1
 Q:QACI0
 S ^XTMP("QACMIGR","HL","U",HL)=HL_"^"_HLNAME_"^"_HLINST_"^"
 S PATSCNT("HL")=PATSCNT("HL")+1
 Q
 ;
 ;
