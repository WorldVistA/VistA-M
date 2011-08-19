RCAMADD ;WASH-ISC@ALTOONA,PA/RGY-Get debtor address ;10/8/96  5:15 PM
V ;;4.5;Accounts Receivable;**34,190**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;Get AR Debtor Address
 ; Input:
 ;   RCDB - Pointer to AR DEBTOR file #340
 ;   RCCONF (optional) - Confidential Address required, if applicable. 1-yes, 0(default)-no.
 ; Returns Debtor Address:
 ;   Str1^Str2^Str3^City^State^ZIP^Telephone^Forein Country Code
DADD(RCDB,RCCONF) ;
 N X
 S X="" G:$G(RCDB)="" Q
 I RCDB?1N.N S RCDB=$P($G(^RCD(340,RCDB,0)),"^")
 ; the confidential address has greatest priority for mailing
 I $G(RCCONF),RCDB["DPT(" S X=$$PAT(+RCDB,1) I X'="" G Q
 ; the AR DEBTOR address (if exists) has a greater priority the permanent address in PATIENT file.
 I RCDB["DPT(" S X=$$ARDEB(+$O(^RCD(340,"B",RCDB,0))) I ($P(X,U)'=""),($P(X,U,4)'=""),($P(X,U,5)'=""),(($P(X,U,6)'="")!($P(X,U,8)'="")) G Q
 I RCDB["DPT(" S X=$$PAT(+RCDB,0) G Q
 I RCDB["DIC(4" S X=$$INST(+RCDB) G Q
 I RCDB["PRC(440," S X=$$VEN(+RCDB) G Q
 I RCDB["DIC(36," S X=$$INSUR(+RCDB) G Q
 I RCDB["VA(200," S X=$$PER(+RCDB)
Q Q X
PER(RCDB) ;Get person address
 N X,Y
 S X="" G:'$D(^VA(200,+$G(RCDB),0)) Q1
 S Y=$S($D(^VA(200,RCDB,.11)):^(.11),1:"") F I=1:1:6 S $P(X,"^",I)=$P(Y,"^",I)
 S:$D(^VA(200,RCDB,.13)) $P(X,"^",7)=$P(^(.13),"^")
 S $P(X,"^",5)=$P($G(^DIC(5,+$P(X,"^",5),0)),"^",2)
Q1 Q X
INST(RCDB) ;Get institution address
 N X,Y
 S X="" G:'$D(^DIC(4,+$G(RCDB),0)) Q2
 S $P(X,"^",5)=$P(^DIC(4,RCDB,0),"^",2),Y=$S($D(^DIC(4,RCDB,1)):^(1),1:""),$P(X,"^")=$P(Y,"^"),$P(X,"^",2)=$P(Y,"^",2),$P(X,"^",4)=$P(Y,"^",3),$P(X,"^",6)=$P(Y,"^",4)
 S $P(X,"^",5)=$P($G(^DIC(5,+$P(X,"^",5),0)),"^",2)
Q2 Q X
 ;
PAT(RCDB,RCCONF) ;Get patient address as "Str1^Str2^Str3^City^State^ZIP^Telephone" from ^DPT
 ; if RCCONF=0 (default), then return patients permanent address
 ; if RCCONF=1, then return confidential address, or NULL
 N DFN,VAERR,VAPA,RCX,RCY,X
 I '$D(^DPT(+$G(RCDB),0)) S RCX="" G Q3
 S RCCONF=+$G(RCCONF) ; confidential address flag
 S DFN=RCDB D ADD^VADPT
 S RCX=""
 ;
 I 'RCCONF D
 . F RCY=1,2,3,4 S $P(RCX,"^",RCY)=VAPA(RCY)
 . S $P(RCX,"^",5)=$P($G(^DIC(5,+$P(VAPA(5),"^"),0)),"^",2)
 . S $P(RCX,"^",6)=$P($G(VAPA(11)),"^")
 ;
 ; is the confidential address available? Return NULL if not.
 I RCCONF S RCX="" G:'$G(VAPA(12)) Q3  G:($P($G(VAPA(22,3)),U,3)'="Y") Q3  D
 . F RCY=1,2,3,4 S $P(RCX,"^",RCY)=VAPA(RCY+12)
 . S $P(RCX,"^",5)=$P($G(^DIC(5,+$P(VAPA(17),"^"),0)),"^",2)
 . S $P(RCX,"^",6)=$P($G(VAPA(18)),"^")
 S $P(RCX,"^",7)=VAPA(8) ; Telephone
Q3 Q RCX
VEN(RCDB) ;Get vendor address
 NEW X,Y,I
 S X="" G:'$D(^PRC(440,+$G(RCDB),0)) Q4
 S Y=$S($D(^PRC(440,RCDB,.11)):^(.11),1:"") F I=1:1:7 S $P(X,"^",I)=$P(Y,"^",I)
 S $P(X,"^",5)=$P($G(^DIC(5,+$P(X,"^",5),0)),"^",2)
Q4 Q X
INSUR(RCDB) ;Get insurance company address
 NEW X,Y,I
 S X="" G:'$D(^DIC(36,+$G(RCDB),0)) Q5
 S Y=$S($D(^DIC(36,RCDB,.11)):^(.11),1:"") F I=1:1:6 S $P(X,"^",I)=$P(Y,"^",I)
 S:$D(^DIC(36,RCDB,.13)) $P(X,"^",7)=$P(^(.13),"^",2)
 S $P(X,"^",5)=$P($G(^DIC(5,+$P(X,"^",5),0)),"^",2)
Q5 Q X
ARDEB(RCDB) ;Get address from AR Debtor file (340)
 NEW X,Y
 S X="" G:'$D(^RCD(340,+$G(RCDB),0)) Q6 S X=$P($G(^RCD(340,RCDB,1)),"^",1,8)
 S $P(X,"^",5)=$P($G(^DIC(5,+$P(X,"^",5),0)),"^",2)
Q6 Q X
