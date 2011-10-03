LBRYSEND ;SSI/ALA - SEND TRANSACTIONS TO FORUM ;[ 04/19/2000  10:44 AM ]
 ;;2.5;LIBRARY;**8,11**;Mar 11, 1996
 ;
 K ^TMP("LBRY")
 S STN=$P(^DIC(4,$P(^XMB(1,1,"XUS"),U,17),99),U),REF="           "
 ;
 S N=""
 F  S N=$O(^LBRY(682.1,"AC","W",N)) Q:N=""  D
 . S LBRYTYP=$$GET1^DIQ(682.1,N,1,"E")
 . D CR
 K N,IN,J,M,NUM,REF,STN,JDT,JTM
 Q
 ;
CR ; Create UTILITY global for transaction
 S JDTM=$$NOW^XLFDT(),NUM=10000
 S JDT=$$JDN^LBRYUTL($P(JDTM,".")),JTM=$P(JDTM,".",2) K JDTM
 S ^TMP("LBRY",NUM,0)="LIB^"_STN_"^^"_LBRYTYP_U_JDT_U_JTM_U_REF_"^001^001^001^|"
 ;
 ;  If LTF
 I LBRYTYP="LTF" D
 . S M=0 D NN
 ;
 Q
 ;
NN S M=$O(^LBRY(682.1,N,M))
 I M'>0 S NUM=NUM+1,^TMP("LBRY",NUM,0)="$",XMSUB="LOCAL SERIAL TITLE REQUEST" D XM Q
 I M<6,$G(^LBRY(682.1,N,M))'="" D
 . S IN=$S(M=1:"TI",1:"T"_M)
 . S NUM=NUM+1,^TMP("LBRY",NUM,0)=IN_U_^LBRY(682.1,N,M)
 . I M=1 S $P(^TMP("LBRY",NUM,0),U,6,7)=N
 I M=6,$D(^LBRY(682.1,N,M))'=0 D
 . S IN="T5",J=0 F  S J=$O(^LBRY(682.1,N,M,J)) Q:J'>0  S NUM=NUM+1,^TMP("LBRY",NUM,0)=IN_U_J_U_^LBRY(682.1,N,M,J,0)
 I M=7,$D(^LBRY(682.1,N,M))'=0 D
 . S IN="T6",J=0 F  S J=$O(^LBRY(682.1,N,M,J)) Q:J=""  S NUM=NUM+1,^TMP("LBRY",NUM,0)=IN_U_J_U_^LBRY(682.1,N,M,J,0)
 G NN
 ;
XM ; Take all transactions waiting for transmission and pass
 ; them to MailMan for transmission to FORUM
 S TRNSM=$S($G(^XMB("NETNAME"))["SENTIENT":"VISTA.SENTIENTCONSULT.COM",1:"FORUM.VA.GOV")
 S XMDUZ=^XMB("NETNAME"),XMY("S.LBRYFSRV@"_TRNSM)=""
 S XMTEXT="^TMP(""LBRY"","
 D ^XMD
 ;
 ; Delete messages
 I XMZ'<1 D   ; If message # returns from last send - then delete it.
 .S XMSER="S.LBRYSRV" D REMSBMSG^XMA1C K XMSER
 ;
 S DIC="^LBRY(682.1,",DIE=DIC,DA=N,DR="2///^S X=""T""" D ^DIE
 K ^TMP("LBRY"),TRNSM,XMZ
 Q
