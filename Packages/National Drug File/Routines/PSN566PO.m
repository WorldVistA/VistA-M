PSN566PO ;BIR/SJA-Post install routine for patch PSN*4*566 ; 02 Aug 2018  2:00 PM
 ;;4.0;NATIONAL DRUG FILE;**566**; 30 Oct 98;Build 2
 ;
 Q
 ;
POST ; entry point
 N CNT,DATA,II,NAME,NODE1,PSNDA
 S CNT=4 K ^TMP("PSN",$J)
 D BMES^XPDUTL("  Starting post-install for PSN*4*566")
 ;
 D BMES^XPDUTL("Re-indexing the 'AQ1' of the CMOP ID field (#27) of the DRUG file (#50)...")
 K ^PSDRUG("AQ1") K DIK S DIK="^PSDRUG(",DIK(1)="27^AQ1" D ENALL^DIK K DIK
 ;
 D BMES^XPDUTL("  Restore GCNSEQNO field for specific VA Products....")
 F II=1:1 S DATA=$P($T(@("LIST+"_II_"^PSN566PO")),";;",2) Q:DATA=""  D
 . S PSNDA=+DATA,NAME=$E($P($G(^PSNDF(50.68,PSNDA,0)),"^"),1,40),NODE1=$G(^PSNDF(50.68,PSNDA,1))
 . I $D(^PSNDF(50.68,PSNDA,0)),'$P(NODE1,"^",5) S $P(^PSNDF(50.68,PSNDA,1),"^",5)=$E(1000000+$P(DATA,",",2),2,7) D
 . . S CNT=CNT+1,^TMP("PSN",$J,CNT)=PSNDA_$J("",15-$L(PSNDA))_NAME_$J("",50-$L(NAME))_$E(1000000+$P(DATA,",",2),2,7)
 D MSG K ^TMP("PSN",$J)
 D BMES^XPDUTL("  Finished post-install for PSN*4*566")
 Q
 ;
MSG ; Sends Mailman message about updates
 N XMX,XMSUB,XMDUZ,XMTEXT
 S II=0 F  S II=$O(^XUSEC("PSNMGR",II)) Q:'II  S XMY(II)=""
 S XMY(DUZ)="",XMSUB="PSN*4*566 - GCNSEQNO field Update"
 S ^TMP("PSN",$J,1)="The post-install routine restored the GCNSEQNO field value for the following VA PRODUCT entries:"
 S ^TMP("PSN",$J,2)=""
 S ^TMP("PSN",$J,3)="VA Product #   Product Name                                      GCNSEQNO   "
 S ^TMP("PSN",$J,4)="------------   ----------------------------------------          --------"
 S:'$D(^TMP("PSN",$J,5)) ^TMP("PSN",$J,5)="No updates performed."
 S XMDUZ=.5,XMTEXT="^TMP(""PSN"",$J," N DIFROM D ^XMD
 Q
 ;
LIST ; VA PRODUCT entries missing GCNSEQNO field
 ;;5556,003242
 ;;19980,062059
 ;;21020,065368
 ;;26849,074811
 ;;7657,004247
 ;;7658,004247
 ;;15709,004053
 ;;16451,003298
 ;;25333,073234
 ;;27516,077118
 ;;27887,065744
 ;;28658,064056
 ;;28674,078605
 ;;28238,047061
 ;;1845,045155
 ;;2473,008764
 ;;8871,015612
 ;;16385,051884
 ;;18652,021444
 ;;23735,070630
 ;;25841,074409
 ;;25843,074410
 ;;26452,013648
 ;;26453,013649
 ;;3352,005154
 ;;12622,064400
 ;;27302,050831
 ;;6105,048520
 ;;16670,016963
 ;;24499,071837
 ;;26436,066702
 ;;26437,066702
 ;;27191,076607
 ;;27192,076608
 ;;28836,071475
 ;;28837,073153
 ;;28845,079002
 ;;52,000214
 ;;18283,062597
 ;;19294,042966
 ;;20737,061237
 ;;25133,072283
 ;;27435,072292
 ;;27452,072284
 ;;27454,072291
 ;;27581,031511
 ;
