PRCFVEX ;WASH IRMFO/KCMO;Extract Data for DUNS Number; ;8/14/96  11:02
 ;;5.0;IFCAP;**84,83**;4/21/95
 ;
STRT ; -- Loop through Vendors, skip * entries, Max 32k Messages
 N DEBUG,XMCHAN,XMDUZ,XMSUB,XMTEXT,XMY,X,Y,N0,N7,STR,FACID,LEN,MSGNUM,I,ST,ET
 S DEBUG=1 ; Deugging Flag, 1 process
 D NOW^%DTC S Y=% D DD^%DT S ST=Y
 S FACID=$P($G(^XTV(8989.3,1,"XUS")),U,17) ;Default Institution KSP
 I '$D(^PRC(411,"B",FACID)) W !!,"THE 'DEFAULT INSTITUTION' IS NOT DEFINED IN THE KERNEL SITE PARAMETER FILE!",!!,"PLEASE EDIT THIS FIELD BEFORE CONTINUING." Q
 S (MSGNUM,LEN,I)=0 K ^TMP($J)
 S X="" F  S X=$O(^PRC(440,"B",X))  Q:X=""  D  ;
 . S Y=0 F  S Y=$O(^PRC(440,"B",X,Y)) Q:Y<1  I $D(^PRC(440,Y,0))#2 D  ;
 . . S N0=^(0),N7=$G(^(7)) Q:$E(N0)="*"
 . . ; -- Record String will be ^ delimited and layed out as follows:
 . . ; -- FACILITY ID^IFCAP RECNUM^DUNS NUMBER^VENDOR NAME^ \
 . . ; -- VENDOR ADDRESS 1^VENDOR ADDRESS 2^VENDOR ADDRESS 3^ \
 . . ; -- VENDOR ADDRESS 4^CITY^STATE^ZIP^CONTACT NAME^ \
 . . ; -- VENDOR TELEPHONE NUMBER.
 . . S STR=FACID_U_Y_U_$P(N7,U,12)_U_$P(N0,U)_U_$P(N0,U,2)_U_$P(N0,U,3)_U_$P(N0,U,4)_U_$P(N0,U,5)_U_$P(N0,U,6)_U
 . . S STR=STR_$P($G(^DIC(5,+$P(N0,U,7),0)),U)_U_$P(N0,U,8)_U_$P(N0,U,9)_U_$P(N0,U,10)_"|"
 . . S I=I+1,^TMP($J,I,0)=STR,LEN=$L(STR)+LEN I LEN>31000 D MSG
 D MSG,SUMM W !!,"Extract Vendor DUNN's Completed!!" Q
 ;
MSG ; -- Drop a Message
 N X,Y
 Q:'$D(^TMP($J,1,0))#2
 S ^TMP($J,I+1,0)="|$"
 S MSGNUM=MSGNUM+1,XMSUB="Sta "_FACID_" Vendor Extract Part "_MSGNUM
 S XMCHAN="",XMTEXT="^TMP($J,",XMDUZ="VENDOR EXTRACT"
 I $G(DEBUG) W !,"Sending: ",XMSUB
 S XMY("XXX@Q-EDV.MED.VA.GOV")="" D ^XMD ;  Address and Send
 K ^TMP($J) S (LEN,I)=0
 Q
 ;
SUMM ; -- Summary Info
 D NOW^%DTC S Y=% D DD^%DT S ET=Y
 ; Record: FACID^SUM^#Msgs^StartTime^StopTime
 S X(1,0)=FACID_"^SUM^"_MSGNUM_U_ST_U_ET_"|$"
 ;S X(1,0)="Station: "_FACID
 ;S X(2,0)="Transmitted "_MSGNUM_" Messages"
 ;S X(3,0)="Start Time: "_ST
 ;S X(4,0)="Finish Time: "_ET
 S XMSUB="Sta "_FACID_" Vendor Extract Summary"
 S XMCHAN="",XMTEXT="X(",XMDUZ="VENDOR EXTRACT"
 S XMY("POSTMASTER@Q-EDV.MED.VA.GOV")="" D ^XMD ;  Address and Send
 Q
 ;
