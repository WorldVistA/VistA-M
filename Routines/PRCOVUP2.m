PRCOVUP2 ;WCAMPUS/-GENERATE MAIL MESSAGE AT END OF CONVERSION ;3/22/95
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;create a message at completion of the vendor upload
 ;the message will summerize the number of active
 ;vendors on file and the number that converted
 ;
 D:'$D(DT) DT^DICRW ;set DT if undef
 ;
 ;PRVTOT = total number of active vendors in last 2 years
 ;PRVFMS = total number of active vendors that converted(fms code)
 N I,J,PRVIEN,PRVTOT,PRVFMS,PRVTXT
 S I=$$FMADD^XLFDT(DT,-730) ;date two years ago from today
 F  S I=$O(^PRC(442,"AB",I)) Q:'I  D
 . S J=0 F  S J=$O(^PRC(442,"AB",I,J)) Q:'J  S PRVIEN=+$G(^PRC(442,J,1)) I PRVIEN D
 .. I $D(^PRC(440,PRVIEN,0)) S:'$D(^TMP($J,"PRCOVUP1",PRVIEN)) ^(PRVIEN)=""
 ; ^TMP($J,"PRCOVUP1",PRVIEN) is the active vendors used last 2 yrs
 ;
 S (PRVTOT,PRVFMS)=0
 S I=0 F  S I=$O(^TMP($J,"PRCOVUP1",I)) Q:'I  S PRVTOT=PRVTOT+1 D
 . I $P($G(^PRC(440,I,3)),U,4)]"" S PRVFMS=PRVFMS+1
 ;
 S PRVTXT(1)="IFCAP Vendor conversion has run to completion."
 S PRVTXT(2)="   Summary Statistics"
 S PRVTXT(3)="      Total number of active vendors on file   : "_PRVTOT
 S PRVTXT(4)="      Total number of active vendors converted : "_PRVFMS
 ;generate mail message vendor upload complete and give stats
 S PRCMG=$S('$D(PRCMG):.5,$E(PRCMG,1,2)'="G.":"G."_PRCMG,1:.5)
 S XMY(PRCMG)="",XMDUZ=.5
 S XMSUB="IFCAP VENDOR CONVERSION SUMMARY"
 S XMTEXT="PRVTXT("
 D ^XMD
 K XMDUZ,XMSUB,XMY,^TMP($J,"PRCOVUP1")
 Q
