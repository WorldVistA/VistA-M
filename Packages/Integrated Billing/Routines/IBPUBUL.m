IBPUBUL ;ALB/CPM - ARCHIVE/PURGING BULLETIN ; 20-APR-92
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Input:  IBD (file) =  piece 1: date through which to archive/purge
 ;                       piece 2: old log # to cancel
 ;                       piece 3: new log # created
 ;                       piece 4: error message
 ;              IBOP  =  1 - Search, 2 - Archiving, 3 - Purging
 ;               DUZ  =  User ID
 ;
 ; - set up MailMan's variables
 S XMSUB="INTEGRATED BILLING "_$P("SEARCH^ARCHIVING^PURGING","^",IBOP)_" OF BILLING DATA"
 S XMDUZ="INTEGRATED BILLING PACKAGE",XMTEXT="IBT("
 K XMY S XMY(DUZ)=""
 ;
 ; - build report header
 K IBT S IBT(1)="The subject job has yielded the following results:"
 S IBHDR="Search ^Archive^ Purge "
 S IBT(2)=$J("",37)_$P(IBHDR,"^",IBOP)_$J("",11)_$P(IBHDR,"^",IBOP)_$J("",7)_"# Records"
 S IBT(3)="File"_$J("",23)_"Log#  Begin Date/Time    End Date/Time     "_$P(" Found^Archived^ Purged","^",IBOP)
 S $P(IBT(4),"-",79)=""
 ;
 ; - write detail lines
 S IBC=4,IBFILE=0 F  S IBFILE=$O(IBD(IBFILE)) Q:'IBFILE  S IBDAT=IBD(IBFILE) D
 . S IBFILEN=$S($D(^DIC(IBFILE,0))#2:$P(^(0),"^"),1:"* UNKNOWN FILE *")
 . S IBC=IBC+1,IBT(IBC)=IBFILEN_$J("",27-$L(IBFILEN))
 . S IBT(IBC)=IBT(IBC)_$S($P(IBDAT,"^",3):$J($P(IBDAT,"^",3),4),1:" -- ")
 . I $P(IBDAT,"^",4)]"" D  Q
 ..  S IBT(IBC)=IBT(IBC)_"   ** "_$S($P(IBDAT,"^",3):"LOG ENTRY HAS BEEN CANCELLED",$P(IBDAT,"^",3)=0:"LOG ENTRY WAS NOT CREATED",1:$P(IBDAT,"^",4))_" **"
 ..  I $P(IBDAT,"^",3)]"" S IBC=IBC+1,IBT(IBC)="  Error:   >>  "_$P(IBDAT,"^",4)_"  <<"
 ..  S IBC=IBC+1,IBT(IBC)=" "
 . S IBLOG0=$G(^IBE(350.6,+$P(IBDAT,"^",3),0)),IBLOGT=$G(^(IBOP))
 . F I=1,2 S IBTIME=$P(IBLOGT,"^",I),IBT(IBC)=IBT(IBC)_"  "_$S(IBTIME:$$DAT1^IBOUTL(IBTIME)_"@"_$P($$DAT2^IBOUTL(IBTIME),"@",2),1:"Not specified    ")
 . S IBT(IBC)=IBT(IBC)_"  "_$J($P(IBLOG0,"^",4),5)
 . S IBC=IBC+1,IBT(IBC)=" "
 ;
 ; - deliver bulletin
 D ^XMD
 K IBC,IBDAT,IBFILE,IBFILEN,IBHDR,IBLOG0,IBLOGT,IBT,IBTIME,XMDUZ,XMSUB,XMTEXT,XMY
 Q
