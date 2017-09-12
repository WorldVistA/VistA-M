QAN26PRE ;;WCIOFO/ERC - Pre-install for QAN*2*26 ;7/23/99
 ;;2.0;Incident Reporting;**26**;08/07/1992
 ;
 ;This routine will eliminate two fields from the QA INCIDENTS FILE
 ;(file 742.1) that refer to regions.  It will also set to null the
 ;data in these fields.  The fields are .03 - E-MAIL TO REGION and
 ;.05 NOTIFY RD BY PHONE (IMMEDIATE).
 ;
NULL ;sets to null any data in .03 or .05
 N QANAA
 S QANAA=0
 F  S QANAA=$O(^QA(742.1,QANAA)) Q:QANAA'>0  D
 . S $P(^QA(742.1,QANAA,0),U,3)=""
 . S $P(^QA(742.1,QANAA,0),U,5)=""
 ;
DELE ;delete the fields
 S DIK="^DD(742.1,",DA(1)=742.1
 F DA=.03,.05 D ^DIK
 K DA,DIK
 Q
