EASEZI ;ALB/jap - Database Inquiry & Record Finder for 1010EZ Processing ;10/12/00  13:08
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**1,9,44,51,57,70,81,100**;Mar 15, 2001;Build 6
 ;
DFN(EASAPP,EASDFN) ;match or add 1010EZ applicant to Patient file #2
 ;
 ;input  
 ;  EASAPP = application ien in file #712
 ;output 
 ;  EASDFN = valid ien in file #2; passed by reference
 ;           OR -1 if no patient match made;
 ;           note: this may be an existing patient or one newly created by user action
 ;
 ;This entry point it used only for initial match of Applicant with Patient database.
 ;
 N DFN,DGNEWPF,DGRPTOUT,EZDATA,KEY,NAME,SSN,DOB,SEX,KEYIEN,ACCEPT,ARRAY,RECD
 N VETTYPE,NEW,TSSN,REM,N,X,DA,DR,DIE,DIC,DIQ,ALREADY,OUT,FILE,SUBFILE,FLD,ELIGVER,SVCVER,APPTVER
 Q:'EASAPP
 ;do not proceed if link to file #2 already established
 S EASDFN=$P($G(^EAS(712,EASAPP,0)),U,10) Q:EASDFN
 D FULL^VALM1 W @IOF
 S EASEZNEW="",ELIGVER=0,SVCVER=0,APPTVER=0
 S KEY=$$KEY711^EASEZU1("APPLICANT SEX")
 S SEX=$P($$DATA712^EASEZU1(EASAPP,KEY),U,1),SEX=$S(SEX="M":"Male",SEX="F":"Female",1:"")
 S DIQ="ARRAY",DIQ(0)="E",DA=EASAPP,DR="1;2;3;3.3",DIC=712 D EN^DIQ1
 S NAME=$G(ARRAY(712,EASAPP,1,"E"))
 S SSN=$P($G(ARRAY(712,EASAPP,2,"E")),"&",1)
 S DOB=$P($G(ARRAY(712,EASAPP,2,"E")),"&",2)
 S RECD=$G(ARRAY(712,EASAPP,3,"E"))
 S VETTYPE=$G(ARRAY(712,EASAPP,3.3,"E"))
 W !,"Applicant Data",?24,"Application #: ",EASAPP,?48,"Received: ",RECD,!
 W !,"Name: ",NAME
 W !,"SSN: ",SSN,?24,"DOB: ",DOB,?48,"Sex: ",SEX
 W !,"Veteran Type: ",VETTYPE
 W !!,"Enter Applicant data as prompted --"
 ;
 ;Get Patient file (#2) IEN - DFN
 ;EAS*1*81 - changes made to allow adding new patient with same name
 ;as an existing patient
 N EASANS,Y S EASANS=0
 N DIR,DIRUT
 S DIR(0)="YAO"
 S DIR("?")="Enter 'Yes' if this patient is the one you want to select."
 S DIR("A")="IS THIS THE CORRECT PATIENT? "
 S DIR("B")="YES"
 F  Q:EASANS  D  K DIR
 . D GETPAT^DGRPTU("",1,.DFN,.DGNEWPF) I DFN>0,($G(DGNEWPF)=1) S EASANS=1 Q
 . I DFN'>0 S EASANS=1 Q
 . I DFN>0,($G(DGNEWPF)'=1) D
 . . D ^DIR
 . . I $D(DIRUT) Q
 . . I Y(0)["Y" S EASANS=1 Q
 . . I Y(0)["N" K DFN
 . . I $G(DFN)'>0 D
 . . W !!?5,"If there are already one or more patients with the same name,",!?5,"re-enter the name in double quotes, for example, ""DOE,JOHN""."
 Q:($G(DFN)'>0)
 ;if DGNEWPF=1 then applicant has just been added to file #2 as new patient
 S NEW=""
 I DGNEWPF D
 . S NEW=1
 . ;add a remark to file #2 record to help keep track of new patients added by 1010EZ
 . S REM="NEW PT. FROM ELECTRONIC 10-10EZ -- IN PROCESS"
 . S DA=DFN,DIE="^DPT(",DR=".091///^S X=REM"
 . D ^DIE
 ;if seems to be not new, check remark field just to make sure
 I NEW="" D
 . S REM="NEW PT. FROM ELECTRONIC 10-10EZ -- IN PROCESS"
 . I $P(^DPT(DFN,0),U,10)=REM S NEW=1
 ;MPI Query
 S X="MPIFAPI" X ^%ZOSF("TEST")  D
 . Q:'$T
 . K MPIFRTN
 . D MPIQ^MPIFAPI(DFN)
 . K MPIFRTN,MPIQRYNM
 ;check for an in-process application already linked to this DFN
 S OUT=0,ALREADY=0 F  S ALREADY=$O(^EAS(712,"AC",DFN,ALREADY)) Q:'ALREADY  D  Q:OUT
 . S FILDATE=$P($G(^EAS(712,ALREADY,2)),U,5)
 . S CLSDATE=$P($G(^EAS(712,ALREADY,2)),U,9)
 . I 'FILDATE,'CLSDATE S OUT=1 D
 . . W !!?3,"Sorry... cannot link to selected Patient."
 . . W !?3,"Application #"_ALREADY_" is already linked to this Patient,"
 . . W !?3,"and is still in-process."
 . . D PAUSE^VALM1 K FILDATE,CLSDATE
 Q:OUT
 D RESET^EASEZI1
 Q
 ;
I201(EASDFN,EASARRAY) ;retrieve ien(s) in subfile #2.01
 ;input EASDFN    = ien to #2
 ;output EASARRAY = ien(s) to #2.01
 ;                  each array element = EASDFN;subfile_ien
 ;
 N N,IEN
 S IEN=0,N=0 F  S IEN=$O(^DPT(EASDFN,.01,IEN)) Q:'IEN  S N=N+1,EASARRAY(N)=EASDFN_";"_IEN
 Q
 ;
I202(EASDFN,EASARRAY) ;retrieve ien(s) in subfile #2.02
 ;input EASDFN    = ien to #2
 ;output EASARRAY = ien(s) to #2.01
 ;                  each array element = EASDFN;subfile_ien
 ;
 N N,IEN
 S IEN=0,N=0 F  S IEN=$O(^DPT(EASDFN,.02,IEN)) Q:'IEN  S N=N+1,EASARRAY(N)=EASDFN_";"_IEN
 Q
 ;
I206(EASDFN,EASARRAY) ;retrieve ien(s) in subfile #2.06
 ;input EASDFN    = ien to #2
 ;output EASARRAY = ien(s) to #2.01
 ;                  each array element = EASDFN;subfile_ien
 ;
 N N,IEN
 S IEN=0,N=0 F  S IEN=$O(^DPT(EASDFN,.06,IEN)) Q:'IEN  S N=N+1,EASARRAY(N)=EASDFN_";"_IEN
 Q
 ;
I2101(EASDFN,EASARRAY) ;retrieve ien to subfile #2.101
 ;input EASDFN    = ien to #2
 ;output EASARRAY = most recent ien in #2.101;
 ;                  array element = EASDFN;subfile_ien
 ;
 N N,IEN,ARR,LAST,EASQUIT,EASICN
 S EASQUIT=0
 S IEN=0,N=0 F  S IEN=$O(^DPT(EASDFN,"DIS",IEN)) Q:'IEN!EASQUIT  D
 . ;S RDATE=$P(^DPT(EASDFN,"DIS",IEN,0),U,1),ARR(RDATE)=IEN
 . S RDATE=$P($G(^DPT(EASDFN,"DIS",IEN,0)),U,1) I RDATE]"" S ARR(RDATE)=IEN
 . I RDATE']"" D
 .. K XQA,XQAID,XQAMSG
 .. S EASICN=$$GETICN^MPIF001(EASDFN) I EASICN]"" S EASICN=$P(EASICN,"V",1)
 .. S XQA(DUZ)=""
 .. S XQAID="EAS"
 .. S XQAMSG="No disposition for "_$P(^DPT(EASDFN,0),"^",1)_" ICN: "_EASICN_" Re-register patient."
 .. ;S $P(XQADATA,"^",1)="NAME : "_$P(^DPT(EASDFN,0),"^",1) ;PATIENT NAME
 .. D SETUP^XQALERT
 ..; S EASQUIT=1 K ^DPT(EASDFN,"DIS",IEN),^DPT("ADA",1,EASDFN),ARR
 .. S EASQUIT=1 D
 ... K ARR,DA,DA(1),DIK,EASNODE,EASDT
 ... S DA=IEN,DA(1)=EASDFN,DIK="^DPT("_EASDFN_",""DIS""," D ^DIK K DIK,DA
 ... I $D(^DPT("ADA",1,EASDFN)) S EASDT=$O(^DPT("ADA",1,EASDFN,0)),EASNODE="^DPT(""ADA"""_",1,"_EASDFN_","_EASDT_")" K @EASNODE
 ... Q
 .. I '$D(IO("Q")) D 
 ... W !!,"No disposition for "_$P(^DPT(EASDFN,0),"^",1)_" ICN: "_EASICN
 ... W !,"A blank 1010EZ may print. Please re-register the patient and reprint the 1010EZ."
 ... H 6
 ..; D ENQUIT^EASEZPF ; KILLS ALL OF THE ^TMP("EZ" VARIABLES FOR PRINTING1010EZ.
 ..S EASARRAY(1)="NO DISPOSITION" Q
 I $D(ARR) D
 . S LAST=$O(ARR(999999999),-1),IEN=ARR(LAST)
 . S EASARRAY(1)=EASDFN_";"_IEN
 Q
 ;
I2711(EASDFN,EASARRAY) ;retrieve ien to file #27.11
 ;input EASDFN    = ien to #2
 ;output EASARRAY = current enrollment ien in #27.11;
 ;                  array element = ien
 N CUR
 S CUR=$$FINDCUR^DGENA(+EASDFN)
 S EASARRAY(1)=CUR
 Q
 ;
I408(EASDFN,EASAPP,EASARRAY) ;retrieve ien(s) to files #408.12,#408.13,#408.21,#408.22
 ;
 ;input EASDFN    = ien to #2
 ;      EASAPP    = ien to #712
 ;output EASARRAY = ien(s) to files; passed by reference
 ;       array(408,"V",1) = ien_#408.12^ien_#408.13^ien_#408.21^ien#408.22 ;veteran data
 ;       array(408,"S",1) = ien_#408.12^ien_#408.13^ien_#408.21^ien#408.22 ;spouse data
 ;       array(408,"C",multiple) = ien_#408.12^ien_#408.13^ien_#408.21^ien#408.22 ;child data
 ;   where ien_#408.13 = ien;global_root
 ;
 N CURINCYR,X,Y,DIC,DA,DR,DIQ,EAS,DEP,REL,IX,JX,KX,I13,SUB1,SUB2,INCYR,PT
 ;
 Q:'EASDFN
 S Y=$P($G(^EAS(712,EASAPP,0)),U,6) I Y="" S Y=DT
 S %F=5,X=$$FMTE^XLFDT(Y,%F),X=+$P(X,"/",3)-1,%DT="P" D ^%DT S CURINCYR=Y
 ;find all associated 408 records, even if no actual income test
 ; get #408.12, #408.13, #408.21, #408.22 iens
 K EAS S DEP=0
 S IX=0 F  S IX=$O(^DGPR(408.12,"B",EASDFN,IX)) Q:'IX  D
 . S DIC=408.12,DA=IX,DIQ="EAS",DIQ(0)="I",DR=".02;.03" D EN^DIQ1
 . S REL=$G(EAS(408.12,IX,.02,"I")),I13=$G(EAS(408.12,IX,.03,"I"))
 . S (SUB1,SUB2)="" S:REL=1 SUB1="V",SUB2=1 S:REL=2 SUB1="S",SUB2=1 S:REL>2 SUB1="C",DEP=DEP+1,SUB2=DEP
 . I SUB1]"" S EASARRAY(408,SUB1,SUB2)=IX_U_I13 D
 . . S JX=$O(^DGMT(408.21,"C",IX,""),-1)
 . . I JX D
 . . . S DIC=408.21,DA=JX,DIQ="EAS",DIQ(0)="I",DR=".01;.02" D EN^DIQ1
 . . . S INCYR=$G(EAS(408.21,JX,.01,"I")),PT=$G(EAS(408.21,JX,.02,"I"))
 . . . Q:PT'=IX
 . . . Q:(INCYR<CURINCYR)
 . . . S KX=$O(^DGMT(408.22,"AIND",JX,0))
 . . . S EASARRAY(408,SUB1,SUB2)=EASARRAY(408,SUB1,SUB2)_U_JX_U_KX
 Q
 ;
I1275(IEN) ;get the active subrecord from subfile #408.1275
 ;input     IEN = internal record number to file #408.12
 ;output SUBIEN = internal record number for active subrecord,
 ;                or -1 if invalid
 N B,ACT,SUBIEN
 I 'IEN Q -1
 S SUBIEN=-1
 S B=0 F  S B=$O(^DGPR(408.12,IEN,"E",B)) Q:'B  D
 . S ACT=$P(^DGPR(408.12,IEN,"E",B,0),U,2)
 . I ACT S SUBIEN=B
 Q SUBIEN
