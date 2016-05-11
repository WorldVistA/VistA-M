HMPPATS ;SLC/MKB,ASMR/RRB,SRG - Patient Management Utilities ;Nov 16, 2015 19:11:53
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^SC                          10040
 ; DICN                         10009
 ; SDAMA301                      4433
 ; XLFDT                        10103
 ; XPAR                          2263
 Q
 ;
APPT ; -- Return patients w/appointments tomorrow
 ; OPT = HMP APPOINTMENTS
 N NOW,NOW1,HMPX,HMPL,HMPN,DFN,DA,TOKEN,NEW,X
 S NOW=$$NOW^XLFDT,NOW1=$$FMADD^XLFDT(NOW,1)
 S HMPX(1)=NOW_";"_NOW1 ;next 24hours
 S HMPX("FLDS")=1,HMPX("SORT")="P",HMPX(3)="R;I;NT"
 ; ck parameter for desired location(s): HMPX(2)="loc1;loc2;...;loc#"
 D GETLST^XPAR(.HMPL,"ALL","HMP LOCATIONS") I +$G(HMPL) D
 . ;DE2818, ^SC reference - ICR 10040, changed loop below to begin at 1
 . F I=1:1:+HMPL S X=+$G(HMPL(I)) S:$D(^SC(X,0)) HMPX(2)=HMPX(2)_";"_X
 S HMPN=$$SDAPI^SDAMA301(.HMPX) Q:HMPN<1
 S DFN=0 F  S DFN=$O(^TMP($J,"SDAMA301",DFN)) Q:DFN<1  D
 . S DA=0 F  S DA=$O(^HMP(800000,DA)) Q:DA<1  I $P($G(^(DA,0)),U,2) D
 .. Q:$D(^HMP(800000,"ADFN",DFN,DA))  ;already subscribed
 .. S TOKEN=DA_"~"_NOW,NEW(TOKEN)=""
 .. S ^XTMP("HMPX",TOKEN,DFN)=""
 I $D(NEW) D SEND^HMPHTTP(.NEW) ;send poke to each URL with list TOKEN
 Q
 ;
FIND(ID) ; -- Return ien of system ID in ^HMP
 N DA,DO,DIC,X,Y
 I $G(ID)="" Q 0                        ;error
 S DA=+$O(^HMP(800000,"B",ID,0)) I DA<1 D  ;add
 . S DIC="^HMP(800000,",DIC(0)="F",X=ID
 . D FILE^DICN S DA=+Y
 Q DA
 ;
