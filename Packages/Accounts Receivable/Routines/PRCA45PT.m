PRCA45PT ;W-CIOFO/MAF - FOR IFCAP PURGE ; 09-JULY-97
V ;;4.5;Accounts Receivable;**88**;Mar 20, 1995
 ;
 ;
 ; -- IFCAP archive - need to remove AR pointers to file 442.
 ;    
 ;
 ; -- Delete the data for the PAT REF # in the Fiscal Year multiple
 ;    in files 430 and 433.  They have pointers to file 442.
 ;
 ; -- This will be a one time deletion of data in those fields and
 ;    those fields will be '*' for deletion in 18 months.
 D BMES^XPDUTL("*** Tasking the cleanup of the PAT REF # field of the Fiscal Year multiple")
 D MES^XPDUTL("    and the cross references on the PAT REF # subfield")
 D MES^XPDUTL("    for files 430 ACCOUNTS RECEIVABLE and 433 AR TRANSACTION ***")
 D BMES^XPDUTL("*** You will receive a mail message when this job has run to completion ***")
 D BMES^XPDUTL("*** PLEASE DO NO DELETE ROUTINE PRCA45PT UNTIL YOU RECEIVE A MESSAGE")
 D MES^XPDUTL("     STATING THE POST INIT HAS RUN TO COMPLETION ***")
 N ZTSK,ZTDTH,ZTRTN,ZTDESC,ZTSAVE,ZTIO,PRCATIME
 S ZTDTH=$H
 S ZTRTN="EN^PRCA45PT",ZTDESC="PRCA - CLEANUP OF FILES 430/433 PAT REF #",ZTIO="" D ^%ZTLOAD D HOME^%ZIS
 Q
 ;
EN D XCLN,430,433 ;  delete pat/ref # from accounts receivable and AR transaction files
 N PRCA,XMDUZ,XMY,XMTEXT,XMSUB
 S XMSUB="CLEANUP OF FILES 430/433 of PAT REF # DATA"
 S XMTEXT="PRCA("
 S PRCA(1)="The Accounts Receivable patch PRCA*4.5*88 has run to completion"
 S PRCA(2)="NO ERRORS or PROBLEMS were found."
 S PRCA(3)="  "
 S PRCA(4)="*** YOU MAY NOW DELETE THE ROUTINE PRCA445PT ***"
 S XMY(DUZ)=""
 S XMDUZ=.5
 D ^XMD
 Q
430 ; delete pat/ref # from accounts receivable file
 ; loop thru file 430
 N PRCATIEN,PRCAPAT,PRCAFY
 S PRCATIEN=0 F  S PRCATIEN=$O(^PRCA(430,PRCATIEN)) Q:'PRCATIEN  I $D(^PRCA(430,PRCATIEN,2,0)) D
 .S PRCAFY=0 F  S PRCAFY=$O(^PRCA(430,PRCATIEN,2,PRCAFY)) Q:'PRCAFY  S PRCAPAT=$P($G(^PRCA(430,PRCATIEN,2,PRCAFY,0)),"^",3) I PRCAPAT]"" D
 ..L +^PRCA(430,PRCATIEN)
 ..S $P(^PRCA(430,PRCATIEN,2,PRCAFY,0),"^",3)=""
 ..K ^PRCA(430,PRCATIEN,2,"C")
 ..L -^PRCA(430,PRCATIEN)
 K ^PRCA(430,"F")
 Q
 ;
433 ; delete pat/ref # from ar transactions file
 ;Looping thru file 433 to delete pat ref #
 N PRCATIEN,PRCAPAT,PRCAFY
 S PRCATIEN=0 F  S PRCATIEN=$O(^PRCA(433,PRCATIEN)) Q:'PRCATIEN  I $D(^PRCA(433,PRCATIEN,4,0)) D
 .S PRCAFY=0 F  S PRCAFY=$O(^PRCA(433,PRCATIEN,4,PRCAFY)) Q:'PRCAFY  S PRCAPAT=$P($G(^PRCA(433,PRCATIEN,4,PRCAFY,0)),"^",3) I PRCAPAT]"" D
 ..L +^PRCA(433,PRCATIEN)
 ..S $P(^PRCA(433,PRCATIEN,4,PRCAFY,0),"^",3)=""
 ..K ^PRCA(433,PRCATIEN,4,"C")
 ..L -^PRCA(433,PRCATIEN)
 K ^PRCA(433,"D")
 Q
XCLN ; in 430 and 433, delete all xrefs for PAT REF # fields in those files
 N PRCAX,DIK,DA,PRCAXREF,PRCAFIL
 ;
 D BMES^XPDUTL("Post Init cleaning up cross references on the PAT REF # field in files 430/433")
 D BMES^XPDUTL("*** Killing cross references 'F' and 'C' for the PAT REF # subfield of the")
 D MES^XPDUTL("Fiscal Year multiple in file 430")
 D BMES^XPDUTL("*** Killing cross references 'D' and 'C' for the PAT REF # subfield of the")
 D MES^XPDUTL("Fiscal Year multiple in file 433")
 D BMES^XPDUTL(" ")
 ;
 F PRCAFIL=430.01,433.01 D
 .F PRCAXREF=1,2 D
 .. S DIK="^DD("_PRCAFIL_",2,1,",DA(2)=PRCAFIL,DA(1)=2,DA=PRCAXREF
 .. D ^DIK K DIK,DA
 .. S PRCAX="   >> ^PRCA("_PRCAFIL_",2,1,"_PRCAXREF_") cross references deleted." D MES^XPDUTL(PRCAX)
 Q
