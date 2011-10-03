PXRMRPC ; SLC/PJH - PXRM REMINDER GUI - routine for RPC ;12/20/2000
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 Q
 ;
TAG(PXRMY,PXRMTAG,PXRMX) ;Entry point for all RPC calls
 ;
 I PXRMTAG="ALL" D ALL(.PXRMY) Q
 I PXRMTAG="INI" D INI(.PXRMY) Q
 I PXRMTAG="INQ" D REMVAR^PXRMINQ(.PXRMY,PXRMX) Q
 I PXRMTAG="EXC" D EXC(.PXRMY) Q
 I PXRMTAG="CMP" D CMP(.PXRMY,PXRMX) Q
 I PXRMTAG="RPC" D RPC(.PXRMY) Q
 ;
 S PXRMY(1)="-1^INVALID"
 ;
 Q
 ;
 ;
ALL(ORY) ;All active reminders
 ;print name^ien
 N ARR,DATA,NAME,ORREM,OCNT,SUB
 S ORREM=0
 F  S ORREM=$O(^PXD(811.9,ORREM)) Q:'ORREM  D
 .S DATA=$G(^PXD(811.9,ORREM,0)) Q:DATA=""
 .;Skip inactive reminders
 .I $P(DATA,U,6) Q
 .;Skip reminders with no name
 .S NAME=$P(DATA,U,3) I NAME="" Q
 .;Sort by name
 .S ARR(NAME_U_ORREM)=""
 ; Build output arrray
 S SUB="",OCNT=0
 F  S SUB=$O(ARR(SUB)) Q:SUB=""  D
 .S OCNT=OCNT+1
 .S ORY(OCNT)=SUB
 Q
 ;
CMP(PXRMY,IEN) ;List Exchange Repository Entries
 N CNT,DATA,CMPIEN,SUB
 D CDISP^PXRMEXLC(IEN)
 S CNT=0,SUB=""
 F  S SUB=$O(^TMP("PXRMEXLC",$J,SUB)) Q:'SUB  D
 .S DATA=$G(^TMP("PXRMEXLC",$J,SUB,0)) Q:DATA=""  Q:DATA=" "
 .S CMPIEN=$G(^TMP("PXRMEXLC",$J,"IDX",SUB,SUB))
 .S CNT=CNT+1,PXRMY(CNT)=DATA_U_CMPIEN
 Q
 ;
EXC(PXRMY) ;List Exchange Repository Entries
 N CNT,DATA,REPIEN,SUB
 D BLDLIST^PXRMEXLC(0)
 S CNT=0,SUB=""
 F  S SUB=$O(^TMP("PXRMEXLR",$J,SUB)) Q:'SUB  D
 .S DATA=$G(^TMP("PXRMEXLR",$J,SUB,0)) Q:DATA=""
 .S REPIEN=$G(^TMP("PXRMEXLR",$J,"IDX",SUB,SUB))
 .S CNT=CNT+1,PXRMY(CNT)=$P(DATA,"  ",3,99)_U_REPIEN
 Q
 ;
INI(PXRMY) ;Lists available RPC calls
 ;
 S PXRMY(1)="Reminder Maintenance^ALL"
 S PXRMY(2)="Reminder Exchange^EXC"
 S PXRMY(3)="Test RPC^RPC"
 S PXRMY(4)="Other Options^OTH"
 Q
 ;
RPC(PXRMY) ;Test bed
 ;
 D SEL^PXRMRPCD(.PXRMY)
 Q
 ;
XALL(ORY,FROM,DIR) ;All active dialogs
 ;
 ; Input parameters 
 ; FROM - dialog name 
 ; DIR - direction (1/-1) 
 ;
 N CNT,DATA,DIEN,IC,TYPE
 S CNT=44,IC=0
 F  Q:IC'<CNT  S FROM=$O(^PXRMD(801.41,"B",FROM),DIR) Q:FROM=""  D
 .S DIEN=0
 .F  S DIEN=$O(^PXRMD(801.41,"B",FROM,DIEN)) Q:'DIEN  D
 ..S DATA=$G(^PXRMD(801.41,DIEN,0)) Q:DATA=""
 ..;Only reminder dialogs
 ..S TYPE=$P(DATA,U,4) Q:TYPE'="R"
 ..;Skip diabled dialogs
 ..I $P(DATA,U,3)]"" Q
 ..;Sort by name
 ..S IC=IC+1,ORY(IC)=DIEN_U_FROM
 Q
