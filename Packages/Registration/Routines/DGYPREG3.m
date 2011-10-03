DGYPREG3 ;ALB/REW - POST-INIT CONVERSION/REPORTING ;5-APR-93
 ;;5.3;Registration;;Aug 13, 1993
 ;
ENDLOOP ;
 I '$D(DGDOMB)&('$D(DGDOCFL)) N DGDOMB,DGDOCFL S (DGDOMB,DGDOCFL)=1
 I $G(DGDOMB) D
 .D TOTVAREP^DGYPREG1
 .W:'$D(ZTQUEUED) !?5,"You will be receiving a Mail Message indicating records whose "
 .W:'$D(ZTQUEUED) !?5,"monetary benefit amount fields can not be converted into the"
 .W:'$D(ZTQUEUED) !?5,"TOTAL ANNUAL VA CHECK AMOUNT field",!!
 ;
 I $G(DGDOCFL) D
 .D CFLREP^DGYPREG1
 .W:'$D(ZTQUEUED) !?5,"You will be receiving a Mail Message regarding the formatting "
 .W:'$D(ZTQUEUED) !?5,"of your Claim Folder Location fields in the Patient File"
 K DGCFLCN,DGCFLBD,DGTOTCN,DGTOTBD
 Q
