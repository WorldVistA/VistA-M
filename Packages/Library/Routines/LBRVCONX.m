LBRVCONX ;SSI/ALA/JSR-Convert data for conso Part 2 ;[ 05/02/2000  5:28 PM ]
 ;;2.5;Library;**8**;Mar 11, 2000
 ;
 ;  Convert pointers of other pointed to files that are
 ;  not being moved and convert them to text with a '*'
 ;  includes Service and Vendor pointers.
TF S TDA=0 F I="B","C","D","E","F","H" K ^A7RLBRY(LBRWSTA,680.5,I)
 ;
EN S LDA=0 D MES^LBRPUTL("Converting pointers in File 680.4")
NME S LDA=$O(^A7RLBRY(LBRWSTA,680.4,LDA)) G VN:LDA'>0
 S SRV=$P(^A7RLBRY(LBRWSTA,680.4,LDA,0),U,2)
 I SRV'="",SRV>0 D
 . S DIC(0)="N",DIC="^DIC(49,",X=SRV D ^DIC
 . I +Y>0 S SERV=$P(Y,U,2),$P(^A7RLBRY(LBRWSTA,680.4,LDA,0),U,2)=SERV_"*"
 G NME
 ;
VN ;
 ;
NX S LDA=0 D MES^LBRPUTL("Converting pointers in File 681")
NVN S LDA=$O(^A7RLBRY(LBRWSTA,681,LDA)) G US:LDA'>0
 S USR=$P($G(^A7RLBRY(LBRWSTA,681,LDA,1)),U,3)
 I USR'="",USR>0,$G(^VA(200,USR,0))'="" S USER=$P(^VA(200,USR,0),U),$P(^A7RLBRY(LBRWSTA,681,LDA,1),U,3)=USER_"*"
 G NVN
 ;
US S LDA=0 D MES^LBRPUTL("Converting pointers in File 682")
USR S LDA=$O(^A7RLBRY(LBRWSTA,682,LDA)) G QUIT:LDA'>0
 S USR=$P($G(^A7RLBRY(LBRWSTA,682,LDA,1)),U,6)
 I USR'="",USR>0,$G(^VA(200,USR,0))'="" S USER=$P(^VA(200,USR,0),U)_"*",$P(^A7RLBRY(LBRWSTA,682,LDA,1),U,6)=USER
 ;
 S ODA=0 F  S ODA=$O(^A7RLBRY(LBRWSTA,682,LDA,4,ODA)) Q:ODA'>0  D
 . S USR=$P($G(^A7RLBRY(LBRWSTA,682,LDA,4,ODA,0)),U,4)
 . I USR'="",USR>0,$G(^VA(200,USR,0))'="" S $P(^A7RLBRY(LBRWSTA,682,LDA,4,ODA,0),U,4)=$$GET1^DIQ(200,USR,.01,"E")_"*"
 . S USR=$P($G(^A7RLBRY(LBRWSTA,682,LDA,4,ODA,0)),U,8)
 . I USR'="",USR>0,$G(^VA(200,USR,0))'="" S USER=$P(^VA(200,USR,0),U)_"*",$P(^A7RLBRY(LBRWSTA,682,LDA,4,ODA,0),U,8)=USER
 I USR'="",USR>0,$G(^VA(200,USR,0))'="" S USER=$P(^VA(200,USR,0),U),$P(^A7RLBRY(LBRWSTA,682,LDA,1),U,6)=USER
 G USR
QUIT ;
 M ^A7RLBRY(LBRWSTA,"LBRV",0)=^XTMP("LBRV",0)
 Q
 ;
