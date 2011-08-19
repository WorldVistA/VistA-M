FBPATDAT ;WOIFO/SS-NOTIFICATION ABOUT PATIENT DATA CHANGE ;4/7/2003
 ;;3.5;FEE BASIS;**57,70**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
CHNG ;entry point
 I $G(DGFILE)=2.141 D UPDADR($G(DGDA)) Q  ;CONFIDENTIAL ADDRESS CATEGORY subfile fields
 Q:$G(DGFILE)'=2
 N FBFLAG S FBFLAG=0
 N FBFLD
 F FBFLD=.351,.03,.111,.112,.113,.114,.115,.116,.1112,.1411,.1412,.1413,.1414,.1415,.1416,.1417,.1418,2.141 I $G(DGFIELD)=FBFLD S FBFLAG=1 Q
 Q:'FBFLAG
 D UPDADR($G(DGDA))
 Q
 ;send patient MRA message to AAC
 ;
UPDADR(FBDFN) ;
 Q:+$G(FBDFN)=0
 N FBFRDT,FBTODT,FBTRTYP,FBZTH,FBDEL S (FBZTH,FBDEL)=""
 N FBAUTH,FBARR,FBLIMDT,FBTODAY,FB1 S (FBFRDT,FBTODT,FBTRTYP,FBAUTH,FBARR,FBTODAY,FBLIMDT,FB1)=0
 D  ;limit date is TODAY - 2 year
 . N X D NOW^%DTC S FBTODAY=X,FBLIMDT=+(($E(X,1,3)-2)_$E(X,4,7))
 ;go thru all authorizations for this patient
 ;and process all of them except SHORT TERM (i.e. only ID, HOME HEALTH and STATE HOME)
 F  S FBAUTH=$O(^FBAAA(FBDFN,1,FBAUTH)) Q:+FBAUTH=0  D
 . ;get zeroth node
 . S FBZTH=$G(^FBAAA(FBDFN,1,FBAUTH,0))
 . ;TO DATE, FROM DATE, Treatment type
 . S FBTODT=$P(FBZTH,"^",2),FBFRDT=$P(FBZTH,"^"),FBTRTYP=$P(FBZTH,"^",13)
 . Q:FBTRTYP<1!(FBTRTYP>4)
 . Q:FBTRTYP=1  ;short terms will be processed via file #161.26
 . ;apply to different rules depend on treatment type
 . Q:FBTODT<FBLIMDT&((FBTRTYP=2)!(FBTRTYP=3))  ;ID and HOME HEALTH
 . Q:(FBTRTYP=4)&(FBTODT<FBTODAY)  ;STATE HOME
 . S FBDEL=$G(^FBAAA(FBDFN,1,FBAUTH,"ADEL"))
 . Q:$P(FBDEL,"^")=1!($P(FBDEL,"^")="Y")  ;the 'Delete MRA' was transmitted to Austin DPC.
 . ;store AUTHORIZATION details in the local array
 . S FB1=+$O(FBARR(FBTRTYP,0))
 . I FB1 I FBTODT'>$P(FBARR(FBTRTYP,FB1),"^",4) Q  ;more recent one already there
 . I FB1 K FBARR(FBTRTYP,FB1) ;kill this one and then replace it (below)
 . S FBARR(FBTRTYP,9999999-FBTODT)=FBDFN_"^"_FBAUTH_"^"_FBFRDT_"^"_FBTODT
 ;add SHORT TERM authorizations to the local array from file #161.26
 D DOSHORT(.FBARR,FBDFN,FBTODAY)
 ;go thru all authorizations selected and saved in the local array
 F FBTRTYP=1,2,3,4 D DOEACH(.FBARR,FBTRTYP)
 Q
 ;
 ;SHORT-TERM (1) Authorizations
DOSHORT(FBARR1,FBDFN,FBTODAY) ;
 Q:+$G(FBDFN)=0
 Q:'$D(FBARR1)
 Q:+$G(FBTODAY)=0
 N FBDT30  ;30 days back
 D
 . N X1,X2,X S X1=FBTODAY,X2=-30 D C^%DTC S FBDT30=X
 ;go thru file #161.26
 N FB1,FB2,FB3,FBDT S (FB2,FB1,FB3)=0
 F  S FB1=$O(^FBAA(161.26,"B",FBDFN,FB1)) Q:+FB1=0  D
 . S FB2=^FBAA(161.26,FB1,0)
 . Q:$P(FB2,"^",7)'="Y"  ;only SHORT TERM
 . Q:$P(FB2,"^",4)="D"  ;we are not interested in DELETE transactions
 . S FBDT=+$P(FB2,"^",5)
 . Q:'FBDT  ;no date
 . ; store in local array
 . I FBDT>FBDT30 D
 . . S FB3=+$O(FBARR1(1,0))
 . . I FB3 I FBDT'>$P(FBARR1(1,FB3),"^",4) Q
 . . I FB1 K FBARR1(1,FB3)
 . . S FBARR1(1,9999999-FBDT)=FBDFN_"^"_$P(FB2,"^",3)_"^^"_FBDT
 Q
 ;SHOR TERM (1)
 ;ID CARD (3) Authorizations
 ;HOME HEALTH (2) Authorizations
 ;STATE HOME (4) Authorizations 
DOEACH(FBARR2,FBTYPE) ;
 Q:'$D(FBARR2)
 N FB1,FBAUTH,FBDFN
 S FB1=$O(FBARR2(FBTYPE,0))
 Q:+FB1=0
 S FBDFN=$P($G(FBARR2(FBTYPE,FB1)),"^")
 S FBAUTH=$P($G(FBARR2(FBTYPE,FB1)),"^",2)
 ;check if there is a pending tramsmission in file
 Q:$$ISPEND(FBDFN,FBAUTH)  ;quit if it is there
 ;send patient MRA to AAC
 D SENDMRA(FBDFN,FBAUTH,FBTYPE)
 Q
 ;
 ;returns 1 if pending or if it is "delete" transaction
 ;returns 0 if was transmitted or there are no transmission at all
ISPEND(FBDFN,FBAUTH) ;
 N FB1,FB2,FBFLGP,FBFLGD S (FB2,FB1,FBFLGP,FBFLGD)=0
 F  S FB1=$O(^FBAA(161.26,"B",FBDFN,FB1)) Q:+FB1=0  D  Q:FBFLGP!FBFLGD
 . S FB2=$G(^FBAA(161.26,FB1,0))
 . I +$P(FB2,"^",3)'=FBAUTH Q
 . S:$P(FB2,"^",2)="P" FBFLGP=1
 . S:$P(FB2,"^",4)="D" FBFLGD=1
 Q:FBFLGP 1
 Q:FBFLGD 1
 Q 0
 ;
SENDMRA(FBDFN,FBAUTH,FBTRTYPE) ;
 N DD,DO,DIC,DLAYGO,DDER,DA
 ;SHORT TERM auth-tions:
 I FBTRTYPE=1 D  Q
 . S DIC="^FBAA(161.26,",DIC(0)="L",DLAYGO=161.26,X=FBDFN
 . S DIC("DR")="1///^S X=""P"";2///^S X=FBAUTH;3///^S X=""A"";6////^S X=""Y"""
 . D FILE^DICN
 ;all other types of auth-tions:
 I $$QMRA^FBSHAUT(FBDFN,FBAUTH,"C")
 Q
 ;
 ;FBPATDAT
