PXRMOBJ ;SLC/JVS - PXRM OBJECT AND GUI EVAL FOR GEC ;7/14/05  07:34
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;
 Q
 ;
STAT(DFN) ;Status Object
 N STATUS,CNT,I,MISSING,CMARRAY,K
 S CNT=0
 D STATUS^PXRMOBJX(DFN,.STATUS,.MISSING)
 K ^TMP("PXRMOBJSTATUS",$J)
 S CMARRAY="^TMP(""PXRMOBJSTATUS"",$J)"
 S I=0 F  S I=$O(STATUS(I)) Q:I=""  D
 .S K=0 F  S K=$O(STATUS(I,K)) Q:K=""  D
 ..S ^TMP("PXRMOBJSTATUS",$J,$$UP,0)=STATUS(I,K)
 S ^TMP("PXRMOBJSTATUS",$J,$$UP,0)=""
 Q "~@"_$NA(@CMARRAY)
 ;
UP() ;
 S CNT=CNT+1
 Q CNT
 ;
DEM(DFN) ;
 Q:DFN=""
 N X,ARY
 N ZIP,DATA
 D GET
 K ^TMP("PXRMOBJ",$J)
 S CMARRAY="^TMP(""PXRMOBJ"",$J)"
 S ^TMP("PXRMOBJ",$J,1,0)=""
 S ^TMP("PXRMOBJ",$J,2,0)="                 Name: "_DATA("NAME")_"  "_"Gender: "_DATA("SEX")
 S ^TMP("PXRMOBJ",$J,3,0)="                  DOB: "_DATA("DOB")_"  "_"Age:"_DATA("AGE")
 S ^TMP("PXRMOBJ",$J,4,0)="       Marital Status: "_DATA("MARSTAT")
 S ^TMP("PXRMOBJ",$J,5,0)="              Address: "_DATA("STRAD1")
 I DATA("STRAD2")'="" S ^TMP("PXRMOBJ",$J,6,0)="                       "_DATA("STRAD2")
 I DATA("STRAD3")'="" S ^TMP("PXRMOBJ",$J,7,0)="                       "_DATA("STRAD3")
 S ^TMP("PXRMOBJ",$J,8,0)="                       "_DATA("CITY")_" "_DATA("STATE")_" "_ZIP
 S ^TMP("PXRMOBJ",$J,9,0)="              H Phone: "_DATA("PHONER")
 S ^TMP("PXRMOBJ",$J,10,0)="              W Phone: "_DATA("PHONEW")
 S ^TMP("PXRMOBJ",$J,11,0)="  Service Connected %: "_DATA("SERCON")
 S ^TMP("PXRMOBJ",$J,12,0)="    LTC Co-Pay Status: "_DATA("STATUS")
 I DATA("STATUS DATE")'["<No Test>" D
 .S ^TMP("PXRMOBJ",$J,13,0)="      LTC Date Tested: "_DATA("STATUS DATE")
 I $D(DATA("WHY")) D
 .S ^TMP("PXRMOBJ",$J,13,0)="               Reason: "_DATA("WHY")
 S ^TMP("PXRMOBJ",$J,14,0)=""
 ; NODE MUST END WITH ZERO SUBSCRIPT
 ; @CMARRAY@(CNT,0)=TEXT
 D EXIT
 Q "~@"_$NA(@CMARRAY)
 ;
GET ; Get data from file
 N FIELDS,STATUS,DFN2,STAT
 ;DBIA #11
 ;S DFN=75
 S FIELDS=".01;.02;.03;.033;.05;.111;.1112;.112;.113;.114;.115;.116;.131;.132;.302;.3621;.3622;.3624;.3626;.3627;.3628;.3629;.36295"
 D GETS^DIQ(2,DFN,FIELDS,"ER","^TMP(""PXRMGECOBJ"",$J)")
 ;
 S ARY="^TMP(""PXRMGECOBJ"",$J,2)",DFN2=DFN_","
 ;
 S DATA("AGE")=@ARY@(DFN2,"AGE","E")
 S DATA("AMOUNTAA")=@ARY@(DFN2,"AMOUNT OF AID & ATTENDANCE","E")
 S DATA("AMOUNTGI")=@ARY@(DFN2,"AMOUNT OF GI INSURANCE","E")
 S DATA("AMOUNTHO")=@ARY@(DFN2,"AMOUNT OF HOUSEBOUND","E")
 S DATA("AMOUNTOT")=@ARY@(DFN2,"AMOUNT OF OTHER INCOME","E")
 S DATA("AMOUNTOR")=@ARY@(DFN2,"AMOUNT OF OTHER RETIREMENT","E")
 S DATA("AMOUNTSS")=@ARY@(DFN2,"AMOUNT OF SSI","E")
 S DATA("AMOUNTVA")=@ARY@(DFN2,"AMOUNT OF VA PENSION","E")
 S DATA("CITY")=@ARY@(DFN2,"CITY","E")
 S DATA("DOB")=@ARY@(DFN2,"DATE OF BIRTH","E")
 S DATA("MARSTAT")=@ARY@(DFN2,"MARITAL STATUS","E")
 S DATA("NAME")=@ARY@(DFN2,"NAME","E")
 S DATA("PHONER")=@ARY@(DFN2,"PHONE NUMBER [RESIDENCE]","E")
 S DATA("PHONEW")=@ARY@(DFN2,"PHONE NUMBER [WORK]","E")
 S DATA("SERCON")=@ARY@(DFN2,"SERVICE CONNECTED PERCENTAGE","E")
 S DATA("SEX")=@ARY@(DFN2,"SEX","E")
 S DATA("STATE")=@ARY@(DFN2,"STATE","E")
 S DATA("STRAD1")=@ARY@(DFN2,"STREET ADDRESS [LINE 1]","E")
 S DATA("STRAD2")=@ARY@(DFN2,"STREET ADDRESS [LINE 2]","E")
 S DATA("STRAD3")=@ARY@(DFN2,"STREET ADDRESS [LINE 3]","E")
 S DATA("TOTAL")=@ARY@(DFN2,"TOTAL ANNUAL VA CHECK AMOUNT","E")
 S DATA("ZIP")=@ARY@(DFN2,"ZIP CODE","E")
 S DATA("ZIP4")=@ARY@(DFN2,"ZIP+4","E")
 S ZIP="" D
 .I DATA("ZIP4")'="" S ZIP=DATA("ZIP4") Q
 .I DATA("ZIP")'="" S ZIP=DATA("ZIP")
 S DATA("SUM")=DATA("AMOUNTAA")+DATA("AMOUNTGI")+DATA("AMOUNTHO")+DATA("AMOUNTOT")+DATA("AMOUNTSS")+DATA("AMOUNTVA")
 I DATA("SUM")=0 S DATA("SUM")=""
 ;get LTC CO-PAY TEST status
 S (DATA("STATUS"),DATA("STATUS DATE"))="<No Test>"
 S STAT=$$EXMPT(DFN)
 I STAT=0 S DATA("STATUS")="NON EXEMPT"
 I STAT>0 S DATA("STATUS")="EXEMPT"
 I STAT=1 S DATA("WHY")="Veteran has compensable SC disability."
 I STAT=2 S DATA("WHY")="Veteran is single NSC pensioner."
 ;DBIA #701
 S STATUS=$$LST^EASECU(DFN,"",3) D
 .I STATUS'="" D
 ..S DATA("STATUS")=$P(STATUS,"^",3)
 ..S DATA("STATUS DATE")=$$FMTE^XLFDT($P(STATUS,"^",2))
 Q
 ;
EXMPT(DFN) ;Check if veteran is exempt from LTC co-payments:
 ; If the veteran has a compensable SC disability, OR
 ; If the veteran is a single, NSC pensioner not in receipt of A&A
 ; and HB benefits
 ;   Input   -- DFN  Patient IEN
 ;   Output  -- 0 = veteran not exempt
 ;              1 = veteran has compensable SC disability
 ;              2 = veteran is single NSC pensioner (no A&A, HB)
 N X,Y,ELG
 S Y=0
 ; if service connected percentage is greater than 10% OR service
 ; connected percentage is less than 10% and annual VA
 ; check amount is greater than 0, then exempt type 1
 S X=$G(^DPT(DFN,.36)),ELG=$P($G(^DIC(8,+X,0)),U,9)
 I ELG=1!($P($G(^DPT(DFN,.3)),U,2)'<10) S Y=1 G EXMPTQ
 I ELG=3,$P($G(^DPT(DFN,.3)),U,2)<10,$P($G(^DPT(DFN,.362)),U,20)>0 S Y=1
 G EXMPTQ
 ; if Service Connected quit
 I $P($G(^DPT(DFN,.3)),U)="Y" G EXMPTQ
 ; if Marital Status = 'Married' or 'Separated' quit
 S X=$P($G(^DIC(11,+$P($G(^DPT(DFN,0)),U,5),0)),U,3)
 I "^M^S^"[("^"_X_"^") G EXMPTQ
 ; if not receiving VA pension quit
 S X=$G(^DPT(DFN,.362)) I $P(X,U,14)'="Y" G EXMPTQ
 ; if receiving A&A or HP benefits quit
 I $P(X,U,12)="Y"!($P(X,U,13)="Y") G EXMPTQ
 S Y=2
EXMPTQ Q Y
        ;
EXIT ;
 K ^TMP("PXRMGECOBJ",$J)
