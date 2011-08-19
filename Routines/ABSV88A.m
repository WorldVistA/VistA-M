ABSV88A ;VAMC ALTOONA/CTB - TRANSMIT TT88'S AND TT04'S TO AUSTIN ;4/13/00  12:19 PM
V ;;4.0;VOLUNTARY TIMEKEEPING;**7,11,18**;JULY 6, 1994
 NEW %,%W,%X,%Y,COUNT,D,D0,D1,DA,DI,DIC,DIE,DQ,DR,I,MSGNUM,N,X,XCNP,XMDUZ,XMZ
 D ^ABSVSITE Q:'%
 S ABSVXA="This program will transmit master record changes made on your DHCP system, to the Austin DPC.",ABSVXA(1)="",ABSVXA(2)="Do you wish to proceed",%=1,ABSVXB=""
 D ^ABSVYN I %'=1 S X="<No Action Taken>" D MSG^ABSVQ,OUT QUIT
 ;BUILD LIST OF RECORDS NEEDING TT88'S TRANSMITTED TO AUSTIN.
 D WAIT^ABSVYN W ! S X="Updating the SEX field for Volunteers from B/G to M/F." D MSG^ABSVQ
 D ^ABSVBGMF W !!
 D WAIT^ABSVYN
 W ! S X="Searching file for Master Records requiring TT 88's." D MSG^ABSVQ
 K ^TMP($J,"ABSVTT88"),^TMP($J,"ABSVLIST")
 S DA=0 F  S DA=$O(^ABS(503330,"AF",1,DA)) Q:'DA  I $D(^ABS(503330,"AF",1,DA,ABSV("INST"))) S ^TMP($J,"ABSVLIST",DA)=""
 S DA=0 F  S DA=$O(^ABS(503330,"AG",1,DA)) Q:'DA  I $D(^ABS(503330,"AG",1,DA,ABSV("INST"))) S ^TMP($J,"ABSVLIST",DA)=""
 S DA=0,MSGNUM=1 F  D  Q:'DA  S MSGNUM=MSGNUM+1
 . F COUNT=1:1:150 S DA=$O(^TMP($J,"ABSVLIST",DA)) Q:'DA  S ^TMP($J,"ABSVTT88",ABSV("INST"),MSGNUM,COUNT,0)=$$ONE^ABSV88(DA,ABSV("INST"),ABSV("SITE")) W "."
 . QUIT
 I '$D(^TMP($J,"ABSVTT88")) S X="There are no master records on file requiring TT 88's for transmission to Austin.  No further action taken." D MSG^ABSVQ
 S MSGNUM=0 F  S MSGNUM=$O(^TMP($J,"ABSVTT88",ABSV("INST"),MSGNUM)) Q:'MSGNUM  D
 . S XMDUZ=$S($G(DUZ)]"":DUZ,1:.5),XMSUB="VOLUNTARY TRANSACTION TYPE 88'S - "_ABSV("SITE"),XMTEXT="^TMP("_$J_",""ABSVTT88"","_ABSV("INST")_","_MSGNUM_","
 . S XMY("XXX@Q-NST.VA.GOV")=""
 . S XMY("G.NST")=""
 . D ^XMD
 . W !,XMZ," - Message Filed"
 . QUIT
 ;DELETE CROSS REFERENCES FOR TT88 AND 04'S
 F  S DA(1)=$O(^TMP($J,"ABSVLIST",0)) Q:'DA(1)  D
 . S DIE="^ABS(503330,"_DA(1)_",4,",DA=ABSV("INST"),DR="11///@;12///@;13////0;14///@;15///@;16///@;17///@;8///@" D ^DIE
 . K ^TMP($J,"ABSVLIST",DA(1))
 . W "." QUIT
 QUIT
OUT QUIT
