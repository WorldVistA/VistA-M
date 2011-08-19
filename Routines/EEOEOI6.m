EEOEOI6 ;HISC/JWR - EEO COMPLAINT FILE (785) INQUIRY ROUTINE ;Apr 20, 1995
 ;;2.0;EEO Complaint Tracking;;Apr 27, 1995
SEC ;Gathers security variables
 D ^EEOEOSE I FAIL Q
COMPL ;Inquiry of EEO Complaint info
 S DIC("A")="Select Complainant: "
 K DR
 S (EEOYSCR,DIC("S"))="I $$SCREEN^EEOEOSE(Y) I $P($G(^EEO(785,+Y,1)),U,3)>0"
 S (DIE,DIC)="^EEO(785,",DIC(0)="AEQMZ"
DIC ;Gathers complaints to be inquired to
 D NEW^EEOEEDIE
 I (X="^")!((Y'>0)&('$D(EEOYI))) G KILL
 ;I +Y>0 I $D(^EEO(785,+Y,12)) I $P($G(^EEO(785,+Y,12)),U,2)="D" D DMSG^EEOEOE2 G DIC
 S:Y>0 EEOYI(+Y)="" S:$D(EEOYI) DIC("A")="  ANOTHER: "
 I Y<0,$D(EEOYI) G ZIS
 G DIC
 ;
ZIS ;gets printer info
 K %ZIS S %ZIS="MNQ"
 D ^%ZIS K %ZIS G:POP KILL
 S (EEOYOP,IOP)=ION_";"_IOST_";"_IOM_";"_IOSL
 I $D(IO("Q")) S ZTDESC="EEO Inquiry",ZTRTN="START^EEOEOI6",ZTSAVE("EEO*")="" D ^%ZTLOAD G KILL
 ;
START ;beginning of print
 S EEOYZ=0 F I=0:0 S EEOYZ=$O(EEOYI(EEOYZ)) Q:EEOYZ=""  S EEOYLAST=EEOYZ
 S EEOYLP=0,EEOIOST=IOST
 F  S EEOYLP=$O(EEOYI(EEOYLP)) Q:EEOYLP=""  D PRINT Q:EEOYLP=-1
KILL ;generic kill
 D ^%ZISC
 D HOME^%ZIS
 K %ZIS,EEOYI,EEOYLAST,EEOYLP,EEOYOP,EEOYZ,BY,DHD,DIR,DR,FLDS,FR,I,IOP,TO,Y,ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE,EEOIOST
 Q
 ;
PRINT ;Fields to print
 S FLDS="""COMPLAINANT:  """
 S FLDS(1)=".01;X;"""""
 S FLDS(2)="""CASE#:  "";C44"
 S FLDS(3)="1.3;X;"""""
 S FLDS(4)="""ADDRESS:  "";C3"
 S FLDS(5)=".05;X;C13"
 S FLDS(6)=".08;X;C13,"" "",.09;X,"" """
 S FLDS(7)=".091;X;"""""
 S FLDS(8)="""SERVICE:  "";C2"
 S FLDS(9)="5;X;"""""
 S FLDS(10)="""GRADE:  "";C2"
 S FLDS(11)="6;X;"""""
 S FLDS(11.5)="""JOB TITLE:  "";C44"
 S FLDS(12)="6.5;X;"""""
 S FLDS(13)="""REPRESENTATIVE:  "";C2,8;C19;X"
 S FLDS(14)="""PHONE:  "";C44,9;X"
 S FLDS(15)="""ADDRESS:  "";C3,10;X;C13"
 S FLDS(17)="11;X;C13,"" """
 S FLDS(18)="12;X,"" """
 S FLDS(19)="13;X;"""""
 S FLDS(20)="""COUNSELOR NAME:  "";C2"
 S FLDS(21)="14;X;"""""
 S FLDS(22)="""OFFICE FILED WITH:  "";C2"
 S FLDS(23)="16.3;X;"""""
 S FLDS(24)="""BASIS:  "";C2"
 S FLDS(25)="18.5,.01;X;C7"
 S FLDS(26)="""ISSUE CODES:  "";C2"
 S FLDS(26.5)="""ISSUE CODE DATE: "";C44"
 S FLDS(27)="17.5,.01;X;C7,1;X;C46"
 S FLDS(28)="""ISSUE CODE COMMENTS:  "";C2"
 S FLDS(29)="19;C4;X;W"
 S FLDS(30)="""INV. REQ.:  "";C2"
 S FLDS(31)="26;X;C14"
 S FLDS(32)="""INIT. INV. ASSIGNED:  "";C44"
 S FLDS(33)="29;X;C67"
 S FLDS(35)="27.5,""INV. NAME:  "";C2,.01;X,""TYPE:  "";C44,2;X,""INV. DATE ASSIGNED:  "";C3;1;X,4;C44;X,""INV. REVIEW ASS. TO:  "";C3;,5;X,""DT ASSIGNED:  "";C44,6;X,""INV. REPT. RELEASED:  "";C3,7;X,"" "";C2"
 S FLDS(36)="""INV. APPROVED REPORT REC'D:  "";C2"
 S FLDS(37)="32;X;"""""
 S FLDS(38)="""CORRECTIVE ACTION:  "";C2"
 S FLDS(39)="61,.01;X;C7"
 S FLDS(40)="""COMPLAINT STATUS:  "";C2"
 S FLDS(41)="63;X;C21;L30"
 S FLDS(42)=""" "";C2"
 ;S FLDS(43)="""         * Denotes ongoing computations which are still active"";C2;X"
 S BY="@NUMBER"
 S DHD="EEO COMPLAINANT INQUIRY"
 S (FR,TO)=EEOYLP
 S IOP=EEOYOP
 S (DIE,DIC)="^EEO(785,",DIC(0)="AEQMZ"
 S DIS(0)="I $$SCREEN^EEOEOSE(D0)" D EN1^DIP K DIS(0),IOP S DIC("S")=EEOYSCR
 Q:$E(EEOIOST)'="C"!$D(ZTQUEUED)
 I EEOYLP'=EEOYLAST D
 . S DIR(0)="E",DIR("A")="Hit return to continue" W *7
 . D ^DIR
 . I Y'>0 S EEOYLP=-1 Q
 . W "   ...continuing...one moment please "
 . Q
 Q
