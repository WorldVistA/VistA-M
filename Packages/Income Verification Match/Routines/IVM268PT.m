IVM268PT ;ALB/SCK - IVM*2*68 POST-INSTALL TO CLOSE IVM CASES ; 10/18/02
 ;;2.0;INCOME VERIFICATION MATCH;**68**; 21-OCT-94
 ;
 ;This routine will be run as part of the post-install for patch
 ;IVM*2*68
 ;
 ;This routine will close all IVM open cases in the IVM PATIENT File,
 ;#301.5, for income years 1997 through the present.  Patch 
 ;DG*5.3*272 closed all IVM open cases up through 1996
 ;
 ; The following fields in the IVM PATIENT File, #301.5 will be updated:
 ;   .03  -  TRANSMISSION STATUS = 1
 ;   .04  -  STOP FLAG           = 1
 ;  1.01  -  CLOSURE REASON      = 5 "OLD CASE NO ACTION"
 ;  1.02  -  CLOSURE SOURCE      = 2 "DHCP"
 ;  1.03  -  CLOSURE DATE/TIME   = Current D/T
 ;
 ;A mail message will be sent to the user when the post-install is complete.
 ;Additionally, details and any error messages will be stored in XTMP globals
 ;for review.
 ;
POST ; Initialize post install
 N %,I,X,IVMGBL
 ;
 ; Check post-install closure question
 I $D(XPDNM),$D(XPDQUES) Q:'+XPDQUES("POS001")
 ; Post-install checkpoints setup
 I $D(XPDNM) D
 . I $$VERCP^XPDUTL("IVMICY")'>0 D
 . . S %=$$NEWCP^XPDUTL("IVMICY","","2960000")
 . I $$VERCP^XPDUTL("IVMDFN")'>0 D
 . . S %=$$NEWCP^XPDUTL("IVMDFN","",0)
 ;
QUE ;
 N ZTRTN,ZTDESC,ZTSAVE,ZTDTH,ZTIO,ZTSK
 ;
 S ZTRTN="EN^IVM268PT"
 S ZTDESC="PATCH IVM*2*68 POST INSTALL"
 S ZTSAVE("DUZ")=""
 S ZTDTH=$$NOW^XLFDT
 S ZTIO=""
 ;
 D ^%ZTLOAD
 I $D(ZTSK)[0 D BMES^XPDUTL("Post-Install was not tasked off")
 E  D BMES^XPDUTL("Post-Install tasked. ["_ZTSK_"]")
 D HOME^%ZIS
 Q
 ;
EN ;
 ; Initialize the XTMP tracking global
 I '$D(^XTMP("IVMPCT68")) D
 . S ^XTMP("IVMPCT68",0)=$$FMADD^XLFDT($$DT^XLFDT,30)_"^"_$$DT^XLFDT_"^IVM*2*68 POST INSTALL RECORD COUNT"
 ;
 I '$D(^XTMP("IVMERR68")) D
 . S ^XTMP("IVMERR68",0)=$$FMADD^XLFDT($$DT^XLFDT,30)_"^"_$$DT^XLFDT_"^IVM*2*68 POST INSTALL FILING ERRORS"
 ;
 ; Begin Processing
 N DATA,IVMICY,IVMDFN
 ;
 ;Get values from checkpoints if there was a previous run
 I $D(XPDNM) S IVMICY=$$PARCP^XPDUTL("IVMICY")
 I $G(IVMICY)="" S IVMICY=2960000
 ;
 I $D(XPDNM) S IVMDFN=$$PARCP^XPDUTL("IVMDFN")
 I $G(IVMDFN)="" S IVMDFN=0
 ;
 D BMES^XPDUTL("Beginning case closing process "_$$FMTE^XLFDT($$NOW^XLFDT))
 D CLNUP(IVMICY,IVMDFN)
 D MAIL
 ; Close checkpoint
 I $D(XPDNM) D
 . S %=$$COMCP^XPDUTL("IVMICY")
 . S %=$$COMCP^XPDUTL("IVMDFN")
 D BMES^XPDUTL("Completed case closing process "_$$FMTE^XLFDT($$NOW^XLFDT))
 Q
 ;
CLNUP(IVMICY,IVMDFN) ; Search for open cases
 N %,DATA,IVMIEN,IVMDT,IVMDFN1,NODE1,ERROR,IVMOK,IVMABRT
 ;
 ; Set data array for closing
 S DATA(.03)=1
 S DATA(.04)=1
 S DATA(1.01)=5
 S DATA(1.02)=2
 S DATA(1.03)=$$NOW^XLFDT
 ;
 S IVMDT=IVMICY,IVMOK=1
 ; First loop on Income Year
 F  S IVMDT=$O(^IVM(301.5,"AYR",IVMDT)) Q:'IVMDT  D  Q:$G(IVMABRT)
 . I $$S^%ZTLOAD S IVMABRT=1 Q
 . S IVMDFN1=IVMDFN
 . ; Second loop on DFN
 . F  S IVMDFN1=$O(^IVM(301.5,"AYR",IVMDT,IVMDFN1)) D  Q:'IVMDFN1
 . . I 'IVMDFN1 D  Q
 . . . ; Update checkpoint on last DFN for Income Year
 . . . I $D(XPDNM) S %=$$UPCP^XPDUTL("IVMICY",IVMDT)
 . . S IVMIEN=$O(^IVM(301.5,"AYR",IVMDT,IVMDFN1,0))
 . . Q:'$D(^IVM(301.5,IVMIEN))  ; Quit if not a valid record
 . . S NODE1=$G(^IVM(301.5,IVMIEN,1))
 . . Q:$P(NODE1,U,1)]""  ; Quit if case already closed
 . . ; Close case
 . . S IVMOK=$$UPD^DGENDBS(301.5,IVMIEN,.DATA,.ERROR)
 . . I 'IVMOK S ^XTMP("IVMERR68",IVMIEN)=$G(ERROR)
 . . ; Update Counter
 . . S ^XTMP("IVMPCT68",IVMDT)=$G(^XTMP("IVMPCT68",IVMDT))+1
 . . ; Update checkpoint for completed DFN
 . . I $D(XPDNM) S %=$$UPCP^XPDUTL("IVMDFN",IVMDFN1)
 Q
 ;
MAIL ; Send mail message with results
 N X,XMDUZ,XMTEXT,XMSUB,XMY,Y,TEMP,LINE,IVMYR,SPACE
 N %,DIFROM
 ;
 S TEMP="^TMP(""IVM68"",$J)"
 K @TEMP
 S XMSUB="Post Install - Closing of IVM Cases"
 S XMDUZ("PATCH IVM-2-68")=""
 S XMY(.5)="",XMY(DUZ)=""
 S XMTEXT="^TMP(""IVM68"",$J,"
 ;
 S $P(SPACE," ",20)=""
 S @TEMP@(1)="Closing of IVM Cases"
 S @TEMP@(2)=" "
 S @TEMP@(3)="Income year"_SPACE_"# of cases closed"
 S @TEMP@(4)="==========="_SPACE_"================="
 S LINE=10
 S IVMYR=0
 F  S IVMYR=$O(^XTMP("IVMPCT68",IVMYR)) Q:'IVMYR  D
 . S @TEMP@(LINE)=$$FMTE^XLFDT(IVMYR)_SPACE_$J($FN($G(^XTMP("IVMPCT68",IVMYR)),","),20)
 . S LINE=LINE+1
 ;
 ;  Add Errors to mail message
 S @TEMP@(LINE)="",LINE=LINE+1
 S @TEMP@(LINE)="Some records may not have been edited due to filing errors.",LINE=LINE+1
 S @TEMP@(LINE)="Those records are listed below:",LINE=LINE+1
 S IVMIEN=0
 F  S IVMIEN=$O(^XTMP("IVMERR68",IVMIEN)) Q:'IVMIEN  D
 . S @TEMP@(LINE)="Record: "_IVMIEN_"  "_$G(^XTMP("IVMERR68",IVMIEN))
 . S LINE=LINE+1
 ;
 D ^XMD
 K @TEMP
 Q
 ;
COUNT ;  For test purposes, check numbers
 N IVMDT,STAT,IVMDFN1,IVMIEN,NODE1,IVMYR,SPACE
 ;
 K ^TMP("IVM68TST",$J)
 S IVMDT=2960000,STAT=1
 ; First loop on Income Year
 F  S IVMDT=$O(^IVM(301.5,"AYR",IVMDT)) Q:'IVMDT  D
 . S IVMDFN1=0
 . ; Second loop on DFN
 . F  S IVMDFN1=$O(^IVM(301.5,"AYR",IVMDT,IVMDFN1)) Q:'IVMDFN1  D
 . . S IVMIEN=$O(^IVM(301.5,"AYR",IVMDT,IVMDFN1,0))
 . . Q:'$D(^IVM(301.5,IVMIEN))  ; Quit if not a valid record
 . . S NODE1=$G(^IVM(301.5,IVMIEN,1))
 . . Q:$P(NODE1,U,1)]""  ; Quit if case already closed
 . . S ^TMP("IVM68TST",$J,IVMDT)=$G(^TMP("IVM68TST",$J,IVMDT))+1
 ;
 W @IOF
 S $P(SPACE," ",20)=""
 W !,"Closing of IVM Cases"
 W !!,"Income year"_SPACE_"# of cases closed"
 W !,"==========="_SPACE_"================="
 ;
 S IVMYR=0
 F  S IVMYR=$O(^TMP("IVM68TST",$J,IVMYR)) Q:'IVMYR  D
 . W !,$$FMTE^XLFDT(IVMYR)_SPACE_$J($FN($G(^TMP("IVM68TST",$J,IVMYR)),","),20)
 ;
 K ^TMP("IVM68TST",$J)
 Q
