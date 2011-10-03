USRPROV ; SLC/DJP - Auto-populate PROVIDER CLASS ;05/05/98
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**7**;Jun 20, 1997
MAIN ; Main loop
 N USRDFN,USRNOW
 S USRDFN=0
 I +$G(^USR(8930.3,"USRPROV")) D  Q
 . W !!,"This option has already been run...Aborting option.",!
 W !!,"Initializing the PROVIDER Class"
 F  S USRDFN=$O(^XUSEC("PROVIDER",USRDFN)) Q:+USRDFN'>0  D
 . S USRNOW=$$NOW^XLFDT
 . ; Exclude terminated users
 . I +$P($G(^VA(200,USRDFN,0)),U,11)>0,(+$P($G(^(0)),U,11)<USRNOW) Q
 . S USRNM=$P($G(^VA(200,USRDFN,0)),U)
 . ; Exclude users w/o names or "ZZ" users
 . I (USRNM']"")!($E(USRNM,1,2)="ZZ") Q
 . D PUT^USRLM(USRDFN,"PROVIDER") W "."
 S ^USR(8930.3,"USRPROV")=1
 Q
