SD53P530 ;ALB/TH - SD*5.3*530 POST INIT; 05/22/08
 ;;5.3;SCHEDULING;**530**;AUG 13, 1993;Build 8
 ;
 ;This routine updates:
 ; 1. TYPE SCREEN field (#7) for PERF MONITOR DATE SIGNED (PMDT)
 ; 2. TYPE WHERE field (#6) for PERF MONITOR ACCEPTABLE
 ;    PROVIDER (PMPR)
 ;in the ACRP REPORT TEMPLATE PARAMETER file (#409.92).
 Q
 ;
POST ;$O thru minor category
 ; Update field 7 for PMDT in 409.92
 D BDT
 S OK=0
 S MC=0 F  S MC=$O(^SD(409.92,"C",MC)) Q:MC=""  D
 . I MC["DATE SIGNED" D
 . . S D0=0 F  S D0=$O(^SD(409.92,"C",MC,D0)) Q:D0=""  D
 . . . I $G(^SD(409.92,D0,8))="" D UPDATE
 D ADT
 K MC,D0,OK
 ;
 ; Update field 6 for PMPR in 409.92
 D BPR
 S POP=0
 S PRMC=0 F  S PRMC=$O(^SD(409.92,"C",PRMC)) Q:PRMC=""  D
 . I PRMC["ACCEPTABLE PROVIDER" D
 . . S PRD0=0 F  S PRD0=$O(^SD(409.92,"C",PRMC,PRD0)) Q:PRD0=""  D
 . . . I $E($G(^SD(409.92,PRD0,7)),1)=" " D UPDATE1
 D APR
 K POP,PRMC,PRD0
 Q
 ;
BDT ; Before update message
 N DA,DR,DIE,TYPSCR
 N SDA
 S SDA(1)=""
 S SDA(2)=">>> This installation will update the TYPE SCREEN field (#7)"
 S SDA(3)="    for PERF MONITOR DATE SIGNED (PMDT) in the ACRP REPORT"
 S SDA(4)="    TEMPLATE PARAMETER file (#409.92)."
 S SDA(5)=""
 D ATADDQ
 Q
 ;
UPDATE ; Update ACRP REPORT TEMPLATE PARAMETER file #409.92, field #7.
 S DA=D0
 S TYPSCR="DO^2971001:DT:EPX"
 S DR="7///^S X=TYPSCR"
 S DIE="^SD(409.92,"
 D ^DIE
 S OK=1
 Q
 ;
ADT ; After update message
 N SDA
 S SDA(1)=""
 I OK S SDA(2)=">>> TYPE SCREEN field (#7) updated successfully."
 I 'OK D
 . S SDA(2)=">>> The value for DATE SIGNED is correct. "
 . S SDA(2)=SDA(2)_"No change done."
 S SDA(3)=""
 D ATADDQ
 Q
 ;
BPR ; Before update message
 N DA,DR,DIE,TYPWHERE
 N SDA
 S SDA(1)=""
 S SDA(2)=">>> This installation will remove the extra space for the TYPE WHERE field (#6)"
 S SDA(3)="    for PERF MONITOR ACCEPTABLE PROVIDER (PMPR) in the ACRP REPORT"
 S SDA(4)="    TEMPLATE PARAMETER file (#409.92)."
 S SDA(5)=""
 D ATADDQ
 Q
 ;
UPDATE1 ; Update ACRP REPORT TEMPLATE PARAMETER file #409.92, field #6.
 S DA=PRD0
 S TYPWHERE="^VA(200,"
 S DR="6////^S X=TYPWHERE"
 S DIE="^SD(409.92,"
 D ^DIE
 S POP=1
 Q
 ;
APR ; After update message
 N SDA
 S SDA(1)=""
 I POP S SDA(2)=">>> TYPE WHERE field (#6) updated successfully."
 I 'POP D
 .S SDA(2)=">>> The value for ACCEPTABLE PROVIDER is correct. "
 .S SDA(2)=SDA(2)_"No change done."
 S SDA(3)=""
 D ATADDQ
 Q
 ;
ATADDQ ; Display message
 D MES^XPDUTL(.SDA)
 K SDA
 Q
