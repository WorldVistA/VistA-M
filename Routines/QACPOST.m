QACPOST ;WCIOFO/ERC-Post-install for patch-Update 745.1,745.2 ;7/24/97
 ;;2.0;Patient Representative;**3**;07/25/1995
 ; Set Period of Service and Persian Gulf Service? fields in 745.1.
 ; Change 'Local' Issue Codes to 'Inactive' in file 745.2
DEMOG ; Add new demographic fields
 N QACCNUM,QACPTNUM
 S QACCNUM=0
 F  S QACCNUM=$O(^QA(745.1,QACCNUM)) Q:QACCNUM'>0  D
 . S QACPTNUM=$P(^QA(745.1,QACCNUM,0),U,3)
 . Q:$G(QACPTNUM)']""
 . S $P(^QA(745.1,QACCNUM,0),U,14)=$P($G(^DPT(QACPTNUM,.32)),U,3)
 . S $P(^QA(745.1,QACCNUM,0),U,15)=$P($G(^DPT(QACPTNUM,.322)),U,10)
ISS ; Change any 'Local' Issue Codes in file 745.2 to 'Inactivated'.
 N QACCODE
 S QACCODE=0
 F  S QACCODE=$O(^QA(745.2,QACCODE)) Q:QACCODE'>0  I $P(^QA(745.2,QACCODE,0),U,5)="L" S $P(^QA(745.2,QACCODE,0),U,5)=1
DIV ; Add divisions to file 740 if site is multi-divisional for Pat. Rep.
 N EE,QACCNT,QACDIVN,QACTYPE
 I $G(^DIC(4,$P(^QA(740,1,0),U),"DIV"))["Y" D
 .S EE=0
 .F  S EE=$O(^DG(40.8,EE)) Q:EE'>0  D
 . . S QACDIVN=$P($G(^DG(40.8,EE,0)),U,7)
 . . Q:$G(QACDIVN)']""  S QACTYPE=$G(^DIC(4,QACDIVN,3))
 . . I EE=1 S QACTYPE=1
 . . I $G(QACTYPE)]"" I $S(QACTYPE=1:1,QACTYPE=8:1,QACTYPE=16:1,1:0) D
 . . . S $P(^QA(740,1,"OS"),U,9)=1
 . . . I '$D(^QA(740,1,"OS2",0)) S ^QA(740,1,"OS2",0)="^740.02IPA^0^0"
 . . . S QACCNT=$P(^QA(740,1,"OS2",0),U,3)+1
 . . . S $P(^QA(740,1,"OS2",0),U,3,4)=QACCNT
 . . . S $P(^QA(740,1,"OS2",EE,0),U)=EE
 . . . S ^QA(740,1,"OS2","B",EE,EE)=""
 I $G(^DIC(4,$P(^QA(740,1,0),U),"DIV"))']"Y" S $P(^QA(740,1,"OS"),U,9)=""
DATE ; Correct data already entered in test sites for date resolved.
 ; Had originally planned to replace date closed with date closed,
 ; but now will just change name.  This subroutine will move any 
 ; data in date resolved to date closed and set field date resolved 
 ; to null.
 S EE=0
 F  S EE=$O(^QA(745.1,EE)) Q:EE'>0  D
 . I $D(^QA(745.1,EE,7)) I $P(^QA(745.1,EE,7),U,3)]"" S $P(^QA(745.1,EE,7),U)=$P(^QA(745.1,EE,7),U,3)
 . S $P(^QA(745.1,EE,7),U,3)=""
DISC ; Correct data at test sites that had been entered in discipline
 ; sub-file.  Design change put this information in service/discipline
 ; sub-file.  This subroutine will move the data to the new location
 ; and delete the discipline sub-file.
 N QACDISC,QACSV
 N EE,FF,GG,HH S EE=2970704
 F  S EE=$O(^QA(745.1,"D",EE)) Q:EE'>0  D
 . S FF=0 F  S FF=$O(^QA(745.1,"D",EE,FF)) Q:FF'>0  D
 . . S GG=0 F  S GG=$O(^QA(745.1,FF,3,GG)) Q:GG=""  D
 . . . S HH=0 F  S HH=$O(^QA(745.1,FF,3,GG,2,HH)) Q:HH'>0  D DISC2
 . . . Q
 . . Q
 . Q
 Q
DISC2 ;
 S QACDISC=$P(^QA(745.1,FF,3,GG,2,HH,0),U)
 S QACSV=$P(^QA(745.55,$G(QACDISC),0),U)
 S DA(2)=FF,DA(1)=GG,X=QACSV
 S DIC="^QA(745.1,DA(2),3,DA(1),3,"
 S DIC(0)="L"
 S DIC("P")=$P(^DD(745.121,3,0),U,2)
 D ^DIC
 S $P(^QA(745.1,FF,3,GG,3,HH,0),U,2)=QACDISC
 S DIK="^QA(745.1,DA(2),3,DA(1),2,",DA=HH
 D ^DIK K DIK
 Q
