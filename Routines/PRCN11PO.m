PRCN11PO ;WISC/CW-post init patch 11 ;08-Nov-02
 ;;1.0;Equipment/Turn-In Request;**11**;Sep 13, 1996
 Q
POST ;start post init
 ;add line item count to file 410 if record contains line items
 ;
 N U,PRCNUM,PRCNIMP,PRCNLIC,PRCNFND,PRCNDA1,PRCNDA2
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine ...")
 D MES^XPDUTL("     -> Adding LINE ITEM COUNT to file 410 ...")
 ;
 S U="^",(PRCNDA1,PRCNFND,PRCNUM)=0
 F  S PRCNDA1=$O(^PRCN(413,PRCNDA1)) Q:'PRCNDA1  D
 . S PRCNIMP=$P($G(^PRCN(413,PRCNDA1,0)),U,7)
 . ;request status in file 413.5    ;19-Approved-Funded
 . ;39-Ready for 2237 Processing    ;18-Approved-Pending Funding
 . I (PRCNIMP'=39),(PRCNIMP'=18),(PRCNIMP'=19) Q
 . S PRCNIMP=$P(^PRCN(413,PRCNDA1,0),U)
 . S PRCNDA2=$O(^PRCS(410,"H",PRCNIMP,""))
 . Q:PRCNDA2=""
 . Q:'$D(^PRCS(410,PRCNDA2,"IT",1))
 . Q:'$D(^PRCS(410,PRCNDA2,10))
 . Q:$P(^PRCS(410,PRCNDA2,10),U)
 . S PRCNFND=1
 . S PRCNLIC=$O(^PRCS(410,PRCNDA2,"IT",99),-1),PRCNUM=PRCNUM+1
 . S ^PRCS(410,PRCNDA2,10)=PRCNLIC_U_$P(^PRCS(410,PRCNDA2,10),U,2,99)
 . W !!,PRCNUM_". "_"LINE ITEM COUNT "_PRCNLIC_" has been added to the entry record "_PRCNDA2_".",!
 ;
 I 'PRCNFND D MES^XPDUTL("        No records need to be updated!")
 D MES^XPDUTL(" >>  End of the Post-Initialization routine ...")
 Q
