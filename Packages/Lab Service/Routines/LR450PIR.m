LR450PIR ;VMP/JSG - LR*5.2*450 POST INSTALL ROUTINE KIDS INSTALL
 ;;5.2;LAB SERVICE;**450**;Sep 27, 1994;Build 1
 ;;Reference to ^SC is supported by DBIA 10040.
 ;Examines field #25 (INSTITUTION) in file #69 (LAB ORDER ENTRY)
 ;to identify records without an Institution specified. If the 
 ;field is null, this routine uses field #23 (ORDERING LOCATION)
 ;to access file #44 (HOSPITAL LOCATION) and retrieve field #3 
 ;(INSTITUTION) to use to populate the INSTITUTION field in the 
 ;LAB ORDER ENTRY file.
 ;
 ;In some instances, the Ordering Location (#23) field is also 
 ;null and consequently the Institution cannot be updated.
 ;
 ;Updated records are saved for 90 days in ^XTMP("LR450PIR"). 
 ;
 ;LRNE = Number records Examined
 ;LRNO = Number records Okay (INSTITUTION properly populated)
 ;LRNC = Number records Changed
 ;LRNN = Number records Not changed (though INSTITUTION null)
 ;LRIN = INSTITUTION
 ;LROL = ORDERING LOCATION
 ;
 D MES^XPDUTL("In testing, the routine processed 250,000 lab orders per minute.")
 D MES^XPDUTL("The routine will report progress every 100,000 orders.")
 N LRNE,LRNO,LRNC,LRNN,LRIN,LROL,LRD0,LRD1,LRX
 N LRRB,LR0,LRCD,LRPD
 D INIT ;initialize ^XTMP
SCN S (LRD0,LRNE,LRNO,LRNC,LRNN)=0
    F  S LRD0=$O(^LRO(69,LRD0)),LRD1=0 Q:LRD0<1  D 
    . F  S LRD1=$O(^LRO(69,LRD0,1,LRD1)) Q:LRD1<1  D CHK
    W $C(10,13) I $D(^XTMP("LR450PIR",2)) S LRD0=0 D LCK
    D MES^XPDUTL("Nodes Examined: "_LRNE)
    D MES^XPDUTL("Nodes Okay: "_LRNO)
    D MES^XPDUTL("Nodes Changed: "_LRNC)
    D MES^XPDUTL("Nodes Not Changed: "_LRNN)
    S ^XTMP("LR450PIR",1,"RECORD COUNTS")=LRNE_U_LRNO_U_LRNC_U_LRNN
    S ^XTMP("LR450PIR",1,"RUN ENDED")=$$HTFM^XLFDT($H)
    D MES^XPDUTL("Post Install Process complete.")
    S LRX="To review updated records, use ^%G to list ^XTMP("
    D MES^XPDUTL(LRX_$C(34)_"LR450PIR"_$C(34)_").")
END K LRNE,LRNO,LRNC,LRNN,LRIN,LROL,LRD0,LRD1,LRX
    K LRRB,LR0,LRCD,LRPD
    Q
LCK ;Give nodes LOCKed on the 1st pass, 1 more try:
    D MES^XPDUTL("Checking LOCKed nodes ...")
    F  S LRD0=$O(^XTMP("LR450PIR",2,LRD0)),LRD1=0 Q:LRD0<1  D 
    . F  S LRD1=$O(^XTMP("LR450PIR",2,LRD0,LRD1)) Q:LRD1<1  D
    .. D CHK K ^XTMP("LR450PIR",2,LRD0,LRD1)
    Q
CHK ;Examine 69.01 1 node to see if it needs to be properly updated:
    S LRNE=LRNE+1 I '(LRNE#100000) D MES^XPDUTL("Orders Processed: "_LRNE_" ...")
    I '$D(^LRO(69,LRD0,1,LRD1,1)) S LRNN=LRNN+1 Q        ;no 1 node
    I $P(^LRO(69,LRD0,1,LRD1,1),U,8)'="" S LRNO=LRNO+1 Q  ;#25 okay
    I '$D(^LRO(69,LRD0,1,LRD1,0)) S LRNN=LRNN+1 Q        ;no 0 node
    S LROL=$P(^LRO(69,LRD0,1,LRD1,0),U,9)
    I LROL="" S LRNN=LRNN+1 Q                             ;#23 null
    S LRON=+$G(^LRO(69,LRD0,1,LRD1,.1))
    I 'LRON S LRNN=LRNN+1 Q                             ;no Order #
    S LRIN=$P($G(^SC(LROL,0)),U,4)
    I LRIN="" S LRNN=LRNN+1 Q                ;no Institution in #44
    L +^LRO(69,"C",LRON):$G(DILOCKTM,3) I '$T D  Q
    . S ^XTMP("LR450PIR",2,LRD0,LRD1)="",LRNE=LRNE-1 W "L"
    S DIE="^LRO(69,"_LRD0_",1,",DA(1)=LRD0,DA=LRD1,DR="25////"_LRIN D ^DIE
    L -^LRO(69,"C",LRON)
    S ^XTMP("LR450PIR",LRD0,1,LRD1,1)=^LRO(69,LRD0,1,LRD1,1),LRNC=LRNC+1
    Q
INIT ;Set up ^XTMP to save modified records:
     ;LRRB = PIR Run Begin date.time
     ;LRRE = PIR Run End date.time
     ;LRCD = ^XTMP Create Date
     ;LRPD = ^XTMP Purge Date
     ;LR0  = ^XTMP zero node data
     S LRRB=$$HTFM^XLFDT($H),LRCD=$P(LRRB,"."),LRPD=$$FMADD^XLFDT(LRCD,30)
     S LR0=LRPD_U_LRCD_U_"LR*5.2*450 Post Install: #69.01, Field #25"
     S ^XTMP("LR450PIR",0)=LR0
     S ^XTMP("LR450PIR",1,"RECORD COUNT LEGEND")="Examined^Okay^Changed^Not Changed"
     S ^XTMP("LR450PIR",1,"RECORD COUNTS")="0^0^0^0"
     S ^XTMP("LR450PIR",1,"RUN BEGAN")=LRRB
     S ^XTMP("LR450PIR",1,"RUN ENDED")=""
     S ^XTMP("LR450PIR",1,"UPDATED NODE LEGEND")="DTC^DTO^COL^C STA^VOL^COM^MO#^INS"
     S ^XTMP("LR450PIR",2)="Records LOCKed during initial pass"
     Q
