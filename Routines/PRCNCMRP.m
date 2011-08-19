PRCNCMRP ;SSI/SEB,ALA-CMR Official Priority Handler ;[ 01/23/97   4:52 PM ]
 ;;1.0;Equipment/Turn-In Request;**2,5**;Sep 13, 1996
 Q
EN ;Check on entered priority
 K:+X'=X!(X>999)!(X<1)!(X?.E1"."1N.N) X
 I $G(X)="" Q
 ; Check if priority X already exists for this service
 D:'$D(PSER) PRIMAX
 S PRCNX=$P($G(^PRCN(413,DA,2)),U,18)
 I PRCNX'="" K ^PRCN(413,"P",PSER,PRCNX,DA)
 K PRCNX
 Q:'$D(^PRCN(413,"P",PSER,X))
 Q:$D(^PRCN(413,"P",PSER,X,DA))
 NEW I
 I $D(^PRCN(413,"P",PSER,X)) S START=X D DOWN S DA=ORGDA
 K START,ORGDA
 Q
DOWN ; Insert this transaction & shift others one priority #
 W !!,"Reprioritizing this CMR's requests... Hold on..."
 D PRIMAX S LPRI=LPRI+1 S ORGDA=DA NEW DA S DA=ORGDA
 S ^PRCN(413,"P",PSER,START,ORGDA)=""
 S NXPR=START D GETDA
 I OTHDA'="",OTHDA'=DA S NXPR=START D GETPR
 K OTHDA,DA,NXPR,START,OLDA
 Q
XREF ; Special MUMPS cross-reference for priorities
 S PRCNX=$G(X)
 S X=$P($G(^PRCN(413,DA,2)),U,18)
 D:'$D(PSER) PRIMAX
 I X="",$G(PRCNX)'="" K ^PRCN(413,"P",PSER,PRCNX,DA),PRCNX Q
XR S STAT=$P(^PRCN(413,DA,0),U,7),SK=0
 I STAT<5!(STAT>10) S SK=1
 I STAT=31!(STAT=45)!(STAT=3)!(STAT=27) S SK=0
 I SK=0 S ^PRCN(413,"P",PSER,X,DA)=""
 I SK=1 K ^PRCN(413,"P",PSER,X,DA)
 K PSER,SK,STAT
 Q
PRIMAX ; Calculate lowest priority. Used in input template, etc.
 ; Returns OLDPRI, PSER, SERV, LPRI, and PRIMAX.
 S OLDPRI=$P($G(^PRCN(413,DA,2)),U,18),PSER=$P($G(^PRCN(413,DA,0)),U,3)
 S (II,PRIMAX)=0 S:PSER'="" SERV=$P(^DIC(49,PSER,0),U)
 I PSER'="" F  S II=$O(^PRCN(413,"P",PSER,II)) Q:II=""  S PRIMAX=PRIMAX+1,LPRI=II
 I +OLDPRI'=0 S PRIMAX=+OLDPRI Q
 I +OLDPRI=0,$G(LPRI)="" S (PRIMAX,LPRI)=0 Q
 I +OLDPRI=0,$G(LPRI)'="" S PRIMAX=LPRI
 K II
 Q
DPRI ; Display priorities. Called as special help for priority fld.
 I $G(SERV)=""!($G(PSER)="") D PRIMAX
 W !!,"Priority list for ",SERV,":"
 S PRCNI=0 F  S PRCNI=$O(^PRCN(413,"P",PSER,PRCNI)) Q:'+PRCNI  D
 . S J=$O(^PRCN(413,"P",PSER,PRCNI,""))
 . I $G(^PRCN(413,J,0))="" K ^PRCN(413,"P",PSER,PRCNI,J) Q
 . W !,PRCNI,?8,$P(^PRCN(413,J,0),U),?25,$P(^(0),U,18)
 K PRCNI,J
 Q
GETPR S NXPR=$O(^PRCN(413,"P",PSER,NXPR))
 I NXPR'=(START+1) S NXPR=START+1 D SETDA Q
 I NXPR=(START+1) D SETDA S START=NXPR,DA=OTHDA D GETDA G GETPR
 Q
SETDA S $P(^PRCN(413,OTHDA,2),U,18)=NXPR,^PRCN(413,"P",PSER,NXPR,OTHDA)=""
 K ^PRCN(413,"P",PSER,START,OTHDA)
 Q
GETDA S OLDA="" F  S OLDA=$O(^PRCN(413,"P",PSER,NXPR,OLDA)) Q:OLDA=""  S:OLDA'=DA OTHDA=OLDA
 Q
