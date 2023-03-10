PRC51225 ;OI&T/LKG - ENV AND POST-INIT ;11/2/21  10:51
V ;;5.1;IFCAP;**225**;Oct 20, 2000;Build 3
 ;Per VA Directive 6402, this routine should not be modified.
ENV ;Check the configuration and issue warning if wrong
 Q:$$PROD^XUPROD
 N PRCA
 S PRCA(1)=" ",PRCA(2)="Warning: The FINANCIAL MANAGEMENT BATCH DOMAIN MAIL ROUTER value"
 S PRCA(3)="is inconsistent with PRODUCTION/TEST type of this VistA account."
 S PRCA(4)="If you are testing this patch in a Mirror/Test account, please change"
 S PRCA(5)="'Q-FMS.DOMAIN.EXT' to 'Q-FMT.DOMAIN.EXT' before testing."
 D:'$$CONFIGCK EN^DDIOL(.PRCA)
 Q
 ;
 ;ICR 7309 GENERIC CODE SHEET BATCH TYPE LOOKUP
 ; Returns '1' if correct and '0' if not
CONFIGCK() ;Checks if Prod/Test setting and GECS Financial Management Domain
 ;are compatible
 N PRCX,PRCY,PRCERR,PRCDOM
 S PRCX=$$KSP^XUPARAM("WHERE"),PRCY=$L(PRCX,".")
 I $P(PRCX,".",PRCY-1,PRCY)'="DOMAIN.EXT" Q 1
 S PRCX=$$FIND1^DIC(2101.1,,"B","FINANCIAL MANAGEMENT",,,"PRCERR")
 Q:PRCX'>0 0 Q:$D(PRCERR) 0
 S PRCX=","_PRCX_","
 S PRCY=$$FIND1^DIC(2101.12,PRCX,"B","XXX",,,"PRCERR"),PRCX=PRCY_PRCX
 I $D(PRCERR)!(PRCY'>0) Q 0
 S PRCDOM=$$GET1^DIQ(2101.12,PRCX,1,,,"PRCERR") K PRCERR
 S PRCY=0
 I PRCDOM=$S($$PROD^XUPROD:"Q-FMS.DOMAIN.EXT",1:"Q-FMT.DOMAIN.EXT") S PRCY=1
 Q PRCY
 ;
POST ; Check configuration and write to installation warning if wrong
 Q:$$PROD^XUPROD
 N PRCA
 S PRCA(1)=" ",PRCA(2)="Warning: The FINANCIAL MANAGEMENT BATCH DOMAIN MAIL ROUTER value"
 S PRCA(3)="is inconsistent with PRODUCTION/TEST type of this VistA account."
 S PRCA(4)="If you are testing this patch in a Mirror/Test account, please change"
 S PRCA(5)="'Q-FMS.DOMAIN.EXT' to 'Q-FMT.DOMAIN.EXT' before testing."
 D:'$$CONFIGCK MES^XPDUTL(.PRCA)
 Q
